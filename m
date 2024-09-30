Return-Path: <stable+bounces-78225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C63989AEB
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A8B1C21080
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116C6537FF;
	Mon, 30 Sep 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJcV2AAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134C29CE8;
	Mon, 30 Sep 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679721; cv=none; b=P8vwdf4BKvMwtRGGvXC63JIy59FDbJY6+ZeFEfgwH2Wcz6d4z6UdgKNwu25w+IwFT/vDnZx90IJouj/lL+qbLoOjd3cbCqXmYuy+5n2dvkIDpSFE3a5kOwV+LHc9/cUoVQm+3JpbTc4MUnUJVvZQK6qyJBd/KZ8fmyBscEdAMFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679721; c=relaxed/simple;
	bh=6n9L0YXWQusPKz6NECqA/T9C7TGOjPEUN7og8vjWtFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKXbwCKjpK8oB1M6UVv8XmtEYWbX91OAe5/HPsvEBC4OIn6DGVVmZVAlB5F6hpotXtE0zPxT4IZPdbMnqrgtL5lCuoTk8jFhliitjRp01ULI1n5USdIM8FWw0K5A4dCuo/ULsxsVachkR4k94hKiY+oFiPRDYR8d6PeUxYqNtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJcV2AAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AA9C4CEC7;
	Mon, 30 Sep 2024 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727679721;
	bh=6n9L0YXWQusPKz6NECqA/T9C7TGOjPEUN7og8vjWtFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJcV2AAIFfkRyYEqQyuHPopdXmaaiJEDPW42vTQT5ddmhhEL/CsoN1QjOEfkf8v2+
	 SC8e34+zHgTkTIs2PwxrpGzwRhn08+AaLKj2MebQ57HuZId2bcgAQA0NwdtLGGYqXx
	 b3wApPV6JKqISdN/xRSXn5uWIB8CtmLn+Ov4QZbYAYOgztGt7CLAlVbPCkqO32xd5P
	 PA4sGbK4C+3KWu+UxUmsIjAvzXfK3+/p7RQQuD4TS1m+RFwWuXUOOGnPJKl/2yE/cc
	 t351w/lGCU+6pYuh9yXKwgTH21L4bs8RIhyGeibTvMvqppLqc0ckgCzafZEuS3FyxV
	 OmwmdszOYNT7g==
Date: Mon, 30 Sep 2024 09:01:58 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sean Paul <seanpaul@chromium.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/atomic_helper: Add missing NULL check for
 drm_plane_helper_funcs.atomic_update
Message-ID: <htfplghwrowt4oihykcj53orgaeudo7a664ysyybint2oib3u5@lcyhfss3nyja>
References: <20240927204616.697467-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="6jrx2cqnw65dpsgi"
Content-Disposition: inline
In-Reply-To: <20240927204616.697467-1-lyude@redhat.com>


--6jrx2cqnw65dpsgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 27, 2024 at 04:46:16PM GMT, Lyude Paul wrote:
> Something I discovered while writing rvkms since some versions of the
> driver didn't have a filled out atomic_update function - we mention that
> this callback is "optional", but we don't actually check whether it's NULL
> or not before calling it. As a result, we'll segfault if it's not filled
> in.
>=20
>   rvkms rvkms.0: [drm:drm_atomic_helper_commit_modeset_disables] modeset =
on [ENCODER:36:Virtual-36]
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   PGD 0 P4D 0
>   Oops: Oops: 0010 [#1] PREEMPT SMP NOPTI
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240813-=
1.fc40 08/13/2024
>   RIP: 0010:0x0
>=20
> So, let's fix that.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: c2fcd274bce5 ("drm: Add atomic/plane helpers")
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.19+

So we had kind of a similar argument with drm_connector_init early this
year, but I do agree we shouldn't fault if we're missing a callback.

I do wonder how we can implement a plane without atomic_update though?
Do we have drivers in such a case?

If not, a better solution would be to make it mandatory and check it
when registering.

Maxime

--6jrx2cqnw65dpsgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZvpM4AAKCRAnX84Zoj2+
dqTlAYD4AtscFOtZMzUGk6+RMPPzgXq4zWG8oSD8cPPWsXpi5gVkTJUYfc7l9Jr4
nyFWgXYBfiLiv68qoFP1mSgHPoh7oI7J9xfP/VZ5hIo8nOfGie/EctK0ARVasiu2
kSU7UayY0Q==
=CpsN
-----END PGP SIGNATURE-----

--6jrx2cqnw65dpsgi--

