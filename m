Return-Path: <stable+bounces-15746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F583B5F5
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156CD1F22C52
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD37EC;
	Thu, 25 Jan 2024 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNm4hltR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98E0385
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141789; cv=none; b=JfKf1rJ23lfCEXltPBN2VAZW6AFMV1o7LtDq9AWsixKaKHc7/aNa8cnZBw20l37UXkjy8pa6fkldYNNh/hhvZiSNSN8CMx08ApB07y/HEwZxoTsCejsQL7XR1G0l4IIfY0iiSFG9duDgOBzPG9WXMd6VOsf/jZNOO5bkAkl6ZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141789; c=relaxed/simple;
	bh=XBSTAuCXvQW9FKKRRzWvWrkyiN4uqlykfiu36laxvqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cidzysqQg+K69D9KB9sidtd6Y/j9IKyvUEvXcrYnoCG46GTEbbJLEa6Q/SrQRI5Yg2wvz1Gu0epk2CqawKIlYfIZtE9H4KJ0Dr8wGEglXG81gbjCRN01iXUK9hmBxuvHo7SNXIk6xhnxE6EL7P36jKPnVoZ5NG+raznOibN/ewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNm4hltR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a27733ae1dfso638035266b.3
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141786; x=1706746586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaKFmsdqDV0f008BlYor5dxmGncEGRrA01Y8ur8OwfQ=;
        b=SNm4hltRVOZo+JqCTkfYzaX8NdMBgGMcKFRpE5t3Fmn+9KUBM6dvKV+cG71s31wm5s
         OL7rd58BJgYyE5cDKBmS/0pQQ91S+uxAp6P8OA+L38PeglzSIIv2pqFoDffxjuVhza+X
         flVnZ0+Cfv/CQmgoUJgq6W4LhRAB0+NgKCan9vEhPVVGLinpX2LsRKZrn6wdSJuWwU0f
         Pdy7BGLHYcC9iaGZEblr6c0I6d54KRk0Jkmf+eo2Xg7kGA+2Y/IOcqJfa8YEEcFNSctw
         2V0QY0k9FwWU3Gn/y+eWa+Ht16jings+jQbmpTW5dYy8x8JTNkRctbV+LqOEW7fcXAcr
         VYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141786; x=1706746586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaKFmsdqDV0f008BlYor5dxmGncEGRrA01Y8ur8OwfQ=;
        b=uuNyTQgY56/zUZJThkvdfu/OGHqwYhVBZ3gv0YKRAcxoXUo7BJVF5vAsR+cR5qgEZ1
         pbhNln4j98Jvbqg8ymfeGNhMgbUNE1ZLaUSxT6LdAXN4hVeKKyqAf5qwfhQruUqcpOiT
         Jeq4DexZwWmofaM6eM6H+GUZtjXll1jo1vrTKfpoc9+GFMmVVDeqKZ7OQ03bFQg29ztN
         Lu5tBvaTZ8exsQx5x5C3lxa95eEbyW3l40kl844gC1P+2I4FRUgMOesAfe7XSVF3Zhc+
         Z3bbyUyXt6gxTygG3gIOovlvov8Z3HDzSOGHebl64K01TH7iNnJzUk+W/uoxLwzR84au
         Poqw==
X-Gm-Message-State: AOJu0YzbvpofBf0mUjPzKQyQ9AhPMhlbrO3IHFhWtxfTh0WPGVLSPZqV
	d8cA7EoLHIElkZoMCs23XkwuK8yAR21vyjkK5xwZzC9zKPzsSCjmDlUGGKHR
X-Google-Smtp-Source: AGHT+IHlypdWfkyrOZQ31oB6OBiRXLFoUVxRcNDu7Z0UV+mnb0mRjejVNg6QAebHiHxMXzB7mpVM5A==
X-Received: by 2002:a17:907:6d1a:b0:a31:6993:bd3e with SMTP id sa26-20020a1709076d1a00b00a316993bd3emr36209ejc.201.1706141785675;
        Wed, 24 Jan 2024 16:16:25 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:25 -0800 (PST)
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
Subject: [PATCH 6.6.y 06/17] selftests/bpf: test if state loops are detected in a tricky case
Date: Thu, 25 Jan 2024 02:15:43 +0200
Message-ID: <20240125001554.25287-7-eddyz87@gmail.com>
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

[ Upstream commit 64870feebecb ]

A convoluted test case for iterators convergence logic that
demonstrates that states with branch count equal to 0 might still be
a part of not completely explored loop.

