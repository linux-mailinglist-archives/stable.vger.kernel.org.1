Return-Path: <stable+bounces-210479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOKXJjVscGkVXwAAu9opvQ
	(envelope-from <stable+bounces-210479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:03:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19B51D6B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2F267C5C5F
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295C407584;
	Tue, 20 Jan 2026 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MOjVKvsZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s31HNvq/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1F40FD9D;
	Tue, 20 Jan 2026 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905518; cv=none; b=m83uX3BcRsPmHuEQJpHzNdMKfvu2oGdPT+ZI1v3AQ/qeO/j0Zt5YI3mZjmiQstBvunLz4rRgFwa3LBOCzlytElNZo3pFCA+tMz26+SIUsRT+G01JAl1vFhDuJbWl49c1/amZE8HfR4wpRwwmlTRjv/soQqbrXx9VUeEs05iZuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905518; c=relaxed/simple;
	bh=OCoHoiX6AZDGG6SGVZikUcm9oJ/LsGlOvL6WSDsdUEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxJuSKL5z5EdQ3VlC58tKV0dpoKRb3bqTp2Y6Zcgcl4pP9H80K1DOKYRdUpeQG1qkw7+WU4KvY6vfeQtSvm2y9rHm69iUQgMu77OaUCQQJOT4lR5E8EQXe3LU0koHQMTpmpu5nBXrUz8Vspnqd+q3ldsVylxdj1sk2OEiDXfUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MOjVKvsZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s31HNvq/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 11:38:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768905514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlhfJGuz9yaGc8VhZmUOtxG9zY4NwgZxCh7TELYWw3s=;
	b=MOjVKvsZxBkHTZJiEdJ9wz8I50gO/LM48j4i3MSr07kLlqxebh858sSD7bwasbNq4jUr/i
	4wm7b5eztbdBbO+Bq05LWAEg5rgmBkK9O740BjfG1K96oLpFmrMA6+ZQybaR2DnSv7czNq
	CTbDNFTdxSHJlsM0mbWX2R0scur0FvSO+FcWMFrXGMqAw75/RAGzH2eCbTE3fTYPMG/EUe
	gzaMLSp8QgZzOTHjlcEXVfYDg34nczBSfqe64A5hsH9P8H8XPP1LVjwaVG0T2DoZkrVfR7
	0tX7IvVPL0kCPMRlr3ciHzRLl0SEQAgHGdE0A840J32/BKlnsyV2yZKu5nXqyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768905514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlhfJGuz9yaGc8VhZmUOtxG9zY4NwgZxCh7TELYWw3s=;
	b=s31HNvq/nOCo6ODZ0V2tH3QNZQAgSHNdYdkigZh072nDV4fQS2/ESxV4MfzQ78T5O5+ygz
	HTkLYtB5254r6YAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, wen.yang@linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: Allow to use SMP threads for backlog NAPI.
Message-ID: <20260120103833.4kssDD1Y@linutronix.de>
References: <cover.1768751557.git.wen.yang@linux.dev>
 <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
 <20260119082534.1f705011@kernel.org>
 <20260119163026.aA1PeSmP@linutronix.de>
 <2026012040-unmolded-dreaded-6e06@gregkh>
 <20260120080104.0yYtfQR7@linutronix.de>
 <2026012039-shuffle-apple-43ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026012039-shuffle-apple-43ec@gregkh>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210479-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0B19B51D6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-20 10:21:58 [+0100], Greg Kroah-Hartman wrote:
> > > Please see patch 0/3 in this series:
> > > 	https://lore.kernel.org/all/cover.1768751557.git.wen.yang@linux.dev/
> > 
> > The reasoning why this is needed is due to PREEMPT_RT. This targets v6.6
> > and PREEMPT_RT is officially supported upstream since v6.12. For v6.6
> > you still need the out-of-tree patch. This means not only select the
> > Kconfig symbol but also a bit futex, ptrace or printk. This queue does
> > not include the three patches here but has another workaround having
> > more or less the same effect.
> > 
> > If this is needed only for PREEMPT_RT's sake I would suggest to route it
> > via the stable-rt instead and replace what is currently there.
> 
> It's already merged, should this be reverted?  I forgot RT was only for
> 6.12 and newer, sorry.

Jakub doesn't seem to be thrilled about this backport and I don't see a
requirement for it. Based on this yes, please revert it.

If Wen wants this still to happen he should either provide better
reasoning why this is needed based on the latest stable v6.6 as-is or
ask stable-rt team to take this instead the current workaround.

> greg k-h

Sebastian

