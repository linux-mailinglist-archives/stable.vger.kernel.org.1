Return-Path: <stable+bounces-204913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9637CF580E
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88B5F304F118
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515CB3314DE;
	Mon,  5 Jan 2026 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQDge6A/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ACA320A2C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644546; cv=none; b=X7MgEEhP4zJ4ffr5sUo0X+zPcI8MXPrbShRhqh+omX4JaaAlRdmoq305BI9+aF5viWx77jR3dbsjsJnh6w5+1kp+Or46D2mHputhsIimObuP5I4BaaompfzgVb57hTsCJwqv5gxkaQx2tjEByDIzmPZ84dc5bY6kXoYTQ6t9A7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644546; c=relaxed/simple;
	bh=1jAC1RIoAKKNGqyL000Ba0t6tIYm4DtAoeIhOFC96JM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tybyL1TNvJRmx7c5JjYyR3K7yNZwx4v6ZPL92kIKtRa1r2+lmpMALIAR/lAtjIe5B/yymE6icNWD71A9Rn+9LJv6wsdAKk9RwjRdnEm3TLf0sK7mrxcZRyk2itAFhd8/1RvFAGI6Bna91TUi/jG8Wm4IhUNKTTXqJmGHQ+m9bZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQDge6A/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7f66686710fso784043b3a.3
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767644544; x=1768249344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4h39aYIECznL06dM7erNFHqb89TAmcNIfDdZFQ9BS5M=;
        b=YQDge6A/qOiFAIIyxJng0R/lr3BP75UFDA7Xy9o4fybeSheGnEFLwj0mltc0rwMIbh
         WeoAVovKM34u3wMIa9vrswTk2qXl+pBliRR8oRpNhoIP+6+l3di/wfiYcInHqhHj89an
         8IUkXT8RcuWWSVdAwjQioR+A3tAeNBAfN/RF6o3FURk+ftE30frQt/21zHE6q7WKD7Em
         mALbd8+wcoTex+Bwwugpr967K0OzIFKVoaqODydkmIALjalB4Z4ra6IED82H+gSbqCMa
         nrM50N9eua6FoNaMwMEumhHY6aJXlI5MIBrnW8Ql85OY+b5INqq00Cadfx7Elva0evpk
         003g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767644544; x=1768249344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h39aYIECznL06dM7erNFHqb89TAmcNIfDdZFQ9BS5M=;
        b=GKgYfAIg7sOnL9buUeU8Wm3hAjw7wgI8vvPk7hs6yyjCIW6443Y5gLG+olQ93Pjulh
         /E76IJGrSRydoY6XM9m36zf+FTtB3NSr+/WebtgRdJHAmoCK9iiTUMH42BXJqFIW9sZY
         3RNaah8mC4Nl+orSuU75KdHfq67WgOYnAtMm5eFegXEosVXo39Lpa8Gf6EtECwBvGK0o
         62z4tg87nhjxOIK6lZ/+vIv7/lPAirywh4//JRLQ8fKATyZJuTtneVoBm0ZxVDal/0yF
         NiZ2DrxgR6mqVtzdUu3VZVQDLIedwtzRDHLSL09YNOcqegwRz8QKnY2odhZuUdVyzBCj
         36pg==
X-Gm-Message-State: AOJu0Yy86KZgAy6e+wCrpNo6Ut5mFF1dlJeczrFxagpU165cz+yb89IK
	UYItGCGUlFwwmaTwZ+XNejQMmE+/OJTCVqN+AwMzF5KZK7EgQW4I5olU/MCxtznEYamTaQa2GJY
	riiWzng==
X-Google-Smtp-Source: AGHT+IHdTcc4ZmtreyEdQQxPzTFs8Z6dZ6tNBwxkZwq/aMbxQyOkqAMl9IBwOAZ9KJG1+iDgbZkpcdrMWuY=
X-Received: from pjsd10.prod.google.com ([2002:a17:90a:bf8a:b0:34c:d9a0:3bf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f9c:b0:371:7fee:7497
 with SMTP id adf61e73a8af0-389823c108dmr417600637.68.1767644543986; Mon, 05
 Jan 2026 12:22:23 -0800 (PST)
Date: Mon, 5 Jan 2026 12:22:22 -0800
In-Reply-To: <20251231150534.3104156-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025122917-cadet-worrier-23c0@gregkh> <20251231150534.3104156-1-sashal@kernel.org>
Message-ID: <aVwdfocPBS792-VX@google.com>
Subject: Re: [PATCH 6.6.y] KVM: nVMX: Immediately refresh APICv controls as
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

