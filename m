Return-Path: <stable+bounces-225415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COGvDPFBtWmiyQAAu9opvQ
	(envelope-from <stable+bounces-225415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:09:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2E028CD29
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17915300DCF8
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D38202F70;
	Sat, 14 Mar 2026 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwgP8Hvl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415317B50F;
	Sat, 14 Mar 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773486574; cv=none; b=t4lK8b8mVMtrnx6co6U0ngt1VrwZyRJP7ZDWKfCbT+nmSWmHqf37FcVq8azolKVwYF+nOoHkYniTJeIBrEl2WkpzdwI/ut3hRMCIntQvaxy0754xu6QhdGPMbWsP/X0JB/Jcocr7vLRrOApoewzbsgoGa2uPsMolk8Df7crgdD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773486574; c=relaxed/simple;
	bh=FsIdoywK9beEGP500Y5qRV1jmRWb97tBn7YIlx7LUOQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U4qZnoEQgLLpqsXiQ7K6opvYgy3i3e5HgroThZfrMHcTpbDPWWx6fpGmDbwh0olHOh+/1WQio1WeqrrycwG7JRI5JIR20HU/a1y49gRog77aS0sHENbPp78QEjEiOm90YlM5ZMKxNliecsrHXx9DgjRj7OUTDB5xVu/uI7K2g5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwgP8Hvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072E8C116C6;
	Sat, 14 Mar 2026 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773486573;
	bh=FsIdoywK9beEGP500Y5qRV1jmRWb97tBn7YIlx7LUOQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cwgP8Hvlsp1NLiGJ3Waw5c+mGf4ZOp059dd1X+SRUpFCs8OMZHVcw4Y/XDG8fxwP7
	 Nbq6Wwzjf4wWcr8AYL0V1rpCYv0YAuW1feiHX3eNobdrA/tQYDhBwWAPGElblCAQTn
	 XjFLKQxIsAhF4n5wYJi8T7VC3AsM5WMVeGg1W2ODJYz9554cE3CJR0+K6NW9OLUfKK
	 v4+IsP6bHZsONsEXdwWJDrwFXgM3jJ8WyXmc5hm1bLDVbkMFTzRazKU4gvxD8LhrTg
	 0cAngWpWCFC/HKS2C1dAh9YmXJQFkE8GcKRDZ8IFBSxC3DehkLMO18ZCORh0JI4AtD
	 uS1gozNea7dQA==
Content-Type: multipart/mixed; boundary="===============7202453078316456263=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dfa065670c02c16c71cac4773c62208f2b031198d9cf070d1b69a5ce0ff3d7ab@mail.kernel.org>
In-Reply-To: <20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f@outlook.com>
References: <20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f@outlook.com>
Subject: Re: [PATCH bpf] bpf: do not use kmalloc_nolock when !HAVE_CMPXCHG_DOUBLE
From: bot+bpf-ci@kernel.org
To: rsworktech@outlook.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,bigeasy@linutronix.de,clrkwllms@kernel.org,rostedt@goodmis.org,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr
Cc: ameryhung@gmail.com,linux-riscv@lists.infradead.org,stable@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-rt-devel@lists.linux.dev,rsworktech@outlook.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 14 Mar 2026 11:09:33 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225415-lists,stable=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,outlook.com,kernel.org,iogearbox.net,linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid]
X-Rspamd-Queue-Id: BE2E028CD29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============7202453078316456263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 9c96a4477f81..8e4b0fe6d12a 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -894,7 +894,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>  	 * preemptible context. Thus, enforce all storages to use
>  	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
>  	 */
> -	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
> +	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +		KMALLOC_NOLOCK_SUPPORTED ? true : use_kmalloc_nolock;

Should the comment above be updated to reflect the new behavior?
It currently says "enforce all storages to use kmalloc_nolock()
when CONFIG_PREEMPT_RT is enabled", but the code now only enforces
kmalloc_nolock when both CONFIG_PREEMPT_RT and
CONFIG_HAVE_CMPXCHG_DOUBLE are enabled. On PREEMPT_RT without
HAVE_CMPXCHG_DOUBLE, the override is silently skipped and the
caller's value is used instead.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23086356774
--===============7202453078316456263==--

