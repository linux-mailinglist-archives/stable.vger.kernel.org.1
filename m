Return-Path: <stable+bounces-109632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7703CA1812B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243737A2FDD
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5C1F3FF4;
	Tue, 21 Jan 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBvbtWf8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E081ACA
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473534; cv=none; b=ShV9V0NiyZGYQ7NxfmvLB+cgm0fbKuZcw7HVIu4fgB14sqCAkECysILS+zKSiVyyYxgFQRR1j9lzSQcZy8kS9VwhsaSYNrvNmqoMZQWVv+kMic2bLngsH7K4a9NuDeq9jGAE3A9f4lOWzjkNFCWGXqaWFY58u6zAhEzqIxc7Qu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473534; c=relaxed/simple;
	bh=e6Yr+dGwQ4A57yUCpIXs3wQNSVbZX4nECbGt43aOxKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gohljY+D0PILsYdyPg9NpU16MU9lESSoSlsCiEcjdHU4NIKlSd/Fyt4bS9jj3z/nYOtqwzMrjSWOdNEB2Y9ComtCTb4iTza6Fvj6+l4PLB3cLKgBkVWTwm5txhDflOUHQFdE3NnPQFWqtOKx1zeQYrF/AbX/LA7yfuc/SPEqLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBvbtWf8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737473532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1bXM7cxoKeUc47A9jFoEGfA5IU+Fj/3JFjY8VGeyAw=;
	b=XBvbtWf8vCOLxLbhJVWoK/9YiX0d9xrOWc1kmQFZI/Ws0qzNltZQmTDLyc6FSx+9DYqlTT
	eYegjWaXVE/tHBJRsifO4fXV5oq46Ia/ZYuoaWMHvrwim1402nhuTkqOQA8d1GOW1Gf7cJ
	iE5E4y1eLgKIEQZA9RgaWfJAKOQfxk0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-E0XoHpwMPmqPFNV60dWMxQ-1; Tue, 21 Jan 2025 10:32:10 -0500
X-MC-Unique: E0XoHpwMPmqPFNV60dWMxQ-1
X-Mimecast-MFC-AGG-ID: E0XoHpwMPmqPFNV60dWMxQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so31912105e9.3
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 07:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473529; x=1738078329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1bXM7cxoKeUc47A9jFoEGfA5IU+Fj/3JFjY8VGeyAw=;
        b=BT60j2u5dh0mSKV8kJK4kpFwL6abRvxRyxKIymvm+hFp3u/1ddXE5Oj46616dhah1c
         k8TgphA5ZdnMt7Hrsbday8tT7YzfrykGNHyJN3OrLSsbGxQpROj369iyQca5M0ZeYc+Z
         vLjxM1QizPqQ3P4mL915iGi7UyDZoy898sJL/2SJ+v9F2CThAwZEGDjf4ecxbmlOPR87
         INsZ+cJ960BABr5Ke9Dz0S50rHHn/MQqbyedM6eDitNfHXOu2jbLWRvo/Ep1zIIS80uN
         lAXb3hi+GM6DyT0rWrlmz0HXzW9x7E3DSZ/R7BD99XWNlYQT/HVPQGzswWuIKySuIrLy
         xHdw==
X-Forwarded-Encrypted: i=1; AJvYcCWd4HI4xUBFeKZquOFzNAZvylsjJN0Tl/TuMl/IeRN1v264O/RnZHtJpgEO4cyCsG6sIWlPT/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnsjaQfpj7ijuJ08cWDAdlJElbp/qeu3NX3Q57vavmBi7AZ95
	so5kBCR+bUDbyvRbS5y44CQWhPEJkTusLpB0pZ4vhJIGQHJmdMFpKGCISdBLJ91+wfgGWcj7WOa
	fXaVY7AKjb2uMjXrieZpnMm7Hxd11yXMJA1Zb7VbyLYwMEjeeSig9Jg==
X-Gm-Gg: ASbGncsZe69kaddl3KpO4sFTW90tupW0IRJ8Lfcf5B+D5VzudxSHXUqaNvaZaF3dKxd
	NhzL3cBeIaCjp8EDfC3C9+5Ni2/nM7Ur1ZuveGqvnhALQdSOvwVNhujIameU834g72XTUltiEm9
	JxxF6gr0aJMuwF3sWP/CfSKB9FmyypmkB2XRKnS/XURc6YkHmfBRvaWE1/2YtEJN8MmopcC5NLR
	0xL9KUvPMzf80qqosRpwiTNubAv4xqx2D4WBcair7pVAkqKqjrQyMBCdmxFUzDKZvLA1urca7CN
	s32RKUhTHXEaQmSDwQvFLP0e9LDbS11bRBfW
X-Received: by 2002:a05:600c:4ec8:b0:434:f219:6b28 with SMTP id 5b1f17b1804b1-43891435c37mr150781455e9.24.1737473529460;
        Tue, 21 Jan 2025 07:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpa1v3wcYhRCINZUP07hM1daVRU3AUjb2eugVysXBiuJ+u+dJE82WVNBEO//scuIHzku/G/w==
X-Received: by 2002:a05:600c:4ec8:b0:434:f219:6b28 with SMTP id 5b1f17b1804b1-43891435c37mr150781025e9.24.1737473529024;
        Tue, 21 Jan 2025 07:32:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32754f5sm13865800f8f.79.2025.01.21.07.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 07:32:08 -0800 (PST)
