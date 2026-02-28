Return-Path: <stable+bounces-220587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IjoGuM6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10351C6797
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A40863220CDF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121F53DFC81;
	Sat, 28 Feb 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFgsNxsN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A143DFC77;
	Sat, 28 Feb 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300469; cv=none; b=BhgX2YZexhb0lSw7ulKV7pbEWBnaa2Q8dvtWtLP4ckimeewv0sSbOtYua3JjZP9M1SkiW0dKSlXQ1nBz/TCHbhIOIorXSFVyswYGDm/3RueOKJI4FWQ6heCAurgIcortO5gZWzSPd3vK6v1GkZMd0Q7MrZUEk2iOZJfj/VNKujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300469; c=relaxed/simple;
	bh=6Y+xZCTR+Bzy3g0YLhogsNBKc2RpGqJPlFj0zQ0zzvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0z+LT9R8AjHpdz+jOxVIGr464W/oLhp511p2AIc3dYYUiaJQBjpVK5jbkFI1gXV/iog3hDE8Hsa/y+GkGEIiXZBBaoQGhfOMQf0dLlIQ1mG3+zpIGQkyqtxLjZauMStsbcuZpacerEXLTXaUMnv4lG2XhMWP0AH1+VEoxtaljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFgsNxsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BD2C19423;
	Sat, 28 Feb 2026 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300469;
	bh=6Y+xZCTR+Bzy3g0YLhogsNBKc2RpGqJPlFj0zQ0zzvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFgsNxsNpyY471OoMpunMOJ9FBJYB8ws4Gue+cKzxI0o+375SpeTdJpLwVGJowpYQ
	 3N6ng6ApacXLuw0VCMBQxfap2HzRPye4XIxK8HNPuhXbdny7Fwc54jAP21qbdjQuk7
	 HnxHQyLSYwHNl/A+N8W3S31PlNeSvGECuBe/nnCUUjaMaQ5NinbQjhn+yOO4/RkSvC
	 KpKwr0XZtflQZYBjWziVwbDAxqEuiR/jmEdQMz9vAtkcvh6RleduDsybnEKexPuoN0
	 FPPlXNP8WhtpUnZfLcCCl5xCfag390NXLiow6f3DEDFNKfgVaT0IUg4GiqGsSMkOo1
	 A4wi0VhITiWOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 508/844] hfsplus: ensure sb->s_fs_info is always cleaned up
Date: Sat, 28 Feb 2026 12:27:01 -0500
Message-ID: <20260228173244.1509663-509-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ibm.com,kernel.org,dubeyko.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220587-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E10351C6797
X-Rspamd-Action: no action

From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>

[ Upstream commit 126fb0ce99431126b44a6c360192668c818f641f ]

When hfsplus was converted to the new mount api a bug was introduced by
changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
fails after a new superblock has been allocated by sget_fc(), but before
hfsplus_fill_super() takes ownership of the filesystem-specific s_fs_info
data it was leaked.

Fix this by freeing sb->s_fs_info in hfsplus_kill_super().

Cc: stable@vger.kernel.org
Fixes: 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount api")
Reported-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20251201222843.82310-3-mehdi.benhadjkhelifa@gmail.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 7f327b777ece8..942b8ff01ad07 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -350,8 +350,6 @@ static void hfsplus_put_super(struct super_block *sb)
 	hfs_btree_close(sbi->ext_tree);
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
-	call_rcu(&sbi->rcu, delayed_free);
-
 	hfs_dbg("finished\n");
 }
 
@@ -656,7 +654,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 out_unload_nls:
 	unload_nls(sbi->nls);
 	unload_nls(nls);
-	kfree(sbi);
 	return err;
 }
 
@@ -715,10 +712,18 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfsplus_kill_super(struct super_block *sb)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+
+	kill_block_super(sb);
+	call_rcu(&sbi->rcu, delayed_free);
+}
+
 static struct file_system_type hfsplus_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfsplus",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfsplus_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfsplus_init_fs_context,
 };
-- 
2.51.0


