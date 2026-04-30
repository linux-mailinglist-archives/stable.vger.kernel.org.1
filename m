Return-Path: <stable+bounces-242181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMZiKEmW82nO5AEAu9opvQ
	(envelope-from <stable+bounces-242181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:50:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 083614A6979
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BBB6306FDB4
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227EC478868;
	Thu, 30 Apr 2026 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDv9iBza"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7A478846
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571275; cv=none; b=cJTaIfhjTx7Ygu01LY3wX9/W5PZ3M+hxg4pqFhCAipEC9127W6FkNaojk1M64OB7tSIVBYsKEI9ByrjVJivw1KCwI4JicMuZK5GOneAL2JiGlulcTy7hMfRzU34Zf/9rWsjPUXDBUCLI9Hfyga334VBJ9Bfd6eVipqDswJlnDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571275; c=relaxed/simple;
	bh=i53XZEuTl+1wWVbmiTcbm5ejur7Mq35JidjF66bR1d8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fpPNQe9puoASq8KmDD0AWmwwj5Vj6QHP2L5wP59RPa2Dw6yatyvYoRw1WUjhiayAj/Lhw5jWI4LM6RRvqx+29LtJIuqqekxScEEZzzCjStoBON25u6VBAuwPnwSNEzn3M1EvFq6/NKuBB7nO0AJQsYTYYrTunPFTTJGv5Jr6u1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDv9iBza; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b69fb9d6so1284499a12.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777571274; x=1778176074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0CWZrzlBiCnsBpZbvCghxoqDP1g1LPCQocNMdZ1pgU=;
        b=PDv9iBza5lQcTv7p0ABEQan8rmfPP6TI3JKZXMts9WlACpPVMrGLO5FNzU2CKdOLHU
         0AIvirQikc4TsvTHiKCBKx0qL6pGFgBPQJPfATn+kzroMKH53ozq1Mu5ZmzcsujzsOFu
         1E5PRHvBFb796aruQjUFnnjzxmWmQyqUdxdw6ABEy+/HUp4BEA8qNPc+ltiBSzt0Zjyr
         LHpTRTpgHm1kud0Tc1hU71SZfNW7B9AMRzH8bE39Pwf+C8yTj1g412s8EPsqSzgv4/5K
         tCopaHpkYjWJlCL/aNF32oMqawbwu/SaMEg2x4LOJAzbFX+DPbPcG3s6LjBbltTWW/em
         PVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777571274; x=1778176074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0CWZrzlBiCnsBpZbvCghxoqDP1g1LPCQocNMdZ1pgU=;
        b=kUbql8pWz9mmG+Sj/pwN9H1STjiiaW3md+ekzxlbF3WLMKl781HluciviiU2JC57MT
         Y0AHT2RsBEuLg/QXOKtMc9hFmOaRgiry8MQZ+ECuFZ9tn6HGx3QZF6BgeN61ZYeoiakp
         kYVCHN33E+5CKQe8MlUfl8AKjd27ZLrGAd9PTi43r2KNgPE3kCodhyBkdQTNJCgN0JQ7
         Wg5qosgwo/J8qW4hoyvSO9Jiv+PuLTCBqm9en7Zw9PzXP0sL+RN6lEOSueVxGPLWIcYV
         Hlmg2Tfc//iUUkZg3cSVvv2gVkJgDto9V9T1pmqMBmazDJYWyUzXpnafXkeV0nyGD/Vy
         JJCg==
X-Gm-Message-State: AOJu0YwlwsgfIuPnG9MUxVkXdC8MQg8WPPqhhXf3+T3OyoUQIgQrDY6F
	JrJRyxG6QF8EP6jL+tcby456FIYDSG8wbXq12Q+kX5QpeBqP7vHFulx96fRrPxLdSp9z3QiLQh5
	QsHZkeA==
X-Received: from pga9.prod.google.com ([2002:a05:6a02:4f89:b0:c7b:a9e3:ecbd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a1:b0:3a2:ed4a:5d81
 with SMTP id adf61e73a8af0-3a3d1d5d12bmr3726333637.11.1777571273607; Thu, 30
 Apr 2026 10:47:53 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:47:52 -0700
In-Reply-To: <20260428214610.2138600-7-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428214610.2138600-1-d-tatianin@yandex-team.ru> <20260428214610.2138600-7-d-tatianin@yandex-team.ru>
Message-ID: <afOVyJFV6zy9Jcbz@google.com>
Subject: Re: [PATCH 6.6.y v1 6/6] KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on
 0 <=> 1 VM count transitions
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
	Nikunj A Dadhania <nikunj@amd.com>, Michael Larabel <Michael@michaellarabel.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 083614A6979
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242181-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yandex-team.ru:email,alien8.de:email]

On Wed, Apr 29, 2026, Daniil Tatianin wrote:
> [ Upstream commit e3417ab75ab2e7dca6372a1bfa26b1be3ac5889e ]
> 
> Set the magic BP_SPEC_REDUCE bit to mitigate SRSO when running VMs if and
> only if KVM has at least one active VM.  Leaving the bit set at all times
> unfortunately degrades performance by a wee bit more than expected.
> 
> Use a dedicated spinlock and counter instead of hooking virtualization
> enablement, as changing the behavior of kvm.enable_virt_at_load based on
> SRSO_BP_SPEC_REDUCE is painful, and has its own drawbacks, e.g. could
> result in performance issues for flows that are sensitive to VM creation
> latency.
> 
> Defer setting BP_SPEC_REDUCE until VMRUN is imminent to avoid impacting
> performance on CPUs that aren't running VMs, e.g. if a setup is using
> housekeeping CPUs.  Setting BP_SPEC_REDUCE in task context, i.e. without
> blasting IPIs to all CPUs, also helps avoid serializing 1<=>N transitions
> without incurring a gross amount of complexity (see the Link for details
> on how ugly coordinating via IPIs gets).
> 
> Link: https://lore.kernel.org/all/aBOnzNCngyS_pQIW@google.com
> Fixes: 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX")
> Reported-by: Michael Larabel <Michael@michaellarabel.com>
> Closes: https://www.phoronix.com/review/linux-615-amd-regression
> Cc: Borislav Petkov <bp@alien8.de>
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20250505180300.973137-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

