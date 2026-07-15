Return-Path: <stable+bounces-274750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nBtjKKQzV2o6HQEAu9opvQ
	(envelope-from <stable+bounces-274750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:15:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0292D75B5AF
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=Toa4B1qb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274750-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274750-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8C3D3078311
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 07:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4693932D0D4;
	Wed, 15 Jul 2026 07:13:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5C377A82;
	Wed, 15 Jul 2026 07:13:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099634; cv=none; b=LlWhYfKbtr231rdOUi9WMOc9VumXKTkqMQsSmSuq9SRbY6dAnyAXPCVvaFY2FuZV+0qYQ3Rv2FdMnY1tlh/egz230644N2oXhhyx1ECeifzjVfohoVfALB3VH3jqLifUT0u3nwOzDGhh7fBytJ4hD+NTfdjpsfYP7x/M6xQKB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099634; c=relaxed/simple;
	bh=pZa09brkd10z0oCV2TZgsc4riiw/UWtjrPZPAyM989Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMiOo79h+BIRDWScebbJpb/BrK/LTlbgbWmAaptoSHGAAoFxoTbwsHcmtlwEQk9Gr/h1t5Ut3ZqVtC5Ln7An/yPfEONR0j3+GTC5Xgfj3bJxhpAl4HRh8NNJNzIhl77LQ3OHs7VY9iNcd+p6tPdBME6iteBGYGx3KBMw6lzFF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Toa4B1qb; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784099623;
	bh=pZa09brkd10z0oCV2TZgsc4riiw/UWtjrPZPAyM989Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Toa4B1qbr4LtURg6wVyLmoFj1Qmtt9V0gr8pDUkw7yeSTbn6PX3geR3OGu3zBwUSE
	 kwbcY0Kn1JVt2yT9K21cKxNQArjeZgMvIZxxmL1HjVt451Jd0lEs0E+a6h4Q2lDGQQ
	 MzZX2ShMU4fz4rtFlFZjZm6GsKsushHtoLabkKC/Vhn1dT7rNeP8gxTom1H0n+OtMI
	 XCQAiY+j5QwSUb+mbVcOOauTl0p+NfJrf38Zwx6yyKB7eUmWhQ5N+6ybY2PatPDLiG
	 bzO21tH4a72Db8bIkpwXLJojUWbz2BFkQj4TBKg9XPHb5FsEoKJtAFkqgAsq8CA6KW
	 e39fs6ayy+InA==
Received: from fedora-2.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CBF0B17E071A;
	Wed, 15 Jul 2026 09:13:42 +0200 (CEST)
Date: Wed, 15 Jul 2026 09:13:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: return error on truncated firmware
Message-ID: <20260715091338.537b6ff8@fedora-2.home>
In-Reply-To: <20260714163056.22329-1-osama.abdelkader@gmail.com>
References: <20260714163056.22329-1-osama.abdelkader@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:osama.abdelkader@gmail.com,m:steven.price@arm.com,m:liviu.dudau@arm.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:heiko@sntech.de,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:osamaabdelkader@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274750-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[boris.brezillon@collabora.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,sntech.de,lists.freedesktop.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fedora-2.home:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:email,collabora.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0292D75B5AF

On Tue, 14 Jul 2026 18:30:55 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> panthor_fw_load() detects truncated firmware images, but jumps to the
> common cleanup path without setting ret. If no previous error was recorded,
> the function can return 0 and treat the invalid firmware as successfully
> loaded.
> 
> Set ret to -EINVAL before leaving the truncated-image path.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 986151681b24..39fff094ebb5 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -829,6 +829,7 @@ static int panthor_fw_load(struct panthor_device *ptdev)
>  	}
>  
>  	if (hdr.size > iter.size) {
> +		ret = -EINVAL;
>  		drm_err(&ptdev->base, "Firmware image is truncated\n");
>  		goto out;
>  	}


