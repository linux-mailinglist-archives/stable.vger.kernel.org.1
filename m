Return-Path: <stable+bounces-74288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25322972E80
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE54A1F252A2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405D18B484;
	Tue, 10 Sep 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pw2yvG6J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F7188CAD;
	Tue, 10 Sep 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961367; cv=none; b=qo1GEDd83S2GDEw8BvT0IeDXM2TB4MNY+t5+9IEROGqfqyPQCyZ1MIy7NywdnVXxcGkHXuOPZgAijaNUuMAeIkL1ZgaVeUNGudZHYbhUIVbHQ9cZuKzOVtw8kpUfRGrXGAFz1gTXVt+vFLaLrBzqfETWi4yBXIyxhbfYK5NFo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961367; c=relaxed/simple;
	bh=5Kfb+qErQRYSzjTE9ujhAIyL0YUHsCglPpexTAnSd3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imEKrG/uOUZNvjc6jNMUxrMOWIjSnveKCTmXiag1zSE5yA5bGoVbDmnrzxOyXK/+PmWWP7Wn6Qj23FxI9vrwDOVbG0H2TcfmGDS4d9UWfe/FRCP6AnfUUsh35F5CuKQipjjWXb37fck8voHWTCembQibdTaN0oGEbOpj6eX99DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pw2yvG6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8C1C4CEC3;
	Tue, 10 Sep 2024 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961367;
	bh=5Kfb+qErQRYSzjTE9ujhAIyL0YUHsCglPpexTAnSd3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pw2yvG6JVI6jt22xGXG5aJ4D4OU6NGpvbU5rFsU8HqCNZfoz8L/4+6arBWwaWwKSF
	 tvbAcTWO0SKq3TjzooEKidI5FoFBykWx9JQ8ubrr4skHzAQecMoRD8sczEfYqE9yAX
	 YMQsACMHSLcLwPM/vTj7JBCO0GbK5rW15nCTwEYg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.10 018/375] ksmbd: unset the binding mark of a reused connection
Date: Tue, 10 Sep 2024 11:26:55 +0200
Message-ID: <20240910092622.880012292@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 78c5a6f1f630172b19af4912e755e1da93ef0ab5 upstream.

Steve French reported null pointer dereference error from sha256 lib.
cifs.ko can send session setup requests on reused connection.
If reused connection is used for binding session, conn->binding can
still remain true and generate_preauth_hash() will not set
sess->Preauth_HashValue and it will be NULL.
It is used as a material to create an encryption key in
ksmbd_gen_smb311_encryptionkey. ->Preauth_HashValue cause null pointer
dereference error from crypto_shash_update().

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 8 PID: 429254 Comm: kworker/8:39
Hardware name: LENOVO 20MAS08500/20MAS08500, BIOS N2CET69W (1.52 )
Workqueue: ksmbd-io handle_ksmbd_work [ksmbd]
RIP: 0010:lib_sha256_base_do_update.isra.0+0x11e/0x1d0 [sha256_ssse3]
<TASK>
? show_regs+0x6d/0x80
? __die+0x24/0x80
? page_fault_oops+0x99/0x1b0
? do_user_addr_fault+0x2ee/0x6b0
? exc_page_fault+0x83/0x1b0
? asm_exc_page_fault+0x27/0x30
? __pfx_sha256_transform_rorx+0x10/0x10 [sha256_ssse3]
? lib_sha256_base_do_update.isra.0+0x11e/0x1d0 [sha256_ssse3]
? __pfx_sha256_transform_rorx+0x10/0x10 [sha256_ssse3]
? __pfx_sha256_transform_rorx+0x10/0x10 [sha256_ssse3]
_sha256_update+0x77/0xa0 [sha256_ssse3]
sha256_avx2_update+0x15/0x30 [sha256_ssse3]
crypto_shash_update+0x1e/0x40
hmac_update+0x12/0x20
crypto_shash_update+0x1e/0x40
generate_key+0x234/0x380 [ksmbd]
generate_smb3encryptionkey+0x40/0x1c0 [ksmbd]
ksmbd_gen_smb311_encryptionkey+0x72/0xa0 [ksmbd]
ntlm_authenticate.isra.0+0x423/0x5d0 [ksmbd]
smb2_sess_setup+0x952/0xaa0 [ksmbd]
__process_request+0xa3/0x1d0 [ksmbd]
__handle_ksmbd_work+0x1c4/0x2f0 [ksmbd]
handle_ksmbd_work+0x2d/0xa0 [ksmbd]
process_one_work+0x16c/0x350
worker_thread+0x306/0x440
? __pfx_worker_thread+0x10/0x10
kthread+0xef/0x120
? __pfx_kthread+0x10/0x10
ret_from_fork+0x44/0x70
? __pfx_kthread+0x10/0x10
ret_from_fork_asm+0x1b/0x30
</TASK>

Fixes: f5a544e3bab7 ("ksmbd: add support for SMB3 multichannel")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1687,6 +1687,8 @@ int smb2_sess_setup(struct ksmbd_work *w
 		rc = ksmbd_session_register(conn, sess);
 		if (rc)
 			goto out_err;
+
+		conn->binding = false;
 	} else if (conn->dialect >= SMB30_PROT_ID &&
 		   (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   req->Flags & SMB2_SESSION_REQ_FLAG_BINDING) {
@@ -1765,6 +1767,8 @@ int smb2_sess_setup(struct ksmbd_work *w
 			sess = NULL;
 			goto out_err;
 		}
+
+		conn->binding = false;
 	}
 	work->sess = sess;
 



