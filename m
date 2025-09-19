Return-Path: <stable+bounces-180674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C4B8A8FD
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442161CC31A0
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70094254B18;
	Fri, 19 Sep 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKlmn4jm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7D17B50A
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299217; cv=none; b=Q2hRNvDdcAYskX5uKIsO+6Sr0KZmmuT/TrE+KdywN/sMkVJ4DxMGIJBQ0EU3Lp3fKIkoG0f0C7xPA6Is7oNAd8n7q/rd/gH7LlRUY+YxJ/verPuuYw/BA9DosRah9Oid3Td/BuoCWm04mimQVgqR1H7FDLDSqjZBekXMN+BtigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299217; c=relaxed/simple;
	bh=lLM9TLzkSpqRpgE9TUG990CuCdQ+Gj5IcDYHm0aNpv8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DdqDPq7t586LaJ+UQ+wfge0ljfV8eZV7HKB+NCg58g8E+PA/qUDRJ7JxwwfBz163zyw2UKuwpUIOr59IKVtwBZnxgsY00iVTqlXSYr/CqISf4E5br4ge1Xq4buqk+lGKurIRz5lwvNroW+OLP/PRsGfukGv+eazeB6dKyymgrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--angeladetula.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKlmn4jm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--angeladetula.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb45e9d03so2179673a91.0
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758299215; x=1758904015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D9cRdfmH4EXrbcW9amga7tIgnS4kOyjsMSHxlmstyQI=;
        b=aKlmn4jmZ7GEBAfhH+JesBFZLjRbF7s6ErFibK2agKoDW90lRMcrQtSWn/iD8yypx6
         rcpaPiOJ8U6tPpfWG4uD3jwkm3tqakorBMA51iRseVloHADsWZDN/LPZfarfmZUPce2X
         Ww3++cdpkTzSagVRNDytydad1E8c0Oie1mWLjJc8QR5hkXMZADWpyw63acA9kOdyZiB0
         hjOGq6KopeOIyXg6d/KvAFH969KuJb1Inuvs0SL0KR8LjcnGe8bA4ATFy95DRfMI7qrU
         Tu40ZXZxyZwyqEgTgTz/p7KM/JInY3edVMMnobvRskVBh96vDaMctHmc5+Hpp7LTDFL1
         0u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758299215; x=1758904015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9cRdfmH4EXrbcW9amga7tIgnS4kOyjsMSHxlmstyQI=;
        b=uWuiEdJfN+RHPUaVPo2CqT8GVVier8MZLjXlxRued+h3MeNGOyflxWQf+VA17sw7vb
         OU0VtfFTgj8aCY1gQlMO5lFEGmkPLxEsdE10oiexfOQJOTKBFjY/ajhdWjqOb3aa71Yg
         FYJVpO48Fx7fcTsjomj/jlrgAbNZxanWM6gPLxDxD67LoHqFOCNlvw1VK0UP5HI+mNXf
         fQajYD83WhiBxa2JbPeGHPWHEQkG7hktS3tCackSqKYKopuXBp7ee4zCGq6JkwEIkND0
         s0Gg+shrrL6N6xVEshBbsWGwn7y9sFeRBOWve0ZgfNXWcfbWDifp/+xuOATBEObA+rmi
         npsQ==
X-Gm-Message-State: AOJu0YzjfKSWxKKuF85aQUBOp4nTIYnhQHetKksU416sGVsP0By+nWxf
	wEJKy2kl7t2RhLmBvXt2Cq0/WkEE+RmQJeESj2eBzHK9chyTXQ2whxzRDbejjBEvYramDiyIrZa
	0ZQWGcN/XmLbVELzKgfjSitEDoDFi+OJNYjx9MXTziKN4IGSXxmanznLztDINNTNs4KPdhgWzAP
	khKUi5X+NQ+tlpxrhxrw8ua8fTlayTvZBAAVu8hwuAYEhQ1dFrE2Wx3vF+c613/RUn8Caw
X-Google-Smtp-Source: AGHT+IGA8d8ctQS/5db343l2ocCaAdzJu+9cgT12MdRtFhg91z7SYn+MindUxr3ewQb7jh8ohDluHJfwabTguqsP5EM=
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:32b:61c4:e48b])
 (user=angeladetula job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f4d:b0:32e:64ed:c20a with SMTP id 98e67ed59e1d1-3305c2078d4mr10748939a91.0.1758299215042;
 Fri, 19 Sep 2025 09:26:55 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:26:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919162652.1361677-1-angeladetula@google.com>
Subject: [PATCH 1/1] perf/x86/intel: Fix crash in icl_update_topdown_event()
From: Angel Adetula <angeladetula@google.com>
To: stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>, Vince Weaver <vincent.weaver@maine.edu>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Angel Adetula <angeladetula@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit b0823d5fbacb1c551d793cbfe7af24e0d1fa45ed ]

The perf_fuzzer found a hard-lockup crash on a RaptorLake machine:

  Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
  CPU: 23 UID: 0 PID: 0 Comm: swapper/23
  Tainted: [W]=WARN
  Hardware name: Dell Inc. Precision 9660/0VJ762
  RIP: 0010:native_read_pmc+0x7/0x40
  Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
  RSP: 000:fffb03100273de8 EFLAGS: 00010046
  ....
  Call Trace:
    <TASK>
    icl_update_topdown_event+0x165/0x190
    ? ktime_get+0x38/0xd0
    intel_pmu_read_event+0xf9/0x210
    __perf_event_read+0xf9/0x210

CPUs 16-23 are E-core CPUs that don't support the perf metrics feature.
The icl_update_topdown_event() should not be invoked on these CPUs.

It's a regression of commit:

  f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")

The bug introduced by that commit is that the is_topdown_event() function
is mistakenly used to replace the is_topdown_count() call to check if the
topdown functions for the perf metrics feature should be invoked.

Fix it.

Fixes: f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")
Closes: https://lore.kernel.org/lkml/352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu/
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
Cc: stable@vger.kernel.org # v6.15+
Link: https://lore.kernel.org/r/20250612143818.2889040-1-kan.liang@linux.intel.com
[ omitted PEBS check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Angel Adetula <angeladetula@google.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5e43d390f7a3..36d8404f406d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2793,7 +2793,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 		if (pmu_enabled)
 			intel_pmu_disable_all();
 
-		if (is_topdown_event(event))
+		if (is_topdown_count(event))
 			static_call(intel_pmu_update_topdown_event)(event);
 		else
 			intel_pmu_drain_pebs_buffer();
-- 
2.51.0.470.ga7dc726c21-goog


