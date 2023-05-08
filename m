Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AD6FAC5A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjEHLXa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjEHLX2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094339B8F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7617F62CDE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9A5C433D2;
        Mon,  8 May 2023 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545004;
        bh=mJBngOkGDYxboBQlyi79GCfB4L2gSFOz7WyVvDY2kbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIo3OTAFwJC9ML+sXrYHr1V1F1pI3Inu8X9JutJPyK+Ac9oSGu1ViLduwXC3KBhiI
         4ps3jbOMacEzvwkSlLnx9iXu/5v7ENN1O6KdnwlebsDwyQiUTpRkCjE2RB8yZrCkgC
         HgpkvofwMMNtEnrzWEcX1fPgbrByRZugUJGf25LE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+d882d57193079e379309@syzkaller.appspotmail.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 594/694] fs/ntfs3: Fix OOB read in indx_insert_into_buffer
Date:   Mon,  8 May 2023 11:47:09 +0200
Message-Id: <20230508094454.395562388@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: ZhangPeng <zhangpeng362@huawei.com>

[ Upstream commit b8c44949044e5f7f864525fdffe8e95135ce9ce5 ]

Syzbot reported a OOB read bug:

BUG: KASAN: slab-out-of-bounds in indx_insert_into_buffer+0xaa3/0x13b0
fs/ntfs3/index.c:1755
Read of size 17168 at addr ffff8880255e06c0 by task syz-executor308/3630

Call Trace:
 <TASK>
 memmove+0x25/0x60 mm/kasan/shadow.c:54
 indx_insert_into_buffer+0xaa3/0x13b0 fs/ntfs3/index.c:1755
 indx_insert_entry+0x446/0x6b0 fs/ntfs3/index.c:1863
 ntfs_create_inode+0x1d3f/0x35c0 fs/ntfs3/inode.c:1548
 ntfs_create+0x3e/0x60 fs/ntfs3/namei.c:100
 lookup_open fs/namei.c:3413 [inline]

If the member struct INDEX_BUFFER *index of struct indx_node is
incorrect, that is, the value of __le32 used is greater than the value
of __le32 total in struct INDEX_HDR. Therefore, OOB read occurs when
memmove is called in indx_insert_into_buffer().
Fix this by adding a check in hdr_find_e().

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Reported-by: syzbot+d882d57193079e379309@syzkaller.appspotmail.com
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/index.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 51ab759546403..ae9616becec15 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -725,9 +725,13 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	u32 e_size, e_key_len;
 	u32 end = le32_to_cpu(hdr->used);
 	u32 off = le32_to_cpu(hdr->de_off);
+	u32 total = le32_to_cpu(hdr->total);
 	u16 offs[128];
 
 fill_table:
+	if (end > total)
+		return NULL;
+
 	if (off + sizeof(struct NTFS_DE) > end)
 		return NULL;
 
-- 
2.39.2



