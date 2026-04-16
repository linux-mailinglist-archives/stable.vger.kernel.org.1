Return-Path: <stable+bounces-238237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PEJHY8u4GnmdAAAu9opvQ
	(envelope-from <stable+bounces-238237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 02:34:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ACE4094C9
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 02:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4394730EE76D
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6111A6805;
	Thu, 16 Apr 2026 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoEm8Oen"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EB1E531
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776299426; cv=none; b=nv5EYVSG55v5CJhKRaZRHTbFzEfLyh60AdaxHCvA2vCIoktWpcTDUIpAtynhyNIXBlKwE6hkwGptARP29rFDzBmCCXV5G+4omZhnMZj5pOSAiG5b9IG7j4ONoqD/jibeiGGcIxSu6tmy+7GewLyAPp+cXe1Rf9+xAoj48ZHRy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776299426; c=relaxed/simple;
	bh=CcCwRytegUwsJjSZ6eoAOigRploRUfqEvFZTbZletZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kSux/2igxkn5Lpreq09sgU3Qceb0j7ZS9GbTXBXaCm0wq9HKqXnb4dtQM8+d4vo4m5rHEmwjXT/ur7BVrkfiaxOlB5bwMLGPk93kCKk5Oar95aakuxpVrGrzNWjoAvKi3mUd1SbUDY9YI0FJyMd8Aj/6xdAzpsKbZNa0VWend+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoEm8Oen; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f2478c37bso6035236b3a.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776299425; x=1776904225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGo4VOJQPFyHusz55hlkxA3lp3eULjapJ3aQapxGGCk=;
        b=aoEm8OenhaSdolh21/YisaP6qP24cAO0xwq87gAJLFIrYHFSVlVPD8uTOq2DFFibTv
         uGxWHY3CXj8FeVlu+/KlKVV/k9uEhfzhCzDejsDYchA+5Lv84iCYqOIkjge2XMJ+EvCR
         7ayGgj6ZOKSVpat7Gxw0LYpwEPm5w+yrE4gDIrKRz+rSignaF7AX/IyL0ltaNgsQaekp
         9kVQOUubV9JS2YUzdzGNfvRvT4ieoVSHrNmjIeJO+GMVdG0XTmy/Ysm6yjflpy/DhFBu
         mgBz2HhrglpdW0x/EOc7YjiMRPX2k/MkmLlB8YNEG4W0jUzDN3hZ72EP9Qcz507xXnLp
         817g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776299425; x=1776904225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGo4VOJQPFyHusz55hlkxA3lp3eULjapJ3aQapxGGCk=;
        b=OJHizsjgYNNXaXFeQiB5FYSudXo2ADfZsVNCGVayts6KDanl4QDApnOLUeG9FWVdRf
         sXLYpd6DUNnX65BY0LTdM9YNhwxNoid7pf1GxXmkh73jco6uDYdXbgBpjHSOU81MKP+R
         p57XIuX6HEWS5RPofCtoQJI0UW7SoNRdyeCspeEJGHQ5ScnClaOugXIEU9UnjCbbmDfM
         h5TukULVLQ6CA/tFCAVOQfdf2mirBD0dYT6dF/8pHZtK4YoIRTOhm/72S9INHQHNiv3J
         fv7B5DLU/c4P+mWdXk+ggeBdeKi+QUiKT55amhCS2nVz57lXCOI3zDystARjRDkndr2t
         c72w==
X-Gm-Message-State: AOJu0Yy5SZ6r+SLaG13UfeEL7aicI+YQ+1h4eHntojBK3yxwji5Ma/5m
	jZaDBd40Sh7lbSrJqtRauwj9qKKfdAT4/iNF/lGqipt0U8X/XdtuVej/eUReQ3pbMCLimZ76Zo1
	WlohLxQ==
X-Received: from pfbcj18.prod.google.com ([2002:a05:6a00:2992:b0:82a:6195:3c55])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4981:b0:82f:776f:a78a
 with SMTP id d2e1a72fcca58-82f776fb4efmr827828b3a.30.1776299424746; Wed, 15
 Apr 2026 17:30:24 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:30:23 -0700
In-Reply-To: <20260413125149.2876836-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026041316-tribunal-pendant-dc80@gregkh> <20260413125149.2876836-1-sashal@kernel.org>
 <20260413125149.2876836-2-sashal@kernel.org>
Message-ID: <aeAtn87DZDv9hab7@google.com>
Subject: Re: [PATCH 6.19.y 2/2] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI
 structures with VLAs
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238237-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 05ACE4094C9
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

