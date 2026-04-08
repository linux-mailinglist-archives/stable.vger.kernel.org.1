Return-Path: <stable+bounces-233899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBH9Nx1W1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:20:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A23BCBED
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF153049288
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F63CBE93;
	Wed,  8 Apr 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pqqM6Drp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0jyJfu7"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFAD3CA497;
	Wed,  8 Apr 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653982; cv=none; b=Pd83nBxx5kTQkegAAABiGwRelEC1OBofAE9eapCXlqAAeAeO37qJa4KZqs2g6EqeKrRXEsSTs+u8GoH474UsgIJD39BZe4DlfdTNO6+bIOjy04GGwSOb02FbByyLbb6s1el44ejoTU04HzQDnHfOj5u0eKVyXewbTH8cpKMBThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653982; c=relaxed/simple;
	bh=yjql2h9M+olgFthb1v2qkQ9I/8DKbYaJS3Jv+Wz0Mp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNRtBvzDXsIeKsGxIvEiEyhLoomCVHhX1TruotZIkFFR4dkFJiqKRSwlS5eXfmG39m3+c0n/TGdWraQZYDEmLX7x616YX97x1HgzwcRqGuat8bKUVcE2Blp8ZUCJVkAXnvfTOwa/CN7K2E7Rr9mJN3D8x/GeP0QaUgevpKW19Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pqqM6Drp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0jyJfu7; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD9927A0208;
	Wed,  8 Apr 2026 09:12:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 09:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775653979; x=1775740379; bh=BBcL8PytJs
	vqCqq2k6Cv3ZDYyhRjF/+iQYWZ05pXbiE=; b=pqqM6DrpOm8Mv8Hr4eQ9gXKvSt
	asOofN1xUXx5XAlT5Y/I+4k0s+vXAlhjn/XFp5FW99xa28fD0EFLf8XdgUZ1iceU
	gOoEohf+MKKp/BsFe++mwvj6U0fo2s7QUvuM+np1/tqdeYUHOAZGjF//sn7dYe8T
	XMDdgnuvlPJT2wRli6JlI7mOHcTg3mM91cc52YO6oTRRp332zFaxrKfcqFrjaqks
	1g4FJ2ALKG+Rg7aOTCRyXhsdajUN1mofj0rgEiJH3TUVCzt0cyXVrY2urwzgKUF+
	KM8BoFDd1LxMvikfjm33fSlHANfBt2imdz9dpIBp1ArwmWSB1MTrz+SDidTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775653979; x=1775740379; bh=BBcL8PytJsvqCqq2k6Cv3ZDYyhRjF/+iQYW
	Z05pXbiE=; b=a0jyJfu75uib6YcMuI3W2jTv7t981O1MQIJVSJCSN+o/kLCC8A1
	FRk1ke/WlbsKCcPBt/TVjA0nVK4DjHRROgtlwwOWlIjAExc91m1wXBqv3e8ubIZ9
	8Sr14auRhnpm6qso8MrPAb4uvhIRk8hRnnCOx1N+sWaRpscyQIG7Ua0F9S3n2sRY
	uQ3z5DY0AlDHo7I+acY2fcVoiI8LnKBQ7KEIY6wC1M9+VrwHC1m4HENg0nqNpVlB
	Ma9b5yn/WLcfTFE9xOBPB//FUKsakanwU4wfeli+I4nZ4wf1b8E8xDRPrENvLlHQ
	tUxie6DR9ZqfZ0DykEohAtkCIBli86pSBbA==
X-ME-Sender: <xms:W1TWaXaMlUDoGKTZnTzqep0NaJLf0zoivS-RXb5-L6WIEr033Jxldw>
    <xme:W1TWaeWInbC8AXhoYX-m3GheAn523i_hJIOu_biFEBczaTD2HHJvaPZ8-OuJtvXdd
    WYcwcpNbGUNTEEMrdD4tWDkkBqHKhhWGpVSbrgxepoVVGhwpA>
X-ME-Received: <xmr:W1TWaRIR05o-73JJxD8fSR91-fiTW6Cqw9NGlIZjCpdzI9gqRehCNw5mOUloMDa7VM03OBx6tC4hFaMmZn1Jc6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegthhgvlhhshihrrghtnhgrfigrthdvtddtudesghhmrghilhdrtghomhdprhgtphhtth
    hopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjhhhs
    sehmohhjrghtrghtuhdrtghomhdprhgtphhtthhopeigihihohhurdifrghnghgtohhngh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhirdhushdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshiiisghothdofhefrgegle
    ejfhdtvdgtfeeklegukeeivghfudeisehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:W1TWaUHOr_rBXw8pon8_utdaPWOY0_EcS8t9daWP5m_HbnoSF0mtaA>
    <xmx:W1TWaeyJBORf5X2aOCO4mpzrlYJ2GkAvd9EBc372pZSKTygiySWpHA>
    <xmx:W1TWaZj5Hhzq81YWEb89CoVmWH6_VXBmUE2W7nO6GmE8H6y_gsb58w>
    <xmx:W1TWaTLK7c_Mc5vqe4soM6vE2CuY1u1l4Zwi8yaFCesvz1MJ480nUw>
    <xmx:W1TWaa922rDY6p_H_kiBcH5kTYOQp6HWnEdtDoe4eNhb-VvlvlW_fFXs>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 09:12:58 -0400 (EDT)
Date: Wed, 8 Apr 2026 15:12:57 +0200
From: Greg KH <greg@kroah.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: stable@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, kuba@kernel.org, edumazet@google.com,
	linux-kernel@vger.kernel.org,
	syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.6.y] net: sched: fix TCF_LAYER_TRANSPORT handling in
 tcf_get_base_ptr()
Message-ID: <2026040825-washhouse-bash-9175@gregkh>
References: <20260321095539.239506-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321095539.239506-1-chelsyratnawat2001@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233899-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,kernel.org,google.com,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,f3a497f02c389d86ef16];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kroah.com:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 482A23BCBED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 02:55:39AM -0700, Chelsy Ratnawat wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [Upstream commit 4fe5a00ec70717a7f1002d8913ec6143582b3c8e]

Why just this one branch, what about newer ones?  You don't want to have
a regression when you upgrade, right?

Can you provide working backports for all relevant branches?  I'll be
glad to queue them all up then (and resend this one at that point in
time too.)

thanks,

greg k-h

