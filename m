Return-Path: <stable+bounces-233339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tzo4IePM0mlfbAcAu9opvQ
	(envelope-from <stable+bounces-233339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 22:58:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7E939FD36
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 22:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FA0C30036FA
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B00C2EFD95;
	Sun,  5 Apr 2026 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVtP2J7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957CEEBA;
	Sun,  5 Apr 2026 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775422688; cv=none; b=m2p5XfdN4zA5c05SZ/GWeFSdd2tnfEUs+uQO1PggUXd7aEzbmQPBSmnHuAuu9ddnoyhsl0W8tRrWvLiUXfrK5mgCR+3gmCFhZ5ol63118LjI7MUDjUKEu+zy0b6r+B9WDjnNtX1RjCBf+5Vise8vQv8W28g/8ErHJxMRP9iAjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775422688; c=relaxed/simple;
	bh=X4pa7U4Z2NxX+L6ROgvq0LnbOuhvAbpD0xfBr8V6bVc=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=JH0QVdyxgdLtewfppMzU0cW5nI9haSdhN32Tgmh7NuwUAc6OHZIf/XKL3oe/QdM3yw7DbuRoqLR/NAw0NnUl2DZ8ToYB+vRpAMDRdsNy9Gz8plRkUTBhepGHGz65t3KlFoyGun5n6sD2CYv14QylVx6i/ZMcIaKJ9owQMlSUbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVtP2J7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7F2C116C6;
	Sun,  5 Apr 2026 20:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775422687;
	bh=X4pa7U4Z2NxX+L6ROgvq0LnbOuhvAbpD0xfBr8V6bVc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=BVtP2J7wcoLq1UvrjUuavVdYdY0EpmngSGpmYd2Tr9ia0twvWPiF8NnJc2FqBAzwW
	 qwKZmlhV1UGyqUBMKywmnnCnpuuFLcNT9IlCgCsFSnX58mjE9i85nzmGaYeXtLt034
	 aNML4LqYWkPgUzR1aUVCVT2DyWlFfErGZZk1G4xfyW+TSM2U4snaTgFWFQGElpRG3w
	 bihLfck6yNYzAHVvOuoy7rpyoZLjFa3wT6ucUnFXgWFRYnESEn8qr6SSsuvgVPS7Q3
	 NcUbxCzonz2Qken7ExIYxeW4NO916+ntj4xPnFTpNpQdJNgCUXUiE5fbZO2HiJMPCf
	 UrIQ8RvpVwOcQ==
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 22:58:02 +0200
Message-Id: <DHLITCTY913U.J59JSQOVL0NH@kernel.org>
Subject: Re: [PATCH v4 1/9] driver core: Don't let a device probe until it's
 ready
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>, "Saravana
 Kannan" <saravanak@kernel.org>, "Christoph Hellwig" <hch@lst.de>, "Eric
 Dumazet" <edumazet@google.com>, "Johan Hovold" <johan@kernel.org>, "Leon
 Romanovsky" <leon@kernel.org>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Alexey Kardashevskiy" <aik@ozlabs.ru>,
 "Robin Murphy" <robin.murphy@arm.com>, <stable@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>
To: "Douglas Anderson" <dianders@chromium.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
In-Reply-To: <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233339-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DF7E939FD36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Apr 4, 2026 at 2:04 AM CEST, Douglas Anderson wrote:
> Instead of adding another flag to the bitfields already in "struct
> device", instead add a new "flags" field and use that. This allows us
> to freely change the bit from different thread without holding the
> device lock and without worrying about corrupting nearby bits.

I was just about to pick up this patch series (Greg mentioned to pick it up=
 next
week, but we agreed offlist that I will pick it now, so it gets a few more
cycles in linux-next).

Due to this, taking a second glance at the code, I noticed the below issue.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 09b98f02f559..f07745659de3 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3688,6 +3688,19 @@ int device_add(struct device *dev)
>  		fw_devlink_link_device(dev);
>  	}
> =20
> +	/*
> +	 * The moment the device was linked into the bus's "klist_devices" in
> +	 * bus_add_device() then it's possible that probe could have been
> +	 * attempted in a different thread via userspace loading a driver
> +	 * matching the device. "ready_to_prove" being unset would have
> +	 * blocked those attempts. Now that all of the above initialization has
> +	 * happened, unblock probe. If probe happens through another thread
> +	 * after this point but before bus_probe_device() runs then it's fine.
> +	 * bus_probe_device() -> device_initial_probe() -> __device_attach()
> +	 * will notice (under device_lock) that the device is already bound.
> +	 */
> +	dev_set_ready_to_probe(dev);

By converting this to a bitop, we now avoid races with other bitfields (suc=
h as
dev->can_match), but I think we still need to take the device lock for this=
 one
specifically:

	Task 0 (device_add):		Task 1 (__driver_probe_device):

	dev->fwnode->dev =3D dev;
					device_lock(dev);
	device_lock(dev);               	if (dev_ready_to_probe())
	dev_set_ready_to_probe()			access(fwnode->dev);
	device_unlock(dev);		device_unlock(dev);

Otherwise, nothing prevents the above dev->fwnode->dev =3D dev assignment t=
o be
re-ordered with dev_set_ready_to_probe() and we are back to the problem the
commit attempts to solve in the first place.

(Technically, this could also be solved with explicit memory barriers - her=
e and
below -, but __driver_probe_device() is always called with the device lock =
held,
so just taking the device lock seems *much* simpler. Also, in the absolute
majority of cases the lock should be uncontended in device_add() anyways.)

> +
>  	bus_probe_device(dev);
> =20
>  	/*
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 37c7e54e0e4c..8ec93128ea98 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -848,6 +848,18 @@ static int __driver_probe_device(const struct device=
_driver *drv, struct device
>  	if (dev->driver)
>  		return -EBUSY;
> =20
> +	/*
> +	 * In device_add(), the "struct device" gets linked into the subsystem'=
s
> +	 * list of devices and broadcast to userspace (via uevent) before we're
> +	 * quite ready to probe. Those open pathways to driver probe before
> +	 * we've finished enough of device_add() to reliably support probe.
> +	 * Detect this and tell other pathways to try again later. device_add()
> +	 * itself will also try to probe immediately after setting
> +	 * "ready_to_probe".
> +	 */
> +	if (!dev_ready_to_probe(dev))
> +		return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready to probe\n"=
);
> +
>  	dev->can_match =3D true;

Focused on ordering from the above, I also noticed that this ordering of
dev_ready_to_probe() and dev->can_match =3D true is actually pretty subtle =
and we
should add the following comment.

	/*
	 * Set can_match =3D true after calling dev_ready_to_probe(), so
	 * driver_deferred_probe_add() won't actually add the device to the
	 * deferred probe list when dev_ready_to_probe() returns false.
	 *
	 * When dev_ready_to_probe() returns false, it means that device_add()
	 * will do another probe() attempt for us.
	 */

As it would be nice to land this for v7.1-rc1, I can apply both changes on
apply, i.e. not need to resend AFAIC.

Greg, Rafael: does that work for you?

Thanks,
Danilo

