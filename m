Return-Path: <stable+bounces-129267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244FA7FE19
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254D17A565F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E6268FEF;
	Tue,  8 Apr 2025 11:09:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC82267B7F;
	Tue,  8 Apr 2025 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110567; cv=none; b=uUyricvkm7TuDrlk3ajfa4br43leo2IW8PDm1SKaLaCDQo0HQVScgFr853HGUI6hJPUMta3twFzI4RE/Wf7HBXbGowxebPiyl3nsMRovuJz1AnfJodJnDxaIPixQ5YEX7bBtTFZ6V3BQEX4nNfM0AtS3l73GOXysWINcmVLHrs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110567; c=relaxed/simple;
	bh=aPXYrndgdMPDisO56UD2/E7jW3VS5JPMQlYHE8N3m/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IfDrgMnY4/sVXS6u/iZ1V/7aiPWXpKMKpKpA8N+QlefFDnVOTrtYlydnfHZOhmB5PUSdS0g0kWKIu4c/Iyptv+tQrbDvqGDKMUQC3GrkPg/0nTlGFvzVUQkE1MDtc4UNJX2SCZfaWavHA7e6+If8CMIrIcyACNNMdlQPMDcsQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso11892901a12.1;
        Tue, 08 Apr 2025 04:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744110564; x=1744715364;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z45/AeptaVau1rF3Bv9GzsdE9rkTDD31oOKZ+k17jHo=;
        b=fDP2cOyvrkl+CvjCHBUJM0mKgUPGs3+IaH88XdNZIUSliFoyS9YckT9EwkcnAKF3ZX
         Nyjs3DOLl782sbzOY3Bzc/7gb0tSw8ZkuvwMMG9uaWEjeL3hGY7hzwM7Q6P7CAC/b/7z
         8VM89X2d9NSBZWEVu2xPklcDWZG1nqNZLGI04SvKGjtrUxOjb+sxF8CPQjhXzjeBe+0D
         bkqi0hDg2OfPSuIFFjXcrFYz6RwQYPzxf/bmZqcSJ7AFV+s08vI0b60as00rvGdhkJUL
         be2/BYHaNWC4KF1mdH/cLkiVgj7o6FZgBqIgF/RzZlJ5tqcnDFCIVTzOeSkLxQbTb536
         H5xw==
X-Forwarded-Encrypted: i=1; AJvYcCUskwA7ijXLkhavYg6aoc+AIBC3/i+zmZ5ZfbsJGyQvrk/4an1QmD0eX170B6xv00ApAQc3ig8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1H04hUjPvsdCUYJLar/SCyYoEGmWzz8W9BVSI3/dObT6Ov5W
	4x8nriD96Bj+mGP1Z7smD4vHgiERgaLlD71d8b3165ZYqeYW7tuA
X-Gm-Gg: ASbGncvY7U0ZwRH15rdwvOy2uGc9v09RtIwrGeMYAZyXnTNd1dDCwDBLFtYf5p+scPj
	tHjTdNgURufGoxi/4NkndSsnltDMvTt5VnQc8JxyUGy6vcLtk9aw+NOF+CXOoU3t2S0UYnf1Pko
	8mt16j3I8MXcdY7wswoLp3habBHPVmoycn0zAni5CAXuvuI8FQIwpTpyegkGil8foGEnjUmaWrj
	+zLFjgg4Cwyrb1YOyCqw9/HaNsQpyQ80WOTdSh2gNq68lGFTA4RAAECl8sQpIWaMkocwH8H+HlF
	IrvblOkNFJdsp0hPI39XjLGlq7tNvgeJDHg=
X-Google-Smtp-Source: AGHT+IGXjo4xWZPqql1KrbG67ffeTRXSgwVC+ILiRJHZTUtyvNaBWb1XRfhZ6elYi14B3lSkSV0dnA==
X-Received: by 2002:a05:6402:1e8a:b0:5e5:4807:545f with SMTP id 4fb4d7f45d1cf-5f1e4472346mr2596326a12.12.1744110564051;
        Tue, 08 Apr 2025 04:09:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f0880a458csm8056627a12.69.2025.04.08.04.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:09:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 08 Apr 2025 04:09:02 -0700
