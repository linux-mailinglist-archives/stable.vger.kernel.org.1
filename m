Return-Path: <stable+bounces-104284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE719F24B5
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 17:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A5418854B6
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C7191473;
	Sun, 15 Dec 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Aky+lveZ"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23A189912;
	Sun, 15 Dec 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734278685; cv=none; b=SKC4LUSziaWuDk3Px+6vaypZQuZEWFkWZnfeZNUPxmJ1PpsFAsBt4kekktlJ55jBRoe41v8yM8To1yEvAIzmTcGG36FoFOvLnvHwjknCI8YbdNOy7ZTuChjIQR4R7gQwpX0oksQzoEAchyYgSYNJfERg/8ntpguMr9FyYRiZD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734278685; c=relaxed/simple;
	bh=lG3oa76h+CM7R0sveI4lJVV207XxC/3DQZgSOboWY7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJU13xfqphL9IzG7DM/F/NI70kAe9Ic6KaXJoQMSxSjYLFSjU86MEx08K9R8NGlb3Ss5XwTskvj4vSYqTMrY3BxvA6jUhFrSDkakdfam+LPgqg3hP7mnYACHI4RjzZC56LbnFnv98lO/ECl4Sz6SZgveusO2vhPBLx/MJD30Qo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Aky+lveZ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734278676; x=1734883476; i=deller@gmx.de;
	bh=g4BgLYlQJWV0uClMLmCWbIXGgt3L/2H1UTwttrn3fes=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Aky+lveZeflozekH7N0gn8x53/Zshr5bUVAFzmSCaD7wfvgJdQLd+Ugusl50sGe5
	 uoPz3ZYandsZ+29k1sSXq5BIF4uKp60B8h2sTx3sYw/lk3TjUMvCDvE+tk0LnNe39
	 g8o0hNA9lDI8r3SSFt5hfzOFkY3/E0UTo1KJhwSZvIu6v+7AEKsBR3dLXtRzHDQQs
	 JkDp18QD9tzye2riMQZX+c782Eb8WjxK3+zUDOzLlGF38saLNINw6HqbFI2OgEsTr
	 tK9xC6Ge+CmEuHuGPDz8ab4fWAO1uH36jSLKgdI29+DUHJfKxOBwvBpoFVZMuZmM+
	 oAuU7QXXypjzLswRjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1tyKez1ag5-00pqPd; Sun, 15
 Dec 2024 17:04:36 +0100
