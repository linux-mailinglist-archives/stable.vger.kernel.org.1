Return-Path: <stable+bounces-136671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E1A9C095
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843337B5A28
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D5233721;
	Fri, 25 Apr 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VYV9VHM2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916E233707
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568789; cv=none; b=jRUkqAHKCSS6wEnT/whq4c/SPwQEjLK6+6brxhnyArTy1VIugJHae1FQ1K1mRvBncyYTym5OZxenpxBF0y2P3UHWBQdzGiMKZE/+HkfWIX1/cbbInaA1txxZowXZt4jBp1ypd3nzFTye2xPRcA5zuJWv0XM18AcFQw6amHG0eJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568789; c=relaxed/simple;
	bh=PX5+hMjL6JFY2CB0grbOkNluLYXcc5ra5dXrMth3tI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGu15e2nSPvS7ldjLC+/4GMSpl/iibDYxbso6heFUf8sVvxCkH760mIFCYMsTz/hKh1kSj7dik+NA3/8ATGT+CajUXlFyDM/aha0soZqRo0ueVwwrgwUVItOIWYh44+RUv5YZGLSdZmQcAH8zYsJyM+D17G20xD/eHJzYWvWGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VYV9VHM2; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1027166f8f.3
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745568785; x=1746173585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpmlVk4S2kZA2YlljJHCMOFf0Bpmxu4MUA5l8tTP26U=;
        b=VYV9VHM29SrX0TPubPgaw/W/+kxj41tMS8Ghm9IjcqW4/u91u1fC7BtEgMUKFdQD2r
         +N85RulC0vZK+Bm+Ps0uYUFyxwOyuv63j/E41Yx/Qnev7Siq8LDMq1W1Kar5mOayyYDo
         IjDeqw0hAYHACE+/wafTya9WonFoKHzrajwHZBTujAsPpxeNE3iI825mKA+k+T2DKmeJ
         bwSymAEfLp0rNT1EMWzU3gCaaKCGK9uhy53hBUumkrOgufz65R5FGna+hrlyYTRDQbcf
         hZQ+tzBMc5bj0lTFASiC65D3xMikMxZYLh2JqF4g4GTRQxyH2f58BnbunAq8CQiM29yy
         YbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568785; x=1746173585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpmlVk4S2kZA2YlljJHCMOFf0Bpmxu4MUA5l8tTP26U=;
        b=DljuZzRJvySxdoPFwDoiniD2etXb9O5nrA6Uc7EuUv76v2DweELrT5SjDwpx3+oheS
         x7NMmZOCcGkOa8c4SzWdSPKT9wCT40w3G7bsuatrN2YZZYm+eBT3gFp9Ml41CIjQ0Pay
         cbm0o//DjSc+DkxHp6VxNg+ZLGxEho2czY0OPSTe63tVFGiSyALGFBHbBlT2rttb+B2j
         B/v2w4BIe1i6hyASA7EPKfrGGBZ6zCcfadTN+uvWJ/Io2d4Z2AfLVpCUPnzWYIP8ChMM
         yj+A+9SpbMN8C1oERhGVQibLEiSFsYQLxH/4ZH8fUtJmSmUOMcGp4Nnf5pQ81w+RlTeb
         VhSw==
X-Gm-Message-State: AOJu0YxiLIEWPpVEeM7q18QrjAJ8P1TR9h5NdQrrv3bW9maCUS4tKjLi
	jNToJg4K7tNs/1evULKawnVCwXdQjmIgPmy2bdTTumFARL+nNVoM5gRnMNKNee19y2JpM3diKDO
	ieWgYdQ==
X-Gm-Gg: ASbGncvm6FV4XQgnf+kG5hlLWkB6LROX15bgLcBCUkZBDiRm4bHTPRA84qB6CnaYYLJ
	aOt7popEHKHfhkD97cCSAHQqixB0HiaawtkTEeCUVO8vSDM+C+oKrOxYVHtRNn/Fj8CfiukHhzG
	keO3CmpGMc0wdgoKFx24691TkkhFBvMdx84Dkl0SYoFRKOot5SE+LNojzXCpXQB1qOHJ5WKr0bl
	hn00Xs/Jtk9TKA/iJ3vzBNiVIdXxAZnhLBL/7e8gG/cAmvMHtrutwauwACQ9Gns2DHFF6ENHqAg
	E6GDo78W/FlrYtG712tnv9SimriS/LW5wxcu+/jxO1o=
X-Google-Smtp-Source: AGHT+IE6M88ppm9Q6ybwBRbirCXu0PvhG7zbWamx5xGDzwZ0UdiOiw13Xy90mzYzLaNongBYmoRSRA==
X-Received: by 2002:a05:6000:248a:b0:39c:16a0:fee4 with SMTP id ffacd0b85a97d-3a074e379cdmr973070f8f.27.1745568785156;
        Fri, 25 Apr 2025 01:13:05 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:c147:7e8d:44fa:c193:53fc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73e25a9a8e7sm2592248b3a.121.2025.04.25.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:13:04 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 4/4] selftests/bpf: Adjust data size to have ETH_HLEN
Date: Fri, 25 Apr 2025 16:12:37 +0800
Message-ID: <20250425081238.60710-5-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425081238.60710-1-shung-hsi.yu@suse.com>
References: <20250425081238.60710-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shigeru Yoshida <syoshida@redhat.com>

commit c7f2188d68c114095660a950b7e880a1e5a71c8f upstream.

The function bpf_test_init() now returns an error if user_size
(.data_size_in) is less than ETH_HLEN, causing the tests to
fail. Adjust the data size to ensure it meets the requirement of
ETH_HLEN.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250121150643.671650-2-syoshida@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 972bafed67ca ("bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
 .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index c7f74f068e78..df27535995af 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
 
 	/* send a packet to trigger any potential bugs in there */
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index 27ffed17d4be..461ab18705d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -23,7 +23,7 @@ static void test_xdp_with_devmap_helpers(void)
 	__u32 len = sizeof(info);
 	int err, dm_fd, dm_fd_redir, map_fd;
 	struct nstoken *nstoken = NULL;
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	__u32 idx = 0;
 
 	SYS(out_close, "ip netns add %s", TEST_NS);
@@ -58,7 +58,7 @@ static void test_xdp_with_devmap_helpers(void)
 	/* send a packet to trigger any potential bugs in there */
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
@@ -158,7 +158,7 @@ static void test_xdp_with_devmap_helpers_veth(void)
 	struct nstoken *nstoken = NULL;
 	__u32 len = sizeof(info);
 	int err, dm_fd, dm_fd_redir, map_fd, ifindex_dst;
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	__u32 idx = 0;
 
 	SYS(out_close, "ip netns add %s", TEST_NS);
@@ -208,7 +208,7 @@ static void test_xdp_with_devmap_helpers_veth(void)
 	/* send a packet to trigger any potential bugs in there */
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
-- 
2.49.0


