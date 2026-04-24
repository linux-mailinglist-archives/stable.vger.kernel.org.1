Return-Path: <stable+bounces-240574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UICiFJQm62muJAAAu9opvQ
	(envelope-from <stable+bounces-240574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:15:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C145B44F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB171300C9A1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A969386573;
	Fri, 24 Apr 2026 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQPmJIg8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512F384231
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018513; cv=pass; b=tyhuZSV0d0fF7nP01gVoOJQXm0I+Ef+CDO19x5hVCo6eNCIHdkHImBXzbRAs9plyPes9wEXB2dOCGoWfFql7byq+uGrhzRz9dhO0UebFW9dz4YrdwEeSsKD7fJsl9mjMe6+R5zDilr+ajB2mrux+iObX2yLhC99fTcWJwSwk8VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018513; c=relaxed/simple;
	bh=EL1LqI0HjOHw/X3s9RX1Z8CHc7JXxIQGtqGpiidE3qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er5meZpkjhzi1k4BadEm+8xS+jZiBGur0w/MX9F7Yo2RHb6tuHntW5URdNtRvUVDT7CgdB7IbK3AeGli7BSoJ46DW1vAdkOK9gFuRDPm2c2xvhc27TOnmTECoM0evmRxa+peDqhETXdxjx2tFiOo4AdePvygecT0YrOHXd2EtJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQPmJIg8; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79db5e18ac6so90492107b3.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018511; cv=none;
        d=google.com; s=arc-20240605;
        b=KOx8rLRj6voPWmj7q47i5CKa75Tq5FWyTFLPronJ7+zU6001FokxPLUqP1PehyRLma
         Zuurl7XDOPaUGUkErH70VwwBfFlo6YLk74mazzWqaSoeyJTTdF3UheteFMJ5ilFLMr3C
         yTdZEsbWkGcc13SDPwUARSCHdykg2JdanXuhTLRwfuQzS0zh0INIup0MuQigj84FeEbR
         0p5aVuv9E37zXaYZ8hXJ60N8uBziyncsLZFhvLX/b3thh3Y+STp+wSbMmGk+t/YH/nH1
         mQVjN/bRDbURvo3oDpjD+rlqjgAy5y+q123Gvbj18QpbwZJGV8LvuaD9N93CTJxhSrgc
         Qi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XoTQ4s/qNuwga1dSku+5JUJ8IacqDxrPAbEtqeudZ8E=;
        fh=K+HmYJBvGrnKz3L4LcLGxuCLxA2H/EZLNQdu/8bo9L8=;
        b=BkAdL6mWGFNgTDm92OV9H/e9cHSeT7NWdXNKeT4RPaBivRzj6CR2EqPd3pZGzZsgvd
         4m5kfIeHVS4rwnIDZ//Bwu1+iyYXgdE6GPTXkRK7PkejjaDzppn/VtCnOQ7P8fhdUlEE
         DUMtdBJkL3oupxFiXHEiLlhOAtXFQc+g2TOfvmkLDcq83bPz70Z/VjnU+5QTd9Dg1TFY
         wkYQJ+9OVA4O4PWeHI/bPArUHGvjBFfKlkC/aI0qY+osTc/UFO/D6xjcSM1ADxsoZuZ5
         nB7dpIK+1O1Ai5vJQc3RgMKoqkTKDrKKmszSquw4AJVZchkRfyqhEwWA1OH6Tky4rlxP
         HCJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018511; x=1777623311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XoTQ4s/qNuwga1dSku+5JUJ8IacqDxrPAbEtqeudZ8E=;
        b=VQPmJIg8R1dotIMjmuu8/yik8kY5PV6RvpBb1OwzQw+s9u12y5XVkM10fXs7S2/2aK
         N5LOhVxtOmqInd6XHOWEJ8TTtcH/G7Jf2BCeQsOQV85sJS1cpGGeFIThOMRUCZ9prIW2
         IBm5IppJmPfclKbECSB2TWvQChj/twWaHbd1wdPyKaetQeQRWV+IQDdJFWYBUZN6wQWG
         sxN7UxOoy6qNrxoEQCi5UuAmJq3uogkOJkmACCJOhzrFDNkVwKHWnrBs6MiEQegqviUO
         eFQIIMsscGEMWom8bI7OAzaz1wFk8mi1Yo8s5seSY8LhzkQDBwC8lFSpm+JIGmTDCnV2
         /otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018511; x=1777623311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoTQ4s/qNuwga1dSku+5JUJ8IacqDxrPAbEtqeudZ8E=;
        b=gQgIgkO/IeJJXks4Ui410sRQEAdioNLyOZjfi/0ZipOaqcpRj82DerNZdfCl30aRfp
         yAeIqFnEQPcMgE1ZOtveobBcaH9rlOJJTISRABKEGu8V1fC/DxKLQc/wrXnPEcCEU2tn
         xMmwkssgrRmdX5LSYbNfy6umm4/BmF7S7r5q+u5ApA/2fYrsvhieyg9vQeYXoUurlRIs
         wCq3B89lGGAeNJESMeCoE7ZhdgrRg6sqoIP+XA2RemBFwiNNgiZLEqfBMOZsTY4DIP5d
         qpDQALMl8rZBocTW4VZ8a2Ia+jXkeKhtOJs8tiZu/cCmWcvS+INeKcqAg8kY016gOyuo
         OzbA==
X-Gm-Message-State: AOJu0YxCwVn9OPQ58WedF2Xc0RUlLycT3XQbo3ZWj1r4BQPQiZ7zLBlV
	+xbOY5K/mK8LuSlRehKg8Ohxw2MQkCSzaPbnOXydP6MDkIQ82NyndD/OqLTMS5rwT34A0rFa0Ma
	Jb8sikZNR+JTQUMdlwjI5mtIun+d1wLk=
X-Gm-Gg: AeBDieuUF6e8oWsiiQsORsuEzOonq++c8tZt/siqsiPszm2erZXECMZ3O0bdwGVAFDL
	edSc8WNNxQf6FPkIiMwEfb5tUMmF8lJDJdXo165YsWzT9K9Qpybrw7Z1I9ofE/t9wtQxfPdlPX9
	8ny/JDagvFh5p/eoiEFTkf3HceipC7+THNPB/zbR6FAedMn/he+3dDMh6J3m2HGpDj/fwqqrz05
	kZaxfSxcr3PBftBe+ag7Dd5G973Klzp5f3HDwmwLOGFgNKXWScHW3hBCwBcfmm+Z8Hzcn4biMA7
	YD0noewDvEQgafh11GDz
X-Received: by 2002:a05:690e:2486:b0:654:3fca:3515 with SMTP id
 956f58d0204a3-6543fca3bcdmr7674478d50.30.1777018511504; Fri, 24 Apr 2026
 01:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415144635.3318697-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415144635.3318697-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:14:56 +0800
X-Gm-Features: AQROBzAFZKMpsNmPGDIOC_UCfbe-Rxj_nU9Bws4LOoucZmHnDsWY6cx-wzEa2m8
Message-ID: <CANUHTR-CH=rfsfm5ezNBHW__4d+TU-EVOC7M-vDkf=nB-N_mkg@mail.gmail.com>
Subject: Re: [PATCH] macintosh: windfarm_core: fix reference leak on failed
 device registration
To: Guangshuo Li <lgs201920130244@gmail.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B58C145B44F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240574-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,ozlabs.org,kernel.crashing.org,lists.ozlabs.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

Please disregard this patch.

On Wed, 15 Apr 2026 at 22:46, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in windfarm_core_init(), the
> embedded struct device in wf_platform_device has already been
> initialized by device_initialize(), but the failure path does not drop
> the device reference for the current platform device:
>
>   windfarm_core_init()
>     platform_device_register(&wf_platform_device)
>       device_initialize(&wf_platform_device.dev)
>       setup_pdev_dma_masks(&wf_platform_device)
>       return platform_device_add(&wf_platform_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by checking the return value and calling platform_device_put().
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 75722d3992f57 ("[PATCH] ppc64: Thermal control for SMU based machines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/macintosh/windfarm_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
> index 5307b1e34261..4003e72f3a57 100644
> --- a/drivers/macintosh/windfarm_core.c
> +++ b/drivers/macintosh/windfarm_core.c
> @@ -436,9 +436,14 @@ EXPORT_SYMBOL_GPL(wf_clear_overtemp);
>
>  static int __init windfarm_core_init(void)
>  {
> +       int err;
> +
>         DBG("wf: core loaded\n");
>
> -       platform_device_register(&wf_platform_device);
> +       err = platform_device_register(&wf_platform_device);
> +       if (err)
> +               platform_device_put(&wf_platform_device);
> +
>         return 0;
>  }
>
> --
> 2.43.0
>

After re-checking it, wf_platform_device is a static platform_device and
it does not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

