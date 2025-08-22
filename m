Return-Path: <stable+bounces-172240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D12B30C0B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 04:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD0CAC53B6
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 02:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13BE22156B;
	Fri, 22 Aug 2025 02:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZH8CSgv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6F21D3F8
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831103; cv=none; b=OR0IReWPckP97jkqokXUu7BIiGRDm0raQGoLO1Gu3Z+k7BOttrybPJoEc3R87vhVzJS3PE1BrXN9W6IJlmviU/qcyPkYZ8UI2ZuBD1UU58w5nlCI3F5L68VcJbvUBi1yjVG95+fPixAc8P6BiFIYeC9ilJIcQYVomPuJfPsVQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831103; c=relaxed/simple;
	bh=rmFbI1Ko1ZvQYMn0Edy34iPghIS2cFWVRm2XsY2P8bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rW044V20Uv6CW+xrhLdmd1K838kpkit2HPUfEzpm06UzD1el97E9RBlrosaxXFiAA7blJ49ZA/OrHpT8aJa30qdmadcsEmO5XPgJSgE7cIh5bzbthYhCpnlcNdXhIwJ9HyCrUvJRz5+n7rrQQWzDhVqLY1eEJxn+dk4Mno/QQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZH8CSgv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b472fd93b4aso1329219a12.0
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755831101; x=1756435901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5y1fBCXfKiFD4O4AUiF2Q1s/sYVAdN3oCGBndILrhJI=;
        b=OZH8CSgvd1ES7cwLat1CL3OyiK9LDWPczPhDAEieYGolUEEbnrPDpmQp4U6q6PRAyD
         WzbekLkJbYmUVkcQT2gkg+7ptpHj9uUXa0XZ7YZkGrj7O7N0dcfvca/mM+RJneGmiu16
         uiQ/YB/H4sdYIBOvlgp15hasSjXpJkSCcf7ZO2pP7Tq/dOJRxa5hX3oQp6Bz4QWuan7n
         /fWwkMIlK4Inq8f8f8L1UeTjm+CQnW+bEcbaEMXkE8LoCJ2xLS8PF7M8xumjKomU+YmG
         LpoNyCoY6dhiMe21x3dQMUFNfZOth7f5oplN4wYc0vmtCAZ1hLeVTjvvZSEE5kd/+Mn0
         DsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755831101; x=1756435901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5y1fBCXfKiFD4O4AUiF2Q1s/sYVAdN3oCGBndILrhJI=;
        b=IdaXVhpOZx+fhKfOsEv1gmak+bIY5lxe/5x3qx9SCBvFFCxQASl06ozB7dDThqW+qs
         ba8kchoZ27YwxewAlR+ra1fKEVsuVmEnngFof47KAIOj9fWcHQkudOy7QovD74NG1AP9
         GqYlyGsHRGOxsakHOaAOTWflz40oSrFv2oUGBbbeymTmjeuhqqQFf4DQQ366iixdv3EN
         8F3mBwmU4z2qfpqP4c1kkpvS03n8vTuNyJvca/y+Qy0KzjZPD8k2mZmfnAN6W7c/rBNZ
         U3eFp8VjyEkhxUvIwK9nr4KAZs2lx/RnfluqzgPNs5/qmk9v+JwUfnbDjTOluUttPSOB
         OyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpm0UohfNBnrT4pfsjK/a9e0tWIsRy5qy5PehUD0HE1sszg0UiTIWHnfltOUmsliHwYR3ekss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOo9iSFde0aYCM8Ey1QrKlNWZrFpG1p3ilItpPoIZ1u+qihsgi
	btEUq0jKR1kZRJET7gdeifHD4wuiaTRiOdptXShP3MYvQQE+CctjvxLU
