Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB347E23B6
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjKFNNz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjKFNNx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:13:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248EBA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:13:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27636C433CA;
        Mon,  6 Nov 2023 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276429;
        bh=yTAyA4EEDpf3qz66PUWAShn8mQwJuvXAOl8sjlEWHMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/t96ANbcKjuAK+P4L6/176hO8c/6L8YROdkY1TqOk5GV4o2E/KewtV0HeHqT7I+H
         Cj4tdAU2PX3aiSBLymy8srohJYdLaGCBedqDF3WvH9Y7t2d6NBTNIsE3HY1DZTAt25
         hJfEOKcBbiXLdjj6kLze412ZBfJsYVG8/bDvAFog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 11/62] fs/ntfs3: Add ckeck in ni_update_parent()
Date:   Mon,  6 Nov 2023 14:03:17 +0100
Message-ID: <20231106130302.231828886@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 87d1888aa40f25773fa0b948bcb2545f97e2cb15 ]

Check simple case when parent inode equals current inode.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index dda13e1f1b330..166c3c49530ec 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3198,6 +3198,12 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		if (!fname || !memcmp(&fname->dup, dup, sizeof(fname->dup)))
 			continue;
 
+		/* Check simple case when parent inode equals current inode. */
+		if (ino_get(&fname->home) == ni->vfs_inode.i_ino) {
+			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+			continue;
+		}
+
 		/* ntfs_iget5 may sleep. */
 		dir = ntfs_iget5(sb, &fname->home, NULL);
 		if (IS_ERR(dir)) {
-- 
2.42.0



