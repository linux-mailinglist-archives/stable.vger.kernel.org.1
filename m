Return-Path: <stable+bounces-262064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gaCCExrrJmqFnAIAu9opvQ
	(envelope-from <stable+bounces-262064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:17:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F202F6589AB
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:17:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="M FUxWWs";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=dRYelcvQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262064-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262064-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C78A310B9C6
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953A2E03EA;
	Mon,  8 Jun 2026 16:03:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F4332EA7;
	Mon,  8 Jun 2026 16:03:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934631; cv=none; b=ef8T/sQtWikmrMqzpB6Z0AcU7uHY0NuTUmu0IPRdlg2iB5dtVhDAvBjov+QqQr6t/0qMW0/UREso/0K7xxP9CUPthgQToHoY/dDeUbsL7DwLO9+TZZJB7RzoljvUDwu1GaVGL636KG3KF6yceM5bFt6jnyMyp2o0EqsU5Fe1C44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934631; c=relaxed/simple;
	bh=aCdiaS58bUQL7UzePzNnvYQIC4XpFG8cK0MyqOyoThk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqDI7xSfXSerTXtX7qGH+1ftIP6E+L0xoIHsQloeCWykpzHnlKozw25s6igWLkXh94BIj9pQwNJlrDCeov2Bof8Hpd9hwiCtwWkkKJJ903uH0WR3KP8oLDyz3U213fgirdNMi1giVaLYCxR3cn/Z3Ge/j7EYQX+x3PBUzgydDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MFUxWWsa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dRYelcvQ; arc=none smtp.client-ip=202.12.124.158
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C11477A00C2;
	Mon,  8 Jun 2026 12:03:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 12:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780934626; x=
	1781021026; bh=zRsyJ98tISk+ATAEz4XJUroqoFu+sTEph+r90M7pkMQ=; b=M
	FUxWWsapxmAIkodmv5sxGWvRMBAYCE/MzQ18g7k/cV0iFFIw7eETOLLJjaX0xNWW
	g4ttF8Wg1ymOmeF/BHzyYJXx06rL0CTGmW0gdRESmWmOcdGSs8a0UJiWI0h+4MaV
	g0DfTWNT7c+QqAhIP3G7aQ1Epa/XKq/FyFwGIkYMNOG48Dwxn1eV5emHr6mz8v7i
	He9erul3fTcCThBX6QZKi6DDh9hkzuSY6soytT7NBsrkqIzJWTJnaNC8qea6Kn2l
	vGqrs2cM+EgJGFliRLPR+bG0Vkfypf2r05sDpINJS7dcnzw6rV+UG5MaBIPQ7/Q8
	xP/ZjZoO3SX01qUc8YhXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780934626; x=1781021026; bh=zRsyJ98tISk+ATAEz4XJUroqoFu+sTEph+r
	90M7pkMQ=; b=dRYelcvQwQzo2hGhgIFZlsHDoTOxbHSR3cLgLLOoKTM2X8HoBgl
	TbndtHpHH8fE2Mz6gfva1AVb8nATlIPC/K+cT7CMasnkeVZYw4em3megL8zVRLC+
	v9Awzt06ZK6eaahLTdN1xYEkDsFS4NZ2j2fgbOEW3vDWqmWRcs9PE00hszWyK3EJ
	uTyBwKMs/GFGz5a5QnA+Ny8RLc5dgQDoUjSQhhUgcEoTvC02qbbQ501fdNO9r3Pd
	HK0a6dVjDsAPuW5KY6lrEd+C+k3Ip1U+pJ1MNReSzo6uObt1hF4Z5OnW8t7z3HeU
	EeW5rB1J0OivA+C+3aXj9SFw90qRpcmE54A==
X-ME-Sender: <xms:4ecmaqofTAipvZ771gHudUl1oDmmmeuHooC3W4rzjm9mgmiz0VonHQ>
    <xme:4ecmaqN0QryWmr4xkeDYWETiWm-vBDubA7RNQXLg6uod505eeFg4WLebi98x7VYs2
    KfgSm85u2ycQo_GWlSjlnGkqmBHhOY8Bzk0L1CQ7MluzFOjQjjpBA>
X-ME-Received: <xmr:4ecmauex5AN7TjKrBY-nI4UJwui1lo6jtkWHxW_zU5swDzTRTnWOhtw5IJKFR1KeAPn2NZjQ_ulwuQfEkCPM_Q0>
X-ME-Proxy-Cause: dmFkZTEJiTZtvJ9ShH977Sp0pLa2KXTz8geBKwqEjOwfs1HT95RnTXnpfB2e0UrDPHqxOw
    gJagGpYftydsSYAXc3/4LsGnpDiMhbMHLIDw34IdjYyZJMPi30S/lHorwaPy++tNt2jIqy
    NspRvWuMUl4QG2QbPpe+V2/R3rgk64UEXOzKAAkzZeS90QbBgIw4cOgCYoM9YpdhHOyyal
    66LNTuu8f9C87eEbeY4fMAFIr+CijbfO3VggQZMrWqWQZi+gZstFvB+Gev2py/MQJ2w858
    kydruTmmi4QM7roIkOAax14wn4ggct6s7qcS4oJl3g1no7liM91wULWI2Dm1VdBzvTcPbm
    h0qVp5g9xPGSlgXEnI2W2JqijSMe2NJh9N1iRZqp37HuqgtBSoKC+d9iZ29OsfvMsr5yzt
    cb7NMNt8hcOByE/F+lp0YFZlURIy70RVvWJCalKMqdM2R7r0S+KnsBO1kQ7OtCDEXgcmVM
    qPK5xdnJ2+QUA034VyFOt+P+rO1eQ/I8SeLHl5WiFB+i9oSnGtlATjhEk12q0aYCjUOqnk
    D9cTnQgsjEN2GAO3Y0/oW6MZFzK9954DI+MfNCpC2aXSaUXXYAEDT93kYbYBdUJrxZirU7
    tpn7qFwU2YQ9YU6qWKpqzLHTrXG6sZ5yQKMjp4qjW2VOJQdN9HKw37/kg7rQ
X-ME-Proxy: <xmx:4ecmagUbKJ7-KNBSfEedX_qMP-UVLF86SzNvTEb_GnLHF2b786Z96A>
    <xmx:4ecmavAMj2fvl7aF_FBQTUoSvORfEorKV7ZLwpA-qpuOVrSdctTVwA>
    <xmx:4ecmar6gMv2Ic-FeQW1gmkt6FA7jdj4dzMrOW5zqIUtyQXDKwXpKEg>
    <xmx:4ecmam1GEbsFS93YclIP8xe_zQ6Wo7SbCfMiZdNm-tQFW_yQfQ_5Yw>
    <xmx:4ucmahgT7ABmLKCiUfTS0E62hOt4TK5S2Ms7XKZlZ2C1Bbo_htCqRwdl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 12:03:44 -0400 (EDT)
Date: Mon, 8 Jun 2026 18:03:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Zijing Yin <yzjaurora@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: af_key: initialize alg_key_len for IPComp
 states
Message-ID: <aibn3tkGc3Iz1r5n@krikkit>
References: <20260608144453.3553219-1-yzjaurora@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608144453.3553219-1-yzjaurora@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:yzjaurora@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:idosch@nvidia.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[secunet.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262064-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,krikkit:mid,messagingengine.com:dkim,vger.kernel.org:from_smtp,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F202F6589AB

note: fixes for IPsec should go to the "ipsec" tree, not net

2026-06-08, 07:44:41 -0700, Zijing Yin wrote:
> pfkey_msg2xfrm_state() handles the IPComp (SADB_X_SATYPE_IPCOMP) case by
> allocating x->calg and copying only the algorithm name:
> 
> 	x->calg = kmalloc_obj(*x->calg);
> 	if (!x->calg) {
> 		err = -ENOMEM;
> 		goto out;
> 	}
> 	strcpy(x->calg->alg_name, a->name);
> 	x->props.calgo = sa->sadb_sa_encrypt;
> 
> Unlike the authentication (x->aalg) and encryption (x->ealg) branches of
> the same function, the compression branch never initializes
> calg->alg_key_len.  IPComp carries no key and the allocation only
> reserves sizeof(struct xfrm_algo) (i.e. no room for a key), so the field
> is left containing uninitialized slab data.
> 
> calg->alg_key_len is later used as a length by xfrm_algo_clone() when an
> IPComp state is cloned during XFRM_MSG_MIGRATE:

The patch looks correct, but do we want to start fixing random bugs in
code that we're trying to get rid of and that nobody actually uses?

If we do, then:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

