Return-Path: <stable+bounces-50188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C029048B2
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E761F23E0F
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B326FB2;
	Wed, 12 Jun 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGj9ArJl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C74A15;
	Wed, 12 Jun 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157629; cv=none; b=KVjF2vXmXADNDjdxttr9DF/thNWY4N48nTmmRBX2Kv2GyEo3gN4FkYNREPRgazpKHXuVHxp6AzdyNahh1qmiePl+NlIVqIh6EF+jxKGxm6eHXic+iTiTOmiey8m0XsfT7oq5UovhDWmy7sfwdTQerGArkMYtc8POHo6nweeKnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157629; c=relaxed/simple;
	bh=dxXi6ytAQbOBXOqgkVPcfqxBW0bnb4QPSPbX/emC1o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5Zr1aVP1kU40yR1xr9IzZc/g1QbWqpytqZzmxd0BapY76FHouvlG8K2V9zKgvnqI9F1MTt5Ly9QUHqL2VHgo69m0j3Wj2XMcutJ5QBdYZD8koetuTrrpup+Ym+jT5sL8swAEyJkML8cXQUDpYM9JobyMzeIUaE2rvdYqPWNcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGj9ArJl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso2276835e87.1;
        Tue, 11 Jun 2024 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718157626; x=1718762426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxXi6ytAQbOBXOqgkVPcfqxBW0bnb4QPSPbX/emC1o0=;
        b=mGj9ArJlKojIXdPhmTsj4LklKDU97XIQVFsolZvezpSlXQb31oej4IgMcR309lTPDG
         IFx2VoMKWknB2bIiyD0P7hL3koJL1eFEi98Xupn949NhYF9/SBeLOZMlQ0v/5d/rHsOX
         I3W5YO3kW/fRamXRhxDKVgDghHqvjPXGzUpgfNAyAxDkcH9KiZVvrbGKGE0ryIVntZ1j
         vez0X5Sh4TVEZvlfYjt690NOhx/nOWrd3vjC+O1OuL/gIuvHUzKyv8edIX9CIUftef0K
         9lEwzFdn4e0EF/D1Q0EHyDOw4EkIhBQ0lSYVSR6JpibkpvZeKs8fKy8PwILJJ/rl8f4n
         GJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718157626; x=1718762426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxXi6ytAQbOBXOqgkVPcfqxBW0bnb4QPSPbX/emC1o0=;
        b=MasaN1ZTwyMtRM9d+8BgPx67xNQfr+WTM1gkBHV887/8ftBCRxltaWmNyWmLBLMvOy
         HjZVdFOzDI1URxaZsYVUlM7Kg5A46FG+aZCvkye2nYVN27vF7ALLlYs19xNXMob9fTcC
         SWENIDBe9G1f9KtjwE3qDOlmVmNflm4Zfx05vGS54uszoF7DPFjZfPazzTJK9zhlbdzU
         DYkYnXOXAcJ/XHUCNFBjUYtirfZKY2OFqjSBb/P+UcYqqKCSMac5Fl+eQ3WLhozt+wRn
         PBt+5YJcsDZVueAtxKiKX2LgQAhMazHw8zvvmyqYRjzaegdfi3PKmDUypYgiSp8AXVsS
         j5ow==
X-Forwarded-Encrypted: i=1; AJvYcCUFODM0KYXmJeH9/o2vqdAdBMHZDFyeirrSdf/7Gds0IiWqb1Z4647X5RYufyb+DkfUbz3+UOKVuH6LW4IG9xdEc7ExIeak1p1sfG6ONnoqcbgqXIHrMIiLeJbD3NRANyV6mizp
X-Gm-Message-State: AOJu0YwXsXzx66K+e0QCSOB2lUj8Rwx9tgwz/xAltCijr5LQPRo4fFla
	xJ+oQWbkGLQQz4ENDH+xPbAnQTu+SyPYu2ND9zIr7Tm+oXf1/GNMlwI3lSAE3k5lEKaY2gWIN6g
	Ro17ADLx5dNMYZuCKOJ6evR30CgA=
X-Google-Smtp-Source: AGHT+IFi4zE0NNyW5qtAbVp0N7wCudL2WMqMEeyo1zEjzIJHDmc8wJeq/lgtYvfuuBtzlZj1NXHC55VsaZYV27XOmWg=
X-Received: by 2002:a19:6a0a:0:b0:52b:863a:59b4 with SMTP id
 2adb3069b0e04-52c9a3df5bcmr278585e87.41.1718157625899; Tue, 11 Jun 2024
 19:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com> <ZmiUgPDjzI32Cqr9@pc636>
In-Reply-To: <ZmiUgPDjzI32Cqr9@pc636>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 12 Jun 2024 10:00:14 +0800
Message-ID: <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:16=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> >
> > Sorry to bother you again. Are there any other comments or new patch
> > on this which block some test cases of ANDROID that only accept ACKed
> > one on its tree.
> >
> I have just returned from vacation. Give me some time to review your
> patch. Meanwhile, do you have a reproducer? So i would like to see how
> i can trigger an issue that is in question.
This bug arises from an system wide android test which has been
reported by many vendors. Keep mount/unmount an erofs partition is
supposed to be a simple reproducer. IMO, the logic defect is obvious
enough to be found by code review.
>
> Thanks!
>
> --
> Uladzislau Rezki

