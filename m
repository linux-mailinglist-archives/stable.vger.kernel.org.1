Return-Path: <stable+bounces-214472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNPrMwuphGk04QMAu9opvQ
	(envelope-from <stable+bounces-214472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:28:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D2F3F1A
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E03653011BF7
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FFF3F074B;
	Thu,  5 Feb 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ5mzvCT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89513EFD3E
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301705; cv=none; b=RSdmmKYbBPqT4ktbhegwZ76u3USRwjKYA/RKOatlv7MP6kKvWqwqMdoSe9haTakInay46FHffR1tvfPBPq0+3EFTLyxbkCcIOmRHxetBTehj7rprvG4y/rZUexEa45hEz9jcXfdPKqb6f9wH2B92N2EXA5FX4vRgAxmHOu3rSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301705; c=relaxed/simple;
	bh=kXr4DefV73hjVoJ4U2FEAT9qvrXlt/HpysOqsndr9DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5H/hECPHkRwy6OCmITKAiJ5Ps/S0HCb6rn343KAM03A6a1fJyYrWOFuCS5JfTDZC4rPsuHfZRA4PxOLtGI7+4zDG4kjlOpGIISZ5Isan94eNVcVi+VwbP1rHtub14yJlz7SAgzgNRCGM3dsOurR9cnhE0gYdGdaQfoKId3kiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ5mzvCT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a79ded11a2so7247595ad.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770301704; x=1770906504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfAPA65QHaIhPMggaE3tVaDFtRc+AOhln1aXEIRSpVo=;
        b=LJ5mzvCThEN5Fkc3WrNKTVSNrujvdbd+i9eP+VwTeTP3dzyXTRYR/YgSjsQBY3by8w
         Wv3towKxBBKUUHj/m+xqqjs6OiWJWniqRo8rvRKfKvDbloGy04UP+Z9Zjs0ucqdlZTMR
         LMsZyLo6VPcVYPNa5SvkvnKjFvJj8zr3bPPII6GXUQphfocgThwZ98R01dFdfvjXW7ay
         KhShbFNBYrZct+3JZHHcchKMWDfNT+j4LAAfYPDxZS5Sbcnv8gnhNpApJeHQUixHU+Xa
         LmjfxNYnMgnoFe+LY7vBKZ7+y25crOQS/cMZ+cnO53r0osgEwtNQetrGTqI01kvy1y+z
         9hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770301704; x=1770906504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jfAPA65QHaIhPMggaE3tVaDFtRc+AOhln1aXEIRSpVo=;
        b=ItaDW9PCXUVk7gIs73Hj9KuP8ozvz1qCCKi6r4F3nQq2pGEOe9ZZC/mrDaO4SPmtXo
         IWjEegm3BvZcSyDiKEU3Su/o5Lh8nK72365NV5kCUAonL75BbmAp1wjDHd0DDdota3XP
         z2OFzw2VTUa+pTYIv2IEUAGjDskygj4yGHDo0nzGmb06BI7ohBT/ZMBlwYTuUu6/Z6/+
         iYdOD0yjHKKv4tkgo3MQiPd05JcXkpAcxPmySjSlihqVtixptR9IOB+im7fxkYVZ18sG
         MWyTFYis768molPIIVGp3apEcmLzd9Z+4Z6mPkxDFEyBndcxdi7wB7Fs61QhVAt/vfek
         iYaw==
X-Gm-Message-State: AOJu0YwoBTtVITCNiNQwqhZOMs07fJq0R+k9bNPfBlHQPJ4hagTCoJPj
	7lFdwRsZDrvauNsDoByG7vUB+KS5elswvEPMlMVbsDlKs2Im/nPMW3ik
X-Gm-Gg: AZuq6aL2poKH5qhr2A6n8dLTopoB4yiaGIhDsiEQTCxa3Jkav5Y1xnEuOjEg/UzMwu4
	Nt9GQhn5Bdj7eC/V2MizMubJIeYMhHZqlWyasF4NPnwWbGdETgwhzVcb9sMSuy6PufhksFX5hh/
	IvhzQRzX3jG5Vhgw0aaeyPjOrg+JeeNeJ4pVKLjxoTvb0a+N70d3pASWLvf7DO3ciEfmdFpEUd/
	fvrnX4/z3NrcsQf8/TIc2QaZUEPHRR46HO+N1TZmfHPy9PUi+XA2XSLNerTAE0drdmOL7ARMDvO
	y0+2ZCU7tuaGbekEXy4NjmG6E/nePcUQHgA215FvjLhVluiurCo7v3vZXMKfY3Ee9Sqdpvz8Qme
	R0KTy6VHF1jaG8t2IgHmGiB9Qbp3BuSrcOchnmJWK6tEbJyfvY5eMcnOduTq96+T8p7LILxaRRi
	cIkhRL6A+5Tr+xeBo+va/lsGQG
X-Received: by 2002:a17:903:fa7:b0:2a8:f8bd:bb72 with SMTP id d9443c01a7336-2a933fa77dbmr61907135ad.50.1770301704102;
        Thu, 05 Feb 2026 06:28:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e5e0sm56692515ad.64.2026.02.05.06.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:28:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Feb 2026 06:28:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	John Ogness <john.ogness@linutronix.de>,
	Daniel Palmer <daniel@thingy.jp>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 6.12 75/87] Revert "drm/nouveau/disp: Set
 drm_mode_config_funcs.atomic_(check|commit)"
