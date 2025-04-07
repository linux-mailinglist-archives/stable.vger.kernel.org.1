Return-Path: <stable+bounces-128771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB63A7EE00
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0E718952E7
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 19:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A822371C;
	Mon,  7 Apr 2025 19:50:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FBA223707;
	Mon,  7 Apr 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055441; cv=none; b=SMxv+VYXs4gyhiE0o9Ur0z39YOY5M9n/Ouw6h+TT5WD95DAA7LAivnJPMTpLMe7nhep6DXTsdORKyrcFBFKhjJNofJg8EX0mOFyWtiVbWe8XgR0BXYMYuAzQ3EpFNBv3X69pJID4ELfYhtNESki+5ioewTaxYW3TMiVgBHCkPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055441; c=relaxed/simple;
	bh=6FcrnhXXHBlKi66a3RVmRdWf48YBqY4hqxLqVyQGXco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q/2vBuRfmYbdv33bzFfGbb8I4Gvl/YzSKcduKUl7GjMl2dKAzrKSJCKM1J6oMXWFo8C0NuiFD9hmh8whN4ECEljTWdrzjftfFKs9Zcx4pybDpLAdPuileMjb6egleUodV4c9Y/HzujwtMF8sjycR1jq1rvbQFXkiNkSCXUXsBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaecf50578eso767971966b.2;
        Mon, 07 Apr 2025 12:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055437; x=1744660237;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQ23J/xN3/vD0wjcg3ixEiCDeKsCxqPrKKKf7SvnUuY=;
        b=jmzP8Rr6+kWX0h1nDx+jROB15Q/tOgInRqmJh0QhYAULNg2TZbjyKFhhv+6ASFoFYg
         iU4beIapXq05XH0b0e1eJpxqQ259rwOUu/NCmOVd8Sm6v8yiMybldobjetjKooOmFB7l
         gS8hR4N9S7aMldNXJHI9JA5VCUIe3+BIgUJHjTk+h0jlYZBv+7wC9rlebZz5mduvrqb8
         4YODpG0HTCtWIy+N74PteS+kzS8oKmlUoulaqEPeDE57zzxW/mHO4Zy8et7t3ihCnFCs
         xl5SrIh6gd/jnJBgJjWBuX2FjdFdt5N6j/TBsxjJPuWxOU+HpfxFZblY/bVok5198i7R
         SY0w==
X-Forwarded-Encrypted: i=1; AJvYcCVaB0HS23hAOBWDG6PcvsSqdZNsupPDU1zrtmv7IAhSFIOpNZ6A4nt0fBpinlIJV6BKaIlcOIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgGc7vfN0YBiIKr1eqZTnIpV94cG9eXCIWUzp5kfMdc3sxtTK
	Wt1LKXveA1J5YvMYuL5jG3hR/p6R3fZ6F+PowuYh0gkxBzv+bH44
X-Gm-Gg: ASbGncuerPsW0MTtlqKFk2nAuZ77F0wu5vLQQJYqmlUJcOtxvqpwis7F4A1siydbIp+
	8mP5lux6cKiEfRsJ7GkMwsScAxncUXvl6eAzQ2CyQVoWaqHrdEbaJuWwC2q90M9NWDDOrlJizq+
	sw/6Y51OSjIHseX6AFhy3bwxbV3Hho5j6qS5NH6yqotgNbN3qfVHQnMXOMhDXYhom1M1wEmgI0x
	gBdrijRoz5sMEbOb1EsHnyVeTr+tZIGyBHhPvuX5aflcgoBywciPN6UyNYWDF4gzfPHOqdMo4QQ
	21Wbw5pfh1jueCjVogMBcUIMarQ47dFU1Zw=
X-Google-Smtp-Source: AGHT+IFtEc97IeYv2Hm/KIVx9zEa8qD+KATfaA8jgCTGcBexg1ny53hZgTd03AqxtkNHdtme/TCXrQ==
X-Received: by 2002:a17:906:4bcd:b0:ac7:ec90:2ae5 with SMTP id a640c23a62f3a-ac7ec902ca6mr737131466b.25.1744055437307;
        Mon, 07 Apr 2025 12:50:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013f2dasm787444866b.122.2025.04.07.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:50:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Apr 2025 12:50:29 -0700
Subject: [PATCH] sched_ext: Use kvzalloc for large exit_dump allocation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-scx-v1-1-774ba74a2c17@debian.org>
X-B4-Tracking: v=1; b=H4sIAIQs9GcC/x3MywmAMBAFwFaWdzaQn6hpRTxoXHUvURIQQdK74
 BQwLwpn4YJALzLfUuRMCGQaQjzmtLOSFYFgtW21150q8VHGrMs2+F676NAQrsybPP8yTrV+kmH
 qs1UAAAA=
X-Change-ID: 20250407-scx-11dbf94803c3
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Rik van Riel <riel@surriel.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=leitao@debian.org;
 h=from:subject:message-id; bh=6FcrnhXXHBlKi66a3RVmRdWf48YBqY4hqxLqVyQGXco=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn9CyLlnqwR/4bHMMzrw/eS5wUOAd4sc0q8edv6
 dw4pkjOcDSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/QsiwAKCRA1o5Of/Hh3
 bQvxD/97PwEN8SScUTk9Q/4AW6ZXleQFuyaRoffNbhsJ7rWB3Zp/YvEFRmsXLquMIptYsldHTVx
 2CX11aW1AP8KqJpekZ+ZV+ftej7jF74URkLuuAJH7D3BM3g8oYFXnKgLPW9MQ+zUZF6oZ3pzCCV
 QGkmHQxaziGanPOqFQV8PACBAKF5rQRqoxBllBqQIy2lTdcOWYO/+pfYkgN2xkuTZ9XI2qFUajw
 p3LqxwKv8ELlKEKKqJa+hhdD12vDR0Cb+FMBAdBYln149uO7yDrJU4GeMioEtLOmMbGi2rWExPn
 alfyQaPAb3P1c6K3cg0Llfdr0gu7NkQbWt5j+mduNO+XmzvU+r0reucixcRM8/yKKupHiOKVzVu
 I4ms7E3bFswwve2DZgVnxxvVwaoQpDjIWyBA7ZEMq1waCoHIoXTMtkw3jFeRWFSmEunUK1/EmXJ
 AiMHzcncwvEVis+xVlt/GQYePUDF1XXF8TuNoWTX8wFMFWjM1I7fnx19OiDDEXBpGTghX/XoQAZ
 WfuMnUtpeKvNDcCoSRu5eyosg5h9eIDfYsSmTKoH4n1fzsliqG07NB0kCoYVgPT98xMydxnj/xg
 T0Kji2EzfV44ctawXzkSY7isgyDYTvnSZZ8P/J96iFESmlQsdU8g6xwsDXEnhiKQlIIXqGTxXFz
 t3pR0tBXS6UrD9g==
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
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 66bcd40a28ca1..c82725f9b0559 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
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


