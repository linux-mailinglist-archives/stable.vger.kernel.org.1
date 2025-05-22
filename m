Return-Path: <stable+bounces-146039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4531AC0580
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422F11BA751C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B71DF754;
	Thu, 22 May 2025 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C6ZVTXaJ"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2778F24;
	Thu, 22 May 2025 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898462; cv=none; b=vAY8NZVhX+tSdyfdFxhMDsFEUscQLG5okistA4LBIXc536in1sOBQpkiti96rPThM+Vkp+BaEEzIwPJFKnqJtKjw9j5FjG8d/ugkqhGBtdUCebVnju98zG9xy11rsvAo0DuFsPWxnk5njzad2i6uvDu7ve7XOw2LCODUAHU1BGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898462; c=relaxed/simple;
	bh=ul/cjA71yK5MkhDHG+jp7IO3e9PwfQ7eb7y0ytnrJVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h07tI0gLceJ20fUvztzuHC6Kg2qKl/7PUaSOMjlyZMP29bktMXHy3gvJ61VWG+HKNQGle1qW1KKeVv7y10WsBJdFyMF3bUW3pogafFVog2uved83ANEp7MvfF+NXoznobZSIixgHEMjvuGFRKzHarDLXW/yq2aq5CrQToLq31ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=C6ZVTXaJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9485:b38f:3394:a853:2b62] ([IPv6:2601:646:8081:9485:b38f:3394:a853:2b62])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54M7KJUW2902504
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 May 2025 00:20:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54M7KJUW2902504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747898420;
	bh=H8ySe4RfS7FZisRl2D+2WkCaP/41l1+Wc5iq3pORidM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C6ZVTXaJl9fPkmU9tWCEZA+IpHTttwRfseYcOWfSzVjoUNDM4MtpwhJqpvo9NquAj
	 FsQe5ksDE4OsoGlCvHYONPWzqCwglXqmfiy8EEHfyf0DFX9xvAK3Bp9vWXF/l5bGHP
	 UBNW5nQDlm7B5USC1L71J6c3X3dp8xSPqCJ0l4zTLm8E1Dt8dSv+Tmqsu1ndolz5HP
	 JjOEuKvO3WTI/qfiqaIaKIOd1FaTeOiH748utqkzMGn/81FAtcV8K+ps1ZvY2FqFce
	 6f0HinozrNLN37u27hrOHQamALkio91K48Ruhpr4Vg1lpBCTA/5nPmtCd3w8ZxbOL5
	 yw1DA0rKYSKPA==
Message-ID: <e32dc7de-9f97-4857-8e07-0905a94acfad@zytor.com>
Date: Thu, 22 May 2025 00:20:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred/signal: Prevent single-step upon ERETU
 completion
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, stable@vger.kernel.org
References: <20250522060549.2882444-1-xin@zytor.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250522060549.2882444-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 23:05, Xin Li (Intel) wrote:
>  
> +/*
> + * To prevent infinite SIGTRAP handler loop if TF is used without an external
> + * debugger, clear the software event flag in the augmented SS, ensuring no
> + * single-step trap is pending upon ERETU completion.
> + *
> + * Note, this function should be called in sigreturn() before the original state
> + * is restored to make sure the TF is read from the entry frame.
> + */
> +static __always_inline void prevent_single_step_upon_eretu(struct pt_regs *regs)
> +{
> +	/*
> +	 * If the trap flag (TF) is set, i.e., the sigreturn() SYSCALL instruction
> +	 * is being single-stepped, do not clear the software event flag in the
> +	 * augmented SS, thus a debugger won't skip over the following instruction.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_FRED) && cpu_feature_enabled(X86_FEATURE_FRED) &&
> +	    !(regs->flags & X86_EFLAGS_TF))
> +		regs->fred_ss.swevent = 0;
> +}
> +

Minor nit (and I should have caught this when I saw your patch earlier):

cpu_feature_enabled(X86_FEATURE_FRED) is unnecessary here, because when
FRED is not enabled, regs->fred_ss.swevent will always be 0, and this
bit has no function, so there is no point in making that extra test.

The only reason for IS_ENABLED(CONFIG_X86_FRED) (which is implied in
cpu_feature_enabled() anyway via !CONFIG_X86_DISABLED_FEATURE_FRED) is
to eliminate the code entirely if FRED is not compiled in.

Although the way it goes, it sounds like CONFIG_X86_FRED might go away
soon anyway, since KVM wants to use some of the FRED code
unconditionally (and Xen might follow, too.)

	-hpa


