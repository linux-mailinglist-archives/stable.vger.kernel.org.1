Return-Path: <stable+bounces-238223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P/CLGkK4Gn2bwAAu9opvQ
	(envelope-from <stable+bounces-238223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:00:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D4E4085CD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FDD9305F833
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F3138F95D;
	Wed, 15 Apr 2026 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoV8faFy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4738F951
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290400; cv=none; b=GSfvXK3jlwYXiYfDuHLuCzeCdZuryq9pdjuuTglY9IWPpAYsY14SnCzur2slm3r+izoMviUYczZcmu3R1ivy17xO5JQveHXCmtxJ3/I2qbNorOt2pVmtq9wLHK8+vQzmcIz1worYsHZFcvjsyTGoDPj0rrK/cdc+/3g3ufTtgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290400; c=relaxed/simple;
	bh=HtHHQLyFrpyRD1K6YTlLXaKgJ56SQTDZhkN7NWqJQ/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lN1/r58yT35QnyX9ryMujsesQypnYXqgzPareJWZohJMo3il97IotKJyo19yt9W/ZBpfrd+H+7uTRbKI9RhVIsbDe5tvEhl3p1UpXKfDHazz23FUqgpRenHnmOcBn5oliMURJ6rVQRT+wj80DrYHi0ESw2rev7Ygy9ks/x4tLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JoV8faFy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f460260cfso3984488b3a.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776290399; x=1776895199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9zLiEKj3T6t8ihrer91NOzILwHRxAQN4Wp96+dLSss=;
        b=JoV8faFy2NRS3yuILA/4OvP+UJVygn1urR5FBI/YqjQS9RQssiW6SFYn3FlUHd5F/x
         fGTIhu5lc8nWTOji0yYoDJ/JXTrlYF+u4hHAvk1X1O26u+ZMUuTnAKabahm6ddLLnHTd
         LT9P8MBdI8YGrzS0x98NKr083hfj33YsCUObWT8bHZiRsRg1REMzqaIY/09ZUPhhgGfa
         7mtZUyKuUvR/ryQRkBl5XWU2gtcpRspX5oc2ebVZcqGjCwM/kmfvUlt5y1MNevvW3jq2
         cu/ePJw60Vs+/kGruVd0cDhl44AKO54tLNtx+q78XTbCR9wNjzDaEg39gRZNx5eUUsjV
         Dkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776290399; x=1776895199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9zLiEKj3T6t8ihrer91NOzILwHRxAQN4Wp96+dLSss=;
        b=jVyLUzliEDGRfpyfklCWg9eKQ3Tt+sjgYtvOh0exPakmz30jjgEfGFNQrNMhqs8+DB
         eDY2S3M4fiNWNI+Eq9R0Itds7hKVyRn7PV5HX4TyVat/CA0790nlE9Jqf1bzXjcP2EMh
         XiVSNKs+sqpNUXUCN5Hr4eC+YxHitV1m8/jIlfnAWJX8Vo18ub4gsGvPeK6yEeHvddDL
         +tlEJbR0obnVoV34NQeIB+1dtf+2uCixcf4GX6GsIKouKdVKUoOkx6RMUe3vQ/0yo7c4
         s1pFSolyt40gXwRR4ajrZexiZlUJUfisFkyO1//EGEGsm1FFdthiqVCyH/tuoyh8sbr3
         M4uQ==
X-Gm-Message-State: AOJu0Yz6SDDDBBmrdtbwuAmuFHp0+WagGipQne1tMu4Dm7xMt1E/FVh6
	1A1ij/lXo6BRkKUQnUGUXlCJi6PBQzN1Pr6EAZEVEtugGqWdapVpFsYPP0oHqV12tll88Ruj4bZ
	beU2o1w==
X-Received: from pfms9.prod.google.com ([2002:aa7:8289:0:b0:82f:49f6:76e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3699:b0:82f:3855:4b98
 with SMTP id d2e1a72fcca58-82f38554da8mr14915951b3a.8.1776290398714; Wed, 15
 Apr 2026 14:59:58 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:59:57 -0700
In-Reply-To: <20260413145835.2969194-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026041318-monogamy-woozy-29fe@gregkh> <20260413145835.2969194-1-sashal@kernel.org>
Message-ID: <aeAKXZPgB9gHLWD7@google.com>
Subject: Re: [PATCH 6.6.y] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238223-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 47D4E4085CD
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
> [ applied `__DECLARE_FLEX_ARRAY(char, name)` change directly instead of inside missing `#ifdef __KERNEL__` else branch ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

