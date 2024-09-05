Return-Path: <stable+bounces-73147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5961396D0B5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F38B2414B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12FC194A52;
	Thu,  5 Sep 2024 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G53eyoyx"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939E194A4C;
	Thu,  5 Sep 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522415; cv=none; b=JKinRL3884aTSHUFK7ZM9JM5cSzu7jRU0Mngd/DUoVFwz39UqKPeR7n+HplhRbAh8Py/pCOQxoLkQNn9DARsaUmkb9Vl9rHwqqTxZ8a/MN4LJJIDQ77IEO36MuTZLDqCsFT4Bgkyui9SkOfmVPeKiusJNH+XsRFHKcWJcz+q3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522415; c=relaxed/simple;
	bh=QYpU67x17CbfVA21RkvhKE9DGjvoVRNHWWEv4K+vCxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1LFng5y+okSDPBm5dKmxu9jbWC5WpqZiMSNe0PCcOOQmD9M2burulyc0/j27kuajDLW4ML6Hh2U94CSThCifrxnSrCPvAhD+Cvk1WpxXjPq/1eAsBDzku+je/jhWdaXmyb1IN+JcepArHFQwW6OfT8tP6hVDuTC1S8LXn3GToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G53eyoyx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725522385;
	bh=QYpU67x17CbfVA21RkvhKE9DGjvoVRNHWWEv4K+vCxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G53eyoyxWdawLmV4K3e3GIpIf8mKKRJ2JHuum58L5JwXsO4BdxvMHawgE5vRm2qKp
	 1b7l7taULwiBcBsGbqIb9WbJL07MaGyZJ/pYJ9KRW85smE2hlIwV/x5ydr7jpkBmWb
	 1Kiai5tUAWU/isnajhdSvNvWGl/0GfR3vPLO9MM+qsfpNStZPgNgkbli6SwLCjTZ6I
	 rw4KrctsY0RJN33mkAtYeLxeoqGPBK3WK8JO/oOUqeCRdylXDJ8ZAK9Hd2pNn8yJAI
	 OyNH/Xbsg15ZD6qaKuF/Fy0yyPzgrESkF8O1Q20Phy25ChkdWg69itybpr0XAqKjsc
	 3AgtcmYzDAvqw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E6C3B17E0F94;
	Thu,  5 Sep 2024 09:46:24 +0200 (CEST)
Date: Thu, 5 Sep 2024 09:46:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>, Liviu
 Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, Grant
 Likely <grant.likely@linaro.org>, kernel@collabora.com,
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: flush FW AS caches in slow reset path
Message-ID: <20240905094620.5744ace5@collabora.com>
In-Reply-To: <6074ec45-7642-4558-83c5-4c9af7e0543d@arm.com>
References: <20240902130237.3440720-1-adrian.larumbe@collabora.com>
	<6074ec45-7642-4558-83c5-4c9af7e0543d@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sep 2024 16:11:51 +0100
Steven Price <steven.price@arm.com> wrote:

> On 02/09/2024 14:02, Adri=C3=A1n Larumbe wrote:
> > In the off-chance that waiting for the firmware to signal its booted st=
atus
> > timed out in the fast reset path, one must flush the cache lines for the
> > entire FW VM address space before reloading the regions, otherwise stale
> > values eventually lead to a scheduler job timeout.
> >=20
> > Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > Acked-by: Liviu Dudau <liviu.dudau@arm.com> =20
>=20
> Reviewed-by: Steven Price <steven.price@arm.com>

Pushed to drm-misc-fixes.

