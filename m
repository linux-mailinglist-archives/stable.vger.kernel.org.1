Return-Path: <stable+bounces-18107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1E848167
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E7E1C22809
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734011721;
	Sat,  3 Feb 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+YC4mgd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624B11720;
	Sat,  3 Feb 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933552; cv=none; b=AY92lq8E552VfJNEax6JummT3noAwp+esltPkyCaDd1xFhjwFy8c4yG5a5K6WlDr+ogyBv/qRyozT7dcbnwJNeLBq1pLPTwYECjbNdTVoPnM4LK5yyi1G8Q8pO3Os6jmtFZKI4WmNpuLv+0n1zLL+5KxpFOeryvtCeMt8JRI2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933552; c=relaxed/simple;
	bh=rG7XAQjJFcU80kDQxZ5mG1oGMa/5/ImS53AzOhyXKpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUtNiKOUH4xx9hFWA7A5Tl7G3n0jCRbBFXSIwVm/r/nCdQ1H/mJ2DF5gpg4OHMyOQKLWm65yAqMjeb2+MWF1Vd7JVEwNeT41eZxxXVNniiyoONEWdIn6igbhUPdVRGKXEtl4VzorSFsgzU/IwYtTnV0SXzmtKAmXWjsJwMOw1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+YC4mgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B518C433F1;
	Sat,  3 Feb 2024 04:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933552;
	bh=rG7XAQjJFcU80kDQxZ5mG1oGMa/5/ImS53AzOhyXKpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+YC4mgdg+LYU0uZfRGQQtXOYcVP5uZQWKx03wvn4vIWFxhR+VHmIm89eee8lKc0+
	 mI9NZUqdmYgLvHsezuqY+lSiC9fKjb3UBUkOD594BKSGk/uG/mgmi5T6BWZ9BjihRM
	 EfRrv7Nhoeiv53OChtZ3rkG4M9e/o0pKqez05DZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 065/322] selftests/bpf: Fix issues in setup_classid_environment()
Date: Fri,  2 Feb 2024 20:02:42 -0800
Message-ID: <20240203035401.235400432@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit 4849775587844e44d215289c425bcd70f315efe7 ]

If the net_cls subsystem is already mounted, attempting to mount it again
in setup_classid_environment() will result in a failure with the error code
EBUSY. Despite this, tmpfs will have been successfully mounted at
/sys/fs/cgroup/net_cls. Consequently, the /sys/fs/cgroup/net_cls directory
will be empty, causing subsequent setup operations to fail.

Here's an error log excerpt illustrating the issue when net_cls has already
been mounted at /sys/fs/cgroup/net_cls prior to running
setup_classid_environment():

- Before that change

  $ tools/testing/selftests/bpf/test_progs --name=cgroup_v1v2
  test_cgroup_v1v2:PASS:server_fd 0 nsec
  test_cgroup_v1v2:PASS:client_fd 0 nsec
  test_cgroup_v1v2:PASS:cgroup_fd 0 nsec
  test_cgroup_v1v2:PASS:server_fd 0 nsec
  run_test:PASS:skel_open 0 nsec
  run_test:PASS:prog_attach 0 nsec
  test_cgroup_v1v2:PASS:cgroup-v2-only 0 nsec
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup.procs
  (cgroup_helpers.c:540: errno: No such file or directory) Opening cgroup classid: /sys/fs/cgroup/net_cls/cgroup-test-work-dir/net_cls.classid
  run_test:PASS:skel_open 0 nsec
  run_test:PASS:prog_attach 0 nsec
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup-test-work-dir/cgroup.procs
  run_test:FAIL:join_classid unexpected error: 1 (errno 2)
  test_cgroup_v1v2:FAIL:cgroup-v1v2 unexpected error: -1 (errno 2)
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup.procs
  #44      cgroup_v1v2:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

- After that change
  $ tools/testing/selftests/bpf/test_progs --name=cgroup_v1v2
  #44      cgroup_v1v2:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Link: https://lore.kernel.org/r/20231111090034.4248-3-laoar.shao@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 2caee8423ee0..f68fbc6c3f52 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -499,10 +499,20 @@ int setup_classid_environment(void)
 		return 1;
 	}
 
-	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls") &&
-	    errno != EBUSY) {
-		log_err("mount cgroup net_cls");
-		return 1;
+	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls")) {
+		if (errno != EBUSY) {
+			log_err("mount cgroup net_cls");
+			return 1;
+		}
+
+		if (rmdir(NETCLS_MOUNT_PATH)) {
+			log_err("rmdir cgroup net_cls");
+			return 1;
+		}
+		if (umount(CGROUP_MOUNT_DFLT)) {
+			log_err("umount cgroup base");
+			return 1;
+		}
 	}
 
 	cleanup_classid_environment();
-- 
2.43.0




