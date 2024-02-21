Return-Path: <stable+bounces-23211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5DA85E411
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6817F1C226AC
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BCC839F7;
	Wed, 21 Feb 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WapNL/AG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED47FBD2
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535430; cv=none; b=NUcqtND78eHd+tDqvZ6ToCko5tuvQz5G5hWzEehBK6dOl+53JG5f740tWLmcB5Z6elxozbgnN7UV0uT6JIC+VHvZmqISKsRHNiERs1luYeP3lXN+1ihalnr3rs8WvN1xm2XPJudPogzV59GrPZou74ZlpnkODz80kbf4FLEnz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535430; c=relaxed/simple;
	bh=3tDTAL3bkuSeNF01dYYjqUmFFxUsUZInOi8GJnTJyoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7utplj1lCPp6SWQvFhdQODfVlrEw6q10m8d9n+Q9OUb6s8fJ86m95fDz5rgE3BsEwCp6ZGRr7ZrRMg0EZ2Nn1mz3+r0h470v3DcC/hKtzLmiXYBBmHgnRQSqkKC5Hx6KqB46cn4uLZ/ER2Q7ZRPwbb2Jy6sktYM7X6g1CXdOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WapNL/AG; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2e1a0337bso3544966241.3
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 09:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708535428; x=1709140228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L0XbTRXpjUJdsD0Ct/U8d4Gr21Ku2zlDm646h3XyY2E=;
        b=WapNL/AGJ7b7Q9ULHoJfXZlq1cxE0QSKH2x2eZz4mgJNYt0LN8wzmGXKDs/opFBiGm
         fO69+ExkfUO5spvo8AnBaohV4zD/O0K2BJyKCZeGzQ/Rzlmg5KMkauOtTCiWP11uqwfA
         K3wmq3Ufxrc9dMwswq6aNIUAQcIWS5BDFlM0gJhEy0imUEtQs1CJYMCAB6Cra6vlDPqe
         h+CgpLmabka6SmVjTNNp6VvrZ820cvBnaP9PDX1w6IDIbChnUmZXHVuARuNuVXDG5nIL
         9KoXWLMYOV1U+SPZ7RmVpoefBO2bwO0NUKvOT8/VfFuamtegm2kBQgcIsKL0DzjLrSQo
         nFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535428; x=1709140228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0XbTRXpjUJdsD0Ct/U8d4Gr21Ku2zlDm646h3XyY2E=;
        b=YsUrSTt/N0nOFS1Z3yLIlFi4DkSjqHNs1MeC7FBXWwzd/xN2xJ7LSczklb8NdWmalk
         SzDnBUVYS5TIWAS/i8ePr/3ri2XFWMuPON7V0JkjUS/jY1mNjp/juSGmSjXJxD0Vg4fC
         fS0dyQbcCHP83/abzOcxhNNolAHKuCIUBRdYuYgvZe/WyehwzsIYI7vT38SxYUhzpZG5
         cLLolLDLCh5lr3tY8RZAwzvZ27daBaThkygtMTztMAxMsl8HHPw1g2qFnZ2E5emQwlt/
         0RURMaqSYdlIPFNKJuqrYtVHcWDZlE5snyFEyW9Cq693iMHiqQWauvE4TXiKYt1OJj03
         8JOA==
X-Gm-Message-State: AOJu0YyhE+KZV+nkvKX388fF4tYhp8xFhsBxfL32Nl8LezgvitxTD+bX
	BY+wUzFSHD0xxLZ7wUmcX3JuHdM/TOVolaqEunLLS4gIKdry/NfSLbDNG9abqhdnlZcHuoAg5/x
	SaKj8CIugpgH/+JV2uzk+OW8FrlwX3UEI
X-Google-Smtp-Source: AGHT+IHa+0CyfrxQoqLiE2FJC+OlCkL46CyHJ5yPDgC3s/oQkeqfvLi/77QFBbKmwwJZT68rGNgGFij+qW8pbKAXQW0=
X-Received: by 2002:a05:6122:218c:b0:4d1:34a1:c892 with SMTP id
 j12-20020a056122218c00b004d134a1c892mr2852670vkd.13.1708535427662; Wed, 21
 Feb 2024 09:10:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMdWSKyoAgFHiSnfbPKELB57295VTBqh-mvjPd--MCDU-uvyw@mail.gmail.com>
 <2024022141-bonus-boozy-44c8@gregkh>
In-Reply-To: <2024022141-bonus-boozy-44c8@gregkh>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 21 Feb 2024 09:09:40 -0800
Message-ID: <CAOMdWSLr7zzux_gSRQG-6NEprF_SsHNhB=cWG=gnON7go=d2_w@mail.gmail.com>
Subject: Re: Patches for v5.15.149-rc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Hi Greg,
> >
> >    I believe these patches are likely already on your radar. I just wanted to
> > inform you that it would be highly appreciated if we could see their inclusion
> > in the upcoming release.
> >
> > e0526ec5360a 2024-01-30hv_netvsc: Fix race condition between
> > netvsc_probe and netvsc_remove [Jakub Kicinski]
> >
> >   We would like to even get:
> >
> > 9cae43da9867 hv_netvsc: Register VF in netvsc_probe if
> > NET_DEVICE_REGISTER missed
> >
> > included, but the patch is still in netdev and has not made it into
> > Linus's tree. If it does come in,
> > could you please consider including it too.
>
> This last did not apply to all of the relevent kernels, please provide
> backports if you need them there.
>

 My bad. Am sorry, I should have checked and sent it out. Now that
v5.15.149-rc1 is out, I will send this patch targeting v5.15.150

Thanks.

