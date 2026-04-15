Return-Path: <stable+bounces-238229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKcaNIoO4GmzcAAAu9opvQ
	(envelope-from <stable+bounces-238229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:17:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BFF408861
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5174D30BE0B4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEC3803F5;
	Wed, 15 Apr 2026 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiVXyert"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9321A434
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291422; cv=none; b=DWffwIa7UXJ7B57HTizMC/33l6bKvjB39GoFT1mhGORgMF/vQyX32PGiX8olZVt4mYXKl42iZ8prQQn6j2S5ZsfI6/OyT6N6ok3GNw8dZ7ZouZxxgDqaDIQJCBKo/o4y5trAb7l+xNSHdxIwKeiGnmz+unTAwGexibNm5uu3gMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291422; c=relaxed/simple;
	bh=CcCwRytegUwsJjSZ6eoAOigRploRUfqEvFZTbZletZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YXrpWAye5C0Rt7EAmg3/nIc0XGWBt/7Rhj4dqiGIB1cm4/mTPmt84h3TNjtsSXFgwOwM+5wBytV54Dh0oxLJgTW2M6EQQjCO1Zkj676xXAhrYsepxB+hFbrinM5HmQDBt7cRzfv2459aPLWQIU6onVo2XQQ7bqhgNtVXhY0ARG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiVXyert; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c79281bd14cso3241535a12.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776291421; x=1776896221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGo4VOJQPFyHusz55hlkxA3lp3eULjapJ3aQapxGGCk=;
        b=OiVXyertePQRRrSuG9Wcowee4jDkhH9Pc4WZqLBANVMRpaLiYsCkFGcTjJulSUOB1f
         1l9HcxWcStgqELJQgxV672B+78NOs79AU0Yj+w8Zicxoa8oY6Ctf73TzB1xwZbcZ05dG
         UjMWHR4R1smqTqKz/rBVLHqtixHM6OSenOMjRHkbcuI6p9s/Ma8KuqhsGxOrj1+HjYvA
         3vGZRH+GGJTiE7x5Xj+ab/7f35OHzXeWGhnT4PJvAIgmjCd3JtwNt1EkbjX/XzMmsG3r
         QyjVYfM70mbCPf9DfJfMPcrO3+LbLYdFOw3j+W1snTRAdWsJ8cQX1WpNQ7Rk0Q3/3pVV
         xDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291421; x=1776896221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGo4VOJQPFyHusz55hlkxA3lp3eULjapJ3aQapxGGCk=;
        b=nuhXOQz9rSt5cu5P4h+ClUQAxkVcr/4Y49ePYm8HaBtwgUIehnt0NgtER785dxm0Fd
         fRpURYXDiQjl4OTOyWhJFceV5B8hiZVZhCYA2RxliO02vNnuFPTOtXgN6BLCb7mSbudB
         nYx5rgSKy4Tgs3O1Hvtmd3eV1/Sh02V4spLkuZmLpzPYDXep3q2+sZz+UojA6YaSgdd7
         P7tFjje8dDRUUkWfdvTB1xCy4wGc7c23JV082RSaTWy4yW9n5E/iZjCgZ5cn2njPtEP0
         XQyzjgNbAtZrFVGdKxYqrjlUP6SQEC1vsYBZ+zaF0wZKo/CqpGbTCVCE7SRGG0nATAi1
         EaMw==
X-Gm-Message-State: AOJu0YxBatTUjx3En59O5sJ95biRqmjEogAQB74HcEFWExlQeFazhrYZ
	FQFECQWDqT3O6l8TJf3O2go8tR+c8VVHHNPX7mv8mt44eEhF1tsbdBKh+AG8tWOu7uG4olDt74T
	/papY4g==
X-Received: from pfav10.prod.google.com ([2002:a05:6a00:ab0a:b0:82f:805:b62a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2791:b0:82c:f035:6748
 with SMTP id d2e1a72fcca58-82f0c253756mr24313312b3a.42.1776291420760; Wed, 15
 Apr 2026 15:17:00 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:16:59 -0700
In-Reply-To: <20260413130125.2879436-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026041317-engaged-onset-3db3@gregkh> <20260413130125.2879436-1-sashal@kernel.org>
 <20260413130125.2879436-2-sashal@kernel.org>
Message-ID: <aeAOW_cvUq_uPrza@google.com>
Subject: Re: [PATCH 6.18.y 2/2] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238229-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,amazon.co.uk:email]
X-Rspamd-Queue-Id: 47BFF408861
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

