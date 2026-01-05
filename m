Return-Path: <stable+bounces-204914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DCCF5814
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E31305575E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CCB32ED4E;
	Mon,  5 Jan 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDHpIwYM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C9320A2C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644583; cv=none; b=gmo8RhQkIdX/8mDPsqmGczh/5hCpjPHNFs/zkxyIpnWNJUaUtNeGgQIMI5xHdtJJOw9h4+5T/PZuEYMeozL6bFc1Mq4lUWfrO2wqUYY9QqsVSwrH8Ofwqx8jdCuE4zCZt+AvFs7/sOWakeA5RcJNViWnbjM/VotlObnEV4BqZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644583; c=relaxed/simple;
	bh=1jAC1RIoAKKNGqyL000Ba0t6tIYm4DtAoeIhOFC96JM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rbBP27I3/fYBr+/olFf1PoGBrhtMPb0MKN2ysCMyuCa0bTpAxXIBEH7EBHKsD+LMLm/KxCwXFjby3Hg4sGloYZzgxf2XOjpMxPfZI4Z7zR6uY0+JqR2jFnKbFht3xYr9oMp/NemcDss/pBtxDzIM43hyKGWeQEthL851OVD1CEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDHpIwYM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34ea5074935so446291a91.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 12:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767644582; x=1768249382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4h39aYIECznL06dM7erNFHqb89TAmcNIfDdZFQ9BS5M=;
        b=cDHpIwYMUslnw0CxLe5pc11NGrxZyXRcVzhgh3inyubUt95oeK3H9h4quOabkv9mDV
         biHD+G8v9l0QhFG/h3uGIAZTK5RRaUGkSS+Aqa8MII9ezfgwdon9WAUi51SFzUYYlgkk
         ebUBf5skkwDbh2GZIS8S49fYRiuQinii9dSOeostA1TJpERqfexr/gYsGnUff3UhNwFP
         +kjjUB2MoOg1loVesEN5pJ9vuSIlYL1tqHRW5hFpe9WW+EvePyLjEznVnzzKpSgRiEbz
         hAF0ClCj5LjCjbjA1Uv6cs8unWwI9XBupQxJkvHtnerukUPoS1dFuxlJ//xnAD+wRwGy
         vZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767644582; x=1768249382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h39aYIECznL06dM7erNFHqb89TAmcNIfDdZFQ9BS5M=;
        b=jWweJelotVbrC6YjaFkg2fVsczi04csl9eWEe2t+LcKR6jw2TscJr21HteC1KMZWMg
         zsfuJr7enVQAskc3XZCvMHtPxYAuoOM2uMfydpsFZf9OGH9vTD1j6mnHvktkkWcjutYY
         JQeMubcVKsBm4T1lzVdeMzKAjcK5OuXRtHR8h6mBZocJxFTJLKXLkldpfWvHSIqylRKY
         9N5NU5AVFvqKTSlpFynKUbNdWyIvPKHKStzoB7qrZBZR1GAxzDlvWvoZp/uchKJ+jFQo
         arxq9Ubkz9sVq2D19+L2wxm6aw3KcOmpoEGgmfCI/z41xK3iyWMN4mJVAoisBeX0nXaj
         ql/Q==
X-Gm-Message-State: AOJu0YyvYtpvy7W9BTIeRQcjDMOyNxs0jRrKOV2fIqV/CkYKegt7RjHm
	vB0YG0SdZS4a6PfjxfuL0oUvbAu396AbwsMAqrvgrSy9HWuSyAjmc61bzSnl8wuSCOlzFn407f5
	nu2vfXA==
X-Google-Smtp-Source: AGHT+IH9rvHJnRVbXWiMKT0y50O5xoNOeY+OdnGj/U97mzyVISUBjywdLoyRQjdqlzL921wzQQmi28iR9kg=
X-Received: from pjcc16.prod.google.com ([2002:a17:90b:5750:b0:340:6b70:821e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c82:b0:34c:e5fc:faec
 with SMTP id 98e67ed59e1d1-34f5f26d38cmr331672a91.2.1767644581708; Mon, 05
 Jan 2026 12:23:01 -0800 (PST)
Date: Mon, 5 Jan 2026 12:23:00 -0800
In-Reply-To: <20251231151153.3146021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025122926-gigabyte-rectangle-0c68@gregkh> <20251231151153.3146021-1-sashal@kernel.org>
Message-ID: <aVwdpA-OEkL7rYPh@google.com>
Subject: Re: [PATCH 6.1.y] KVM: nVMX: Immediately refresh APICv controls as
 needed on nested VM-Exit
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 31, 2025, Sasha Levin wrote:
> From: Dongli Zhang <dongli.zhang@oracle.com>
> 
> [ Upstream commit 29763138830916f46daaa50e83e7f4f907a3236b ]
> 
> If an APICv status updated was pended while L2 was active, immediately
> refresh vmcs01's controls instead of pending KVM_REQ_APICV_UPDATE as
> kvm_vcpu_update_apicv() only calls into vendor code if a change is
> necessary.
> 
> E.g. if APICv is inhibited, and then activated while L2 is running:
> 
>   kvm_vcpu_update_apicv()
>   |
>   -> __kvm_vcpu_update_apicv()
>      |
>      -> apic->apicv_active = true
>       |
>       -> vmx_refresh_apicv_exec_ctrl()
>          |
>          -> vmx->nested.update_vmcs01_apicv_status = true
>           |
>           -> return
> 
> Then L2 exits to L1:
> 
>   __nested_vmx_vmexit()
>   |
>   -> kvm_make_request(KVM_REQ_APICV_UPDATE)
> 
>   vcpu_enter_guest(): KVM_REQ_APICV_UPDATE
>   -> kvm_vcpu_update_apicv()
>      |
>      -> __kvm_vcpu_update_apicv()
>         |
>         -> return // because if (apic->apicv_active == activate)
> 
> Reported-by: Chao Gao <chao.gao@intel.com>
> Closes: https://lore.kernel.org/all/aQ2jmnN8wUYVEawF@intel.com
> Fixes: 7c69661e225c ("KVM: nVMX: Defer APICv updates while L2 is active until L1 is active")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> [sean: write changelog]
> Link: https://patch.msgid.link/20251205231913.441872-3-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ exported vmx_refresh_apicv_exec_ctrl() and added declaration in vmx.h ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

