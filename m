Return-Path: <stable+bounces-100248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC069EA007
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B68281CC4
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D41993A3;
	Mon,  9 Dec 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVlq6yQZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2791991D8;
	Mon,  9 Dec 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774634; cv=none; b=NzjWLCk2yafqMrFaiSORaU9Yo3vuHMjm1J5zlWm1W+bG4UUSsg19XH22cU7kE5scUQ9selcsI3oY8tETDVgiq/sNVXdrArctx+bhzM5psOPp+CYB0GDA4sM9eoahGJCXNNFRg29yEEL2dZNadHpgDXp/vje+n5l1HAZXZAXD7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774634; c=relaxed/simple;
	bh=zyN+whCZR2q+qXBVeoIQlKB2+tQ1rRz8VvKQdfGJrZ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n2PdD5SmPlpzfgPlJgVD3KtK3Ja4j0UwU25Z2nyEaEMebTjAYK6vuC/Z1ZqWZRFhjPP5U+GEtnopHZ65H6Jptm0++xAF5gtSExCZYwdY9LWIvuFKlKh5HLTY02pM1euqj3AiGAOQz8CuPpKuU03Nmy+1vyPea+DsnpoiaJ4RzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVlq6yQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC77BC4CED1;
	Mon,  9 Dec 2024 20:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733774634;
	bh=zyN+whCZR2q+qXBVeoIQlKB2+tQ1rRz8VvKQdfGJrZ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OVlq6yQZb4/7neuS9sITbvkc8KwO9YE2uk8tNPfY8ySSxVFg1mJmTnuSL+cFo/EMK
	 50pkGrz5+Fqhagvt25E2SX20I80Mzds7IV8FLR/GVJKCO5M8gCU+m1QlL8CZb5+nUo
	 zxL5JX8Y5dnGg51DBvqyjIUd9a/gap1wsDqm9ihy89/ezDEYqRnhCaJcvgLrPVvVCz
	 dGAuOVhDH8oOH1y7O85xFAKGXA99qAUmMqPExle2FrItsUwsqiY9YXFIANQ54X5kCc
	 IdI9vaZUYc/YwHpAt0bJLDPZHYRQ938MvikZMB4eImatiPzrnOXvD9/iTA62MM2bny
	 fWb5v9XeRPEaA==
Date: Mon, 9 Dec 2024 21:03:51 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: He Lugang <helugang@uniontech.com>, stable@vger.kernel.org, 
    regressions@lists.linux.dev, 
    =?ISO-8859-15?Q?Ulrich_M=FCller?= <ulm@gentoo.org>
Subject: Re: [REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works
In-Reply-To: <4p2nlmktrkoeu44yctsyrpr2ofmat3e3knlwudfdcrjwkzr56n@amyl3ad44sxe>
Message-ID: <33n906sr-o01p-01o1-2pp5-13ro9s4qn772@xreary.bet>
References: <uikt4wwpw@gentoo.org> <4p2nlmktrkoeu44yctsyrpr2ofmat3e3knlwudfdcrjwkzr56n@amyl3ad44sxe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 25 Nov 2024, Benjamin Tissoires wrote:

> On Nov 03 2024, Ulrich M=FCller wrote:
> > After upgrading from 6.6.52 to 6.6.58, tapping on the touchpad stopped
> > working. The problem is still present in 6.6.59.
> >=20
> > I see the following in dmesg output; the first line was not there
> > previously:
> >=20
> > [    2.129282] hid-multitouch 0018:27C6:01E0.0001: The byte is not expe=
cted for fixing the report descriptor. It's possible that the touchpad firm=
ware is not suitable for applying the fix. got: 9
> > [    2.137479] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI00=
10:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input10
> > [    2.137680] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI00=
10:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input11
> > [    2.137921] hid-multitouch 0018:27C6:01E0.0001: input,hidraw0: I2C H=
ID v1.00 Mouse [GXTP5140:00 27C6:01E0] on i2c-GXTP5140:00
> >=20
> > Hardware is a Lenovo ThinkPad L15 Gen 4.
> >=20
> > The problem goes away when reverting this commit:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/hid/hid-multitouch.c?id=3D251efae73bd46b097deec4f9986d926813aed7=
44
> >=20
> > See also Gentoo bug report: https://bugs.gentoo.org/942797
>=20
> He Lugang,
>=20
> It's been 3 weeks since this regression was reported and we haven't
> heard back from you. It's clear that the patch mentioned here is too
> gready and needs tuning to only apply to the firmware which needs the
> fix.
>=20
> Could you quickly submit a fix that checks that the device is indeed
> requiring the fix (and thus the class
> MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU) and if not, keep the default class?

Lugang, have you perhaps missed this one?

If we don't hear from you by the end of this week, I'll revert the patch=20
(unless there is someone else who has access to the device and cook up a=20
tested fw-dependent patch).

Thanks,

--=20
Jiri Kosina
SUSE Labs


