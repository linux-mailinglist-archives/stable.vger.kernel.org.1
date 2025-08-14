Return-Path: <stable+bounces-169588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AAEB26BD0
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488AB1CE5B95
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8822E3FA;
	Thu, 14 Aug 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdxEwGQp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70C1C5486
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187026; cv=none; b=OKUelgnEX9DJSCPmO+ss5A0pmCxP98V54csHkoKGq0uxnZnrKYfAqTcqBmoC7upUvWzvebxMqO0keW+0sv2AQNlx9K8tklSHrXdjEhjcYGXgjOYnybRIYrNpuIS1drzaMxhMiw2aE5gGfxyw0+6R1bJudJDZb20Wolpqwsnl0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187026; c=relaxed/simple;
	bh=3M6olNCkfBgg79SBlkoN6YaHd1iwdF64SMcb1OiDJSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aB5w7aj95JbptJ08nmSHLm99uP0MapV8KUgBPCL9vBaVkEnt7pBdwk4aAGscUCuQ4ZomVIAl5B0ok3O7w0XHvRmSM50ei6b7sGlRIFvnLfBuhM+gzl9IMqGhdTYOnqkyTWq4scHo46npZuiqNXglgrDBV+P8WS6qdw2GIjaLE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdxEwGQp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323267915ebso2100906a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755187024; x=1755791824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZln5AlMLNKwBYNNEImRxFo070vZbrB9DRk7vU6UURM=;
        b=TdxEwGQp680idpRFkaffFdK9j7GHKtd7p0B29UQVSuabnfA2w/PCBvDYRy8uNIAdp3
         2Y5CZBTrh01IMbtbuN0TC1TFA8fyxCGE+G8ohoVB/H/oj8UxAxTixfFfRNVXV97q3WU/
         g4cY+A6R8ujxX4C3Ooxf+JA+qZRTku19B5IyqxR5x57wQLaFc5rOrT2rXQFbg0V4iV7r
         +8kgn3XF+x1GikM4XBnY3kMlNaGVQR+4Mwsq57HDwyubn8C4dObIfofApoqsr4N0+GkI
         k9zPrEXBpZhql8IPXm/fplOFzXcadAW77rhzFKkcKIsEo21l4TBVQU0Fbno336pW0x2r
         WwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187024; x=1755791824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZln5AlMLNKwBYNNEImRxFo070vZbrB9DRk7vU6UURM=;
        b=VjYcinwO12rXyo0PnxcY6tQwAS4uR8PRFQUgXHvx9vDgsIxBsTotz6hc/a/jqHQl0w
         B2oHb30aBRFe03aVUZ+c3oO8xMsgcZ/WkzjvjoFbCDx5EsYCBghVvC9vHypxcp9D0LFh
         gbo7Z2SrOJ+cfglZmb6ZP+wHhqJyW5neHbr8nXXbSAMwlN3G8t6cQ2uGBftj3l9q7dc9
         o1C9aAN67Vf8dTbkfer1d6X2XedW6YCcbBJhnFcBUbAUgsjX5rwOrdXNKAnsDohvRqT/
         s/JvRNl8DQ81FK8XEKB7x8Zx/wB3kRzuGUANq2cDcIMVolpY0BQI8blnNafr0ZAXJTzg
         RzyA==
X-Gm-Message-State: AOJu0YzqesU7mYsoZ5iRv4hjcbhyQCX8KW/A+1JPX2ShyTyNatCk4hJh
	BPi7uyZyreePEpI6NDRLVT0kJyVcH6Z91XbVUXa5lthe5/yZWzX4Z6Aer0eowOymmplN1CADnzf
	wG+qTiA==
X-Google-Smtp-Source: AGHT+IGkerUL2cLZDPWZvUCNahk3WWBCW43AyTuiGoYr4yc4kIJylgBdsIjSlG0DmD363AxCXFB4LnLbAA0=
X-Received: from pjbsb5.prod.google.com ([2002:a17:90b:50c5:b0:312:ea08:fa64])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a45:b0:31f:1757:f9f4
 with SMTP id 98e67ed59e1d1-32327a864d1mr5906907a91.24.1755187024068; Thu, 14
 Aug 2025 08:57:04 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:57:02 -0700
In-Reply-To: <20250814125201.2090009-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081208-petition-barcode-1e2a@gregkh> <20250814125201.2090009-1-sashal@kernel.org>
 <20250814125201.2090009-3-sashal@kernel.org>
Message-ID: <aJ4HTpfkAop583Jv@google.com>
Subject: Re: [PATCH 6.15.y 3/3] KVM: VMX: Wrap all accesses to IA32_DEBUGCTL
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

