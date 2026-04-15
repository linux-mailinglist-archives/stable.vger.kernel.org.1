Return-Path: <stable+bounces-238222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMcoJycK4Gn2bwAAu9opvQ
	(envelope-from <stable+bounces-238222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:59:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A64085C4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D90E3301ECC8
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FFB390202;
	Wed, 15 Apr 2026 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZgXOEcI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1EC386C06
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290332; cv=none; b=ToBwWevQau8OEXCyZ+jKgItmp3BGsySLdOnonE9kfmpGiI7hpZ9Jd8JsvYXsCiea+63nooiHfZzpM7m9vG83WGlEzIMeUX95/Oj+Usj1qVH4UJYY/6UEIyJotRL177NOIQNOMUeFb7udoQgf7CSTfY+ImTl4oCBxRIfDfhPl950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290332; c=relaxed/simple;
	bh=HtHHQLyFrpyRD1K6YTlLXaKgJ56SQTDZhkN7NWqJQ/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lv+rDspmeUyjF94eV6jCOEw0YxIJJTkvufDK2a+x1lBTslcwtEKX3MobENNWPv+NCc6Wd0sFh1VHDVLJaHde+VeqIprYSIXb0Rux/keCx3qdLB1+vmNEMkGd5lzZbrV1SP8Yp0UZewpsekBNDShe8cxIWZzzv1nqS85ss3yX7U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZgXOEcI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70dd30025fso9342699a12.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776290331; x=1776895131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9zLiEKj3T6t8ihrer91NOzILwHRxAQN4Wp96+dLSss=;
        b=HZgXOEcIf6Go8bXyXy7NYDoQn/VHdlLey13h9sA0Kv8kz5k17dUB+7KjPFRPQSiXO0
         oKTlpy1FTa9LqhDLhHrBl904PMz7aNLBCtPzMndlh09pnka25763hsLn55K4YL/+nng8
         LD36B+KL0QE6cN1rhllTSGsY/MBF4+HmjLZmMrGvzR1ITO52NxU4yedR+gFdDJ6kv5XV
         zOZp6gWmAVX0V9yhQzBHoYGyNotZITiP//uESeFfhmXDIBqHYuZXsSa7PpyY8Mt7rGZh
         l8jOdJq2Bz5tjqADhisjTxXNJyMGmk9jD5Z9CABGJN+CGA00emm1W1Zxj5lHPw9NfDb1
         2InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776290331; x=1776895131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9zLiEKj3T6t8ihrer91NOzILwHRxAQN4Wp96+dLSss=;
        b=Aui+koQ+TkIUnbQY6znuEoaM4qHkB9jEhyxaCcmW+g5QJd+GV+FMSuuQelTiDyrh9a
         KdsKk5IGprsiDjnesHEPkDWA5KPPRZp9QpSOWLKa/I2CxlhhrOqp0wY6o6riR6lGomem
         9MIxSIzet2FODSwGSrI73JDCYwAVuKvVYUPydQKnp+7rsvqNQLCWs6MC7JXa3YDCj6cM
         ZXicVRV6yzx0o26fllSjRIQSl/LbLjgSm7b8uLqkbrmMu029k7Js/DBs3eWYXTDt9rFd
         0HgmEmr1JFd1at/XfjxsFYnhtnvBaySwWgDHh8cGhqmKAngWJ8/OzCnSq2mbfX+7Lgzn
         TsMA==
X-Gm-Message-State: AOJu0YzxV7mmmoA6ci5SBJZm3qVZgSbr99MChG+6Pq3Xrcrv5we8/zXr
	96cFD+Nf4/DwLoQgHsFga6uYf3hD5kEwVtK8kPOpZ7MTZFEdnxCIc+b6Dw2W5Hi1ecY0VxoCp/M
	Fqxrdlg==
X-Received: from pfbdh21.prod.google.com ([2002:a05:6a00:4795:b0:829:f706:70e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4388:b0:82c:ae58:4690
 with SMTP id d2e1a72fcca58-82f0c2f17b9mr23341809b3a.52.1776290330560; Wed, 15
 Apr 2026 14:58:50 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:58:49 -0700
In-Reply-To: <20260413152005.3014972-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026041319-perceive-bok-f424@gregkh> <20260413152005.3014972-1-sashal@kernel.org>
Message-ID: <aeAKGSfGF4z_S0FS@google.com>
Subject: Re: [PATCH 6.1.y] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI
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
	TAGGED_FROM(0.00)[bounces-238222-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: BF9A64085C4
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

