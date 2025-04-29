Return-Path: <stable+bounces-137113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 753CFAA1091
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2334189B97B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A14021A45B;
	Tue, 29 Apr 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zPFKM42c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0D21ABA6
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940849; cv=none; b=m+I5ycXXA7zEeUT3R9v9kYVZNzl49Pfv+8VOD+MjgCNkRdt3YsbvNJfBY5keyxFNGqHkwOnRLGG7/KyUK/N6vwH/HMQeriwam7KZwkTz5jCqCFFOJhCAp3jvx/01wQ+rSZd17zbcJL7ZINJKtjLLAAAGgatud73v2t4ikfaFPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940849; c=relaxed/simple;
	bh=IEo4VOZd5YxIifc6V0dQx7/4kej0lsbDyKXbI7KYj9Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k6lJFP3h9pxf9k1QZfdCnDI56mBl61jF9w+FfqH4t0XKWuxqiBVz6zGJC81K/zeKQrM9ycsKX7ek3Pi+Z5ub90IRykEHJw5Ol0ZYC9QHA8to5Ms9cQYczBVwxcQn9QlVPqf4emfFps5pOVEyfF5trbfsofG4/wnvmWto/F45v84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zPFKM42c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C57EC4CEE3;
	Tue, 29 Apr 2025 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745940848;
	bh=IEo4VOZd5YxIifc6V0dQx7/4kej0lsbDyKXbI7KYj9Q=;
	h=Subject:To:Cc:From:Date:From;
	b=zPFKM42cJCtgeaqGA5SGbRXyQWwMzLhgDxJYtpTEY27Bh8V0AC5Boegkm/N5r5Ce4
	 0ahMN4LJ5tLW9VBq3KaV5VPwY0hmMVEhXdj5MKtF2zwAn57Gn8DUpWlqJLuR1xwU2F
	 FJSv9UwOvX615P0VAOXxU8D48fUtO7dfHUSqKijc=
Subject: FAILED: patch "[PATCH] smb: client: fix UAF in decryption with multichannel" failed to apply to 5.15-stable tree
To: pc@manguebit.com,dhowells@redhat.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Apr 2025 17:34:05 +0200
Message-ID: <2025042904-zap-drench-9729@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9502dd5c7029902f4a425bf959917a5a9e7c0e50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042904-zap-drench-9729@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9502dd5c7029902f4a425bf959917a5a9e7c0e50 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Wed, 9 Apr 2025 11:14:21 -0300
Subject: [PATCH] smb: client: fix UAF in decryption with multichannel

