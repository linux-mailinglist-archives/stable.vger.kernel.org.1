Return-Path: <stable+bounces-91559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969D9BEE89
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99B2B231BA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B513AD11;
	Wed,  6 Nov 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZTzc7/KL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4C1CB310;
	Wed,  6 Nov 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899088; cv=none; b=dH0SdnV3xa4hTkeqFas2w/M3mPbpXON2xsWtnVe5zLRctd45YSaIfzje6XTCdXypBGIZHRNGfe99hLvOnjSq0x0NxpdYBzOqYM6YGK8qCAqblj2E5JzGzyMLd0PmbmSl1BaYpsIvWyOGe9beJgl2Lup6s1R3+tujDwxA4Vvw3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899088; c=relaxed/simple;
	bh=4Mf5p2NWYtuUj0IjG2Gmki1CeftRPlkpofBPVNae2Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDXZixaFbBXFmGbCQC2MjnoHsheDS/BzNBPOJ1NzJDYclLxfxyr1GbPHB8+juwf7JuqoAc3r33qCIYHTVBJqr8oX3oAyL9z1Gq53I6taMgfM9/0W6YIzKtBBKEQPrwzN5rp+TX/kyCZTxPLs1VuxyXJWDiP2AZ6qMQYEYQ/7DYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZTzc7/KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA5BC4CECD;
	Wed,  6 Nov 2024 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730899088;
	bh=4Mf5p2NWYtuUj0IjG2Gmki1CeftRPlkpofBPVNae2Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTzc7/KLIEgpznpT1bJqNOS+XPU7NVCnRB+1UjI+tQteCYzLGIEPxeLMQsP3+wdv8
	 CM6lVhImOgQWAIxwVxv2NRQX9CFifItwsYTD5gSSK/Ez3NJqqpWiDBUAx3xaZFKytN
	 xzsPZ7JVkXamsywwBR6obW/2jcqHV0N/I2XNMOtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Joel Becker <jlbec@evilplan.org>,
	Mark Fasheh <mark@fasheh.com>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 456/462] ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow
Date: Wed,  6 Nov 2024 13:05:49 +0100
Message-ID: <20241106120342.767775908@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit bc0a2f3a73fcdac651fca64df39306d1e5ebe3b0 ]

Syzbot reported a kernel BUG in ocfs2_truncate_inline.  There are two
reasons for this: first, the parameter value passed is greater than
ocfs2_max_inline_data_with_xattr, second, the start and end parameters of
ocfs2_truncate_inline are "unsigned int".

So, we need to add a sanity check for byte_start and byte_len right before
ocfs2_truncate_inline() in ocfs2_remove_inode_range(), if they are greater
than ocfs2_max_inline_data_with_xattr return -EINVAL.

Link: https://lkml.kernel.org/r/tencent_D48DB5122ADDAEDDD11918CFB68D93258C07@qq.com
Fixes: 1afc32b95233 ("ocfs2: Write support for inline data")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reported-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 7294d5b3d80fe..0c62cb90d63dd 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1787,6 +1787,14 @@ int ocfs2_remove_inode_range(struct inode *inode,
 		return 0;
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		int id_count = ocfs2_max_inline_data_with_xattr(inode->i_sb, di);
+
+		if (byte_start > id_count || byte_start + byte_len > id_count) {
+			ret = -EINVAL;
+			mlog_errno(ret);
+			goto out;
+		}
+
 		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
 					    byte_start + byte_len, 0);
 		if (ret) {
-- 
2.43.0




