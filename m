Return-Path: <stable+bounces-149132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB3CACB102
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DC7165894
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352B23C510;
	Mon,  2 Jun 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SOk7UhfH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123A23C8A1;
	Mon,  2 Jun 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872995; cv=none; b=ueksTi/x7eqL+zRw9ZVq3d20o+CKuNBco60ugMf5qKN9+eY+qPWSyFKAgpgVd8Y0vEnoZnAzifcF83DrwjxnUgtxCEHXQN87u8OZM9JFpV5tD6Vf/l4FFI5PpjAbOIs3SGz9UTe+yAeVQL/3viBlG1hZ48r9h4oIThdbsGkjJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872995; c=relaxed/simple;
	bh=GlVCvZyvIpS5r2yoWKnyJDKMOCE8SAJLJQ0lmc8tZ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbNYB8B856sQye53r2BHTrb1mbOJ5oJHI7CWgxrI1XW7koAGenqArkiWsb+OJ9QYJ61Qrt23MsLLXGOQ2B/lbUPM79Su8pFpgS8blykgDKNclcXzwvd8PlLcHI7bYyv5fEyumWZmwZDjsiliaJUjqAACX5BNfqtzP36Xti2nWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SOk7UhfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD23EC4CEEB;
	Mon,  2 Jun 2025 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872995;
	bh=GlVCvZyvIpS5r2yoWKnyJDKMOCE8SAJLJQ0lmc8tZ8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOk7UhfHSU7FCmOZ3tHWOFvxAjZTLLC5pPqYPi8bGK147KTetM02EleG4FwT/1wKx
	 x8F9nXNlc0iq6HaJjskpqa+HnMjvnnFu1k08wOMM8HlzRRSCxDLm3XqduwSlilbxqT
	 aYXG+UbJ0vNA2mlZx/NNizv3mXiy/lRRBxp2zekQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.12 33/55] coredump: fix error handling for replace_fd()
Date: Mon,  2 Jun 2025 15:47:50 +0200
Message-ID: <20250602134239.586020166@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
References: <20250602134238.271281478@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit 95c5f43181fe9c1b5e5a4bd3281c857a5259991f upstream.

The replace_fd() helper returns the file descriptor number on success
and a negative error code on failure. The current error handling in
umh_pipe_setup() only works because the file descriptor that is replaced
is zero but that's pretty volatile. Explicitly check for a negative
error code.

Link: https://lore.kernel.org/20250414-work-coredump-v2-2-685bf231f828@kernel.org
Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/coredump.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -507,7 +507,9 @@ static int umh_pipe_setup(struct subproc
 {
 	struct file *files[2];
 	struct coredump_params *cp = (struct coredump_params *)info->data;
-	int err = create_pipe_files(files, 0);
+	int err;
+
+	err = create_pipe_files(files, 0);
 	if (err)
 		return err;
 
@@ -515,10 +517,13 @@ static int umh_pipe_setup(struct subproc
 
 	err = replace_fd(0, files[0], 0);
 	fput(files[0]);
+	if (err < 0)
+		return err;
+
 	/* and disallow core files too */
 	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
 
-	return err;
+	return 0;
 }
 
 void do_coredump(const kernel_siginfo_t *siginfo)



