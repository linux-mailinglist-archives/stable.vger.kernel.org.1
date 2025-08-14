Return-Path: <stable+bounces-169618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46539B26F78
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 21:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D865C219D
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 19:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4534220698;
	Thu, 14 Aug 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkbeQ7oS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11F215767
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198336; cv=none; b=mzUCY2OUPb8glXPY1q6JWxMacAmq7z17dRqll3xsah9nf8JOla3ruGzNyeJMQkdl+KgnAb5XPgORL56ImbP/Q/vkCaFp2heDJnCv2m+Hmq2O01l5MXDfNCsueoGi8Rbfrt2S5ICkTAkO1VasiPG+2fycbQYT5EwfjFI2w5qYac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198336; c=relaxed/simple;
	bh=3M6olNCkfBgg79SBlkoN6YaHd1iwdF64SMcb1OiDJSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SOWpYwR9nh1fndr8z7R+yS2eUebpnBXqSOsmM2ew0Vck9Fg3GjGTmoOHwd/jcDafyJRmHkwXdOuQzC5QoN3nrsZQl1PRaqFePdObpooKl2eAAJ5gcvD+wR89pZlsBKMwSJ5mYyNQFtazyueATY9pI5BU2qTnshJaNQ86Wp4C6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkbeQ7oS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326bed374so1234444a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755198335; x=1755803135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZln5AlMLNKwBYNNEImRxFo070vZbrB9DRk7vU6UURM=;
        b=pkbeQ7oS9mthnHHenj4NxZnz5/5G5IXC/Rz8d1OgHIK4laeLPXJudgzaSjcmAKx1jz
         oeOxmu8UpiV3jgazOoqgb1ru4Sk7xrEjREPwzUsNLUm6BkQHG5S4EckM3m0B4TWH72W8
         l3qsK2SeZmmJLgC9NIJnx9LaT3RFxTwbsdh0B1Jkmj6mqh51h7LjQQrKDvKYNZLP+xjR
         Ok5cLh+PpkhIzi1a7mILUMRFOdHIgTn08qwThS1C9IFKDFE5ZlSmsxsyyosotZMAd0M2
         lCMSKnBGy2fTTR8Ss9Ct9+yEzfz1w6RCtUdRoRXF5f22kuOiWF6fka6z03jBf3wOrjfT
         OqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198335; x=1755803135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZln5AlMLNKwBYNNEImRxFo070vZbrB9DRk7vU6UURM=;
        b=Z7pmx4IXnz7Wes4B6lq1Qa7N7Dsia055R8sK+QnCz0QVwyQO+6r0Dj7wkXlqgPuQTA
         MGzC0mBKadj7+Xw9m7k/+9U66SHj4zTQECrp4YsfnmOimoqkDxDWBjCX+0K1PqW+/qMK
         tFbEjb9+A+MzRo9eGQkRU6N95Nk54aeiK/F8FmIrdf7QV+gmeSux9kmkWE2/oZokvsw5
         PDyNq3rh3BTmRDWHmqaHxjvu3gib/cV8SrzbcV3WtejA5hlLOqtC2Xc8E2s6maF0VYMw
         cGuDpaw0CqfJIeb1yrd/OWAZZB/Aw6Mg8ow8fNaYqKTValj8v+h3QiMvh0HI0ENzaafZ
         1FQQ==
X-Gm-Message-State: AOJu0YzY0lDNTlW2i4593wqQKMgd6M82TJ2idFpwetwfDMuyIuBS+Kuk
	gusYh77ZhlA5FUu/6tT+VhhOmT67WSHRw+dD/9j4X4bpCe2cg+aXnJkiOopsTpoxC73VMhLEDyt
	ApgEnHg==
X-Google-Smtp-Source: AGHT+IGjcIAuKP6lSEBMEwoStQYCUXAV6FHycDXlwu/XOYDaS7KiPKN4RfAKonpH3DIzNPjDvwQLH8hkouA=
X-Received: from pjwx3.prod.google.com ([2002:a17:90a:c2c3:b0:321:6924:af9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380d:b0:313:dcf4:37bc
 with SMTP id 98e67ed59e1d1-32327aa7b9emr6135916a91.34.1755198334608; Thu, 14
 Aug 2025 12:05:34 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:05:33 -0700
In-Reply-To: <20250814131146.2093579-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081214-bonanza-germproof-173f@gregkh> <20250814131146.2093579-1-sashal@kernel.org>
 <20250814131146.2093579-3-sashal@kernel.org>
Message-ID: <aJ4zfUgob0N4wBKu@google.com>
Subject: Re: [PATCH 6.6.y 3/3] KVM: VMX: Wrap all accesses to IA32_DEBUGCTL
 with getter/setter APIs
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 7d0cce6cbe71af6e9c1831bff101a2b9c249c4a2 ]
> 
> Introduce vmx_guest_debugctl_{read,write}() to handle all accesses to
> vmcs.GUEST_IA32_DEBUGCTL. This will allow stuffing FREEZE_IN_SMM into
> GUEST_IA32_DEBUGCTL based on the host setting without bleeding the state
> into the guest, and without needing to copy+paste the FREEZE_IN_SMM
> logic into every patch that accesses GUEST_IA32_DEBUGCTL.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> [sean: massage changelog, make inline, use in all prepare_vmcs02() cases]
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-8-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

