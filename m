Return-Path: <stable+bounces-254080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPeYL/vkE2rhHAcAu9opvQ
	(envelope-from <stable+bounces-254080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:58:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D02DC5C61E7
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 067C230028DB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78B35E1C4;
	Mon, 25 May 2026 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyhBumdB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E451F5842;
	Mon, 25 May 2026 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688692; cv=none; b=U/WN0myxP7rBQUtIZJYCChzFdp5MR6DxdiQiyhwZOGmZDXca1by79MTSKjAkFIhS/jr1hww+FawvFotzEqSiF2X2oguCQz84BMVykXSUCx9Mb/MI73bOH42Kd+82PFzCWZFoSjSqYSTRGLn7a7PbiT813kvVfXUCsi8NY87kViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688692; c=relaxed/simple;
	bh=nimDBp9SaVkFWh936SfObtHzSlf83xWNLjgH240Ozvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYZbXVGsConz9y3gltODgPe11XKgf2Wy4iZE4P7815U5xKcF4kEXzf9KfcmS5CxLNcOH8uz5RhI9R3qUXHTaHTcP6lCt+fGk6Su3qNfmRJ/K3wlWk4XomO+hd4C12qEL/AkQ45b0ovdNbw4/HuEpp1qnvmXqTFi+uVkrcSPrzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IyhBumdB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F131F000E9;
	Mon, 25 May 2026 05:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779688691;
	bh=NWIFi+1O2Fmh2o45v7apRP2MYJxbwOReNxkxm3QZY48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IyhBumdBTzyGFFMcupyzI8888a4I6s8LR4nklkFgVPW22uVP4ZgKKCi2VlC/1XH8/
	 WyTtVyNiAreimVIZrm/u6+Hn92kb+gPhYjyvyzNXhUf/p3JFoycZ22zbF3rmmjRLxn
	 VZyVUb2WNulWRls/yo5cyQeV8tnIvqJlDPsfnt8M=
Date: Mon, 25 May 2026 07:57:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Korwel <adriank20047@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org, dave@stgolabs.net
Subject: Re: [PATCH] usb: gadget: f_midi: cancel work before midi is freed
Message-ID: <2026052509-shelter-caucus-92e5@gregkh>
References: <CADgB2mE=WX_PxArBp40WpmQ-qQpbuxDRRE0TRg7Be_zGyuRqig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADgB2mE=WX_PxArBp40WpmQ-qQpbuxDRRE0TRg7Be_zGyuRqig@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254080-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.953];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D02DC5C61E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 08:40:25PM -0500, Adrian Korwel wrote:
> From: Adrian Korwel <adriank20047@gmail.com>
> 
> f_midi_disable() disables the USB endpoints but does not cancel the
> pending work item before returning. Since f_midi uses the system
> high-priority workqueue (system_highpri_wq) rather than a dedicated
> workqueue, there is no implicit draining when the function is unbound.
> 
> The work item f_midi_in_work can therefore be scheduled via
> queue_work() from f_midi_complete() or f_midi_in_trigger() and execute
> after f_midi_free() has run, resulting in a use-after-free when
> f_midi_transmit() accesses midi->in_ep, midi->transmit_lock,
> midi->in_req_fifo and midi->in_ports_array.
> 
> This was introduced in commit 8653d71ce376 ("usb/gadget: f_midi:
> Replace tasklet with work") which converted from tasklet_hi_schedule()
> to queue_work() but omitted the cancel_work_sync() call needed to
> ensure the work is not in flight when the structure is freed. Tasklets
> did not require explicit cancellation in this path; workqueues do.
> 
> Fix by calling cancel_work_sync() in f_midi_disable() after disabling
> the endpoints, ensuring no work item referencing midi can run after
> teardown begins.
> 
> Fixes: 8653d71ce376 ("usb/gadget: f_midi: Replace tasklet with work")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
> ---
>  drivers/usb/gadget/function/f_midi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c
> b/drivers/usb/gadget/function/f_midi.c
> index 4d9e4bd700d8..864527bf900c 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -430,6 +430,8 @@ static void f_midi_disable(struct usb_function *f)
>         usb_ep_disable(midi->in_ep);
>         usb_ep_disable(midi->out_ep);
> 
> +       cancel_work_sync(&midi->work);
> +
>         /* release IN requests */
>         while (kfifo_get(&midi->in_req_fifo, &req))
>                 free_ep_req(midi->in_ep, req);
> -- 
> 2.43.0

This is corrupted, please don't use web email clients :(

