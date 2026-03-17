Return-Path: <stable+bounces-226110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJEsNPR1uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:40:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC62AD2F7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B96973032D0E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B33E1203;
	Tue, 17 Mar 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v7DpeUIn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FD3EBF2D
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762034; cv=none; b=JyZevtEDCKffQxK9Kw+w45oHx14MEVp7ICIZa10LjtYr6dmMsLT2e1v3LboOhIkUpEeEIa1wdk6D0uAu+hf+OM76djEIGNVASKQ7iW58CdVXH5PoqW7XGctVoJ6fV5XyGF6RPI1Wp/tIWPTetgstfE4kJ3rvK8A+RFecE7HPZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762034; c=relaxed/simple;
	bh=aGEpsIoRuiCGeJjOG0LxP8ahqPX6ZbREOGXtpn7izTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Auuy4mAgekd5udlIpY0c5wya2+dqBJLz8XIKObUWqHv3EmvAktTla5gYMg8/2oSO+65FtLSmf82kpnDdO/BXr9x494CHZg7rdRkP9qGvKUAVW3yHdoOfVT1ggOWTWanqiBETDXWY3HAvZpwwQ4kWpqdbb38G71awwxYkL4gIIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v7DpeUIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FA5C4CEF7;
	Tue, 17 Mar 2026 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773762033;
	bh=aGEpsIoRuiCGeJjOG0LxP8ahqPX6ZbREOGXtpn7izTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v7DpeUIn/64CgfZ4jBHV/SV395Emg2QDunDA1uv2r4c0GY9rVHakd/GdKIdHpcg4M
	 r2qeBkddmszakic+EwvKG6yJq++OPJCpax1rAAROkcjOP618/xvfZ5OYykzgK6MKfd
	 vsgG8u46q+0wI0cDMej8sS9qS5I7rlzmCbU7BQqM=
Date: Tue, 17 Mar 2026 16:40:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: inv.git-commit@tdk.com
Cc: stable@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix odr switch when
 turning buffer off
Message-ID: <2026031713-program-cedar-3f3f@gregkh>
References: <2026031710-candle-hypnotism-fa31@gregkh>
 <20260317151940.343916-1-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317151940.343916-1-inv.git-commit@tdk.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226110-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,tdk.com:email]
X-Rspamd-Queue-Id: 61CC62AD2F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:19:40PM +0000, inv.git-commit@tdk.com wrote:
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
> index aca6ce758890..743580ea5845 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -378,6 +378,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
>  static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
>  	struct device *dev = regmap_get_device(st->map);
>  	unsigned int sensor;
>  	unsigned int *watermark;
> @@ -399,6 +400,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
>  
>  	mutex_lock(&st->lock);
>  
> +	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
> +
>  	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
>  	if (ret)
>  		goto out_unlock;
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

