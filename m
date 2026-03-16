Return-Path: <stable+bounces-225527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AM3B5bkt2mzWwEAu9opvQ
	(envelope-from <stable+bounces-225527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:08:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C00E2987A1
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9BF6304CA57
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476002367CF;
	Mon, 16 Mar 2026 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ei+aqoCN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B7225403
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658983; cv=pass; b=n3zBoYgdhKT/Oi29VcuCFt/OsfCIgN1ah1L5LLmCB5tWWPSJPQ4+H36v48LF+y7F/kclFm/MC76kpfLhCUZIGI6jMgJUf1dnnKO7t37Na04Anz1i+K63BaFZBnUAPWU8FdqngeZ8xjzdDEPp/L99yh673XYjyrY6ovATGnDhDXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658983; c=relaxed/simple;
	bh=ps6KqBz3Tolb4OztqKZDKSfuCF/1Zo/6VCi2Bz089KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRT0gmKPh+3blqvd2fjEE3rOqhm3Q73Is+DAbTwVnIrjcbWYO3mVfxMk9u00pRDF3NV2Cdk9TMSq6FraYpLgdnUKqMeiFrhIAzxfs+8BvERdyL+LQEw/up0wUvAqNYQ8LNGRgAfH51m2omOx+wZeGG3TezqbVI+l2QqTJAuI9JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ei+aqoCN; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e4989dacdso4983108e87.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 04:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773658979; cv=none;
        d=google.com; s=arc-20240605;
        b=U9fzNXbu0+a3865/XUF1tJ5ISydrbSNZOlAoMCe49/OXItkQAFxL03ug+Kmc6cvOY8
         irY4fDmWTTDUCmXFyMELCFIM095F+oIyUD6UF/Qr88SbUTuZi+np7IogcA3Emz9xrxEc
         5Wqiv/1gmKg2fr3OjY0KXEYkmvaFmYxWRYFWTCKenGhBBT9QCNw7Z6pJc9xlw5GlDAe9
         Rwna0Rwb5clBQI0+Av16mfFXb65Ot6LDw0Wky3nteswO1fzYP7wkUdhodq3T1fspbgfb
         res5zUJjJ8yZhCkWVbGcCPggdYmPxEXWxZdvnbCuhjJeFClT+yHZ1/t9wZJffZHy6IoR
         JS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
        fh=y8bS1pXJ40Fyc2FPdD1YwRnMIvCFBRTsNHlVohtdpYQ=;
        b=bRSD/H7Pw9fr8w5Nd/sPJfSgb2ocHjbMNeXi0EqmuLiG1CI5WJWeVJfnRN8IMYeyVQ
         Ss1c8+la/DbqQIXqDsZax9aO2G7mhSMUyUayeClGMg9qVfHISGwuOP0Tc7uW5ykiQpwz
         bYThnoW8vR8WQfSKjyuikGj4QJsO+KPWEHhHPQJpS4iQhdfDEBO3iF7QBnaLquFXDgIs
         yIIpR1mrGIUOWhfypuxrkjPozE9i/6IYmB3zJA2XFXc9saodTel90WlAELwIqdr+9nYA
         KlKUo6Dtra8v6kdw48/Kx49d1AWD16xmbBGL2BemEEd1Ez4HJXAJe27mJSqRAJZPxhgJ
         sDnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773658979; x=1774263779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
        b=Ei+aqoCNSVPXPa76BzbrgxSc4q7IzkNfHuc0dlBwMcmnbKbCi3Bb9wERR8FK4iGk5P
         VF5lKXdfxqCXu5MAVy8aXm41UlQQwb1MrjkyUCnJetXuhGDq/gO5bR1nntx4i+9jm7el
         H+1lzPjEIF5+z7WlYe+1IAK/vWHaxmEPN2EvluBiJbSDbSJ1+CcMHR4UfWYXpQqUa0qs
         c25p+tWIScmB9bLl0Dknre+gNPFbbfnGxZUanu0q6XIMxOKEK8WLrYvfBcmdRh5WhblE
         R2Dl4xLKEyO6iRJQrJlfLfNPPYxTnwKs9LekvYCVnSG11Uj37ejbx6ykG0H8/W82hWl+
         1eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658979; x=1774263779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
        b=offnVBrhnHDZQS+2COssuDZzRNoHhO1qUKidGtpbciJg4raE41y2QdyeHqF6GDzdem
         Se/tJ5CToZP7kBjm4ogyFDWzPEBo2TNG8rdoE5Qae4vagcPkmvMJLKQj0I61AMv6cR99
         taQYhe78XO44L1bDCaarBFD5lj7pehC8mqxjiimyzBkICqegIYad+/Li1FJ5Smo+UnP7
         01zpzOe1o6xbkPlchNXt2qmURn/K2xAcExX1smV2xk5J5YDsu1UOZ21QUSvMflGA8Vaf
         O4geptSFFgd1ldrgwcbqvTL7VggYYHZnCSVCkvu12qxPXgDrcPEdIAe4kriKIACC5ICC
         DZKA==
X-Forwarded-Encrypted: i=1; AJvYcCVd/P66hc4X26IX20AfE2YJEnDsZqjID8FEb0GtiTXAvmkfdqtXHNjknBregl4Sfn81dLceUG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/sKRNogU5Ft4nrHWTytOckMk0Q26GTnTnPJ6uaQMw61bhGOY/
	AmZbHBbkAUDKyeBluhTNWKysago3DNVqk6If7dEAnqXL9Pr9UQ1hvItoNHMlCaVi06p8sSinHZX
	z3A+xA+2emSXT1oBJc1Wsc53xF7pNViawAzpUOxswbw==
X-Gm-Gg: ATEYQzwNw6eMFO706c6CK/foIQqLpWVrq/Z1E/Bh9I0ZeOLpTjctOoHHFomoeqxtTIR
	0/cYnxlpRmTPHCeBizZOz5Vjmy0r0K24wpej9PbsCeGmFj7kX/md5Jwz/2KCINr+oEqAM7xdjcA
	6/yxHWLthz9E4B4JVnDbpceSuw7wLCDWebSFaJmgmdkNQduvoGFnikzPIYwEwuAMMzmDWM3gLnC
	4y6zfm604CMwo3lCW/xNleiAcRjR0AkhLGrq5J242wdhl9AIUcu1RSE+jCP5Nwn0fWcXpE8FfY+
	Uf3jfOfy
X-Received: by 2002:a05:6512:3d08:b0:5a1:476f:bbcd with SMTP id
 2adb3069b0e04-5a162b1febemr3904293e87.44.1773658978742; Mon, 16 Mar 2026
 04:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com> <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
In-Reply-To: <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 12:02:20 +0100
X-Gm-Features: AaiRm53iPYU3kIDyxQsV0KhFz9ohyZ2kXqcNJl_f0uC65KcEG9ey-Zyr9y0Dr8Q
Message-ID: <CAPDyKFqqdGG34+a7hY8feNHsnJsHvq0M45Y5-hDJp=bedHcZpg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] pmdomain: bcm: bcm2835-power: Increase ASB control timeout
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>, 
	Iago Toral Quiroga <itoral@igalia.com>, Chema Casanova <jmcasanova@igalia.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com, 
	stable@vger.kernel.org, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-225527-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,broadcom.com,gmx.net,igalia.com,raspberrypi.com,pengutronix.de,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9C00E2987A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 at 22:35, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
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
> power domain transition. Also, move the start timestamp to after the
> MMIO write, as the write latency is counted against the timeout,
> reducing the effective wait time for the hardware to respond.
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>
> ---
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Ray Jui <rjui@broadcom.com>
> To: Scott Branden <sbranden@broadcom.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index 0450202bbee2513c9116a36abaa839b460550935..1815eb4ee69b9b672b5e31440=
2f1cc9897c57dcb 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
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
> @@ -176,9 +174,10 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>         }
>         writel(PM_PASSWORD | val, base + reg);
>
> +       start =3D ktime_get_ns();
>         while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
>                 cpu_relax();
> -               if (ktime_get_ns() - start >=3D 1000)
> +               if (ktime_get_ns() - start >=3D 5000)
>                         return -ETIMEDOUT;
>         }

Please consider replacing the above polling-loop with
readl_poll_timeout() or use another one that fits better from the
similar helpers.

Kind regards
Uffe

