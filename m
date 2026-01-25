Return-Path: <stable+bounces-211490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDzALVUwdmmjNAEAu9opvQ
	(envelope-from <stable+bounces-211490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 16:01:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F58119F
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C38C830048C6
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504E1F30AD;
	Sun, 25 Jan 2026 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SzxMaWXy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D53EBF3A
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769353298; cv=none; b=ZFCkI/Cp9SwnXViR1lR1l1Tb7vsZ2WESpbF1LXC7lJZ/YTvkcHeWOs84cHMqZcC0j2mxTnLjuVwzfinXS2n71LDLfxfg8crcB3O1VLM+uwTrw/p+Xd0eN6FmP7KAN/GlCHXYMFmdSO82E9uG+IQEOIbzOk9YFM1eMph35K42UTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769353298; c=relaxed/simple;
	bh=MR8/T6hWANVv+0jE6mehubi2fbAPKuuGcVZaTeZYJ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNLlp1a1KhKHFZicrJPgkWRDMdFCytSeFb2dmy7ijrN6BQmJpbbFLRfyplve/clDhfKbch1BsT3mX7dJewfoxTSTdABuyN9f9h4wxuIEVFg3mVD5sYMaw4DZCnTEh4T0BdBE7aqtnvbvWUAP72+R7Uxirb8HRrKV3xrndKmxA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SzxMaWXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4DBC4CEF1;
	Sun, 25 Jan 2026 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769353298;
	bh=MR8/T6hWANVv+0jE6mehubi2fbAPKuuGcVZaTeZYJ9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzxMaWXykFPNsBH5OGRBaEMUS2D9vxZVZYRyDJuLwf5PcWk6L/ivWGWZhCu3oleqA
	 mlYF21U6TYMzDcaS6WfTHtCBVqY3psc8o76UySkhOfGqFmyVMo7WpqkMsVtFK8rIZg
	 XRFwh6olRT38E6/vuqQlubyDnzEan53b0PszOq/4=
Date: Sun, 25 Jan 2026 16:01:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saikiran <bjsaikiran@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/2] media: qcom: camss: Fix pipeline lock leak in
 stop_streaming
Message-ID: <2026012527-maker-deplored-0884@gregkh>
References: <20260125145544.50785-1-bjsaikiran@gmail.com>
 <20260125145544.50785-2-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125145544.50785-2-bjsaikiran@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-211490-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 150F58119F
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 08:25:43PM +0530, Saikiran wrote:
> When a browser or application closes the camera, if any subdevice fails
> to stop streaming, video_stop_streaming() returns early without calling
> video_device_pipeline_stop(). This leaves the pipeline permanently locked,
> preventing any future camera access until reboot.
> 
> Fix this by logging errors but continuing to stop all remaining subdevices
> and always releasing the pipeline lock, even when errors occur during the
> stop sequence.
> 
> Fixes: 89013969e232 ("media: camss: sm8250: Pipeline starting and stopping for multiple virtual channels")
> Cc: stable@vger.kernel.org
> Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite, ov02c10 camera)
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/media/platform/qcom/camss/camss-video.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
> index 831486e14754..242c44f97801 100644
> --- a/drivers/media/platform/qcom/camss/camss-video.c
> +++ b/drivers/media/platform/qcom/camss/camss-video.c
> @@ -312,9 +312,15 @@ static void video_stop_streaming(struct vb2_queue *q)
>  
>  		ret = v4l2_subdev_call(subdev, video, s_stream, 0);
>  
> +		/*
> +		 * Don't return early on error - we must continue to stop
> +		 * remaining subdevices and release the pipeline lock to
> +		 * prevent the camera from being permanently locked.
> +		 */
>  		if (ret) {
> -			dev_err(video->camss->dev, "Video pipeline stop failed: %d\n", ret);
> -			return;
> +			dev_err(video->camss->dev,
> +				"Failed to stop subdev '%s': %d\n",
> +				subdev->name, ret);
>  		}
>  	}
>  
> -- 
> 2.51.0
> 
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

