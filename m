Return-Path: <stable+bounces-244931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFSoMGb7/mlW0wAAu9opvQ
	(envelope-from <stable+bounces-244931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:16:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0E4FEF67
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C413019BA1
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6671FECAB;
	Sat,  9 May 2026 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LMjyljtF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vQ92Oc4a"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36338E135
	for <stable@vger.kernel.org>; Sat,  9 May 2026 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778318171; cv=none; b=GISTaKKHU424cOrEFur+3Zy3zXerruB6epXI4UD6m4QXalCz/pulCvj3uv2Bko3JEChol6oDK3sCBLj6N60tZJXCtwC06gNFGOT/6vFHE+PUBFidFaiR7jYDMFurRuDeZxdS/Rxh5RwKHGacsCcwVAtrXIGQk+A/xG6wq6AJW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778318171; c=relaxed/simple;
	bh=OrHy6Rjm3c6Jr7d052C1h50+sIQqeZDaXfci3W9/cVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDbmV3bz75BDJSUBPQFkpx3TH7B8lM9kPpV1/IEbWAqLj0DuDhPovzNlEUGK6gvj00BPMctdCzyvIKkMNCQ1hxlMnrC2jsP78QuYdm6xfAv7XP/9b2hAA4K68IO/cRCCskVz49MebVx2qJ7VBtbcFlpUI4HOqaKCmvdM+5KRnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LMjyljtF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vQ92Oc4a; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D45DE7A00CD;
	Sat,  9 May 2026 05:16:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 09 May 2026 05:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778318167; x=1778404567; bh=k4Qy2yQRQn
	AQkPzGLK9kEUwvs9HGcxud4+CFk2JrXEs=; b=LMjyljtFr0JpaECagG1zExE5P1
	+YVGEPGM5/mCt3QOkaKRgs0AS6NJ0jO72uJMzNH7Qr7u19AV2tll2u0aiIxblmqX
	KxBptJXbjSgkSbnsTjPsqbSYDkk8Ka+2iwRJAadUjCDfNXjGcqVpLlsbjt5b3240
	x/iIh6UrwdjSDVxvWtxi4sHy28FWwnesMh1ys6vCgY7rhmjywIkMrlM08qdprvvn
	8r7xAf6GDr+JnGaj0NWd7RwO3rXZWSmaQqMAKxvD2otYi+IMAfr6IwMb4map5ZZA
	COoYy097yl25L1yNZd/owY3J77vVh4pu5Uwk3C0I3o4E5phVozRmsmBbZRwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778318167; x=1778404567; bh=k4Qy2yQRQnAQkPzGLK9kEUwvs9HGcxud4+C
	Fk2JrXEs=; b=vQ92Oc4a9TlniJ7jdz2e+T2VXcGtiqweNQyqP4kE7Bu9oIJCVe+
	begWklA1uFwDpe42Wa9dyi8TIvhTEUD2vKzEt4+FjvkhtnJrf2lvsLJDj5gMxzHO
	+a+i2y6KRAvfXAlEAgXb4tCg4LvhXj3+yznt3q9aIkhawQg7c/12mkj85962RySc
	C0MTUf9nUHvMuvi06h5YODSyDfNQ5QEN24I8xNltnYjAlwLjZhy0ZxhLRY4rxAs1
	U0GzmPN1GNgPnw+MsGFPEAz6HS6JeYSMtAGBQdPi0ASdDGWToJ/9aji6vVZiORRb
	G9k0sHmd2Uu6IJHXCK5Sh/FRsNoAOn8AiFQ==
X-ME-Sender: <xms:V_v-aRH90UioYhp4df_6L9WSA99mZNsDM816uyl4UD0dfU4-HJV1Hw>
    <xme:V_v-aUIUko0BQAG4wZ7xIpsqO5Gb0LS2IR8OIs76D4XnjcgQQuovVn-t05jbtSndj
    QytCoVyplHUtvhlgf21mfStbaRvXmoF7BHoz7lhzDLzn6bw06U>
X-ME-Received: <xmr:V_v-adkhfxuW9hX5QcoTUr7BjV4GRcUI0j92eakJiYaSmEvbxmvk2qqFnSoQcIVMsuaylClh8hR5fWPHWZ4AK_jvWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkihhguhgthhhirdhrrdhsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtrg
    gslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:V_v-aUStLJ7UpFSY0FbIzj09clomumbMIsi3pNYLuoX2mljpkHP3mg>
    <xmx:V_v-aXLxS7fXjav0II0FUDCevPUDrQRLpMTGrIiIWzYFwRb0omfoVQ>
    <xmx:V_v-aSAgh9LRg6IekND2Y4hnB5cutk3AoULcXXFUa-vs6Wg_HN-gjA>
    <xmx:V_v-aYAA-Aqxa5c22uMjbi-GC-xS0qPKyfj-GwTNtV1cmAiUy58fnQ>
    <xmx:V_v-ab-wQO41TWE9-BPP_9O270MpvzTPsZjHNxO6Ad_gLlbEboNjWHy3>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 05:16:07 -0400 (EDT)
Date: Sat, 9 May 2026 11:16:06 +0200
From: Greg KH <greg@kroah.com>
To: Rion Kiguchi <kiguchi.r.sec@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: vme_user: validate slave window size against
 buffer size
Message-ID: <2026050921-shifty-oxidation-f184@gregkh>
References: <2026050935-designing-glancing-2e16@gregkh>
 <20260509090721.1136091-1-kiguchi.r.sec@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509090721.1136091-1-kiguchi.r.sec@gmail.com>
X-Rspamd-Queue-Id: 38D0E4FEF67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244931-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 06:07:21PM +0900, Rion Kiguchi wrote:
> The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
> a user-controlled slave.size and forwards it to vme_slave_set() without
> comparing it against image[minor].size_buf. The slave-image kernel
> buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
> (0x20000 / 128 KiB), but the configured VME window size can be made
> much larger via the ioctl.

<snip>

For some reason you are not using scripts/get_maintainer.pl on your
patch to know who to send this to (hint, it's not the stable email
address...)

> @@ -401,7 +409,6 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
>  				slave.enable, slave.vme_addr, slave.size,
>  				image[minor].pci_buf, slave.aspace,
>  				slave.cycle);
> -
>  			break;
>  		}
>  		break;

Why was this change made?

thanks,

greg k-h