Message-ID: <5c806fca-9081-4b67-ae6c-1a2c47869177@gmx.de>
Date: Sun, 15 Dec 2024 17:04:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/udlfb: Remove world-writability from EDID attribute
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Bernie Thompson <bernie@plugable.com>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241215-udlfb-perms-v1-1-2d1f8c96b1ab@weissschuh.net>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241215-udlfb-perms-v1-1-2d1f8c96b1ab@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pN7hPfaqEPivIMyJfEePKwVnDDcEneG/sTdxsCZSey0tY3uyyBh
 v0K6HzuBQ6fTLyIJ3WoIhzPIuvpez4qre3Wa3DaWaDDZ4S1pJvfLPngwfRjXihHL3eUsfmw
 L9FAbGWlMtb7PcvhB2ab5yd3BWF4BU+2zOQQIqaG4Zq5LO4oJ4gGB3i+YuAaN+Jk58FtS2p
 9KE1aADajPLEr3oS/nwjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2WZfOk496HI=;IS8oNBDis3gWh52kXcPVKfpoX6L
 PRTND+/zemu2SpX+OaAbU8N0S9wjlIS/COIdWo1+xOcdGf6+0/t8PbbdfSr7hmaqF27MhZzuT
 c7F1avRkbil//J6+Jao43ImGsOzmgwxsdiNWXjt6hIrgQFKSnCI79DUgnFSWuEMPHAgfxFMK2
 RmKC9mMobmDY1MPSX8s3Ype1wNjt69HtnPWZeKJofrdFJwhdqmzye++wJ8ddrlH6vQ1oAGBx/
 j8uy1TpVxud+Ug7W4q44ttYemuoFLT3so6pi103UOmCigtXWeARz3gsyfy2V+9L9L8yk2qCfm
 ydbjM89w9v1MBuCwPhYx3hN1o0Sjiqm8cAoCUewQd17QqQxNowgBJPGIp8NBJkqWf9RTGc9TT
 41oNnGg0Pn8Nwbbh4lhedGBsYG8jjsTn5RJpznq2R+55Sbpv8tpB/1L584sziyNuMkPn4znHL
 uNBIB6VWfvh4kIC+/M1AwUqACAt/IJnUK7kBW9Z1dY5mFltz0xWd3BM9o+lqXv6+AUkF22+IZ
 PIoV5VNjeYPOxlwQ8d5WgwJv5fagQzpl0x7HBEV0yZeSfum14jaHnQ4SNhkzbpFH2/r+dNIJI
 NAV3xwbjSCoz5t2A4UMu83LT21oFmtlfH8xpxn5EuDnirE53XqB8AMwhqokwYdleeMmccYNNS
 iJHRaroy29zmoO14m8+ktI9LbxxS8XsliANbAbQHXw+zRHQJzVbnTVeksZ72v102x2RTWiKLT
 z+8WBPs/2XaT4EYYBPSOkboV0S1AElruxE0IE/tfG/7Li5aTK1r0rg3hpBa7Ie+MxIfas/MlK
 uAktrv85tllxLfZ1VWGJIJxebvC4+9IVmAB1JJhH9uvujXvs196HcGdLUhI+X1gMoMfX480J7
 T/bJkeQdqBIZTL3ES0Zfu81I8mKdCyroI7/bVt3mAVUPoPKyuVotYW6es8wwNhGwjf12/j8Ng
 voa+7x7gh6WC3x4cyCYKuc3oxYN8ronXpELh5C1ZLlITbvvPSbJpXsoTu5sb+oOJMFmo3HTxQ
 gZoOkQSfJRfy+bFsyZyf6u1mEVJvUt/HiC7XlV4ubOJ82ztPucAluWRrbPfCrb/GknqIghRIv
 MugKJGcyQlck41mLillj6wmeg8m2J8

On 12/15/24 16:15, Thomas Wei=C3=9Fschuh wrote:
> It should not be possible for every user to override the EDID.
> Limit it to the system administrator.
>
> Fixes: 8ef8cc4fca4a ("staging: udlfb: support for writing backup EDID to=
 sysfs file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> The EDID passed through sysfs is only used as a fallback if the hardware
> does not provide one. To me it still feels incorrect to have this
> world-writable.

I'm wondering if there is any real danger to the system integrity if
a user writes an own EDID (or a broken one)?
I mean, the only reason to use an own EDID is if you are a desktop user,
and then you usually are not a root user.
So, user-writeable *seems* safe to me, especially since the provided EDID =
is only
used if a real one isn't provided by the monitor.

Maybe Bernie has an opinion here?

Helge



> ---
>   drivers/video/fbdev/udlfb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index 71ac9e36f67c68aa7a54dce32323047a2a9a48bf..391bdb71197549caa839d862=
f0ce7456dc7bf9ec 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1480,7 +1480,7 @@ static ssize_t metrics_reset_store(struct device *=
fbdev,
>
>   static const struct bin_attribute edid_attr =3D {
>   	.attr.name =3D "edid",
> -	.attr.mode =3D 0666,
> +	.attr.mode =3D 0644,
>   	.size =3D EDID_LENGTH,
>   	.read =3D edid_show,
>   	.write =3D edid_store
>
> ---
> base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
> change-id: 20241215-udlfb-perms-bb6ed270facf
>
> Best regards,


