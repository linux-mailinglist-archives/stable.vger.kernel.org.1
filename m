Return-Path: <stable+bounces-272738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m5CSCi7GTmo7TwIAu9opvQ
	(envelope-from <stable+bounces-272738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 23:50:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253F72AA6C
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 23:50:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm3 header.b="K 1LJCbE";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="Dr/bbDL+";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272738-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272738-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDCD830151D6
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8519E3F7AB4;
	Wed,  8 Jul 2026 21:47:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93533E4506;
	Wed,  8 Jul 2026 21:47:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547254; cv=none; b=SvhtRJMgRQ6u9Wo8m1GTQEpWL7kcWCawy154TYsLSw9WUXDdUnQqz2WcQzuXyL9UDvtPR2L/q1ifeZFXyHRFJNpqpnAlRkE1knY9Ln5E9pfOtL1he9mkRS9wgYKAvWGE4QfDYdl1lZNkpmuuIeksUTPVQT4nCgDRsFrE2SytYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547254; c=relaxed/simple;
	bh=cLbYfj0ix0uweAgXGMGt8iFFBLz5yorNVz94Azlcj2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ6s6EvLiBHZmSbk87pdH7YR0oyu5ajZUnrttf2KFc4JFH3WJfFpuBpHXoE0hePFTGuDTyjovxGvKTSPrloGNKKoFjSzzWIbLPcgQH61sJxfG/cHGEKXzCR+nWFR5gTbiULxRgfqEzgsqB2DRg3E4fcEJpW/uYN2EJX2p8/10aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=K1LJCbEG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dr/bbDL+; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B7E431D000F9;
	Wed,  8 Jul 2026 17:47:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jul 2026 17:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783547249; x=
	1783633649; bh=SkhMzosNQBmymgj3p2xy58uHyxhr2icAp5O0RittQsM=; b=K
	1LJCbEG1PWvnlad0u6OH2lgDk3yullbaD90XoQNGzNXFKuHumqCs0p4SStp2ZbU1
	5IfaiOLrNHuxQjWuYw/uYx8TU1VfUbck9B3aqjNPgof4VlBz71RSUDPatFvJCEGE
	ZiLlfD19rZSMHMw7ZJF27N20uSu6wU9UpNTdPM9o6POy6ovNuOYBcwmeVlQn3Not
	LSy1BPV+L9KrSzeFV7QC65A1wrD+ANAGXHIboi4T17ihg9hvBUmahLWoI1LsH2Zu
	VOYnx/W71yT4CoAXL8PSRIFiDe3FVJeC4dGYmk6NLLLo3cF5hj/rVINZvfkdTF5+
	oRJ2sdEo9IxBg9CuCQxsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783547249; x=1783633649; bh=SkhMzosNQBmymgj3p2xy58uHyxhr2icAp5O
	0RittQsM=; b=Dr/bbDL+Nfj24xMuamJn3n5991rsaof8f5Okxgwm5a1z8USunaE
	PYxgDAlF/VoehPlipTgjEHwPWTiyL3OMlrzViy8PteArxpDDVAcidaAefy40F78+
	L/LYuUKq0GGSVVogKwGjByp1IIbclBvBA4GUTdL6AGKBipOCAtx+gpDONIPpBtTE
	4NTwopLbmCJxfTSVnBNpwy4ox/YjPB9NlUVjNaVHR0NhzvcLe5fH955hQSQjRWTR
	LLFkAk1olQGdg81Eq2hfJn81XyAY00+BTPzGH+uUMagvPXvWFrGu25+RXh5H+Ygu
	dJKw6kaCeyt/akaC88ICPrhnrFjJ8gKlgWA==
X-ME-Sender: <xms:cMVOaj6wnGviWtpneh4TyA3-RsuMSiXfYDXkyoLjo2Hnx75Pmt9o-Q>
    <xme:cMVOau41Oa6Y46-tyuXsYRHpZQrIsJvT0pNWDqtu1ItRjWcd9DNKsCqcfzkBSFii7
    MC3dpaPbLrqe3l9i8bkjF6KdYNokxUYbFaNDfPEzbNiAuZG7M-aB9c>
X-ME-Received: <xmr:cMVOalQz-ENSktFUZSIKYA-Sv4BXNLZraxiKaWXKjpdTirNxYabj5ZGTuvY>
X-ME-Proxy-Cause: dmFkZTEonscYrV8b2DWfVXUlBrm8n8hor4M9W55tDzUSmnxl25KP1CDRJTK8KTUJgx0v8Y
    gx9DrSnOE1G5w2YDc92fzt/3txvP0t10I/emDODh1kwAOEc/4ftn0/IZmO9iIxfsJMn3VK
    nESCEsib6vJR/x7xMXWiWu+E+h8zCso7JZy7DXlfQaEnQNC1/7whC7ynogs4MH7KtQkFEz
    PD21nDRC7d0oKKHiOoXAg4z8HLsu/KZQGV0kXec00bBGJ1Xgo4Pe0vmufmgX3hO/JptI/Y
    yX/oUFENX2HOeSzvRCO4ZZWqHdzbXqAEs8zJiizPgc7ra5P6LD6FuHiQtOXM2wUlDdnIP4
    92DAvQWPAVArDoZu5DDIg4XcvX43AYnNI5uISxV7xrZO68/fnk7NL5xA1cZNToAsiUVhre
    VWWw9lmSlnz9SV7sXBNt70L9TpFT0UfECute6TcbTFlUzZ2Wslbz5E44yL0zUvBHUVV9xU
    Lw8vw/66ub9cSuJck0L3ntiOQyoePK5gJwFJ+5r3FARajElxlTRBAxpu3zdGBk7rCoYrNM
    FTiVtPVXyWw3ztPZKUZMP01KleNtxHbbLq9ZrG49zm0XhhB2/+RG9z3hv9IAjBNPeGKExD
    ZfIdm3cq0f0RaiiitqobDCJActJCIxUv6/bjUJrkz7CB31vwlzMoJoWmeCwQ
X-ME-Proxy: <xmx:cMVOam9jrdq3MkSHaaFvjqv2zsH_4YZO332ctRHBePbb_k9HdYo2Gg>
    <xmx:ccVOambS91hN9Q_eoThVoHfeEh6pLS0q_mTcyR5Z3dMRlQl4Qi_V2A>
    <xmx:ccVOanq_DFVRO71aiEPeO1OD0oDwd4HW4sSI5-N-pdmRYXIvs9IzWg>
    <xmx:ccVOaqRmO_LXfL4aGODNXAy7zr3shu6kXmFCKm1ObDPRLJYJ03BEWg>
    <xmx:ccVOavSNQ7VVDKEgK15wj9ua9xPvHF6PkWSJ2gYTE0cnijdK1MxZWm1f>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 17:47:28 -0400 (EDT)
Date: Wed, 8 Jul 2026 23:47:26 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: James Raphael Tiovalen <jamestiotio@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Antoine Tenart <atenart@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] macsec: fix promiscuity refcount leak in
 macsec_dev_open()