Message-ID: <5951f289-a7ef-43b1-badf-f1e7cd04c02d@roeck-us.net>
References: <20260204143846.906385641@linuxfoundation.org>
 <20260204143849.619741696@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143849.619741696@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214472-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,thingy.jp:email]
X-Rspamd-Queue-Id: 366D2F3F1A
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:41:13PM +0100, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: John Ogness <john.ogness@linutronix.de>
> 
> commit 6c65db809796717f0a96cf22f80405dbc1a31a4b upstream.

Not questioning the need for it, but this revert does not exist
in the upstream kernel ???

$ git describe
v6.19-rc8-45-gf14faaf3a1fb
$ git show 6c65db809796717f0a96cf22f80405dbc1a31a4b
fatal: bad object 6c65db809796717f0a96cf22f80405dbc1a31a4b

Guenter

> 
> This reverts commit 604826acb3f53c6648a7ee99a3914ead680ab7fb.
> 
> Apparently there is more to supporting atomic modesetting than
> providing atomic_(check|commit) callbacks. Before this revert:
> 
> WARNING: [] drivers/gpu/drm/drm_plane.c:389 at .__drm_universal_plane_init+0x13c/0x794 [drm], CPU#1: modprobe/1790
> BUG: Kernel NULL pointer dereference on read at 0x00000000
> .drm_atomic_get_plane_state+0xd4/0x210 [drm] (unreliable)
> .drm_client_modeset_commit_atomic+0xf8/0x338 [drm]
> .drm_client_modeset_commit_locked+0x80/0x260 [drm]
> .drm_client_modeset_commit+0x40/0x7c [drm]
> .__drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0xfc/0x108 [drm_kms_helper]
> .drm_fb_helper_set_par+0x8c/0xb8 [drm_kms_helper]
> .fbcon_init+0x31c/0x618
> [...]
> .__drm_fb_helper_initial_config_and_unlock+0x474/0x7f4 [drm_kms_helper]
> .drm_fbdev_client_hotplug+0xb0/0x120 [drm_client_lib]
> .drm_client_register+0x88/0xe4 [drm]
> .drm_fbdev_client_setup+0x12c/0x19b4 [drm_client_lib]
> .drm_client_setup+0x15c/0x18c [drm_client_lib]
> .nouveau_drm_probe+0x19c/0x268 [nouveau]
> 
> Fixes: 604826acb3f5 ("drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)")
> Reported-by: John Ogness <john.ogness@linutronix.de>
> Closes: https://lore.kernel.org/lkml/87ldhf1prw.fsf@jogness.linutronix.de
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Tested-by: Daniel Palmer <daniel@thingy.jp>
> Link: https://patch.msgid.link/20260130113230.2311221-1-john.ogness@linutronix.de
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_display.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -391,8 +391,6 @@ nouveau_user_framebuffer_create(struct d
>  
>  static const struct drm_mode_config_funcs nouveau_mode_config_funcs = {
>  	.fb_create = nouveau_user_framebuffer_create,
> -	.atomic_commit = drm_atomic_helper_commit,
> -	.atomic_check = drm_atomic_helper_check,
>  };
>  
>  
> 
> 

