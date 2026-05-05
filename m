Return-Path: <stable+bounces-244032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHVhIE+6+WmNBAMAu9opvQ
	(envelope-from <stable+bounces-244032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:37:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B34C9E57
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A759306633A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83D32570D;
	Tue,  5 May 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KRRQ3dlW"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C843290A9
	for <stable@vger.kernel.org>; Tue,  5 May 2026 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973696; cv=none; b=XQju0WkVpywYFK6FuW/PWdr9/bUxhktP1ElKtDLElO9WWqIgOSivaV2RDkVTW/U21NAPcr6GUAQqP4GGFY/hT72ZhEZjfLtD9sbGQDQgnvba3mUyF/68J/J7XE8PUTTlCBKl4bH6+2U9/LjuiZE7XUlPed4sr7VfEk1JEkpkfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973696; c=relaxed/simple;
	bh=5/f+PuTgj2epI8CtVBSkOBeeYpHhn9gfhcLMmWMiuNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWcpwXR9bX0tsMW16HigpbyXqd9ZCGNyjspj9av5Bi1ITFsjLAqQRfniqinWlw8n/4kBXqq8qZtxj9T8tvrVdaXlSp+WrFsofX7YZvVf8mzpebx1Q2TKSjancfKcPEU4QYN3jSO5H+kgOEQJlr3CLyU8OIwlpEbSDvtzEIjLSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KRRQ3dlW; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 5 May 2026 11:34:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777973681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CESp6uetEB7khEa9r53J2U2W+2MpllmP1Ap/FFA1vfs=;
	b=KRRQ3dlWz78ws2rS5TZAMUbrlgY9EF+6HoTPcSO54Vmtw0edRpBn+BZIUR4CiEkUvz/TaU
	Z2WBOQtcs9xhEvsQrp9OltCN10CSR148F1dMwivvAjeyHe/ZYKL/wWINr6ojccNRI2Lwsp
	RYbwLicxL1uTYheor8rGgnBSWWodjqs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Eric Anholt <eric@anholt.net>, stable@vger.kernel.org,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: fix NULL dereference in vc4_hvs_unbind
Message-ID: <afm5rE1i3D-Uk3S7@linux.dev>
References: <20260502121251.39206-3-thorsten.blum@linux.dev>
 <CAPY8ntDOEjAHFF_HxFoVEmrgQ8okm=8cHQEfm2QUU=MuB77d_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntDOEjAHFF_HxFoVEmrgQ8okm=8cHQEfm2QUU=MuB77d_A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 174B34C9E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244032-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,igalia.com,raspberrypi.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,anholt.net,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

Hi Dave,

On Tue, May 05, 2026 at 09:54:53AM +0100, Dave Stevenson wrote:
> Hi Thorsten
> 
> On Sat, 2 May 2026 at 13:13, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >
> > With 'dtoverlay=vc4-kms-v3d,noaudio' and 'hdmi=off' on Raspberry Pi,
> 
> Mainline doesn't use overlays, so this description isn't valid.
> 
> Which generation of Pi are you using? Whilst they all share the vc4
> driver, the functionality associated differs. If you're disabling HDMI
> (and HDMI audio), which display outputs are you using?

It's a Pi 500 currently running headless, which is why I turned audio
and HDMI off. I ended up using:

  dtparam=audio=off
  #dtoverlay=vc4-kms-v3d
  hdmi=off

This prevents the vc4 and snd modules from loading and works for me.

> > unloading the vc4 module calls vc4_hvs_unbind() with
> > dev_get_drvdata(master) returning NULL.
> >
> > Return early when 'drm' is NULL before converting it to 'vc4' and before
> > dereferencing 'vc4->hvs', preventing a kernel oops.
> 
> That leaves things allocated and clocks running, so bailing out isn't a fix.
> I'll have a look to see why dev_get_drvdata is returning NULL.

Yes, I realized there are probably other things that need to be fixed.
However, the defensive NULL check avoided the kernel oops for me.

Thanks,
Thorsten

