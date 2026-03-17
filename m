Return-Path: <stable+bounces-226128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMJ9NFeDuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:37:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542B2AE216
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B7D5307BB6A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487753A5E66;
	Tue, 17 Mar 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pTnBX+aL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAWHtRhz"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83430376BCC
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765216; cv=none; b=ou/A3TxvkixkKIkw7HdUSotb8Uz/AuYZipkPvTB8OQ/DJOWP7BIaBl/iMlVS3lLAh6P3efqs1asfYuEtzd2L0QCzdEVzZvCqg0fjtqVl8ik8hUjL9u4vNtaCAl9CbhS5mzUSJATzzkxJ2NoaKM2u7uzMKuF0T0nWJ4nQFTt4IIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765216; c=relaxed/simple;
	bh=U06W9qx2yxe4I4rWXhJNkuERNXmG75ZCzvKbbPiCk+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb7NZoUfZrlByfi5aGVhkHwOHyOgmGQWSSysg8iQAoB1Ts+3ku3oTq2WXtVmnTz6JrdjCPTmpTR3r/SLSql021CL4NuoVsDfOFn1xIuoiTOgP2UVbURu4OnvRFHXk4RNhJff2iQpQIczHrTVqSAWLzZwQ7e7HLzNnXvZdOaIod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pTnBX+aL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rAWHtRhz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EABA14000BE;
	Tue, 17 Mar 2026 12:33:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 12:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773765209; x=1773851609; bh=SSLYqYLx7+
	n7Z0JXA2O6XisSJW6wdXE89jwL1yjenOY=; b=pTnBX+aLL5DhazRPNGaYv/kkWp
	SwCzNquYT683vHTIDDhgzgszT6SjeOGXCuxT4wA2bwgvh4tEAOKoi3FIpy7HKDGa
	KAv+Pm3lBoPHshbRc5FNTtCQzU3tWnRBSKQiGxM342rDIaN8pyDruFWBuih7YWZA
	BIMhkKc7MJrHqt5qzF538L94kbAhh66e5CHeXY4KkSoQPxPFm+6DIvx1AiiAprGx
	ps1R3ohJdGk0Vez0DYiOkUpZ1d+eRXMaUMtx6TSaKWsz+3L4MaZl0l2knyqk1sFB
	sdhr+LVtEXz3Y0Fzq/z8NfimD68s4IJZ/GWbYhsKoHbnL3EY2Ahaw1KIM55w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773765209; x=1773851609; bh=SSLYqYLx7+n7Z0JXA2O6XisSJW6wdXE89jw
	L1yjenOY=; b=rAWHtRhzsS8FAPzvo7P+OTpaKdaeK54b+hAX2TcJCnOboL6T+hQ
	WXgFuXhuBTRrs+Q+juRF90Dx+6Pv2EfG63YyLp/xmj0/ehG05p9R4i8jQXPLXROA
	qvtTn+TrIjfN3bvGIw7uPq/B5bNHhk6T+AtnbkP4wIn7MP/H3H5xQITIfX6IYtno
	DE8BNklGzCBArcyDVgPGrutfrpnOPoJgYO53bQAG8Wn7S6hioSz7GmafbNtPrmWW
	p9Ti6YvaV/ATb8nc/SfhQLLY860tm65qIaDtM8OlisGoYxVtmAR9/xnM8zOraAMF
	x6IUN/wKFEJuYl5uCKaE7e3nLZVqlEMSFcw==
X-ME-Sender: <xms:WYK5aWxYhHwQw7svbflQE0m1VPxIgDOFexXVjXLjwt4rhLQXtBEK7g>
    <xme:WYK5acTLQ4ydKgcHpJUr4Tcwg5VYtjwimVvYupCXTOvdwTTc--8gmke-ImndxTpgz
    I30P46FFyZeOlYJGAwJeu2bkqbx2ntvkwvKJCSm8NDnSUXNRw>
X-ME-Received: <xmr:WYK5ae9o3pr4vEVxroSUxJi8VGEocZgVVI8N63YAdlFh6DLw31mNHXwa2Gh5CJvNpSY87dLzhXSihWa6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehinhhvrdhgihhtqdgtohhmmhhithesthgukhdrtghomhdprhgtphhtthhopehsthgrsg
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvggrnhdqsggrphht
    ihhsthgvrdhmrghnvgihrhholhesthgukhdrtghomhdprhgtphhtthhopehjohhnrghthh
    grnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:WYK5aatlBaIpThlrwdwCdTaZpMut3eeiGSutAnfsAT1f150OWn4dpA>
    <xmx:WYK5aWM8C1yqwIQeeJCz-8qIXPIWZkPWkjvfa-4ZlxoXLnS7F6pb4w>
    <xmx:WYK5aXiIAQEuWKypVDGf2NUwpV5E0vZ4Eivvrz2-SDbNZFW0k9l6Gw>
    <xmx:WYK5aQ7AADTc9Hsl1FABUKdWU9N4ugYwFiiO79iw_m5VvO96ul7x8w>
    <xmx:WYK5aZWeVWmxX0U6owZ486p9TC-gNOH7KtHXyun0_YbwoMY_rstntBzd>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:33:28 -0400 (EDT)
Date: Tue, 17 Mar 2026 17:33:25 +0100
From: Greg KH <greg@kroah.com>
To: inv.git-commit@tdk.com
Cc: stable@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.1.y] iio: imu: inv_icm42600: fix odr switch when
 turning buffer off
Message-ID: <2026031722-capacity-compactly-7cef@gregkh>
References: <2026031739-putdown-harmony-6f22@gregkh>
 <20260317153124.522408-1-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317153124.522408-1-inv.git-commit@tdk.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226128-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,tdk.com:email,kroah.com:dkim]
X-Rspamd-Queue-Id: 5542B2AE216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:31:24PM +0000, inv.git-commit@tdk.com wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> ODR switch is done in 2 steps when FIFO is on : change the ODR register
> value and acknowledge change when reading the FIFO ODR change flag.
> When we are switching odr and turning buffer off just afterward, we are
> losing the FIFO ODR change flag and ODR switch is blocked.
> 
> Fix the issue by force applying any waiting ODR change when turning
> buffer off.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 32d7f8364230..f29c3e8531e6 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -377,6 +377,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
>  static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
>  	struct device *dev = regmap_get_device(st->map);
>  	unsigned int sensor;
>  	unsigned int *watermark;
> @@ -398,6 +399,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  	mutex_lock(&st->lock);
>  
> +	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
> +
>  	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
>  	if (ret)
>  		goto out_unlock;
> -- 
> 2.25.1
> 
> 

No git id :(

