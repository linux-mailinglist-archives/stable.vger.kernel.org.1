Return-Path: <stable+bounces-149769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB0ACB48D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108D09E4370
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9F223327;
	Mon,  2 Jun 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bSyXRpqW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A232C3247;
	Mon,  2 Jun 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874981; cv=none; b=bLdCLlOi514j6RaJQI/isRchV0Eyg6pytQ8LG5VdoE+yJw9PIJRi4W0mVx3wMMCR1PUy5zTqc3OkK9Eag7NNVYBj5bPYc297pWcEWBr3E2QvKrao6xY+noPZUQn/SwyttGaLNFIqK9YmWfF3/UuSRAoDfXTqItnuekvKz2M6V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874981; c=relaxed/simple;
	bh=mLzOsfKwtgB5DHxL6MAX8pfG9tUYoU/+JaPHe83SX/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbxdNvOc/WcYnHUOE/iBcGUDdHgnvXIPDo+o4ElaoQUCvLPgUkiI84Rzwz4GqRPpXNRpePntqT7fLDmk6aF3F26kvaLi9VmJCGap/Z+hdv2ImCjrmAvs/yN9z5zPmsO9GEKR0SsRh0JQLnxt9PRZz0Vbnsne2OEdNbgs94mSdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bSyXRpqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE733C4CEEB;
	Mon,  2 Jun 2025 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874981;
	bh=mLzOsfKwtgB5DHxL6MAX8pfG9tUYoU/+JaPHe83SX/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSyXRpqWrMigGYgSbY9sgX5j7sA0XzJwnV5pay6f7ZPfEHaxDD1Tdc3XnnlY1RIrP
	 BfTHFhZQyZysDILRiYU4Dzy4zXG8KvSLqjvwRzqkwfTAEwxASfqV5fVvcqNFy8S615
	 jXVTR1RDYiJyluE/8gw6pG3qrJLqUAY4WkG219Wg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 195/204] fork: use pidfd_prepare()
Date: Mon,  2 Jun 2025 15:48:48 +0200
Message-ID: <20250602134303.337852777@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit ca7707f5430ad6b1c9cb7cee0a7f67d69328bb2d upstream.

Stop open-coding get_unused_fd_flags() and anon_inode_getfile(). That's
brittle just for keeping the flags between both calls in sync. Use the
dedicated helper.

Message-Id: <20230327-pidfd-file-api-v1-2-5c0e9a3158e4@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/fork.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2155,21 +2155,12 @@ static __latent_entropy struct task_stru
 	 * if the fd table isn't shared).
 	 */
 	if (clone_flags & CLONE_PIDFD) {
-		retval = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+		/* Note that no task has been attached to @pid yet. */
+		retval = __pidfd_prepare(pid, O_RDWR | O_CLOEXEC, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
-
 		pidfd = retval;
 
-		pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
-					      O_RDWR | O_CLOEXEC);
-		if (IS_ERR(pidfile)) {
-			put_unused_fd(pidfd);
-			retval = PTR_ERR(pidfile);
-			goto bad_fork_free_pid;
-		}
-		get_pid(pid);	/* held by pidfile now */
-
 		retval = put_user(pidfd, args->pidfd);
 		if (retval)
 			goto bad_fork_put_pidfd;



