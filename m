Return-Path: <stable+bounces-53844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E595790EA96
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216E5B249F1
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7213EFEE;
	Wed, 19 Jun 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07mOd4ww"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651613EFEC
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799145; cv=none; b=hnp4GsAo974a5WOv7qaGyMMUsLfMa7lfQo5Rr1x/fJM4o3jJZt3e5KFMnR0XQSUAAX9/aiNkfZ3iupTB5YnioSV9jbOyT/QZrfiuCjsagLih5UJUHIdc2/m5poLNZpexp3jMiZAsjqIOQ5Jxp6nJ+poSVirY7e4B+Vxu9OqeB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799145; c=relaxed/simple;
	bh=/qoAMv4/iK73JnJhouOWLX9TgHDogsrc40PBA3Znnnk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MMZCElwfRHm6OtgISOfUR7XUrEuf+SQJ7UqvsCcQWoODfNl549Gk++dh7LfKYuolVZmkQCFOGhIJ6NKlPODhsR42J2W1NSR71hXinvEsxTVy9+ALov84dZIf8EPV221bpLpfbT/XPgMjaIDKXtJLL/aqKN+WlEYKQRK3f9PmWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=07mOd4ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE55FC2BBFC;
	Wed, 19 Jun 2024 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718799145;
	bh=/qoAMv4/iK73JnJhouOWLX9TgHDogsrc40PBA3Znnnk=;
	h=Subject:To:Cc:From:Date:From;
	b=07mOd4wwNUnZiGCiNNuQACqGSJ0g7Mm9c8T/VtfdRx8bfUthrCp7bc+E0cEOnaJbc
	 u3QrISFV/pC2/R3vaq1fdeDr/skVplqXUdpuyJJJT9yrVfV5SqTDJjcWVtq0xR/9he
	 5dBKz3xb9QRZxKWD5iXgpzjXcIgDjSW9raV1KBZw=
Subject: FAILED: patch "[PATCH] ima: Fix use-after-free on a dentry's dname.name" failed to apply to 5.15-stable tree
To: stefanb@linux.ibm.com,viro@zeniv.linux.org.uk,zohar@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 14:12:19 +0200
Message-ID: <2024061919-angelic-granny-6472@gregkh>
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
git cherry-pick -x be84f32bb2c981ca6709
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061919-angelic-granny-6472@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be84f32bb2c981ca670922e047cdde1488b233de Mon Sep 17 00:00:00 2001
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Fri, 22 Mar 2024 10:03:12 -0400
Subject: [PATCH] ima: Fix use-after-free on a dentry's dname.name

->d_name.name can change on rename and the earlier value can be freed;
there are conditions sufficient to stabilize it (->d_lock on dentry,
->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
rename_lock), but none of those are met at any of the sites. Take a stable
snapshot of the name instead.

Link: https://lore.kernel.org/all/20240202182732.GE2087318@ZenIV/
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index b37d043d5748..1856981e33df 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -245,8 +245,8 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
 	struct inode *real_inode = d_real_inode(file_dentry(file));
-	const char *filename = file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
+	struct name_snapshot filename;
 	struct kstat stat;
 	int result = 0;
 	int length;
@@ -317,9 +317,13 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
+		take_dentry_name_snapshot(&filename, file->f_path.dentry);
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename, "collect_data", audit_cause,
-				    result, 0);
+				    filename.name.name, "collect_data",
+				    audit_cause, result, 0);
+
+		release_dentry_name_snapshot(&filename);
 	}
 	return result;
 }
@@ -432,6 +436,7 @@ void ima_audit_measurement(struct ima_iint_cache *iint,
  */
 const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 {
+	struct name_snapshot filename;
 	char *pathname = NULL;
 
 	*pathbuf = __getname();
@@ -445,7 +450,10 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		take_dentry_name_snapshot(&filename, path->dentry);
+		strscpy(namebuf, filename.name.name, NAME_MAX);
+		release_dentry_name_snapshot(&filename);
+
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 6cd0add524cd..3b2cb8f1002e 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -483,7 +483,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     bool size_limit)
 {
 	const char *cur_filename = NULL;
+	struct name_snapshot filename;
 	u32 cur_filename_len = 0;
+	bool snapshot = false;
+	int ret;
 
 	BUG_ON(event_data->filename == NULL && event_data->file == NULL);
 
@@ -496,7 +499,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 	}
 
 	if (event_data->file) {
-		cur_filename = event_data->file->f_path.dentry->d_name.name;
+		take_dentry_name_snapshot(&filename,
+					  event_data->file->f_path.dentry);
+		snapshot = true;
+		cur_filename = filename.name.name;
 		cur_filename_len = strlen(cur_filename);
 	} else
 		/*
@@ -505,8 +511,13 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 		 */
 		cur_filename_len = IMA_EVENT_NAME_LEN_MAX;
 out:
-	return ima_write_template_field_data(cur_filename, cur_filename_len,
-					     DATA_FMT_STRING, field_data);
+	ret = ima_write_template_field_data(cur_filename, cur_filename_len,
+					    DATA_FMT_STRING, field_data);
+
+	if (snapshot)
+		release_dentry_name_snapshot(&filename);
+
+	return ret;
 }
 
 /*


