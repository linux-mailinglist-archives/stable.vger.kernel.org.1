Return-Path: <stable+bounces-240587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDNFN2cy62lfJwAAu9opvQ
	(envelope-from <stable+bounces-240587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:05:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223445BDBE
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E22ED3008224
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8629221FCD;
	Fri, 24 Apr 2026 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLnNhF1K"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BF3385A5
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021484; cv=pass; b=Ep2RI9KHrfgQV09OdxYbivNfp83jCa0JrG7cLbYiK0O6bSwTP7B//8xP3oBkqZTO2fHsyHImGIO1wVC+FcGpCa7rRRxx9W0r5x6kPHIcLu46z52nE4uI76RdHjECuVri+rO64oc4T/FAEfjdyQcIaqoSBqitleqBXya9Ohbx3fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021484; c=relaxed/simple;
	bh=A4jH1huI9yFh1il+odDweWEa+S5rrAi0RBYTn1kn1/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpaAWv2XM1QgMzVWQW/qDmrmdCtk/u3uoLVO/5c+KCXAnAsBbvfK9+Bo+OfIzTaD6LS7kOR2AvTW5OmUpdEYnsuh3HjPgpXHfbfm/8G4E9ABc9Yg4++yxLWPurC182xxqX2a9pfxLm3jCDKQVVpMz7INIg5hcuQPzscnM9S7EIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLnNhF1K; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64d5a7926cfso7603633d50.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 02:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021482; cv=none;
        d=google.com; s=arc-20240605;
        b=amOag6EojxsDG9bXVVfUSwbzRsE9tVYthk1AA32s/1Va7f8B9oreejjB79pd3vRLer
         Mt0EwRbo80ZchWBCV/Cbp524PYBUeGYACWAHoUxt+lTPU+ZPC7D0uc4smFKPjYNP5k0H
         iBsgOIpO/CZiXAbhBtJ7paWn9iW9DGG2UVRF7g61v/GWIWD7Rfw5niH7mfY04p4EovXq
         SfjMJaWu4S4zwy/CgRbtw36Gg8sORjLCx01Xc0xp6S/KXifs9IOWNcFPmAQYmgUpmPqA
         rFNQb9e7ZJayMbAte/XeTC/RcpSm6pbUaAeLmddfLKBUEfFbEtJZ+znoDLJ6BAeMzGVx
         wG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
        fh=GLcjqu8CwCdy7Qp3BGavHt0T+BqAGZp+d0E/ww+rwI0=;
        b=hVkPVN49xhK3Egh5EPM8m9ZwcP7IwbkFxKpinbcYekaHPlnQLBrKsTpewJaV/fKejB
         b15f8t4dvxBYITVTy+57a21ZdDMOu6uLiFZGkOxqKWm6KimkrLwLuSpRATA+Bzv/vkXk
         QQ0HoNlOi6kJWX7zNzrbx7hlkz4BcA/k7Tw3NcNNMLgXyraHcMV1Qh6PwWjf8mLP9qUC
         9rV8O7GuuyZ+Wg86NShzg5PqTPd+TnWK5kuV7YOjtOTMVVR9NwVQjQOWfFTrnQgRWTmF
         O6qELaiYPkw21yQxatfPfKrUJsoYikEHSoNefRNjSONe6IdEZko0UOEPVaeyJsLAKSDH
         oRjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021482; x=1777626282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
        b=NLnNhF1KDy4LZCUrNLNN1t/m/OZhDExs12BAEYc3vmWsKIscL00TLi4ldWV7Rf0qJz
         jD0jasGnpLZXX/B6HK0UuT4KwY3In7f1nPu1vzpKdqx9SmC4AWLlESy+U6Hf70oV4G7j
         CsFEaY7N7HOoEdi77H164Csedcb8P1jcJ+cER33JCCHRye52rZTnefZXpG4sP2C03pqx
         fmcWFlwtlDdLzyR4a+jIYavs7JqCMmdr05tRRpa+Xijbqc+/7MR9JJ82GaunCpEigYmC
         GWWPpANBuUcf3CY0XhPL9IxOMJQOVAVi6YjklnmaYfvVQjT5O0CeANn30Xn1ANSusOKM
         i15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021482; x=1777626282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
        b=ct6UqlVfJBcM2XUpseXc0e/LEru0iumHejH46SiE3hJnwQXDfDDTioufDKChEhnNCQ
         8XsHe+ftKm6rdojfRWp6MrwGXtLiKV0yOR1qLjARGW9LfY63P73R2E+SoWRu855gp95J
         rpIi6Vq8nRv6Ge8RN31o3o9baeCAp9oMBRMWTlKmLQL5MpZZLOlb7biuN7BA6KH6PaHT
         W62970H7UQF8OA1OtRr4qHKXs3Ktxxwy9+Fc6e55WJEmktQ0BGAVYtRIojEv+wJS1CxV
         FW70r15hahz+3DP9R8x89Rnqv8daiX8oRIXVmZ6XX9wYiYAcBfRYJ5EwMdWlvOI1hXCI
         FdQQ==
X-Gm-Message-State: AOJu0YzRYNxD20vSJMoHeh6ETZZVK3w5Tex7+bni2UkBm0/hKtIBtpAr
	f0wRS5EDICDJWgZdeuGUXQ8Ye8CY17TuAEAmw0j0zaInhGjWi7TaEk4OlgXeoa0gxcP44xIMdwz
	ZugsKNWlb+YgNN8xh0eYgarrNLJZdi/Y=
X-Gm-Gg: AeBDiesMNfoiAVdot789JmiDjV348AujXW89Rg34FPrzxfF989gncZtICFc+9pt05b1
	vraf0zFpWi+SUTU+cVj/Ii1tqM5uJImU32IeXOk/llO9ncLNEJ0+koCCo9jPfPs9YA6tFD/UwCg
	TG0rQvdil52KETx1NxXhZza6LL0PIHEmtf/GLFPMuxfMg9dhbpPqlhTMVeLEclWlns46UUwp9qp
	hAjg43IatxlHdELBmBNsOc3PHUkMU7K0FksudRhcBO9G0ic5J6HWvg+lg7jy22OroSoqKXhoTDw
	CMk1TDqfPJdOoAxRDrd9
X-Received: by 2002:a05:690e:4141:b0:653:3f1a:798d with SMTP id
 956f58d0204a3-6533f1a7f4bmr26739134d50.23.1777021482431; Fri, 24 Apr 2026
 02:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415191306.3837839-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415191306.3837839-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 17:04:28 +0800
X-Gm-Features: AQROBzD3ciSHDJ4yZ2SN0KweOJ4wwJwZ7CklV1Yarwt6T_p1EdetKVc2Xh8dTK8
Message-ID: <CANUHTR_zY8f3eGUJwzcq_rAe=XfturfT5N=E3fYLyaYXqGV4Tw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: q40fb: fix reference leak on failed device registration
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8223445BDBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240587-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 03:13, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in q40fb_init(), the embedded
> struct device in q40fb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   q40fb_init()
>     -> platform_device_register(&q40fb_device)
>        -> device_initialize(&q40fb_device.dev)
>        -> setup_pdev_dma_masks(&q40fb_device)
>        -> platform_device_add(&q40fb_device)
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
>  drivers/video/fbdev/q40fb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
> index 1ff8fa176124..0151a41267b3 100644
> --- a/drivers/video/fbdev/q40fb.c
> +++ b/drivers/video/fbdev/q40fb.c
> @@ -141,8 +141,10 @@ static int __init q40fb_init(void)
>
>         if (!ret) {
>                 ret = platform_device_register(&q40fb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&q40fb_device);
>                         platform_driver_unregister(&q40fb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, q40fb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

