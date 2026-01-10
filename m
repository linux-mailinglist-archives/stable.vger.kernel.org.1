Return-Path: <stable+bounces-207967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A18D0D7EE
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4123029D08
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292DF346A0F;
	Sat, 10 Jan 2026 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF+qa6BU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83102FE05D
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057597; cv=none; b=Mw3iTk8YluRee1jgCYvGy5ahHL+akvNwFjm8qmXpHIIExPrEo+AoyWVooig+NgT6ZMx+lNCSXe0FHXzA6aPolcRznoRU0wze54ijKBbDpJ5iNrBlY85tNadKIeSi2Vte14RWTTB/uTFSqLOH8jtpfNmd9rBCsV8jjnyr0UVlEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057597; c=relaxed/simple;
	bh=WQvn+u+Jd2MUC1UEDqAxOjgH6JRsCV8dAvYV5oi1MsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGYSw92fbPDPcc1828tvpTeEpvEqLIQb/htgVyRhn+ZZ7DWPgyhDAh528FrdBhHYSWoSuQtrl3reIpGOcvk19lbWIKAFpqnoLrcTATLQC8VAT5ZyBUtLSzBCYeVhs90VcwFL4jwlVg6xYzy8/WMmiDdwffOV/NqXOOrtB7IS1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF+qa6BU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c868b197eso4450931a91.2
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057596; x=1768662396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UGkBqQ3dEyH02b9Cz6V2aAVzB1sEUkHSYsagBfz+8BQ=;
        b=mF+qa6BU1ujStg0lEkGcbm5gem5tzKZH4/Si+Nk3wK5yWKsj1cw5YsES7jUBiNcyuK
         CX/PnAy3vorPN4io7gjqdBYs8fAGjcfiyXcRhUaPMz6EluL7qwuU47OxZUBnoJmLzUD3
         9926Xk7OjAyF6b526C7hljqXmohs0yv/q9LiREIH5qvQ0rSFRFw9XG3bNJHPPlW+CvUm
         GTEsXp6d/p+ftoy+Duh8Q5e7e6lciIaJCeCTn01W9iSOkzSr+cFGF7sGS4jIv60CbY6c
         yTA+34YOkXTQf3isoa10Z/ORAuMpdoiazed0tKB3wIgWELb5VYxDVFnS93kk53ZMiHtx
         PEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057596; x=1768662396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGkBqQ3dEyH02b9Cz6V2aAVzB1sEUkHSYsagBfz+8BQ=;
        b=WiP2/Rq6AODMYZ4txF1HVCZOZG/tIxIFV77l769RAlDKsT4zORJ3sgAxjD6/JyLpBO
         qiiq7/sfjZ5ed5qrrWFkRk9j5JZeWfiRoBxRaE7ZO/8WAFA7AkjEj8BzSqA8wvWOl0r5
         NVdPOa/UHxppDR6r3Xu1ODtB4bG/wjpcVBHaTjCQ5oDA1jiEWzwXSorqw3mUVzWt8M/1
         F5jukS0T9Ixz/4fWPHv1UsWOLQl4X2tLZFxkROn2D9P+aZpbbNXAv4cRZXsxeHCpLH0L
         3Ra2ibIg2yVmgjQuEYoybkyZLlEIapZEnIjdoXq7HAWre/88dLk4R9s6OWf0M/vNuVPN
         iC0A==
X-Forwarded-Encrypted: i=1; AJvYcCVNB7pkM8Fxmikn1VTkZILPrD8QXmZ9pexsyc3bZj+gA/HmksbG36NMTufn2EJWjyRDuuevoLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4Uxi721Lk/6jVTVy5+A/08s2FHdMwk7DNgRMaS4eDKvqzoCY
	NQAB7VwC6S4Br5jh6+pWKCSqEtyrVcFC/k8lYJazjQ/0C4NEV1wCxb7dC1dCRzkVL0HkABEGQNu
	p1Do7bfCb93y3bwUNS6eeiWNjIkPUlCo=
