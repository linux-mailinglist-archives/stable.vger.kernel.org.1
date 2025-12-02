Return-Path: <stable+bounces-198110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702E9C9C130
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 17:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118643A2D94
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3D6270557;
	Tue,  2 Dec 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="masZH/aq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C82257855
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691410; cv=none; b=hAcnknEMSipYqCUyUpRzM7muw8hirqVZSZceBQfjLw+nFW3Tz22OyAe2z6dojqWEUi+SwWVxYPlCD92gGR7gUJ4GqWvHH7WPHIntgNQRAVFrn+iKmWNfWcKkBzKfSWwbffwIxfipZmmnYqey8DQdGVgEVBNcRZZShA7Egnf/c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691410; c=relaxed/simple;
	bh=qRYb2UuLMho7adIKiGqSJm3f0QgiMpUF9tCgxUcb1ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EUwHuEu0IrQruwPL9cjU8jkPgKfqgP/vlWV4fXoLihYQlsLxR93/r5HiMY3M7XtmyoWa81dsNHODt75ha/s3xzPxGrXHIn0gcrbjGZYVogs76PbgZyMlsLANOhq+O55MRmakNPLPCx0R8VJwW2YYZVzAEDq3D1eCw7Z2opSsNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=masZH/aq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso6274805a91.3
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764691408; x=1765296208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7h65javEKiZCilvi53EqrbcCyqwHMbAxO5ZzdpYHZ2Q=;
        b=masZH/aqlMEUaLDkXB46XPz6/Tw58M9bfX7tPa37CMc35hdprpAhQH8fi2syvRE2CH
         Rmo30Tag66rhRj8cwfXYrKKJS0DXuI3b3pYpVAHJgWeOa/7ihsaqQqOIVmbJzZuHZ99f
         IEYLqNa+VZpHtdl58LrkXcHm0KHD2bYqNEjsZd5U2hc3G1Q0FVWWCOHl1UahzlkFrl1C
         7dniGt15KRjnQBnpvyVp5Z3gRhszx/Lco2f6mU3cTmsIfGMlC9dBiTMhDq1SF54H0W6z
         0HscIHluBmCaiBJyIk7kL3x11yepDNgxtR/i7QB1UWi9dsvff/w9R8o5/E8gP5l51wQ5
         Fk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691408; x=1765296208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7h65javEKiZCilvi53EqrbcCyqwHMbAxO5ZzdpYHZ2Q=;
        b=Orv5aynhHgAlMI1JGp/rT5oF1ZM54mUCmguw8K9XVXQw0cbOGuxz/DCMCwr/DyRqyJ
         jrfzQ0jJ2gGgHvvWK8y+r/T+c1ipOXqqb7odW5jGlIIDXfk/LAuwxSGYg9JLTID7s+b5
         bUVXoTWvI06fbGP9JPWVyjtKQ1PXj2p3i3w/0PGLRN48KDicsIPXEr66aL7B1tDGAEqg
         oXSDlA2629uSO7IJ5YWTZVpK+CScgYE7MJcn1f7OUu9uxtVNiTxPSojMKMQCLztALzbl
         lGa8Mx1C2vJZSTte8vDWUy2qtLVThx5Ygqaf4Jyk8J0zLL3tl5gOaZ6PKh7yC3RM/9N1
         32JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAmk+lz1At0ZJ4TroflQ1tc04YZ4ORrUKX+oW6Ba1UtVBkOBnZaHT8FKnHDPa0Gqkk7fiJd3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QHd/YeI8Pq3zuSk3cr/HmusyPDY5HgCwqw2cDiCdvXW/C0kV
	rAlmCXHC8ei+eso/kRZqsGZ5hk8Xyhf9XtBBZmNl/k3VItnFxbKbxxPLZ7sqix3RptlG87g5m6U
	IgAnnvQ==
X-Google-Smtp-Source: AGHT+IHgZDUiSW6QxjIjcAOYgkuyQjls1DupsHMaqWae+TriC3tvVF94Ipa05PoU8Re45MZOfysmDED4NVs=
X-Received: from pjbca18.prod.google.com ([2002:a17:90a:f312:b0:32b:ae4c:196c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5605:b0:340:bc27:97bd
 with SMTP id 98e67ed59e1d1-3475ebf93b2mr25169788a91.9.1764691407827; Tue, 02
 Dec 2025 08:03:27 -0800 (PST)
Date: Tue, 2 Dec 2025 08:03:26 -0800
In-Reply-To: <20251202124423.GC2458571@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201142359.344741-1-sieberf@amazon.com> <20251202100311.GB2458571@noisy.programming.kicks-ass.net>
 <20251202124423.GC2458571@noisy.programming.kicks-ass.net>
Message-ID: <aS8Nzomxsy5S4AQ-@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Do not accidentally create BTS events
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Fernand Sieber <sieberf@amazon.com>, pbonzini@redhat.com, 
	"Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?=" <jschoenh@amazon.de>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw@amazon.co.uk, 
	hborghor@amazon.de, nh-open-source@amazon.com, abusse@amazon.de, 
	nsaenz@amazon.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 02, 2025, Peter Zijlstra wrote:
> Does something like so work? It is still terrible, but perhaps slightly
> less so.
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 2b969386dcdd..493e6ba51e06 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1558,13 +1558,22 @@ static inline bool intel_pmu_has_bts_period(struct perf_event *event, u64 period
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned int hw_event, bts_event;
>  
> -	if (event->attr.freq)
> +	/*
> +	 * Only use BTS for fixed rate period==1 events.
> +	 */
> +	if (event->attr.freq || period != 1)
> +		return false;
> +
> +	/*
> +	 * BTS doesn't virtualize.
> +	 */
> +	if (event->attr.exclude_host)

Ya, this seems like the right fix.  Pulling in the original bug report:

  When BTS is enabled, it leads to general host performance degradation to both
  VMs and host.

I assume the underlying problem is that intel_pmu_enable_bts() is called even
when the event isn't enabled in the host, and BTS doesn't discrimate once it's
enable and bogs down the host (but presumably not the guest, at least not directly,
since KVM should prevent setting BTS in vmcs.GUEST_IA32_DEBUGCTL).  Enabling BTS
for exclude-host events simply can't work, even if the event came from host userspace.

