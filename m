Return-Path: <stable+bounces-224684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKwnM69gsWl/uQIAu9opvQ
	(envelope-from <stable+bounces-224684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:31:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1C6263A1E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB13C3031B12
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015362D8DC4;
	Wed, 11 Mar 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y334Cv2p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EE19D89E;
	Wed, 11 Mar 2026 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232296; cv=none; b=FupyYK/QfgI8fotAnwiPMpTVWz7Hmh6zRGkeQi6bGtonvPVKxMUVA+TemrMUreJzAsMrG4k50f68FQJDQLym9AIcKTi0dLWLgDfGs2AYdDr/oQThuApHwx7TrfjJxBOClTg6gQZypaZZV47j19kDS010Oj4JhlUCLK2fz+8t/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232296; c=relaxed/simple;
	bh=8FO5JQyUdTtvjjiHusgWZwBFkP9+9Rfi0T2kj3nS7/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5a8rtOne5UR1W9naOlVUdnkjF1fKHm61ED2ztkbCHDEb8d/9xe7Q/nOFB+eyJPiX2MqwSfWJ/cdfG6nYbfhNSveIMip0QzWMphtoBEsSiX3eIgsy8tukTCLz+SY16wb0ecXD1I5uIR5xvsK4iCJR9FABNvqPnob83h7q+3AowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y334Cv2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ED8C4CEF7;
	Wed, 11 Mar 2026 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773232295;
	bh=8FO5JQyUdTtvjjiHusgWZwBFkP9+9Rfi0T2kj3nS7/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y334Cv2pg/qqS247eo0chrhcWYxfmmxKEwRvJXdsJej3UYrDhxm1etLftQQ01pyQk
	 ufUGIffxfbrDJFMGlqQfZjmy+IXxmpzKHT1Fl8sZSXs+AQLlWo6f7N/mo4YGCdlynq
	 9TxuBcLEwaxQC030xBN1R6jujBnbV6JtykbFk7l8=
Date: Wed, 11 Mar 2026 13:31:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, perex@perex.cz, tiwai@suse.com,
	quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de,
	christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn,
	wesley.cheng@oss.qualcomm.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: usb: qcom: manage offload device usage
Message-ID: <2026031115-unboxed-spouse-1dcd@gregkh>
References: <20260309022205.28136-1-guanyulin@google.com>
 <20260309022205.28136-3-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309022205.28136-3-guanyulin@google.com>
X-Rspamd-Queue-Id: 4F1C6263A1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224684-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn,oss.qualcomm.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 02:22:05AM +0000, Guan-Yu Lin wrote:
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

Two locks?  For one structure?  Is this caller verifying that those
locks are held?

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

Where is the lock being held here?

This pushing the lock for USB calls "higher" up the call chain is rough,
and almost impossible to audit, given changes like this:

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

You have multiple levels of locks here, which is always a sign that
something has gone really wrong.  This looks even more fragile and easy
to get wrong than before.  Are you _SURE_ this is the only way to solve
this?  The whole usb_offload_get() api seems more wrong to me than
before (and I didn't like it even then...)

In other words, this patch set feels rough, and adds more complexity
overall, requiring a reviewer to "know" where locks are held and not
held while before they did not.  That's a lot to push onto us for
something that feels like is due to a broken hardware design?

thanks,

greg k-h

