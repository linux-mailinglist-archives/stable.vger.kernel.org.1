Return-Path: <stable+bounces-136670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46DA9C091
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C81A1BA6569
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA6233715;
	Fri, 25 Apr 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q35DK0vU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4A23370C
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568785; cv=none; b=goUK2dWKSVN88ID4d3AHBhaXUvcAXOsLEs44dEwcNGlbY2MvxFKdF8A36kjjGYNj6Bjg6HWWIOtgC0L8FseEvMhrmvLCmrHuSzZxi5QpGeHG32sbcZPtrJ6RnWbe4WnWnDKa511bniITfivWMkGCu9eNSG1imXI0ccLCKptnEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568785; c=relaxed/simple;
	bh=40gk9gK2dQiIp027AzcxwVaCixAtJngmb9rzzsojFq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N59UFJhmZ16wTXnpaOpttB8sLZnR5BsXC/KFs16Sp+cKIqgR/+j28Fv4a/MY7X0X7YV2ERorV3llZJ5LfkWqzXXSvrTg3ppbvk8Z3KYiRIq5MisezFYEzTRfpeiIlWLr6rgMShsj4ekUnw92ICulr6Zw6XGsIJxm95ttgLSKqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q35DK0vU; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-acb39c45b4eso301325566b.1
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745568781; x=1746173581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFAok9Yeg9GrCOyQxvjuyFDCQwIOLOpF0tGyByBNWO8=;
        b=Q35DK0vUbVmTGAeBr7pO6eCeAM1iTkYj3clqs8nlfMz5ga25tSjtUtqhMjB4id7sR+
         ndqhZFrYtfFLnug6Bb0/ex49GHoAM4FJxuE4UZHoTR4HmgyA7HVBz2eWbrgKO6Q6qiv6
         GpHbmEBhE398PPID/QlmsIQhha/qV0mzW+bXsT0DCjvt/8a36miDtn6GuOv94T2HxEJP
         ozs3F0I2Z2+jZ1lQ9/eHRPNKcrXYpl37HG0QGcaSuxLP0BA+vcSK/TcGmkDfkq+FHlOw
         mH9HC0T/sfbxUbGm7FcwTgi/QYIov968Zvsn2AHMPPExXQY7K6MMrEcsN6pEUm/n9rrA
         M5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568781; x=1746173581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFAok9Yeg9GrCOyQxvjuyFDCQwIOLOpF0tGyByBNWO8=;
        b=cfBhyA40KlBJbXhVqYwT5oto5/nO01sEuMgqBEr4YzsoMRlLUPz/9Imuhmlsc5vI9B
         TpkRBnb9vgNEvrh3GvWmFJmgPU5bGkQLoRtv9lkbTkzaa99MkLcTePDuVgq1PyGU/pid
         vzw1B+Ea1h/fOjY//Mjr/GjuHqJFHs1Qdcd9VSFUpqwg504F5T+joqELimxTZoaCDLAM
         SJlqob9bAnkv+PxbOJyx/BAEJRNuY7M9fSXDFs34bph53ZRq4e0fNjJAu0DXkhme/WR2
         AohjIJ+IOZOWhjOsrDgvpI4MNiisd4AvX+Cj0J1SYw8WQ84gX+XGLfwGrFrPLRkjLSsO
         J85Q==
X-Gm-Message-State: AOJu0YwlsyrgiRz2AhWqVnDdf+67pyDYefmr01S5BMySZVnPjpIfEu0z
	ylryQtI90SOSQKA/kxedN0DVwwsKtg/DeGFNzszEZDm4Ex10zzIlt06Onfh+Jjcn0DAcgPlzpNf
	qiR7q6g==
X-Gm-Gg: ASbGncvJQboK2HGHgw52fFwwoE28gjfBA0ac6o3gdH/Eh7mOs1d+fC5nIQcPf/TKeK4
	rzy1N0GRMCWjImcxgQwOsVA9RgzjJ1eHayDHyiHmAAfsNbgk2Zcbd7m1iNM+iz8rc13JkCkOAHN
	EGXHjPfiRtT5F2hQJ0BkwYfjFidu+5ILMRnWNsWlktQuayloqlP8l8SdgEpSt1wG7rMIq+ZHuUh
	t/0bgwhbL1L1E0cnZwhtgtSx1PX78xCfrZqi5Kv056Q1binTTtH0O0mYyzX8+7mwcQSRTtgfqSM
	czJJQ3IGH9+pAvaJEurmlFvm42QrtZ4OtSaIjqKPtF5xEVwj/4w30A==
X-Google-Smtp-Source: AGHT+IFSEOFuW7a9NpjHB6rH8IqR3wtV52+0GaCv/9dJhhXaARx6FE0TjSLjuieKIkSnT0Tod4rXCQ==
X-Received: by 2002:a17:907:d90:b0:acb:ac79:12fe with SMTP id a640c23a62f3a-ace73b46296mr103911866b.50.1745568780911;
        Fri, 25 Apr 2025 01:13:00 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:c147:7e8d:44fa:c193:53fc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db4d76d56sm26505505ad.4.2025.04.25.01.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:13:00 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 3/4] selftests/bpf: check program redirect in xdp_cpumap_attach
Date: Fri, 25 Apr 2025 16:12:36 +0800
Message-ID: <20250425081238.60710-4-shung-hsi.yu@suse.com>
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

commit d124d984c8a2d677e1cea6740a01ccdd0371a38d upstream.

xdp_cpumap_attach, in its current form, only checks that an xdp cpumap
program can be executed, but not that it performs correctly the cpu
redirect as configured by userspace (bpf_prog_test_run_opts will return
success even if the redirect program returns an error)

Add a check to ensure that the program performs the configured redirect
as well. The check is based on a global variable incremented by a
chained program executed only if the redirect program properly executes.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Link: https://lore.kernel.org/r/20241009-convert_xdp_tests-v3-3-51cea913710c@bootlin.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c   | 5 ++++-
 .../selftests/bpf/progs/test_xdp_with_cpumap_helpers.c       | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index 88e8a886d1e6..c7f74f068e78 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -62,8 +62,11 @@ static void test_xdp_with_cpumap_helpers(void)
 	err = bpf_prog_test_run_opts(prog_redir_fd, &opts);
 	ASSERT_OK(err, "XDP test run");
 
-	/* wait for the packets to be flushed */
+	/* wait for the packets to be flushed, then check that redirect has been
+	 * performed
+	 */
 	kern_sync_rcu();
+	ASSERT_NEQ(skel->bss->redirect_count, 0, "redirected packets");
 
 	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
 	ASSERT_OK(err, "XDP program detach");
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
index d848fe96924e..3619239b01b7 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
@@ -12,6 +12,8 @@ struct {
 	__uint(max_entries, 4);
 } cpu_map SEC(".maps");
 
+__u32 redirect_count = 0;
+
 SEC("xdp")
 int xdp_redir_prog(struct xdp_md *ctx)
 {
@@ -27,6 +29,9 @@ int xdp_dummy_prog(struct xdp_md *ctx)
 SEC("xdp/cpumap")
 int xdp_dummy_cm(struct xdp_md *ctx)
 {
+	if (bpf_get_smp_processor_id() == 0)
+		redirect_count++;
+
 	if (ctx->ingress_ifindex == IFINDEX_LO)
 		return XDP_DROP;
 
-- 
2.49.0


