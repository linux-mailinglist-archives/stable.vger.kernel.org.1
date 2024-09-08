Return-Path: <stable+bounces-73844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B397068D
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6FA1F21ABE
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721614A0A0;
	Sun,  8 Sep 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RH8EKCY2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF71B85EF
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791141; cv=none; b=cjcV5cdqfuROC8/I9rv3eAqWD42/5oOpgoDJ24qlOIYgulIYPzWYHWmUnVIOfJSeJB4BPwo6CyTmaG7xhnbNT5LUDaWbWSuGfwrRY3+H2RiBDSOTJQqVkT5Mqt7MJZjiXG/Z19xGs2SNdEsRjubwOJJ1qf3FTqr1EQOFqjgBh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791141; c=relaxed/simple;
	bh=3Jo1E2XGzy3aOUbpkc0ToDts7DO8uCNv+U75TBJLGLA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U04LKA0irXy3QIIo8Aa+cdhwt/e9wVngm1TP1Due/WFupdWL8OD1FOeYeDQ7TJgs+wHltMWZ65EsQ3z19agpWEOCjt7X2JSmIiOivWUWdCjsOES7z2gbfVxqDGRo04yM4/lWj+8Sv9H8ChdIFbZLVo3CpbPzYDH9fGP5YVS5YHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RH8EKCY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3716EC4CEC3;
	Sun,  8 Sep 2024 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725791141;
	bh=3Jo1E2XGzy3aOUbpkc0ToDts7DO8uCNv+U75TBJLGLA=;
	h=Subject:To:Cc:From:Date:From;
	b=RH8EKCY2dk8qQ0N66rEHytlTDdI+pfRXA9iIUp6X4zDKPYrVPrRYgG42xAZJQ6hOh
	 Xv12PpaO9YWprC1BTw2FL4GOc8aiVChaXgrOlXJc9h24221fVECMH7DTs4tdBRDlyi
	 AlGgHuv/kONDRua6KHvnzUHjF0dZE8pNvdLGwfn4=
Subject: FAILED: patch "[PATCH] ksmbd: unset the binding mark of a reused connection" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 12:25:38 +0200
Message-ID: <2024090838-reentry-fender-aec1@gregkh>
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
git cherry-pick -x 78c5a6f1f630172b19af4912e755e1da93ef0ab5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090838-reentry-fender-aec1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

78c5a6f1f630 ("ksmbd: unset the binding mark of a reused connection")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
f5c779b7ddbd ("ksmbd: fix racy issue from session setup and logoff")
1d9c4172110e ("ksmbd: Implements sess->ksmbd_chann_list as xarray")
62c487b53a7f ("ksmbd: limit pdu length size according to connection status")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78c5a6f1f630172b19af4912e755e1da93ef0ab5 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 27 Aug 2024 21:44:41 +0900
Subject: [PATCH] ksmbd: unset the binding mark of a reused connection

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 20846a4d3031..8bdc59251418 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1690,6 +1690,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		rc = ksmbd_session_register(conn, sess);
 		if (rc)
 			goto out_err;
+
+		conn->binding = false;
 	} else if (conn->dialect >= SMB30_PROT_ID &&
 		   (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   req->Flags & SMB2_SESSION_REQ_FLAG_BINDING) {
@@ -1768,6 +1770,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			sess = NULL;
 			goto out_err;
 		}
+
+		conn->binding = false;
 	}
 	work->sess = sess;
 


