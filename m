Return-Path: <stable+bounces-96832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376B9E21E8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E743716624A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6151F76A4;
	Tue,  3 Dec 2024 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHshVu/s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E041F892B;
	Tue,  3 Dec 2024 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238722; cv=none; b=uwdV36T+XZ99RjpigWLZVDu23DdYtSwaduJhflTYvP4w1nF3BBg2zT3cIRiGRpK2fvwGhD22pHHvqHFqKn1ysHWCAGxJeH/D0g5NpbUrCSLoRSZAAQTI1vGU866429QPOyKOpnVyrApryfeShV8QL2Nx9FxulyCGqGQlH9WCNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238722; c=relaxed/simple;
	bh=0OuHvNL2BiVyLx0GYS4S+CjbRep328vLgEMWsXcHmqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO0/s1GuO5Oglqy2BSbd8hwwEC+KoXK91vM5dywOUqEZ4JSaX3+fsgvJHRFVKI+9bMMYnIwHEGHiHLtuf8zvc26FuRIdZN9dCKs6IYDaoFktcPURPBxy5x6u4/F0YScTXlOP6haes6ivfbP0TYai0QTQtMQhy8jjTjXwUqibuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHshVu/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1518C4CED6;
	Tue,  3 Dec 2024 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238722;
	bh=0OuHvNL2BiVyLx0GYS4S+CjbRep328vLgEMWsXcHmqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHshVu/sVsTiqtLm9zBexKwNuGnaQPUV98qlg5+o1sy8WpNEP2qlKOLCaczTo4hhG
	 Y2qbWPtIufTIKdEU6u+XxWxghcpaXlXL06Q7rU1hB+u71D3PG8z2M1vg6lzkx9kJ7X
	 7dvyKrVtkq5OTPEY8+oqcltwkvsQ6kC2giuGDZ4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viktor Malik <vmalik@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 344/817] selftests/bpf: skip the timer_lockup test for single-CPU nodes
Date: Tue,  3 Dec 2024 15:38:36 +0100
Message-ID: <20241203144009.253124285@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viktor Malik <vmalik@redhat.com>

[ Upstream commit 937a1c29a287e8f48c4cea714c76a13e14d989ac ]

The timer_lockup test needs 2 CPUs to work, on single-CPU nodes it fails
to set thread affinity to CPU 1 since it doesn't exist:

    # ./test_progs -t timer_lockup
    test_timer_lockup:PASS:timer_lockup__open_and_load 0 nsec
    test_timer_lockup:PASS:pthread_create thread1 0 nsec
    test_timer_lockup:PASS:pthread_create thread2 0 nsec
    timer_lockup_thread:PASS:cpu affinity 0 nsec
    timer_lockup_thread:FAIL:cpu affinity unexpected error: 22 (errno 0)
    test_timer_lockup:PASS: 0 nsec
    #406     timer_lockup:FAIL

Skip the test if only 1 CPU is available.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Fixes: 50bd5a0c658d1 ("selftests/bpf: Add timer lockup selftest")
Tested-by: Philo Lu <lulie@linux.alibaba.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241107115231.75200-1-vmalik@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/timer_lockup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
index 871d16cb95cfd..1a2f99596916f 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
@@ -5,6 +5,7 @@
 #include <test_progs.h>
 #include <pthread.h>
 #include <network_helpers.h>
+#include <sys/sysinfo.h>
 
 #include "timer_lockup.skel.h"
 
@@ -52,6 +53,11 @@ void test_timer_lockup(void)
 	pthread_t thrds[2];
 	void *ret;
 
+	if (get_nprocs() < 2) {
+		test__skip();
+		return;
+	}
+
 	skel = timer_lockup__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
 		return;
-- 
2.43.0




