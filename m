Return-Path: <stable+bounces-20865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B883C85C436
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12331C23408
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612E12E1D8;
	Tue, 20 Feb 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXAB9I3N"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34F6A01C
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455777; cv=none; b=e/uWPQdK/otVk/Kl48u8DciYgAtk53xKR+fq+IzXIV2nV6zVuYMyPTk6HSgTbr+4rSOs3xXO+CKelRerOBsSokmczmLTJK69GAwHdQP89UVYS1ab0q6FY7zTGDohUdF8CRWOKDyeVMevhZCNHkpR2fngnQcXXr5oIUtvXtJ/GnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455777; c=relaxed/simple;
	bh=Qoze/htoU2x15hkrAN8co6ZkISYxGbqr1cbpqXI8PsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rf5W2In0EGq6AVYcNp1Jq0CmchLuYfCIQzcPKKM/Jy8TaZ3n4BuPhXtTyJ1LNB7s6+6tl+HOra1cn0v7BFf08VU9QyaH0J8JWURyF4/VxFPD+Sps9tSzxdKBQFt2BHpJHpVeC4Yb06lRh/dgq+ab5dvtPwOWqBqRlvZj+DUUtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXAB9I3N; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e613a1baso93540907b3.1
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 11:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708455774; x=1709060574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xP1p0RfYLtRuLGmIaGupO+z+5mHJPnCzMHQ7XKfhV30=;
        b=pXAB9I3NCOsUjc3lmjcPTMJcOidYwUbeA8d2qDakoH8XHjXPmC4z7QmxsrACK568M8
         OZJ7+YIpJaza6Vf4YuvG7+iZ1e6XfnLaoU39WysQJ8gRn1mTu4GFki+kof/fLjqSfR8s
         uO+A8s0JbeisNbYHpcjn+SiLXDDjLjPYOb1nd8cIoNrDzyKXPlePmZ05MzRK8Evq3Thr
         SUxEsft9H0AT1oaB9HpFqT7DjkzSAB5S4gHiWmhJv4teNTRuomZvkxQeLtAuV+3NFcIa
         nhL1MWnRSxaJ9ggBKsyiQ8Op1GBNMxq4j/qFlc/5NLq3uL503mXPLRT7xMTAY/NzQutO
         90xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455774; x=1709060574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP1p0RfYLtRuLGmIaGupO+z+5mHJPnCzMHQ7XKfhV30=;
        b=BSEP5hEA5bzoVbGNKhxoFNzrbF2RtZqnoRdsKkk0nP6vJjhaCOKAmMeIuvvoWA+h3W
         Zed9zHih7B388YgWLmANCTJThp6Ri4+VXJLtkpWDdx/1wIZtUzFIq9nRl3kU4PtMMcCF
         X7oZ8Wb5r18GSnxao+DOsF8GhCko9Zn58xSobwSuqAldVeGW+lteE5+FgiG5oQK0hJPa
         CWQHQy1zivGzbtTnLxb4iJbTBcG/fHOVbfLPusOd12AjeYHjFkBsoNxOnvr2i/6vtIOU
         Vn6cmGroKL75gQr9tFzO/qKIpv+CM8349ICnpwJT/rv0kOumVZB95ISFVGYAYbHeRkye
         jNUw==
X-Gm-Message-State: AOJu0YzyIQbGNGR+AHPPr1SWQqMArCeEFgTI4tcnhiuTzhXc0izTtFs+
	lnjm2HdJkzOI6DxLHdfF1u5i0e8Xi7JsFS5GmBemHSgx4hFGG+76BT++j0oMXQGobYlpDXATj7X
	mcylumLVIZ1rv5qMcjAA8WrvPHMptUPBDpO8N71u9DiC79KLMuKTCJHr8zv89Gzn98Zg82syNZa
	cqzPNPO84h0ZTqgjbRN/t00rAqiybinZrJ
X-Google-Smtp-Source: AGHT+IGOdxEsP2JmU6H/izkvXzKjL4QcWaBX0dpG6a9aoEzuMmKtOaWusnt6GaP5TECqr5vKIhzro/QUQXI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:ca94:87c9:6cd2:68a0])
 (user=surenb job=sendgmr) by 2002:a05:6902:10c2:b0:dc7:4b9:fbc6 with SMTP id
 w2-20020a05690210c200b00dc704b9fbc6mr3992120ybu.10.1708455774468; Tue, 20 Feb
 2024 11:02:54 -0800 (PST)
Date: Tue, 20 Feb 2024 11:02:50 -0800
In-Reply-To: <2024021921-bleak-sputter-5ecf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024021921-bleak-sputter-5ecf@gregkh>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220190250.39021-1-surenb@google.com>
Subject: [PATCH 6.7.y] arch/arm/mm: fix major fault accounting when retrying
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


