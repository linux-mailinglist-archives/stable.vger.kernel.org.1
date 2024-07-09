Return-Path: <stable+bounces-58691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1970C92B834
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C983F28425E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278B152787;
	Tue,  9 Jul 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lChksv1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F655E4C;
	Tue,  9 Jul 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524703; cv=none; b=DquxVG5KD6SGoR4YABfE43mINintHvchfJQ3ykBloj5IcHi9dzZD8s0AZXMxORw/7qPm1WqKGFU/R0PjCLKwANNBpGKJUUVzVwZagAYswNAAYluBCJlWEnktSdMO5Eu4pxUzcyjgqAxnuFhvPhiSOaZnsaw08qpo/kumbnOSOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524703; c=relaxed/simple;
	bh=/g+ybqgYsDsMTdB7QGPm4ydgfpI9SdNhzFp3XXanN6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ekqa0OXKOySIEi6oNJcVRmPqLTCmU0GhmOP4Fx8NAFfIZKvJ0jBwwl6FXHrnnAKQrLat9BHfO3qeC5Q0QnP8HIVzeztzlVeVKRN5b3B9h8F424wONf3ocJlMTqVERjXw6OGUZ6eX+FN0nDau16qR8DRFBuodFctLCh3+skuGDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lChksv1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD87FC3277B;
	Tue,  9 Jul 2024 11:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524703;
	bh=/g+ybqgYsDsMTdB7QGPm4ydgfpI9SdNhzFp3XXanN6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lChksv1XeqKKNNDURFOfCVPFd0HogQ+6M85hFp1WMyousiPQjE5PRp5QF06PXdP3s
	 BHUCItdNPQ4aeBY9/xoCIyhlgAQYxFK4ME4iMWvYXlEXTZOUuwmXqRV2Mvmr1pzvun
	 t30KVdFWJSJHCTUCKIf2zxurzOSlFp/M9SSGwXKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 072/102] fsnotify: Do not generate events for O_PATH file descriptors
Date: Tue,  9 Jul 2024 13:10:35 +0200
Message-ID: <20240709110654.179541354@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
References: <20240709110651.353707001@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



