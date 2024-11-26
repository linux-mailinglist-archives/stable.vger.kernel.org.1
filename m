Return-Path: <stable+bounces-95502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D059D925C
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0E3B23DFA
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7401898FC;
	Tue, 26 Nov 2024 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D4HNJvoU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF21539A
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605742; cv=none; b=W7mgiAWxXOfdi4oN1dmei6MK+thxrNdq5g4Zo2mDm6w9/2GYVF5fVdRONT1XptoG5deBeAEWg7ltQeDc3uqC/Cxd3eqPNa281LltbNb3jTUiaAQMZuh9oM7GLpQ8Kz5or1rG7NP4kgi09GK0fsbWO5o63OdrvovEjCaKp8avEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605742; c=relaxed/simple;
	bh=svzpTwMfpLXDJD8S2zbyCrhcx1EHyCk75ixmN4/MzwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/VZESR2D+oyAkWeWESkdHNcCyJybdU5NNXNKIKqI28LR8N7bRxK1NNLCpstSobKqKw83tPlMa3XmCbLSYhF+IF+CTgnAXtFW89SSjmh1xF4ijaYAQvNF5uTeJd5/A9ffoBjvtshCdRRFRl9uVo2MS+R11qTgD1VAqCGtjm8DTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D4HNJvoU; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so434135e9.1
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732605739; x=1733210539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZHw4ncRBaalH2tzU7oO67VVMPW73v4Zbs6Ss9mYPqw=;
        b=D4HNJvoUx9Hsb7me+VH/FYGdYxqd4wgm+YNEqhpkRF01er1JEcnUzVsIts9Y33b276
         8rWokkmyo2mcoy2TYt2kT4Bsv+PeGsa2WuOxTp1HnzUBhhoJBRzvYwlvzAm6IBS9Ih23
         oOdQnOE/mHIO5tepspE1hGqa7mxgLpeLiCOyDEBu8Eho22c1bdD7PyBSbEtYm47GieQi
         qYUMHdTxK4BSn5jPFrYRDa3XdueTRmekfk4RBbN4NL38eTu5e5dEF3ih6SjQNwltpT4q
         2FQj+PFFjsdsvqNBLgpADfPBZJes5pLpSKcq5YqbTGD3MIVKNhdZdwlEGI3bRWqvnFY1
         MMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732605739; x=1733210539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZHw4ncRBaalH2tzU7oO67VVMPW73v4Zbs6Ss9mYPqw=;
        b=owv6KGgHHzALp/IN/JuxJCuYKdn74pbJIGP4lfgJtsfLABpVox+ksHSQCJ2SbTuG+j
         vLvFacuuszhKUyjNQ1NWNcUfvhZaP8/TtBClAjthCGhiAdV8DYWLdIuMFVBoD6Y3wnal
         xVtawuCkUSiZvFjI48+54SNtECne8hO1+S51LTP3+oQxNBVrIB0YdYbi8sImBNjbN7/U
         lG/ZuDi8d6SCglhgvKWWA2PwDvoVfFGYc/RQ5HRZNUNntpDp9CQ+vA0W2xPH3Z2dsXwa
         /cV3yS0jexCpQe1CjPlp1RC8CY1z/IRV99+JkhWNuiQDdh//1tABT18vUOdvtlc+1VpY
         /H/g==
X-Gm-Message-State: AOJu0YxbdRIvFCE0YQSm6zb48z8KcLevT0a/ma+TiRJM8RvxvZJG5b5Q
	z3so4tekjHbXtIW1fK2Iqb/GzOTQ46EKPr8/TLyrfXG3IZHG1AJEtasJgC/qXdSnxRt7UFYM4iW
	65mtwngeBBww=
