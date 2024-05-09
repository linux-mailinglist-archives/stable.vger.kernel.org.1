Return-Path: <stable+bounces-43514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828BC8C1826
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 23:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3978A1F217AC
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 21:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49F85270;
	Thu,  9 May 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXZ4kdYj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD584FB1
	for <stable@vger.kernel.org>; Thu,  9 May 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289134; cv=none; b=JpxoBU6DS0rZr5ezkhvGqE8Az9+v4yL4NbN8m5E3TrgKj/yJCGMkVEBCSLyfxe86xfdmV1pIjhMKh1zZIW+tTRxVZnTeC9qxBwKye4JW0V0p+p9HhVKvenlM33GmKYF76DyMcQaGzlo6ICD5DAlevP7ohHj2LqPpn1HM6K9C/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289134; c=relaxed/simple;
	bh=GoXYrd7dicaqnmSpnOwygXCpC2py7G+x/HeNV0GmZKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNKSeOd8cjHP4TaAyndDEDVYHWvETcc2hD+C0ZkYqau5Tvivq84ZKVd13r3b9VEjJVkmRZhth87Fmc9RX1meRvOhdSKxl3a/p2ltOCVNukWTrtyNpjUyAxGZywO9eWans6FFtaeA3P9rwzWFdquNFwb0rlKaMyj/k39G92spK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXZ4kdYj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715289131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kHA6/aeevN+iRF1+w07RanccRf9FAorS/DmVI5C2io=;
	b=XXZ4kdYjkF+oKNOuTZL8YVGzwq+SqVeAxV3G/BAAXR7LWjZEEf6nat1sobOrkY+/RHKK5m
	hlYC28W1VJ7LP0QQ5osNO39hqy0fi3GN2FIVmv3zEgBYfuYN9bjj/C11I22OgCbVmsKaPL
	WCamZ+pSOl1wBW4UjzOxcsHKeWQv5Tg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-AqQ2VCXpNbOj3rMVmufo-Q-1; Thu, 09 May 2024 17:11:52 -0400
X-MC-Unique: AqQ2VCXpNbOj3rMVmufo-Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ee128aa957so1363259b3a.2
        for <stable@vger.kernel.org>; Thu, 09 May 2024 14:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289111; x=1715893911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kHA6/aeevN+iRF1+w07RanccRf9FAorS/DmVI5C2io=;
        b=uTZa0oIHDGrkCrHVSypj8/4AnA2ReQ9rQ+oyNk8dIA8Tg/clMs5j4h0M8pZyrRTMIu
         nkyMClO8DuKDmOFsRhItri+s9Zym/532ak+EAQNYtkhdEV9+EOs1khht3mLNWrAqeJt0
         AB5N3NKYtD1MiCQUuYfVVYKiriFCsPoIir4Iv/Jg2l8kTFQs9mcPiTcv9BCvSRKp7wbO
         eQ8OLpxlCynU+jiG1iOHJt2Mg6E/FHdjO7HA8E17iLiR4SpJ4KTLkQ328kagSCZMaDj+
         3mVoxlFJhAymxg8h062qkDDTCF2IeMITGLSyisHCSMzlljo3nkaKNk+U3dpJz99S+RyB
         Qg6A==
X-Forwarded-Encrypted: i=1; AJvYcCW7MtNxWvGY6CbMnJK1i/boBKdfMF/3/jygvqjA0yzCf81fo2Yi/q8OlDUNEr/vIpdTTKVxjdWpvLG6yeLX+fpqi7zwIm0+
X-Gm-Message-State: AOJu0YxiBXxrdi7dP+YDGjc4GKWHuHiGNnsNbM3Oe2yn9si6k63bRF+v
	12p5I8nmu07kXwFOWW0ugKBger71xwAFU/ZWhxp+mAPhTBNejz2QkSwL9BNojp9mfpgfN7J6xGI
	QtnMYcq5R4AY9BrkFLpUE+XJ+uuuZ20qqCUQ/PK0E9s4JRwv8LwnBVr53UKMgmR9rAXeS/UoYnk
	fy5ELogPefnLZrj7HX6d7J+gVAWLDo
X-Received: by 2002:a05:6a00:9285:b0:6e6:98bf:7b62 with SMTP id d2e1a72fcca58-6f4e02ac4cdmr745598b3a.8.1715289111136;
        Thu, 09 May 2024 14:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOeAuLy32ezsJj2r1M7Hca10qZlE0XUfZZcm6MULvRBLOnlB/aFauj8MDw1aUvDiKiKEQTpiYrLQJPHEHvMxs=
X-Received: by 2002:a05:6a00:9285:b0:6e6:98bf:7b62 with SMTP id
 d2e1a72fcca58-6f4e02ac4cdmr745574b3a.8.1715289110746; Thu, 09 May 2024
 14:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506182331.8076-1-dan@danm.net> <ba0bc464-a06a-4c54-945a-202dca2c4e49@leemhuis.info>
In-Reply-To: <ba0bc464-a06a-4c54-945a-202dca2c4e49@leemhuis.info>
From: David Airlie <airlied@redhat.com>
Date: Fri, 10 May 2024 07:11:39 +1000
Message-ID: <CAMwc25pJqmNwpRvD3-Ahf66_XB9yFMxhSvU=M4vBMdhVSYS3PQ@mail.gmail.com>
Subject: Re: [REGRESSION] v6.9-rc7: nouveau: init failed, no display output
 from kernel; successfully bisected
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: lyude@redhat.com, kherbst@redhat.com, dakr@redhat.com, 
	stable@vger.kernel.org, Dan Moulding <dan@danm.net>, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:31=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 06.05.24 20:23, Dan Moulding wrote:
> > After upgrading to rc7 from rc6 on a system with NVIDIA GP104 using
> > the nouveau driver, I get no display output from the kernel (only the
> > output from GRUB shows on the primary display). Nonetheless, I was
> > able to SSH to the system and get the kernel log from dmesg. I found
> > errors from nouveau in it. Grepping it for nouveau gives me this:
> >
> > [    0.367379] nouveau 0000:01:00.0: NVIDIA GP104 (134000a1)
> > [    0.474499] nouveau 0000:01:00.0: bios: version 86.04.50.80.13
> > [    0.474620] nouveau 0000:01:00.0: pmu: firmware unavailable
> > [    0.474977] nouveau 0000:01:00.0: fb: 8192 MiB GDDR5
> > [    0.484371] nouveau 0000:01:00.0: sec2(acr): mbox 00000001 00000000
> > [    0.484377] nouveau 0000:01:00.0: sec2(acr):load: boot failed: -5
> > [    0.484379] nouveau 0000:01:00.0: acr: init failed, -5
> > [    0.484466] nouveau 0000:01:00.0: init failed with -5
> > [    0.484468] nouveau: DRM-master:00000000:00000080: init failed with =
-5
> > [    0.484470] nouveau 0000:01:00.0: DRM-master: Device allocation fail=
ed: -5
> > [    0.485078] nouveau 0000:01:00.0: probe with driver nouveau failed w=
ith error -50
> >
> > I bisected between v6.9-rc6 and v6.9-rc7 and that identified commit
> > 52a6947bf576 ("drm/nouveau/firmware: Fix SG_DEBUG error with
> > nvkm_firmware_ctor()") as the first bad commit.
>
> Lyude, that's a commit of yours.
>
> Given that 6.9 is due a quick question: I assume there is no easy fix
> for this in sight? Or is a quick revert something that might be
> appropriate to prevent this from entering 6.9?

I'll take a look today and see if I can reproduce it and revert it if neede=
d.

Dave.


