Return-Path: <stable+bounces-116589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A2A38635
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 15:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8974D164BE2
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E01224B02;
	Mon, 17 Feb 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QJb6yqZ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320DEEBB
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802049; cv=none; b=dACIHqPyCtgL656FxqkTG5tBsqqr5FvRqm2rw5v/K/CjBYmZcLw1By2Ow5KJ4Mdkns1gDUeRuvDgb6YRiPgW+lRRi2Wn/kOUAFhMxykQXcVzqvrNh119G5OhSC6mm4LlRielaAg9Rw/hdXDlQYQh01dHraWFH/Hyy/BVWF8vOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802049; c=relaxed/simple;
	bh=pUkno1ClkAeGLy1jHsxCUlTUTKEHE1UwHZ9mm+Uryjc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tL6PIc2jVgsqYg8nNoFzeIdAarB8pEoxD8HxvwdBoRtAmyUkC3X1DibzkBEba2/rT3nyoqBvyJ94Zti/PPO9H8THc7GqbgWTvwX2QVIhNn2yf2lLLEvKSNfYVQpeMpPIk1jAbm2sgTn56spOcA+Dwu31rduaeYCye4DOI7JAW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QJb6yqZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE29C4CEE4;
	Mon, 17 Feb 2025 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739802048;
	bh=pUkno1ClkAeGLy1jHsxCUlTUTKEHE1UwHZ9mm+Uryjc=;
	h=Subject:To:Cc:From:Date:From;
	b=QJb6yqZ82AOarjIKf1cp24B36dOVU7pdMDpMdMO5wkSRaWZxxxZOAyB3ekwyJFM0o
	 stTydW045vdD+o8n4IoluN11FMiKulyt6WAA0ufDesza/3bGJVYjdggIgMQjTbXPPf
	 qFEvcP3WG0Xo9+nK3Zuhb9tgGU0sAohKfS1dyydg=
Subject: FAILED: patch "[PATCH] nfsd: clear acl_access/acl_default after releasing them" failed to apply to 5.4-stable tree
To: lilingfeng3@huawei.com,chuck.lever@oracle.com,jlayton@kernel.org,rmacklem@uoguelph.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Feb 2025 15:20:39 +0100
Message-ID: <2025021739-feel-carrot-068f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7faf14a7b0366f153284db0ad3347c457ea70136
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021739-feel-carrot-068f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7faf14a7b0366f153284db0ad3347c457ea70136 Mon Sep 17 00:00:00 2001
From: Li Lingfeng <lilingfeng3@huawei.com>
Date: Sun, 26 Jan 2025 17:47:22 +0800
Subject: [PATCH] nfsd: clear acl_access/acl_default after releasing them

If getting acl_default fails, acl_access and acl_default will be released
simultaneously. However, acl_access will still retain a pointer pointing
to the released posix_acl, which will trigger a WARNING in
nfs3svc_release_getacl like this:

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
refcount_warn_saturate+0xb5/0x170
Modules linked in:
CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
6.12.0-rc6-00079-g04ae226af01f-dirty #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
RIP: 0010:refcount_warn_saturate+0xb5/0x170
Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
cd 0f b6 1d 8a3
RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? refcount_warn_saturate+0xb5/0x170
 ? __warn+0xa5/0x140
 ? refcount_warn_saturate+0xb5/0x170
 ? report_bug+0x1b1/0x1e0
 ? handle_bug+0x53/0xa0
 ? exc_invalid_op+0x17/0x40
 ? asm_exc_invalid_op+0x1a/0x20
 ? tick_nohz_tick_stopped+0x1e/0x40
 ? refcount_warn_saturate+0xb5/0x170
 ? refcount_warn_saturate+0xb5/0x170
 nfs3svc_release_getacl+0xc9/0xe0
 svc_process_common+0x5db/0xb60
 ? __pfx_svc_process_common+0x10/0x10
 ? __rcu_read_unlock+0x69/0xa0
 ? __pfx_nfsd_dispatch+0x10/0x10
 ? svc_xprt_received+0xa1/0x120
 ? xdr_init_decode+0x11d/0x190
 svc_process+0x2a7/0x330
 svc_handle_xprt+0x69d/0x940
 svc_recv+0x180/0x2d0
 nfsd+0x168/0x200
 ? __pfx_nfsd+0x10/0x10
 kthread+0x1a2/0x1e0
 ? kthread+0xf4/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...

Clear acl_access/acl_default after posix_acl_release is called to prevent
UAF from being triggered.

Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241107014705.2509463-1-lilingfeng@huaweicloud.com/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Reviewed-by: Rick Macklem <rmacklem@uoguelph.ca>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 4e3be7201b1c..5fb202acb0fd 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -84,6 +84,8 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 5e34e98db969..7b5433bd3019 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -76,6 +76,8 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	goto out;
 }
 


