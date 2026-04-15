Return-Path: <stable+bounces-238227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF5gECAO4GmzcAAAu9opvQ
	(envelope-from <stable+bounces-238227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:16:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B3A4087FD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 773F13022AB6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07F03909B6;
	Wed, 15 Apr 2026 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dp7oMaNQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58E21A434
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291314; cv=none; b=n8l5yZd8rJISkd9og+dbgIn5kgXaCE/78a1qIR2m0KQUaDrBN1vqdCPEqDUMybx63dsyLfKE788DRVB+nRF8gOYjwCXA0HyM2oJHk7bLXMkCFHIAsaQU1n9f5Z6z3/Msz7IhlzdVM3/dD/McSo+2JVx4LavQ2hjBlcqTcNTFAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291314; c=relaxed/simple;
	bh=CcCwRytegUwsJjSZ6eoAOigRploRUfqEvFZTbZletZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0K9GVhxYerW3Wq1dW66y4N+TvMjrwCfvAO4+YgEy3YLjmIXwxgDhP37g8ydm389yjMvZH5K2eIr0shgZw/baVXCrQUVTbCom+9pKeVYl+CCbYQPtGiAwy9MVaY7QTZb/F3fr7JF08OosTUBgk1pEwRHnOd9fSkgxQNDHbXNVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dp7oMaNQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e91add2aso44901525ad.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776291313; x=1776896113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGo4VOJQPFyHusz55hlkxA3lp3eULjapJ3aQapxGGCk=;
        b=dp7oMaNQCXmdryY/a+4Ax1iepQ9QP/eCbZmAhAChGTB7RxWErk520Nli6D7JPUofCw
         gkxnbw30pOCWTdDWBDcMYvIL7UsI8c/t6WqrdN/79aESEvs1EwQx7wtyv1h7YKwlWoUK
         iV/1vGn2OQEqaRpwRbtUVTapILt2sDj0U3IitozMbSP0lKlNRjpnHZOEgvp8lsGByZLz
         nw1ksXCzCtkVACeuJCVoHxFK1vGtdvQeynHnr9xpmtuLUC281vxq6eC5suB60bCvzj9t
         4Fi+d0tt2U5g6orWsJ5vpfJo+Kqxrs04uDik0zoUwJbX1W0tdgLJ4eweOAvPixOFYQi8
         UVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291313; x=1776896113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGo4VOJQPFyHusz55hlkxA3lp3eULjapJ3aQapxGGCk=;
        b=T/QTEz9KTt82BMnUUBcs9nR0cdNcKcwZVaGBclNYHRc4X6FqzolG7RHtYwAux2L6yw
         Dr4kNxZvxMdhMfSsyQzhE4ubcrG7a7rgYLsktvld8miAAJ1ebR7ud+izdlOC+jvyrR7M
         0Ga5x7kK/1h+CQqZU7mjpj7qZuoCVrGVazzsStYODw003saKOE1FXtY70DgqCDVxyNkl
         phdNvMTS9MuN5Q5aqRP2JrOETc0ilxkLZhxU62ZeXMS7PrswGxh/3ocRM4ZxXGXM1ecf
         VCg86KsUpFp8iMncx49nJNA+THxGtK+nNcrNQzNliAivJ+xZPuFJAudPxKsiQ01+Kcwy
         RJgg==
X-Gm-Message-State: AOJu0YyVyJXZkHY+wVBctU8X7+lrvd3a3sfjHXz4THImB8X4flO+6P7I
	7ra65bGPFPHJlME8YmwEQO0dshFWK+ry0Vw7GQ1Z3xorNvFM32XrYbPeemMgPLteGzJRKgflBXB
	Q/og26w==
X-Received: from plsc1.prod.google.com ([2002:a17:902:b681:b0:2b0:5e63:fc48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acf:b0:2b2:539b:d29a
 with SMTP id d9443c01a7336-2b2d5a1525amr241068115ad.23.1776291312762; Wed, 15
 Apr 2026 15:15:12 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:15:11 -0700
In-Reply-To: <20260413140746.2904035-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026041318-chowder-paper-ef87@gregkh> <20260413140746.2904035-1-sashal@kernel.org>
 <20260413140746.2904035-2-sashal@kernel.org>
Message-ID: <aeAN7-QftlPxuYzE@google.com>
Subject: Re: [PATCH 6.12.y 2/2] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI
 structures with VLAs
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238227-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[msgid.link:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85B3A4087FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026, Sasha Levin wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> [ Upstream commit 2619da73bb2f10d88f7e1087125c40144fdf0987 ]
> 
> Commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
> flexible-array members") broke the userspace API for C++.
> 
> These structures ending in VLAs are typically a *header*, which can be
> followed by an arbitrary number of entries. Userspace typically creates
> a larger structure with some non-zero number of entries, for example in
> QEMU's kvm_arch_get_supported_msr_feature():
> 
>     struct {
>         struct kvm_msrs info;
>         struct kvm_msr_entry entries[1];
>     } msr_data = {};
> 
> While that works in C, it fails in C++ with an error like:
>  flexible array member 'kvm_msrs::entries' not at end of 'struct msr_data'
> 
> Fix this by using __DECLARE_FLEX_ARRAY() for the VLA, which uses [0]
> for C++ compilation.
> 
> Fixes: 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with flexible-array members")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Link: https://patch.msgid.link/3abaf6aefd6e5efeff3b860ac38421d9dec908db.camel@infradead.org
> [sean: tag for stable@]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

