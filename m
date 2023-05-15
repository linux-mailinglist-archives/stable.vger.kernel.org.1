Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6654E70350D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbjEOQzT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbjEOQzC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B06E80
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86A8A629C1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77820C433EF;
        Mon, 15 May 2023 16:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169689;
        bh=0iaogp2O6ps7ry+Uw6606MgwHXbKeUewVTbumINAuZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xIYkNZPRTfcXsL96RKqAjM5GaMkf5DFOEqSPFjqBY3iPReoJpupXpAOcQ5WyyZzaV
         rz6rtMCk6Xs9hzc6cttG4tSQiAEFUhqKTpDXZKuJACo5ASemcxMOq3yBH7mfyeOIev
         UDFHVQ9xlYbDpH/bPd7oOipypWCIcatsMLmQ2zaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.3 138/246] btrfs: zoned: fix full zone super block reading on ZNS
Date:   Mon, 15 May 2023 18:25:50 +0200
Message-Id: <20230515161726.706014719@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Naohiro Aota <Naohiro.Aota@wdc.com>

commit 02ca9e6fb5f66a031df4fac508b8e477ca69e918 upstream.

When both of the superblock zones are full, we need to check which
superblock is newer. The calculation of last superblock position is wrong
as it does not consider zone_capacity and uses the length.

Fixes: 9658b72ef300 ("btrfs: zoned: locate superblock position using zone capacity")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -122,10 +122,9 @@ static int sb_write_pointer(struct block
 		int i;
 
 		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
-			u64 bytenr;
-
-			bytenr = ((zones[i].start + zones[i].len)
-				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
+			u64 zone_end = (zones[i].start + zones[i].capacity) << SECTOR_SHIFT;
+			u64 bytenr = ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
+						BTRFS_SUPER_INFO_SIZE;
 
 			page[i] = read_cache_page_gfp(mapping,
 					bytenr >> PAGE_SHIFT, GFP_NOFS);


