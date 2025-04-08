Return-Path: <stable+bounces-131819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626AFA812E0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AF9882324
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5BD1D61A2;
	Tue,  8 Apr 2025 16:50:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0622F38B;
	Tue,  8 Apr 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131058; cv=none; b=jeNDiCOWGAznIio1AMD+7rUSHOJDnC8buh7DBMTVtriehxSqOYKJU5D58MnngW5fbEarTQUJ8VTZh1Ll/BLoftOOgVMDPRQ+xjwmh8kGOGGbfBgLfs/+rG7e2EiyG2BrU44uh1aivoU8mhw7yY23P4tdAsMX8tfhj8ZMLlOw/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131058; c=relaxed/simple;
	bh=JGXjMWrxBGpV3IilaEw9ywZk6BI6PGgjJL6y6JxnWIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JnMc7fxTESB1ZMiZB+pY7gj//3SXr2cMTRAcfJ/nyH0WLCfZ/8YoO3OH8u7R9TxnLZ3ZD3fdqwiNwE51ypYWAmFye100cYK6PaRp3QKB6FSsthcMTTqgo5xL8ADjOOG4DWW7tDfEIZyS2B8LOrSBZ/LT3txHtljZqHdl7v+HNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab78e6edb99so841430566b.2;
        Tue, 08 Apr 2025 09:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744131053; x=1744735853;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnsvCmPODSQ5t/BQaRsj9d0cYYH8fWPK5EiZS/A0N3I=;
        b=CZ9dae/isn20LYYfIl6s2gP0JD/JguJp1wwpnG6HX0GKpr9FH9NlG24GxbAvvhsbEq
         RqPHfdwtjtRBpOiFwTOHE3D+KQYIIV9hp/OnAf1G756yY8iAa4AndkDovuKpvQzT9fX/
         6SytQPGpTinFenIN1evyp+WXuDS4C2EkHROixh+MfdoT/XPizW40nwlxm6pCBCv4YxgI
         N9hXB/fKYTUqcqTJ4W4k3rg1DT2OSuwMycxqlltMUKEsNkP0pcktONKxNwL64VCatj62
         vlEaFPrQoL6JSi/mMiePNFT5tQCYoPHM1f2Hx4DCsG5TP0Gn70M4lIcTnIrfQr2xfOSw
         YgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7CHUiDf97y8Chmk1o6xwiWsN/7MqrHAvN6ri7lLePhvhh88y9bqwPiUfPUYKF5aHbRcSeRo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfyuthExQkF6EX2k23ibVATEYEsNAySh7v+U3kc5KKgDYI/Wfh
	QuoO7V6zWrA03s73KYSC5olQ5XtPBA1FQo5O5tvbSkijcvezBQkQ
X-Gm-Gg: ASbGncuuuo4RQNLy7MOzFL48CY2q4QZDRxB1zrlaXw2o1To0J8+m73dnQQxE64P5g0M
	g7/T4TSg/s8x0f8lCCa2QDzDsZHLxdJCAmFLlOPzCanLNb04VD15ygZ6JV47jGxiAJnFvHtqSWe
	fksQ3uigMy9bWjxmlySs53evcEgOrz8dpfczJ77VH7GBAJMrws6Ojm1FwRF8MKjP14mA2dERnmS
	qKP3HpTXesFL+e/4Y9kkCgORdwmOuiWNrbdfqKOL6H2pMCqHCnf4ZfduFk48RFDNbzM/HEZ66fg
	PL92HYXYp9HGNWPyFVFGXD7IG61FvOZEk52D
X-Google-Smtp-Source: AGHT+IH9HnNyMFV5O6WicbArRsnqzIi2jDwQCiMAZaH7h0h4KnM/huCtsHoH8BLqq2TuZW5kz9hTAg==
X-Received: by 2002:a17:907:7e98:b0:ac2:622f:39c1 with SMTP id a640c23a62f3a-ac7d6d06cd9mr1431713166b.22.1744131053190;
        Tue, 08 Apr 2025 09:50:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe99c5dsm939456666b.43.2025.04.08.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 09:50:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 08 Apr 2025 09:50:42 -0700
Subject: [PATCH v3] sched_ext: Use kvzalloc for large exit_dump allocation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-scx-v3-1-159b6c7a680d@debian.org>
X-B4-Tracking: v=1; b=H4sIAOFT9WcC/1XMQQ6DIBBA0auQWTvNDNAgrnqPpgtEVDbagCE2x
 rs32k3d/uT9DXJIMWRoxAYplJjjPEEjVCXAj24aAsYOGgGS5J00Gcx+Reau7a2uSXkFlYB3Cn1
 cz8vzVQkYY17m9DmnhY969YWR0RjdOqOd9GweXWijm25zGuAYFPmP6h+SyMjW2N6TJkvqgvZ9/
 wKzOm0AzAAAAA==
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
 changwoo@igalia.com, stable@vger.kernel.org, 
 Rik van Riel <riel@surriel.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=leitao@debian.org;
 h=from:subject:message-id; bh=JGXjMWrxBGpV3IilaEw9ywZk6BI6PGgjJL6y6JxnWIo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn9VPrFoZMjwfWRMhRm8BGuTC9GEd7KGOvwjbfO
 voAMEtN0DSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/VT6wAKCRA1o5Of/Hh3
 bWdQEACw2dB4mwMRitL2l9c2VNtd1fZhvsRRUvD8+oZ3utcy8/V6pODu2SSjVXHBu1TJ+nhqjcx
 KZ4H+WaKMX+ts5cDY/FIkohTQroy39Xm8ly9e/OqzxvH81En5PycLPrYlRwuG+PtTZ2JoBFz2fB
 AxAT4fcIBuw8X5Elx6/n9+rV4+iKyACZao6dg4Zd9wgFuovIWFc65Ywpmc/pWbnOFFNlYUfA1T+
 l7B96B6ACSB74GwernhJgjkJWGC6spNm6Hs+/zgTSBawD1Sen+6ECDdCuUv/olJfoyf7ZdVIWen
 0MsY0/GSwBJqEH4jvUcoZ1BfJFJ43/79xybDzMicfbgB/Zx2SvWs9ZnLDcr0OhrJBt2jlDRGFf7
 hmiyU7Peyv7x2uMYYofnmztZCtWSQT/qghg1oeE3AfLMqZYA80yD6e4uD6tMfzWQM8OB51sK5kV
 xfEi/3Kp08OyqvysrIxfJaVBGRxao+fb2LMT5IutvHof8Xkb9q1Qaxi+QbqUVAqqvPsRMPtgNxT
 XNyt8q1CYWBGQwXkxw9ijBFF3puqgkL3mTu7QAmRtFIvFigT9LvW4J4rB01SDBj7y49eIgZt0q6
 v3KvMOtm3mcdvR5tmTHov1xkbWTJnWn/6blIroBiFhA6X0eQlYz40wTVB9dqfScOYdblKCfDLE+
 rGvbChEhXYgUufg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
can require large contiguous memory depending on the implementation.
This change prevents allocation failures by allowing the system to fall
back to vmalloc when contiguous memory allocation fails.

Since this buffer is only used for debugging purposes, physical memory
contiguity is not required, making vmalloc a suitable alternative.

Cc: stable@vger.kernel.org
Fixes: 07814a9439a3b0 ("sched_ext: Print debug dump after an error exit")
Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v3:
- Rewording the patch message
- Link to v2: https://lore.kernel.org/r/20250408-scx-v2-1-1979fc040903@debian.org

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