Message-ID: <ak7FbqzijszPeyni@krikkit>
References: <20260705113629.187490-1-jamestiotio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705113629.187490-1-jamestiotio@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272738-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jamestiotio@gmail.com,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:atenart@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,krikkit:mid,queasysnail.net:from_mime,queasysnail.net:email,queasysnail.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7253F72AA6C

2026-07-05, 19:36:29 +0800, James Raphael Tiovalen wrote:
> When a MACsec interface with IFF_PROMISC set is brought up on top of a
> device that has hardware offload enabled, macsec_dev_open() first calls
> dev_set_promiscuity(real_dev, 1) and then propagates the open to the
> offload device. If that propagation fails, the error path jumps to the
> clear_allmulti label, which only reverts allmulti and the unicast
> address. The promiscuity taken on the lower device is never dropped, so
> real_dev is left permanently stuck in promiscuous mode. Its promiscuity
> count can no longer be balanced from software.
> 
> Add a clear_promisc label that drops the promiscuity reference and
> route the two offload failure paths to it. The dev_set_promiscuity()
> failure itself still jumps to clear_allmulti, since on that failure the
> count was not incremented.
> 
> Fixes: 3cf3227a21d1 ("net: macsec: hardware offloading infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
> ---
>  drivers/net/macsec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

