Return-Path: <stable+bounces-15757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C583B600
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA941C21F66
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2097F;
	Thu, 25 Jan 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/NbRJpk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAA7FB
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141802; cv=none; b=Z8fp3G7opdvuD6GBCqKNDsfqQ67rgpmkB/8AtGFwpB4Pl0lsiGDiPqr3ST/y+bAB/DJVLL98e8vPNz95F+wxvP2rsU1iIbxPBiH1Gl/q9F/UoUkfj/cPAYWqWVNfD+YnGjOfY2KH70plvs5wZubzg7ef70dYyHjjRUSldNZhSFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141802; c=relaxed/simple;
	bh=pZGXF2d06olvPr2VuC7KErwte7ZYEyrv3VX4TKuYYHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpHQ3UVSYTcQqqX3Emd86A4hQfeNnKNqZgIKaoOvNHn6U6Z98Vq81YM7MY150+UkKw6yWkYeL3iRG6hvtdyUtYZrZTJhcz321H/DLQqrOMkKEGgwEGDVnTy9TALHtnK/l2TuNCKaDTehIFuYGen+i4MyKN4GiqGQrLnVhaTud0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/NbRJpk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so45558666b.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141799; x=1706746599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqd42+7IhdQSaHY3dRZxC9Dx0KjzaYfl82GUKX0YIFw=;
        b=h/NbRJpkWG3HJXnFCBuPCz/owKA1XfmO4THIx7kNUYrAcG30d2T6HsapRCieLwUpf8
         RqLl9NLWMmSh/zZ3wfZG80bB+B0ib7pGNSjG22EI2CjFN3chIaCYJ54m2fIEGRk56zSm
         ZGdbkf0NJcHloAPVQHw4NmGZjfexAH5Zueutf4jyTBK9XoT8KRcN13rtIcFaEvtdvCHZ
         winXP292rFbtJcgaxlgtbUOevxndT+zpM2Qtyp10pY7fOc37Z5jAs3+PsAhWDhrOye1f
         Ns0ZVrzNJYeVDJgfwIuApFvmkThVHXDoAQmRT0Taxm//UA72B1HoXMWWYBoHG2JsNi5E
         9G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141799; x=1706746599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqd42+7IhdQSaHY3dRZxC9Dx0KjzaYfl82GUKX0YIFw=;
        b=FW784MJmrARREAdQLHCNrQzBYkvK6qJiJnzxLs3n2X9EyMZQBYPp4om7YsTrcx1Y14
         Gdh+t7NHh2jbDBsIsJg+3WRuTjIQOjwQSit1YvACse2vA2LiAIliXJLQUAjA2CQVzbsD
         of0/gUTidZRl3oQC472Ii/dSU926hlYDBrAITdXhgCgF8bB+mxKbYf+R6qKgZlAzgvlp
         TUNvSjX+PBzO1aCmr/mApb97ZurlddGxVWHSIN3wLg+23WKXH0GVr7qbxlxGzFn87AQI
         Pl1o2/fqMOIEUbMCWGUWvxQONxKOzO2xdvUj2S3WnSqHGwGJKcseF52Qz5MKUWOEhCtu
         SOqg==
X-Gm-Message-State: AOJu0YzV709fcn8yFedOZzGnaV+5DRnafiO5ctFtKdrTC+gNJ3STTeM3
	cR3GImLSRvTrD9O7FQ8RUpkPzD6erpHRQi5NvTu4dIlWDW+jETKFjrk7ziHR
X-Google-Smtp-Source: AGHT+IHCGynLUhFz6FZbyQOd18Fuu5fdXj1NouTvdp+XTOv+QFa1iA73WR4ZsBmF+V8TajX94L/H5Q==
X-Received: by 2002:a17:906:b814:b0:a2d:9b73:d81d with SMTP id dv20-20020a170906b81400b00a2d9b73d81dmr118609ejb.48.1706141799100;
        Wed, 24 Jan 2024 16:16:39 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:38 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.6.y 17/17] selftests/bpf: check if max number of bpf_loop iterations is tracked
Date: Thu, 25 Jan 2024 02:15:54 +0200
Message-ID: <20240125001554.25287-18-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 57e2a52deeb1 ]

Check that even if bpf_loop() callback simulation does not converge to
a specific state, verification could proceed via "brute force"
simulation of maximal number of callback calls.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-12-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 598c1e984b26..5905e036e0ea 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -164,4 +164,79 @@ int unsafe_find_vma(void *unused)
 	return choice_arr[loop_ctx.i];
 }
 
+static int iter_limit_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i++;
+	return 0;
+}
+
+SEC("?raw_tp")
+__success
+int bpf_loop_iter_limit_ok(void *unused)
+{
+	struct num_context ctx = { .i = 0 };
+
+	bpf_loop(1, iter_limit_cb, &ctx, 0);
+	return choice_arr[ctx.i];
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=2 size=1")
+int bpf_loop_iter_limit_overflow(void *unused)
+{
+	struct num_context ctx = { .i = 0 };
+
+	bpf_loop(2, iter_limit_cb, &ctx, 0);
+	return choice_arr[ctx.i];
+}
+
+static int iter_limit_level2a_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i += 100;
+	return 0;
+}
+
+static int iter_limit_level2b_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i += 10;
+	return 0;
+}
+
+static int iter_limit_level1_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i += 1;
+	bpf_loop(1, iter_limit_level2a_cb, ctx, 0);
+	bpf_loop(1, iter_limit_level2b_cb, ctx, 0);
+	return 0;
+}
+
+/* Check that path visiting every callback function once had been
+ * reached by verifier. Variables 'ctx{1,2}i' below serve as flags,
+ * with each decimal digit corresponding to a callback visit marker.
+ */
+SEC("socket")
+__success __retval(111111)
+int bpf_loop_iter_limit_nested(void *unused)
+{
+	struct num_context ctx1 = { .i = 0 };
+	struct num_context ctx2 = { .i = 0 };
+	__u64 a, b, c;
+
+	bpf_loop(1, iter_limit_level1_cb, &ctx1, 0);
+	bpf_loop(1, iter_limit_level1_cb, &ctx2, 0);
+	a = ctx1.i;
+	b = ctx2.i;
+	/* Force 'ctx1.i' and 'ctx2.i' precise. */
+	c = choice_arr[(a + b) % 2];
+	/* This makes 'c' zero, but neither clang nor verifier know it. */
+	c /= 10;
+	/* Make sure that verifier does not visit 'impossible' states:
+	 * enumerate all possible callback visit masks.
+	 */
+	if (a != 0 && a != 1 && a != 11 && a != 101 && a != 111 &&
+	    b != 0 && b != 1 && b != 11 && b != 101 && b != 111)
+		asm volatile ("r0 /= 0;" ::: "r0");
+	return 1000 * a + b + c;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


