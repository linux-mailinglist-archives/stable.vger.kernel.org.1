Return-Path: <stable+bounces-226129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ4FGy6EuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:41:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D62AE343
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D201D30524D0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF6377EC3;
	Tue, 17 Mar 2026 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ABh52XPP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sSt0mRZy"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A037756A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765229; cv=none; b=BSoxRl6C/VE+RIQfc7xwADWJuNygFnqXfriTc2tz5yXcchnHRpXhWEJ389HiqNxma0bE7M/Ri+49ufDfyFxeLVD+7UTvoQ5aL3VyT7N7zee9h1TfNWLpZdZBoGU3y/wMMqo1iAe83pWHr3BiuXv2JicopFwTGLrog6upjXwRbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765229; c=relaxed/simple;
	bh=Xn/pUj/JQAuJ7R1VVQ0/EOUPA+c6zICkeFDnIwow0zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6BYYfWF53EGYRxq4LThg7vYmK3lOrIuFeTEaN+0LkYiO8m5qEE+1fdtcSqWUKbDHUxDnYIdCYIR0ukXjA9+51td7WGPhn9DfUuAPmlHHjsRvY9P/6sbByV6P6yUGePdecaGSpITItXYCmMpXSBMrd306LcUPRQT3PobEZzK/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ABh52XPP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sSt0mRZy; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8859D140024B;
	Tue, 17 Mar 2026 12:33:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 12:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773765226; x=1773851626; bh=8JI4As3YAo
	QiVX9Q2h1InuaMC5jmK0ahdkVI0LO8zRw=; b=ABh52XPPZRC4iU16i6bcfEiEDw
	5xLeYj/nDnaTP01GgYQh9yrScDzc9I5MYrf9hut7tjTlRh+Fas2Ot4r3lzFo7fQc
	yllUhBbqaKKYxQXGITKca/rOSSfr6j34CjiRVSVuyLlI9JjBQgKA122E+Wx/q46r
	r6vYceBILcUv1inzzYM9udtUGIhuRhAovuDirV+IKk+boTv62fR2r1IFikhHRwV1
	zgXrjTCrS3PDwYM/ybu8PVbPjlaq1RBnm9Uw9NRqLuTkiUee079awvLoxUo+z+n5
	DJg8uuElyPh/57kqI6FiF0zSVnCx3vFOoVirUa8zxe6dvAnq8dFRKJwmNKkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773765226; x=1773851626; bh=8JI4As3YAoQiVX9Q2h1InuaMC5jmK0ahdkV
	I0LO8zRw=; b=sSt0mRZyWAvEGMQ9E6q1MPEwS9HhzN9TTRL7nv1p4dfOK4MLOCV
	/6RF7oU8I0O81dPOZODTJKVvjlSZmvEnk0rESDtO8mevhnHzs9VIVnzYdGqdjyRe
	v5I2lNM5GDOkSZU423GADhj61To+s1QbQ6yq89RW9tVTnyR/ihP4/doj6HGv7VOS
	meqW2PDap/FrQfho/TAAL9qv1KWegJYaTtQJtQTvJoOTxisEK3HaBXb0TQ294TPE
	Rgs4ypQFLSuEfspj58ix6sG/nbZgiFfYB+zNZCtCXYhi8wAj1T5E9GISZefasphd
	si5MgFgMn0AQdNVMQC2d8+bXQeI62G1PNEg==
X-ME-Sender: <xms:aoK5af_C_d1H4TH5lpHvGi_Lc3Kk1gvMRKplR97TQ89hSU0wmXWPHA>
    <xme:aoK5aVs-OtwDgsAuqZ_bI_iKJWUxZFnVEt2Qf5h6OMVKnZF1GkqklaJmSwdvdc-KM
    oziUFDfzvr0BWZkITsBgzR5zuDlz05AveEjGZLEa9522hdZSg>
X-ME-Received: <xmr:aoK5aTrd9KY8UGprDK3granXMKxauc3bsnwV7WvJw83J4sKyxaGEuAYPbtLKQ7hFAT3EGJhAqeQLCP-W>
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
X-ME-Proxy: <xmx:aoK5aZpLNDP8rtN98Pz4wMN_kQ2NgWmPXgUUIlkG_dh1OuVlexv-bQ>
    <xmx:aoK5aSbd64nv-B4OPe4QqQkcZyfV-71cJsrxD9O7Cz8d4maKaC0Ecg>
    <xmx:aoK5aX8t2afU7ZUnoNaAKA_UABtD8xFdhF7wW--UebQQr7304R604w>
    <xmx:aoK5aQlOijAj7q_x5Z_TeYvFZqtLwdNiHmHmfyJB_-uA8XT4caz53A>
    <xmx:aoK5aZAfpfZSqf4rzeaHHXePrOyWN0mtLH9Mc1DYYgnukFVsF1uPlKGF>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:33:45 -0400 (EDT)
Date: Tue, 17 Mar 2026 17:33:44 +0100
From: Greg KH <greg@kroah.com>
To: inv.git-commit@tdk.com
Cc: stable@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5.15.y] iio: imu: inv_icm42600: fix odr switch when
 turning buffer off
Message-ID: <2026031740-jolliness-crystal-15d4@gregkh>
References: <2026031738-vacant-most-feaf@gregkh>
 <20260317154338.637579-1-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317154338.637579-1-inv.git-commit@tdk.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226129-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kroah.com:dkim,huawei.com:email,messagingengine.com:dkim,tdk.com:email]
X-Rspamd-Queue-Id: 8E5D62AE343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:43:38PM +0000, inv.git-commit@tdk.com wrote:
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

