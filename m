Return-Path: <stable+bounces-246687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFljJU+hA2qe8QEAu9opvQ
	(envelope-from <stable+bounces-246687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:53:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4F52AA5A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9108F30476F7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC3393DE2;
	Tue, 12 May 2026 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQuPwmon"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC061393DE6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622796; cv=none; b=dvc5HkAfzd8exdb2wN9Db7IaN0v55r6psZ8iNPfB1Y8/s5Y7OASDbxvJsz8gzQPJw0C/0lLZ1tDNED0E/rzcwcu9V2O3XeVbmzYT7PT1K8jX+hz8vbM92ltInzBsBf6jeFx5Y98h33sCrcZEfa6hkUsTPH54wnOuq53Z67y/9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622796; c=relaxed/simple;
	bh=5f0sbgLOx99dwJMkBq5NiUwfH0lg4jMa9lQjzCvSrPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BhpwaxJpcXENQwZYWFqHt0c3OeDlQcsm34GgpgHdQfCzj4nn11+J/B42bko+QCG12LpOfkUmlsbKdIsyxhdo6XA2405dkPOX4Al0Y0WpV2MZaw2EBOITIt5ADz0oCCSwlUrWUrgs2D/P7pEk/N/cNKn5QnNKD2IBo/B7e0PaEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQuPwmon; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso5667197b3a.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 14:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778622793; x=1779227593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvVTealEAKbqzDp6SQK7MaRjPvv5/iK5fsP9B8BXPtw=;
        b=oQuPwmonHYfSklAUh6FnwZ+uQcCwWnefLhTeK4Zl3R9AoP0ezPeBctjBGaoh4uU1Jx
         2IwiMOUFs9halxXGMHtbCnnktLLphFHJQ4MtkWhyCcNBZAPMln6gATucD5e6yyxyGdkt
         5xbrDUfqKCRmnkW26AP9sigZhwgE0FdM0csp2aartlSPpdXgUsWgi9YEQCKIN7urhE78
         WQQrknEzJ0Ve7xLtp3wjor2M9YbREuvlt9B2JBF8Gn81dmawsETE0vaZdorTx+1bHQdA
         Gy78lETwh1G8BT2bmHxgUNScKnfrcuZfx26hG6rypEBz1R1YzUeZV3pMd9qMzEoMDasf
         bq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622793; x=1779227593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvVTealEAKbqzDp6SQK7MaRjPvv5/iK5fsP9B8BXPtw=;
        b=ari5SFxLRJ6h5o2JpfSVoGk8SmAdBAm+yJgreFnwT2IUkhabC5x+9nZRW5IYGB1Rgz
         1CB26GExMT5O8XVMd/UXvjxlP2aSWUQLYDmoFkwvapfKDIrJkpdFW+OuuA7Spiz5Pukh
         DzO6oeWqdMA8YASWNNVt81OZLid787ZaYBbnyXREVvSO/RHZy12/NdR30Tdvw82T6HED
         sAhM2nch15xiwhyzkksEH0ROUv7UNXZelbNoLQHx1ioaXhd9w0E+5oEoisglPMVtc4vy
         HmjcVlrFY0uSHN7rM1v6SmaC+pj8OL/PxWif+CbQtN2aPXpd6A9K5oEDlTXfUIJqJNJf
         4Fxg==
X-Forwarded-Encrypted: i=1; AFNElJ8F7tIgLiMC2Ij64Bz45Zy3R9dV64WnIZxMmKkEAHVvLQLcfhg73CZGSdzV338Ez2r8kZaazyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybp8aD2NdcMsLVcqO11W0lYp5TF6J6qC1/ni/g/DgTppbLIgzd
	jlOS16ZNVwMGAHr5LHhLOlBOB0rGBzzMirt21y/Ek8eaJX5RZEtppjvBtSZ2MGPJcmmLzI8j4wn
	PwlNsoA==
X-Received: from pfvo27.prod.google.com ([2002:a05:6a00:1b5b:b0:837:e90f:8cd9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a06:b0:82f:7b98:e499
 with SMTP id d2e1a72fcca58-83f058b2dc4mr95628b3a.31.1778622792910; Tue, 12
 May 2026 14:53:12 -0700 (PDT)
Date: Tue, 12 May 2026 14:53:12 -0700
In-Reply-To: <20260512205250.313933-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512173940.376401154@linuxfoundation.org> <20260512205250.313933-1-ojeda@kernel.org>
Message-ID: <agOhSMXZGSv0bPhX@google.com>
Subject: Re: [PATCH 6.18 091/270] LoongArch: KVM: Compile switch.S directly
 into the kernel
From: Sean Christopherson <seanjc@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>, 
	chenhuacai@loongson.cn, lixianglai@loongson.cn, patches@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 32C4F52AA5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246687-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,loongson.cn:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026, Miguel Ojeda wrote:
> On Tue, 12 May 2026 19:38:12 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > 6.18-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Xianglai Li <lixianglai@loongson.cn>
> >
> > commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.
> >
> > If we directly compile the switch.S file into the kernel, the address of
> > the kvm_exc_entry function will definitely be within the DMW memory area.
> > Therefore, we will no longer need to perform a copy relocation of the
> > kvm_exc_entry.
> >
> > So this patch compiles switch.S directly into the kernel, and then remove
> > the copy relocation execution logic for the kvm_exc_entry function.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> For loongarch64, I am seeing a bunch of errors like:
> 
>     arch/loongarch/kvm/switch.S:201:1: error: unrecognized instruction mnemonic
>     EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
>     ^
> 
> `EXPORT_SYMBOL_FOR_KVM` does not exist in 6.18. Does this need a subset
> of commit 6276c67f2bc4 ("x86: Restrict KVM-induced symbol exports to KVM
> modules where obvious/possible")?

Either that or just convert EXPORT_SYMBOL_FOR_KVM() => EXPORT_SYMBOL_GPL().  If
that's somewhat scriptable for ongoing LTS backports, that's probably the best
option.  EXPORT_SYMBOL_FOR_KVM() will only work for 6.18, and the list of backports
needed to get EXPORT_SYMBOL_FOR_MODULES() working on older LTS kernels looks to
be non-trivial

If we do end up backporting EXPORT_SYMBOL_FOR_KVM() and others, we might as well
also grab a subset of 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() for the
mediated APIs") to ensure a kvm_types.h stub is present on all archs.  That way
EXPORT_SYMBOL_FOR_KVM() usage in arch-neutral code will also work.

diff --git include/asm-generic/Kbuild include/asm-generic/Kbuild
index 295c94a3ccc1..9aff61e7b8f2 100644
--- include/asm-generic/Kbuild
+++ include/asm-generic/Kbuild
@@ -32,6 +32,7 @@ mandatory-y += irq_work.h
 mandatory-y += kdebug.h
 mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
+mandatory-y += kvm_types.h
 mandatory-y += linkage.h
 mandatory-y += local.h
 mandatory-y += local64.h


