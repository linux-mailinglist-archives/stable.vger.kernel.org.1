Return-Path: <stable+bounces-163230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2094B087A3
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4761642C1
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 08:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29749263899;
	Thu, 17 Jul 2025 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U2Ra1GX6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1469218AB0
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739791; cv=none; b=L9SbkiYHSvpQGJpd3BSLqvkQmC7vVAJFG/JaK0gp4iCECl7L6L/tIVKbhMySn8Kz8D17YM+9SzH5i5xs7arh9PRMmmcz5BD4gcQS4C8YaGOb/8ZpGO8uGWMKEJ6ACfK77rkqbw1JzUScLBFM30KlWRHEYB4d9Bm6noRXkEBjUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739791; c=relaxed/simple;
	bh=l5gOqLJveM7q9X+rjlW61hfv24++A7WESPvOUeY6/AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXmnOTIh8VrSLqvBYy98PM2paSUVkhSGFUJJ2Zhdr69cUT7njCLi26csT2wsJP/X0zLKEPo1bJyB+Dy8eHw3PENbvFJ5GKAqSlFMf3wA6ZohfXii8NEY+qM9kTvPJtIkS4mkmuYOo+GaAyleXe9bsQSlXju+eUKtdef1YTaeDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U2Ra1GX6; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso295737f8f.0
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752739788; x=1753344588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fee0lh7NVHpbHeVA2Xk6kWSCcpEju6DFK/mt36YvQ+c=;
        b=U2Ra1GX6EW5jBtZ0cWzDWJWyGDiml92y3d1XuA93seW+Ees+UtpmV9lLqIw7PlH5X/
         PHjS92ssLVQSM44GGmrV9h1VqgngRZC4mOyv0IjBDtJOScQt0f36DcHgMZnbEjrABoIz
         Bocj9zDNYNRQfh2e4COgqZFXn6PtoReIY+UZOeDsxJOGuSxgBc9NtkyJioGCqvmVUWEA
         gCzBc84qbDqpJJvq0OAWre6FCFuxcuEoeiQBi/LjetkwgKSLnbsPZt9M69VISYzrUbuy
         UFt4KCs7pvrvyWI3NrCtXOo6BaAAXhO89dc2VXCGmBVtsxA/Zrsr8b4gjPWa4dHP43J+
         QNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739788; x=1753344588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fee0lh7NVHpbHeVA2Xk6kWSCcpEju6DFK/mt36YvQ+c=;
        b=txtba8su+KhD4XiPySmBh6G5BqlujT/V1uIVo7YFVWk69Eyi3DhQT6ktQ5E7G2h+6k
         a8s7LzwrnK7/Zovn+M1BQdeI4Yx14rg9ClPcS+z9irfsA6wLECpvrDTfU+sDEXUOKecw
         3tJn8ExIV1FbgQWqeQnYpBHqI7WybYw8EqBjxKA8A2cZdpr7GnYzhYLReFKEXDpEX//Z
         hXpKJIchDXm9lXn74tfiSIWmkAOL+E2GuqI8x7+uXQVq+05dI7JoFH3+XOf3x9KrQ+RV
         53J+3awJ8OBKe2XL706s06N0Hixt35qWkINZgaAY1GbOIgF3gPlkc1UczC+35ishM3iV
         FFxg==
X-Gm-Message-State: AOJu0YynN+ABHJniVoz5wfws9pJmlf5Py3M3PrFPt8OEekpWLzdsKpXt
	+iO4HR6cY/Aspqj/gWeduLszwAp8UwGa1dJAvBSMdKZRPD+aMK4/luVDCtxfGvqtOrEn9dDDDzY
	7swNseQ+0/Q==
X-Gm-Gg: ASbGncsOlo0i2u9IGpnbRphoDuNnXPssevvHliGKlLQ/KpOxvTUaaK72aBgrGNWbHZ4
	3b6P/OIVtk+PybH7Fsf8CKpmLjy6fCo0M/grwDWpiXbC8LT+bqu3JhUI/J7Ai3JUCrK3PNQFmYi
	kJ4ORx/WHFLtfCIZhGgA5pxQqSTOvuYT5lIUu69uG0MjoL2nAz6PIGfqDoucurr1W5QvfbiQvMr
	9Ym22YBk4zKy1OIb14xhXw+h91WaR6C2eV5yFlBZAPwasQkimiiHr+ZfOMbO9l4OsYGTPgxg8gi
	+T9fUbwQXpLjGsiSltNc4yoSwCwPJIBNLUhh+zFvy7gvJPRMEesfbteHOUqnYJH2z7OmcPw2tGD
	htp/pXV7GD4h+2O3zqH+cTcx9
X-Google-Smtp-Source: AGHT+IEKsnqK8xl7BJFLuCaXTLO+RzdbmT4kBQ8XCWTxVBzr7boAMDlbwHzxX4ZClJb3J3F7x5hUkQ==
X-Received: by 2002:a05:6000:290d:b0:3a5:52cc:346e with SMTP id ffacd0b85a97d-3b613e5f68amr1229023f8f.6.1752739787791;
        Thu, 17 Jul 2025 01:09:47 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:365f:22a6:ee13:ef7f:1e74])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de428663esm135511055ad.15.2025.07.17.01.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:09:47 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 2/2] Revert "selftests/bpf: dummy_st_ops should reject 0 for non-nullable params"
Date: Thu, 17 Jul 2025 16:09:25 +0800
Message-ID: <20250717080928.221475-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717080928.221475-1-shung-hsi.yu@suse.com>
References: <20250717080928.221475-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e7d193073a223663612301c659e53795b991ca89.

The dummy_st_ops/dummy_sleepable_reject_null test requires commit 980ca8ceeae6
("bpf: check bpf_dummy_struct_ops program params for test runs"), which in turn
depends on "Support PTR_MAYBE_NULL for struct_ops arguments" series (see link
below), neither are backported to stable 6.6.

Link: https://lore.kernel.org/all/20240209023750.1153905-1-thinker.li@gmail.com/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 27 -------------------
 1 file changed, 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index d3d94596ab79..dd926c00f414 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -147,31 +147,6 @@ static void test_dummy_sleepable(void)
 	dummy_st_ops_success__destroy(skel);
 }
 
-/* dummy_st_ops.test_sleepable() parameter is not marked as nullable,
- * thus bpf_prog_test_run_opts() below should be rejected as it tries
- * to pass NULL for this parameter.
- */
-static void test_dummy_sleepable_reject_null(void)
-{
-	__u64 args[1] = {0};
-	LIBBPF_OPTS(bpf_test_run_opts, attr,
-		.ctx_in = args,
-		.ctx_size_in = sizeof(args),
-	);
-	struct dummy_st_ops_success *skel;
-	int fd, err;
-
-	skel = dummy_st_ops_success__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
-		return;
-
-	fd = bpf_program__fd(skel->progs.test_sleepable);
-	err = bpf_prog_test_run_opts(fd, &attr);
-	ASSERT_EQ(err, -EINVAL, "test_run");
-
-	dummy_st_ops_success__destroy(skel);
-}
-
 void test_dummy_st_ops(void)
 {
 	if (test__start_subtest("dummy_st_ops_attach"))
@@ -184,8 +159,6 @@ void test_dummy_st_ops(void)
 		test_dummy_multiple_args();
 	if (test__start_subtest("dummy_sleepable"))
 		test_dummy_sleepable();
-	if (test__start_subtest("dummy_sleepable_reject_null"))
-		test_dummy_sleepable_reject_null();
 
 	RUN_TESTS(dummy_st_ops_fail);
 }
-- 
2.50.1


