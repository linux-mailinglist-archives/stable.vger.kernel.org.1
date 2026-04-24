Return-Path: <stable+bounces-240925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FVKIuFz62kQNAAAu9opvQ
	(envelope-from <stable+bounces-240925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:45:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D7445F8D1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31D963031ADA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C653D6494;
	Fri, 24 Apr 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TajKuz03"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29B3563D4;
	Fri, 24 Apr 2026 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038194; cv=none; b=mw2iDuvvTY3bm1Dr2tJQJrab5QC8Vf1ws8VJiKLb9P5j+A4OybkQuNM6t+du2Vk+4puhItJCdlDawyIloZqVDXHKl+yecF/B+v4RP8fDzay2tOKcPpNm9ocV9Jj2A6i1RWQzKt3O44mmpxP8rMlxDVYQDJsN6O9A6KrJ893duV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038194; c=relaxed/simple;
	bh=ByvjIgZQypRzyJdsc7kOXlWuDFk/MplFCApr8UhTDzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BStY0plg6fdAKvKSjVb06F05Z1IRELJD0nANH5udP5giXkcmgBWcIPJThAA/cAexuF6usw9qYoyxjD5W2SrRTK3aCxmnqsRlQvICSbiVfObWXULHPTDjtIw4jBp3/8EVKpAFayV9L4cHDzoiaMPKG9XkzEoCdLjqHXXHKabagdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TajKuz03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62801C19425;
	Fri, 24 Apr 2026 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038194;
	bh=ByvjIgZQypRzyJdsc7kOXlWuDFk/MplFCApr8UhTDzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TajKuz03+9mgBdev6Qu87TBYVGnBPG0//JgmrKBAmJlO2zaQ+eVQCedXM/LFVFRYc
	 VV9rxVpsOdUh1ZSC69sON4dmbIN25TobvlAvpbn4FCa66YQE4ax2RVlDeXHCVzDgEa
	 5dpdMNuYORcNrj/rwDT/gEP+4UeKq9MZ527UQsbg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.18 29/55] f2fs: fix to avoid memory leak in f2fs_rename()
Date: Fri, 24 Apr 2026 15:31:08 +0200
Message-ID: <20260424132436.063481179@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 22D7445F8D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-240925-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cf7946ab25b21abc4b66];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

commit 3cf11e6f36c170050c12171dd6fd3142711478fc upstream.

syzbot reported a f2fs bug as below:

BUG: memory leak
unreferenced object 0xffff888127f70830 (size 16):
  comm "syz.0.23", pid 6144, jiffies 4294943712
  hex dump (first 16 bytes):
    3c af 57 72 5b e6 8f ad 6e 8e fd 33 42 39 03 ff  <.Wr[...n..3B9..
  backtrace (crc 925f8a80):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4520 [inline]
    slab_alloc_node mm/slub.c:4844 [inline]
    __do_kmalloc_node mm/slub.c:5237 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5250
    kmalloc_noprof include/linux/slab.h:954 [inline]
    fscrypt_setup_filename+0x15e/0x3b0 fs/crypto/fname.c:364
    f2fs_setup_filename+0x52/0xb0 fs/f2fs/dir.c:143
    f2fs_rename+0x159/0xca0 fs/f2fs/namei.c:961
    f2fs_rename2+0xd5/0xf20 fs/f2fs/namei.c:1308
    vfs_rename+0x7ff/0x1250 fs/namei.c:6026
    filename_renameat2+0x4f4/0x660 fs/namei.c:6144
    __do_sys_renameat2 fs/namei.c:6173 [inline]
    __se_sys_renameat2 fs/namei.c:6168 [inline]
    __x64_sys_renameat2+0x59/0x80 fs/namei.c:6168
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is in commit 40b2d55e0452 ("f2fs: fix to create selinux
label during whiteout initialization"), we added a call to
f2fs_setup_filename() without a matching call to f2fs_free_filename(),
fix it.

Fixes: 40b2d55e0452 ("f2fs: fix to create selinux label during whiteout initialization")
Cc: stable@kernel.org
Reported-by: syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/69a75fe1.a70a0220.b118c.0014.GAE@google.com
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/namei.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -949,6 +949,7 @@ static int f2fs_rename(struct mnt_idmap
 			return err;
 
 		err = f2fs_create_whiteout(idmap, old_dir, &whiteout, &fname);
+		f2fs_free_filename(&fname);
 		if (err)
 			return err;
 	}