Message-ID: <c60288f0-a1ee-452e-a36f-f4194d05c975@redhat.com>
Date: Tue, 21 Jan 2025 16:32:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64/sve: Ensure SVE is trapped after guest exit
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org, catalin.marinas@arm.com, fweimer@redhat.com,
 jeremy.linton@arm.com, maz@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, stable@vger.kernel.org, wilco.dijkstra@arm.com,
 will@kernel.org
References: <20250121100026.3974971-1-mark.rutland@arm.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250121100026.3974971-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 1/21/25 11:00 AM, Mark Rutland wrote:
> There is a period of time after returning from a KVM_RUN ioctl where
> userspace may use SVE without trapping, but the kernel can unexpectedly
> discard the live SVE state. Eric Auger has observed this causing QEMU
> crashes where SVE is used by memmove():
> 
>   https://issues.redhat.com/browse/RHEL-68997
> 
> The only state discarded is the user SVE state of the task which issued
> the KVM_RUN ioctl. Other tasks are unaffected, plain FPSIMD state is
> unaffected, and kernel state is unaffected.
> 
> This happens because fpsimd_kvm_prepare() incorrectly manipulates the
> FPSIMD/SVE state. When the vCPU is loaded, fpsimd_kvm_prepare()
> unconditionally clears TIF_SVE but does not reconfigure CPACR_EL1.ZEN to
> trap userspace SVE usage. If the vCPU does not use FPSIMD/SVE and hyp
> does not save the host's FPSIMD/SVE state, the kernel may return to
> userspace with TIF_SVE clear while SVE is still enabled in
> CPACR_EL1.ZEN. Subsequent userspace usage of SVE will not be trapped,
> and the next save of userspace FPSIMD/SVE state will only store the
> FPSIMD portion due to TIF_SVE being clear, discarding any SVE state.
> 
> The broken logic was originally introduced in commit:
> 
>   93ae6b01bafee8fa ("KVM: arm64: Discard any SVE state when entering KVM guests")
> 
> ... though at the time fp_user_discard() would reconfigure CPACR_EL1.ZEN
> to trap subsequent SVE usage, masking the issue until that logic was
> removed in commit:
> 
>   8c845e2731041f0f ("arm64/sve: Leave SVE enabled on syscall if we don't context switch")
> 
> Avoid this issue by reconfiguring CPACR_EL1.ZEN when clearing
> TIF_SVE. At the same time, add a comment to explain why
> current->thread.fp_type must be set even though the FPSIMD state is not
> foreign. A similar issue exists when SME is enabled, and will require
> further rework. As SME currently depends on BROKEN, a BUILD_BUG() and
> comment are added for now, and this issue will need to be fixed properly
> in a follow-up patch.
> 
> Commit 93ae6b01bafee8fa also introduced an unintended ptrace ABI change.
> Unconditionally clearing TIF_SVE regardless of whether the state is
> foreign discards saved SVE state created by ptrace after syscall entry.
> Avoid this by only clearing TIF_SVE when the FPSIMD/SVE state is not
> foreign. When the state is foreign, KVM hyp code does not need to save
> any host state, and so this will not affect KVM.
> 
> There appear to be further issues with unintentional SVE state
> discarding, largely impacting ptrace and signal handling, which will
> need to be addressed in separate patches.
> 
> Reported-by: Eric Auger <eauger@redhat.com>
> Reported-by: Wilco Dijkstra <wilco.dijkstra@arm.com>
> Cc: stable@vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric

> ---
>  arch/arm64/kernel/fpsimd.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> I believe there are some other issues in this area, but I'm sending this
> out on its own because I beleive the other issues are more complex while
> this is self-contained, and people are actively hitting this case in
> production.
> 
> I intend to follow-up with fixes for the other cases I mention in the
> commit message, and for the SME case with the BUILD_BUG_ON().
> 
> Mark.
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 8c4c1a2186cc5..e4053a90ed240 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1711,8 +1711,24 @@ void fpsimd_kvm_prepare(void)
>  	 */
>  	get_cpu_fpsimd_context();
>  
> -	if (test_and_clear_thread_flag(TIF_SVE)) {
> -		sve_to_fpsimd(current);
> +	if (!test_thread_flag(TIF_FOREIGN_FPSTATE) &&
> +	    test_and_clear_thread_flag(TIF_SVE)) {
> +		sve_user_disable();
> +
> +		/*
> +		 * The KVM hyp code doesn't set fp_type when saving the host's
> +		 * FPSIMD state. Set fp_type here in case the hyp code saves
> +		 * the host state.
> +		 *
> +		 * If hyp code does not save the host state, then the host
> +		 * state remains live on the CPU and saved fp_type is
> +		 * irrelevant until it is overwritten by a later call to
> +		 * fpsimd_save_user_state().
> +		 *
> +		 * This is *NOT* sufficient when CONFIG_ARM64_SME=y, where
> +		 * fp_type can be FP_STATE_SVE regardless of TIF_SVE.
> +		 */
> +		BUILD_BUG_ON(IS_ENABLED(CONFIG_ARM64_SME));
>  		current->thread.fp_type = FP_STATE_FPSIMD;
>  	}
>  


