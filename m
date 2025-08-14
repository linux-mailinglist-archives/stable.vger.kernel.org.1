Return-Path: <stable+bounces-169600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1BB26C77
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDE9686F0C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4F823504D;
	Thu, 14 Aug 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3Vw1QNz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDE271468
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188286; cv=none; b=PQKp6j8TR5Tvb7EKdm5w4vc8Ym7zfb+eAU28gv802t6cbyDczE+05a99+OA68dTK7QVOglNKoMPEtTvJjZSPDHSj6be8zNEIF8quUaYCL5W6B0UFlSX+EmNmUWskvSV2lBni1UqXiHO6+8Vl83+IGFJiWp4DnMwoiFkCD96Wa+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188286; c=relaxed/simple;
	bh=3M6olNCkfBgg79SBlkoN6YaHd1iwdF64SMcb1OiDJSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PLscWnwMn4/JS1PmPl4VZ3m82wCQYGZOm++xgMy+xRG4hGBFZG+sDwc5Cj7msziOU/+v7F/56cG30fhF9fOUd9ehCKiQTVtZDr+jpGwrA1eJNf/1BOQR9ry+3bDsvxFgVATw5bhH9h7d9zqNL9q7ZmapclOQIlgaK1hx1aA7j4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3Vw1QNz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e6d8a9so1192378a91.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755188284; x=1755793084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZln5AlMLNKwBYNNEImRxFo070vZbrB9DRk7vU6UURM=;
        b=B3Vw1QNzIFORnAWNAzUkSPI/2tCwiNI6OqlVX6iIBnfTnXIqxqVBZhIxbrUYrsbkWn
         oN/b9K7lwxQMCnDySIA4yDQoEmHBAVhKxOzX6iEE6/MsjR+vxVo6hWTZwTifq8TN6H00
         FAFT2B38MsZunHwlymSZjJVsBsiHVaQRo2YTfotbKnnhGwvlFyNTE7tBM6eeXdSUdK8Y
         jj2oDcxQrYvtK4f56YIql7y7x9UtI2YmvBXjqhGRl+h1Mru44Yy3Oa8qdZ98MRRsz1of
         4AcSHvnvgOGv0sfIAXPtNXf3DnE7/RD2HGKvyOoGPKN+HbSGP7DDaWEQV6wblsXQrxR3
         yQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188284; x=1755793084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZln5AlMLNKwBYNNEImRxFo070vZbrB9DRk7vU6UURM=;
        b=mrbh7yd8tVQOnOUu8AGJJnj5UW9t4pPCOz/GgUec5p14XMf3jori0rajUa6FP/aOPP
         zJL0gXKS36Hz062YQ8JLsT1AbkVD3/D2BenYk7fSvhWnwkiHmsAY8KXAaA6ul1xjb6Ke
         prxbYbWv0Q+wvcf3WSBuRsPMbZBbrgl9tbnWT4zVcyGxxHetSMdt9LGBYOSiMebw8+wL
         wZvrflI9r/iOthsc9iUVBruvRIEtpIhQL25w4oTxg+8O2XJi//t5lb3ZrOZuM5M4BSR4
         nvk3aByo8PmKNNv5Ft1AcXrll3KlSK3QCXaTK03BDXTaA6aDtUqAnHUjsTgV+TvDyDLe
         ObNw==
X-Gm-Message-State: AOJu0YwgkoHIVLEEuqsFstHbM4thnBayXuJcQnqk4PQA+a4QnRtPZ6EB
	FwEmdSQQTMm5nO/BY58mKroV2wWVqa1oEALgP7U9vLWkZgyXI3lN2yBToC1InuezCc+71LNEyJs
	Usl9+gg==
X-Google-Smtp-Source: AGHT+IFekJ5qSX8LD4mkTWDV4B8o06VKznGtFZ9FKJ3pol7rohFjrbQSC4kfyxJki1cma0d2iDS+u7gyZ70=
X-Received: from pjbqc5.prod.google.com ([2002:a17:90b:2885:b0:31c:4a51:8b75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d46:b0:321:265a:e0c2
 with SMTP id 98e67ed59e1d1-32327ad25femr4484249a91.32.1755188284252; Thu, 14
 Aug 2025 09:18:04 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:18:02 -0700
In-Reply-To: <20250814125614.2090890-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081209-sworn-unholy-36ad@gregkh> <20250814125614.2090890-1-sashal@kernel.org>
 <20250814125614.2090890-3-sashal@kernel.org>
Message-ID: <aJ4MOgqs02XpdbWG@google.com>
Subject: Re: [PATCH 6.12.y 3/3] KVM: VMX: Wrap all accesses to IA32_DEBUGCTL
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

