Return-Path: <stable+bounces-259470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFK+Kvs7HWoqWQkAu9opvQ
	(envelope-from <stable+bounces-259470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 09:59:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B861B366
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6510303D2F7
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A497341AC7;
	Mon,  1 Jun 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RSUcyhxo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ag+pymI2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A837BE71
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300346; cv=none; b=WXG/TzXxfPlJDL9BsCszX8H9wUR4NynZD6puCSArMdG7CznQKZc06CCOydCETBa6lH0zMbswFBeLXqLjob/HLan+Jm4J506amZkOPuStyOn5oBk2uh4fDP9V3WkfBCRinHAYIjKOEitdAWsRVnaXSAUb+Ptcc6KY+uzIGGLr8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300346; c=relaxed/simple;
	bh=U3QRqRxZJvtvSIFs9MwxLLkUlkoblXK54E8fwDVPyuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0Ym4/1Sov0vQ1fWZL6GerWH3DflBwR638KSz9mJ4hH8ZviIYEiNAneH4qrF/OXfPaXUS0N6A2aZBS8hmqfqUAdTm0bXrxixFdjqSffu9MsqJjjhwrTgZAdTm/v1ehhH3C7MmPFpXe2u/T9ZHTtX8IykRIed37nxXx9AdAu0Gog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RSUcyhxo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ag+pymI2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 1 Jun 2026 09:52:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780300343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3QRqRxZJvtvSIFs9MwxLLkUlkoblXK54E8fwDVPyuU=;
	b=RSUcyhxoUN5NRir04P01RpsoFRu05maXhgZ2rxSvMPe5B3rHjf4aLVdpqt03fNMdzWy1nD
	tLDn/J7wzfA4rDdpQXEfElo86tmEZQdcYyIBG5bAOJzV9+L4KXpK9BFLOV28T4O1gfePXR
	FueQz96XM599wRJOUHgDWQFNFmhID/jy2Aap4rHkBXPHwrS7IOKjGT8PTmbL/bFvme91fu
	Sm4jH7maQf1+M2YyzTaIdrXooQBzgZgM4d+CgHNo4JHnNUWs6w/Xe8bu8Sde3KbRAM5jfS
	n86vqquVb1X71aG/lQjEFHPYGFeJgQRogCZvKreA+gRl3eyT0AgtFzop+yHz8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780300343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3QRqRxZJvtvSIFs9MwxLLkUlkoblXK54E8fwDVPyuU=;
	b=Ag+pymI2a9g54BgB76ChBgtDzlgrrycr2ukEAPlGcZRsaavy9K3fDtizA4zRfQXHCNUyfY
	w+Dty7W45NI4bvDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Felix Maurer <fmaurer@redhat.com>,
	Steffen Lindner <steffen.lindner@de.abb.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.18.y 1/2] hsr: Implement more robust duplicate discard
 for PRP
Message-ID: <20260601075222.hFB8WzTJ@linutronix.de>
References: <2026052838-cleat-rewrite-24c4@gregkh>
 <20260529232406.1883397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260529232406.1883397-1-sashal@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259470-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,abb.com:email]
X-Rspamd-Queue-Id: 396B861B366
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-29 19:24:05 [-0400], Sasha Levin wrote:
> From: Felix Maurer <fmaurer@redhat.com>
>=20
> [ Upstream commit 415e6367512bf8faca93eaaf46fbe23d841b4509 ]
>=20
=E2=80=A6
> Reported-by: Steffen Lindner <steffen.lindner@de.abb.com>
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Tested-by: Steffen Lindner <steffen.lindner@de.abb.com>
> Link: https://patch.msgid.link/8ce15a996099df2df5b700969a39e7df400e8dbb.1=
770299429.git.fmaurer@redhat.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Stable-dep-of: aaec7096f996 ("net: hsr: defer node table free until after=
 RCU readers")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is sort of big. It should not introduce any regressions and if so
we need to fix them anyway so early exposer might be good. However
aaec7096f9961 ("net: hsr: defer node table free until after RCU
readers") should be backported down to v5.10-stable so I wonder if
taking this huge patch is economic for this two liner fix going down the
road.

Sebastian

