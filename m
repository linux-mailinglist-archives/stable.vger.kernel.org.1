Return-Path: <stable+bounces-254211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFo9ISSyFGoHPgcAu9opvQ
	(envelope-from <stable+bounces-254211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:33:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 477765CE867
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A2A0305505E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FEA39B943;
	Mon, 25 May 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc/02I2X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141A3955D5;
	Mon, 25 May 2026 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741030; cv=none; b=UcdxFXsDx5z0kTqaeUdMcIO0g49EQ4I5Ik2DBg5a+2XEaLKcO9XzzDp5M5bXcp8LoXdkapqK3xPYbGd/biQO0xbOyFyeHoZHVoPnj5prVjEE9vVIRjEjgpkpq8R5ORTnXkI9aI3poz4f3ADQbN7ddPVMtmNWsaRY2Knbak8M/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741030; c=relaxed/simple;
	bh=0WaWRxHBFl1JaQtnfdsveWSUkhyLcusZa4kO1gdJjtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZVf2V3Q2eSWbibOWtdTeeT2ayW/M8Z7R3x6PNDW9KntKL2fuXzcis6DQtrE1dyxBkeBE1kYQX4Duj/X5rkUpyVKOABf5gKKjbhqRJd9t9o/p9wffQmIh+kJDWXoPDbzaiGa5sBWrM9l0KjgWba0gLAZHrFrqN8dRIA9DXFZscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc/02I2X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35421F00A3D;
	Mon, 25 May 2026 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741029;
	bh=0WaWRxHBFl1JaQtnfdsveWSUkhyLcusZa4kO1gdJjtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nc/02I2XFVJiatDMFP5VygLJJKycokachH1SOvzsgTl2PC1rHBRW7XgQqU1I8dBfM
	 nT5lwCw42ktihGNOAquHqLTZ1+FtyQjsFM9aNlQMZO/356YkqmHxLfLTaAWxvg6MNl
	 wqCKRzAPTH5p0f+LicOlOyY0nyiauKPqSeJlADAhX8a10Ya8n5vepIjLHPCCHv3w14
	 KxK9pMZLScq3GrduBc4A2it9x8uW45M5+wKalZdWFED4XaZ7th2EVSG0NOHJgJ2Usr
	 0UJVeig5KCOlcQHweYmUwjW/KbFD7htxsxn7Dzj4xRpr+raqknYLkEe/RUquE6OWe2
	 WHQlYsncsZ2CQ==
Date: Mon, 25 May 2026 13:30:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christopher Lusk <clusk@northecho.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: tls: preserve split open record on
 async encrypt
Message-ID: <20260525133028.58494274@kernel.org>
In-Reply-To: <20260521025840.976378-2-clusk@northecho.dev>
References: <20260521025840.976378-1-clusk@northecho.dev>
	<20260521025840.976378-2-clusk@northecho.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254211-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 477765CE867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 22:58:39 -0400 Christopher Lusk wrote:
> When the BPF sk_msg verdict sets apply_bytes smaller than the current
> open record, tls_push_record() splits ctx->open_rec into the record
> being encrypted and a remainder record. The synchronous path reattaches
> the remainder to ctx->open_rec before continuing.

The current understanding is that this code has no real users.
So let's try clear async_capable if BPF is attached and avoid
all these bugs in record handling, please? The savings from
zero copy are negligible.

