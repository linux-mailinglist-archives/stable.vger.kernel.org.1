Return-Path: <stable+bounces-227063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GgWImCkummyZwIAu9opvQ
	(envelope-from <stable+bounces-227063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:10:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05E2BBF79
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EFF31255C8
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57A3D6CD1;
	Wed, 18 Mar 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpIgNrQX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87B3B7B76
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839236; cv=pass; b=M6J95jZlVF54NH1gBQ9sdWcIbX6Joloa2mbXc6Fw0clmbvYyIcboWI+DQghfQuQBsKj1vUf4Paknb3ceEzlzYsoK82RewWgLd4ttTnultC4kLqXq6yDFcMdVSGa6KnJkGhNXYTahX6qN2i//NwxqKEjh3WGuCiplJqRNB03WjlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839236; c=relaxed/simple;
	bh=lt+ywfAaR1Vf4CU8mDfXb4qsSFqZ/g0PCAg3+I2clZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfKaBJaujhhlViQYVJGegVNsampuviseh4WMcOKKvkU3T447+8zjXjMQ2MIoogZcMBEHhSZ7y7FVvtspXHJvnyQuJj1C4S8vtj+FLS86oWO+ED29mlTPddgKRymuFUewh7xKjlPN7kD/9FSDpB3MRZJvZ+MpFKcRAtnBvsnZxBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpIgNrQX; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38bdb4b8e66so4232491fa.2
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 06:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773839233; cv=none;
        d=google.com; s=arc-20240605;
        b=PebJ4v4QLEOzrQ1aXY7knzA1hd7tbe9dWP5+jkPHNfgnNfXy+X8t2p+KBSlfgEXnRC
         X54BjN8P459xXxDVPTe8HP/E1FWUSToKRX9oSkR0+CWmdSYm74l1QGEenYOKz97lxxZt
         4hpgbIk+cXeODv0MUAJExf9colKeSiMqDEqQOmyXNOz5rHQgkUC4UmzzgqIsNoDWW/cL
         KvnsVxtGHU08wVq1MvmLBYF9A5ZL4eBWdhPNmAqYspoYuzv4WShLPAAma+pe98uuTjPC
         4xQTdp6WZiCEoRAJ6wPIbBrrrrWRKfLh3XhkoyFJsYZsq6J+Y5zlJbqB4H/T67txNDjA
         FsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ns2P3ggM46Yr88OF2vB1ZSaRsJzPAmjjEjQot/+oNY0=;
        fh=4R9XGlX5jZQpnEWHtJ1i77pC7bgKoaMKO/FxCDS9jL4=;
        b=D45YdZ729dgaNUIaybI8nA3ZpgMi6XSJc81PvIl75fLzNpKpkQxeQyow6E04q4b8G/
         MPhI+fBcbvJ0Q86VaSIb7Dl4tVzHhw6FR/QAs9Dos4ES9HBapIfOkWw2plCVCDWx2ujK
         xMUDCfGkTHnDsBnvdlsxlDBYH8srLhm6AqEZSDBJ9gsd3zWIZ+3+tf3SKLUhxbGFGtp9
         ttrOSp8sZgyk/MNppr9fMrX0GJ1k528HP6of/yLlyTPiERKHhCu2xexsZPebloInshbW
         U5gB55lK9PPGoBlFHCpdSBgLTs0aijGLeQdevsDZzCpX770h1Cnw+nYWEtpeBxILNeaz
         ibmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773839233; x=1774444033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns2P3ggM46Yr88OF2vB1ZSaRsJzPAmjjEjQot/+oNY0=;
        b=wpIgNrQXqNCy5/541IV911CuWAYpy3kvXTUMJW9Gvx7Z4UNRyXOGGeEAYsZbQGy4GV
         o3lWKU/lkHJDS9Eiv6YWx0CUzTNleMcP8koMje7q401wTK39i2amZhvN4n8xEv5ca04H
         QLt9O4NBKhoairs7RS3rtXqmfMDuvNnbBmjjzpGqXiqmQ0kkshvRpddVH9y+dXZoxPGK
         18F2XTYP5N0AY+bFgsQaZKcwak0H8+hp+1q5bySlyqKET8kCs/9lSa4omQSpudLoF5in
         sZOxn+vc8Cw6M3Bm3ffsHk4fQjEZJFS1hFQWjTUkGU+IzX/butKijRqvaeyq6FsqxRI8
         E03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839233; x=1774444033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ns2P3ggM46Yr88OF2vB1ZSaRsJzPAmjjEjQot/+oNY0=;
        b=AOgssTJBT8WmaXPNDcYztD7XruzGpzBmFkqShTjFR3LTvZh/ibtdskbgQwynMv3QZ5
         8dYaBYVkEshi3T/3AEjwgeuGw/js3KAxR8h/EjKXD7GDSI7mvyuKSVu2IGEDwUhCwzcg
         BP7/mh/PEWygJIcvrd+6JtTvya9fFhFzTzpi3EObnwzM1KCzzXd7ZFqakS7nRCYwbyD4
         9vhtjarru89QMFvXVU1bvYMX/zHFfMsaq74btVsW2KjJIa3WDcPVf2xX3UI8w12vNYZu
         thlztgQUW+5tkh7YWJkDgICYK/5luRF2O/A/N3HxOfMOc8Ha8GEq9sFAknsJwaxFKWC1
         y0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXrI2yKTBzEycrI6hoDZCyCANKYfG3i/YelE/rbFL5IIU8TeJUwZs9a9YhA21FDFFi1TDzShfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGZ+obT+UCM5QIraDEEpZxkWh0QTi6Yl5zafq+59+96JUT3vt
	VHbyueJ5hXAly3MQFS1ymJGqooJ9qH9Zkbt6UDvAJJ/HHOG4YsjT8WdUI7xKnsDf/5m05OqYVo0
	sEu/PtjkhzcR9nGkD0CHgTOrE++HYnPJukMlpVbcQWg==
X-Gm-Gg: ATEYQzw9hDDTj0rYrFxXgvAft5YUqpl5+N9hdHypSQcs0H79zBbqVfF/XrE5b4t+wlN
	+0FmrDZg1E/Fd2N7h4eAzirrMOWVlLBOay8fUCVifpbk6+89CT++DQ8Z5NKi37pcZ2Wo7D4OdqD
	SPa0OsNaB1ZffyQY1pdh3g2kEGnIHvN7CejLUBajOiQM5fSe7qWgn3YFXhJTIXJSYpAY7WTLWf+
	WO0IHvjqazc08+7d+AA8m2ZljJunP4BUHLQ9b1jAb9oiJvewcRqSY+gmoIFSXCunlM3uSU5mq/c
	prb6Qvhp
X-Received: by 2002:a2e:720e:0:b0:38a:4de2:85f1 with SMTP id
 38308e7fff4ca-38bd58b92e0mr10200901fa.32.1773839232816; Wed, 18 Mar 2026
 06:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com>
 <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
 <c803299f-709b-4b57-b7fc-46ef3bb4c9ee@gmx.net> <5fe9332f-fbce-469e-8f19-dd3d7ef54c5f@igalia.com>
In-Reply-To: <5fe9332f-fbce-469e-8f19-dd3d7ef54c5f@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Mar 2026 14:06:36 +0100
X-Gm-Features: AaiRm52m5cJvt4QR4VS4vXBV8Ahr79JL09AakQc1EBgijJMRaGkvQqTnXJFDsT8
Message-ID: <CAPDyKFoooZbU9W_Y1aSx+HuCfjHZGn9XR4_CB8YgDmCBWTB-Tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: bcm: bcm2835-power: Increase ASB control timeout
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>, 
	kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-227063-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.net,broadcom.com,kernel.org,igalia.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: 2C05E2BBF79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 at 13:54, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> Hi Stefan,
>
> On 18/03/26 08:51, Stefan Wahren wrote:
> > Hi Ma=C3=ADra,
> >
> > Am 17.03.26 um 23:41 schrieb Ma=C3=ADra Canal:
> >> The bcm2835_asb_control() function uses a tight polling loop to wait
> >> for the ASB bridge to acknowledge a request. During intensive workload=
s,
> >> this handshake intermittently fails for V3D's master ASB on BCM2711,
> >> resulting in "Failed to disable ASB master for v3d" errors during
> >> runtime PM suspend. As a consequence, the failed power-off leaves V3D =
in
> >> a broken state, leading to bus faults or system hangs on later accesse=
s.
> >>
> >> As the timeout is insufficient in some scenarios, increase the polling
> >> timeout from 1us to 5us, which is still negligible in the context of a
> >> power domain transition. Also, replace the open-coded ktime_get_ns()/
> >> cpu_relax() polling loop with readl_poll_timeout_atomic().
> > personally I would have moved all readl_poll_timeout_atomic changes in
> > the second patch, to avoid possible conflicts in stable. But no strong
> > opinion about this.
> >
>
> TBH personally, I also agree. But, as I don't have a strong opinion
> about it, I prioritized addressing Ulf's feedback in the last version
> [1].

The first version of the patch moved the call to ktime_get_ns(), so I
thought we might as well use readl_poll_timeout_atomic() directly,
instead of fixing up the open-coded loop.

Kind regards
Uffe

>
> [1]
> https://lore.kernel.org/dri-devel/20260312-v3d-power-management-v7-0-9f00=
6a1d4c55@igalia.com/T/#mf96146960ec7ffeea32e732c95ccf9548af21748
>
> Best regards,
> - Ma=C3=ADra
>
> > Best regards
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power
> >> domains under a new binding.")
> >> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >> ---
> >>   drivers/pmdomain/bcm/bcm2835-power.c | 12 ++++--------
> >>   1 file changed, 4 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/
> >> bcm/bcm2835-power.c
> >> index
> >> 0450202bbee2513c9116a36abaa839b460550935..eee87a3005325848547ce1f5fd72=
9b168a641460 100644
> >> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> >> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> >> @@ -9,6 +9,7 @@
> >>   #include <linux/clk.h>
> >>   #include <linux/delay.h>
> >>   #include <linux/io.h>
> >> +#include <linux/iopoll.h>
> >>   #include <linux/mfd/bcm2835-pm.h>
> >>   #include <linux/module.h>
> >>   #include <linux/platform_device.h>
> >> @@ -153,7 +154,6 @@ struct bcm2835_power {
> >>   static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg,
> >> bool enable)
> >>   {
> >>       void __iomem *base =3D power->asb;
> >> -    u64 start;
> >>       u32 val;
> >>       switch (reg) {
> >> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct
> >> bcm2835_power *power, u32 reg, bool enable
> >>           break;
> >>       }
> >> -    start =3D ktime_get_ns();
> >> -
> >>       /* Enable the module's async AXI bridges. */
> >>       if (enable) {
> >>           val =3D readl(base + reg) & ~ASB_REQ_STOP;
> >> @@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct
> >> bcm2835_power *power, u32 reg, bool enable
> >>       }
> >>       writel(PM_PASSWORD | val, base + reg);
> >> -    while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
> >> -        cpu_relax();
> >> -        if (ktime_get_ns() - start >=3D 1000)
> >> -            return -ETIMEDOUT;
> >> -    }
> >> +    if (readl_poll_timeout_atomic(base + reg, val,
> >> +                      !!(val & ASB_ACK) !=3D enable, 0, 5))
> >> +        return -ETIMEDOUT;
> >>       return 0;
> >>   }
> >>
> >
>

