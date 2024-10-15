Return-Path: <stable+bounces-85079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440C699DAAF
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 02:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757B81C21565
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1638F77;
	Tue, 15 Oct 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSGPyvmy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97AA4A23
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952221; cv=none; b=V8bWBWaFTIzMkqGCfE6QgVuP5vDCaDdCsFGrxiXdgJ8KIpjDTPM2vlAOKgXeBUehUt6isvftCOG8fV8GD9JADpVkMb5FTvRJBSS8uf5rbxE3anXzO7ZvODwigYdI1HGx4CLpu+XxUG6O3MQ2A5bQ0ImQsOStoYFPPsRi9n4YaFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952221; c=relaxed/simple;
	bh=nJZ1QWkTV0MZm9WgJo4U6AQhnf5be0DTLzOoclSeVys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euPaX00OCYwipU11juubWF1zML7wiu/S4E2auXaS/QLWPFR4U3RQ4DG9S878r5cTwhwui3vcS5l96cU/IZh76KZ0aj4le+itL2ulxIe9+AZpFiI18QWlOKhQnYRNGEkySAm0OBEFEN1hj7Nqj3KOzJxDvKJjF9zouJ5feTXlUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSGPyvmy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4612da0fso3450406f8f.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728952217; x=1729557017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WqzwA+or3NqGNBho9kDhIYHCDYygL6ZXy4nRRa0QQ3k=;
        b=lSGPyvmyiC88GB7L/zlIBOV05oHEHYiQy5IYVIdmd/CEsgiqEs1zdHIUxH9/ZubJrl
         pxlNlZnOjx9GxxKI1gLHI9gCSjbOhgDDctrdM1mXpU0Al0CQQTdIH5G5SkraYttIljmf
         G/UEPmz10YgBNO+ZwV1iBSc7ong0fmz4rRbJvCI/XUugHSYbWyVRMei58FFB3hlkrJJH
         AlSsVA6gDAdFS9WRTj1A93jToBIhCf/XOg+jKRhvRdpnPFarbOmqX7/HQJt5z3pW73Y0
         MzkmurdctiYx0IUPdHy9bz7LngzKCWJ+h3PnSAhQFp8WeiU4zPJoOgC+7m0tPUozDhah
         ChQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952217; x=1729557017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqzwA+or3NqGNBho9kDhIYHCDYygL6ZXy4nRRa0QQ3k=;
        b=jX3UQKRVtTmOcGorNWnAFbDqg0TS+TfHNOJMY5TfVXh/0BiwyXt76lNBzjnuLecclI
         YHp84h/SyAUIDLtCM/86LeLqK7xQGm3XpehO31zJpJY2l301XBJkFLjr89o2epKsMxZp
         0BlOW4VhHONbJFYFzH8kr1b4e0yArTvNPMpdUu1JjHL5qdHs8buAcQjTytU8mic4u6jx
         QThSDrCKwXybLJ0VZbOHLkxDGRWqN4RsozCDK8WMdpB7R/YRYqQaYoh8PKMpzqQdFeul
         u2z8mhM+BVhkVLoHxtIGS8r3PxzZBu6ItxK2ZpelO3do+dTj29x8QRZVa3qoFRvMKl+O
         BC3A==
X-Forwarded-Encrypted: i=1; AJvYcCVp0UKt2vhM83Lnk2miCcztKPC7av8jzMbZ4v2kDwHfZZmaQZihFMpB8FQ6+1WJ99JpS1ekSck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgEPfakCVmL2zZfkaGa9TwQNROVhdwgBPeWiaJ108riCX38pi
	M/aegxJchgEpeRbJAdxWybFykwchjV2Ecv6jSVTJHiVK3rAOTkSdLLuzDvqlBDB8ujcjXBKeNk+
	KzB4LhrZdm51YOjF4UbMWCN+n0UtQBvg0
X-Google-Smtp-Source: AGHT+IFPAxDn9Ocl0LS03WxYc8aEQzGGOLCCAjLOCm3WRw4+Fkxt+cvbLLevHQD36JPExtOkdy+JI3CIpchS01moSbw=
X-Received: by 2002:a5d:504e:0:b0:37c:ce3c:e15d with SMTP id
 ffacd0b85a97d-37d551d9cb7mr9596165f8f.14.1728952217042; Mon, 14 Oct 2024
 17:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205211233.2601-1-mario.limonciello@amd.com>
 <20241013213103.55357-1-stuart.a.hayhurst@gmail.com> <MN0PR12MB6101BA1509A6D9B6338EC8E9E2442@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101BA1509A6D9B6338EC8E9E2442@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Stuart <stuart.a.hayhurst@gmail.com>
Date: Tue, 15 Oct 2024 01:30:05 +0100
Message-ID: <CALTg27nH4FfnRi8js8hqh1_C-As-Ouw1Q5FGKm-9Bm8p9c8r+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Rossi, Marc" <Marc.Rossi@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Is this on a mainline 6.11.y or 6.12-rc3 kernel?  Can you please open up a new issue with all the details?  You can ping it back here.

Currently a Debian 6.11.2 kernel, but I did reproduce it with a
mainline 6.10 and earlier versions in the past.

Issue link: https://gitlab.freedesktop.org/drm/amd/-/issues/3688

