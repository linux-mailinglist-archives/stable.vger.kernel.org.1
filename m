Return-Path: <stable+bounces-271760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p+tmB7iwR2pKdgAAu9opvQ
	(envelope-from <stable+bounces-271760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:53:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 677067028CA
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:53:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="GcV2Ko/T";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271760-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271760-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1829330675D1
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3DB3BB132;
	Fri,  3 Jul 2026 12:33:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259733CCFB8
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:33:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082024; cv=none; b=Qdi4vtqdh0kog+/VUU7KiWqX5q5dYqxHd2scRB08oOgM9KtcoD095vXV7Rl0qIbNTd6GL84eu6MrZAH+r2rEbtz/D2+tP//aKBsRV9rwUNYGI0mBTQUoSYfOU3ImLZjmOcyTYdoUri45k19JfE/TUwPDNC7aaWmwj60CtxVXzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082024; c=relaxed/simple;
	bh=Iwx8oZ7/7Jr4sTS3vwCIMK2rRu3GdndaIh9ngB4ncgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqbMJ68hosYsMU3YVRxonKFtMNW8hSI5raNAYA+ktPa+WFqS6mx8dP1/Dd2FWNszKVAcWTkWmkVmls/QT6fZdxyWZYn/hRcpoa3ES1+utCMLjxPzwvk4ohLS7whugjyqmZHNTKXRzt2psbzoUQJ/63Mf2U/naYjj6g1T2jTulnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcV2Ko/T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE0F1F000E9;
	Fri,  3 Jul 2026 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082019;
	bh=IzTtUWvcvKwy5/CaSNmD9QE0NUxcM1je/AKQaH18lH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcV2Ko/TStpr5aVfO7MqhWtbfXpGuoLWol5CjTq1AfCqcbrtdG25RKszBkXSvfRP0
	 NEl3dCyfhRxNwzXrM92U8LkkjGAjwIEkDOVKx3MK6cDcELOK4r/Wtu1d0v3L0SpU8s
	 QHvIQrZCCxCPo0TfuWWhK0rAkN1F/l9j+PT5A3UZdEDqiWkaJaBWri2PdA+0eFkEpj
	 RMRxcMs2zOokI+4FEDHCOkoeNOx0K4eE1LHYYBf6q1SDDtx20JML9YJyb03P1Qs8j/
	 liTO+XVnBqWSLenIsG7Ng8rfSp82MY4Gvq87s1hPNDMY9aVA1kGuuLVymmSocF7/t8
	 Vx4IB8B29HhdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] f2fs: fix to detect corrupted meta ino
Date: Fri,  3 Jul 2026 08:33:35 -0400
Message-ID: <20260703123336.3945189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070218-taekwondo-skeletal-13d5@gregkh>
References: <2026070218-taekwondo-skeletal-13d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:chao@kernel.org,m:jaegeuk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271760-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 677067028CA

From: Chao Yu <chao@kernel.org>

[ Upstream commit fcc2d8cc96b2f6141bbbe5b1e8953db990794b44 ]

It is possible that ino of dirent or orphan inode is corrupted in a
fuzzed image, occasionally, if corrupted ino is equal to meta ino:
meta_ino, node_ino or compress_ino, caller of f2fs_iget() from below
call paths will get meta inode directly, it's not allowed, let's
add sanity check to detect such cases.

case #1
- recover_dentry
 - __f2fs_find_entry
 - f2fs_iget_retry

case #2
- recover_orphan_inode
 - f2fs_iget_retry

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 5073c66a96a9 ("f2fs: validate compress cache inode only when enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7494a68a53196f..4a99a9eab8291d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -496,6 +496,12 @@ static int do_read_inode(struct inode *inode)
 	return 0;
 }
 
+static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
+{
+	return ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi) ||
+		ino == F2FS_COMPRESS_INO(sbi);
+}
+
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -507,16 +513,21 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		return ERR_PTR(-ENOMEM);
 
 	if (!(inode->i_state & I_NEW)) {
+		if (is_meta_ino(sbi, ino)) {
+			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			ret = -EFSCORRUPTED;
+			trace_f2fs_iget_exit(inode, ret);
+			iput(inode);
+			return ERR_PTR(ret);
+		}
+
 		trace_f2fs_iget(inode);
 		return inode;
 	}
-	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
-		goto make_now;
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (ino == F2FS_COMPRESS_INO(sbi))
+	if (is_meta_ino(sbi, ino))
 		goto make_now;
-#endif
 
 	ret = do_read_inode(inode);
 	if (ret)
-- 
2.53.0


