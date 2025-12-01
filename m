Return-Path: <stable+bounces-197935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0003C98284
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD7EB3444B8
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E230B53B;
	Mon,  1 Dec 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N3wE2x5b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE7311588
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604915; cv=none; b=lpQrWsz3vSW2x5I4dbYJmbNT5w84IUDErdmz2m3p65GUPxbuJnSwfhfkc2Ognq7y1SMyVA4e4v3ndNYWY3qEi1siUCxbkoW7cGpM3YNzkhh9KexauH5/+CATrVc2cUt2kLxm7CsTYrf2Fhu5gMFOyUtLaLaWRPI55THWKYEmEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604915; c=relaxed/simple;
	bh=+LVatQcufITFLCEF4mWy5QWMx8VIhtfhtWHX4tnTQxc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YKPgffb72/vH7iGCwH39AWoh+zGXr+yidTE1kzL+tJAwM3Pz8C+c+V/OC2485s4f94KwWxRZmJH4GHsl4FRlXjcvhD9+297E18bsQsfFwZurrgxS9jLvRWMJJdaukCXBlJHCV7Hj3Ph7seYgezx+TBWfN0IMnY/cSs18YS3eUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N3wE2x5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED97CC4CEF1;
	Mon,  1 Dec 2025 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764604915;
	bh=+LVatQcufITFLCEF4mWy5QWMx8VIhtfhtWHX4tnTQxc=;
	h=Subject:To:Cc:From:Date:From;
	b=N3wE2x5bhxrQQi+7ACLVltayomeMVryKkpHVREqi+gnDMxU8xO2v7Hl+4hys1NQc8
	 TvYM0KYK78dZKHTsRR1fndr+6rn4+VFLctbLFwVOyZUQniID+BUfbe9XQuPXzKo/wK
	 eCdzC4af7LNE5QMpQ1W6lgh/3j84lINmSgzzBfG8=
Subject: FAILED: patch "[PATCH] smb: client: fix memory leak in cifs_construct_tcon()" failed to apply to 5.10-stable tree
To: pc@manguebit.org,dhowells@redhat.com,jaeshin@redhat.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 17:01:44 +0100
Message-ID: <2025120144-dismiss-quilt-863b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3184b6a5a24ec9ee74087b2a550476f386df7dc2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120144-dismiss-quilt-863b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3184b6a5a24ec9ee74087b2a550476f386df7dc2 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Mon, 24 Nov 2025 17:00:36 -0300
Subject: [PATCH] smb: client: fix memory leak in cifs_construct_tcon()

When having a multiuser mount with domain= specified and using
cifscreds, cifs_set_cifscreds() will end up setting @ctx->domainname,
so it needs to be freed before leaving cifs_construct_tcon().

This fixes the following memory leak reported by kmemleak:

  mount.cifs //srv/share /mnt -o domain=ZELDA,multiuser,...
  su - testuser
  cifscreds add -d ZELDA -u testuser
  ...
  ls /mnt/1
  ...
  umount /mnt
  echo scan > /sys/kernel/debug/kmemleak
  cat /sys/kernel/debug/kmemleak
  unreferenced object 0xffff8881203c3f08 (size 8):
    comm "ls", pid 5060, jiffies 4307222943
    hex dump (first 8 bytes):
      5a 45 4c 44 41 00 cc cc                          ZELDA...
    backtrace (crc d109a8cf):
      __kmalloc_node_track_caller_noprof+0x572/0x710
      kstrdup+0x3a/0x70
      cifs_sb_tlink+0x1209/0x1770 [cifs]
      cifs_get_fattr+0xe1/0xf50 [cifs]
      cifs_get_inode_info+0xb5/0x240 [cifs]
      cifs_revalidate_dentry_attr+0x2d1/0x470 [cifs]
      cifs_getattr+0x28e/0x450 [cifs]
      vfs_getattr_nosec+0x126/0x180
      vfs_statx+0xf6/0x220
      do_statx+0xab/0x110
      __x64_sys_statx+0xd5/0x130
      do_syscall_64+0xbb/0x380
      entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: f2aee329a68f ("cifs: set domainName when a domain-key is used in multiuser")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Jay Shin <jaeshin@redhat.com>
Cc: stable@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 55cb4b0cbd48..2f94d93b95e9 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4451,6 +4451,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 
 out:
 	kfree(ctx->username);
+	kfree(ctx->domainname);
 	kfree_sensitive(ctx->password);
 	kfree(origin_fullpath);
 	kfree(ctx);


