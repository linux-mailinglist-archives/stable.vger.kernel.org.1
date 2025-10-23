Return-Path: <stable+bounces-189075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47EBBFFCB8
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21ECA1A04EDA
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A32ECD1B;
	Thu, 23 Oct 2025 08:08:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AD2EB863
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206892; cv=none; b=da4prMBgIgUOMgtJw98k+v6C16SvHjOQ6W5Cjj/yLLdwNV2boIypF9HVxK0gzKvqzl9XnPmaw3mTILObyVo3/svYs+tumofILlGo0LJq2HcAfbClUq8NhAMFmamKPDGo/raH/J3jD9KX/TonS+Jxg0ihywyxb6strcXmPNnOcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206892; c=relaxed/simple;
	bh=YSlV3Ui/R8OX+GLrbep0IihwU6AoVM62SupLufD3Caw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PltyqZKAsLGPa4fsDo3kWdxXC4IpeeuOerJbTKTOfpDAIL8Bg6L+D1VaDw/onYxhxV1H7Le7wVLYQzkjWpDifkyx4iXY0whrnzvKS6XlXVJbvbi8wQSRidomFIxCs/MSz//ylSYCdv0Hbq9atHmgCaKH5rQiPg5sTFzbwwD2zL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5db24071011so1271779137.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 01:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206888; x=1761811688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nolr+eNt6aVR4bnXOrSXLAjzFqxSLYKSdI0s7QV7cbw=;
        b=f1p1gkKa4TDE71XFTB5VdSLTa9YfO8NhprlPsGPf/woSc7JqEUMYJH0cSXXUoZwwAc
         Jzwe15YXA5dRqogOs3lObhvqtuHFRQ2widiT8uo8bPnLZGmlWjmjFUQvvb+PpofQYPV5
         PRNQfl8DpBVjWI3q52LMGvGr0zwd6LBPenHmc41GhPNV/K+nTTtrB8au4GtJk5U+aWYe
         I1f8l7FFCVJoUegnLn7gXV8oP0bsyyYBRr+oD4F+CQ4AVMkx698M0KfCtIDa/SLtcQAh
         EQ4UMMhiVpSuSlI0VvVGRx3cIg87ulMRbCqlR71utuEhK94g71yAxsg6NRvsq3IaSrxf
         actA==
X-Forwarded-Encrypted: i=1; AJvYcCWD8zkX6JBXw/XyI4amWb9nRG34BKEwBEEE2EAeueLkhJt/IngzORtWQ4plEi/Rg+Vy1mJgTCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjfMfoVi1KDe4yWrIYgC8vd2KURpC2d6kZymqP3pQQKYUeluB
	Mv43LLVCwrgo53NSAInanmtl3gtfYhhQtMA9K7W5Rj6y9KxFwk5Lt2Kz4RqZDJKp
X-Gm-Gg: ASbGncsnuSrb+d9Bq1t9NbQ1gGaykw3IVyibDF+guAzn1+Gw+3yhMScdTUkxty9KfRq
	THlXTn8wOPA2xYX4qG5ic0r/N14DxTOYR80Ou3hqXujg3zroUgZsLd6PVmj6dAVUG+gGCoYFOxU
	RWCmaAgRtwyw8ne91FDUAZ/a8IiFeoN+pp5GbxxPRhlDMOC69fEYTh3Iv6zmF02WvXlPO+vGrfi
	Jp3MftzdP7rUaAa4H+q0Hrcn9bt+F42WTOkawGt3g+rctghfYaUWZ0pqa1UWYiSTggdarwUbj4K
	KstYnoMMIrjZm8eF733fassKEl/jmqznBFpmUmUGH5/6Htk9s7kJxfrK0i4E9oNbTe1C/+BhV6N
	u1km6JfQRWiadIgrWPyVLPkebjuqjNBCo6DIJfA/cmr45fZaCUu27oAydQCcmtBPcFnAlmrAkA2
	2NpGqfq1yFfyi+ZgR/zqZ6sH5ZIkAcU7K+CKoXVA==
X-Google-Smtp-Source: AGHT+IH4017MKI4nRrI+XMzOYdJw3C05vIrPjzV0oeBf8uV57RJlnRwSIJXcggV68t1cQnpfbnnlgw==
X-Received: by 2002:a05:6102:1669:b0:59c:1727:f59d with SMTP id ada2fe7eead31-5db238492b0mr1193076137.11.1761206888320;
        Thu, 23 Oct 2025 01:08:08 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934aba93a1csm669811241.2.2025.10.23.01.08.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:08:07 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5db2dc4e42dso506160137.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 01:08:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMf0hS7fVpLMYmUSaDDlcxC//DWH2vSlDztt4TTAhFrrijDb4iRDp/c6TnilyliImlZiXztE0=@vger.kernel.org
X-Received: by 2002:a05:6102:81c6:b0:5d5:f6ae:3902 with SMTP id
 ada2fe7eead31-5db23866f45mr1605522137.19.1761206887227; Thu, 23 Oct 2025
 01:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022124350.4115552-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251022124350.4115552-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 10:07:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTe8t8O2H+hPU6=WC6V_YGHwTd7sF1htuhX8mVC_fUqA@mail.gmail.com>
X-Gm-Features: AS18NWCVYlN6uQfMDhc6d_B3LlrJdzYInr_Xaym6zmDpvYwmst5OSgE2t6h-cSM
Message-ID: <CAMuHMdWTe8t8O2H+hPU6=WC6V_YGHwTd7sF1htuhX8mVC_fUqA@mail.gmail.com>
Subject: Re: [PATCH] usb: renesas_usbhs: Fix synchronous external abort on unbind
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com, 
	geert+renesas@glider.be, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Wed, 22 Oct 2025 at 15:06, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> A synchronous external abort occurs on the Renesas RZ/G3S SoC if unbind is
> executed after the configuration sequence described above:

[...]

> The issue occurs because usbhs_sys_function_pullup(), which accesses the IP
> registers, is executed after the USBHS clocks have been disabled. The
> problem is reproducible on the Renesas RZ/G3S SoC starting with the
> addition of module stop in the clock enable/disable APIs. With module stop
> functionality enabled, a bus error is expected if a master accesses a
> module whose clock has been stopped and module stop activated.
>
> Disable the IP clocks at the end of remove.
>
> Cc: stable@vger.kernel.org
> Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -813,18 +813,18 @@ static void usbhs_remove(struct platform_device *pdev)
>
>         flush_delayed_work(&priv->notify_hotplug_work);
>
> -       /* power off */
> -       if (!usbhs_get_dparam(priv, runtime_pwctrl))
> -               usbhsc_power_ctrl(priv, 0);
> -
> -       pm_runtime_disable(&pdev->dev);
> -
>         usbhs_platform_call(priv, hardware_exit, pdev);
>         usbhsc_clk_put(priv);

Shouldn't the usbhsc_clk_put() call be moved just before the
pm_runtime_disable() call, too, cfr. the error path in usbhs_probe()?

>         reset_control_assert(priv->rsts);
>         usbhs_mod_remove(priv);
>         usbhs_fifo_remove(priv);
>         usbhs_pipe_remove(priv);
> +
> +       /* power off */
> +       if (!usbhs_get_dparam(priv, runtime_pwctrl))
> +               usbhsc_power_ctrl(priv, 0);
> +
> +       pm_runtime_disable(&pdev->dev);
>  }
>
>  static int usbhsc_suspend(struct device *dev)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

