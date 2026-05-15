Return-Path: <stable+bounces-247820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIHNOEA4B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:14:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F67E551F82
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C40483008C31
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0148BD58;
	Fri, 15 May 2026 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EdmGvpGI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3L6zyam"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1D2C21F1
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858024; cv=none; b=unZQk5Y9dGa7Bu0pfwjX9QCKTud60G6jvf/UskloTPV2iSaroX/uahIguglsceIPErn/hVj5LEV9wb/qCGg8RN18Vj29tKNx7fAYrzntCJGbWzAZEjKdCRjZF7Ld4wb3sc5Xcxs/1g/IOv/MxbaYe7e0rfUB4JGgDrsQbDWIT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858024; c=relaxed/simple;
	bh=rAvbkB9wYkJm9H9qsg9SHSXxCwWmkgT6m6s0ptkbw7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng98M1/dhC6qLP/p8iiV5O3dgFgwN2i7Atjqzk746E9Tcr1ZdMzfWZ1FqURjGGN15OA3ZXTBHC4xG0PH/VwvLhXKguccxnnklh2Cb7s3IPuvCHyy9+6CkVeKvxStPl5u++E9LfUbjDNhfJhitG58Wudf8IUSjrhJR8dz+oCTz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=EdmGvpGI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q3L6zyam; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 49C09EC019E;
	Fri, 15 May 2026 11:13:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 11:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778858020; x=1778944420; bh=0p5gfl4xV5
	VXQLE90bgQZ0PlPjpxMCSM6pgF8xL0/+Q=; b=EdmGvpGIb24vEOXOAJcyabcbzA
	VXsfGMbd3gLcKPDPHoSsCzXoNN34jzCunkUSvjhfuXfFA1CSH4p1BtQ23gCcn+GW
	XqcXTEgMpL/j7J16JkMELe0ynGsQPVaDKSTRZ/YpcHX1F5un+2kmksVRSdKtJjLv
	mZHMqFV7uFcANcUvI0pGq4a72+9lqibrzzDRM4zfYQcyj/D0+Fk8S9/lxaSeQDQw
	Lm37HHySE83evSQBi28kx14SuU2DOAMwAbR4FQePv+BIxXAzyFmRa5uaVGLsncqS
	cPCwLQkvnj0jx7s+dRYmwZY3mTR6kkmIJhDKsTerP+XZ/WzmP4lC1Y4QWAEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778858020; x=1778944420; bh=0p5gfl4xV5VXQLE90bgQZ0PlPjpxMCSM6pg
	F8xL0/+Q=; b=q3L6zyamT7dgjf6W6xDhDWF5dUsXNff4iIALXEyeveml9ABe6eK
	iNGUARSlA6Qzz+2VM57qsePdcX/0dqR7oxmb2xwtA/tfJFHqRsjN5R6n+gK4zkh+
	FzvHyU7Nlq18EpnedvY6XJJqTONJMC9IE4cDzZocqarcTqNkWBiNgF7oTHQvtIqf
	BCj+FAYEvB9XjDjR0mkZUfZY3GlEZDjNnwBCXAxK/VWy58rDaIPFCS8BQgG/7fnB
	z1t4K33hKZ03B6uwXHgxUtuZ+gXmBKFm5jgHwCOdPg6kFoy3O+YHiSFYsVh91A21
	JoptAMGRutwd2jMuhnEbTtFhFyvigickTcg==
X-ME-Sender: <xms:JDgHar6nCnKXiCeXifph4UD3f5a0bhX3xl30XDW2280UjaTFv1uGdQ>
    <xme:JDgHaqOPU2wzt0Mp1OCH9cpE3QJc85jrdTXAdUqTnubg_Yy5g72TzniCo-HXsVEKf
    Nm98LEiASRlbZTcir2dD3gjHQmhGh-vzxtt0jepYfxbu_CF>
X-ME-Received: <xmr:JDgHaptpWl0xQ_XbJRU_ozxiA8yuCCwjfaWWk58kl8sslTeqWLDdMrbVovznPdtKuwsyELWiC1yzKe1yqVfTZMrIjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlvghonhgrrhguihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtrggslhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhgrghriigrrhgvsehrvggu
    hhgrthdrtghomh
X-ME-Proxy: <xmx:JDgHatZXdE4pqDypxAiUtxWLtPNqnlV4FmmQowFsmiTdn_Igcj8EZQ>
    <xmx:JDgHarwgxImE5YNRjjhsDWB9hWvBJ0LTsAN0k-0z-fSNrzrHJZYgDw>
    <xmx:JDgHaljcCBKW9iAAGz8fbPFz1lCgBBndh1NjiQFQXexGXZ6jC-zJCQ>
    <xmx:JDgHanm9IADe51r2TBJmMEuq3KlMablFeVhkJtIJigLDSY5Ny8FuNQ>
    <xmx:JDgHarxSskFwI2pa08-9mD_thOQDmXa_H-uz18ziU1NL-_1xwC285-hY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 11:13:39 -0400 (EDT)
Date: Fri, 15 May 2026 17:13:45 +0200
From: Greg KH <greg@kroah.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Bunch of vsock patches for linux-stable
Message-ID: <2026051500-ashy-deplete-b04c@gregkh>
References: <CANo9s6mMchuAN-_9nWofGJq=mbRYP5X4ctc_5-Bis_-Z-zwnWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANo9s6mMchuAN-_9nWofGJq=mbRYP5X4ctc_5-Bis_-Z-zwnWA@mail.gmail.com>
X-Rspamd-Queue-Id: 8F67E551F82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247820-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kroah.com:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:02:38PM +0200, Luigi Leonardi wrote:
> Hi stable maintainers,
> 
> I realized that several vsock patches have not been backported to stable.
> 
> They fixed various vsock bugs: incorrect buffer size clamping order,
> wrong length/offset and empty payloads in tap skbs, unbounded skb
> queue growth, and an accept queue counter leak.
> 
> CCing the maintainer in case he has any objections.
> 
> d114bfdc9b76 "vsock: fix buffer size clamping order"
> 
> This applies cleanly to:
> 5.10.y
> 5.15.y
> 6.1.y
> 6.6.y
> 6.12.y
> 6.18.y
> 7.0.y

Now done.

> 5f344d809e01 "vsock/virtio: fix length and offset in tap skb for split packets"
> This applies cleanly to:
> 6.12.y
> 6.18.y
> 7.0.y

Now done.

> 3a3e3d90cbc7 "vsock/virtio: fix empty payload in tap skb for non-linear buffers"
> 
> This patch requires "vsock/virtio: fix length and offset in tap skb
> for split packets" to be applied first.
> Then it applies cleanly to:
> 6.12.y
> 6.18.y
> 7.0.y

Now done.

> 059b7dbd20a6 "vsock/virtio: fix potential unbounded skb queue"
> This applies cleanly to:
> 6.12.y
> 6.18.y
> 7.0.y

Now done.

> 52bcb57a4e8a vsock/virtio: "fix accept queue count leak on transport mismatch"
> This applies cleanly to:
> 6.1.y
> 6.6.y
> 6.12.y
> 6.18.y
> 7.0.y

Now done, thanks!

greg k-h

