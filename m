Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF01703646
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbjEORIe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243679AbjEORIK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD38A7A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E29362AE4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D28C433EF;
        Mon, 15 May 2023 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170371;
        bh=8Hini5i2gjNU/AWHedEnQ0znvizlX1usYwcZDJPr0hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koaFL4ntN1z98vtmMUK9qfAEXWZLTJOsN8z4KjtfGKMFnBNaNAFW6qfxWzL18YFNu
         xIYvl9I2nh75n5zFBnfvd/ZcOCl2d0b09ZSIBzDA2Ev8DhoYw9Nm80sO5a4UOtLuYs
         0pNkXDkk9w0xoigD3cA7BXA1X38GjHaYC+q7ATmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 110/239] btrfs: zoned: fix wrong use of bitops API in btrfs_ensure_empty_zones
Date:   Mon, 15 May 2023 18:26:13 +0200
Message-Id: <20230515161724.997905483@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Naohiro Aota <naohiro.aota@wdc.com>

commit 631003e2333c12cc1b52df06a707365b7363a159 upstream.

find_next_bit and find_next_zero_bit take @size as the second parameter and
@offset as the third parameter. They are specified opposite in
btrfs_ensure_empty_zones(). Thanks to the later loop, it never failed to
detect the empty zones. Fix them and (maybe) return the result a bit
faster.

Note: the naming is a bit confusing, size has two meanings here, bitmap
and our range size.

Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1163,12 +1163,12 @@ int btrfs_ensure_empty_zones(struct btrf
 		return -ERANGE;
 
 	/* All the zones are conventional */
-	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
+	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
 		return 0;
 
 	/* All the zones are sequential and empty */
-	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
-	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
+	if (find_next_zero_bit(zinfo->seq_zones, end, begin) == end &&
+	    find_next_zero_bit(zinfo->empty_zones, end, begin) == end)
 		return 0;
 
 	for (pos = start; pos < start + size; pos += zinfo->zone_size) {


