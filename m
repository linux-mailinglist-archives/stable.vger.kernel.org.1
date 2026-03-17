Return-Path: <stable+bounces-226112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMJcEt53uWnQGQIAu9opvQ
	(envelope-from <stable+bounces-226112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:48:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A40652AD4B1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B335930699A9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04EB25A357;
	Tue, 17 Mar 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="h9fdauuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6GIP+Ro"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49772221265
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762495; cv=none; b=HanFuYk/0reC2GGQWG5I7AoaOCwkrxcTBiub86NjkziqZ+DQZCXbmCWg29cQ0DEG8Rx37/Vqxi8tJlDqG+Fx5flheo3xTT4YH57cj5DgZVnxGBFjobQCh2TOD//TyHTcEvnxzG40t0OHxtbyeGj+xA4dcGE2OysMDx3UCjE82fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762495; c=relaxed/simple;
	bh=DCV2RgwIMsZ11w7jKDcV2xtHGJ+bkK75jGzQKfliNDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub51qunwuK3TbSas0JmGcNmLIBR0Hvv9lOh0P0y9nMpVb/MwlYQhllgkIIjKh82qg2O6W0XVeGM2hK+Y5CDw0DPFfhnWzkCBzL4e9GNdyQPayp/jlfKhA65O01y1umCJ7Eue8au/mxDTv8wmIu/7C8UCUZhfpJVV2/0t9uw3Sv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=h9fdauuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6GIP+Ro; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B7BFEC0772;
	Tue, 17 Mar 2026 11:48:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 17 Mar 2026 11:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773762493; x=1773848893; bh=p5ISHONBOz
	Q3P1hEE7m+QJPSNWQRe1lfuA25b2kofA0=; b=h9fdauuXZ5YlxbnxCMCvcpLCHG
	Y5wL5LH0vcvy+2OWmGR4JLuCeFxp7qq5fsA8IpqFzdiVLLDKH2vL9hFj0H8uEiPg
	iBvDTmfbZaYIYFzOEdQK45BFSZzcZr0ScsDv7vD8F6EoetpkNaDt/L6JSWj+cayu
	DVwEY1AJw4fT+iDkhv2iO9v8QjZrTBJVNWCEf84TxAGJ3XwTTzHdlAWieltPjcXl
	vROv/wWJ/EOe1epHB1V1+9eR45ARojjXqf+inzxosfm4JPgcPNg2w1YpFf9KqC+K
	QU6lWSXoWpb9KSg4aAXmlyjelYgnNqFVEsk5OTLI3I4Pv029nGd7ArnXv4Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773762493; x=1773848893; bh=p5ISHONBOzQ3P1hEE7m+QJPSNWQRe1lfuA2
	5b2kofA0=; b=U6GIP+Ro5eTGjeuWxRKJ0zI6HawhW1vdfb2IGR82sBZWXv74thf
	fqFMPdjRZu5fsVEaXSB/0iXXj4eWs0hwDQ4OEpg+ExrN0fwsxNrb/It9lairZx6Z
	lXymEwOz5wt5GDhgTjyT208Sz5IW/dEnGj+mCjyqVwjyllpMzI+TsYx62xACygl3
	fRsDi9Mq+/2AwZPJOjKbEB25c+oXr5NBneKwAnkCZQoIvBIK6eVT81HysywsE7nF
	Qd1nCNpV6MkNIZzIn4MaKk4arGkzp61bNS6s+vKtvcsJF+oW8aer8HqQyiFF3AuD
	T8JeH2zzjk1oQ3NmQphUQ53y0FKVr51bCHg==
X-ME-Sender: <xms:vXe5aWtjaLJD-8bxYK4zbe3HIcbV7lCkYtLTkMBo4epK1X8PkHzn5Q>
    <xme:vXe5aVeUUaW29PyA6DiEz4_9gv42SIifR6De8fJjUBpkvj6vmofhVB92Pvk795VKF
    N5JV5fgfbU0wk592BFLb0tw54kCRlhcJ-gK5MBtqzu8Tgq9pw>
X-ME-Received: <xmr:vXe5aYbhdAlk5UoChesj4leCI1NZVHz60XhljT2C3ObvyAd4lCioT9QLJnjnB_Slr15MRgGrAocb3Xq1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:vXe5afZnogWaTY6pFvXgmR-Wsi_BEttrQZGb6ZhcjpxUEesxJI22ng>
    <xmx:vXe5aVKYGP0cci-jX6iAkR5R7W_OoFWFsdIAJ89hW4Msfctq1qAwlw>
    <xmx:vXe5aTtnnpZkUxk1EFC1YKTvqRdq9trw5MXoB1-epWnjkYFBMe4m2w>
    <xmx:vXe5aRXLsk36XFPdNfQdfOjHLgHZ5FwuQiUZBJlvQ7MbICLymKm95A>
    <xmx:vXe5aZyI_8pyfQUEXNQ9a02H-VYV_EQKnznc8_ccMCE_hsVx4YkP1mCM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 11:48:12 -0400 (EDT)
Date: Tue, 17 Mar 2026 16:48:09 +0100
From: Greg KH <greg@kroah.com>
To: inv.git-commit@tdk.com
Cc: stable@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5.10.y] iio: imu: inv_icm42600: fix odr switch when
 turning buffer off
Message-ID: <2026031756-huntress-errand-07a3@gregkh>
References: <2026031737-trophy-prison-d009@gregkh>
 <20260317153943.637315-1-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317153943.637315-1-inv.git-commit@tdk.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226112-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,kroah.com:dkim,tdk.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A40652AD4B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:39:43PM +0000, inv.git-commit@tdk.com wrote:
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

You forgot to put the git id in the body :(

