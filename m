Return-Path: <stable+bounces-136669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A28A9C094
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291147B30D5
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63EB233712;
	Fri, 25 Apr 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FiKmdExB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C323370C
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568781; cv=none; b=Gc9gNPVhDz0uHzmdnQSWELvdo+Fk8UBG9whosScnM+0Ai17d3bC5kfU7wS4EA+/i036WnACz2SUVBNmko2gpZW2iXvBQ34MeAzyPKPDrHIwUNIZl40CbteNE/SWAzTp3/oBBVw12OMcEbgnxYMvpzPnQowimY/+2m3ES7Sap25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568781; c=relaxed/simple;
	bh=D4gKk7mTGysx+hJDqguq3xl4kLEd/N8mWJWPqcDOXic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tu277sc6aQtHTalbsUSAMfthqn0awR2MXkt4lMhpCgGObyjDEr8qovmvnTmHgDRWWUhfZxRf50kXZG1P64D5wWIPnC3ppJ8zsleQ/bLV5K+gumYJqUnaTNLcU20S9o39S9sasgSyrCPmbyZ3A0jgdkIGE5Rv9dpzQWSzZBVbAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FiKmdExB; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso2073751f8f.0
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745568777; x=1746173577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltU84CwaqVWm5s8+q0VdsYg2VsV4ega7337dxe3KA5g=;
        b=FiKmdExBulPeig5KcAyzFa1ive1ay1W6UECBM0y35ZfN/vfDLFln9JUTWT1j0fr2r8
         J5Y7Afa1/SmK5B4dQii65ItMdrrPUUPUduts9oV0nJouTy8uN8xGywm6IBpkfH2OpRci
         c2CsNvSMJbxoVYra6u+WfZyfu6DKhq8yhYz4NmJ+O5pVe4XJAABMQ3G9r27X0TqNWEpM
         /PKoxLG9HjUSmrEdAKmVQ6U65A6JoCBUItb0F2XUkrhb1vGpfnCxu7glFAcRRYF/dJqY
         WsHyZm4HsiCbYUnfgX412hIHb8V1NwnrSl7SwSu9WD4+mSKk7KWvsDr4YUt+P31QgL/Q
         SfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568777; x=1746173577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltU84CwaqVWm5s8+q0VdsYg2VsV4ega7337dxe3KA5g=;
        b=vpHkpBt86lLRjzuQ0WeVaCinIfh1Awvp9Jp2E8ohJje2La7wR4Nfvb7fL77PDKRq+7
         8kZ1ZMA55Sx6sk8FPWZ6eMgSMuyJBVdenHr8oSx7UL5W1E8tAIQ3Tx0gkvTdRP8ZqpBK
         FKJUfz+KkIJ/BpFs0fsyzizOPCWPVuI2iB+eg0OYdQpPxRDn3P6/hQBA1twX0dxVOOtH
         ZrRXsrs6UmMrDhg4JZUsBx/pl2wbyC27xtGTjnWEi7ceJ3uG8npzJvQwooaLIHisjnuQ
         Ds6qjgvaByXjo1ZKlvfWZ1KJwVS55w7b6gq9iD4vxu61Frx89hzERXu/qfw5w9VbUCOR
         kM5Q==
X-Gm-Message-State: AOJu0YxGREq0UNyeWkhd9tnknh4W8R+G/bl4n0rcN7yuaFxMpgSIb2yW
	03MJkcRel5apN7N6QgzLSBLEEfQdEgAjukTBtn7ErSoy2X8olgXS63eGR7Dx6t+Y1d3aTyCvXC7
	9uH0Aeg==
X-Gm-Gg: ASbGncsMsmp9kLyOuSWrqQUYiLRJRG4chGGhki40JMtkJkys7s/oxygjlK51i7EXjrG
	4lu0yMtSwPUT3vMaHc7qvcZiYIv51vMIcYpB9KyW0aN+R50536urc6DG5FjSvEX+j4mqmnlZDQ8
	mDll+YWF8O7OgtvsAdua18pBkqAtznhAwxmyb4D/QYJyJN65XSUPCvGWXXhCMb6CsR8120sNk5o
	dGgJPrBkmCl3KzEsq2S9a+ECjLQrySfxsz+tuTN5tW8wQcaS6bLrVE3wNq4ZAqNmYgvUH4MwvRK
	z4XOFIHgFszyMVRvL+wcLbqjkTLxf9uJB4e18xNXuX8jUJaO7WaqYw==
