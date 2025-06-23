Return-Path: <stable+bounces-157586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0AAE54B7
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E21168FEC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370D821D3F6;
	Mon, 23 Jun 2025 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNMS3Tmq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFF3FB1B;
	Mon, 23 Jun 2025 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716231; cv=none; b=qrp9lVUHVWXLfCJwyfKBGMmhmcCMdu/gYjEFMZ2xYYzBPSTcGfJwrZiVCZuxS2bS8hp7MQA6g6wT/b4hXCvAkHAqdMaQPE4ft6DFk2Sawsc+vwo7HhzUz8HooQyTfMxLQ5A5+TWl0Ikn9X6pKzFixRwm25FPeHjoyszixu5ya6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716231; c=relaxed/simple;
	bh=57QtL5FiQ774J5RZjrmndC8lo4FojEC1L5Ih88NuNQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbMD9topXBlOj9b6VfGZwD0OBjy4usaq4Iy8VqPQp5dgfWmSlnCnl8Uotzh2b79/aMGRc4PVGmVyK8aHEE+UkekYhWgTilzKtXQw/+GofXfFHTTJJlQIoSS1+KX1IOrbj0MEMlFK5bH+wzajv1ls+jDshsHHfdNX92JWqWkFDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNMS3Tmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75112C4CEEA;
	Mon, 23 Jun 2025 22:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716230;
	bh=57QtL5FiQ774J5RZjrmndC8lo4FojEC1L5Ih88NuNQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNMS3TmqaJUYwO6OgWQrXXrnrM1vTuo+k5xB7agXxEd2Eu8MQZzVUaqIsb1zfLATO
	 AfT3GsQXAkuTTWEvkFfdM1x4c0hapUeX0RT2JxgCeN8NiSClfKfoaMHVGn/lHXfXbd
	 5AHIJae7GfyknKPljIV41WDYGcIeRPl8IKPYWfIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Aurich <paul@darkrain42.org>,
	Bharath SM <bharathsm@microsoft.com>,
	Ruben Devos <rdevos@oxya.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 271/290] smb: Log an error when close_all_cached_dirs fails
Date: Mon, 23 Jun 2025 15:08:52 +0200
Message-ID: <20250623130635.071769329@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Aurich <paul@darkrain42.org>

commit a2182743a8b4969481f64aec4908ff162e8a206c upstream.

Under low-memory conditions, close_all_cached_dirs() can't move the
dentries to a separate list to dput() them once the locks are dropped.
This will result in a "Dentry still in use" error, so add an error
message that makes it clear this is what happened:

[  495.281119] CIFS: VFS: \\otters.example.com\share Out of memory while dropping dentries
[  495.281595] ------------[ cut here ]------------
[  495.281887] BUG: Dentry ffff888115531138{i=78,n=/}  still in use (2) [unmount of cifs cifs]
[  495.282391] WARNING: CPU: 1 PID: 2329 at fs/dcache.c:1536 umount_check+0xc8/0xf0

Also, bail out of looping through all tcons as soon as a single
allocation fails, since we're already in trouble, and kmalloc() attempts
for subseqeuent tcons are likely to fail just like the first one did.

Signed-off-by: Paul Aurich <paul@darkrain42.org>
Acked-by: Bharath SM <bharathsm@microsoft.com>
Suggested-by: Ruben Devos <rdevos@oxya.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -484,8 +484,17 @@ void close_all_cached_dirs(struct cifs_s
 		spin_lock(&cfids->cfid_list_lock);
 		list_for_each_entry(cfid, &cfids->entries, entry) {
 			tmp_list = kmalloc(sizeof(*tmp_list), GFP_ATOMIC);
-			if (tmp_list == NULL)
-				break;
+			if (tmp_list == NULL) {
+				/*
+				 * If the malloc() fails, we won't drop all
+				 * dentries, and unmounting is likely to trigger
+				 * a 'Dentry still in use' error.
+				 */
+				cifs_tcon_dbg(VFS, "Out of memory while dropping dentries\n");
+				spin_unlock(&cfids->cfid_list_lock);
+				spin_unlock(&cifs_sb->tlink_tree_lock);
+				goto done;
+			}
 			spin_lock(&cfid->fid_lock);
 			tmp_list->dentry = cfid->dentry;
 			cfid->dentry = NULL;
@@ -497,6 +506,7 @@ void close_all_cached_dirs(struct cifs_s
 	}
 	spin_unlock(&cifs_sb->tlink_tree_lock);
 
+done:
 	list_for_each_entry_safe(tmp_list, q, &entry, entry) {
 		list_del(&tmp_list->entry);
 		dput(tmp_list->dentry);



