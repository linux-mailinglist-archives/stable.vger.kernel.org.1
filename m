Return-Path: <stable+bounces-231386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHakElKky2mTJwYAu9opvQ
	(envelope-from <stable+bounces-231386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:39:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6A5368222
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE7C63074E02
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522733F0AB0;
	Tue, 31 Mar 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0q7can2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE13E0C68
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952729; cv=pass; b=VkIobUbbAk6+i7C8K3cp0UbkLdpShS8LQ7acI5CWxT020FOMSHnlq2He46zbveZwdh3PhQk1+rLD585bnO9nSe+vqGu2Y9phXuF5si6y9TVEqGdONc+C6OwqsjsBUc7i4sv8zgQMJwK9StdXRxCO6QxNwbGuQyscP9CD7w3BIug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952729; c=relaxed/simple;
	bh=0xZ65aEgS6XS5mPxZxPz+I09u2lkDz0qU/QCr6kni98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUvPvujoeM+iWeWo5iI7juIw9u6pbCVb8aIs8zKkWziKkZ4t9EfrrvKE5n/2mItQXZKlZSjlM5yc4N8GrWJFloS9Rw+UgO5CII5cGnMZHYgEg9ZKqodjnesr+OQZl0r5gVJDLq8wNLmX30/NJiWN2w45+Q2otbBXeoR1BPela98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0q7can2; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so7440108e87.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 03:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952726; cv=none;
        d=google.com; s=arc-20240605;
        b=e+ea9uKQ5PVdRjBQOMq6ODtYXyH4LgLlhY9Vs8sJ+8RxtPZGSExu3yrtuPHkG/a0xQ
         p2WU+mi5HcvgF9Q+zP6P+sYCb1cPuNs0w4m5JJYkEFDkuJJC338KEJDQggnNjNPNbK0Z
         KMRmZEhhq8uHMQQG0sjJiiMlfWa8pXP+dQNMaSDzR0SXkFsEF12Mk94OGSll0F6GvTdt
         M5D4f0qjbLvTnop5oCZ6dgtlv+EvJg4TL2Zpd+QFRt5aNTolSB9tLm0y1xTIsIicKOJh
         oQUE2FXgk2FXP44g2LFPrtVMFqnk4iyWLQlMw8P3fvgLMpY2LaoJ8R639bzJtd21wKkQ
         c18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XBIXQ1IvymanQZCLCIrI88ZGl5hQ8LVN5jZWed3Qpaw=;
        fh=9C8GFYWk4kariMc0tiDFG8XhuP3B62V9Mx6K22a8FrU=;
        b=RcZPhSbASd7o4ONrPydR01TfISUy4zzOjVzH+haYrmdPpSKK+o/rxf2jCQngKGVX3x
         PgsX/HFGKft7ztDEpv1a044l2XHJej9Pa2KpwrXX2Q1vWYBUW+gzR74IBiv0n0xtuLnC
         8fu3e+dKtf9jZwqllV/ey8USFdoqXqGtZCpvhZj/tizSwJrSyaOQHcqOvvk65NTjyC4m
         VQB0Zwg00IQk+jGVAQPZxQyaZRiomysif2XYzzLMgS7723JcK9xCmaomuGmtknI/DwrU
         TGGjz+h4HRDVDyS914ZIxCUE15qS1Feg1yn7VzemT1XQk91WyokvyCK4XRY4mLcbrhHd
         22SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774952726; x=1775557526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBIXQ1IvymanQZCLCIrI88ZGl5hQ8LVN5jZWed3Qpaw=;
        b=I0q7can2Er4GEjaTvJcJoio3e/OmMeWUqIdoJ2zalmOBjgyyr1Qn+28PoA6y5hfm7d
         jVJcYYs/03x6TAehpH7NM4oW/TKbbp3PFT9n1YMHLI0B1VizQkXqMw6benc3GfwcRL+7
         pePqKE0FNEuPSi/g/3G2amM++JB+IOyt1m6UNpuDoG/bPyAcDWJHZBACdMxvBMan0cmF
         pzm85rfYBfTTbs06VktZPolPG7owQe5Qeovb9RXODjLKrLZmsUHCC3MQ44CkGtYxbinI
         1766JtsyqQWKrq5JrhEpP9ELr9jMmTdZtE8MsyQineuOnyaYQAjdD+ISE+AyouSZEWqC
         KYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952726; x=1775557526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBIXQ1IvymanQZCLCIrI88ZGl5hQ8LVN5jZWed3Qpaw=;
        b=eQZW46OIUHBTANVQehRrBlG54B8GueQ2ZEaG3F01TR/UPcC+37uNehucYDvGMe1glv
         QFEOhMl7iweDkdUloVHEOQbfuhvQelBp13BSiHLtAJizEg9DduImg2eRI/eWlMVgvTgO
         zuVDIQY1aWHg64+rl7zNJnm3QfeITWw7RvvUe1iHyiMNlm0eRjb4rGA6pUh5S9fvbhzJ
         Ojt+5EIVk/3q/7Z2b+kCLepvUHMvZX3B5vA6WJVYx26EWjpbTg4jopno5SYTryWnMVZ9
         0ugqltESgWopu1aSBUN3wzPyrCh7/J+CbYwrDCGZPDVpCrvJPbHR6GfB0sop7brMe2/s
         iolw==
X-Forwarded-Encrypted: i=1; AJvYcCW2QK7XalmEyfclPwYvh4e9E4rAOLybC/P8ulfwp+HigSZPF+9CynRNreaBp1CL2enLmD+Tp6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+I+8d70uK7eZFFOA/ilqxBf5Lo3rQYJJU4M5tMC0wu8R3JT1o
	akYz2kIN9ZT1ybYMe3dHOGvG1tBv4YyU1vSakMQu3LAHmURyfVIe5WQ0jd/0IPcsyTDAmej5sxq
	lN9LkBCHNOjtX8BZSxmkCFNERbYxAgX6HyytndD0V6SoqoL20UkPe
X-Gm-Gg: ATEYQzyvLKm0eYutyQcjfTalBJkBbpdVXNN6xy1/TG+t4PMnLRHlBmGiniCFLsvWvBI
	HSB0Wsmd4T+B1FMzkPnoTdnbAM1qXo/xSk6sOhH/AW7hxTVcCcLnFhgMthuM8FNK4wGneRaymQw
	PUKcJgck9lsDc+8FphSWOZxpAcJ9V87c/qvX71DaZjNy5wVgqeNhQObx5aEH+8csLARsROkUpBl
	5bTy0qawEGxAsvVF5JQ8spZMaa1yJvQm5V1dEsVW5PoIH2KWa8X5lO8x+4xY8f0gxNWTI31mYyi
	8u9pqk/I
X-Received: by 2002:a05:6512:1108:b0:5a1:1e44:8682 with SMTP id
 2adb3069b0e04-5a2ab9294a9mr4892116e87.34.1774952725626; Tue, 31 Mar 2026
 03:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327105208.1310739-1-johan@kernel.org> <20260327105208.1310739-3-johan@kernel.org>
In-Reply-To: <20260327105208.1310739-3-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 12:24:49 +0200
X-Gm-Features: AQROBzAIIF4vqFpK44CPUhY9m2k50H9Tt7zGx_VCKe9Z30Qp-B8l6-4bTcnNwJE
Message-ID: <CAPDyKFrX2Bw_Ari-6kvSbSd=VsDh4bpxn5UbZV+eFChCsBE1kQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: vub300: fix use-after-free on disconnect
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231386-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,loongson.cn:email]
X-Rspamd-Queue-Id: 3C6A5368222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 at 11:52, Johan Hovold <johan@kernel.org> wrote:
>
> The vub300 driver maintains an explicit reference count for the
> controller and its driver data and the last reference can in theory be
> dropped after the driver has been unbound.
>
> This specifically means that the controller allocation must not be
> device managed as that can lead to use-after-free.
>
> Note that the lifetime is currently also incorrectly tied the parent USB
> device rather than interface, which can lead to memory leaks if the
> driver is unbound without its device being physically disconnected (e.g.
> on probe deferral).
>
> Fix both issues by reverting to non-managed allocation of the controller.

