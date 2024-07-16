Return-Path: <stable+bounces-59681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE252932B43
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2DF1C22E96
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DA91448ED;
	Tue, 16 Jul 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fjnFDt6m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E074F9E8;
	Tue, 16 Jul 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144581; cv=none; b=cz/BzPwpQwDxK2XBcOscA8luvfpJ/V8pOullJ4H6PPranut+g+VEXKEunjFWFqp+ZTslFMtyzGkSKoIljJBzxyyjkXKcSzuFaeolNSlXOidr3zdzCkIZjvdd1IhskyNUnhhZyU9XBkYYcLhTUI201fiNVsGkgA4dvCV7qvnnn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144581; c=relaxed/simple;
	bh=DnELbNB/We1pvCQLLAyYuPZJl5zAFrq/IUsmh/9lvLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPdcY5Dl1Z4CZkSI8w0junmHDO/HY3Cf5UZWBwsrdj2nBQOcczGYShjoKLkec1E8r3+EDS5H+d0S+EL8+M9cgyX6wkzcs+5ByrbdTKD1DVxPX5eNUcM5EUQqcFu0uHZXzKKmakzetKTxyg5S8eje3aY9wjLn1ZBHZspihsflnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fjnFDt6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2723BC116B1;
	Tue, 16 Jul 2024 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144581;
	bh=DnELbNB/We1pvCQLLAyYuPZJl5zAFrq/IUsmh/9lvLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjnFDt6msxKxRcHWAd8FuG8Ce42eUbPoIjIUN/csCkqg4kdb43+C87w8t92iu9MBH
	 4ZX1jmjA6HbFnqVj9qH/dve0JU3MuhduBg5i7hftb/ka7B1wxVmTL8cC7EFDY15kBY
	 epqg7dLbwFXxatj9jUn2deSuxIQsUNk1ypkhAF2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.10 040/108] fsnotify: Do not generate events for O_PATH file descriptors
Date: Tue, 16 Jul 2024 17:30:55 +0200
Message-ID: <20240716152747.534434839@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -93,7 +93,13 @@ static inline int fsnotify_file(struct f
 {
 	const struct path *path = &file->f_path;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	/*
+	 * FMODE_NONOTIFY are fds generated by fanotify itself which should not
+	 * generate new events. We also don't want to generate events for
+	 * FMODE_PATH fds (involves open & close events) as they are just
+	 * handle creation / destruction events and not "real" file events.
+	 */
+	if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
 		return 0;
 
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);



