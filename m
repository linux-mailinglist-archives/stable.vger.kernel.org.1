Return-Path: <stable+bounces-58381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966C92B6BC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1951C21BF3
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD2158875;
	Tue,  9 Jul 2024 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOBxPJwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789813A25F;
	Tue,  9 Jul 2024 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523763; cv=none; b=BlWhVu2hrC+ohu/PHyw6ex1IClKc/3kayrlgxnqszPADrs+utm5+u6zoDN4xjCTQZkf4ZmpgN4DRsGMrYYt9FB5EiJbvYOAFs3qVQbqbGXaar6oVdCYoy9LB8+v8gIldQpT/WJy3JZ3G9raVHNe9mu89J8l+QVGukPmdLLqclmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523763; c=relaxed/simple;
	bh=UpT1Td2H1r3jMq7Z/He0rCz4U26usen8xS3bo0/qFTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX2MiHHmcSzUI6inq8ynVXckvmBRN8bAmA3xC04Li/fRVz6OdbCw7CiwrjbSw/vJfd5FTcQ9O+cHmv6aM0WmrxmfAs62shvdpx/qUSDlf7MWNXNRQdJ3NO1bhLsjMptfKqLVhMkUF/NIdIJyFNzwIduxKDjcjS9WAU7sa3NB888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOBxPJwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F9C32786;
	Tue,  9 Jul 2024 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523763;
	bh=UpT1Td2H1r3jMq7Z/He0rCz4U26usen8xS3bo0/qFTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOBxPJwj62kjaKFLXA+IutpiMQ+DnX9MYarPhL22nVf98nsAkdAHfg8mOQNbb2biV
	 kMPsmLxLqfv0NKFNm+9qzk8n8A7qW9be6pSAPtJfMGQLXj7xx+2yCib8N8IaWh5BiK
	 SdpDtp6+XqjzhM++30C2hfftDR2YAc44Ujx68Nfs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.6 100/139] fsnotify: Do not generate events for O_PATH file descriptors
Date: Tue,  9 Jul 2024 13:10:00 +0200
Message-ID: <20240709110702.043743375@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
 	const struct path *path;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	/*
+	 * FMODE_NONOTIFY are fds generated by fanotify itself which should not
+	 * generate new events. We also don't want to generate events for
+	 * FMODE_PATH fds (involves open & close events) as they are just
+	 * handle creation / destruction events and not "real" file events.
+	 */
+	if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
 		return 0;
 
 	/* Overlayfs internal files have fake f_path */



