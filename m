Return-Path: <stable+bounces-240581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDwmJt4r62mBJgAAu9opvQ
	(envelope-from <stable+bounces-240581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:37:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F25345B99F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4617630074DB
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6431AAAF;
	Fri, 24 Apr 2026 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItxzugMk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6D3382CF
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019833; cv=pass; b=gEKPu3c27n7bX7TIygibeeqzBQsNxYo7njvbx6tccJjyjX92uL+38DwJQ6raWJbZ4Zfde4rmLKgCm2WzJic3X0hVUe9eEwdZPPkHfH3fbGrCqxOyly5IRt0tk95nM61LEt9kRXJ+46RQD60p6FVVaPK62VCaWUn134vDtz1xfGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019833; c=relaxed/simple;
	bh=x4I1YjupP6GGFjVPW9Jy1Eo0uFh4ai+pFkQeZCw6Z8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIjANf9EfTnQwJ84PEQueZ5jeKyeu2OxNpaq0fqWY/3BYBpfpotSRBPayFWNu+1HB2mRsh12VTOGt8GKflv72Fp0eEtd6uYM1mVk2U9AKh9xTWxtP/m7gmZt9tGnMFVE2TZGcLJw2pt12cStHNQ0uiYc9yI+k0T0onmcNyExiqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItxzugMk; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651bf695701so6068137d50.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777019828; cv=none;
        d=google.com; s=arc-20240605;
        b=A7L9Ej+OLw8vLTU4UGTrUfRXs7qcRztwixbPb4JhnjYAY5VRbWuKgIWm9T+lGRjAs4
         zLdYhycQOOWbE19tEMh18GQMANkKM+A+5VEoUzD9opGWSAO2wWGV+S/P72exyyfD6D8m
         ocORIFWm8JH6krdJmI0fa0s704ivoATMlGmaxlpahjaPGkcsgvY3N/2skn0lXo9/b5Vi
         Ch8N9M6WmS5XMNTvw3SEfSTjrc8a1VxvALgjv1s98H7mpKf5iQDoHNBQxzHE1VXSPwYM
         YZEXIdl0hUGOi2ff6suQNiDTROgNaRGHeLbJWqKIQmYvSR1wORxbZNycr+zJEiVR6Tac
         pNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lVI6vsFdn9OVrj4vyMP79clufaLb0TYUczzolorXSOI=;
        fh=rMLtdgVQHN1VlxV87T3IOmOxtXaGsIX9qNoOgBTQxBk=;
        b=N/VwU/bzY/pCHlRzcUr5xD2TcKNYPKlsct/BH+WHX5y1d4C+Z6TwVuhxvBYGLCBZb+
         zv6LliCBQsh6iVxsTOQgHl0bMFgoiONG/+H9KulMt5wxpidXrDh8KQHkgKpVB7ztWN+D
         YdG4Dn/rirrWk1fv/geO3R/t/D4C1Q28hIrOSvnrJqvbHgRwEx6pAGyYI1jlGmraChGg
         MdFkF9x8On6VZ8q2M8+X2xELq0aovW81a7vbv8+LncdBcgTqiOdcX9VodjGHghaJPU9X
         onp2hJADZBQA+YetZSkTCXorIUkBuPBcTD18bh8fZayforhSddH4ASd72cMo5Nf9gHmd
         Rtbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777019828; x=1777624628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVI6vsFdn9OVrj4vyMP79clufaLb0TYUczzolorXSOI=;
        b=ItxzugMkXSX4fJELShENUatpJFhB/Xh/+s6D4jUBDe+L3t8yHDlVnkuNoSQleD2/v0
         fNxvLQFQNmQ9nNZArxr17o8RdPwPI63jDW96gAtkuOFWtHsdkzzJX/MfkagwWxyyhTTE
         oFjL8h5D5x2XDQ5UQ/mjnrnh17A3m/YgkgHVqUW6+zWU2mZL78SYcBvOKI3LWuBE8hJR
         0AZpEZgbHvfbmaOfmlpR+OnfikzX6adFOovM7Jq8nsqlzcqgo0GL+RAHleuLsFZVvyDY
         kTwWg2cHS7Pnq7cPEL103Ksj8d6cGccNuBvI2HWbMj1CxT6iGXv3Timr2AHB2g4tMO89
         X/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019828; x=1777624628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVI6vsFdn9OVrj4vyMP79clufaLb0TYUczzolorXSOI=;
        b=O70yPdEMtey990piHdtBY/f/B68SHK99dy/GRPajm7rpWMVP42TTz4Jnby0/uic+Pk
         VxOcQ+uCzs8wh1aQA49CgtqnL8ohOXWHuHp0NB4T77LnP2rwch7eDD41r/iOLGwJnvoF
         Fc/s+Z/rJ4e8FrhAkPp2kFUxihSunMN+6vD1QTNoulHT7jGYGzVdW72fotUThZZv5YXF
         mhCvWK61QPJ0ghY5W1KbRH6zjZ7tX46bpkcUJhwpBH2yu4tBJVxsR5NcDcb2ArddDlMH
         iVfWqpF/iPd6x4hzIE3nj3exgyxRApPv7GuRwccLepyGvFju2w5MtIrCg9jbg6VZmnYO
         kbAg==
X-Forwarded-Encrypted: i=1; AFNElJ80hpcf51YFJP4ZX43Y0PTdUnVKJPo0HUHs6ulM3pO5w9hzwVk+oRpKAFpDEcCbt94K9iiFOzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdecXdAbUkWIKjgzuWA+gFZ+YpJ3v8ZwLiGXlj0Bn/F4hn9JFb
	xgP2lxktXrJLLpGEV5xUeeF/xGVYhA/HDO7UHE+4RdMQM5c3mMTuroEzGnR9kA8NtSpzmwOPXMg
	lr0S/wfFnBk4rbfdNf6tBG1ZogVL1L+E=
X-Gm-Gg: AeBDieuCkALHnU25t85xd3kgrTaWPNxIoCeEIKNjH7WFufBCNc9cai690AncUortYpC
	y70yzyrwLptEKNBzxXFI2PB1BFaYfQdyUUDc3CFLW9RxcJMLX4Uk+glcR1zeft+V1M00X+818Ur
	iiXvdG6ybrqI6RXwrz4mUZdN6iyTaGEbiFsberDPyk1MdLIPsF5rmR7qm7ef2sDmzL+4ZzivuVu
	S9zauPeYn0gHKro2zUpmSVJ+51jb8nHo8DLRwvOZW0GrPYdv5nxlwzaY8s+nNwPLpTS//O03+RK
	QNtBCzGz04S+/8knPHo4
X-Received: by 2002:a05:690e:2543:b0:651:be4a:94ed with SMTP id
 956f58d0204a3-65310a8fabamr22114503d50.50.1777019828400; Fri, 24 Apr 2026
 01:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415180042.3648360-1-lgs201920130244@gmail.com> <aeCX1m_RMbSYXG8R@ashevche-desk.local>
In-Reply-To: <aeCX1m_RMbSYXG8R@ashevche-desk.local>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:36:54 +0800
X-Gm-Features: AQROBzBhJsFbSldwMS_OSWq-p_kDVbLQ8_Ky3HJIwRo7ZBFY3yY7UWkZkMarZLw
Message-ID: <CANUHTR-eLpy5+Lb0nCxGBC2Ak88aLPd_Ci0=G1wE+EsWs1EGxw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_scu_wdt: fix reference leak on failed
 device registration
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Linus Walleij <linusw@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8F25345B99F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240581-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Andy, all,

Thanks for the review.

Please disregard this patch.

On Thu, 16 Apr 2026 at 16:03, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Apr 16, 2026 at 02:00:42AM +0800, Guangshuo Li wrote:
> > When platform_device_register() fails in register_mid_wdt(), the
> > embedded struct device in wdt_dev has already been initialized by
> > device_initialize(), but the failure path returns the error without
> > dropping the device reference for the current platform device:
> >
> >   register_mid_wdt()
> >     -> platform_device_register(&wdt_dev)
> >        -> device_initialize(&wdt_dev.dev)
> >        -> setup_pdev_dma_masks(&wdt_dev)
> >        -> platform_device_add(&wdt_dev)
> >
> > This leads to a reference leak when platform_device_register() fails.
> > Fix this by calling platform_device_put() before returning the error.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

After re-checking it, wdt_dev is a static platform_device and it does not
provide a dev.release callback. Therefore calling platform_device_put()
on the platform_device_register() failure path is not appropriate here
and can trigger the missing release callback warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the confusion, and thanks again for the review.

Best regards,
Guangshuo Li