After commit f7025d861694 ("smb: client: allocate crypto only for
primary server") and commit b0abcd65ec54 ("smb: client: fix UAF in
async decryption"), the channels started reusing AEAD TFM from primary
channel to perform synchronous decryption, but that can't done as
there could be multiple cifsd threads (one per channel) simultaneously
accessing it to perform decryption.

This fixes the following KASAN splat when running fstest generic/249
with 'vers=3.1.1,multichannel,max_channels=4,seal' against Windows
Server 2022:

BUG: KASAN: slab-use-after-free in gf128mul_4k_lle+0xba/0x110
Read of size 8 at addr ffff8881046c18a0 by task cifsd/986
CPU: 3 UID: 0 PID: 986 Comm: cifsd Not tainted 6.15.0-rc1 #1
PREEMPT(voluntary)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-3.fc41
04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 print_report+0x156/0x528
 ? gf128mul_4k_lle+0xba/0x110
 ? __virt_addr_valid+0x145/0x300
 ? __phys_addr+0x46/0x90
 ? gf128mul_4k_lle+0xba/0x110
 kasan_report+0xdf/0x1a0
 ? gf128mul_4k_lle+0xba/0x110
 gf128mul_4k_lle+0xba/0x110
 ghash_update+0x189/0x210
 shash_ahash_update+0x295/0x370
 ? __pfx_shash_ahash_update+0x10/0x10
 ? __pfx_shash_ahash_update+0x10/0x10
 ? __pfx_extract_iter_to_sg+0x10/0x10
 ? ___kmalloc_large_node+0x10e/0x180
 ? __asan_memset+0x23/0x50
 crypto_ahash_update+0x3c/0xc0
 gcm_hash_assoc_remain_continue+0x93/0xc0
 crypt_message+0xe09/0xec0 [cifs]
 ? __pfx_crypt_message+0x10/0x10 [cifs]
 ? _raw_spin_unlock+0x23/0x40
 ? __pfx_cifs_readv_from_socket+0x10/0x10 [cifs]
 decrypt_raw_data+0x229/0x380 [cifs]
 ? __pfx_decrypt_raw_data+0x10/0x10 [cifs]
 ? __pfx_cifs_read_iter_from_socket+0x10/0x10 [cifs]
 smb3_receive_transform+0x837/0xc80 [cifs]
 ? __pfx_smb3_receive_transform+0x10/0x10 [cifs]
 ? __pfx___might_resched+0x10/0x10
 ? __pfx_smb3_is_transform_hdr+0x10/0x10 [cifs]
 cifs_demultiplex_thread+0x692/0x1570 [cifs]
 ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
 ? rcu_is_watching+0x20/0x50
 ? rcu_lockdep_current_cpu_online+0x62/0xb0
 ? find_held_lock+0x32/0x90
 ? kvm_sched_clock_read+0x11/0x20
 ? local_clock_noinstr+0xd/0xd0
 ? trace_irq_enable.constprop.0+0xa8/0xe0
 ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
 kthread+0x1fe/0x380
 ? kthread+0x10f/0x380
 ? __pfx_kthread+0x10/0x10
 ? local_clock_noinstr+0xd/0xd0
 ? ret_from_fork+0x1b/0x60
 ? local_clock+0x15/0x30
 ? lock_release+0x29b/0x390
 ? rcu_is_watching+0x20/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Tested-by: David Howells <dhowells@redhat.com>
Reported-by: Steve French <stfrench@microsoft.com>
Closes: https://lore.kernel.org/r/CAH2r5mu6Yc0-RJXM3kFyBYUB09XmXBrNodOiCVR4EDrmxq5Szg@mail.gmail.com
Fixes: f7025d861694 ("smb: client: allocate crypto only for primary server")
Fixes: b0abcd65ec54 ("smb: client: fix UAF in async decryption")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index e69968e88fe7..35892df7335c 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -704,18 +704,12 @@ cifs_crypto_secmech_release(struct TCP_Server_Info *server)
 	cifs_free_hash(&server->secmech.md5);
 	cifs_free_hash(&server->secmech.sha512);
 
-	if (!SERVER_IS_CHAN(server)) {
-		if (server->secmech.enc) {
-			crypto_free_aead(server->secmech.enc);
-			server->secmech.enc = NULL;
-		}
-
-		if (server->secmech.dec) {
-			crypto_free_aead(server->secmech.dec);
-			server->secmech.dec = NULL;
-		}
-	} else {
+	if (server->secmech.enc) {
+		crypto_free_aead(server->secmech.enc);
 		server->secmech.enc = NULL;
+	}
+	if (server->secmech.dec) {
+		crypto_free_aead(server->secmech.dec);
 		server->secmech.dec = NULL;
 	}
 }
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 41d8cd20b25f..3f7fe74688a9 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4555,9 +4555,9 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 			return rc;
 		}
 	} else {
-		if (unlikely(!server->secmech.dec))
-			return -EIO;
-
+		rc = smb3_crypto_aead_allocate(server);
+		if (unlikely(rc))
+			return rc;
 		tfm = server->secmech.dec;
 	}
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 81e05db8e4d5..c4d52bebd37d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1252,15 +1252,8 @@ SMB2_negotiate(const unsigned int xid,
 			cifs_server_dbg(VFS, "Missing expected negotiate contexts\n");
 	}
 
-	if (server->cipher_type && !rc) {
-		if (!SERVER_IS_CHAN(server)) {
-			rc = smb3_crypto_aead_allocate(server);
-		} else {
-			/* For channels, just reuse the primary server crypto secmech. */
-			server->secmech.enc = server->primary_server->secmech.enc;
-			server->secmech.dec = server->primary_server->secmech.dec;
-		}
-	}
+	if (server->cipher_type && !rc)
+		rc = smb3_crypto_aead_allocate(server);
 neg_exit:
 	free_rsp_buf(resp_buftype, rsp);
 	return rc;


