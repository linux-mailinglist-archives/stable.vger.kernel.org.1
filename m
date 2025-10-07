Return-Path: <stable+bounces-183543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F2DBC174B
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 15:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD919A0101
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC92E06ED;
	Tue,  7 Oct 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LrZP+kM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LeUx5ame"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B52561D1
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842984; cv=none; b=gZgk6xPJ9t0k5t0IdFEfrbBZrKJ8QjwEA/Z4IET8ZlqZOWHCpoMZEYcsiJic4KMXlCiTC56miiATMM8hCwd6Le7DnI4qXgY8h7eHtRmLVdwAG40NEn6gtkTvyU0hqbNo8tE5pYHSe79RAjgerohJf611V8dRaaCpp0yDvWcq5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842984; c=relaxed/simple;
	bh=dxsPADbl8z+hTOA3RhfbtlCXsqdu18vP3slFu871b7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejwDNGK7z7CTAB5IEuppSUuvAPy71zduUy8t1j62DNt8kGv8qQm7yH7WQZvRV42F5gYEPdtGE6kS6iXA7csJwxsbouKtey9IO56WqsMK1olhRryU3r0mp8z6Y0TzaCV2Uriij8slLy8NioIZNIBJ4lklZUIyv4HQVZE+zLEWiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LrZP+kM6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LeUx5ame; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D77DEC003B;
	Tue,  7 Oct 2025 09:16:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 09:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759842981; x=1759929381; bh=Q8H/cd7Wqe
	YGZ/iEOGW0hj7F0xk5Uck07aRS+Yeg4dI=; b=LrZP+kM69/q4w+GqYlSI3uJAhZ
	Pp2avnARy7ycFpFumdDTc7/YtTXi3QuvHCLm/hhoeHJE6KkIgoRTFFNMYrIgLRY+
	rb0gWyB/Ye8DY/RMKF45MPCpH6LWkGj+RWMzy8N+LYvqSspaDL0PbvCLjlE7TsjT
	v5Gf6mf9F036irDLEWq7xtLELaKqn5LCJ6p4n2iz87qVLbYjPmTJJskgQ4bYbHTm
	x+ct0SwzGyHOg+Nqo4TCoy9CdQOMVgXfPIa0JWhI5m52noNfJww9PQGJ2XnMRp0h
	ktNzDVyVnqGrD0mJqKgnW/Lc1AVBBY+q9OPudHQx0QtRtBep+9cTts84NafQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759842981; x=1759929381; bh=Q8H/cd7WqeYGZ/iEOGW0hj7F0xk5Uck07aR
	S+Yeg4dI=; b=LeUx5ameSrdKGrVxpgnUDk2nOjLk8kD94OkojLk6Gz+I95pZhde
	+83GUMIhMO5WMKaTLGEnOmow3HPKDv/07/6+2fWAh0VnM8UtXXKJCNlu8Z0dbork
	N5e2Ctgqalv8wbS5foabWQZ9dPzbGkwl3AC2kuQ1tIs+fYj7d7NlGJ4ogVugev5h
	SClHwIo7y4mJR+QBBHGTNiu4ywMGmhcTpfPltOrMvUlR3vGTKZYtTzUfo/D07H4I
	+D47Sbgl7gcqHN9yo0MXxG/XQb6W2xEeukdlrwEKxeNy4bqwnoRT3xndcADSb1n5
	ZULQnXLpazzexruckk8AaomnBiCGrh2EoPA==
X-ME-Sender: <xms:pBLlaMBir0az6AdhCK1Twj8kspuoIO8_RKWls42Sa1TxjCeuEO8jJg>
    <xme:pBLlaGuc1_ZKLDIdIt3FJAvdMtr1wL5AWjjGZ00rmQlSvI65_qB9e5a1Igzjx34M1
    Ex97rNievu56APV2myXDIlLK6hGxwSmcLfym1khcJpVCsYl>
X-ME-Received: <xmr:pBLlaLJ9dFbgbj4xr-lOVnn2Wj3exaCZW62V-I7n5acxGMK1UQo-DPuQg1koP7gtbntYMNvscZCqYwg1-lZqqCX_W16ur9cF0cY00w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddthedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeekfeffvd
    effeduffejteekffeileehgeefudffgfdtgfeuueduuedujeekfeeknecuffhomhgrihhn
    pehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhmshhgihgurdhlihhnkhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvghes
    khhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehrohhmrghinhdrshhiohgvnhesmhhitghrohgthhhiphdrtghomhdp
    rhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegtohhnthgrtghtsegrrhhnrghuugdqlhgtmhdrtghomhdprhgtphhtthhopehjihhk
    ohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshiiisghothdohedvtgdurgejug
    efvgehsgefiedutggtugefgeeisehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:pBLlaNb2FxcGlFx9SSFai2ulnjT3yXaave6J668a0OE3U5iyTrtNGw>
    <xmx:pBLlaNCgjnUc_GJw0v4u5uJxxZI0c7BmrK6wIoP459X-EIPCoiLhng>
    <xmx:pBLlaHYr2siMJ4EJIgSRVz4nCLxIDY2JoWFnoxeJgGO1cXXHBaWsCA>
    <xmx:pBLlaFmgg7yDWIL0gRM2hiF1EH-FNLh3ojLDDBMirRD0lHDHPPzesA>
    <xmx:pRLlaCFXHTA91VxbHbMmWZXZD30yOrMrdE1wgZPDU5sSlBEylMDdv438>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 09:16:20 -0400 (EDT)
Date: Tue, 7 Oct 2025 15:16:18 +0200
From: Greg KH <greg@kroah.com>
To: Romain Sioen <romain.sioen@microchip.com>
Cc: stable@vger.kernel.org, contact@arnaud-lcm.com, jikos@kernel.org,
	syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] hid: fix I2C read buffer overflow in raw_event() for
 mcp2221
Message-ID: <2025100751-ambiance-resubmit-c65e@gregkh>
References: <20251007130811.1001125-1-romain.sioen@microchip.com>
 <20251007130811.1001125-2-romain.sioen@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007130811.1001125-2-romain.sioen@microchip.com>

On Tue, Oct 07, 2025 at 03:08:11PM +0200, Romain Sioen wrote:
> From: Arnaud Lecomte <contact@arnaud-lcm.com>
> 
> [ Upstream commit b56cc41a3ae7323aa3c6165f93c32e020538b6d2 ]
> 
> As reported by syzbot, mcp2221_raw_event lacked
> validation of incoming I2C read data sizes, risking buffer
> overflows in mcp->rxbuf during multi-part transfers.
> As highlighted in the DS20005565B spec, p44, we have:
> "The number of read-back data bytes to follow in this packet:
> from 0 to a maximum of 60 bytes of read-back bytes."
> This patch enforces we don't exceed this limit.
> 
> Reported-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
> Tested-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> Link: https://patch.msgid.link/20250726220931.7126-1-contact@arnaud-lcm.com
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> [romain.sioen@microchip.com: backport to stable, up to 6.12. Add "Fixes" tag]

I don't see a fixes tag :(

And is this only for 6.12 and 6.16?

thanks,

greg k-h

