Return-Path: <stable+bounces-254514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EQ1F2ytFmpHoQcAu9opvQ
	(envelope-from <stable+bounces-254514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:38:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC135E138D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B212304F394
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749D1C84D0;
	Wed, 27 May 2026 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="M/9DZweC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7UuHPyy"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FB3033DF;
	Wed, 27 May 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871027; cv=none; b=ShP0vnxGPeHCeyOoSovWZkKCxKOc6t2bBVU+CP2xP/kuCAjpflUgZVnIYlE3/H57k3QEI7uUY6Trhup7J1NYOJzi2cRrm35hkXjf24tEQQrSpvERBzAjxyip6wWS/6/B+utSbDCgdQfbCcIZI1jhLXfzrGlaN3Sb3X4clOI6CJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871027; c=relaxed/simple;
	bh=mV0eqPfStaVEdd4au0sVuT+0AyOXyiKQUYogUROCQJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqHBsISwybZNoshImWaA4dPTB/NYnn9SZ9a/GqZOCPwG4+oERGlvKSKULdUFGu/E8Ke5xSFNd1jN5uuHNo+DGl+yGOb6tvCgaxNSpenyILGIs7tmkhvMEN3H9GxdNk4BwdH6F0+F9K7LXHB2NgmGMaZtPT/GWDuj4cd0UahzLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=M/9DZweC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7UuHPyy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C353A1400026;
	Wed, 27 May 2026 04:37:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 04:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779871022; x=
	1779957422; bh=iqYkkR95tJWGlo961K38i/9j/Zuwg9rvqCt7UwFbdYs=; b=M
	/9DZweC2VPPmWRFQuOWS7ckKDI8LuFkC7JVMq74FtrmIEhFtfSUC/+jtRFlkXrDn
	YIVdJm6LZ3kQvexfsgm/NLDZ24b/H0LKpLikrlDofF+rEtcppWG5iP3G5cZmKVBW
	x8EzctXIJXb3fN1K4oyMixbTIs9gxrT48KpQ0yGIPoBCFzbaTymOcOZlk/0INCUE
	Y8afjw42Winong0Dc0cTPxco6yuuv1npGAvuLL0BhR8FsSPsjB3RmqMer7fTIIc8
	opuUn9nmDOr6OZ4knPmEURez60deqVp1tcisIHwUHmbOwq3B/CIEkNbdsqg73ypr
	OdXJC86w84+lOtcMFng3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779871022; x=1779957422; bh=iqYkkR95tJWGlo961K38i/9j/Zuwg9rvqCt
	7UwFbdYs=; b=F7UuHPyy7ESrxmLNAPDI7hUvRpLFO4OZhxsJbBbPutiNIQzyuFf
	g4akQ0iu2fp39j5lpZO2qGz41jELj0oENSfNXRB4C3JS1TmgBVdWY3guRU5DpE1e
	Q03peMjjQA4posARzQkI36EU+OuTyFEt4c7oPFsFVKr5VoeS1o2NHz9SsNKKK3Iq
	CnfMzpOUlOILyMCd7DkgKullqsb/QikiHlQkAMwLSSCOAVMsQAKL37CKzOGZ/5RC
	3xfOLJdWcKxfdyC5tcZOLLTXVROihZpXn7G8X0Gl0d8LJwGpRcaeEpMqMqtOnsz3
	wF7VcLc38NNTKzE5HWWj/Bm9rge5RQWDfFA==
X-ME-Sender: <xms:Lq0WaorQVRTuRp_CV01k1yy0C4ISzkFFncCE3mMGMI_Y70GScd3DKA>
    <xme:Lq0WauxX2e-a2BxQDIIVg7gt8RFODBF56cQQ1ObahN_-2C2m8Syo0ApUNTQ1Zm74E
    w_NJUAMTYLROXEOVLy6LRiwcTkY2Ybc0aJZnHWMuHYrbsYEsfwKzjDJ>
X-ME-Received: <xmr:Lq0WakqMTaF-VLOmmD6qwX7WplT6VDdTFSERleV1B8djU3gluADjOTzEMyVAe3VDz5PwvfWPARJ8WAJ3rsEzC4U>
X-ME-Proxy-Cause: dmFkZTEGMopZWvBCowpkS6P/sbdjeATG+Lj4Mf1P1ayPJeEjqS/1r9YjJNrZyqXIcruQVQ
    oUJYRlw33XbmPnDE90GNmtcMDQHlIjjaRpJT7r+Fta8Vwf5zCYlhyCCYYpYuQKe/q1z8tJ
    P2apZxaNfmzNbgEkcC/eIfalEsOoqZtSMlp2qwhcvLxODX0UCwjDiR/PMEpn2cS7NPQCZk
    PuOroWRQ4YXVYKFRXuZuaDtWrJqhLzioSBmN8UcJAeHK7PYIHT02jEybGKRuoxCyB1a5pu
    JipKXoNEX58stvSN7FileXGBg4BPLZAjuu1V+Xdh4rM3MZ5lMe3Y8xKGO+AAt9dVgiErL9
    iwS9iVvPFg9h/ZFXt4hinXHjEmcIkeAwy51vc30bX6gdvk7nJHqM4xdCzvpf52+ZkblTBB
    BMygLCToYK3T5rQ+vAstQIseCsXj7ftSzqWOAFUzOL9Zi3ebKJ4qJ8OcBLdZDAGOp+7YG3
    /fmo/ouqFYbXeNbwKgmRhr0XAQ1NOvRJaGcHJ+jMsk45QNybId9/HzFTdZS2nOYbRPeYOx
    S8qVRwmuJPR0Lp9FLJV9nvR0me94q2MFC22UiYw1bX0uVW2KDSb03CfouKGpPPepBGhyWt
    6m4iydqJr6xe2hoHkrbp5x+Iee0upU5W4cawMJTnN4rgynSxhPm/r6lbskhw
X-ME-Proxy: <xmx:Lq0WamfXDYdmXmvtdDCLgrckLmsF6fDoDMDHeMNtlJxgNV4jrvGj_A>
    <xmx:Lq0WavpkxvCXLWmhU4R7FFSsF5TAgdM6OICA0zDTNmh5aaIH7EtMcg>
    <xmx:Lq0Waomf1Dny8ENTz050uMwVjN6rxVObeNs2OoZCdSGgx9mTs8wjKg>
    <xmx:Lq0WaoR207oPXeYyoO0RZnpjOwveL96pxj5zVXbZQ0eIwYUc2LUqaw>
    <xmx:Lq0WaveKWhn1rIchW7zziJnOBPE5gunnlkDDnM0xooEApuDblcRkWRQG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 04:37:01 -0400 (EDT)
Date: Wed, 27 May 2026 10:36:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Christopher Lusk <clusk@northecho.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Message-ID: <ahatK87kXyudML_4@krikkit>
References: <20260526025154.60607-1-clusk@northecho.dev>
 <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
 <20260526161101.691d4cb7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526161101.691d4cb7@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254514-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.dev,northecho.dev,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 1CC135E138D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-26, 16:11:01 -0700, Jakub Kicinski wrote:
> On Tue, 26 May 2026 14:44:24 +0800 Jiayuan Chen wrote:
> > May be time to remove skmsg from ktls? (disable by default first, 
> > re-enable via a new ktls module_param?)
> 
> Yes, we asked John F off-list to get his attention and I think there's
> only a vague plan to start using kTLS + sockmap, no current user
> (sorry if I misread / misremembered).

That was also what I got from this.

> module params aren't a great API. If we want to deprecate it let's just
> remove the integration in net-next. You have my vote..

+1

and keeping the code around means we still have to maintain it and
deal with the extra complexity.

-- 
Sabrina

