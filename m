Return-Path: <stable+bounces-189217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13177C05250
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53511884576
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E72D640D;
	Fri, 24 Oct 2025 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aio7QwG9"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C943093A5;
	Fri, 24 Oct 2025 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295519; cv=none; b=n2TAf/tFNpCVcFfOVJgcC2khtipz70GFnDyaz6zQ6+u5NK+6z4/MT3bi8ZQFAwOW6SDA+/U5M9ePMW8jps9bytUHoGWJA44LBD6OwkEMeErkqLVoWWBbdR6cgrMeLi/MtVTDm7Zg34DKmlh1O4AqeAhXX6It9kYAUjc2u5HYwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295519; c=relaxed/simple;
	bh=XVE8HS8pLPjAPFJWJXLAavH7lu4ZWWXTbIrG9J2oUhE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SpYNpoxWRhhRTuzbP2yJtMow214hRB61F0XMhb1SId715iiHrToIPhbUobkG01i8nXr5fRGw7BxX8wXyqZwI95MqXyb3z/4g2gZlwJZYsff9mybzBXTcknz512edjRnKXBHxiMouFlaNvkKH5FoEpD3OdEJDmdPLnTqve/S3QbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aio7QwG9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SckvzvtqAlVsB0xWL+sj9UnbS0aJYxJfJMb2wF6gvDk=;
	t=1761295518; x=1762505118; b=aio7QwG9zCvffTBk4RsAccSxMtUz3VFi1poFntmD8cWeJaf
	AcNz4BhQaBRtLjyuaA7Abo4BVS/e0paYzNmhv/lwOMuhwbDV1cy/Wc1dfM4kEsu0Y2hkgo12B5on3
	ofcNaxmuPleIwifqqFndcDQru4xG9GGfu2N1DtF4TslrKTQRdJunhJIintT4dM+7kYfi2wjT2dKtt
	yx7sF0XZIp5sObkYDm0lRHv7nRsiCMcovY/VbIF7zRr8TqKNtE3hYNqqRbSMqkiAb0ad8kCzpNhJK
	Ut1HlxVx5I156QoRVuxOcq/Y6zExSzbvc6S7iVvciDjd8zwGu92USgnfqUO3P0cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vCCuK-00000002NRR-1tjW;
	Fri, 24 Oct 2025 10:12:20 +0200
Message-ID: <e683355a9a9f700d98ae0a057063a975bb11fadc.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: Fix circular locking dependency with
 devcd->mutex.
From: Johannes Berg <johannes@sipsolutions.net>
To: Maarten Lankhorst <dev@lankhorst.se>, linux-kernel@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org, Mukesh Ojha <quic_mojha@quicinc.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich	 <dakr@kernel.org>,
 stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>
Date: Fri, 24 Oct 2025 10:12:19 +0200
In-Reply-To: <20250723142416.1020423-1-dev@lankhorst.se>
References: <20250723142416.1020423-1-dev@lankhorst.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-07-23 at 16:24 +0200, Maarten Lankhorst wrote:
>=20
> +static void __devcd_del(struct devcd_entry *devcd)
> +{
> +	devcd->deleted =3D true;
> +	device_del(&devcd->devcd_dev);
> +	put_device(&devcd->devcd_dev);
> +}
> +
>  static void devcd_del(struct work_struct *wk)
>  {
>  	struct devcd_entry *devcd;
> +	bool init_completed;
> =20
>  	devcd =3D container_of(wk, struct devcd_entry, del_wk.work);
> =20
> -	device_del(&devcd->devcd_dev);
> -	put_device(&devcd->devcd_dev);
> +	/* devcd->mutex serializes against dev_coredumpm_timeout */
> +	mutex_lock(&devcd->mutex);
> +	init_completed =3D devcd->init_completed;
> +	mutex_unlock(&devcd->mutex);
> +
> +	if (init_completed)
> +		__devcd_del(devcd);

I'm not sure I understand this completely right now. I think you pull
this out of the mutex because otherwise the unlock could/would be UAF,
right?

But also we have this:

> @@ -151,11 +160,21 @@ static int devcd_free(struct device *dev, void *dat=
a)
>  {
>  	struct devcd_entry *devcd =3D dev_to_devcd(dev);
> =20
> +	/*
> +	 * To prevent a race with devcd_data_write(), disable work and
> +	 * complete manually instead.
> +	 *
> +	 * We cannot rely on the return value of
> +	 * disable_delayed_work_sync() here, because it might be in the
> +	 * middle of a cancel_delayed_work + schedule_delayed_work pair.
> +	 *
> +	 * devcd->mutex here guards against multiple parallel invocations
> +	 * of devcd_free().
> +	 */
> +	disable_delayed_work_sync(&devcd->del_wk);
>  	mutex_lock(&devcd->mutex);
> -	if (!devcd->delete_work)
> -		devcd->delete_work =3D true;
> -
> -	flush_delayed_work(&devcd->del_wk);
> +	if (!devcd->deleted)
> +		__devcd_del(devcd);
>  	mutex_unlock(&devcd->mutex);

^^^^

Which I _think_ is probably OK because devcd_free is only called with an
extra reference held (for each/find device.)

But ... doesn't that then still have unbalanced calls to __devcd_del()
and thus device_del()/put_device()?

CPU 0				CPU 1

dev_coredump_put()		devcd_del()
 -> devcd_free()
   -> locked
     -> !deleted
     -> __devcd_del()
				-> __devcd_del()

no?

johannes

