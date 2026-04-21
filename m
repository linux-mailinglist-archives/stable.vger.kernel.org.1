Return-Path: <stable+bounces-240235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIxkI1bg52mbCAIAu9opvQ
	(envelope-from <stable+bounces-240235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:38:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426E43F852
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93819302C573
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10F3446C7;
	Tue, 21 Apr 2026 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="N+fXdLgZ"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABE31E85A;
	Tue, 21 Apr 2026 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803924; cv=pass; b=qx5cyJBfjPfxltPr8zzBYOLYXWFg7ShmNmonPviMAS7n/YEsnTdYknoOhQee0WFWTtONtsCiiX4fC+mvJuoS3hvaOJKMByGlijXuF3m5MJDTNkDaJPNZ+U+qQ15afCAJHGGD5uBkwir/s/7VhcQPBFwiAuBdgX2z/0yoL+KEfNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803924; c=relaxed/simple;
	bh=SWSSCJwOgAoWwj2cAvgJ2veCwKFOB7SnBnEQQot0VuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Heh3U1xkJIKwSb8t6zupv9TZH0CENKnfrGV6XHdIpKsMIFehTppBtF/qrzLC3ZIbjD8650HH06dWvU6EWWUY7Bbz2oalmUzzMqmGkahATuA04akfl+H/qmgf+cKNQDrMNW28RiSDmvLFi4Yu8uPsURox5PDeFbKY9jPu6wV3Y/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=N+fXdLgZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776803909; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AVEISuzOkBmF5InESuJzBYA7sp+mdStgApOzWWkQIFjEb2QGMok0zhb9xYKa1JrrGZRUwAjnIPHCCAoWaK/Sk6zpnb13A24FAIkO6B8aBFs2sekIcpXYdPDGqI6IfdohsvVARmudOFDT8pSWQhhjT6jY0EwXIE/bPiZJpCf/pU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776803909; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HSh/B2iUj0iq/8dGADJDwgRxvcXnfJwJ0DwKuc/4DVA=; 
	b=QJefDIkZEoBGXFV7QnX65lpg+Am9Ut9jOoASz/guT7wma5gxiZaXH+LSoqCLA+io86DnkP3OnVFW0RBjAufvIhhTBr4/2B3CvkFajy+iE6kfah+SCF/41v2RXTqwgm9N2MVpleZAw9H/xvPl1XGYKsY3aL+xfXJu0ukp4mFYwoo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776803908;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=HSh/B2iUj0iq/8dGADJDwgRxvcXnfJwJ0DwKuc/4DVA=;
	b=N+fXdLgZWvNOtow91JjzhnuE74T59mdwR/JiTC+zaJlQfxxchNSJDbAjYsV9nYU/
	LXxJQIbI414tl9JHY4Nby1d9W3WIt9HhQaudTZUJ4tVTjdg3hfPSXy1Dm6nMgaN6Zqi
	uOQ1J8n/CA0pD2gL0F+rAV/1wHdDtq1swoe2rOKw=
Received: by mx.zohomail.com with SMTPS id 1776803907231125.60155997936374;
	Tue, 21 Apr 2026 13:38:27 -0700 (PDT)
Date: Tue, 21 Apr 2026 21:38:20 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Steven Price <steven.price@arm.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/panfrost: Fix wait_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
Message-ID: <aefgJ5eR3MXTO5Qf@sobremesa>
References: <cover.1776581974.git.gye976@gmail.com>
 <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-240235-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[collabora.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.larumbe@collabora.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,collabora.com,kernel.org,arm.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:dkim,collabora.com:email]
X-Rspamd-Queue-Id: 3426E43F852
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 19.04.2026 16:17, Gyeyoung Baek wrote:
> dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
> on success, 0 on timeout, and -errno on failure.
>
> panfrost_ioctl_wait_bo() returns this 'long' result from an int-typed
> ioctl handler, so positive values reach userspace as bogus errors.
> Explicitly set ret to 0 on the success path.
>
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 3d0bdba2a..784e36d72 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -390,6 +390,8 @@ panfrost_ioctl_wait_bo(struct drm_device *dev, void *data,
>  				    true, timeout);
>  	if (!ret)
>  		ret = timeout ? -ETIMEDOUT : -EBUSY;
> +	else if (ret > 0)
> +		ret = 0;
>
>  	drm_gem_object_put(gem_obj);
>
> --
> 2.43.0

