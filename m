Return-Path: <stable+bounces-253783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDWQARNYEGocWgYAu9opvQ
	(envelope-from <stable+bounces-253783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:20:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345A5B5031
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1258F30E5618
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77D737C105;
	Fri, 22 May 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/m5c86H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5C362154
	for <stable@vger.kernel.org>; Fri, 22 May 2026 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454581; cv=none; b=urbtN19EL8y+dcozBUKUD79x4R9P5iDcyeZdnuCyhQJWE6hwtTZy25xPX4omrRROYAQsW0dNt3M0EJoMXocI/QfCJBNbxbFhBeS8voXtxgy1Ih+udhqKT9fQ4lbtfbZhNeYFCQ+d+UGeFm7rfqzuwyHhObASMMSvzpQ8PjMyBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454581; c=relaxed/simple;
	bh=1ueFHrmb3kCbD3q8Yyn0R74TtKXfDG/UxEfY8QbskYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fTz3Cx0wMRejF3FJt1EftCO7kaJOGGxDp1pWztbJHARg3HMYs0HzLod690+wuJh3pJtWASDKCcnoG8whQ1f+gXc0OibqfiPN0BjlugAYHjasNbvGQIt7HXEic9nyEG7mdAdNGyn9SPv2YPnJ4/UTwvWq9jISDJDegsKkciIbWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/m5c86H; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so74541895ad.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779454579; x=1780059379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6CvdCjBkIe33nG5oetvbmG7gqC8FP4sJXMVlPKJ4Mw=;
        b=H/m5c86HO6FlET7GJCsq4us9YAvLTx/1QPLiTzo+QqxwOjNO3BdRQSe4dwXc1COAjl
         wRqsqw53FAObehXC1V7Zh7EdmS0CDh6xKIR33nfC6MVI7JLOwub+1FZ5KjLlnf3V+TT9
         6/wk/mkk6EkI5a2Z4/kYTmVNkapwiv/MczLTXGWDwfyMlJ1qArSnlv2yLK+Uw6FiC0rW
         2VZrhancw3tkzlx9uTtaQzloT0GfrFcT6oW+GWSTVNQ0Q+3vyJmGixhPvliMJcqFN37H
         qKD2dtaTCKumNX75dyQO90izj83N4AKL5Fo6XpHi5NWBL1GMWtF5rnVgS0TIn/HHNitX
         /Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779454579; x=1780059379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6CvdCjBkIe33nG5oetvbmG7gqC8FP4sJXMVlPKJ4Mw=;
        b=a11vI4mciK3tOR+TZGEe+/NaIqig7/atS9dD0xisJjmgmSaZo1JBJmNugoUnI89Gji
         PrlJxswCNlToYAHlkhHh5xDX8rwI+JVJTfJrnJg/Iw+5Rgm20bTwVk9LE5pEAEWwHRdJ
         AKhiNkUoN7DrLXsDPwqPvIDel2S5vVIjrHHS039eDOwI0VC5yVy0ICVAyLPNhDwmz5Fl
         4pILG3VDG8hF6NWr0YUfihvQ1KJD++dSOFVSDqBb+WPY6F0S6RfiIBZQTbkmGYEXymKp
         XFL4GBj+dKA1Ms8+dT47yXrTH2pgoJzHScaxAUdI7EJD1cfOaCwAOAa2ZXfDtgX/78Cz
         vBbA==
X-Forwarded-Encrypted: i=1; AFNElJ/WFe8Sdd1XP6wwpcZi6NMYD93tO35pU5EhZrNBu2/a14baJkqmbJxCeg3mN7zIuBevQYz9pL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuNR5LoBtpBNnSqfuqWS8+Z1xKKuymc2XyS85f0C8UQR8yFXG
	ecb51WNY+HnhXmCwVSQ6l3+bD6I4GiA8YmF35+uO2dsvtqkRvFWCIgPPJG1agYi8dm3w4yqz+PR
	0toRu4A==
X-Received: from plty10.prod.google.com ([2002:a17:902:864a:b0:2ae:abe9:b38b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2450:b0:2be:260b:fa58
 with SMTP id d9443c01a7336-2beb06ea868mr37239635ad.1.1779454579148; Fri, 22
 May 2026 05:56:19 -0700 (PDT)
Date: Fri, 22 May 2026 05:56:18 -0700
In-Reply-To: <20260522040014.3380201-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522040014.3380201-1-zhang_wei@open-hieco.net>
Message-ID: <ahBScosf2jUlKdAt@google.com>
Subject: Re: [PATCH] KVM: SVM: Disable AVIC IPI virtualization on Hygon Family
 18h (erratum #1235)
From: Sean Christopherson <seanjc@google.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, mlevitsk@redhat.com, 
	naveen@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-253783-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.984];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7345A5B5031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026, Tina Zhang wrote:
> Hygon Family 18h CPUs are derived from AMD Family 17h (Zen1) silicon and
> share the same erratum #1235: hardware may read a stale IsRunning=1 bit
> during ICR write emulation and silently fail to generate an
> AVIC_IPI_FAILURE_TARGET_NOT_RUNNING VM-Exit on the sending vCPU.
> 
> The absence of the VM-Exit causes KVM to miss the required wakeup of
> blocking target vCPUs, leading to hung vCPUs and unbounded delays in
> guest execution.
> 
> Extend the existing AMD Family 17h erratum #1235 workaround to also cover
> Hygon Family 18h.  With IPI virtualization disabled, KVM never sets
> IsRunning=1 in the Physical ID table, so every non-self IPI generates a
> VM-Exit and is correctly emulated.
> 
> Fixes: 8de4a1c8164e ("KVM: SVM: Disable (x2)AVIC IPI virtualization if CPU has erratum #1235")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/svm/avic.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index adf211860949..993b551180fe 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -1300,12 +1300,14 @@ bool __init avic_hardware_setup(void)
>  	}
>  
>  	/*
> -	 * Disable IPI virtualization for AMD Family 17h CPUs (Zen1 and Zen2)
> -	 * due to erratum 1235, which results in missed VM-Exits on the sender
> -	 * and thus missed wake events for blocking vCPUs due to the CPU
> -	 * failing to see a software update to clear IsRunning.
> +	 * Disable IPI virtualization for AMD Family 17h (Zen1 and Zen2) and
> +	 * Hygon Family 18h (derived from AMD Zen1) CPUs due to erratum 1235,
> +	 * which results in missed VM-Exits on the sender and thus missed wake
> +	 * events for blocking vCPUs due to the CPU failing to see a software
> +	 * update to clear IsRunning.
>  	 */
> -	enable_ipiv = enable_ipiv && boot_cpu_data.x86 != 0x17;
> +	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18)

IIUC, family 18h is carved out entirely for Hygon, correct?  I.e. there's no risk
of disabling IPI virtualization on unaffected AMD CPUs?

> +		enable_ipiv = false;
>  
>  	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
>  
> -- 
> 2.43.7
> 

