Return-Path: <stable+bounces-166502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40F5B1A8CD
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 19:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6E16227C3
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0679B253F00;
	Mon,  4 Aug 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjyX6on3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7780B;
	Mon,  4 Aug 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330354; cv=none; b=GLAb+kTBRMvrLLxzrAoK0RahgeKRFEjZ/ZjaLWCMFi9LGAmSwK2gyZKDzxTFEEpsgAgphBLPoK1SHC8rgvc3MvmRqENx7Tj5WbYE0JIC4k9eBXXn5HPBwNcmh5p3dwe+rILY8rh60s5BMWZMNqDdRJjf6mqEkKySyRqg9w/yVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330354; c=relaxed/simple;
	bh=hRBqtBgChyarswMkyqYaXicaN4pphCyOw/27Y+y30EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SgXUKRV7cawNYnjiDAJCUbvDc6Q1MSi0NxK2jIslzAo8ZRocO/zBhxlP6RQ3jIUrOQMnKCoLcmDSXo63ewKa3TEGHJ3wqC9pmtgerTeJMB64V0L8OXAOuffpEVjdY8wqcdZ4uuUM3pcjrDpaqqANZJvSG6Rs8ceBuK2CZltTw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjyX6on3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24014cd385bso42565485ad.0;
        Mon, 04 Aug 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754330353; x=1754935153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TML5SKZfJNHDTPDytEAgukzx0quH2eqGb0TO1OdDwgY=;
        b=IjyX6on3uhuzfxS2/4eSoyJY0av3klyrCtTujXbVKh/Q1oWKHD06v2zSlGx2Q9x+ZL
         uvqohHBjhwIQLSj1QXJTQp9h3CzjnnSGJJkt1ZqAQyysP0GlVJHMYBSrKuoQNemHVMT1
         VzjtlLiV3FiQxrD9xxKCwKlBKZ51x5hEBFvPdcPYFF1eCl593uQUeY2ANrTuz2o1oPqZ
         cYPOcnHKrvqD+JjFdgaO5eoFyjBgpc6TSqnIwXkJAEpSgFmYXop+XKHW8MBLOY6Vpt2M
         B/Vu4C2nvVxMRYBqYTq7nPPjzUs/D3CVoGOs5M8eYKvmnVkXn8oiUZtv3+bKGaQWmKPy
         nwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754330353; x=1754935153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TML5SKZfJNHDTPDytEAgukzx0quH2eqGb0TO1OdDwgY=;
        b=LilyFqYYuokY0xQOESNSuK9BzOsLF1LNtXxFFiyAP5T8aRsKxYj7IYbI35qLhg5Inh
         16ED1IDIRnCUu4svmISsWAOOvWG6dH8wJtCKgmah9W2bcz+hb/zFh5stsyTmrWjwtdZ8
         tA/4ZgEyQDjUFbuA8Y6Z8IpG4t++hhY0f39GpJkIJTfbjbOUJT+iJI3F8NsScBXcUIaL
         cmNFgXkux7+Bi84aOzOlbZ1dMSjPhGxk62WcupL0nqkll+0tD93kvZr6fXIaOm0dk1wq
         n4hyjbLtoN9IqHWxpSBRGhoyC9MMWiQPY0BCgsmdodAZmN5OIjlyn7maOdcqSf8h14MI
         rYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNXyQxuq3pEeqbWorM+lkd1u564QrQ+5KpMOUE5ee5guPBVx1YOxJbBFJwb08LSDCnAcNS9czj@vger.kernel.org, AJvYcCXcJK5lXOvFDLYO3yxSkTN2K6gWrdkTi0r8vbUC9KNmIw5Q8j26O6JVfNAd6YVmKK7ATs/atzl9nskH8Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Yh1qoQbJ6oTJc5JL9eEVeja3ZK6c0EUAY7EQb1wq7BiIjaK/
	hMPVtRR46ece4SMiB8s8LRivORAYUNZvkg9yIsg7sjbQvCmN3gKn+0uf
X-Gm-Gg: ASbGncvZEKvlIn07jJaqKSFD1dsF9fLkzfHmIwOURmoTjt1nBmr1C5gXylrcSdvz8A/
	1QqTrvYIyJOnxo3NYcKJ2O5z7VmUKh2XEZhbEMN6JaZ7jGuMyNvYNxmffXLnngUcwQYIxI9KJoB
	rc+bFDVZLZCyKRobgYbwv+gycUjUsSpnGQCibdv2Xw6Uv/tlqaPRStY4OG6Eg1lRtDjtahZ+Tjk
	uiYPRPlqmr2uMqHxPO0CXzK2CYDzpBDRT0QSlrqQ89sfqC8z6akpcaqA1r//gcMPAXA0EwuqJIu
	9WgKgRM8byKQlrxAngLo7kgybWDf/9clvcmNTOf7W98zdQoFTm6uLGUbzp4+OE7VqU9JNgRF1pS
	sf7tUus7OyUqhX4g7qEdRmLYLXe9wpcU=
X-Google-Smtp-Source: AGHT+IG3xbtJ7aB6w3otcsf12+CJy2T25OWBiy3cp3FPaOpHfRKzg+mfJFxHOfZ8gH7iNa/hMowAdw==
X-Received: by 2002:a17:902:ecc6:b0:240:b075:577f with SMTP id d9443c01a7336-24247025e7emr152480025ad.37.1754330352555;
        Mon, 04 Aug 2025 10:59:12 -0700 (PDT)
Received: from archlinux ([205.254.163.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b6casm113511255ad.127.2025.08.04.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 10:59:12 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	darwi@linutronix.de,
	sohil.mehta@intel.com,
	peterz@infradead.org,
	ravi.bangoria@amd.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] x86/cpu/intel: Fix the constant_tsc model check for Pentium 4
Date: Mon,  4 Aug 2025 23:29:01 +0530
Message-ID: <20250804175901.13561-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pentium 4's which are INTEL_P4_PRESCOTT (model 0x03) and later have
a constant TSC. This was correctly captured until commit fadb6f569b10
("x86/cpu/intel: Limit the non-architectural constant_tsc model checks").
In that commit, an error was introduced while selecting the last P4
model (0x06) as the upper bound. Model 0x06 was transposed to
INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
simple typo, probably just copying and pasting the wrong P4 model.
Fix the constant TSC logic to cover all later P4 models. End at
INTEL_P4_CEDARMILL which accurately corresponds to the last P4 model.
Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")

Cc: <stable@vger.kernel.org> # v6.15

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Changes since v3:
- Refined changelog

Changes since v2:
- Improve commit message

Changes since v1:
- Fix incorrect logic

---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 076eaa41b8c8..6f5bd5dbc249 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
-	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+	} else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
 		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}
-- 
2.50.1