Subject: [PATCH v2] sched_ext: Use kvzalloc for large exit_dump allocation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-scx-v2-1-1979fc040903@debian.org>
X-B4-Tracking: v=1; b=H4sIAM0D9WcC/1XMTQrDIBBA4asMs9aixmLrqvcoWfiXZDZatEhK8
 O6l2XX74H0HtlQpNbRwYE2dGpWMFhQDDJvLa+IU0QIqoa5CC8Nb2LmU0S93fRNTmJABvmpaaD+
 V58wAN2rvUj8n2uWv/v9dcsmN0d4Z7VSQ5hGTJ5cvpa44jzG+YBozgpcAAAA=
X-Change-ID: 20250407-scx-11dbf94803c3
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr, 
 changwoo@igalia.com, kernel-team@meta.com, stable@vger.kernel.org, 
 Rik van Riel <riel@surriel.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=leitao@debian.org;
 h=from:subject:message-id; bh=aPXYrndgdMPDisO56UD2/E7jW3VS5JPMQlYHE8N3m/c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn9QPiqUZuEDOC7Bta42R0kYSkzDVMUwwGi5oXO
 BlKsS1FGziJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/UD4gAKCRA1o5Of/Hh3
 bdnhEACv3OZT8uBUc98v8zwq/PfNKw5xbgcVl5bVC4u4Tvm/P/MZFDe2NSpyfH19+CyybDlTEMo
 AieOFtfc7yfCqCptEeThjZEAi5V4gGF5lC1656MO/Qg3Lii5iq5vxedAEXoQvzCej+N31v/WD/+
 Yuw9Y0is5RL9TYrDvU/2rCMtRJsEv6MlwCF4dYSkFP1FTXsZ5azGTXrx9g96ubQ7EVkko2d6c2T
 u4D4CgcklS96nqg7XagcmwdgJOslBnSg08oihCgkaaM93iWLNKwjfsy4l4yzovfC9+t6SMwG/eu
 Jo1fXYuUA6MDID7FJc3dHOi5o1R9mxO8aM14PxhIXpgbLkytHstZkBdrk8f6NZgzv6Hl0iFaSLo
 c53e4XL6Qcs0yclkBEkaRll5cDdO6k2hp1AaM6FUYFG5XOw3EfwQeH1aM2/F1qzc6PTHWXvFQ4B
 gtuaZKFObsxVGDnD0JxN+1braYTgA/AXLaJwSHHsnNhV2gJwTA00g1rU1VPL+VdZHVCN8ycqpjj
 2dewpxULxJs43ZQveWikOwcbhdj0Ni/46WMaHjeE8nldzB6oENa1TOrkDFRBtTNYoP5moyi/oGo
 nXze56OzNjea2ayIlgzc1njud+aewoZdyW29SisPXQ98tu/52cc4hkVotmKdv2In/HmVeJVfDln
 pTYaF/hqA6uGeZw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
can require large contiguous memory (up to order=9) depending on the
implementation. This change prevents allocation failures by allowing the
system to fall back to vmalloc when contiguous memory allocation fails.

Since this buffer is only used for debugging purposes, physical memory
contiguity is not required, making vmalloc a suitable alternative.

Cc: stable@vger.kernel.org
Fixes: 07814a9439a3b0 ("sched_ext: Print debug dump after an error exit")
Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
- Use kvfree() on the free path as well.
- Link to v1: https://lore.kernel.org/r/20250407-scx-v1-1-774ba74a2c17@debian.org
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 66bcd40a28ca1..db9af6a3c04fd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4623,7 +4623,7 @@ static void scx_ops_bypass(bool bypass)
 
 static void free_exit_info(struct scx_exit_info *ei)
 {
-	kfree(ei->dump);
+	kvfree(ei->dump);
 	kfree(ei->msg);
 	kfree(ei->bt);
 	kfree(ei);
@@ -4639,7 +4639,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
 
 	ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
 	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
-	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
+	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);
 
 	if (!ei->bt || !ei->msg || !ei->dump) {
 		free_exit_info(ei);

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250407-scx-11dbf94803c3

Best regards,
-- 
Breno Leitao <leitao@debian.org>


