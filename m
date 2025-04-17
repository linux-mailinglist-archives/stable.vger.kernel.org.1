Return-Path: <stable+bounces-133699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01088A926EC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA5C4A1476
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060E425525D;
	Thu, 17 Apr 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wv+5gO+y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50861DE3A8;
	Thu, 17 Apr 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913873; cv=none; b=ta3sUNdx9B85yG/xXiYlKClZ008jyDOmXfiOFvux+6wJtH+/ablhOpwRDSeIpaIO+yZAQ/4Yh3NUuERoH2cQEQOBYW4iIg5JcO6tRJWFsGT/BxdzvZQOqNQGtvT4smw/5JIFLB5J/J1C+LhJQqxsszpFhHNoXfqQxsrLqXRKx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913873; c=relaxed/simple;
	bh=tcxN/Njlgz0N789H7BuI053ntva65RX/aQRPY2Gjn2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diiuFQ4SYqmFuv7UpV8agwy1q6930bL0EaLLWaaYSvqQRt4a5aRqO+4uBrMg8d6wYNBp5U7S3AMKCLq2U0dh0N/8oUdg/yf3les6RF2ZBZKNEwIV0ocJhz3wy0RIfUdLro13Z0tOOQsZbHc1APRGmqPq35mzEMe1gzZ7THMiS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wv+5gO+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1D9C4CEE4;
	Thu, 17 Apr 2025 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913873;
	bh=tcxN/Njlgz0N789H7BuI053ntva65RX/aQRPY2Gjn2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wv+5gO+ynFkSGRz8AB3LIZZDvvSHbgKaqi+eNeMPQuKvX26tRkvT8xhCtd27njN9V
	 5PxRkNFCS31a3S9yZ8V1j+p0TnEKE++C/hI677gtlZ24lXlg9U0Jdw2v37f+Ojxe7O
	 0zGlywdz7ZRnnoGdCL5GTlbKCKQ/ccUCPBElsr/g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 031/414] smb: client: fix UAF in decryption with multichannel
Date: Thu, 17 Apr 2025 19:46:29 +0200
Message-ID: <20250417175112.667473473@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 9502dd5c7029902f4a425bf959917a5a9e7c0e50 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsencrypt.c | 16 +++++-----------
 fs/smb/client/smb2ops.c     |  6 +++---
 fs/smb/client/smb2pdu.c     | 11 ++---------
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 7a43daacc8159..7c61c1e944c7a 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -702,18 +702,12 @@ cifs_crypto_secmech_release(struct TCP_Server_Info *server)
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
index 17c3063a9ca5b..9bf0f498be19f 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4549,9 +4549,9 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
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
index 23ae73c9c5e97..7b27acd94864d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1251,15 +1251,8 @@ SMB2_negotiate(const unsigned int xid,
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
-- 
2.39.5




