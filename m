Return-Path: <stable+bounces-37340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7118B89C470
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A235F1C222A2
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845817BB1A;
	Mon,  8 Apr 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsoiFOao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7C7B3E5;
	Mon,  8 Apr 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583946; cv=none; b=SOynHFhE74LpYuObjvytPWUWrVOfkqtJIQb6dLrtsEBIu34iiOH0E9IL6mqClUFxvtLmKuB97/nmBKk57eKX37lQHYzxhd0dgoI9zfqX0A48TORb8aXCIqCqtm7N8AHXgYXfdZ9yi+WPf9eKC0TTgaIqKceGnAfuojtI5560nqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583946; c=relaxed/simple;
	bh=jHvBzsK4zl4XHuugyjqixf7mD78SjsJUnDbfz9w3Mdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evEfjJu+g3gnSrst7wI+IcJO0j2Roz9H92u4JY180po8+cf0/JH0WW/soJr4XV82Bi4flk4ddGl4okdsKvECz6rY51rJAFKZGxvqsp4JZYoE42c4b6sXXmjjjiUEsC7zUUL41FGgaX98V/LJUDvOhEwiPMW4edX1DKrksXXhIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsoiFOao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1E9C433F1;
	Mon,  8 Apr 2024 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583946;
	bh=jHvBzsK4zl4XHuugyjqixf7mD78SjsJUnDbfz9w3Mdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsoiFOao6OOqmfZAyQeWBCKghVyN+5ElCEg1vgemjCSCN8x9zl+5B+BppzTkGxsCi
	 jt2GlrZ/fXTChxiEIXRNVvgKMvlclnlnIEeZJQ5MrjHLaFt4Ym49KY4cfJZGXjHon/
	 3aaStRbBcIBgl4JnQ3lN7QZTjQrCL9pZIqBSGBd0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasily Averin <vvs@openvz.org>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 305/690] fanotify: fix incorrect fmode_t casts
Date: Mon,  8 Apr 2024 14:52:51 +0200
Message-ID: <20240408125410.643941340@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@openvz.org>

[ Upstream commit dccd855771b37820b6d976a99729c88259549f85 ]

Fixes sparce warnings:
fs/notify/fanotify/fanotify_user.c:267:63: sparse:
 warning: restricted fmode_t degrades to integer
fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
 warning: restricted fmode_t degrades to integer

FMODE_NONTIFY have bitwise fmode_t type and requires __force attribute
for any casts.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/9adfd6ac-1b89-791e-796b-49ada3293985@openvz.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fanotify/fanotify_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 4471043955f87..6db5a0b03a78d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -260,7 +260,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
 	 * originally opened O_WRONLY.
 	 */
 	new_file = dentry_open(path,
-			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
+			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
 			       current_cred());
 	if (IS_ERR(new_file)) {
 		/*
@@ -1373,7 +1373,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
 
-	f_flags = O_RDWR | FMODE_NONOTIFY;
+	f_flags = O_RDWR | __FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
-- 
2.43.0




