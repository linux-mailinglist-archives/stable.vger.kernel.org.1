Return-Path: <stable+bounces-238231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHJSGzYP4GmzcAAAu9opvQ
	(envelope-from <stable+bounces-238231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:20:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA94088AE
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A72830A5DC2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D48374197;
	Wed, 15 Apr 2026 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amVG5gwp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4B373BEE
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291635; cv=none; b=oIK18oB7Kc2/VFlTwR0AgP6JrVebY7dX4TxC/fDUuE1to1EX25KlH8YsY0YqpBLMxUs0fSS3f1N1SGqUkaGQT3bdZvPKoqJqXyYMJCLppyfYTQkcsBOxIDXfXoVZLjs6dHgF+2at7xc4LWQFobME0hOEYddEVH43pXParBSxCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291635; c=relaxed/simple;
	bh=vdpdh0xkIajBHZM7qoM+xUEgxrphiImhs+GqNY7hsgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L5rOCbgfFbKry01MLDSOnHKcFkuOQRWkTIcftC/VdbUc7JJ0cZ7e89tEanc+BApCmAvBNIAM5P8HYOf/og/3ETxvWIKCGx60r9FI7iYv0qD3eACwsJiMBGl1ZlnTWQC34JWulsX5z7lBl8Cezr5pWTmldMRiwhiB/HqGJWFQs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amVG5gwp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35842aa350fso13800175a91.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776291633; x=1776896433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QToygMVPGVk7KubMavoRHu5zoGCxschPTOHOfHs+CAE=;
        b=amVG5gwpo6T9HKLFuKS2ujxjnEvTvlN+UV61Mls7/1FTaNQ8TSnAtjR2rGYxz7k2yo
         xNhEVp4rPEP1Yy6CzviCV8mKAIzImtYeJB7nhwmRxOg7uC7+4g+wbkAOVhPja0WHjETq
         g0+6Im6SdIrcuymovcPmXygmTJWEM2l5NvMNtfcEJWVI7MRe77n7vdvrlgaqT/oeY1pw
         /oYhbXO+6TTq1TRr/w45JCns5MsvxAXhWLqJ2N096wBXmEt8dbvPDXXUzowqIRBYoQQG
         Q2mLuyGguGGif2gmYViUVgZFG3GMbhdKmj2RLjIblkNaxPMORPhzvxCJSVxVjM9C3NbO
         3hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291633; x=1776896433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QToygMVPGVk7KubMavoRHu5zoGCxschPTOHOfHs+CAE=;
        b=bMqJP68tcEJJlQH/LCW5cNeuIJ4ki81PHkzav0inxs4lOqpRGN8RnjMWfGKZOZmfnv
         fgrp47jiZ/Hq8bQJ5sUmGT94H4L39pGYXciuUA8Pu3HR020wiSJ0UKCpcm8M9YbYvhGB
         N8FhXkYvedcrq5zh+AQOInoN8h76wZ5sn//8UoIpLsH/wZWSWV4j5ALP+nW8yvSb64cq
         nWLI8fRS+VXBni3iv3r2b1nDwcXrFR3Nv3d2es7clZjjCcWMdSL4+8O9mNrm5VkHB25v
         Juswk8rTM9yFVM52v+fcs33s8OtgUmhXVXBs1A1musNGP2c+hg284BL08JAof0MnDzbb
         9ZtA==
X-Gm-Message-State: AOJu0Yzm0ZsL2eU4C+HORsZ/aPqmagqZ8mN5AEnCgheBtK/GhRuWpM5h
	41Ui9ye8RSqd3uWotwiJJAObRXcH9qtfEO4l0DLWWOD2GXhO28RWypT6wtEGD3Np25J0XfUEZol
	dPhH0xA==
X-Received: from pgbdp8.prod.google.com ([2002:a05:6a02:f08:b0:c74:2046:ade])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e292:b0:39b:8545:f0d
 with SMTP id adf61e73a8af0-39fe4064a87mr26156990637.51.1776291633300; Wed, 15
 Apr 2026 15:20:33 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:20:32 -0700
In-Reply-To: <20260413125149.2876836-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026041316-tribunal-pendant-dc80@gregkh> <20260413125149.2876836-1-sashal@kernel.org>
Message-ID: <aeAPMPp_HFiJTq2J@google.com>
Subject: Re: [PATCH 6.19.y 1/2] KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238231-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,brainfault.org:email]
X-Rspamd-Queue-Id: C3FA94088AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit da142f3d373a6ddaca0119615a8db2175ddc4121 ]
> 
> Remove KVM's internal pseudo-overlay of kvm_stats_desc, which subtly
> aliases the flexible name[] in the uAPI definition with a fixed-size array
> of the same name.  The unusual embedded structure results in compiler
> warnings due to -Wflex-array-member-not-at-end, and also necessitates an
> extra level of dereferencing in KVM.  To avoid the "overlay", define the
> uAPI structure to have a fixed-size name when building for the kernel.
> 
> Opportunistically clean up the indentation for the stats macros, and
> replace spaces with tabs.
> 
> No functional change intended.
> 
> Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Closes: https://lore.kernel.org/all/aPfNKRpLfhmhYqfP@kspp
> Acked-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> [..]
> Acked-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Link: https://patch.msgid.link/20251205232655.445294-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 2619da73bb2f ("KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

