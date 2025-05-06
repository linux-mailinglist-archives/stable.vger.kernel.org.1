Return-Path: <stable+bounces-141776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91174AAC072
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 11:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300CC7B84E1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088926FDAA;
	Tue,  6 May 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RXqv3cK7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79626A08A
	for <stable@vger.kernel.org>; Tue,  6 May 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525182; cv=none; b=UbtGO0owKsbjURoQyg+MUZbQJmc9iBFqsaQh9hCgOJftqx2qhj6Uf4kar7YSNg9lyzNHDns7Is/onQzSi3onWcMm55c0k15gRG8xKzEF++rhdi0LYEM3eotlcmUEQngsCffQMts6i8GFTiHfN8Q0/sTpfokX1j2+rvU8f1z9Q6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525182; c=relaxed/simple;
	bh=CbHRAffdNjucoHpZXlzmBTKwF5V0Do7COpLf3OhpD0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZTL0IrDewlJcBJs6gaS4N0onjYgErWpcEv5bY/kOG4KjPLoLtpc7jav3rvf2x8351dGh1hxN9Etg+9469T2IWdD9RfcTSZA2jgCSH3I0aZy75eNVVbKJwjUYFx8+VI3jvt+kPGP/6acJfz7izuI2ZbQhSKyDTFbN2euLKOl3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RXqv3cK7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf89f81c5so5421025e9.2
        for <stable@vger.kernel.org>; Tue, 06 May 2025 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746525179; x=1747129979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhaFKze9VG1/eFCN9G58dM2RFBh4W36ZYcYCtz7qr9g=;
        b=RXqv3cK7rRFChYbgFdR43xbzz/tnvAGl8gWurpyzVTyR0O1qtiEd1TfWIc3Pr6pjqV
         6eHAfCEZ8d8vMMQEavhveavR6khIB7Kc0gKp0g7bOZZGrC8xjMOSRqaK9hRj1F/uMCkt
         3I7S8hVGdg4orYl7PVIRl026+dO5TBeZ9qOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746525179; x=1747129979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhaFKze9VG1/eFCN9G58dM2RFBh4W36ZYcYCtz7qr9g=;
        b=f4QfsE4WiiBnk6t2Mv/oaCTRHKbwOKGbWZLKNkFfFxNbE+1Uu9PtQCsqarbTe0Ol7s
         qlwVx0wH6blrML3oRXltsMmj2WknzghACMkhjqJ69SQ9C06ir3kjnlr2bkumwu234VvM
         fIBNK+wbhjJpdjctHR9ERL+RoKBQvKbh0T+D+sUnmNMBbpP5/S6lwuXcQ18TK2ovWuig
         6jMzvWPwfOf4qKY8X4aZ0IPF4jfuLj0fZ2W4AAp4IeMdahgd94V+9ygih/cB+zv23WJE
         UexHcBoQBVDPleQidyp7QOFPvvmxnuzsjGcFtlqqvll87bFYJho2jT3Qph3UuaD+KOUS
         pXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVvEf7TwfXGb3neoxgC6Aa0vohC9gkk8uVBHtcMh1rQvKbDCMFq2CnFgGcVmWB1zsBPdc69js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/py+HG5vLqKdNV0VnGSgaMJVuIpJcdxH1qeEKILNfXbi1wGa
	aTM9637zYul2ctTvvMNlPgOA3OTIiI6Ptbp/ruTp1GxSTB5hFeGfLOO9xS9bxQ==
X-Gm-Gg: ASbGncvWSPAZ7iyninN4aeaakzvvcR3qOmN7AvitxIL/Iai911pB+ybXsdu9cuCv/9m
	92pOegjX1lQtV7uQQ57EKDBGq49sKI/lN/mk+f7VkyXQOtO1vOekB4MZH/lkKcC/knrWG6hYl0L
	IoMujvE8At1rzcJhT16EQlm1+oWw1KhH+CFfHzjdhPKO9QeA0+N3Pq0XP9OYc10eD9CuPUrS2sH
	RbuI+IG77ygQGv6rFXfEfmW79Fg9af4/CVRX+tFmQg1TliHfZltZeCgMiWsg7dCt8sc25thaNub
	/qnAZknM7MOWLDIbaZ4SOAoZ8BltOLDqnDYIwuUuf5z6TF+xYFt/j8Ug
X-Google-Smtp-Source: AGHT+IHeK+dFXjh9OrxfzRPfPF/LOpOuNNkj7QNpkKx/cJ7vvnj2X+5i334G41Ez0rqAejsL1kXepA==
X-Received: by 2002:a05:600c:1382:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-441bbec38b2mr52734125e9.3.1746525178968;
        Tue, 06 May 2025 02:52:58 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:7196:3093:b0e3:1016])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7a46sm12879860f8f.44.2025.05.06.02.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:52:58 -0700 (PDT)
From: Florent Revest <revest@chromium.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	thiago.bauermann@linaro.org,
	jackmanb@google.com,
	Florent Revest <revest@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] mm: fix VM_UFFD_MINOR == VM_SHADOW_STACK on USERFAULTFD=y && ARM64_GCS=y
Date: Tue,  6 May 2025 11:52:21 +0200
Message-ID: <20250506095224.176085-2-revest@chromium.org>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
In-Reply-To: <20250506095224.176085-1-revest@chromium.org>
References: <20250506095224.176085-1-revest@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On configs with CONFIG_ARM64_GCS=y, VM_SHADOW_STACK is bit 38.
On configs with CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y (selected by
CONFIG_ARM64 when CONFIG_USERFAULTFD=y), VM_UFFD_MINOR is _also_ bit 38.

This bit being shared by two different VMA flags could lead to all sorts
of unintended behaviors. Presumably, a process could maybe call into
userfaultfd in a way that disables the shadow stack vma flag. I can't
think of any attack where this would help (presumably, if an attacker
tries to disable shadow stacks, they are trying to hijack control flow
so can't arbitrarily call into userfaultfd yet anyway) but this still
feels somewhat scary.

Fixes: ae80e1629aea ("mm: Define VM_SHADOW_STACK for arm64 when we support GCS")
Cc: <stable@vger.kernel.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf55206935c46..fdda6b16263b3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -385,7 +385,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-# define VM_UFFD_MINOR_BIT	38
+# define VM_UFFD_MINOR_BIT	41
 # define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
 #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 # define VM_UFFD_MINOR		VM_NONE
-- 
2.49.0.967.g6a0df3ecc3-goog


