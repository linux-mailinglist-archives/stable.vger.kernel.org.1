Return-Path: <stable+bounces-223448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ad0L7xFrWm90gEAu9opvQ
	(envelope-from <stable+bounces-223448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 10:47:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264822F3D4
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B06DB300C9B4
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48D36829D;
	Sun,  8 Mar 2026 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="inkuBTNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F417A2F6;
	Sun,  8 Mar 2026 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772963255; cv=none; b=M3pMuV3rIR04INR5ppzACSf0AdbQ8Xt/RMmCmlop0iY1OhnZ8F3NkLWWYJ6AT3vyfNf7W3GmjzhPigSMuV1tSyXlLZZWcGanWjLzWrpxa4nCUVLvlCEwYI0l6rGqoxqIFYHfBG2inTLf3LqbvuWeC50FmBOqw74lSKadPUpZo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772963255; c=relaxed/simple;
	bh=PJ/9tu4qNJoagggBdPlz3TTFrsJFAYDkXxreRvZYzbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvROFIsAiPSLn3jS6g5pFVkxrPp1clqfi30KyrreArF6f+IZYZIi/ZicrC7oybQijep6aTdn1NTzLz77Hi/Tnbzlugdm+oD4So8Y/2//ST6hqmrKKzI19jyH8Be7vpibKbiexE0hR/Mus1PTDiAAOxiFbXOOwf/jtH9wgUpFjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=inkuBTNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64498C116C6;
	Sun,  8 Mar 2026 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772963254;
	bh=PJ/9tu4qNJoagggBdPlz3TTFrsJFAYDkXxreRvZYzbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inkuBTNQQQ2/C91px9u6cd8g6uvQtqjOLZrbOBsE11CrW/uQaL2p2G9DhEE7iHZJ1
	 1rj2EA7lUYmYzlvnkhv47/WMkBIzIjyoqoihhn36HfNTOmoxJEMywf22x5OJXJL+dT
	 3U9ZzDQRV5O32oYL9U5AI791+YbkbSv/lScJ1WMY=
Date: Sun, 8 Mar 2026 10:47:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: hgfdgjn <shichuanyim@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [BUG] HDMI monitor shows no signal when the refresh rate is
 higher than the default 60Hz
Message-ID: <2026030839-applied-prominent-b774@gregkh>
References: <CA+tjKGrmADg=oG9CT74_mgGNN3h17=LLmnv51K=MggAqo7q2Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+tjKGrmADg=oG9CT74_mgGNN3h17=LLmnv51K=MggAqo7q2Eg@mail.gmail.com>
X-Rspamd-Queue-Id: 3264822F3D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223448-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.257];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 05:42:39PM +0800, hgfdgjn wrote:
> Hi maintainers:
> 
>   After updating to v6.19.6 on Arch Linux, if I set the refresh rate
> higher than 60Hz, the monitor displays "No Signal".
> I tried bisecting and found:
> > # first bad commit: [3471b9a31ce352ffb343cf02a991261880aac3a7] drm/amd/display: Rework HDMI data channel reads
> 
> This issue on my machine was caused by this change:
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> index 267180e7bc48..5d2bcce2f669 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> @@ -549,7 +549,8 @@ void write_scdc_data(struct ddc_service *ddc_service,
>      /*Lower than 340 Scramble bit from SCDC caps*/
> 
>      if (ddc_service->link->local_sink &&
> -        ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite)
> +        (ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite
> ||
> +        !ddc_service->link->local_sink->edid_caps.scdc_present))
>          return;
> 
>      link_query_ddc_data(ddc_service, slave_address, &offset,
> 
> 
> It appears that scdc_present is always false on my device.
> I reverted the change to write_scdc_data(), and the monitor works
> normally at high refresh rates.

Can you cc: the developers and maintainers of this change to let them
know?  Otherwise they will not notice it.  Also, does 7.0-rc2 show this
issue?

thanks,

greg k-h

