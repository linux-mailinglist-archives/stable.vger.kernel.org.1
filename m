Return-Path: <stable+bounces-59597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E0932ADB
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC821C22B0A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E31DDD1;
	Tue, 16 Jul 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NcRW2EjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF241E894;
	Tue, 16 Jul 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144328; cv=none; b=FCgeIj7pF6taewdDNGJ4LcsNGTbZpIGcwMxXPh3vItBBceMT/hPwoeC/feNTc3G+eJViLZaZ10xGcQMzstN7KiHghLXc1etu8rFqUT1SXmmpnBIZ1FtZfCtQqWMZPVM2d37PNiB4tUgVP4IAtTxttGt1XG4axgbZr1adkeKJRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144328; c=relaxed/simple;
	bh=HI1VK5KuIjhbjHMRxsuqTjoZNZjz1WHKywWH5Zcs/80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpN1GHNjAWWtTJGodBQC7xb0WWSTVBlILkGs7RZ4FXXz7CqH4gIgEKzqTKSdzE+aLmAecNd6amImBmxVcZ9bemCEZRUl1IS3laCZxyxFQy3D5PJ9WH9anaK0LCUJ4CUxDI3NcsuLMgAlRJaR7TMs2I/sUuQIz6VlwWvejKfW8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NcRW2EjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEC3C4AF0B;
	Tue, 16 Jul 2024 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144327;
	bh=HI1VK5KuIjhbjHMRxsuqTjoZNZjz1WHKywWH5Zcs/80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcRW2EjUKVl3P0svhGUjyXjjjbhoRjG3dySFT2rK6J2xbaa8kTwgxGLhzsEvCTZmV
	 8K5waXo0lJG+tefUKbTq/XbKjl6VDHboysLNIvZxsdPGo+++Uc+AcTi3xNKM84AKzs
	 GeiD42g8p+sz9qdDBWEHRrnWI6mTWxrjoj3cfwSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 36/78] fsnotify: Do not generate events for O_PATH file descriptors
Date: Tue, 16 Jul 2024 17:31:08 +0200
Message-ID: <20240716152742.035084628@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152740.626160410@linuxfoundation.org>
References: <20240716152740.626160410@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 702eb71fd6501b3566283f8c96d7ccc6ddd662e9 upstream.

Currently we will not generate FS_OPEN events for O_PATH file
descriptors but we will generate FS_CLOSE events for them. This is
asymmetry is confusing. Arguably no fsnotify events should be generated
for O_PATH file descriptors as they cannot be used to access or modify
file content, they are just convenient handles to file objects like
paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
file descriptors.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240617162303.1596-1-jack@suse.cz
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/fsnotify.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -62,7 +62,13 @@ static inline int fsnotify_perm(struct f
 	struct inode *inode = file_inode(file);
 	__u32 fsnotify_mask = 0;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	/*
+	 * FMODE_NONOTIFY are fds generated by fanotify itself which should not
+	 * generate new events. We also don't want to generate events for
+	 * FMODE_PATH fds (involves open & close events) as they are just
+	 * handle creation / destruction events and not "real" file events.
+	 */
+	if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
 		return 0;
 	if (!(mask & (MAY_READ | MAY_OPEN)))
 		return 0;



