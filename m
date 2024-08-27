Return-Path: <stable+bounces-71344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D9961785
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 20:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31D91C23743
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A721D54E2;
	Tue, 27 Aug 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsQI+z/U"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F141D414E
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784997; cv=none; b=j7miyR7HPdOb1aPA78d313gtYbVyLQ+0PjIqIkZnYuBpu5UYwJx80c9mFFXI93TYd6qg4AgsdPaqLx/LI8tRyGDUFKcXt/2mF+APIU26O5zbJP78uoJGmiFpjOe+/P8nZv7WPtdsQhZt59cjwdXx100wTEQReTVDpux0Ss8uV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784997; c=relaxed/simple;
	bh=Ka2T5YdW6oNpZNQU7rr8zr6Y0HG4jm+2UxDZANRTCCA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e/8TP09hxyOHGgniVm2K2SZAihcr4wwgXW6TT5ZiU15rCZyNqfMhjmI0rIEv7xQuw+bCOFQzwYkFAIO2eaTO8ezfS8m7EzR+S3Wx9p9Eh+6SizNQ0xc2Fz85s5ikHhVS6KHGxrVnwfxPsj6I184djFpIyPsbMjBxD78djVCqT8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsQI+z/U; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso9923126276.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724784994; x=1725389794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WVEg6iQOl2Kkuc9v2k09ZHppiBPP1VstSQCds7jk4I=;
        b=tsQI+z/UsOY0N4Atu25aDYR50xnISfBV01e1QiocW7wKSVJyCjF0QseLxY34hFLpqg
         3kMS+SL0k7+LN5hsil+9Pj4cHgzUCKHGGMOK4WoT8gw/GiD5wmaPVdu3if3GwWcKrY5b
         aTzc7vD9iItrvpvOmOUrTAjdWXx0qw5kH1s7NTwTLqLovxJUWDpl6QMsWvvPbQ8joDfG
         hNPSMNFxt4zGTMumYRMNOFtSpIpzWU3g/Bo9VMRSJOMexeocaMtO5+qYIZpTiKsW7qdr
         H0pUavzCerAlTKnbDn6DUZJBZKEGDaeoobBTizMtjSBLOXVkpdi0Mz8R2gBTHy3VknQ2
         t6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784994; x=1725389794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WVEg6iQOl2Kkuc9v2k09ZHppiBPP1VstSQCds7jk4I=;
        b=bJe3hZ8PXQ1PSPi6tfdlTDKo9o9k2LyOQX4GDdAR+QxXDHzBXsG1+dF6JTIRdqCpsH
         9//pKRxLMK9YymlpeQVWYhJIUJHDNWyb3/WzDQBJrPMjjwnsk17VllX1hpX8XHXwdqrG
         FAWIVSuoDhSmTJ5aEmy2yi1L+HL6/yUUkDiNWoTQIv+ICetYYp5l/AaenE67TB9Q/fA8
         xrNyM0gJ38YmKaMXntQgAz2msvVuPUMcCQQkd3z8dyEKMuTcbT05dZ3zH2CF0n38eIF5
         YJHF518gSq0RQ0mBHoOwBc7S1TOv12TdB/W6W69y4yb5iYxcrWSxRmWP7KFQgCy/qSxH
         vmkg==
X-Gm-Message-State: AOJu0YzR8wQ4z51jiiFDoQW+4NHg6F5NpeIZfN3vI9d6QEa8j/sBiL4U
	vFaljbY9raBUDrTXY4iSmotaYXNCVAz0FSX97kJlGmKXDXDmRc0bPP1NyEpFn+rHJtRiOrfgpSf
	yQA==
X-Google-Smtp-Source: AGHT+IF0TO61acJ/N4PuAFd2nLlAdHN6lDaWX9AJ95EYuBVufRmStWP1YlaUca9GBUj8JvN1i83vthonfHs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d6c1:0:b0:e11:5e87:aa9 with SMTP id
 3f1490d57ef6-e17a863e967mr20488276.8.1724784994284; Tue, 27 Aug 2024 11:56:34
 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:56:32 -0700
In-Reply-To: <20240827143849.600025269@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827143838.192435816@linuxfoundation.org> <20240827143849.600025269@linuxfoundation.org>
Message-ID: <Zs4hYMSkyDtUdq6d@google.com>
Subject: Re: [PATCH 6.1 298/321] KVM: x86: fire timer when it is migrated and
 expired, and in oneshot mode
From: Sean Christopherson <seanjc@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Peter Shier <pshier@google.com>, Jim Mattson <jmattson@google.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, David Hunter <david.hunter.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 27, 2024, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.

Purely to try and avoid more confusion,

Acked-by: Sean Christopherson <seanjc@google.com>

as the fix that needs to be paired with this commit has already landed in 6.1.y
as 7545ddda9c98 ("KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.")

> ------------------
> 
> From: Li RongQing <lirongqing@baidu.com>
> 
> commit 8e6ed96cdd5001c55fccc80a17f651741c1ca7d2 upstream.
> 
> when the vCPU was migrated, if its timer is expired, KVM _should_ fire
> the timer ASAP, zeroing the deadline here will cause the timer to
> immediately fire on the destination
> 
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Peter Shier <pshier@google.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Link: https://lore.kernel.org/r/20230106040625.8404-1-lirongqing@baidu.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/kvm/lapic.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1843,8 +1843,12 @@ static bool set_target_expiration(struct
>  		if (unlikely(count_reg != APIC_TMICT)) {
>  			deadline = tmict_to_ns(apic,
>  				     kvm_lapic_get_reg(apic, count_reg));
> -			if (unlikely(deadline <= 0))
> -				deadline = apic->lapic_timer.period;
> +			if (unlikely(deadline <= 0)) {
> +				if (apic_lvtt_period(apic))
> +					deadline = apic->lapic_timer.period;
> +				else
> +					deadline = 0;
> +			}
>  			else if (unlikely(deadline > apic->lapic_timer.period)) {
>  				pr_info_ratelimited(
>  				    "kvm: vcpu %i: requested lapic timer restore with "
> 
> 

