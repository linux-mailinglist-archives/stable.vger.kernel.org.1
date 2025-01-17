Return-Path: <stable+bounces-109379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D9DA15200
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B1216931A
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A814815B0EF;
	Fri, 17 Jan 2025 14:41:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9670825;
	Fri, 17 Jan 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124884; cv=none; b=DinUgr7Qf1wCFBtlJKB05lcpqgxKR0tZHg1EE3gDYvRs0luwn7B2pIvPhwccTezXRTdYru4T06nyUEYQHX4u8FLHiHPVXFdq6V5HEALw7EQmSNW8BplS0vJ+1sELN+yLXpUGyMO89vQ1iAxEzGGPHyHWDlz+jyw2eTX7xY4dTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124884; c=relaxed/simple;
	bh=qB+mIM0EYz+I1pls6sSIWINm3zNY9i+8wIbRvi2RtA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HyDfDcEk+Mk0cIXvc+qjLv6uPuSfpAxKBF7JN/m0wmqIHRTJsF3G0w6zuUAnnS0jDrGrX/f5hIyBAeSEmdsaITQqeY6gKivoOZ3LZnf5lgYV85f8VuAVk4RCrrpYqOvqU9voJfrKhTzSNocvQqGDEZ0CJsqak5ZRfii5v/iLupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso639964966b.1;
        Fri, 17 Jan 2025 06:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124881; x=1737729681;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgheNYehqLNKR0b+eUvD7CWj7dO9HGnP8KiUhbtcnlc=;
        b=walNqUHSCXRUL5uHLmXnIEtDPGPi3ehsaHjqAmqqJgG8bBV2ELwF9I+qQWwn56eIJU
         52YGdfsDMVlN2lXpNLGwTc8csaqoG2mFjlG7ufiHHmXas4Cel0FfwyxTIc/WR0QAR5Ti
         /hC9XOlh8a9lzSZ1tbfDCC+ESWrktmr34Bqb33PBfSErbZMGBy6PeY7MMgMvIsIl6Co9
         zA0UeU7RN2rOn4dwVkNmFVQO2eOwTgwPgyokNkGpklBBuA2VF82BYw9mjbfPafcTJBSv
         1EaAcgp5IaGGWNj8g/S3l2OUF5k7VrDln1GPBI6Cc6WSLB/xAlCj49pPp8AWZ+rC1lGW
         kPOw==
X-Forwarded-Encrypted: i=1; AJvYcCUGrYuLbNmNUelr0ubAvbkmCd20BqSUS+vlx8r82uVZdT+dOi6pnoFYzyfmR0y8A4WS0+nBhI4cdwJnvFU=@vger.kernel.org, AJvYcCW7zWvCG7gNrkSkxcPVNpN7ikhZkqj4YwbJmF8xFGiwW5208NpRtNuZyRskaOQP5wtBqjpMii79@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3O50AHtfI51iq9rKh4UZfphhdd7u/NE0ynx2ngzu36sM/IEV
	lG11U6Z0IQX3uBmI8LwDM/8mufZZlGn5RT9y0XNjVQ3uNdhaF9q+TXh8/w==
X-Gm-Gg: ASbGncvXiMU+NaUooh4dGgzXnmJMyjaFyKfYBtugV4U2uQhbyQCxNLcVykTlThl0JAP
	Wa8quvT+Hi8kkdnYTPA1G/HrysyZTgJnarB51layXWSZZYBpqQ8DMbNIiPtj76KR3QJHy72rBnZ
	/5+rhyxReh84C1vIWxGTABoYSvms4BC1weFxd9dR59yE3gNEB4LRvuuLXluyKcEYAxSvJrKoN6V
	N9tT1treUk1egN2Y5fZ8+tNqfjQoPMq8ryg1r02ljwfJ9hC
X-Google-Smtp-Source: AGHT+IHXvQ0+JN63YvqBaeUp8+0+4arDFRKh9DkvundLC8f1gHxpznOEEtHUT9S3KLif86OPNY1niA==
X-Received: by 2002:a17:907:7206:b0:aae:f029:c2ec with SMTP id a640c23a62f3a-ab38cc62521mr206347066b.12.1737124880854;
        Fri, 17 Jan 2025 06:41:20 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f8628asm179363266b.138.2025.01.17.06.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:41:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 17 Jan 2025 06:41:07 -0800