X-Gm-Gg: AY/fxX7o0ZQSGv2K9HPMEn8b0iLHaAuFBdRA0Q+WA6p5FU2OvigHL/Lownerv45j49i
	BmxFWeaamWVHcchvN/pGhCGEYkPXjKliVc/huYVTNlE+2qLjWemv0hbkop0ohHOef4TxTlv49lQ
	oocCpx2GDdWDCK/eQSlBfmeWzWU/VJqCJZ9DPeXLBUivpdumqR28naRsLm4Fo+4Sh8oycF/9VYX
	nLVYzyDPBxrHMCKCwz/mW238wkocanGU66e2fXqvokl70OBu0By465pXdMPQDoKZa6XyixT8IR4
	Lelsj9Zg
X-Google-Smtp-Source: AGHT+IFzQQ/5f5DJe4nBElHnSw7Mgu6aLxPMI120DA2DbnwxqPMk6MVlVdDhGW69nPu5bRwxBN71E4Utx4hB5sJTCnk=
X-Received: by 2002:a17:90b:3b8f:b0:339:d1f0:c740 with SMTP id
 98e67ed59e1d1-34f68b83b12mr12282185a91.1.1768057595938; Sat, 10 Jan 2026
 07:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110145829.1274298-1-aha310510@gmail.com>
In-Reply-To: <20260110145829.1274298-1-aha310510@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sun, 11 Jan 2026 00:06:34 +0900
X-Gm-Features: AQt7F2rrBoH9FkuYqOWIJsvvsgVyWVOjjSL1GKk8EjPCgKiGJlK03oV7Mi8JbCI
Message-ID: <CAO9qdTGc8A0ge_pfRavAQNpsnjoUXz4-Sm_3dE2oVX7CEpmTUg@mail.gmail.com>
Subject: Re: [PATCH v3] media: hackrf: fix to not free memory after the device
 is registered in hackrf_probe()
To: mchehab@kernel.org
Cc: crope@iki.fi, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+6ffd76b5405c006a46b7@syzkaller.appspotmail.com, 
	syzbot+f1b20958f93d2d250727@syzkaller.appspotmail.com, 
	Hans Verkuil <hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Jeongjun Park <aha310510@gmail.com> wrote:
>
> In hackrf driver, the following race condition occurs:
> ```
>                 CPU0                                            CPU1
> hackrf_probe()
>   kzalloc(); // alloc hackrf_dev
>   ....
>   v4l2_device_register();
>   ....
>                                                 fd = sys_open("/path/to/dev"); // open hackrf fd
>                                                 ....
>   v4l2_device_unregister();
>   ....
>   kfree(); // free hackrf_dev
>   ....
>                                                 sys_ioctl(fd, ...);
>                                                   v4l2_ioctl();
>                                                     video_is_registered() // UAF!!
>                                                 ....
>                                                 sys_close(fd);
>                                                   v4l2_release() // UAF!!
>                                                     hackrf_video_release()
>                                                       kfree(); // DFB!!
> ```
>
> When a V4L2 or video device is unregistered, the device node is removed so
> new open() calls are blocked.
>
> However, file descriptors that are already open-and any in-flight I/O-do
> not terminate immediately; they remain valid until the last reference is
> dropped and the driver's release() is invoked.
>
> Therefore, freeing device memory on the error path after hackrf_probe()
> has registered dev it will lead to a race to use-after-free vuln, since
> those already-open handles haven't been released yet.
>
> And since release() free memory too, race to use-after-free and
> double-free vuln occur.
>
> To prevent this, if device is registered from probe(), it should be
> modified to free memory only through release() rather than calling
> kfree() directly.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+6ffd76b5405c006a46b7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6ffd76b5405c006a46b7
> Reported-by: syzbot+f1b20958f93d2d250727@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f1b20958f93d2d250727
> Fixes: 8bc4a9ed8504 ("[media] hackrf: add support for transmitter")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---

Cc: Hans Verkuil <hverkuil+cisco@kernel.org>

