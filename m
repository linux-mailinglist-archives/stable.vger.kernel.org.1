Return-Path: <stable+bounces-204342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB38CEC006
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340403021E4B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3813164B6;
	Wed, 31 Dec 2025 12:44:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44939314D26
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767185067; cv=none; b=rD/yCUeDm2fhxISVhOF6/+/c3HnFDctsAtGjkh6WQLvccsXC2ozyjIhb9yiwAxPWHQvst4FH2ckFVITalbcWv7Rmm5fQPDxxiDV5K3S58tcUSjaHPCeny1fsB9yJchuvpen3UzEknXXrUmdl/MX0pW0hbY9BGXUXB02UJRnbRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767185067; c=relaxed/simple;
	bh=rtQ9YOzpTI1rtYAALDX3LhmxVAFBXeE/3oqvYKuAQ8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BucXlnmXKuH4s6Gv9B0hCjDI/rpderU4XQyQLDx96PESZJJQ/8Q8TWFJbYX/NdzPQGhLDCXznSsF2SdwHlFZZEy3Yo2eDnsPc7aOING8dKST33l1BS8DFCRVqT+by7PA7kSU7tms39+JkTV8IEcHs5sM79bmc5MXZBmE9wPaEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c75b829eb6so6840485a34.1
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 04:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767185065; x=1767789865;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doIBT3kveDHefqqmJXIbpBpDJYXHZZ9gY6YG0CQ1W1s=;
        b=isOhlsbGO91e7/W2tiVNH6lC1c7V5ny9kE0U2Zbr14KjW0/552BiQRc3+QPCZcwdGa
         GlWzhMfnIyz04SwBD4LsjYPWkz/9YTVz5tVCy2VTAJW0+et/PUobPEPN8j3iOU5GuRv4
         /AiYsQFRVEmE4JkI9IknGLqOjOAdVzNji6oUJqYVbBO/rkFAaWUqJT6l5fdM+1Jk1be8
         TyDzBzM7CDzFm2uk9S/LwD0HuZKefDJkqJdEthKwH1BTP+Mx/eIDNxl4tOYJ3VMz9HFq
         Ni5ynJ0OsSGaSSV83QzuIZEktANc5mTl1FDXhBo6VZXBwqJGfNwyfr7nHXW9JLO5eiSZ
         oYTA==
X-Forwarded-Encrypted: i=1; AJvYcCXaRxWgqlxShtYUiE2awsP/YJ4aNO4fWSiIzcTqst2FDLx81wnlh34jPIULtF7n+HFWEFpKDGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZCy0xIoyVdzTrm6D05WH+kc6cjFYoTbUEtpTjFN4OVyMr398
	ki8dky9yPzzoErNmQ1LwX/7fIeafcZLlGjiYWhy13QjkSI6AI+yQPSWW
X-Gm-Gg: AY/fxX5wHEm730bORWLaQnp2fsPtHaCHxZ++tXJ3ONvS2B6gaR0rlIizhRKmISyLefd
	tEqKPmdTfyZ41CXZLAFrnNEbX2T24bXhpZtfq1cUFWLyvpsU//H8qtrdx1YwbYGoKnh1pkXRlbX
	02u82390y61mwd5mimQbarPOduu+7esFbfqnroIrJN0DtZoHTsEhkzWiOhuKNhL0QJmA/F84LIe
	Fs4jPk4A0iDCFJR3OrNjUOLKkX7M29Zz5X9RNjLI0a1fmamhcI6B+9aA0zQkA9bXpf1MSklT/gw
	j3NfNDlH3D9B3L2VJQK8UjgrF8zuCpcdspnKwwi3HQ2lmjj3TU0RqzIyQ2LlMUhKzwbrHKNCgjZ
	MiyCB7PuO+CqRjTamqsvIKPkcg71F+qq49GGKKFJPQvMvsJJHGbReU829uHeV+i+VjPR4exuGhG
	f9ojcvqlIDGw==
X-Google-Smtp-Source: AGHT+IFVj7a9FUlEf5NH6KpIT/kaUw0oiLWglRHiOzK9tALgQw37NwF6rJUHBW5v0Oj+IkC3OkEsQw==
X-Received: by 2002:a05:6830:3154:b0:7c1:12c5:334e with SMTP id 46e09a7af769-7cc66a023c7mr23119448a34.17.1767185065067;
        Wed, 31 Dec 2025 04:44:25 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d6b04sm24557658a34.16.2025.12.31.04.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 04:44:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 31 Dec 2025 04:44:05 -0800
