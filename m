Return-Path: <stable+bounces-104442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9749F451B
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8FC7A075B
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F72199FAB;
	Tue, 17 Dec 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F9x3ZSud"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051771990CD
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420520; cv=none; b=Xkm+5YQLcktpnfyAGY/iYVqmb26e3t6EjMdhxClfkwsVXW//rQRLkfo41held9JToewteNudZOLr9Rf/CSzhroP46mohRpnO4ddvCjlldavm/pg7GhBG0XG74BElhT021/qztIsn6kmnHkJgXNsTrh3P+L7K1tk3UZl2euXML0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420520; c=relaxed/simple;
	bh=+TKS3NVPljJZT0YQ0HSB2OQOlOecACVdfwNyo9KfiL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz4xsI9ecpSdggIsfJ4GK2Z3tFhrE/ojiO79bx6/C6sTsxngaCNSvd/vRKDvXXsZY91ykjmNN1ynwdKbD2U7YfkF/WOXRXpowTmVL8FX+wutvagrA9OlFwtzWgBhHVKxzmfQUHP+96AcM0BtguRdXORHP5T7webZ6GGgF8Ck91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F9x3ZSud; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso12039265e9.0
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 23:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734420516; x=1735025316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWnGZO1aGIQzUaYGqvaR6u8SQ+iRAndoXda7Dlxvtqc=;
        b=F9x3ZSudy5s51vvzkqSG4KSesZaU9Kgaoy6XglyO5RGjyDHjpt5eL3g+KpE3kPPhBE
         +BJpY791KGyscUR/lEn/6Mt/p9O6MhsyGt5PUccWLS9ig8My7O3Et6Jzfibt6TLYhzxq
         ecJZx9e8oke3G2IqUU7g4zSuga0TWwobyFCd+5izrgKfEhd0dfzBErL0Ph/5xbWXHz9B
         KGj8RydSfOfyvFmTuiXpUAPBDyd2QsnVRx9JnFAcjg/m28Pv3Z3UqMFsLaf6/xtff37M
         pNr7ASX4uUklXCpsv2Wel/QdY0JpEjPGtm2T/J3gkZwGRP30QELEaAmAxo36XCEiY3/n
         +oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734420516; x=1735025316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWnGZO1aGIQzUaYGqvaR6u8SQ+iRAndoXda7Dlxvtqc=;
        b=F5tPkZaoG187NnNnyx8DqR2FKOAwujxnXVnqRdFGQcIb9ePujYlK+lt6xvlNV5rECQ
         5KJ/wO3sxDZLxdaNdY0bV2B6WivPEp60l9p7yZInA0gH0rncdAi6YmqlJhlRRQqX496F
         EjPNvVUYR3/1h6VLmFWgue+5KZAYECYqQRGOiBPc1LqpjD6TZl5IHh6zaGMKaEHr1fPT
         dXvTrbLCzZelpSqUvgB7+DigjpgMCjqVPIRnqEKcW61m7dArpb4XmR/zSaDR/xg5a1hj
         +ONd19GgS7iVnLFVuW1ii9DgmHBjRmfvgeLu5INEiXONH8wm6gVc7TTnQnCHyXYlr4Yg
         bMQg==
X-Gm-Message-State: AOJu0YzO4ehE2+YhPKeD2K2JkBTNgQn5ajNeNf9/0WRAlof0odpBr1Rg
	GW+kx5rSbskV8IMjc4Jt0H4e+zZujh7mXe8gZ8XOnpQ57Ki9q+IKgrOwM5dNquYBunGDmwzyXcM
	DO/Y=
X-Gm-Gg: ASbGnctay1VescHE6PrGcuTibd8awSWYKt+bQ439FtFADvuDm1wFH7cswQLVDNXGZXK
	/hdD0DjlH2IX3rzMsMjYwgEtxn15+jylEeVdj2FPDWdudDQ1AYh29ZRzH3OjKsWvu0qjYknNM5F
	0K9PCYHEbfNqQGIaPAD7A3krExPDnJZHEmaYiWxbni8IsulDfowip/hF45KS5v9JwZtySqMwqW+
	T1Cw2LSN3qZwVXkdODYs++9TTyxL+kEGmmftD2hJszrScG++S85ZYnPj/U=
X-Google-Smtp-Source: AGHT+IG92jtT1ts8pLCse/pz3891R0JUjdYhcgvq+7v8M5vVXQlY8zB2P0P7iFOh+U59M9KgLG4ncA==
X-Received: by 2002:a5d:5f90:0:b0:386:34af:9bae with SMTP id ffacd0b85a97d-388db22aa6emr1679599f8f.4.1734420516121;
        Mon, 16 Dec 2024 23:28:36 -0800 (PST)
Received: from localhost ([2401:e180:8862:6db6:63ae:a60b:ac30:803a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2db9ca30asm462029a91.1.2024.12.16.23.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 23:28:35 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 v2 2/2] selftests/bpf: remove use of __xlated()
Date: Tue, 17 Dec 2024 15:28:19 +0800
Message-ID: <20241217072821.43545-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217072821.43545-1-shung-hsi.yu@suse.com>
References: <20241217072821.43545-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Downstream commit for stable/linux-6.6.y ]

Commit 68ec5395bc24, backport of mainline commit a41b3828ec05 ("selftests/bpf:
Verify that sync_linked_regs preserves subreg_def") uses the __xlated() that
wasn't in the v6.6 code-base, and causes BPF selftests to fail compilation.

Remove the use of the __xlated() macro in
tools/testing/selftests/bpf/progs/verifier_scalar_ids.c to fix compilation
failure. Without the __xlated() checks the coverage is reduced, however the
test case still functions just fine.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c    | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index d24d3a36ec14..22a6cf6e8255 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -682,22 +682,6 @@ __msg("from 3 to 4")
 __msg("4: (77) r1 >>= 32                     ; R1_w=0")
 __msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
 __msg("6: (95) exit")
-/* Verify that statements to randomize upper half of r1 had not been
- * generated.
- */
-__xlated("call unknown")
-__xlated("r0 &= 2147483647")
-__xlated("w1 = w0")
-/* This is how disasm.c prints BPF_ZEXT_REG at the moment, x86 and arm
- * are the only CI archs that do not need zero extension for subregs.
- */
-#if !defined(__TARGET_ARCH_x86) && !defined(__TARGET_ARCH_arm64)
-__xlated("w1 = w1")
-#endif
-__xlated("if w0 < 0xa goto pc+0")
-__xlated("r1 >>= 32")
-__xlated("r0 = r1")
-__xlated("exit")
 __naked void linked_regs_and_subreg_def(void)
 {
 	asm volatile (
-- 
2.47.1


