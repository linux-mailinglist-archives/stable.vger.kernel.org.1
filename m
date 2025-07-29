Return-Path: <stable+bounces-165034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98524B147AE
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 07:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB7E1AA2334
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 05:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66B22D4C3;
	Tue, 29 Jul 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bhrMoZQX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0541C69
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767423; cv=none; b=bOqXK91UQi32oH37hWhnABweHQJwyx5PCu7yBauIitMAT3n4VSFUqUjoHKVPhr/9vGlqyX+XfFIyPru9omIYVEUCMXabfLDc7MfRsWqHz2yo+48l7ZQ4h8qiTX3kRqjUwdMUVdlO1U3kLhEVXGYeqx9s3cdMUQiIx79y8g3nqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767423; c=relaxed/simple;
	bh=EVbbzzezYD0K3KPxpJ/lUuCeAB774J6O7/23auYc27w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncKCylZx5f1rSqG8O1sWcYe8+7mCvy40WE6CbYhpsPjt0gezZPUSg3flm8Dk9JV6aVxs4U+5F6ZtEswzSqbHyzB/YCh/4kFsALF51s2hzPDSMBEX2EiMZKMnEO/uS9lXdauDGae53cm6wl/GWu6/+MirluY7ZDBp115yfN67RPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bhrMoZQX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78294a233so1853262f8f.3
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 22:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753767419; x=1754372219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nK9P0fRK/EYrJJdON4Qzx2pRguvbCZG6lv6EPx9lvck=;
        b=bhrMoZQX9+lkk/M2sJ0HrRx7zfXFgwpwpL0LIM1wDuN87ZVS8l80X/fhboMjOXFvOr
         pe8UwGU7GF/nqmUbTvLicm1CnZtA8v/tY+KZQyOOnLeiRV5PHeDzpxtw6bi24VIkAW79
         iksKYchvomokG0/26Z20HsGF1Vj3Wcdr0Oj+ZbARJ4Z03MGVSqt+Gl+i79IJ3uL9eSVH
         cbubZU0wLhCieCH2YkfkGP41O0psfhtNLchLjDqhW3782PIC03llg9KUSrFY5EJf5RRI
         ENKhn0ydvYGYZA4+PfgcKPHXQhKl5ZfE5Myt1ZOa3+BDqCumYnFO4EteZWdAsksCODYJ
         9YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767419; x=1754372219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nK9P0fRK/EYrJJdON4Qzx2pRguvbCZG6lv6EPx9lvck=;
        b=auslEdlr4ZCbm+auryv1OpB6kQ8pWiN34kcHBY3pkwFJjIpWL3PJB3qiYzuiSg4lyu
         sPOSN0R3lCVWmN+LeoSoTO9h3XxXoKEH5dphhQtnlWHeP2Ip7iwzedPHn+L69R2V3ysF
         /e9dZQe4+YQZZ0TH7Tj0iLug29oumvYKTYv6wRFq/TUoOqZXaXvhUuGfYa7wZUFtZKLf
         oPlK5jS6l6uuRGFvlOridA/+iA06bEls7Aq8UtjQl1eK9l18MyNYe+OAKDuk4FbCeeQS
         wl7ILjZlbrecqRNF6VonvlK35t0QXTpeRmwODmZLNDBe9DAF0LfLc2n8gWr8JUQ3vWqn
         uNLw==
X-Gm-Message-State: AOJu0Ywg74h9Szqd/pz6gHuHk5mYfJIfnyTf7xRLHsx8liZM9J1JXDp0
	8FKXRpAcXEjIuqTqNuU2vZhHP0HCYhEZldHnh8iHtkGbh7GO/7pBIEvZ8UPq1XIDh2UWLbN+qNy
	7rMXMnoU=
X-Gm-Gg: ASbGncuTfAybTPKww4/ZNzF0GBUEtXyarH97clmgYqiTTens1IKYIKMaX7CVKO22jOM
	hgzHf6tbRl+rW+npA+MRJv7xzteCLW6XhwGoFTmYRVd6kIpTsrDZnbAF6KajVXtjXBMHYMu8Xfz
	skKj60QSrfo1oEGbTIURKly/Jt73XurOnWZAY1xcECyAin1IZcoFU5VldKO7nAOcRE8HzcLQGMq
	ucEHVAQTyO7SOaH4hc4nzhb3nohdVB+0+0EvDQUkITrVfdds4PLLdRizQUceN/TiAjYoNEeFUtR
	ciaX6F1/hcxCW4zxOP/xbOdG++3trtfseAtTY4ObZ/tqpg9lTf0XwSWMnKW2y2maeFwz0FayDBy
	ByXMxFK+IWFrHtLGUMbu+F7tKdxIXLb8o