Huh, sounds like a real mess, but thanks for the detailed description.

I will defer applying until we finalize the discussion on patch1, but
otherwise this looks good to me.

Kind regards
Uffe

>
> Fixes: dcfdd698dc52 ("mmc: vub300: Use devm_mmc_alloc_host() helper")
> Cc: stable@vger.kernel.org      # 6.17
> Cc: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mmc/host/vub300.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index f173c7cf4e1a..3c9df27f9fa7 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -369,11 +369,14 @@ struct vub300_mmc_host {
>  static void vub300_delete(struct kref *kref)
>  {                              /* kref callback - softirq */
>         struct vub300_mmc_host *vub300 = kref_to_vub300_mmc_host(kref);
> +       struct mmc_host *mmc = vub300->mmc;
> +
>         usb_free_urb(vub300->command_out_urb);
>         vub300->command_out_urb = NULL;
>         usb_free_urb(vub300->command_res_urb);
>         vub300->command_res_urb = NULL;
>         usb_put_dev(vub300->udev);
> +       mmc_free_host(mmc);
>         /*
>          * and hence also frees vub300
>          * which is contained at the end of struct mmc
> @@ -2112,7 +2115,7 @@ static int vub300_probe(struct usb_interface *interface,
>                 goto error1;
>         }
>         /* this also allocates memory for our VUB300 mmc host device */
> -       mmc = devm_mmc_alloc_host(&udev->dev, sizeof(*vub300));
> +       mmc = mmc_alloc_host(sizeof(*vub300), &udev->dev);
>         if (!mmc) {
>                 retval = -ENOMEM;
>                 dev_err(&udev->dev, "not enough memory for the mmc_host\n");
> @@ -2269,7 +2272,7 @@ static int vub300_probe(struct usb_interface *interface,
>                 dev_err(&vub300->udev->dev,
>                     "Could not find two sets of bulk-in/out endpoint pairs\n");
>                 retval = -EINVAL;
> -               goto error4;
> +               goto err_free_host;
>         }
>         retval =
>                 usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
> @@ -2278,14 +2281,14 @@ static int vub300_probe(struct usb_interface *interface,
>                                 0x0000, 0x0000, &vub300->hc_info,
>                                 sizeof(vub300->hc_info), 1000);
>         if (retval < 0)
> -               goto error4;
> +               goto err_free_host;
>         retval =
>                 usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
>                                 SET_ROM_WAIT_STATES,
>                                 USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>                                 firmware_rom_wait_states, 0x0000, NULL, 0, 1000);
>         if (retval < 0)
> -               goto error4;
> +               goto err_free_host;
>         dev_info(&vub300->udev->dev,
>                  "operating_mode = %s %s %d MHz %s %d byte USB packets\n",
>                  (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
> @@ -2300,7 +2303,7 @@ static int vub300_probe(struct usb_interface *interface,
>                                 0x0000, 0x0000, &vub300->system_port_status,
>                                 sizeof(vub300->system_port_status), 1000);
>         if (retval < 0) {
> -               goto error4;
> +               goto err_free_host;
>         } else if (sizeof(vub300->system_port_status) == retval) {
>                 vub300->card_present =
>                         (0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
> @@ -2308,7 +2311,7 @@ static int vub300_probe(struct usb_interface *interface,
>                         (0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
>         } else {
>                 retval = -EINVAL;
> -               goto error4;
> +               goto err_free_host;
>         }
>         usb_set_intfdata(interface, vub300);
>         INIT_DELAYED_WORK(&vub300->pollwork, vub300_pollwork_thread);
> @@ -2338,6 +2341,8 @@ static int vub300_probe(struct usb_interface *interface,
>         return 0;
>  error6:
>         timer_delete_sync(&vub300->inactivity_timer);
> +err_free_host:
> +       mmc_free_host(mmc);
>         /*
>          * and hence also frees vub300
>          * which is contained at the end of struct mmc
> --
> 2.52.0
>

