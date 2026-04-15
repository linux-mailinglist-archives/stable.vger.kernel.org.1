Return-Path: <stable+bounces-238135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGSKIkKZ32nXWQAAu9opvQ
	(envelope-from <stable+bounces-238135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:57:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E199405106
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8810930B123D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6240B3CF03F;
	Wed, 15 Apr 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9wON2fC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AB3B3BFE
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261278; cv=pass; b=ZUeX53S2QUIr20Ob8B5Ytd8P+zH62Y1NpxE7E1WF6fuP5wp/O+5q0NK+jbvI5ZaBn+CN7b4aZTMwHAv3v2a6DOTVGe1VvYDjkxdm5CH/+rA+gTtL1uR1QsU+A5JwyfUKZWg1vGCm3nIXlvAV65Du+maUhTx8BgsqZ9TjdABwbSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261278; c=relaxed/simple;
	bh=jjLEeyfM7aLe72MtknknZ7JoDQX1kZPS4u5VhFIwQr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PziRSROHR39kcsSzkKFL7Swk2gYdzkCSMszfbEHsRn3CSOfIkOXPcgYfa7qUYcGs0MbSX+5yn69hklS3mJRjoZvtNmBd6nNgswlYxIssr01M9TSVxqUAoFaVi2PjMvXQXfM75cSFru5qdfI7mJVeKZCmioPeOVNbnpySDmposPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9wON2fC; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651cfaa21e6so3056163d50.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776261276; cv=none;
        d=google.com; s=arc-20240605;
        b=aWC47JhvlTagYw/UxQHYSbsZFXYjJS8Kh/n9aqZqxC5n+EvuJn09oRkIf1yTKeI3+L
         AQBLQLELAnMor/rh21lWwoQ8bkbAvOs1ddi9RyMGI4QrTi0KoXaMvSNEfBZLEfJ50zFf
         OjGiO/3fGLfoQJy0aF7ybt1x4BBwthZYZepSvDTLcBXD2fgIEhW5hatjdFwmHA/wH0XG
         mJaH7QX0cpintRp4vgbV0QyF3b0skqbmf81x2iXxxDlrnqzelvyqjlTh3khp+c4KpV5G
         jBWdfmNF+pcbJ5Z97YWGqeVKnneOBz1iJ4Ali6qv1ZD78n5E7l6oHHe4UeQHjaub6ftK
         sOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eiU5+/o+Dy2k6wBYHFotkArhw04FNZIcBj1PufHtM34=;
        fh=/eCcu2KkxbI1L3lBPHHsB7Fq1IIvLhrPF8X8r7bKUO4=;
        b=hbUQbce3+GWbCO7FqvlT3j4KBIdmFm6RA5Tp7q/C/ikZo9oQ81GwYhKcSc5kQbP7tv
         61jNuMByg2zkupaVCIC8uIYQQbktvoJ6D9fnnQhwtqsuLvj6UDnxKaALPf6TkmWgpb8J
         4xejAVoKKrlObV1IdQTb0FsL387EfJr85IRPrF93qRsv9MgJNfQBEDhwwjQcuIl30p1o
         9W3yFWb3rVWf5waAug16W8h3/EMflVyNNYJH6dZwmg0xlWNkUa6nxKS0rtVCjCChgZx5
         yUTs60WXDoi3VzqGMabu8z9EBJZz/1dsD7Ii/etcs36GuUhSD6eKZwhLmel80MNzOewC
         FqYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776261276; x=1776866076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiU5+/o+Dy2k6wBYHFotkArhw04FNZIcBj1PufHtM34=;
        b=T9wON2fCDPGw9DksWKXifsoSol4P1ve9Qeo8Q/3XaynYrD69yJOQiWDOa1QXujuVNP
         RVrnZ7CFU4vf8FILQMXZO6OMK4skmaQ4K4Nnj7oEr5TodBylZVJDGPREhn23u7Cfc7Ud
         udq1NCY/mDLSBYnYLx9x6yFvOMYyuXvUzwcDr7sb6cMygCb7rCEFOMMZ1bZTTCSyhPMO
         PaIUq6KJklraoXCygtGp23pCDKWltZ8No2aNMIXvc6hhYOIOEMt7G4nujMEGR4wFfSeF
         Ge2BXVDmNny5O8K53Ybkdc16iXnohJty0+LfzCFX1PwFBD0W4MTPqTkWFxl66kCplqVS
         NH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776261276; x=1776866076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiU5+/o+Dy2k6wBYHFotkArhw04FNZIcBj1PufHtM34=;
        b=TG0Op3MFC/NVgp5oByhC/1YPoMvs0Zz5zuMvbV99ohzUO3A6JxDLawJQEPRzqXp0Tt
         BYB6FBsMEn9G6ybUEMtZCF0D7TnV237bOFHqiPi+TB+zp6hOSMqejpIXqQhRKxzE6Zoe
         bzCwIZzoYnSueB89kENdmx3U44fTTvuOzyP0EyjgDS6ZqKfupGS6GcemIwDqAGCzQNBY
         2WncGqneJI9yjOvK4O4LSIOvqkXsZk4/oCPLlqMKW4+7DLWbsUNNGUrDdpZ0fYSDXF0Z
         ZbDf198YTKxFF7gb3JtRODZt+Md27WeVXNZLjj7hfoKYfkspwQr9R1f1897MgC/VdMWC
         o0uw==
X-Forwarded-Encrypted: i=1; AFNElJ/Q3teLHqv+xcSs/DIIgZb2Rgje8llXc2AMymy64hnGfGLoZguWsQvaiDfvBne2XKvJeCtEJ0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXYqL8XyUIW0h+4Eu58O9DrmK4d8NX+wqRuijCsgkbWidve6a
	RE29nVXIhvm3HJzvDqHQuOVWsbG4nZAJDHcHQ1213/XrjwuU3DqV/cSsrlDq9omis1DW2xi6uyv
	9TBACvCusrRGt+kjn6AmhGeOsTf0VVuA=
X-Gm-Gg: AeBDieuqje/+S37dJ72SVx2jbN1KDsWONwBug7hV0SE6kISKWdqoTH1TVA+P/AIvtoz
	UICYU1b2BEZLYDWo+YAZExJ6PpruQZ8Chf8dEzm3pPKr8epmxmDXWMcAGBWIHHx3M4ymVklNID4
	t4Tm/TtHtcSUGnJgFKDSI9CUymXdcl0s9EpjIt4ny0GwHlGAsLBDX9vanP6YCsqPjQSfnr6Lhj+
	h0AXH8V7avJpQZ0XpJqU4v80Js0AYgJo2Rosx2rmFSjd5yOcIeuiiH7QN8+GAemjRUXfCvtHZKA
	UyijtpUAwhkGlMjZkHOM
X-Received: by 2002:a05:690e:11cc:b0:64a:d3b2:d3a2 with SMTP id
 956f58d0204a3-65199096b59mr16518933d50.27.1776261276068; Wed, 15 Apr 2026
 06:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413153114.3040093-1-lgs201920130244@gmail.com> <8afc6b6b-399e-4f77-82e8-3c0e717f765e@linux.com>
In-Reply-To: <8afc6b6b-399e-4f77-82e8-3c0e717f765e@linux.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 21:54:21 +0800
X-Gm-Features: AQROBzDx705EQfjAt7PwyLxjDvSpfcDpFcg8DPIUUm7RnvZjSrOx98S0HD6UZyA
Message-ID: <CANUHTR9MQ8GGpgtGDgRCmjQL_D0jW4E-2OER4Q784xbGd+nJSw@mail.gmail.com>
Subject: Re: [PATCH] floppy: fix reference leak on platform_device_register() failure
To: efremov@linux.com
Cc: Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238135-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E199405106
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Denis,

Thank you for the review.

On Wed, 15 Apr 2026 at 21:00, Denis Efremov (Oracle) <efremov@linux.com> wrote:
>
> 1. Let's use platform_device_put()
>
> >                       goto out_remove_drives;
> > +             }
> >
> >               registered[drive] = true;
> >

My understanding is:

For the platform_device_register() failure case, we should use
platform_device_put() instead of put_device(), so the failure path
would look like:

err = platform_device_register(&floppy_device[drive]);
if (err) {
        platform_device_put(&floppy_device[drive]);
        goto out_remove_drives;
}
registered[drive] = true;

>                 err = device_add_disk(&floppy_device[drive].dev,
>                                       disks[drive][0], NULL);
>                 if (err)
>                         goto out_remove_drives;
>
> 2. We also need to fix this case.
>
> platform_device_unregister()
> registered[drive] = false;
> goto ...
>
> Thanks,
> Denis
We also need to handle the device_add_disk() failure case for the
current drive, since out_remove_drives only cleans up previously
registered drives. So this path should explicitly unregister the
current platform device before jumping to the common cleanup path, for
example:

err = device_add_disk(&floppy_device[drive].dev, disks[drive][0], NULL);
if (err) {
        platform_device_unregister(&floppy_device[drive]);
        registered[drive] = false;
        goto out_remove_drives;
}


Is my understanding correct? If so, I will prepare and send a v2
following this pattern.

Thanks,
Guangshuo

