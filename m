Return-Path: <stable+bounces-240585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA3lIKUw62lfJwAAu9opvQ
	(envelope-from <stable+bounces-240585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:58:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D686645BC87
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A27300D97D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAEB36E484;
	Fri, 24 Apr 2026 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6+/tIhu"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C33644A3
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021070; cv=pass; b=mud5eI6DATk3llyrtXh3ZDQpocJdDR5hWf2IvZeMm26H0drqxZJOwO2ATQvyv3E17pKLcRY/1Eo6NZJ8nqYF0Ze3LKlNwjwpfd8aXXfK/hOxt1ytmShyhintg3wIHe9SOPVeM/3wkYyfox/LAKpWUuD/oFgFkmJYQgxGXDuQbpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021070; c=relaxed/simple;
	bh=mJycpKriTio44XHdChcIwU/V772ZEJHE3GawlsKrjHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a828i9hzYWoswU1Dv3F5WakY3Gmwn1+CTPbUJMt0RNruvaI9GuF2NyP3jia1QjhopAD+hXFfbGsryGJQvUXqz/TX/nLS+U7MCKEEK9QD6GQct314/RrFuH1enbNLKSACmtQETGvuAOSoemXblnYwZXThcXbyp8CwRiYFAdH1kZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6+/tIhu; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-654672a6d68so1879385d50.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021068; cv=none;
        d=google.com; s=arc-20240605;
        b=RX7gxr8ImMr6YZbUwMOD/h6AT2vNa7nJaaLjk1I0Ke0RGCY8yGhOr3ltfHbXE/Xxlb
         OYZXoiVfRHcN0WWtLLDLi+ApVeC0nmcDuz6XmG+Fr5MV/51hJMo1HVVkPtQwuDp1YhQ3
         5bWno5N6Y+T9h9Nr7BwG+MilajHOYWnRg5iZ89h4cmR5DcJ8O/+E+aEvM/cRLlAhfeNO
         ExZa51BU/x5tDLXphSK1Ed3kyrPf8bvKOcimUzFuOBDQZdcwgPNfaF8osgFwX1kNlwhg
         gUIToAhePZs5mv6GLH2StqYBLlH7YqR2bLzUCi7Oo7/P/D4SZlnzYdP3zfd0bGOtKzTO
         B3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
        fh=GLcjqu8CwCdy7Qp3BGavHt0T+BqAGZp+d0E/ww+rwI0=;
        b=GFPBDcwmOgh3F/QVlZcqROKdFzhwDmuN/BtmBDRKZNozV7ZVyAF+flRAQ0W0MQVL5p
         h458ZCs29H/8HaacjOaLuCIBTuJ3N+YVN1XKVZfgkWtAO+AB1OhOolGwybbbOyijpVyV
         OpE4TuOLgXr9hF1DKZ0Ybsiz2hAYyWf5gcEDAioro25ff/ptglucwrfup8XL60CNPgo4
         J/eTmKTgkcvNzyZkiAZcHYNXp8gfRbUKkudi2KyP9Mdcsj8DNaE/Dw7V13I5pTgyRt6V
         amem3IgDoxiabW5EC76UEOcddmk2YHlpSjnG4h0+iWUBV6Dd325CujoNdojpfEbEh3bl
         PR0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021068; x=1777625868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
        b=j6+/tIhukzxZmK0pAb/20Lt3g+pUgsXuFs/Kr5fwM+/79i6oDwTP8KIS8F0k+DzGPW
         2O4baIxPIB53jQBYi+gmWyN6dSZ40Kw5+2UZT6YREUFo6lsAqQZRMAFIFiZSMT8L0UjD
         wqAQf7l3mrt8xbyvMB1aZlyWXd8yNtjijI8byjXZI71/o1rdSJxa8YHv4fy4z06n/vmo
         msSjantIQMKPaDfufNGsBlEcw67OXC4uVnbFEUZWzC68x1amTAg11vLnZ/iwiMoHCEi7
         s7v2w3+E+wlEqqqE27eNmzRCOjw4eoMDEE8j1LMZrrgYTmI6JDM7tZnbdjDRH3S0QMlY
         aa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021068; x=1777625868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
        b=MzkPxFsU/d8whPDNXHTcPtwghLo2uHe2v8l0PSSxu5kpOydpTJzXYeyW+EaxrWHg2b
         eDAZGfu9bwX7KjJxdyu82OmAyec12Ii0kyCRQEy7kZ6tRElXH0CnnaGiVBhqwwzcOfWz
         ayECCdWRFd4BPSeBYS+I4fkVyYXFF+4a0xs2Xi2UVPwmvf/JqPy4G1Zdwgta6q+W3K4V
         QqPIsazHVXkbl1sWFRjlJIVzJDBUTudXc32ZELntEkf++1IcfeyTijtmKOickp3qD0Ok
         yOUML8DxCM34CwVYHPsUHQ6srWAjlrBZINSE/hChZlUaCOpwW965W9BcxqqGJdObIOef
         SKsA==
X-Gm-Message-State: AOJu0YwDPLPtYCwFjGipManuYruvMTozJ3aPRSIjcRtHljlUNCgH+ZFJ
	xTIrWdnUflGNV0zEXxdOYTeSZTmFWb2ARah/O5w8u39PoPLqG1uc98hcaeMsxaiYqsG4+zBdaH4
	kWCX55qhhoOJKgeiTLmSv90rkhrBAanA=
X-Gm-Gg: AeBDietrW6xhCm4OlAf5limFjTDKe1XVWThTjPJIRG7NlOz6lDe82Pa+JIVBUUChLbw
	4BjP/T6x3q+j8a2I2Y81LcX+a9MWAi4DTlL6FjU+yNfP8RXHAGGEeRxSl1LrspVOIgG5NfhjOrk
	qG7wpoh3/Mmjqp+bLQpCi8rX9YlHPxAWCM0JX11NCCyJeMRow9PIXTIKjv1W+4lQCw9XfYSZrcV
	lfGMXxts7MGw3DdNZ+IuG54sTwXJ64ummchWQVtbn+WfF6l/RaFDnRHJcZ+5d+Hdrx9xgthhg/J
	hvmgBk/fpRullANnEpFg
X-Received: by 2002:a53:d748:0:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-65310a737b1mr21220612d50.48.1777021067703; Fri, 24 Apr 2026
 01:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415190738.3821974-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415190738.3821974-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:57:33 +0800
X-Gm-Features: AQROBzCmQJ1EX2ApfnpwOngh9p6OkQ-4OwvW-Db64LtyYbRXyvs5_5WPx0t6Mt8
Message-ID: <CANUHTR-JSL0rkw1VbAa1AYFsp0NGF2Dz3X2AWmQFcJ=mm-nsxw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: dnfb: fix reference leak on failed device registration
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D686645BC87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240585-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com,vger.kernel.org,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 03:07, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in dnfb_init(), the embedded
> struct device in dnfb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   dnfb_init()
>     -> platform_device_register(&dnfb_device)
>        -> device_initialize(&dnfb_device.dev)
>        -> setup_pdev_dma_masks(&dnfb_device)
>        -> platform_device_add(&dnfb_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before unregistering the
> platform driver.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/video/fbdev/dnfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
> index c4d24540d9ef..72a9c47418f8 100644
> --- a/drivers/video/fbdev/dnfb.c
> +++ b/drivers/video/fbdev/dnfb.c
> @@ -296,8 +296,10 @@ static int __init dnfb_init(void)
>
>         if (!ret) {
>                 ret = platform_device_register(&dnfb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&dnfb_device);
>                         platform_driver_unregister(&dnfb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, dnfb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

