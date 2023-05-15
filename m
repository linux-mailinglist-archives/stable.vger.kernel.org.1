Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF387703872
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbjEORcm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbjEORcT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F256B11624
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C8D062CB3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83788C433D2;
        Mon, 15 May 2023 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171751;
        bh=4LJ3Nv3a6viQkQdNImyTDfhRmkvTz/PVLioB2CSnvqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6ny5YHq2bWh3kER+yrVszOXz6lSSRQlfgTWQwukKNSMDd25vjcLw9928R4nkckjg
         I8HcQ5uX6FbfdtGAUCIOJjPZGu2IMIKUXu2yRJ6IW/BA/t/UVYMIKrEVBVGvCMJWR3
         p1yElcQ3CRg5Vs3PcF7j+o6R7dgjrWDh5q3FV4y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Anastasia Belova <abelova@astralinux.ru>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 066/134] btrfs: print-tree: parent bytenr must be aligned to sector size
Date:   Mon, 15 May 2023 18:29:03 +0200
Message-Id: <20230515161705.356481701@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Anastasia Belova <abelova@astralinux.ru>

commit c87f318e6f47696b4040b58f460d5c17ea0280e6 upstream.

Check nodesize to sectorsize in alignment check in print_extent_item.
The comment states that and this is correct, similar check is done
elsewhere in the functions.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ea57788eb76d ("btrfs: require only sector size alignment for parent eb bytenr")
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/print-tree.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -147,10 +147,10 @@ static void print_extent_item(struct ext
 			pr_cont("shared data backref parent %llu count %u\n",
 			       offset, btrfs_shared_data_ref_count(eb, sref));
 			/*
-			 * offset is supposed to be a tree block which
-			 * must be aligned to nodesize.
+			 * Offset is supposed to be a tree block which must be
+			 * aligned to sectorsize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
+			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
 				pr_info(
 			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
 				     offset, eb->fs_info->sectorsize);