X-Gm-Gg: ASbGncuo0eLo1Gu2J/RpZwpYOmttBsInCezR2z8zkC/T6autZUfizaRpUob6PPLpzYH
	sH+dbHEcHNCmXlauQ7XfvlnIohpI3vLx80sW0hXjZjWHSOuT0urIf6umfCj6jjucBOwhGoKZ1yF
	wBLLNNNg1d0DQNyhh6VWCh8ve+0/WnlDL40PbnRlsLd8q2mFz+NsXqboDcF1YsCE+aPt4R4Etr2
	luGk+XT786FKJ5ykC34t9lAUvX+VCAnNqFJhXLC5E1NNAepRHx14SEgKWirEcR/pGZqAmscRh6r
	1aCmq2pbLBdmpL1hZkmOm2GGdfrQfpPGcfBueT0z5TjkUr6gr11YYK3WqCrG6EA4rdJsLoYd5AV
	cGOSfQUqv2ItuUbYQ
X-Google-Smtp-Source: AGHT+IG6EHV8ZRai6TgzlWPeLJW94eI6szB0VIDlvVy7DY/ryr2+cLBvv/1oIXijaDK6rW2eCMhxtw==
X-Received: by 2002:a17:903:1a2b:b0:242:9d61:2b60 with SMTP id d9443c01a7336-2462edac937mr23760035ad.6.1755831101073;
        Thu, 21 Aug 2025 19:51:41 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24614a8e166sm27790215ad.75.2025.08.21.19.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 19:51:40 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Fri, 22 Aug 2025 11:50:57 +0900
Message-ID: <20250822025057.1740854-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
include/linux/jiffies.h

 /*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

And jiffies comparison help functions cast unsigned value to signed to
cover wraparound

 #define time_after_eq(a,b) \
  (typecheck(unsigned long, a) && \
  typecheck(unsigned long, b) && \
  ((long)((a) - (b)) >= 0))

When quota->charged_from is initialized to 0, time_after_eq() can 
incorrectly return FALSE even after reset_interval has elapsed.
This occurs when (jiffies - reset_interval) produces a value with MSB=1, 
which is interpreted as negative in signed arithmetic.

This issue primarily affects 32-bit systems because:
On 64-bit systems: MSB=1 values occur after ~292 million years from boot
(assuming HZ=1000), almost impossible.

On 32-bit systems: MSB=1 values occur during the first 5 minutes after 
boot, and the second half of every jiffies wraparound cycle, starting
from day 25 (assuming HZ=1000)

When above unexpected FALSE return from time_after_eq() occurs, the
charging window will not reset. The user impact depends on esz value
at that time.

If esz is 0, scheme ignores configured quotas and runs without any
limits.

If esz is not 0, scheme stops working once the quota is exhausted. It
remains until the charging window finally resets.

So, change quota->charged_from to jiffies at damos_adjust_quota() when
it is considered as the first charge window. By this change, we can avoid
unexpected FALSE return from time_after_eq()

Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v3 [3]
- fix checkpatch script errors

Changes from v2 [2]
- remove unnecessary example about time_after_eq()
- remove description of unexpected reset of quota->charged_from
- clarify user impacts and when bug happens

Changes from v1 [1]
- not change current default value of quota->charged_from
- set quota->charged_from when it is consider first charge below
- add more description of jiffies and wraparound example to commit
  messages

[1] https://lore.kernel.org/damon/20250818183803.1450539-1-ekffu200098@gmail.com/
[2] https://lore.kernel.org/damon/20250819150123.1532458-1-ekffu200098@gmail.com/
[3] https://lore.kernel.org/damon/20250821163346.1690784-1-ekffu200098@gmail.com/
---
I checked patch by checkpatch.pl script, just leave result for reference.

./scripts/checkpatch.pl ../patch/250822/v4-0001-mm-damon-core-set-quota-charged_from-to-jiffies-at-f.patch
total: 0 errors, 0 warnings, 10 lines checked

../patch/250822/v4-0001-mm-damon-core-set-quota-charged_from-to-jiffies-at-f.patch has no obvious style 
problems and is ready for submission.
---
 mm/damon/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index cb41fddca78c..93bad6d0da5b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2130,6 +2130,10 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
 		return;
 
+	/* First charge window */
+	if (!quota->total_charged_sz && !quota->charged_from)
+		quota->charged_from = jiffies;
+
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-- 
2.43.0


