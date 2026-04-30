Return-Path: <stable+bounces-242180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIESLsiV82nR5AEAu9opvQ
	(envelope-from <stable+bounces-242180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:47:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B3E4A68FA
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A1D3026AA8
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4031478E45;
	Thu, 30 Apr 2026 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaA7Qyj1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874E42E01C
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571265; cv=none; b=ksAiE+GeKoXxs3xJrqWdOKYSYL5mVsyr/UOJQ0dNZ0bCDQBBS27UWUPDfCmEgsC0TFyNebVKnbvA+511ZrjSYI/Uqzh18m85uoTGE/uyaOl13k/TianJyszK63sS10Gc56A4gB6FvqHE+QTGfStXeoMzjjD/ExxsUocCnpJ7VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571265; c=relaxed/simple;
	bh=5EJ30Gqtru62HMMBfPeGqMrURbVi60vosZt3XIpYxNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wr+PO1JAq6fZLEhHcDeI4shXQiVgy/fHQ2S3pIUwNbZreLibarncqrXJq3fQtlDur+dSQ+kaTS3SLNWIIgYMTOknxeBzyd0cGuub1AoaOAw7dU+08b2GI72NXN1/HT1cVk7zroThpRoOxeOqGQAuNSqKnT9ORQVD7S5XtVtlebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaA7Qyj1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f460260cfso1287154b3a.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777571263; x=1778176063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSvwP/DPP5VMidfSJOprDmf1oGMfmtIRMut8JZvMh6c=;
        b=IaA7Qyj1DxqNcFHqOFRX0IEhg9BLYF4+Gxl5fA9+B8B2FWzeb271lJ2OueRK6Ey6IO
         M1W67lnwhak2ZvXfePau7cgPX0KoPDp/gh47se694+LybWsV2fxHaqM+zuMBulTZmyi2
         +a3BIZlCSNG8+WjhHOWwTeFSq+7I/s2va5gsCN/q4yEg+RqbYnuyCRsZpOFznoYA7W96
         Jd0PmkmC8d53Rn0PkuRnNNgKOS22NwIa/tuT/Y4Tyun4fH3zNlMeSlR1tuJyv3L9BciV
         k6SQGTXFQAovOjWwWtLFQhOtEqftap7F1YzwArgh506buk8KVyA8elxcYV4QRBwiWic0
         HtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777571263; x=1778176063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSvwP/DPP5VMidfSJOprDmf1oGMfmtIRMut8JZvMh6c=;
        b=LhHOdsIlwechj9nz3z9b8YZDpHueujerJ4nHst5/ezmzqVdTut/tvyeBUn/HQT+7ey
         M81dJ1oO/bG5+7O8ItgqxR9lrnGEy8pTldr9i2CBx1lDbW5BhlPWPtiiOVJTDylP0YqY
         qVML0TysknIBCykvm3tgujuSO/DJEZ3ixMl/kRL76iIqfDlNRfGzVT7W69tCiSSIVFam
         gRV2qA2XSTP2fKph0pWEF/Qa3mDQp3/HATRQCnYN+++RI7DRpEMDr3ALHC14GnRF8BS4
         7daKGz6QBL31wrWbAqfUBtGAXTcAXWAni17QnSrmpcFufSqKhxoPU3b30C6N1QRbWMEc
         927A==
X-Gm-Message-State: AOJu0Yy4fInsysYj/YElPEChon+CHd5bgWjbZ/qUOgvNaDb8GYPihtOM
	xPrAjIZ4nkLVU1WkG9n0lQPgpVlZIswZkLQJJk8c4lt5avg1bC1PWe5k6mXUXG8Su47B3gyNl3P
	hf3RZHQ==
X-Received: from pfbbk25.prod.google.com ([2002:aa7:8319:0:b0:82f:b853:3ba7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c83:b0:81e:12f1:d8a
 with SMTP id d2e1a72fcca58-834fdc29e0bmr4940712b3a.34.1777571263381; Thu, 30
 Apr 2026 10:47:43 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:47:41 -0700
In-Reply-To: <20260428214610.2138600-6-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428214610.2138600-1-d-tatianin@yandex-team.ru> <20260428214610.2138600-6-d-tatianin@yandex-team.ru>
Message-ID: <afOVvcKlpPoD7O6M@google.com>
Subject: Re: [PATCH 6.6.y v1 5/6] x86/bugs: KVM: Add support for SRSO_MSR_FIX
From: Sean Christopherson <seanjc@google.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Sasha Levin <sashal@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 07B3E4A68FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242180-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026, Daniil Tatianin wrote:
> [ Upstream commit 8442df2b49ed9bcd67833ad4f091d15ac91efd00 ]
> 
> Add support for
> 
>   CPUID Fn8000_0021_EAX[31] (SRSO_MSR_FIX). If this bit is 1, it
>   indicates that software may use MSR BP_CFG[BpSpecReduce] to mitigate
>   SRSO.
> 
> Enable BpSpecReduce to mitigate SRSO across guest/host boundaries.
> 
> Switch back to enabling the bit when virtualization is enabled and to
> clear the bit when virtualization is disabled because using a MSR slot
> would clear the bit when the guest is exited and any training the guest
> has done, would potentially influence the host kernel when execution
> enters the kernel and hasn't VMRUN the guest yet.
> 
> More detail on the public thread in Link below.
> 
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20241202120416.6054-1-bp@kernel.org
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  Documentation/admin-guide/hw-vuln/srso.rst | 13 ++++++++++++
>  arch/x86/include/asm/cpufeatures.h         |  4 ++++
>  arch/x86/include/asm/msr-index.h           |  1 +
>  arch/x86/kernel/cpu/bugs.c                 | 24 ++++++++++++++++++----
>  arch/x86/kvm/svm/svm.c                     |  6 ++++++
>  arch/x86/lib/msr.c                         |  2 ++
>  6 files changed, 46 insertions(+), 4 deletions(-)

For the KVM changes,

Acked-by: Sean Christopherson <seanjc@google.com>

