Return-Path: <stable+bounces-244627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKQONZjV/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:10:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C44ED3E7
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4CD930252BF
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859E44D6BB;
	Thu,  7 May 2026 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="OSEyMWuN"
X-Original-To: stable@vger.kernel.org
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873A43E9FF;
	Thu,  7 May 2026 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177425; cv=none; b=j8c1QbyqCN83srVdrDZnQRRjclPk3UTtQ+nNHneogTTMi/gNrsVC5KlscehLzZurwBmClOD5iMzCLbvKJ8oRioUGME7jbbDCjvrv5gul8/bYMPOxfLlfIL9NrlAJSIXD7MaeMdRQ922HjT8Wa/c7ssx368b9m8klY91lOHjFbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177425; c=relaxed/simple;
	bh=XlsJSkJu7uGWr4gtKsWIcp2zHFxisuJ0BEEM0g/h9Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly9WhBtLZGtd/FJ7Vq//cYGL9PkxXSuV7cIlwyCzDohAs0pvR/Y9LJaM99QmtRQ6BR3DNwi92ofpH5hPh8tKIhHwP9OrVr+vOAr81FDyOepWybchwyDWoQHhRFlF8J7WePf7f5M/ZotSwl70J0QFHo0RK/U3Y2VkRde/OXtvKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=OSEyMWuN; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 7EBCBD011B;
	Thu, 07 May 2026 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1778177416;
	bh=nY/8STcP17wypLqIMnvcBtkQl5e9XIg9NLgVj+cI2gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OSEyMWuNxVXWFhRzBhkZDTBiz+5TltnQiEp5Uv3+bClIfu2NY4i9G4IT/BwShML1G
	 qRv46qHsvjwY2h+iQ1OOD6RVQ06VSddnN0YKEQXKrQf922XlZEXHFLawKcbTLD66Um
	 numpb/LiBz81Gq7Vs6DYAWpIO69zrYHpkPIjAUVo=
Date: Thu, 7 May 2026 18:10:12 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: mike.marciniszyn@gmail.com
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Mike Marciniszyn <mmarcini@meta.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/fbdev-helper: Fix deletion of stub for
 drm_fb_helper_gem_is_fb()
Message-ID: <afzVhCHu3FTwn9w0@shell.ilvokhin.com>
References: <20260501204313.127616-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501204313.127616-1-mike.marciniszyn@gmail.com>
X-Rspamd-Queue-Id: 8C8C44ED3E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ilvokhin.com,reject];
	R_DKIM_ALLOW(-0.20)[ilvokhin.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244627-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,amd.com,redhat.com,lunn.ch,lists.freedesktop.org,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d@ilvokhin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ilvokhin.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,ilvokhin.com:email,ilvokhin.com:dkim]
X-Rspamd-Action: no action

On Fri, May 01, 2026 at 04:43:13PM -0400, mike.marciniszyn@gmail.com wrote:
> From: Mike Marciniszyn <mmarcini@meta.com>
> 
> When CONFIG_DRM_FBDEV_EMULATION  is not defined this error results
> when building amdgpu_display.c with CONFIG_DRM_AMDGPU:
> 
> error: call to undeclared function 'drm_fb_helper_gem_is_fb'; ISO C99 and
> later do not support implicit function
> declarations [-Wimplicit-function-declaration]
> 
>  1777 |  if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Marciniszyn <mmarcini@meta.com>

Just hit the same problem, thanks for the fix.

Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>

