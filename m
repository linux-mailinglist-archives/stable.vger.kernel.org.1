Return-Path: <stable+bounces-227135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOfWDpbvumkBdQIAu9opvQ
	(envelope-from <stable+bounces-227135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:31:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8392C14DD
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D037F30C78F9
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF13CB2C9;
	Wed, 18 Mar 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y96hdK+F"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDBE265298
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857987; cv=pass; b=KbNKmnSwsvWNjhUHiEFIZKZfR8wg53LgNTgwMPPOWVMHjiHg/FpD4KVmxLdggxYrQANv7bjAKZV9nHRSAxV3mhxRJSL0QjES6Hr9DuHa1w58oyVCwKqU+7oJDo/SzAV3pz11RANDU/2CDpCzYnLAZjCNvXrXGmeyUCqi5Mhf+2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857987; c=relaxed/simple;
	bh=PoIXV/SEiAxyp3zTzsVrIIEiDO8ISD+QIm/nqSAV+Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kdx0r0mVGt7dTgJNPwb2X3zY4tgDTMZFKb2ShlfxBXfxpGzZW9RM9tQKxKTgjLnA+GodJhNmT+v20bDdPz1VFp4KOfeU/uT1PPT8M65wfpoPQrZ4aLkkpXUO0CiBsV6Jv5cQ56DV9dLinyff3lLyEN1ce8HNCuvYhfEICIau90E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y96hdK+F; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38be66a9fc0so1349891fa.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 11:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773857983; cv=none;
        d=google.com; s=arc-20240605;
        b=eZ8+bGVKsSHvLTcMuJI0G2QUhSpSvqH97PBE6y+d/MgTud6ifCsSMI1dB6xhFfJZj9
         ua7mMp8AjSk5IDqvTW+DDW0vCMzUYiMD048C/XNoKDYAtY6gCD0iaEipnfi0pEdokJaU
         5Yg8iwaMURqTaCpOr4Wqp0JqzvQKxKzNDKXnrc9d25f4Iz7E5MLOuggsXZhUNQ2hz5eK
         v+dy569p1MXpMITOf1VEcO+SJGJo6HfIGNhOuH4iVVxOWYOsyTZ5y7dTgvthXDquztTX
         PnujcU3ArECgraOEI/YKQV6g/+/vVSXj/7Qcy+MbzwLDfV2Ocx/IadpHJpRqkOuhaNc7
         n33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sh96NpHK/Gnjs5OHX/qQC171dH+qdnnnJqOoacHs10U=;
        fh=/pQcJhsYd/r2qzbGG47Xdf6NM73Kdib+H16k/J2BBSM=;
        b=Smf8e+LYmg1uDfwMjdoIixSByqKMgmed4AWgC3QuJpo0ED7gz5npI6Ry6W0wukNtzP
         fmTGcP4Q/RKS+hPHove6Tyh9k/ONnk1IrI3V0uOw3tHu6cTiKZmPpTl1raxHU8Ny3siD
         YJGcYhHFxcSP8NViKIs5eupDdTj0TziANhNtieX6o6y+6mBkYeskiXrxQbeNshA4d1Uu
         fZIdjhnlf6fJVEbfDlAx36cktQ3pe30Xw1PNJKa8V3ycJUPi5UKvZoWp8pozZeIOPBkr
         AN3yWNoP1pfSHIKOjHuwc0/Siur7Ss7AMRLm88Z25KtgcsdG8voTNM/dgFYg140mQaIF
         UpHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773857983; x=1774462783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh96NpHK/Gnjs5OHX/qQC171dH+qdnnnJqOoacHs10U=;
        b=Y96hdK+FmAMlEguDsq60cO/prB51d1xrWEArIEKHPkIV50nXwLtM8FbY8WihgQ0Nj7
         xBP2uD6sHDL4C+6XSE+ES4opC2alwuORuSA5EOa1vLg2PrVgILFoUCAUzoizCueQsIGv
         oSAQMHV3EJzTPVN8uHTQ7OWx5wzM+tjfHp0dI1TFTbx5aLa+cFaZKDLJsrhMxOKeVrsK
         YU58d8qALA2cF5Hxs8cb7NnCAiPNgKvwA3mwu0ZsboAu9dC7jW0CBvXAH5b3v7nKmU5R
         VTSoSTi0I5JUGXe/qKvruwBy2oViRPbCWmOotU9FzAccAgBlxb4JOHnPwQk2u+m7Rdx+
         tWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773857983; x=1774462783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sh96NpHK/Gnjs5OHX/qQC171dH+qdnnnJqOoacHs10U=;
        b=RiHD2kn1hEYKdDfWOzl+hs1piW/MpEJXEbqXUN0TqSG9Syrc2kZcU2hUndZdCbL8Nh
         kXDvF80WmsYdSWZXuTi2EHyOEkc9p2Am/Tsa7JGcdKCkidlvyFMB/m/8HEpMJNZzkzX1
         wuO1z7WaCriFWweDiijZe5xI6b5d6JTUXeq8NejwnIlBBbpwjEgcipPpGO2L2T8thCWU
         W5Cy9E23XJasjD5JwhGSKZDcSwJFoNHTplVqPmgS+oAtROPtlEDZ28lQMEraV8kPivCo
         BLmQqCvKJQj80/y8w7GlBMtjF4ypLdzZvcBfaURdPSOtnHC5WJxAe08g2o8ArqkLPZwm
         +a6A==
X-Forwarded-Encrypted: i=1; AJvYcCXW7kDh9unbLyTyUtgMX17JLK8LVuAXEGuxLQbYskCxnzsG7uJxlDHjTRQZ+jLaP/VZ29VoDGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFypfMlLo3g7Rof1zLNjqpot1PhqUJBp9drP3F350dJZsLpGq
	pEgJ4x9/BsdT/uS+RabiQqESDmiNegMi40gWIefc1yErdrJuN3zxiJfNigPsPOUWShyxQZbLXAa
	BFOgpe9qNCB+ptBjjU4kwRiqO3x2Nfrz392GOFdnufw==
X-Gm-Gg: ATEYQzw5a1JAI2cUwImnhmeZD6iDcNKntyoBERrZVH0IfImWqiVQvp8CgxrmlyTy3Oc
	eL/pGd5/1xyCQZBVifGAnwb0kr029wdMcCgjSASQlUsQgqUoV6X+sBn70o/M8FKUiX0kOLuNxw1
	lbn1WzHJR8aPT8MYCbktF0L8pz/g4IjOx61jJNKVjRWGVR/Poay/GbJouzQBa5OkxLidmTOxm9K
	x7rROfKAjMt2+cnY4MjHKr7GhRJce+xWRqsJouvuDvPLpo2IWyW2PpcJGRWdwXsy2xbSEwjcrV0
	VIMQU8dU
X-Received: by 2002:a05:651c:b23:b0:383:31cb:e3ae with SMTP id
 38308e7fff4ca-38bd57b7f5cmr17915201fa.9.1773857982777; Wed, 18 Mar 2026
 11:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com> <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
In-Reply-To: <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Mar 2026 19:19:06 +0100
X-Gm-Features: AaiRm510MvoJuvyX_yjMZMwW_dgWQm9TQabqsR1tmMTEGls5Ev4rqc21mGQKDYQ
Message-ID: <CAPDyKFrBazYFcWxMOrmMThuatqrAq0kFG8nnYi8xQ2OJg3LeXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: bcm: bcm2835-power: Increase ASB control timeout
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Rob Herring <robh@kernel.org>, kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227135-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmx.net,kernel.org,igalia.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.976];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:dkim,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF8392C14DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 at 23:42, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> The bcm2835_asb_control() function uses a tight polling loop to wait
> for the ASB bridge to acknowledge a request. During intensive workloads,
> this handshake intermittently fails for V3D's master ASB on BCM2711,
> resulting in "Failed to disable ASB master for v3d" errors during
> runtime PM suspend. As a consequence, the failed power-off leaves V3D in
> a broken state, leading to bus faults or system hangs on later accesses.
>
> As the timeout is insufficient in some scenarios, increase the polling
> timeout from 1us to 5us, which is still negligible in the context of a
> power domain transition. Also, replace the open-coded ktime_get_ns()/
> cpu_relax() polling loop with readl_poll_timeout_atomic().
>
> Cc: stable@vger.kernel.org
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains=
 under a new binding.")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Applied for fixes and by re-adding Stefans's reviewed-by tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index 0450202bbee2513c9116a36abaa839b460550935..eee87a3005325848547ce1f5f=
d729b168a641460 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -9,6 +9,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/mfd/bcm2835-pm.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -153,7 +154,6 @@ struct bcm2835_power {
>  static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, boo=
l enable)
>  {
>         void __iomem *base =3D power->asb;
> -       u64 start;
>         u32 val;
>
>         switch (reg) {
> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power *=
power, u32 reg, bool enable
>                 break;
>         }
>
> -       start =3D ktime_get_ns();
> -
>         /* Enable the module's async AXI bridges. */
>         if (enable) {
>                 val =3D readl(base + reg) & ~ASB_REQ_STOP;
> @@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>         }
>         writel(PM_PASSWORD | val, base + reg);
>
> -       while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
> -               cpu_relax();
> -               if (ktime_get_ns() - start >=3D 1000)
> -                       return -ETIMEDOUT;
> -       }
> +       if (readl_poll_timeout_atomic(base + reg, val,
> +                                     !!(val & ASB_ACK) !=3D enable, 0, 5=
))
> +               return -ETIMEDOUT;
>
>         return 0;
>  }
>
> --
> 2.53.0
>
>

