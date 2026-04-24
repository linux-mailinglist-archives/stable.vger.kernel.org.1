Return-Path: <stable+bounces-240573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ1SJDUm62muJAAAu9opvQ
	(envelope-from <stable+bounces-240573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:13:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F043745B416
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD9A3026766
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76D332EDE;
	Fri, 24 Apr 2026 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohy0uOBK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14031F980
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018331; cv=pass; b=cfk3S5ZILryHaJtRCc3SDMMJCFIVxelm688rEak7ZP+ZA9KCEI7+MZMW9IVW4iIeebTOC1SEwLehngIro1BqZd5i56ia3iOSbVZRnW+HfV6T5uU1+uNd6aCnUu1XJmYKCih4qX/IgTnSrimofWMvW640bUcYX9ytB+G5lGDBi5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018331; c=relaxed/simple;
	bh=pQhCJoKrDswYtZBf1LWhLNAE+CqCNDWeVMEeYK8DQag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmGrHG0xjXF9xLNDipG/OnXJrSUMqhIBIj/zE/cSPoG4mXVuSn24bvTvRszYiD7i8CLaWW8Fx1Zl0vbZo1vPIGOf4FaEZF6hBkOa60lW4vbS1j6BJMFPqcAqEbjlMl4tFrCpa7AN23M6aD1ZfGqc25IFIlTuB+CYCnQBkGn8/+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohy0uOBK; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65075c2ba66so5814151d50.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018329; cv=none;
        d=google.com; s=arc-20240605;
        b=NFjoAo5Bdf6r6KEzAm0uQBgEjHRxKyFoe77JRPh05gC3lqSvEtliZLSXH/o7aygOU2
         JXF8qlSMmp95B17GFna2cNK3KAbw8eSADw/z/3jQk8p3xhONTDsLnudjsqkwnMvbo+Df
         ZQUT7L8a3PmUlhyD9jzQVMTXvOyA9Sow0WeCqFfMZp/joxrJKq6WDPqJSRQXw8Bx9ZPT
         rXw/j+mxnsXz5EQ1TkTWV7tlaal76EB/kkCtLN/UWc43DknPild05/IRThveGzqsoGrL
         O7kddmGdHqtmN1z0hHCsrz+bJTMf+X05DHLH4SLOCc7EMlAc9Fu7OrQmyUHYmW2qk+m1
         RrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PghHXsaUvPB2FGmxVpPAYNm3E4Qd+tT/tA4p8BC2Akg=;
        fh=5iDg9gIPvJ5qp5W07WuLV2SDbhgx8Vrj5dXY3ju26Hc=;
        b=J6r4GvHs45cXmqssZ/TVsalSjPm0OoepSzJAUfimRTMCNMtMiwuKi6UHjCzRfkPtJK
         8nXYukE34wrmqLOmkOUYSwUxVC7hfmaDQdJbmmrXuRbLJ+guOvKDo1dV93XYD9DawAs4
         MLpXnJqYVkVCRtQvlyNVnwyYRK5BrcdIJN9E76zgitve5MO/mvCmARdmlpyXpeivSRIn
         aDuhrEHw1fc5dXpfB9bmxXdHaJ74laspPLmLlM3cC5EdfUuqEWFhA9Z0A1xIvPrXYpi6
         EWtJSbZ5BX/CPEzX2FLwhn3NQ7ELqKCysomspcBoDy22okxXZMSI8Rd+jzes1mKochf/
         cg5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018329; x=1777623129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PghHXsaUvPB2FGmxVpPAYNm3E4Qd+tT/tA4p8BC2Akg=;
        b=ohy0uOBK/Q5nOD1uZxfygNAv/lliLqFi360rMQYo+lxVhPgGo9kc1ado0XVytrub6y
         aasAh33gPcVtL3BlafJSBT2+z0nkRcLd1DL99Ovus29H4FM/L1Up1mq8UukgAsVWRvgL
         PkmY0y6lA+kIzQUsAb6xtxCNC1abLb+4KnFJNabc5OKlLP66wHFVD4SwlTEiS4q+YIJE
         oF3qgy2rhKO6n/MF+58re/Gyo0HIfkuxOeVxfkRzgRN6IC4tluGPiKmTzWfSRX74lk8H
         SNDaems2AZsaPznn1cWABdnEXRB35ySIP5N/9RmVmBH67cS37fQQpfYi0cs6EhrI27DI
         zSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018329; x=1777623129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PghHXsaUvPB2FGmxVpPAYNm3E4Qd+tT/tA4p8BC2Akg=;
        b=WZ0Ck7aG+7v3j4RuV06lzlf7OllBlsSOZuJ85gF9c4QJe4/0irDvxoLOxW9qAAzqQd
         CMTQ9botvv/gkjNA3NTuUbaxBQusVgXU+A5w7IimPbwd6f36EJQRO2LdkZ2ebBlpREr2
         WkgDKbG66YP5DG12ae+1T84FpE87awEoUNqLvl0Dj4ThlN9gazNjJGayqu7waMnDrCCH
         c5r6YLoo4egiSEXs21sDACo33xvjCk6HW5/kSJvbxAGGd6SXigSrEgJ7JMqiV3Cr0gsc
         vfdZMxZ056nB2WWC4AF1wZI+X8PhPWHi0l7qVVvswLIPUdqxbrsXCAR+1pF9XFrPcqe+
         wlKw==
X-Gm-Message-State: AOJu0Yxqa32LFFnwHV2YBvHUAwDMlBxxDzj/7iN1WznnDAAWf0IdcCvJ
	top/t5LNpIiR3dFFOcQ2Gt0EKdw+0OkTl7nK5UIGpERC0LPISXaRLGHouSmMYLHEFIknmUl4Qie
	YarxI/AOPUVPVkWz9HqUMZxe/ul9SWXI=
X-Gm-Gg: AeBDievVy+vvONgTSLqrpGo1fOMA/aJdCbNCg8elnHtBfyoXBHplNtPyLH6DjjCVC6i
	R08nHhnpcAB6d59ETxvu5utaUmZUP1XajIDKau7r6blKztq9MnZoXYQHzWL5eJwqrWaI5dpMTVe
	NkOAz18pOp+ftjtA9PmWYdHJx+mg+y7raJdjV1aT0CH0E2vcM5cHXDu0UQ/Go3zVSaPU80Rz2yq
	SqoM43XZzqONwlIycuqYk04R4iDiuOwWeWK5pY6sbbJSTp1zHxYqAQmgHP+ij+IZMpwH6Wq0yRI
	p9KMxbXBHuY/OQsc3tqM
X-Received: by 2002:a05:690e:4199:b0:64c:a0c6:da93 with SMTP id
 956f58d0204a3-6531089af70mr25686233d50.28.1777018329042; Fri, 24 Apr 2026
 01:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415143701.3309681-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415143701.3309681-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:11:55 +0800
X-Gm-Features: AQROBzBc5qXvUTrDC5JalkEZi1O-Zxl9G-jCas25GxZKqJns4L1d-RV9sUSyvKw
Message-ID: <CANUHTR-YL+ZBWA13vYgOfs-YjKRyG_60ZjFbpPa-Dh8P8Mixmw@mail.gmail.com>
Subject: Re: [PATCH] macintosh: adb: fix reference leak on failed platform
 device registration
To: Guangshuo Li <lgs201920130244@gmail.com>, Kees Cook <kees@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Paul Mackerras <paulus@ozlabs.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F043745B416
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240573-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,sipsolutions.net,ozlabs.org,lists.ozlabs.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi,

Please disregard this patch.

On Wed, 15 Apr 2026 at 22:37, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in adbdev_init(), the embedded
> struct device in adb_pfdev has already been initialized by
> device_initialize(), but the failure path does not drop the device
> reference for the current platform device:
>
>   adbdev_init()
>     platform_device_register(&adb_pfdev)
>       device_initialize(&adb_pfdev.dev)
>       setup_pdev_dma_masks(&adb_pfdev)
>       return platform_device_add(&adb_pfdev)
>
> As documented in platform_device_register(), the caller must use
> platform_device_put() to give up the reference initialized in this
> function when registration fails.
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by checking the return value and calling platform_device_put().
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: c9f6d3d5c6d4f ("[POWERPC] adb: Replace sleep notifier with platform driver suspend/resume hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/macintosh/adb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
> index fe150125e099..eff06f78aa80 100644
> --- a/drivers/macintosh/adb.c
> +++ b/drivers/macintosh/adb.c
> @@ -883,6 +883,8 @@ adb_dummy_probe(struct platform_device *dev)
>  static void __init
>  adbdev_init(void)
>  {
> +       int err;
> +
>         if (register_chrdev(ADB_MAJOR, "adb", &adb_fops)) {
>                 pr_err("adb: unable to get major %d\n", ADB_MAJOR);
>                 return;
> @@ -893,6 +895,9 @@ adbdev_init(void)
>
>         device_create(&adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
>
> -       platform_device_register(&adb_pfdev);
> +       err = platform_device_register(&adb_pfdev);
> +       if (err)
> +               platform_device_put(&adb_pfdev);
> +
>         platform_driver_probe(&adb_pfdrv, adb_dummy_probe);
>  }
> --
> 2.43.0
>

After re-checking it, adb_pfdev is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

