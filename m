Return-Path: <stable+bounces-75164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161997332E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0BF288B31
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E41991A3;
	Tue, 10 Sep 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HzHwgxKp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1B18C340;
	Tue, 10 Sep 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963935; cv=none; b=DNXYFmNXp81G04GefDXYQyuW1upMpiMwmRhRc9rj3bMpvXao6XAW8ACHMKa97tZW9RPe2mHQKLIOUbS1VyeIu0S6BQEH42POMVHx8mAKzvJoFOGyP2okQp7qYvBs4NphxCIYi3m/YGWYkq4HmqTzrTXezNwy5DDmCNJ7gFpKi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963935; c=relaxed/simple;
	bh=LBXH6qfhz/u7B/v16mwg0bbr5ZqFmUriBYNvyW8yC3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHMYl9Lc+c31UN0AOkVWegS5ZKj+IJCqExBjP50iZ2TQfEGhR3oSTpsGl+9ujmfMLf3rZKCzA9azKwsvycowxQ6AdnbaiUuA11PjhOhDER6nB8Ddta8dCdP9D8nNw9SPj0oaGBTgzqQs4VVvAD59gOw2tKwcvi9qQ9gdHL8zMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HzHwgxKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779F8C4CEC3;
	Tue, 10 Sep 2024 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963934;
	bh=LBXH6qfhz/u7B/v16mwg0bbr5ZqFmUriBYNvyW8yC3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzHwgxKp/oqnZH2gw6/2Qe4GumF7CVqTqLR56BvHfzKhbHW6ugh/UarvqlZYFxq7f
	 VDzFQnUdBUCk+cN4x9GnVW0hdNJcRHfWMZwpjKg8p4FBkFGfi0HfwdQ/GPpclDqlAM
	 EVMFfhUt9lYuRWcjl3TlOQuxgSomwn34wQSZ8+gA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 012/269] ksmbd: unset the binding mark of a reused connection
Date: Tue, 10 Sep 2024 11:29:59 +0200
Message-ID: <20240910092608.692049398@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
 



