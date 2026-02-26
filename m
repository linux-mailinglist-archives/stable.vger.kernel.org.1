Return-Path: <stable+bounces-219839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I+6NVGIoGlvkgQAu9opvQ
	(envelope-from <stable+bounces-219839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 18:52:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAAB1ACED7
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3027A332A1C2
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9458287E;
	Thu, 26 Feb 2026 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XVUO7vuA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PjDsIFJs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XVUO7vuA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PjDsIFJs"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F4368963
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125991; cv=none; b=MmkVxvVOKY8hc6LBU3uVHm7XbZ0/fexWkWDs0iK86NVz5jxO6lWghihz+U2GN9u0/ulcxCdo77bxoA0R5mnaSd46oQZxRfZTPYrRnQbd0L32E5LOSPI46sbRP8boWdUte/V2QSuUC0IyV38hZ3xcDkch+LACA0u8iiyPPeYLYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125991; c=relaxed/simple;
	bh=vuNF+CsgDhYGhajv9QOfHxvpySDi0aQnR8cDGX6FixI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJ1CnrGXQJ39dbD5ztSBDMRPw1Vf/LaoGluaYbhwhfKLOviTWTZuc4BHsW0cCtbWTaQYazP8xsoCVfsoGlk9Fc8MI/quTqxzosw2zMAK/LQ6pnRGbimvLYa1yWWiHxJR4mFor2u8qpiUTzgT7XKV7Q96uvFWQeWO1MJbS0Te9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XVUO7vuA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PjDsIFJs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XVUO7vuA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PjDsIFJs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6CA11FAA8;
	Thu, 26 Feb 2026 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772125988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=chsq2oq74SxheHrAUdoA/OBtFxtpPWmDeHM3rlP8M3Q=;
	b=XVUO7vuAJumaORaLN7Qb+0Mxsfpvc9lG8/D2D9hsSKk1cn+zam9mYFOrJPjCna4a6rcaSX
	rV8FRfKJ3KLDVI+UiUXuzZLU6p18rPSaDZKgCXYbnhq+6T5mQUkhVXp3m1CV0BxAOkBR4S
	K8Q9dKuPSteh1iEqi2zCRvAl+Z9so2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772125988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=chsq2oq74SxheHrAUdoA/OBtFxtpPWmDeHM3rlP8M3Q=;
	b=PjDsIFJswnEipvFHgf0wLq3ZFRNMQdjuPuHbX5a6FPU52YueUVMK6OUF7sSeEwzaFst/pd
	bmmGkHN2b9y2mwCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XVUO7vuA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PjDsIFJs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772125988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=chsq2oq74SxheHrAUdoA/OBtFxtpPWmDeHM3rlP8M3Q=;
	b=XVUO7vuAJumaORaLN7Qb+0Mxsfpvc9lG8/D2D9hsSKk1cn+zam9mYFOrJPjCna4a6rcaSX
	rV8FRfKJ3KLDVI+UiUXuzZLU6p18rPSaDZKgCXYbnhq+6T5mQUkhVXp3m1CV0BxAOkBR4S
	K8Q9dKuPSteh1iEqi2zCRvAl+Z9so2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772125988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=chsq2oq74SxheHrAUdoA/OBtFxtpPWmDeHM3rlP8M3Q=;
	b=PjDsIFJswnEipvFHgf0wLq3ZFRNMQdjuPuHbX5a6FPU52YueUVMK6OUF7sSeEwzaFst/pd
	bmmGkHN2b9y2mwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F86A3EA62;
	Thu, 26 Feb 2026 17:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SZJIDiR/oGl3SQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 26 Feb 2026 17:13:08 +0000
Date: Thu, 26 Feb 2026 18:13:07 +0100
Message-ID: <87fr6na0nw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	quic_wcheng@quicinc.com,
	broonie@kernel.org,
	arnd@arndb.de,
	harshit.m.mogalapalli@oracle.com,
	wesley.cheng@oss.qualcomm.com,
	dan.carpenter@linaro.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ALSA: usb: qcom: manage offload device usage
In-Reply-To: <20260225064601.270301-3-guanyulin@google.com>
References: <20260225064601.270301-1-guanyulin@google.com>
	<20260225064601.270301-3-guanyulin@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219839-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 1EAAB1ACED7
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 07:45:51 +0100,
Guan-Yu Lin wrote:
> 
> The Qualcomm USB audio offload driver currently does not report its offload
> activity to the USB core. This prevents the USB core from properly tracking
> active offload sessions, which could allow the device to auto-suspend while
> audio offloading is in progress.
> 
> Integrate usb_offload_get() and usb_offload_put() calls into the offload
> stream setup and teardown paths. Specifically, call usb_offload_get() when
> initializing the event ring and usb_offload_put() when freeing it.
> 
> Since the updated usb_offload_get() and usb_offload_put() APIs require the
> caller to hold the USB device lock, add the necessary device locking in
> handle_uaudio_stream_req() and qmi_stop_session() to satisfy this
> requirement.
> 
> Cc: stable@vger.kernel.org
> Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>

Mostly it looks good to me, but a slight concern is the
usb_offload_put() call in the error path of prepare_qmi_response().
IIUC, the bitmap is cleared only at uaudio_event_ring_cleanup_free(),
and you have also the usb_offload_put() call there.  I wonder whether
this might lead to the refcount unbalance.

I'm not sure whether the original driver code handles it well, and
this could be already a bug there calling
xhci_sideband_remove_interrupter(), though.


thanks,

Takashi

> ---
>  sound/usb/qcom/qc_audio_offload.c | 102 ++++++++++++++++++------------
>  1 file changed, 60 insertions(+), 42 deletions(-)
> 
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> index cfb30a195364..1da243662327 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -699,6 +699,7 @@ static void uaudio_event_ring_cleanup_free(struct uaudio_dev *dev)
>  		uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE,
>  				   PAGE_SIZE);
>  		xhci_sideband_remove_interrupter(uadev[dev->chip->card->number].sb);
> +		usb_offload_put(dev->udev);
>  	}
>  }
>  
> @@ -750,6 +751,7 @@ static void qmi_stop_session(void)
>  	struct snd_usb_substream *subs;
>  	struct usb_host_endpoint *ep;
>  	struct snd_usb_audio *chip;
> +	struct usb_device *udev;
>  	struct intf_info *info;
>  	int pcm_card_num;
>  	int if_idx;
> @@ -791,8 +793,13 @@ static void qmi_stop_session(void)
>  			disable_audio_stream(subs);
>  		}
>  		atomic_set(&uadev[idx].in_use, 0);
> -		guard(mutex)(&chip->mutex);
> -		uaudio_dev_cleanup(&uadev[idx]);
> +
> +		udev = uadev[idx].udev;
> +		if (udev) {
> +			guard(device)(&udev->dev);
> +			guard(mutex)(&chip->mutex);
> +			uaudio_dev_cleanup(&uadev[idx]);
> +		}
>  	}
>  }
>  
> @@ -1183,11 +1190,15 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
>  	er_pa = 0;
>  
>  	/* event ring */
> +	ret = usb_offload_get(subs->dev);
> +	if (ret < 0)
> +		goto exit;
> +
>  	ret = xhci_sideband_create_interrupter(uadev[card_num].sb, 1, false,
>  					       0, uaudio_qdev->data->intr_num);
>  	if (ret < 0) {
>  		dev_err(&subs->dev->dev, "failed to fetch interrupter\n");
> -		goto exit;
> +		goto put_offload;
>  	}
>  
>  	sgt = xhci_sideband_get_event_buffer(uadev[card_num].sb);
> @@ -1219,6 +1230,8 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
>  	mem_info->dma = 0;
>  remove_interrupter:
>  	xhci_sideband_remove_interrupter(uadev[card_num].sb);
> +put_offload:
> +	usb_offload_put(subs->dev);
>  exit:
>  	return ret;
>  }
> @@ -1483,6 +1496,7 @@ static int prepare_qmi_response(struct snd_usb_substream *subs,
>  	uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE, PAGE_SIZE);
>  free_sec_ring:
>  	xhci_sideband_remove_interrupter(uadev[card_num].sb);
> +	usb_offload_put(subs->dev);
>  drop_sync_ep:
>  	if (subs->sync_endpoint) {
>  		uaudio_iommu_unmap(MEM_XFER_RING,
> @@ -1528,6 +1542,7 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  	u8 pcm_card_num;
>  	u8 pcm_dev_num;
>  	u8 direction;
> +	struct usb_device *udev = NULL;
>  	int ret = 0;
>  
>  	if (!svc->client_connected) {
> @@ -1597,50 +1612,53 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  
>  	uadev[pcm_card_num].ctrl_intf = chip->ctrl_intf;
>  
> -	if (req_msg->enable) {
> -		ret = enable_audio_stream(subs,
> -					  map_pcm_format(req_msg->audio_format),
> -					  req_msg->number_of_ch, req_msg->bit_rate,
> -					  datainterval);
> -
> -		if (!ret)
> -			ret = prepare_qmi_response(subs, req_msg, &resp,
> -						   info_idx);
> -		if (ret < 0) {
> -			guard(mutex)(&chip->mutex);
> -			subs->opened = 0;
> -		}
> -	} else {
> -		info = &uadev[pcm_card_num].info[info_idx];
> -		if (info->data_ep_pipe) {
> -			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
> -					       info->data_ep_pipe);
> -			if (ep) {
> -				xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
> -							    ep);
> -				xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb,
> -							      ep);
> +	udev = subs->dev;
> +	scoped_guard(device, &udev->dev) {
> +		if (req_msg->enable) {
> +			ret = enable_audio_stream(subs,
> +						map_pcm_format(req_msg->audio_format),
> +						req_msg->number_of_ch, req_msg->bit_rate,
> +						datainterval);
> +
> +			if (!ret)
> +				ret = prepare_qmi_response(subs, req_msg, &resp,
> +							info_idx);
> +			if (ret < 0) {
> +				guard(mutex)(&chip->mutex);
> +				subs->opened = 0;
> +			}
> +		} else {
> +			info = &uadev[pcm_card_num].info[info_idx];
> +			if (info->data_ep_pipe) {
> +				ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
> +							info->data_ep_pipe);
> +				if (ep) {
> +					xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
> +									ep);
> +					xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb,
> +									ep);
> +				}
> +
> +				info->data_ep_pipe = 0;
>  			}
>  
> -			info->data_ep_pipe = 0;
> -		}
> -
> -		if (info->sync_ep_pipe) {
> -			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
> -					       info->sync_ep_pipe);
> -			if (ep) {
> -				xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
> -							    ep);
> -				xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb,
> -							      ep);
> +			if (info->sync_ep_pipe) {
> +				ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
> +							info->sync_ep_pipe);
> +				if (ep) {
> +					xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
> +									ep);
> +					xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb,
> +									ep);
> +				}
> +
> +				info->sync_ep_pipe = 0;
>  			}
>  
> -			info->sync_ep_pipe = 0;
> +			disable_audio_stream(subs);
> +			guard(mutex)(&chip->mutex);
> +			subs->opened = 0;
>  		}
> -
> -		disable_audio_stream(subs);
> -		guard(mutex)(&chip->mutex);
> -		subs->opened = 0;
>  	}
>  
>  response:
> -- 
> 2.53.0.414.gf7e9f6c205-goog
> 

