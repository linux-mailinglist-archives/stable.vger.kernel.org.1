Return-Path: <stable+bounces-240577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD71GrMp62mPJQAAu9opvQ
	(envelope-from <stable+bounces-240577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:28:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6713C45B77C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CB083006D55
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF6137A494;
	Fri, 24 Apr 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxqTxthp"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612293563F6
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019301; cv=pass; b=pCXz/GgJVLT9aL7kN0c0d2ulihTOIf9L3Q5m2YSzNXWZw80krc9TvmE9xja9HnbHwBGcpj3YAEh3dpkETYvrSbUbBLd+zejYn1toVD6jFBfJjkLwBFLhKXbW5oS2nT9dklkazgr/z8nVw/BLomKeGxuK3csnAxdW8PUYWe6t4dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019301; c=relaxed/simple;
	bh=mrBqKA2Mc6TmW8ESnrXXX0vP/1JjZNaiwPmcMcCbbeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCWGFjBxCFNmY9A+I/aH1mn9s6YnY7CeiCxZmSX0vOr5cu2g36/xuBstGdxih60OzlegQzTlKhOKl7/kVh+8DMlR1UE9GQXfn21SSFaWCDeR9kFRwNDhe7ExFJ+jrtIFa1Xg+x7u8mZO+Ri/gTLpeae0wg5kpFrlhK3PcsRjhSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxqTxthp; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65492d097acso1292975d50.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777019299; cv=none;
        d=google.com; s=arc-20240605;
        b=IZi6trZ1OMlu4rLEgXHVYi2ivtBC4PF+mrsOOvFZnUC2jmxQcPvKbdx14/Ve0BffyW
         wS0bALA0ZX18a94JAN27Oqn8FcLam+D+zuwT75Ma0Yo7NgArx6v25BHEp6maATSphsWM
         mjlPZNf071T/wz/p+I8Q4gf6bhBazR51rWgja+rpZcrQmpL9YL3uBgxPU35D45JXAJXk
         3MJkAQMgJ22IHi3WLI2wZHPeoQyL/oZH0VYsr5+mE3AAa93Pb669tbPeCDDO6seYubNM
         YD798f588eYLm+m0f1cglTD0Zxy5ggNldNdKFXzGFsYlEHfZ7wYWZbK38/HbOUdb9HHi
         BVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sN0rziPZQdRn6WX26SP72flDm5ulQNY3Uv4jrO0qY7w=;
        fh=WXss7Jv0bStWbtPH6ekpiN8BReOWfX10iDUVH6uJk5Q=;
        b=AGAbpY7FAKDZvJtO2IlTg4+v/+9cifaJLb5yioN9xAyJwNXVzvDrf8sIPOpNABYDIR
         jBofjKAdg9C4uV11GGOJX38Daj31nE5Xkm2rXaIE4hohbHLeSolikbK6JAeSS4PQlv03
         PHEwQdZ4Z/cVRm4H5XT/qBdprDHIb/MtnehOGgT164dGBjX5G2qq4VD83t4sIx3//wJM
         lP7iv5DvsYiTxnBFgSzMqE4SQ6it0NvSytBRpJHyPh1NYbb2Owlp3Q09okf4W3I2Njfu
         PKib+E9A2BGFaipOJwjEBSLwVlX9IUW9U8miAOPyK3dx8vWz3D1QgnylBLQLnkOg659h
         BCqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777019299; x=1777624099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sN0rziPZQdRn6WX26SP72flDm5ulQNY3Uv4jrO0qY7w=;
        b=AxqTxthpOXv5aFU3nc+0QLIhqHlfHkrlAL2lhk8c4ccY45ltvyiIkhka2X0AhibUuW
         +rXzjVpme2kyocn9kmUnJLXxpah3kP+TtkYFd+d+DZr902LSKZ+ZEZYwKz/yjyVpoGn3
         qU98qm05MEOBEUyhfs5EqZ8N0nT4nMnfU0sZ9LX9iqve4YpqCPj4gAT5LVvIPhv7Nxk+
         N3WpNyTEOkRtshD/87fUdg0YR55DFMG5WCLu8qJU8j2+fgwb1Ub2lpsFRPEs7nm85ojk
         he8Xf4MaY2SFTVA/YU3cFGG3DUgSXAD9o6jqwaRCpCtLCT1wqmp51Ot8Mzm79v/hE/gg
         rmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019299; x=1777624099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN0rziPZQdRn6WX26SP72flDm5ulQNY3Uv4jrO0qY7w=;
        b=FFXiiGCJL6Tk6nSm36kHPi8KvtBhuyE3m1lEuGFXPC12gjZpk3HpNqkvcKBiP21f5Q
         /rbfNSU5ShXQryJUWjH6kped9Y5q2wvVLpMbJ/2YgGojhZrev1FAdaPATmQb6nYZHphU
         TFcP9AGt3AZbghGxTAvl917Tkk/WVgCUBu5BoVqMbh7FRRl1sPX1TBJCsPONylT41yFo
         XmmjWexYrM7IqCfVSXupLgmMlHnWWwRmGSAlUdi+FkwxqlB4LzvqvmDXhLBj9CTxMaMh
         ERT3HruUIVEi5+UHKej/REdNNuK7X+zssw0cugIhwVmnr/Lcsi0zuO41gBOYkPFCmcrH
         FuAg==
X-Gm-Message-State: AOJu0YyjU4cmocmVPg36LaEPA2+FZamP7SjjXzmLuDa3oGHZ9EdKedZF
	gu0uB7WulVDtBHjuGjz8n1PVq2l9wmXbR3ogDV2fvQF7naEI1N3lT6WwzLFe/ZLbog9s0jfa65C
	2Oa97aCwnHY3InX6NdOKne5jipb0JB08D50cBxis=
X-Gm-Gg: AeBDietQ8qRqKC2Yw/BVEiXtNRrZ3Tvns6XZq7+ZfeALjpe7ncJANuo/Wsnd6dh1X4i
	Nk+yLOr7HeiOLKT8YvFVBQpa9tw6J3mEi6oUi3u1ReTf4qDqMkChd+NePRZ2pKMSVhgXA+Ff7Zr
	4d8QKhXFiMhy4qSRDbDKyLMmloSmGUqloDixLYLFH8Yw1JKmUr6LorsmGnTV9H5tRc7pDfCUY2A
	eo2bx77FpQ+FSm4ES2MIfcj/9y289Wrf5dE4kkV22i/39bB2WlZmMi/nkxO4cdWfYcRn4phnMEw
	p0gSjiAwP2uJeEwlJCDR
X-Received: by 2002:a05:690e:43ce:b0:650:77ce:71b4 with SMTP id
 956f58d0204a3-6531083935emr21579917d50.16.1777019299304; Fri, 24 Apr 2026
 01:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415173642.3619223-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415173642.3619223-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:28:04 +0800
X-Gm-Features: AQROBzC4f7BN7Xu-mePHuktSwx5TbBZts9RyUfFNEQ7T6-Hh4NRD0ML1i4FNcwk
Message-ID: <CANUHTR8JfNvn1JgviJfdgcfqiQDr224N_DT=xZNCH5OQUo=FaQ@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: tcic: fix init_tcic() error handling
To: Dominik Brodowski <linux@dominikbrodowski.net>, Guangshuo Li <lgs201920130244@gmail.com>, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6713C45B77C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240577-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[dominikbrodowski.net,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 01:36, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in init_tcic(), the embedded
> struct device in tcic_device has already been initialized by
> device_initialize(), but the failure path does not drop the device
> reference for the current platform device:
>
>   init_tcic()
>     -> platform_device_register(&tcic_device)
>        -> device_initialize(&tcic_device.dev)
>        -> setup_pdev_dma_masks(&tcic_device)
>        -> platform_device_add(&tcic_device)
>
> This leads to a reference leak when platform_device_register() fails.
>
> The reference leak was identified by a static analysis tool I developed
> and confirmed by manual review. While reviewing the code, I also found
> that init_tcic() continues to use tcic_device.dev as the parent for
> registered sockets even if platform device registration fails, and that
> the pcmcia_register_socket() failure path only unregisters the first
> socket instead of rolling back all previously registered sockets.
>
> Fix all of these issues by checking the return value from
> platform_device_register(), calling platform_device_put() on failure,
> stopping the initialization immediately, and properly unwinding already
> registered sockets and other resources on later failures.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/pcmcia/tcic.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
> index 060aed0edc65..43bda9930645 100644
> --- a/drivers/pcmcia/tcic.c
> +++ b/drivers/pcmcia/tcic.c
> @@ -362,6 +362,7 @@ static int __init init_tcic(void)
>  {
>      int i, sock, ret = 0;
>      u_int mask, scan;
> +       bool irq_registered = false;
>
>      if (platform_driver_register(&tcic_driver))
>         return -1;
> @@ -464,8 +465,10 @@ static int __init init_tcic(void)
>         for (i = 15; i > 0; i--)
>             if ((cs_mask & (1 << i)) &&
>                 (request_irq(i, tcic_interrupt, 0, "tcic",
> -                            tcic_interrupt) == 0))
> +                               tcic_interrupt) == 0)) {
> +               irq_registered = true;
>                 break;
> +               }
>         cs_irq = i;
>         if (cs_irq == 0) poll_interval = HZ;
>      }
> @@ -486,20 +489,33 @@ static int __init init_tcic(void)
>      /* jump start interrupt handler, if needed */
>      tcic_interrupt(0, NULL);
>
> -    platform_device_register(&tcic_device);
> +       ret = platform_device_register(&tcic_device);
> +       if (ret) {
> +               platform_device_put(&tcic_device);
> +               goto out_cleanup;
> +       }
>
>      for (i = 0; i < sockets; i++) {
>             socket_table[i].socket.ops = &tcic_operations;
>             socket_table[i].socket.resource_ops = &pccard_nonstatic_ops;
>             socket_table[i].socket.dev.parent = &tcic_device.dev;
>             ret = pcmcia_register_socket(&socket_table[i].socket);
> -           if (ret && i)
> -                   pcmcia_unregister_socket(&socket_table[0].socket);
> +               if (ret)
> +                       goto out_unregister_sockets;
>      }
>
>      return ret;
>
> -    return 0;
> +out_unregister_sockets:
> +       while (i--)
> +               pcmcia_unregister_socket(&socket_table[i].socket);
> +       platform_device_unregister(&tcic_device);
> +out_cleanup:
> +       if (irq_registered)
> +               free_irq(cs_irq, tcic_interrupt);
> +       release_region(tcic_base, 16);
> +       platform_driver_unregister(&tcic_driver);
> +       return ret;
>
>  } /* init_tcic */
>
> --
> 2.43.0
>

After re-checking it, tcic_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this version.

Sorry for the noise.

Best regards,
Guangshuo Li

