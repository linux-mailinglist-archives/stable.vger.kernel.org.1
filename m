Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D067E2502
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjKFN1T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjKFN1R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:27:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB1EA
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:27:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF0DC433C8;
        Mon,  6 Nov 2023 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277234;
        bh=h7lmvppCMkgdziu38ydHLTIsaXEoUD2N4PCrqfo2S0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7rKh8TPrJS0D+GEI1jDzqGqvCF0x199/EP3TIRApyZVRH8xhNPe8il+mjcIRCCVQ
         nsA253cFuFRF7OfaQQp8ipdpCLN1Qb9E5Jejt0LyKFtZDlJK6g4V2s58HNt/ssnMfg
         PEV9QqqVXg/iJGOvN16YJQgbHxNZz3CUCi4eJfkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/128] fs/ntfs3: Add ckeck in ni_update_parent()
Date:   Mon,  6 Nov 2023 14:04:03 +0100
Message-ID: <20231106130312.912213026@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 9a1744955d1cf..73a56d7ac84b7 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3144,6 +3144,12 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
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



