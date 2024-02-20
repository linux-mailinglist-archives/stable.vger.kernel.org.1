Return-Path: <stable+bounces-20866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E3485C438
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867831C22DE2
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2322C12E1D8;
	Tue, 20 Feb 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ceOovhg"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31478B51
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455837; cv=none; b=lSlXFjacUyc8++F+tij4VWZW/e0Yzwdc1EtZGoIS1DkwJXy/Zn6OcR1zF+iwiyOVo5k+876zAMXMEyho9Kc8Ppy7AR9T/YWUq0tCm7t9g6lZQWS5EwWQIbqt2605LRnLOuKQjV630SiInLSEQey7c/1dX/1FyLbl7HSU+ZgrmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455837; c=relaxed/simple;
	bh=7IjtTn4XG8QYAyLq2UhjyqSoyurV4DwQIJeexOoQYnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gH6WNTC0lzXo4lkQFGtss+BKv3H7BIXxLqd2hrhI8/AmuYbsMPQ21ufRI1Cz9y5LSKsx1NcPjsnSrpBTm9v8v7+NXNy0jLN/1wPAG3e3mK+77f4pKIz21Z0wcc60Ul5YFYFWqdgHYBtc1a3mDUQJICFFehGlhIAhiu9TNbGxQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ceOovhg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60810219282so37216197b3.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 11:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708455835; x=1709060635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jKZ4KiC4kkq1KhbZI20dsIsyhfJ696TE/LFJygR6/Y=;
        b=0ceOovhgexVLBloVmmWqw5LN5XlmETJP+DohSEHv5erJgghU+MDSvYUrjy9NX1gU0V
         YQbTtb4xz3LEFX0ELvYWGvcJ3STc7VZkZHmXITiAuqwQ+WcDevBy7ys4rpZZ83LfYl75
         ey5w7Nomuw+wGedbJlpHV/v4OJYhNWNamAKMSHCYksbtbT6ChRbDcRUdZuTBoMoOkoA0
         nItBylfcYi/cXcnsIZtlVXBcg0XiRXEfCvjQ99yDmlBz+L7HwIS/+gmxBiTvkJdreR1o
         vyEGgsOp2kyQDcZDUXJ6qbH3j/mYNQ9rP+xYmaf3uddyQRJj/LT6a/TKhPG2MaDw5YmH
         JRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455835; x=1709060635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jKZ4KiC4kkq1KhbZI20dsIsyhfJ696TE/LFJygR6/Y=;
        b=V+XsgJEWbhkOGv2U+qBjO2gLER6cSv1lnVeqUN+rEK5v1VyRgbxXsSrMG1zmJ60S53
         /30wn186/ZCiS/RsfOaxW6RuRMsDfduglKfIYC1pFdmdR5NONuYyKBhOPk7kNWvXTAoi
         WEXTKHYhY6nGSWwoGFlcP1MYznWCik8lNO321O6SAm3tUaEQt/9s746lRnsyGQmP1LDz
         iPNz04lwYGgwoNQ9Eb4042BYmcPc5mPj9A3SGaB4lwCvBIIcEoxXX1cTERXDG8WO0s1b
         oPWKv8NyHUFuaRx/ja/8N3iHhENlz5niSdBziy5Eqr686KIJkvLLTdwKIi3WCOwjNp3i
         /i+Q==
X-Gm-Message-State: AOJu0Yy4L6gJFADAOB2xN7kN4BBrxdQvfEI03bi+Zu6dgc5iDdU3ccDQ
	IcHhA/Mtxs0stv23DuRKGWpcUbkI6VFJafAgqOhCtQ+1oHtYBf1DJW8FhUYQ1eFA4WAmwn2C4i3
	04zTUh6JkoK1nr0MUQP9ZfAybA7E7VfZq8/BnENpzsaRyyQCRKwjW4lh8db+2W0NbxOGT/NarIm
	ATtJo06qQP5jyl8j1J9jhlNJMmQsiLlrnx
X-Google-Smtp-Source: AGHT+IE9t4losynPcFuoQRAx6OTSJ4m2hNeD5nlbqMJoOTLRdumVaAAcYh3Wh1+QwIOoSk0kZs5/nznLVV4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:ca94:87c9:6cd2:68a0])
 (user=surenb job=sendgmr) by 2002:a0d:c946:0:b0:602:b7ce:f382 with SMTP id
 l67-20020a0dc946000000b00602b7cef382mr2997437ywd.7.1708455835242; Tue, 20 Feb
 2024 11:03:55 -0800 (PST)
Date: Tue, 20 Feb 2024 11:03:50 -0800
In-Reply-To: <2024021921-bleak-sputter-5ecf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024021921-bleak-sputter-5ecf@gregkh>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220190351.39815-1-surenb@google.com>
Subject: [PATCH 1/2] ARM: 9328/1: mm: try VMA lock-based page fault handling first
From: Suren Baghdasaryan <surenb@google.com>
To: stable@vger.kernel.org
Cc: Wang Kefeng <wangkefeng.wang@huawei.com>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Wang Kefeng <wangkefeng.wang@huawei.com>

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails, the ebizzy benchmark
shows 25% improvement on qemu with 2 cpus.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm/Kconfig    |  1 +
 arch/arm/mm/fault.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8567e95f98b..8f47d6762ea4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -35,6 +35,7 @@ config ARM
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index fef62e4a9edd..e96fb40b9cc3 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -278,6 +278,35 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+	if (!(flags & FAULT_FLAG_USER))
+		goto lock_mmap;
+
+	vma = lock_vma_under_rcu(mm, addr);
+	if (!vma)
+		goto lock_mmap;
+
+	if (!(vma->vm_flags & vm_flags)) {
+		vma_end_read(vma);
+		goto lock_mmap;
+	}
+	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
+lock_mmap:
+
 retry:
 	vma = lock_mm_and_find_vma(mm, addr, regs);
 	if (unlikely(!vma)) {
@@ -316,6 +345,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	}
 
 	mmap_read_unlock(mm);
+done:
 
 	/*
 	 * Handle the "normal" case first - VM_FAULT_MAJOR
-- 
2.44.0.rc0.258.g7320e95886-goog