Subject: [PATCH] perf: Add RCU read lock protection to perf_iterate_ctx()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-fix_perf_rcu-v1-1-13cb9210fc6a@debian.org>
X-B4-Tracking: v=1; b=H4sIAAJsimcC/x3MYQpAQBAG0KtM329buytp9yqSxAzzB81GSu6uv
 AO8B4VNuSDTA+NLi+4bMoWKMK3jtrDTGZkQfWx8CK0TvYeDTQabThdFUh2ST40fUREOY9H777r
 +fT9OQ2wNXgAAAA==
X-Change-ID: 20250117-fix_perf_rcu-2ff93190950a
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kuba@kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781; i=leitao@debian.org;
 h=from:subject:message-id; bh=qB+mIM0EYz+I1pls6sSIWINm3zNY9i+8wIbRvi2RtA4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnimwP7CuJXGZXVXhvEt8gYXUR4uV/xLOLBpPKu
 OGamGIlVACJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ4psDwAKCRA1o5Of/Hh3
 bYDHD/9ZajneFmbBt8j8gmpZgPk9Ag5E+zBz1mUSvsSNQcaLEuooQmTtP8DvHYYVkOM7IPAZGL6
 Zr9/UUMFBFgoONJjfk68VK5D6knbwc3jfslYZTFZwFX95HknJaAJyrK1L1gt3YAA2ucMU6Gxrg5
 kymiOeGYHoV/tYu21KMLxyj+sqsvrhdsHqOx+uWf5u0yiWgiIXR30I5gPxHW8LxOfq7lphrrp3l
 Rul8W2uaTvUfmQrej5R2XoFuRBsAcM5GDjV6x0q1Vk9yuVhCojBn8ROBX6oI1jOupS14h5wpr22
 7v+lI6xTVDrrAAbXGJxzu9qqU/dxTDN9K+m9j9bBMaj4qy5Pt2CJgaXX68cVc/imMEreZzgKFpy
 J1H9Rbmzb+J0IJ7azhlfiCjwwKtnYq8b0IZxy8e22WytjRfUgkASQWy86LxiKZ7MRiNNPpLDHRf
 IDOchb8Z1ywVTq2qi0MYcLcAjfuUb+xz9d+N0u/+Z5W8pR2fD6d3rRps51KMPRQCzjtWYdyWhvQ
 3xBa7g938rfdvam8zyeh5xvRPgDbM0RcMeozZX1kLrrz8Mr9zcox1rA09CPrWZkfTYsXzIblKxl
 O3Ck5tFcZ7DfTgq8t1d8ZuHIEiV7ifdthvQS08iSAOa05XhMivTIIz2fb0pP3dU0keoZy9Ld2fo
 D4AXZOThD9w9N8A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The perf_iterate_ctx() function performs RCU list traversal but
currently lacks RCU read lock protection. This causes lockdep warnings
when running perf probe with unshare(1) under CONFIG_PROVE_RCU_LIST=y:

	WARNING: suspicious RCU usage
	kernel/events/core.c:8168 RCU-list traversed in non-reader section!!

	 Call Trace:
	  lockdep_rcu_suspicious
	  ? perf_event_addr_filters_apply
	  perf_iterate_ctx
	  perf_event_exec
	  begin_new_exec
	  ? load_elf_phdrs
	  load_elf_binary
	  ? lock_acquire
	  ? find_held_lock
	  ? bprm_execve
	  bprm_execve
	  do_execveat_common.isra.0
	  __x64_sys_execve
	  do_syscall_64
	  entry_SYSCALL_64_after_hwframe

This protection was previously present but was removed in commit
bd2756811766 ("perf: Rewrite core context handling"). Add back the
necessary rcu_read_lock()/rcu_read_unlock() pair around
perf_iterate_ctx() call in perf_event_exec().

CC: stable@vger.kernel.org
Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a0d8ee66cc76314ae247dbe45cb57..e2adb06f8d81307b2762375474bee1c9e8a74598 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8277,7 +8277,9 @@ void perf_event_exec(void)
 
 	perf_event_enable_on_exec(ctx);
 	perf_event_remove_on_exec(ctx);
+	rcu_read_lock();
 	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
+	rcu_read_unlock();
 
 	perf_unpin_context(ctx);
 	put_ctx(ctx);

---
base-commit: dbb0aea70ce4b85915a52d7adf9af57bd80f330a
change-id: 20250117-fix_perf_rcu-2ff93190950a

Best regards,
-- 
Breno Leitao <leitao@debian.org>


