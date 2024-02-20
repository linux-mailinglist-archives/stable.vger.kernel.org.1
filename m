Return-Path: <stable+bounces-20867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C777F85C439
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E6C1F246C7
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B112F5AC;
	Tue, 20 Feb 2024 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTUuN9zK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEDA12EBEC
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455839; cv=none; b=KNslJhCa6xBsHKaN1Qg31RnXgzpQV3hQgHLObTQ3Rz69edAp7PNQgC8nTLrmzos+YcpuQ10F0AQfro2oLbl8puwyit7tbroWzDQ3qrSgQ6HutfNtnBqMvNsBxg0/o5t1/96FYKy6jAnZsUM4zpudRzXLpuAfeNLchIoBfKzhCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455839; c=relaxed/simple;
	bh=Qoze/htoU2x15hkrAN8co6ZkISYxGbqr1cbpqXI8PsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Puuxqfup1VQbHWmhnQw6LnlR2VpqNODdNattwkwqJOjmdjowz+IlNqgOUcfl+SBDXwhaEdg5i6Yq1w65Y6lThjRIBd1T+xIYTyvyLJU/Ur6YOt8VZOp6pZAt87ayLgDma+zBr7YsLhqnEHsUsFEewnxvUwphtCQ5kpP0Vn2TLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTUuN9zK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so9181991276.1
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 11:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708455837; x=1709060637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xP1p0RfYLtRuLGmIaGupO+z+5mHJPnCzMHQ7XKfhV30=;
        b=vTUuN9zKxgbKMCFeRyMIcB+gtj/H5A+GVy6vKCP/GRzD3I5Mx/eVSqMBtn0D0Zkq8I
         Mu3/J3yUVrROkLMsb15ldU8FvdpOH4OhPb6kxk55tzTDLZJ0QSxmyPX8ekoObh5JrA2I
         c8fAyV73eZ2Ek8bif969JkKt0svBh/aggOiCUNC83pg5IOEd0OZb1/PNXbwsFCaKouvq
         sWMPYuegIuEone07DRS3cIaV1zSMNiJsLEqw11lNWDK50Es9vlEXFaC2079f/MK33TTv
         r2nEbvxbNTC8AW3zRm+iFh6MCZxaLpAuQ08ieQ+GHd9L8guWsDk8ciLXYquPe2m2+bMy
         jGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455837; x=1709060637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP1p0RfYLtRuLGmIaGupO+z+5mHJPnCzMHQ7XKfhV30=;
        b=gIs3wxirqw2a29/hsyjG1eIkFoYII2RwrXiI5zmYOf7rVBq3wVvfysOmpRrn2nk0K+
         F5sph2psv61K5qKhhv/EeAMd/QfoZkGPsY32C4T8lN01bFTcFTpF1GNhpOW4Eh29z9Ji
         0/L2uPg2gPVIOmWGctaWP5ciiERoaXEYBTrvg2kE230/I6E4kVTt3f+ULlmx95t1z88u
         bPBfYnFpXnpAT2FeHXhbtO359MP5WasdB+W4o7uF1VvT9vIeRFqvta4dY63M7NTPyGuK
         kTL8IDNzgJGYx5349B6vpRcBpokQQrHQRjZf1UgAYzcmUbqDuF0UqdbbosM+atSOr+r5
         FF8A==
X-Gm-Message-State: AOJu0Yyo+zfMYI/vhJ/7bqYZ48CGrjvt4cdL4DAfZGfAS0bBruLTJ6VU
	9Rs9vbLJckpfmXr68TVbu8cP7XNSxun9t4wLzmicxnZ7G7/jYa2VDVGvNoyyPdxbfa/veSKlsPF
	Yb7jYNgCpBlPn1s11QV7aAM3GmyHmfjyvHj+20wTdQPZuFqDgq6a7FxkD8H+lct6+puigk+I/ez
	jpLIH3YRsQNM2nj7rUVJorEOsN02xklbhp
X-Google-Smtp-Source: AGHT+IFtRzodtvJvMqN0BApE7mLjnn7Ru7vZ2HxMrxe2HRYw3wo6XhKSB1iIa/ogcWm8sa91IxMDIS3ammA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:ca94:87c9:6cd2:68a0])
 (user=surenb job=sendgmr) by 2002:a05:6902:110a:b0:dc2:398d:a671 with SMTP id
 o10-20020a056902110a00b00dc2398da671mr4028003ybu.10.1708455837287; Tue, 20
 Feb 2024 11:03:57 -0800 (PST)
Date: Tue, 20 Feb 2024 11:03:51 -0800
In-Reply-To: <20240220190351.39815-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024021921-bleak-sputter-5ecf@gregkh> <20240220190351.39815-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220190351.39815-2-surenb@google.com>
Subject: [PATCH 2/2] arch/arm/mm: fix major fault accounting when retrying
 under per-VMA lock
From: Suren Baghdasaryan <surenb@google.com>
To: stable@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

The change [1] missed ARM architecture when fixing major fault accounting
for page fault retry under per-VMA lock.

The user-visible effects is that it restores correct major fault
accounting that was broken after [2] was merged in 6.7 kernel. The
more detailed description is in [3] and this patch simply adds the
same fix to ARM architecture which I missed in [3].

Add missing code to fix ARM architecture fault accounting.

[1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retrying under per-VMA lock")
[2] https://lore.kernel.org/all/20231006195318.4087158-6-willy@infradead.org/
[3] https://lore.kernel.org/all/20231226214610.109282-1-surenb@google.com/

Link: https://lkml.kernel.org/r/20240123064305.2829244-1-surenb@google.com
Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")
Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e96fb40b9cc3..07565b593ed6 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -298,6 +298,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
-- 
2.44.0.rc0.258.g7320e95886-goog


