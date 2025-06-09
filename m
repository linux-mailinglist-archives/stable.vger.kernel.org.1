Return-Path: <stable+bounces-151988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63BEAD1854
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AF23A7EFF
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 05:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498CD27FB3A;
	Mon,  9 Jun 2025 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PXXhEjKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287D3FF1
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446998; cv=none; b=n8CzPCb0m9SmM+mAoMyL9YES9mduXM+K0N5r27RUWpmp5oylpIJEZ5QW1WEY2VVsYEjmRFUiDsTpxlfyfAeSotnxlNz/xFvlYiriZ8Er8HExHCHWLypU3tDKy9GUN27qX4drudbDn7rqTNIRcbyMdRGpEf2Lsg1MtgakW8dmOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446998; c=relaxed/simple;
	bh=93h8kn5xVls9Ngi8HZZ9l1is5mg9eAIy7FB0kJlHl4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRROywybk4H+dzQF49Yr8EUZs+a9CX+NjkcIyNFInazLiETlpNlYG4RaTWiLLazaiqFiDeLDaT/0x35KCq+a3CntU58cVQHwq3wrgw/PbCU5mWUKYZz8qFiA+gF70EGbrJQ9T/U4fQsm75ovYxK5oPdXSjAukQKS2yg6/OCYntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PXXhEjKt; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-451d6ade159so32704465e9.1
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 22:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749446994; x=1750051794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mF2BTpLT1s+MLNXWca+LZBlRTo25iGM0dixwo5kQWLc=;
        b=PXXhEjKtVvIj1JOIygBnyAgKDoN/wpJ4jh2+zzaUhWea+W/GveJ/vsJJMayQtxLiMv
         pKRoSFIU608nGEhZwuU/FmivJWru+4cBre3phPd2VE7e3CoCsvI39nJyY++X5Dofnfyy
         C6pdAbF2MtwY8tbCZssH9tpvMte4jgXWsOo4cD5dzIi1cyeG3CJz3qic8QDVx7OElypA
         WQ7hhJVp0uygZpenL2Z0EC3GAaAD+nD6A8uNPRuC1O9jiD4xldULIvRDFjLLXHlx28Ha
         2/cFsQaYnJhbKN9JB5e6IfvpnMSL8GlR1fCfhUd6AYu9Yr0ZqKBfx0A6dmyDT2vxybYm
         9udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749446994; x=1750051794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mF2BTpLT1s+MLNXWca+LZBlRTo25iGM0dixwo5kQWLc=;
        b=vQrllDNvDX/LwoJMSIL8qX3F8Cpz1ddvbCY9aGl+URYufGOSnqXc5NlOoh5pJRQSaC
         hlfjWDvOBeQjuXwpXTLkfsQ6f2TWweeRjB1ymQWG53ynD8qwpct6rL0b5UyoY+qAL6dG
         B8Q8jZkB0Q79Ft6qQTEDJBIQ+xyZEquL65IWmvdCqN0SKrHXU+lyHojly1/EpLLhKUHs
         mPxuene7B1rRWRhUK2W3t2i6dr0xeXkmZsII3ImUVFCKWXGNlbxnvCyXI4uqO8ToDyPK
         M+Ur2EkkX3ylMkit6ty1Aw7BBdgBz/qq3p2B3Fv/aKRJQy4LPdg2AEKP/pAScXO7FpFf
         a5sQ==
X-Gm-Message-State: AOJu0YwnC8b1GlAm2uF+tAK4C/DkZ95Y6jQx/VfIhssjIGbWBvEUKSrM
	6DlR9T7pcO+wianCDgf56WWPuNDUnxNLN0ucPeQZ8nMW0q4rQpbWDxZgA9qQrdh1DXW6g3BXq18
	VYt03w810kA==