X-Google-Smtp-Source: AGHT+IGwm5a6mioDht2IYWb/mMdqwfliVdSxK/Dwo72wJW8lQl5isY9RuCXUt5gLrnd7DBTn+wp4cg==
X-Received: by 2002:a5d:5f44:0:b0:39c:1f0e:95af with SMTP id ffacd0b85a97d-3a074e1431amr980523f8f.3.1745568776927;
        Fri, 25 Apr 2025 01:12:56 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:c147:7e8d:44fa:c193:53fc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73e25a6b462sm2601962b3a.114.2025.04.25.01.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:12:56 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 2/4] selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
Date: Fri, 25 Apr 2025 16:12:35 +0800
Message-ID: <20250425081238.60710-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425081238.60710-1-shung-hsi.yu@suse.com>
References: <20250425081238.60710-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

commit d5fbcf46ee82574aee443423f3e4132d1154372b upstream.

Current test only checks attach/detach on cpu map type program, and so
does not check that it can be properly executed, neither that it
redirects correctly.

Update the existing test to extend its coverage:
- keep the redirected program loaded
- try to execute it through bpf_prog_test_run_opts with some dummy
  context

While at it, bring the following minor improvements:
- isolate test interface in its own namespace

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Link: https://lore.kernel.org/r/20241009-convert_xdp_tests-v3-2-51cea913710c@bootlin.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: c7f2188d68c1 ("selftests/bpf: Adjust data size to have ETH_HLEN")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/xdp_cpumap_attach.c        | 41 +++++++++++++++----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index 481626a875d1..88e8a886d1e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -2,35 +2,41 @@
 #include <uapi/linux/bpf.h>
 #include <linux/if_link.h>
 #include <test_progs.h>
+#include <network_helpers.h>
 
 #include "test_xdp_with_cpumap_frags_helpers.skel.h"
 #include "test_xdp_with_cpumap_helpers.skel.h"
 
 #define IFINDEX_LO	1
+#define TEST_NS "cpu_attach_ns"
 
 static void test_xdp_with_cpumap_helpers(void)
 {
-	struct test_xdp_with_cpumap_helpers *skel;
+	struct test_xdp_with_cpumap_helpers *skel = NULL;
 	struct bpf_prog_info info = {};
 	__u32 len = sizeof(info);
 	struct bpf_cpumap_val val = {
 		.qsize = 192,
 	};
-	int err, prog_fd, map_fd;
+	int err, prog_fd, prog_redir_fd, map_fd;
+	struct nstoken *nstoken = NULL;
 	__u32 idx = 0;
 
+	SYS(out_close, "ip netns add %s", TEST_NS);
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto out_close;
+	SYS(out_close, "ip link set dev lo up");
+
 	skel = test_xdp_with_cpumap_helpers__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_xdp_with_cpumap_helpers__open_and_load"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
-	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
+	prog_redir_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_redir_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_OK(err, "Generic attach of program with 8-byte CPUMAP"))
 		goto out_close;
 
-	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
-	ASSERT_OK(err, "XDP program detach");
-
 	prog_fd = bpf_program__fd(skel->progs.xdp_dummy_cm);
 	map_fd = bpf_map__fd(skel->maps.cpu_map);
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
@@ -45,6 +51,23 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_OK(err, "Read cpumap entry");
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
 
+	/* send a packet to trigger any potential bugs in there */
+	char data[10] = {};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = 10,
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = 1,
+		);
+	err = bpf_prog_test_run_opts(prog_redir_fd, &opts);
+	ASSERT_OK(err, "XDP test run");
+
+	/* wait for the packets to be flushed */
+	kern_sync_rcu();
+
+	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
+	ASSERT_OK(err, "XDP program detach");
+
 	/* can not attach BPF_XDP_CPUMAP program to a device */
 	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_CPUMAP program"))
@@ -65,6 +88,8 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_NEQ(err, 0, "Add BPF_XDP program with frags to cpumap entry");
 
 out_close:
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del %s", TEST_NS);
 	test_xdp_with_cpumap_helpers__destroy(skel);
 }
 
@@ -111,7 +136,7 @@ static void test_xdp_with_cpumap_frags_helpers(void)
 	test_xdp_with_cpumap_frags_helpers__destroy(skel);
 }
 
-void serial_test_xdp_cpumap_attach(void)
+void test_xdp_cpumap_attach(void)
 {
 	if (test__start_subtest("CPUMAP with programs in entries"))
 		test_xdp_with_cpumap_helpers();
-- 
2.49.0


