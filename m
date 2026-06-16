Return-Path: <stable+bounces-265601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +cnIOiGMMWo8mQUAu9opvQ
	(envelope-from <stable+bounces-265601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:47:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBE6937A5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:47:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XPPzdi3M;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265601-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265601-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2078D30008B6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B83CFF4B;
	Tue, 16 Jun 2026 17:47:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABC169AD2;
	Tue, 16 Jun 2026 17:47:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632027; cv=none; b=Nhc70RHTyedJOApeP298qSalNdCh6LhYMF3wLsIR87+2w8HrGH+vM0OdzpeDEcHvhxmIr5X6JWkRvmwutxHe3G+IyLDSTqj5QhysQdGzpraYioKelgaNjqdHFqKJQ/d5R/uYZK+b6YLYfplxA2qprXTTRa3l7aNjkoM9zWcHrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632027; c=relaxed/simple;
	bh=VaOkP6KtTmmRVsWBkV2tPvOTbU6MqEkVvyKLtGdMN7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ii7qQjl7Fb4ek0j9yjA63+uudlYNZb2xAjbiAyFNd5rJi6VOzMul7aP6l134kcNlq/LQyq4bxAiBL2B+8dIC7Db94ZjrP2pigul5JOjB4w7+DJ778tlL4DUdozTg/B5Mk4kE/mrwRHhtq3Zo4WX9bNdrR+Vzb8qhhB6E4ZNNMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPPzdi3M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286281F000E9;
	Tue, 16 Jun 2026 17:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632026;
	bh=Tfwzz+tOwgnFjPJQUqdwAJNzbDjMIeczJ9KfIRkWGrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XPPzdi3McVmv3pCSKo5k758lYZjZ6H5CIVqhgQoODdaFQylklOpglleckrXpUQImy
	 PfgXPhw4PaUrZ/lB7IoaZaMB5Be7OrCcgQly/usTsyNPHqQubhiOapnq2r9pXUnysH
	 608wJ0fHC0bjtymk8Q1EEtMoABOgVHFJhxT1Ei8U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiazi Li <jqqlijiazi@gmail.com>,
	"peixuan.qiu" <peixuan.qiu@transsion.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 331/522] f2fs: use kfree() instead of kvfree() to free some memory
Date: Tue, 16 Jun 2026 20:27:58 +0530
Message-ID: <20260616145141.311664384@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,transsion.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-265601-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jqqlijiazi@gmail.com,m:peixuan.qiu@transsion.com,m:chao@kernel.org,m:jaegeuk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDDBE6937A5

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiazi Li <jqqlijiazi@gmail.com>

[ Upstream commit e9705c61b1dbe7bac9dc189de434994d8a76b191 ]

options in f2fs_fill_super is alloc by kstrdup:
	options = kstrdup((const char *)data, GFP_KERNEL)
sit_bitmap[_mir], nat_bitmap[_mir] are alloc by kmemdup:
	sit_i->sit_bitmap = kmemdup(src_bitmap, sit_bitmap_size, GFP_KERNEL);
	sit_i->sit_bitmap_mir = kmemdup(src_bitmap,
					sit_bitmap_size, GFP_KERNEL);
	nm_i->nat_bitmap = kmemdup(version_bitmap, nm_i->bitmap_size,
					GFP_KERNEL);
	nm_i->nat_bitmap_mir = kmemdup(version_bitmap, nm_i->bitmap_size,
					GFP_KERNEL);
write_io is alloc by f2fs_kmalloc:
	sbi->write_io[i] = f2fs_kmalloc(sbi,
			array_size(n, sizeof(struct f2fs_bio_info))

Use kfree is more efficient.

Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
Signed-off-by: peixuan.qiu <peixuan.qiu@transsion.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 6af249c996f7 ("f2fs: fix to do sanity check on dcc->discard_cmd_cnt conditionally")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c    |    4 ++--
 fs/f2fs/segment.c |    4 ++--
 fs/f2fs/super.c   |    8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3433,10 +3433,10 @@ void f2fs_destroy_node_manager(struct f2
 	}
 	kvfree(nm_i->free_nid_count);
 
-	kvfree(nm_i->nat_bitmap);
+	kfree(nm_i->nat_bitmap);
 	kvfree(nm_i->nat_bits);
 #ifdef CONFIG_F2FS_CHECK_FS
-	kvfree(nm_i->nat_bitmap_mir);
+	kfree(nm_i->nat_bitmap_mir);
 #endif
 	sbi->nm_info = NULL;
 	kfree(nm_i);
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5180,9 +5180,9 @@ static void destroy_sit_info(struct f2fs
 	kvfree(sit_i->dirty_sentries_bitmap);
 
 	SM_I(sbi)->sit_info = NULL;
-	kvfree(sit_i->sit_bitmap);
+	kfree(sit_i->sit_bitmap);
 #ifdef CONFIG_F2FS_CHECK_FS
-	kvfree(sit_i->sit_bitmap_mir);
+	kfree(sit_i->sit_bitmap_mir);
 	kvfree(sit_i->invalid_segmap);
 #endif
 	kfree(sit_i);
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1683,7 +1683,7 @@ static void f2fs_put_super(struct super_
 	destroy_percpu_info(sbi);
 	f2fs_destroy_iostat(sbi);
 	for (i = 0; i < NR_PAGE_TYPE; i++)
-		kvfree(sbi->write_io[i]);
+		kfree(sbi->write_io[i]);
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
@@ -4548,7 +4548,7 @@ reset_checkpoint:
 		if (err)
 			goto sync_free_meta;
 	}
-	kvfree(options);
+	kfree(options);
 
 	/* recover broken superblock */
 	if (recovery) {
@@ -4627,7 +4627,7 @@ free_iostat:
 	f2fs_destroy_iostat(sbi);
 free_bio_info:
 	for (i = 0; i < NR_PAGE_TYPE; i++)
-		kvfree(sbi->write_io[i]);
+		kfree(sbi->write_io[i]);
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
@@ -4639,7 +4639,7 @@ free_options:
 		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	fscrypt_free_dummy_policy(&F2FS_OPTION(sbi).dummy_enc_policy);
-	kvfree(options);
+	kfree(options);
 free_sb_buf:
 	kfree(raw_super);
 free_sbi:



