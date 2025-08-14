Return-Path: <stable+bounces-169599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6FEB26C73
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03AC3A6AFC
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E05199FB2;
	Thu, 14 Aug 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHtKc6Ra"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642711DD889
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188275; cv=none; b=lmYVQSQpRBTNOOa72ckYmhjjNR0zB5/tB0ct7Czxa1fqiVm/o48mXJzVM64SaadjDBcRmMyIgKayEcexGepS2ywFTUiHWEzZa0dsblKN2NTuv4ow9sh56r2cyd3WPCrDheenxeK09QCXRPSqxtzrDdMKq1do32qh4h4aVltrWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188275; c=relaxed/simple;
	bh=Lul2cOelkNHQHGgiL0sVPTaXHraoS6VHhVcE9U8NxYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cbY1b/4wVdk+pA8OqXApI2K5NdZrult/BqHR5+fteNjhEDgQf740o/UmAo04PTab6mtgQ98liAXhIAz847BYe3qjYTfVJ5mgR5Aou+UaNSnlLdc+W8a0Y2tN34GcOXmj2Fh0LRktV0HH5NFfRIol6OvHQdCxkutAsM/oprlo2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHtKc6Ra; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e1f439so1125032a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755188274; x=1755793074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=olsP8MliwTlsxFlZKFloEEBSqpNiu0oalGAUNxDbpBA=;
        b=xHtKc6Raxh9MKSrZV6mbYwwycjg2GJDHrJNkeC7VYWyfYWKs2/rVgk3WhuZYoA+huz
         j/mFsNB/VG8EXdPFJCKUvqwQ8oj15CehthSpNkYtRZa7kAEG69DfQYh1utD9/69t8ZNR
         VZnTXD5zsOrpPkq0NhDRA8KQsEVYycly0mXzYWPpon/FoD0dvdLT9iGPbi+ck255Pasu
         5eLfhxpOYOi44lM95Om38Fe/bC3xNd06CXd1x1VcOSfiIqbWmN8B5dYulYNnjTnYhZ05
         W2mpPYdGK9LINHrRlOukOqq5QaKDFWaOpKEfXiAIvwumph5HgPFjf0SyttTe57iIliQ5
         RwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188274; x=1755793074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olsP8MliwTlsxFlZKFloEEBSqpNiu0oalGAUNxDbpBA=;
        b=jaj2Ekaa2GnSPwfPU4lo2r0H19Kggkr0rpSk3rMC91k0h8AIRsGjf42Hi5OfVNQ6Wn
         bMPgQqh98MtFl7BXwu37WiQbx1om1hL+sYqzMkcmouc4HdcDO7UxZIxFozj66lK5raBJ
         k7y10g4RUoxVnlmHgeSzikbDWQaUEFqPk9N73py6kAjkSXfMuj1eOkSfjP70Z1heooTm
         kZRQ6yjbFTUIkZ/j0S6oqmNIuRbqvaWfFR4DBMe278Si6e1kUvQqec5DWcb9ISevz2V+
         4Dpup88J003Ups3cqaWaSnSKg2LeXSzjPsTfmBHKa2PviI54hl5jef1rIcgKa/+lSmTl
         AP2Q==
X-Gm-Message-State: AOJu0YzOBy4lF5kmc4ECHW7eG9adlCf+8lsoevicGpOkiQcwfQLKvJyi
	gcEobjd+ljMYVy6XPBe325tkXmOBz37NHzTpZ37mexryM1hxv1JNdOWfSICpDfgtKlzOnvnsD/i
	X15yV3g==
X-Google-Smtp-Source: AGHT+IHBntTUtozlSL8SAVpW8iNd7WM0CvCYIysVQ/y16CYxlqBAIECfCU3nEmKarJCSpJl+SnHG69wm4cc=
X-Received: from pjhk32.prod.google.com ([2002:a17:90a:4ca3:b0:321:cbe5:b93c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f85:b0:321:c37e:e325
 with SMTP id 98e67ed59e1d1-323279d8772mr6552017a91.12.1755188273719; Thu, 14
 Aug 2025 09:17:53 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:17:52 -0700
In-Reply-To: <20250814125614.2090890-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081209-sworn-unholy-36ad@gregkh> <20250814125614.2090890-1-sashal@kernel.org>
 <20250814125614.2090890-2-sashal@kernel.org>
Message-ID: <aJ4MMNPMLcMf2jJP@google.com>
Subject: Re: [PATCH 6.12.y 2/3] KVM: nVMX: Check vmcs12->guest_ia32_debugctl
 on nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 095686e6fcb4150f0a55b1a25987fad3d8af58d6 ]
> 
> Add a consistency check for L2's guest_ia32_debugctl, as KVM only supports
> a subset of hardware functionality, i.e. KVM can't rely on hardware to
> detect illegal/unsupported values.  Failure to check the vmcs12 value
> would allow the guest to load any harware-supported value while running L2.
> 
> Take care to exempt BTF and LBR from the validity check in order to match
> KVM's behavior for writes via WRMSR, but without clobbering vmcs12.  Even
> if VM_EXIT_SAVE_DEBUG_CONTROLS is set in vmcs12, L1 can reasonably expect
> that vmcs12->guest_ia32_debugctl will not be modified if writes to the MSR
> are being intercepted.
> 
> Arguably, KVM _should_ update vmcs12 if VM_EXIT_SAVE_DEBUG_CONTROLS is set
> *and* writes to MSR_IA32_DEBUGCTLMSR are not being intercepted by L1, but
> that would incur non-trivial complexity and wouldn't change the fact that
> KVM's handling of DEBUGCTL is blatantly broken.  I.e. the extra complexity
> is not worth carrying.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-7-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

Same caveat, needs to land after the RTM_DEBUG change:
https://lore.kernel.org/all/20250813182455.2068642-1-sashal@kernel.org

