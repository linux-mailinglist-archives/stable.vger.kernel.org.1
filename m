Return-Path: <stable+bounces-192805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56ADC437B0
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526203A51D0
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B30378F2B;
	Sun,  9 Nov 2025 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LxQQ4wFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172147483
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657920; cv=none; b=oGJgKy9SfXVjSCk19ioCcN0l7nfkH9t98yklcKLkrHVQ+ydDIYoMc7v+jA6AhBoIN3venDRu2AzVAfgwcdFPeETExnCY41C+SMq9tiZDMauruBnD+SBi5XpjyQJyXr6v1cKPceALFrPjjLQwhwTw/fbSkIfj6Pmj0JZAQjcEAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657920; c=relaxed/simple;
	bh=HRYWBrPB0XZsGyTaDhCD1pAKMXd9h8bEbEIOJd23v8U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VmovGBOraQqWbUtFMmjn9VH6XS3aO79IiHCY6j4Sd9Q5nVl36Z7KVpKrNo0jrnf17V0gpHG8iiBzNUribXrApqUYU1mhOm1LhNaE9oysmDU0qPjQeTSYwIJODxXPkb6FcNNKER3xO2frdV5fh0MQRf+EKADgWWz7lQEBPFzmt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LxQQ4wFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59369C19425;
	Sun,  9 Nov 2025 03:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762657919;
	bh=HRYWBrPB0XZsGyTaDhCD1pAKMXd9h8bEbEIOJd23v8U=;
	h=Subject:To:Cc:From:Date:From;
	b=LxQQ4wFJqHBgs5Klv/Y10XsLBJlsInd9WajCEx9KSg0OZnJyjNZbO6LdaD8+PCNXP
	 2AGEIaHs4Dgvg3QzJgA02n29ym007BxyUUs5hvDIfVEwD2XjIWWOPz3eerKYmj9/Lq
	 umIRLZ6oi5B4JCCBcizYwj2guSe3OQLtSJv6Pp64=
Subject: FAILED: patch "[PATCH] smb: client: fix potential UAF in smb2_close_cached_fid()" failed to apply to 6.1-stable tree
To: henrique.carvalho@suse.com,jaeshin@redhat.com,pc@manguebit.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:11:56 +0900
Message-ID: <2025110956-pork-relearn-9e1e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 734e99623c5b65bf2c03e35978a0b980ebc3c2f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110956-pork-relearn-9e1e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 734e99623c5b65bf2c03e35978a0b980ebc3c2f8 Mon Sep 17 00:00:00 2001
From: Henrique Carvalho <henrique.carvalho@suse.com>
Date: Mon, 3 Nov 2025 19:52:55 -0300
Subject: [PATCH] smb: client: fix potential UAF in smb2_close_cached_fid()

find_or_create_cached_dir() could grab a new reference after kref_put()
had seen the refcount drop to zero but before cfid_list_lock is acquired
in smb2_close_cached_fid(), leading to use-after-free.

Switch to kref_put_lock() so cfid_release() is called with
cfid_list_lock held, closing that gap.

Fixes: ebe98f1447bb ("cifs: enable caching of directories for which a lease is held")
Cc: stable@vger.kernel.org
Reported-by: Jay Shin <jaeshin@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index b8ac7b7faf61..018055fd2cdb 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -388,11 +388,11 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			 * lease. Release one here, and the second below.
 			 */
 			cfid->has_lease = false;
-			kref_put(&cfid->refcount, smb2_close_cached_fid);
+			close_cached_dir(cfid);
 		}
 		spin_unlock(&cfids->cfid_list_lock);
 
-		kref_put(&cfid->refcount, smb2_close_cached_fid);
+		close_cached_dir(cfid);
 	} else {
 		*ret_cfid = cfid;
 		atomic_inc(&tcon->num_remote_opens);
@@ -438,12 +438,14 @@ int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
 
 static void
 smb2_close_cached_fid(struct kref *ref)
+__releases(&cfid->cfids->cfid_list_lock)
 {
 	struct cached_fid *cfid = container_of(ref, struct cached_fid,
 					       refcount);
 	int rc;
 
-	spin_lock(&cfid->cfids->cfid_list_lock);
+	lockdep_assert_held(&cfid->cfids->cfid_list_lock);
+
 	if (cfid->on_list) {
 		list_del(&cfid->entry);
 		cfid->on_list = false;
@@ -478,7 +480,7 @@ void drop_cached_dir_by_name(const unsigned int xid, struct cifs_tcon *tcon,
 	spin_lock(&cfid->cfids->cfid_list_lock);
 	if (cfid->has_lease) {
 		cfid->has_lease = false;
-		kref_put(&cfid->refcount, smb2_close_cached_fid);
+		close_cached_dir(cfid);
 	}
 	spin_unlock(&cfid->cfids->cfid_list_lock);
 	close_cached_dir(cfid);
@@ -487,7 +489,7 @@ void drop_cached_dir_by_name(const unsigned int xid, struct cifs_tcon *tcon,
 
 void close_cached_dir(struct cached_fid *cfid)
 {
-	kref_put(&cfid->refcount, smb2_close_cached_fid);
+	kref_put_lock(&cfid->refcount, smb2_close_cached_fid, &cfid->cfids->cfid_list_lock);
 }
 
 /*
@@ -596,7 +598,7 @@ cached_dir_offload_close(struct work_struct *work)
 
 	WARN_ON(cfid->on_list);
 
-	kref_put(&cfid->refcount, smb2_close_cached_fid);
+	close_cached_dir(cfid);
 	cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cached_close);
 }
 
@@ -762,7 +764,7 @@ static void cfids_laundromat_worker(struct work_struct *work)
 			 * Drop the ref-count from above, either the lease-ref (if there
 			 * was one) or the extra one acquired.
 			 */
-			kref_put(&cfid->refcount, smb2_close_cached_fid);
+			close_cached_dir(cfid);
 	}
 	queue_delayed_work(cfid_put_wq, &cfids->laundromat_work,
 			   dir_cache_timeout * HZ);