E.g. consider the following state diagram:

               initial     Here state 'succ' was processed first,
                 |         it was eventually tracked to produce a
                 V         state identical to 'hdr'.
    .---------> hdr        All branches from 'succ' had been explored
    |            |         and thus 'succ' has its .branches == 0.
    |            V
    |    .------...        Suppose states 'cur' and 'succ' correspond
    |    |       |         to the same instruction + callsites.
    |    V       V         In such case it is necessary to check
    |   ...     ...        whether 'succ' and 'cur' are identical.
    |    |       |         If 'succ' and 'cur' are a part of the same loop
    |    V       V         they have to be compared exactly.
    |   succ <- cur
    |    |
    |    V
    |   ...
    |    |
    '----'

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231024000917.12153-7-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 177 ++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 764a68420c3e..c20c4e38b71c 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -998,6 +998,183 @@ __naked int loop_state_deps1(void)
 	);
 }
 
+SEC("?raw_tp")
+__failure
+__msg("math between fp pointer and register with unbounded")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked int loop_state_deps2(void)
+{
+	/* This is equivalent to C program below.
+	 *
+	 * The case turns out to be tricky in a sense that:
+	 * - states with read+precise mark on c are explored only on a second
+	 *   iteration of the first inner loop and in a state which is pushed to
+	 *   states stack first.
+	 * - states with c=-25 are explored only on a second iteration of the
+	 *   second inner loop and in a state which is pushed to states stack
+	 *   first.
+	 *
+	 * Depending on the details of iterator convergence logic
+	 * verifier might stop states traversal too early and miss
+	 * unsafe c=-25 memory access.
+	 *
+	 *   j = iter_new();             // fp[-16]
+	 *   a = 0;                      // r6
+	 *   b = 0;                      // r7
+	 *   c = -24;                    // r8
+	 *   while (iter_next(j)) {
+	 *     i = iter_new();           // fp[-8]
+	 *     a = 0;                    // r6
+	 *     b = 0;                    // r7
+	 *     while (iter_next(i)) {
+	 *       if (a == 1) {
+	 *         a = 0;
+	 *         b = 1;
+	 *       } else if (a == 0) {
+	 *         a = 1;
+	 *         if (random() == 42)
+	 *           continue;
+	 *         if (b == 1) {
+	 *           *(r10 + c) = 7;     // this is not safe
+	 *           iter_destroy(i);
+	 *           iter_destroy(j);
+	 *           return;
+	 *         }
+	 *       }
+	 *     }
+	 *     iter_destroy(i);
+	 *     i = iter_new();           // fp[-8]
+	 *     a = 0;                    // r6
+	 *     b = 0;                    // r7
+	 *     while (iter_next(i)) {
+	 *       if (a == 1) {
+	 *         a = 0;
+	 *         b = 1;
+	 *       } else if (a == 0) {
+	 *         a = 1;
+	 *         if (random() == 42)
+	 *           continue;
+	 *         if (b == 1) {
+	 *           a = 0;
+	 *           c = -25;
+	 *         }
+	 *       }
+	 *     }
+	 *     iter_destroy(i);
+	 *   }
+	 *   iter_destroy(j);
+	 *   return;
+	 */
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -16;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = 0;"
+		"r7 = 0;"
+		"r8 = -24;"
+	"j_loop_%=:"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto j_loop_end_%=;"
+
+		/* first inner loop */
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = 0;"
+		"r7 = 0;"
+	"i_loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto i_loop_end_%=;"
+	"check_one_r6_%=:"
+		"if r6 != 1 goto check_zero_r6_%=;"
+		"r6 = 0;"
+		"r7 = 1;"
+		"goto i_loop_%=;"
+	"check_zero_r6_%=:"
+		"if r6 != 0 goto i_loop_%=;"
+		"r6 = 1;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 42 goto check_one_r7_%=;"
+		"goto i_loop_%=;"
+	"check_one_r7_%=:"
+		"if r7 != 1 goto i_loop_%=;"
+		"r0 = r10;"
+		"r0 += r8;"
+		"r1 = 7;"
+		"*(u64 *)(r0 + 0) = r1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+	"i_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+
+		/* second inner loop */
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = 0;"
+		"r7 = 0;"
+	"i2_loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto i2_loop_end_%=;"
+	"check2_one_r6_%=:"
+		"if r6 != 1 goto check2_zero_r6_%=;"
+		"r6 = 0;"
+		"r7 = 1;"
+		"goto i2_loop_%=;"
+	"check2_zero_r6_%=:"
+		"if r6 != 0 goto i2_loop_%=;"
+		"r6 = 1;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 42 goto check2_one_r7_%=;"
+		"goto i2_loop_%=;"
+	"check2_one_r7_%=:"
+		"if r7 != 1 goto i2_loop_%=;"
+		"r6 = 0;"
+		"r8 = -25;"
+		"goto i2_loop_%=;"
+	"i2_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+
+		"r6 = 0;"
+		"r7 = 0;"
+		"goto j_loop_%=;"
+	"j_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_all
+	);
+}
+
 SEC("?raw_tp")
 __success
 __naked int triple_continue(void)
-- 
2.43.0