X-Gm-Gg: ASbGncvRiiUGWbzVKtzkgUgBsGOrwMN8CSGkd0rY7q1Hzxttpd/wsJ/x4j5eoEXOWK+
	kH1+fdpkqGUL9LRFa6XvetH3OvfiI4O43Z17hTnHgTzgIupMCYm/BdDt7fWQe8pJ8i/zJ9LW38p
	bkFMIa0FqgfVBveDyXcPZNx/vas7tqlkKW69a6cZN1Et1ce7ije9n1k8bfBn2VdRUTCmH6WbF9f
	SXothkA8ibiDAfmsxOYoOYGNEWrNWWLCZZl3/vw5zqvK3dQbiTDHSUMBQSywSzaXTzi4CPiAytE
	ESfmSerE7PmD34TswTCfbWXfP2MlQQzM66RJrLVZ0gXLPxUeI4gzum5NyUDkQuhrsovM5wTQiGC
	B2w==
X-Google-Smtp-Source: AGHT+IFaCI+3HLmXEw5kZeudXmG3TLvqK9QADhTDpo98lz8+wq1ALBBocvHq6PqvkFEw5pqy//5rlA==
X-Received: by 2002:a05:600c:8b14:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-4520139a3b3mr110072745e9.9.1749446993757;
        Sun, 08 Jun 2025 22:29:53 -0700 (PDT)
Received: from localhost (106-64-1-212.adsl.fetnet.net. [106.64.1.212])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45213709611sm102806725e9.24.2025.06.08.22.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 22:29:53 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 6.12 1/1] selftests/bpf: Check for timeout in perf_link test
Date: Mon,  9 Jun 2025 13:29:38 +0800
Message-ID: <20250609052941.52073-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ihor Solodrai <ihor.solodrai@pm.me>

Recently perf_link test started unreliably failing on libbpf CI:
  * https://github.com/libbpf/libbpf/actions/runs/11260672407/job/31312405473
  * https://github.com/libbpf/libbpf/actions/runs/11260992334/job/31315514626
  * https://github.com/libbpf/libbpf/actions/runs/11263162459/job/31320458251

Part of the test is running a dummy loop for a while and then checking
for a counter incremented by the test program.

Instead of waiting for an arbitrary number of loop iterations once,
check for the test counter in a loop and use get_time_ns() helper to
enforce a 100ms timeout.

v1: https://lore.kernel.org/bpf/zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241011153104.249800-1-ihor.solodrai@pm.me
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../testing/selftests/bpf/prog_tests/perf_link.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
index 3a25f1c743a1..d940ff87fa08 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -4,8 +4,12 @@
 #include <pthread.h>
 #include <sched.h>
 #include <test_progs.h>
+#include "testing_helpers.h"
 #include "test_perf_link.skel.h"
 
+#define BURN_TIMEOUT_MS 100
+#define BURN_TIMEOUT_NS BURN_TIMEOUT_MS * 1000000
+
 static void burn_cpu(void)
 {
 	volatile int j = 0;
@@ -32,6 +36,7 @@ void serial_test_perf_link(void)
 	int run_cnt_before, run_cnt_after;
 	struct bpf_link_info info;
 	__u32 info_len = sizeof(info);
+	__u64 timeout_time_ns;
 
 	/* create perf event */
 	memset(&attr, 0, sizeof(attr));
@@ -63,8 +68,14 @@ void serial_test_perf_link(void)
 	ASSERT_GT(info.prog_id, 0, "link_prog_id");
 
 	/* ensure we get at least one perf_event prog execution */
-	burn_cpu();
-	ASSERT_GT(skel->bss->run_cnt, 0, "run_cnt");
+	timeout_time_ns = get_time_ns() + BURN_TIMEOUT_NS;
+	while (true) {
+		burn_cpu();
+		if (skel->bss->run_cnt > 0)
+			break;
+	        if (!ASSERT_LT(get_time_ns(), timeout_time_ns, "run_cnt_timeout"))
+			break;
+	}
 
 	/* perf_event is still active, but we close link and BPF program
 	 * shouldn't be executed anymore
-- 
2.49.0


