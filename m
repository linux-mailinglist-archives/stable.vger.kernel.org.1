Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9602703A98
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbjEORxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbjEORwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8EC40D3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265AD62F32
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2D4C4339B;
        Mon, 15 May 2023 17:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172999;
        bh=4LJ3Nv3a6viQkQdNImyTDfhRmkvTz/PVLioB2CSnvqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pu2EEB6zFm6XVeSnsR7+CjcK87eSfG9TgEdrX/zyhYsoS/3QKQI+unOxYnOa5m9vL
         ujLnrFNq4eSNI2litwUKNdyf09xEwriKW8ceqquHs11Db1BM/AKQvJeoecgeFq70jj
         SfEEGcZeMnvowA41GM1rDioslThDZA8mxyiO59nQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Anastasia Belova <abelova@astralinux.ru>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.10 336/381] btrfs: print-tree: parent bytenr must be aligned to sector size
Date:   Mon, 15 May 2023 18:29:47 +0200
Message-Id: <20230515161752.023797235@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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