Subject: [PATCH] arm64/mm: Fix annotated branch unbootable kernel
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-annotated-v1-1-9db1c0d03062@debian.org>
X-B4-Tracking: v=1; b=H4sIAJUaVWkC/yXMwQqEIBQF0F953HVCKhH4KzEL01e9FjaoxUD07
 0O1PJtzonAWLnB0IvMhRbYER7ohhMWnmZVEOIJpTaeN1cqntFVfOaq+i2wna0PsRzSEb+ZJfs8
 1fF6XfVw51DvAdf0Be9PcO20AAAA=
X-Change-ID: 20251231-annotated-75de3f33cd7b
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Laura Abbott <labbott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, puranjay@kernel.org, 
 usamaarif642@gmail.com, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=leitao@debian.org;
 h=from:subject:message-id; bh=rtQ9YOzpTI1rtYAALDX3LhmxVAFBXeE/3oqvYKuAQ8c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpVRqoMlyZ1wZ3Pzr1vXtCo85272KEY4xVGFmrE
 b2oMh6CVkmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVUaqAAKCRA1o5Of/Hh3
 bQZwEACnPfBsC/ChcFSyk6SAwxKoOvb1ERUF80rfaNxXBJiaA1VgbqM7C/wBw+YbXrQmhzVqY/e
 zB/ndUjEg1Qw/f1EkWqLpRYykPjwyQ/nZsHL8RUh+lvvsu2vH83B4FgCIL991+rvhDFZW75ecWY
 Wx27xdC7xpaYRNPR/lCGRyKw9GRdkZybGZhUqed7Tu0UwVGNJkdEonPSWzsyXQhxdAKqPkaTXwP
 yI+5HdfEAuA8nCB56AYgRaMxUUmY+Gg0JtwVD5CS/lsrFAcsngfXp0I0h2TMFDOYF1Hlwo5ZZ/z
 w8qA3nMwS0murcRCerIFfvy/jgPPx+OW9JE1WcwbAEDqZjXSQ/Po0ENzua7Nu8JciG9+Xf46Ikv
 xH/PK9ICIZQsNLJszbbllCh6smeoREyPb7MLH7utDd9lbPy0K7ALIeJJJOM77UoSBmIX3yJlEl8
 8FLJGGRpDH2/y2YbFkzWthRAgG9qFm3dVwpY8HtXJsFRnxAb2lQW3w99ahtwb5b+WzXzGXSaks4
 csHXIdZitAVmfvtZvoZc2hJ9fpfI2ggf5vrK2Z+gT7SN4VIA6agvZWESHTh3BpTcabZIWqPxwIl
 7GUbaPEl3NeaOpCjDiB438p2p4W5UwQstGYeLrTvFjKj8PLdWHg5liU52jhLlKSvVXXC2iAk+iL
 +BJxQOoAcO2C7tA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The arm64 kernel doesn't boot with annotated branches
(PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.

Bisecting it, I found that disabling branch profiling in arch/arm64/mm
solved the problem. Narrowing down a bit further, I found that
physaddr.c is the file that needs to have branch profiling disabled to
get the machine to boot.

I suspect that it might invoke some ftrace helper very early in the boot
process and ftrace is still not enabled(!?).

Disable branch profiling for physaddr.o to allow booting an arm64
machine with CONFIG_PROFILE_ANNOTATED_BRANCHES and
CONFIG_DEBUG_VIRTUAL together.

Cc: stable@vger.kernel.org
Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Another approach is to disable profiling on all arch/arm64 code, similarly to
x86, where DISABLE_BRANCH_PROFILING is called for all arch/x86 code. See
commit 2cbb20b008dba ("tracing: Disable branch profiling in noinstr
code").
---
 arch/arm64/mm/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index c26489cf96cd..8bfe2451ea26 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -14,5 +14,10 @@ obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
 obj-$(CONFIG_ARM64_GCS)		+= gcs.o
 KASAN_SANITIZE_physaddr.o	+= n
 
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_physaddr.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 obj-$(CONFIG_KASAN)		+= kasan_init.o
 KASAN_SANITIZE_kasan_init.o	:= n

---
base-commit: c8ebd433459bcbf068682b09544e830acd7ed222
change-id: 20251231-annotated-75de3f33cd7b

Best regards,
--  
Breno Leitao <leitao@debian.org>


