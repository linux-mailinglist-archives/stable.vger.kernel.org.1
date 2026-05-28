Return-Path: <stable+bounces-256446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPCEO2bUGGrSnwgAu9opvQ
	(envelope-from <stable+bounces-256446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:48:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4265FB81A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69271304EA20
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96EE34CFC2;
	Thu, 28 May 2026 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQFy//Ys"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F022EFD9B;
	Thu, 28 May 2026 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012055; cv=none; b=brlHVqDHX3nouzpwCXr96z5CLHS8P2futPtgFqRUTu/IgWeswYPj6/mvZ+NUN0bdStacGBnJyqa+shlIvXefiXKkSlAUm3s61uHVfCzxNEgOGBX8oWAAyMJImCSjsPmxHIsTpukToK7yc+0GwXq873e+ahxbmdWi0vuXm9nxhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012055; c=relaxed/simple;
	bh=A6Ea2s0Nl0DjlhqASqS0+2K8Na9DvmEWVzJOKF1+nCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L957v4ingD4xTd2qErv8VjkyhtTcL4P/WyWbS4Sz0MQtfFEaGMsNrjqGH6BfTzE0zAunLsLN8wWYsrOi9xlCOW0PRLi8X2Ve/esq/I4GQH1hMw/hUjcDDeGefnhTtxcLBYuBhPQkJ59XqWcNBNpfOpQeunlziQW5khkjPO+VHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQFy//Ys; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7373E1F000E9;
	Thu, 28 May 2026 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780012054;
	bh=noZp9qsoZp8RybKy58s89H/97RxvwSavZV3ULdPkyE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kQFy//YsFECVAYYInXm6tf3zYom1yx9TA64tLkprEwe7ml6WnqdP6K1eVlRtWUTvy
	 6Z6nd56VJfI9xlBxLwzhkmA08Lrxju2lsjfAoM/dxGwcTstmhylrCgXRyMiH+63SyA
	 ZrUj1jE/xYCyMXRpQOmPGO8ELk3Q1K4jB14Op5rR2264tuU8LAgQaxv0xF6vNKKWlp
	 s5eStSPELVRIPFCsxN1lxRygovXQm8yB3ekMzh8GSJSED4+S3kHqHY+uFx8+qOd+dn
	 16LHG07UYiMn+XNCeCkBfk8qSaJ3/7g4M7sBkh9uCOEG8GHKXpnW6LQBZkfVlg1Cvs
	 XaMt8q28XYYSA==
Date: Thu, 28 May 2026 16:47:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Christopher Lusk
 <clusk@northecho.dev>, Sabrina Dubroca <sd@queasysnail.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Message-ID: <20260528164732.5e5cff2b@kernel.org>
In-Reply-To: <ahdAboFpUAZ8aaWm@john-p8>
References: <20260526025154.60607-1-clusk@northecho.dev>
	<d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
	<20260526161101.691d4cb7@kernel.org>
	<4626d285-57ab-46c9-b75b-d56efe7417fc@linux.dev>
	<ahdAboFpUAZ8aaWm@john-p8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256446-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E4265FB81A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 12:16:02 -0700 John Fastabend wrote:
> One option we start rejecting these helpers? That would resolve most
> the pain I suspect. The original thought was we do have use cases
> now for userspace proxy where we insert headers.

Rejecting the helpers would solve all the recent security issues, IIRC.
I couldn't think of a clean way to do that, are you thinking adding
a bit into the skmsg like "from ktls" or "fixed stream" (kinda like 
we have at_ingress)?

> >>Yes, we asked John F off-list to get his attention and I think there's
> >>only a vague plan to start using kTLS + sockmap, no current user
> >>(sorry if I misread / misremembered).  
> 
> I'm not against a cleaner solution here.
> 
> Another idea: We just add a simple sockops BPF hook with the sk_buff?
> No updating sg lists, manipulating data packet sizes and so on.

TBH I don't think the existing solution is particularly unclean.
It's just complex enough that it'd benefit from getting removed and
re-added, cause the re-add would undergo the modern LLM reviewer
bashing that should hopefully shake out most of the bugs.
Trying to do this surgery now, as urgent fixes is quite constraining.

