Return-Path: <stable+bounces-42034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8538B710B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9651C2223E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158DF12C550;
	Tue, 30 Apr 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uyCy4c8r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC1E560;
	Tue, 30 Apr 2024 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474345; cv=none; b=q0IFIYh1VySxJzF8dKKX0acHK4ZmSrtomJgHPRRM9TU9c9cx4/CfkcUqm/QwOTznobhe3UpusUMa1K2nL8qtqBhPyNYVA6FdlipGlZutcY9RqOZNIKtMHGtY5YYUoiAWroLoqyWBTbY/56fTfd1dI4fac1/pzjrmao0x2MFrbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474345; c=relaxed/simple;
	bh=bxn1M8djtLJunMH7WAZ9EE7y1chIujXRmJuA35s3Hn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzHsqS2dvf6C2vgHQnUyky4iy9cL9myP0osw8AdgiS5nSozbUatkAEC8Wzp3n6/AubJ5dEHvQlg8fVwEo74XbS0LurFqOzmpcbdAlp6XdrZNSECrlKaNjMCsWD7YxHw0diigrH+ZCAaqcv4sEKTVkpL8PJNthtdRISlURG+kALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uyCy4c8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E806C2BBFC;
	Tue, 30 Apr 2024 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474345;
	bh=bxn1M8djtLJunMH7WAZ9EE7y1chIujXRmJuA35s3Hn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyCy4c8rvVQHjBdHPuixPZ4qPEbpTz3RSVigqbNDuTpEn0sIis/fbqULCO2F0TLoV
	 z3YXj542K1Y2ue1PRoUr5mV+ZPxG6g9esntA6vUCT9zEtG2+IoXc3YO5EH98qKnE5p
	 D6PECycWQo6GicDeN8lSmk6s7WhLnzD4YJsJq4mU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Terry Tritton <terry.tritton@linaro.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.8 129/228] selftests/seccomp: user_notification_addfd check nextfd is available
Date: Tue, 30 Apr 2024 12:38:27 +0200
Message-ID: <20240430103107.528017496@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Terry Tritton <terry.tritton@linaro.org>

commit 8e3c9f9f3a0742cd12b682a1766674253b33fcf0 upstream.

Currently the user_notification_addfd test checks what the next expected
file descriptor will be by incrementing a variable nextfd. This does not
account for file descriptors that may already be open before the test is
started and will cause the test to fail if any exist.

Replace nextfd++ with a function get_next_fd which will check and return
the next available file descriptor.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
Link: https://lore.kernel.org/r/20240124141357.1243457-4-terry.tritton@linaro.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4037,6 +4037,16 @@ TEST(user_notification_filter_empty_thre
 	EXPECT_GT((pollfd.revents & POLLHUP) ?: 0, 0);
 }
 
+
+int get_next_fd(int prev_fd)
+{
+	for (int i = prev_fd + 1; i < FD_SETSIZE; ++i) {
+		if (fcntl(i, F_GETFD) == -1)
+			return i;
+	}
+	_exit(EXIT_FAILURE);
+}
+
 TEST(user_notification_addfd)
 {
 	pid_t pid;
@@ -4053,7 +4063,7 @@ TEST(user_notification_addfd)
 	/* There may be arbitrary already-open fds at test start. */
 	memfd = memfd_create("test", 0);
 	ASSERT_GE(memfd, 0);
-	nextfd = memfd + 1;
+	nextfd = get_next_fd(memfd);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret) {
@@ -4064,7 +4074,8 @@ TEST(user_notification_addfd)
 	/* Check that the basic notification machinery works */
 	listener = user_notif_syscall(__NR_getppid,
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	ASSERT_EQ(listener, nextfd++);
+	ASSERT_EQ(listener, nextfd);
+	nextfd = get_next_fd(nextfd);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
@@ -4119,14 +4130,16 @@ TEST(user_notification_addfd)
 
 	/* Verify we can set an arbitrary remote fd */
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/* Verify we can set an arbitrary remote fd with large size */
 	memset(&big, 0x0, sizeof(big));
 	big.addfd = addfd;
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 
 	/* Verify we can set a specific remote fd */
 	addfd.newfd = 42;
@@ -4164,7 +4177,8 @@ TEST(user_notification_addfd)
 	 * Child has earlier "low" fds and now 42, so we expect the next
 	 * lowest available fd to be assigned here.
 	 */
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 	ASSERT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/*