X-Gm-Gg: ASbGncv1iTMW9ZyGo1RfK/Q1WiDAa+XHeoolqD1tHvcSIZ1n2qD36m0v0J8V6hh3dfx
	/wF0prkWXbVfTRK9bVLwuHWDlzsMyLTqvJVflkuo3+LwwuLqzQ0IUZgxD1fxQYFfyJ69MpaUzv1
	VNLyB1gjKI8NpgXg/cgdjVOugZmb4wWxroCMsMBnV+8gwsYWbCp6Hrr4vMy5Vw9L/eoqOh8dVXu
	PxZtg/ODKYsikV9SB2E5fKwebqM3xVRl8RI3gVVpJUlT316p8Y=
X-Google-Smtp-Source: AGHT+IEeErBTZeyDeQ1b5X59CmqXopRaVkLQeDdkoBR3BdZ6KiIFOLP3lRRqXiRf0amgyWiXr1qfyQ==
X-Received: by 2002:a5d:648a:0:b0:382:47d0:64b0 with SMTP id ffacd0b85a97d-385bf9edec0mr1422427f8f.2.1732605739127;
        Mon, 25 Nov 2024 23:22:19 -0800 (PST)
Received: from localhost ([2401:e180:8891:cc8b:6df8:da33:1f62:8cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724df8b04f2sm7818442b3a.66.2024.11.25.23.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:22:18 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hou Tao <houtao1@huawei.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH stable 6.6 6/8] selftests/bpf: no need to track next_match_pos in struct test_loader
Date: Tue, 26 Nov 2024 15:21:28 +0800
Message-ID: <20241126072137.823699-7-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126072137.823699-1-shung-hsi.yu@suse.com>
References: <20241126072137.823699-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 4ef5d6af493558124b7a6c13cace58b938fe27d4 ]

The call stack for validate_case() function looks as follows:
- test_loader__run_subtests()
  - process_subtest()
    - run_subtest()
      - prepare_case(), which does 'tester->next_match_pos = 0';
      - validate_case(), which increments tester->next_match_pos.

Hence, each subtest is run with next_match_pos freshly set to zero.
Meaning that there is no need to persist this variable in the
struct test_loader, use local variable instead.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20240722233844.1406874-7-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/test_loader.c | 19 ++++++++-----------
 tools/testing/selftests/bpf/test_progs.h  |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 150aebd1802f..226fca524516 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -413,7 +413,6 @@ static void prepare_case(struct test_loader *tester,
 	bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
 
 	tester->log_buf[0] = '\0';
-	tester->next_match_pos = 0;
 }
 
 static void emit_verifier_log(const char *log_buf, bool force)
@@ -429,25 +428,23 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j, err;
-	char *match;
 	regmatch_t reg_match[1];
+	const char *log = tester->log_buf;
+	int i, j, err;
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
 		struct expect_msg *msg = &subspec->expect_msgs[i];
+		const char *match = NULL;
 
 		if (msg->substr) {
-			match = strstr(tester->log_buf + tester->next_match_pos, msg->substr);
+			match = strstr(log, msg->substr);
 			if (match)
-				tester->next_match_pos = match - tester->log_buf + strlen(msg->substr);
+				log += strlen(msg->substr);
 		} else {
-			err = regexec(&msg->regex,
-				      tester->log_buf + tester->next_match_pos, 1, reg_match, 0);
+			err = regexec(&msg->regex, log, 1, reg_match, 0);
 			if (err == 0) {
-				match = tester->log_buf + tester->next_match_pos + reg_match[0].rm_so;
-				tester->next_match_pos += reg_match[0].rm_eo;
-			} else {
-				match = NULL;
+				match = log + reg_match[0].rm_so;
+				log += reg_match[0].rm_eo;
 			}
 		}
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 2f9f6f250f17..ff162a65cb18 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -430,7 +430,6 @@ typedef int (*pre_execution_cb)(struct bpf_object *obj);
 struct test_loader {
 	char *log_buf;
 	size_t log_buf_sz;
-	size_t next_match_pos;
 	pre_execution_cb pre_execution_cb;
 
 	struct bpf_object *obj;
-- 
2.47.0