X-Google-Smtp-Source: AGHT+IGeJYKpQ9MyhPNjIuMjJaG74YeNje8Bn2DywBczZ49yJ6gF4VqJWb1BcDe5MaKZQmtVTj7JzQ==
X-Received: by 2002:a05:6000:2088:b0:3a5:2599:4178 with SMTP id ffacd0b85a97d-3b776735b1cmr8496441f8f.19.1753767419300;
        Mon, 28 Jul 2025 22:36:59 -0700 (PDT)
Received: from localhost ([2401:e180:88a2:4c10:c47b:26d3:8f9b:63])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24025f5a3ecsm36989075ad.136.2025.07.28.22.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:36:58 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 1/1] Revert "selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test"
Date: Tue, 29 Jul 2025 13:36:51 +0800
Message-ID: <20250729053652.73667-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4730b07ef7745d7cd48c6aa9f72d75ac136d436f.

The test depends on commit eb166e522c77 "bpf: Allow helper
bpf_get_[ns_]current_pid_tgid() for all prog types", which was not part of the
stable 6.6 code base, and thus the test will fail. Revert it since it is a
false positive.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 73 -------------------
 .../bpf/progs/test_ns_current_pid_tgid.c      |  7 --
 2 files changed, 80 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 2c57ceede095..a84c41862ff8 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -12,7 +12,6 @@
 #include <sys/wait.h>
 #include <sys/mount.h>
 #include <fcntl.h>
-#include "network_helpers.h"
 
 #define STACK_SIZE (1024 * 1024)
 static char child_stack[STACK_SIZE];
@@ -75,50 +74,6 @@ static int test_current_pid_tgid_tp(void *args)
 	return ret;
 }
 
-static int test_current_pid_tgid_cgrp(void *args)
-{
-	struct test_ns_current_pid_tgid__bss *bss;
-	struct test_ns_current_pid_tgid *skel;
-	int server_fd = -1, ret = -1, err;
-	int cgroup_fd = *(int *)args;
-	pid_t tgid, pid;
-
-	skel = test_ns_current_pid_tgid__open();
-	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open"))
-		return ret;
-
-	bpf_program__set_autoload(skel->progs.cgroup_bind4, true);
-
-	err = test_ns_current_pid_tgid__load(skel);
-	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__load"))
-		goto cleanup;
-
-	bss = skel->bss;
-	if (get_pid_tgid(&pid, &tgid, bss))
-		goto cleanup;
-
-	skel->links.cgroup_bind4 = bpf_program__attach_cgroup(
-		skel->progs.cgroup_bind4, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.cgroup_bind4, "bpf_program__attach_cgroup"))
-		goto cleanup;
-
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
-	if (!ASSERT_GE(server_fd, 0, "start_server"))
-		goto cleanup;
-
-	if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
-		goto cleanup;
-	if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
-		goto cleanup;
-	ret = 0;
-
-cleanup:
-	if (server_fd >= 0)
-		close(server_fd);
-	test_ns_current_pid_tgid__destroy(skel);
-	return ret;
-}
-
 static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 {
 	int wstatus;
@@ -140,25 +95,6 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 		return;
 }
 
-static void test_in_netns(int (*fn)(void *), void *arg)
-{
-	struct nstoken *nstoken = NULL;
-
-	SYS(cleanup, "ip netns add ns_current_pid_tgid");
-	SYS(cleanup, "ip -net ns_current_pid_tgid link set dev lo up");
-
-	nstoken = open_netns("ns_current_pid_tgid");
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
-		goto cleanup;
-
-	test_ns_current_pid_tgid_new_ns(fn, arg);
-
-cleanup:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del ns_current_pid_tgid");
-}
-
 /* TODO: use a different tracepoint */
 void serial_test_ns_current_pid_tgid(void)
 {
@@ -166,13 +102,4 @@ void serial_test_ns_current_pid_tgid(void)
 		test_current_pid_tgid_tp(NULL);
 	if (test__start_subtest("new_ns_tp"))
 		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
-	if (test__start_subtest("new_ns_cgrp")) {
-		int cgroup_fd = -1;
-
-		cgroup_fd = test__join_cgroup("/sock_addr");
-		if (ASSERT_GE(cgroup_fd, 0, "join_cgroup")) {
-			test_in_netns(test_current_pid_tgid_cgrp, &cgroup_fd);
-			close(cgroup_fd);
-		}
-	}
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
index d0010e698f66..aa3ec7ca16d9 100644
--- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
@@ -28,11 +28,4 @@ int tp_handler(const void *ctx)
 	return 0;
 }
 
-SEC("?cgroup/bind4")
-int cgroup_bind4(struct bpf_sock_addr *ctx)
-{
-	get_pid_tgid();
-	return 1;
-}
-
 char _license[] SEC("license") = "GPL";
-- 
2.50.1


