Return-Path: <stable+bounces-63675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4148941A15
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6ED286A5B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0418452F;
	Tue, 30 Jul 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQmkGmm5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3131A6192;
	Tue, 30 Jul 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357594; cv=none; b=CHm77MVlRnh57G/gbhkyStyTXPgGhtPRZqRdPiPmPkiExhy0uSBz5uxIghCre6VAJKf1loJP9bpKZxOjaczacNKW3z+G7zofl6qRZDdOiaZY/Y8HM/xsGAVRWV2unQZLni8KwvYQ2KHR+VNIinzQ9qv06n1oNYy27htiWIoyyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357594; c=relaxed/simple;
	bh=glBMCQsu9f4s9jwaE05oHSTC/mKj8oRkHwMsoRLZ9Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezmb6KtcvhMTCrx/2V+6QUdPUhbEbOSW31JEWd5o4BJvyErxO/0nL3hWKF20M1sPri+mjnRBv6y/nsOr0+TE1AEyBDfIlyYEz/VOJ52USh4A6fLN/afCJNEoMB1JGqRk1UwZwoYVnO8PVem/NzycQWiUHynWAo8D86obdXmK/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQmkGmm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC8BC32782;
	Tue, 30 Jul 2024 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357593;
	bh=glBMCQsu9f4s9jwaE05oHSTC/mKj8oRkHwMsoRLZ9Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQmkGmm5KGoXFhYTvX2pmtjKcHeE7pfKiNWXR46odPCq4Aw0f351ie8fSS3Xhwg6T
	 ZtadSvnFDxMAMy0FOF5eBzpS5WAWcQ3TGhlNMpwQX9yrcHODmxV2YD51gEi0Q3F+zZ
	 jxf49l5ptt3O+Uz9uKGx9CZUqFf5o59gc9M7Vt1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 6.1 307/440] selftests/landlock: Add cred_transfer test
Date: Tue, 30 Jul 2024 17:49:00 +0200
Message-ID: <20240730151627.813763789@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mickaël Salaün <mic@digikod.net>

commit cc374782b6ca0fd634482391da977542443d3368 upstream.

Check that keyctl(KEYCTL_SESSION_TO_PARENT) preserves the parent's
restrictions.

Fixes: e1199815b47b ("selftests/landlock: Add user space tests")
Co-developed-by: Jann Horn <jannh@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20240724.Ood5aige9she@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/landlock/base_test.c |   74 +++++++++++++++++++++++++++
 tools/testing/selftests/landlock/config      |    5 +
 2 files changed, 77 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -9,6 +9,7 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
+#include <linux/keyctl.h>
 #include <linux/landlock.h>
 #include <string.h>
 #include <sys/prctl.h>
@@ -356,4 +357,77 @@ TEST(ruleset_fd_transfer)
 	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 
+TEST(cred_transfer)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	int ruleset_fd, dir_fd;
+	pid_t child;
+	int status;
+
+	drop_caps(_metadata);
+
+	dir_fd = open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	EXPECT_LE(0, dir_fd);
+	EXPECT_EQ(0, close(dir_fd));
+
+	/* Denies opening directories. */
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Checks ruleset enforcement. */
+	EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	/* Needed for KEYCTL_SESSION_TO_PARENT permission checks */
+	EXPECT_NE(-1, syscall(__NR_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL, 0,
+			      0, 0))
+	{
+		TH_LOG("Failed to join session keyring: %s", strerror(errno));
+	}
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		/* Checks ruleset enforcement. */
+		EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		EXPECT_EQ(EACCES, errno);
+
+		/*
+		 * KEYCTL_SESSION_TO_PARENT is a no-op unless we have a
+		 * different session keyring in the child, so make that happen.
+		 */
+		EXPECT_NE(-1, syscall(__NR_keyctl, KEYCTL_JOIN_SESSION_KEYRING,
+				      NULL, 0, 0, 0));
+
+		/*
+		 * KEYCTL_SESSION_TO_PARENT installs credentials on the parent
+		 * that never go through the cred_prepare hook, this path uses
+		 * cred_transfer instead.
+		 */
+		EXPECT_EQ(0, syscall(__NR_keyctl, KEYCTL_SESSION_TO_PARENT, 0,
+				     0, 0, 0));
+
+		/* Re-checks ruleset enforcement. */
+		EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		EXPECT_EQ(EACCES, errno);
+
+		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		return;
+	}
+
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/* Re-checks ruleset enforcement. */
+	EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+}
+
 TEST_HARNESS_MAIN
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -1,7 +1,8 @@
+CONFIG_KEYS=y
 CONFIG_OVERLAY_FS=y
+CONFIG_SECURITY=y
 CONFIG_SECURITY_LANDLOCK=y
 CONFIG_SECURITY_PATH=y
-CONFIG_SECURITY=y
 CONFIG_SHMEM=y
-CONFIG_TMPFS_XATTR=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y



