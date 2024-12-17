Return-Path: <stable+bounces-105068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC29F57EC
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45CE7A1E22
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A63A17BEA2;
	Tue, 17 Dec 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoUNqTF0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047D1EC017
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468047; cv=none; b=aS0WPhMzUsuRDTA9x90iGl6bspO1ueInTZ1770gyXyVokPr5RRF3XR3qQ9o8dnJgBWvrCP7HzWRY+s9G5n7ZP/rSg+VOyImQQbKoWoWupyhavZIUVqSX5EyLCtsc5Gj+uV9PPTC5CrXgBXh8C4ULWX/U66pP6jvDEaQpcuzxNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468047; c=relaxed/simple;
	bh=arhloySYvj0YNXV/9Ls0b839evIgS/1OVzPCdQHlq3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7M4827rKXQsKKhphhC4flnhOWSz0xSYNhOx60LF9ahlUt/K+KpkfzzmAvmERvgoPdOgZpt5BydVT2J4KFlJjHh16T0BjzZobNvgtkjdxP2Y/PVqP7HNHwuDCZDZbtPngkV5cwRWUZVUzGd29kEtWrc9AvlRrpFNpNcyss2MI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoUNqTF0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46741855f9bso49834131cf.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734468045; x=1735072845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arhloySYvj0YNXV/9Ls0b839evIgS/1OVzPCdQHlq3k=;
        b=GoUNqTF0ZcF9JFLX9U27/DmF8+QKIJOWEF3PCudxI5DdT3EFbVCyS+HJAC43eU/h9l
         GIqWgCw9auzpUpWViyDlrsaG1lUvj8hzqOqpNLpe5BhaofYqHBwFPhUkozihn9MXsVHw
         wnS53+fO/dcxEr+ZPiEUdgdngrcMAaO3nya58l07eacz/+Ym9DHzq8MeXsi31kznQpa4
         wU8LjYxyDvgVY3n+U9aqU6rWJxwF4xtbzP95807xZeilCjwOfXmJeW7eEXkhQMq2IGaG
         Tbp76Uwf2feAm9e8v/LohP+GtG/aIQL106Pk4fPaQbzVy9joQ1cMQZrmzkIFk+2TYT9Y
         0qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734468045; x=1735072845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arhloySYvj0YNXV/9Ls0b839evIgS/1OVzPCdQHlq3k=;
        b=wPItL9o4MLQ8BytKi9O3ZhnhzCmIqM+TjYP0ugWiOK7kI1UOSwWCq8mqpGZq9+3cum
         DTsiOSvz6w6zatYSbg517dGmzcXUn5okpF+lumsD9dQauD/6dKN6/RiG5Zml5AdMUcKc
         +ZIkbD1FmpeQLZffJ3m49ETrcNFOMe6uJsCLbvJItiT/8WcvC+Wpkq8bz0DH8WkbaqP0
         S3FCE3i38JRVt8RvoUA1egUEkc8Te/KIZTj9SGsIWyODmGoKc34qKOxBQI/i/u7Uj+NU
         Q2VLLioYFU/r/w3Y9SbNeqKKVl2urERZhOaJSWObAy3q2yjTiB5yT3BCbWpkFomjdNvo
         RuMA==
X-Gm-Message-State: AOJu0YzxUfTzPtamfV3GFkSVwu0CoCL61c+5Tt2MgNg+0XvMp16fgkoY
	PqFViWBsIGrrz8+fgsPeVkA93iAL8e/YsbnS1GQaRnFmqZ9hQBDDWCa4N12csJpPih5G0DaOoUj
	szxygbewAhtiBCVd2MA1B432iW4T9ig==
X-Gm-Gg: ASbGncsU7f0Zj9KgW7IEQaccc5EuSq/i3Mngel5ZbfGZeA1u44E4vOSMXdfI2VYPSQH
	YbbF6MaseU3E9AuKvX8xTlvfdlvfVuSlU4b9B5V0=
X-Google-Smtp-Source: AGHT+IEzn1NO6NhhfGxj2JEI4SNTGnwfuRgOKqdCwwdpAH7hT9QTK5g3603Y7rTqAwHoTeMEvVND81xgGmTpFmyt7QM=
X-Received: by 2002:a05:622a:1a09:b0:467:6c61:b706 with SMTP id
 d75a77b69052e-46908dbf247mr5708051cf.7.1734468045371; Tue, 17 Dec 2024
 12:40:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024121517-deserve-wharf-c2d0@gregkh> <20241216161840.4815-1-jiashengjiangcool@gmail.com>
 <2024121749-errant-existing-a587@gregkh>
In-Reply-To: <2024121749-errant-existing-a587@gregkh>
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Tue, 17 Dec 2024 15:40:34 -0500
Message-ID: <CANeGvZW0Aptvqbb3ZtGu6P5G_9By8h99Ot6tRdpfOLP0OxWpSA@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] drm/i915: Fix memory leak by correcting cache
 object name in error handler
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Dec 17, 2024 at 4:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Dec 16, 2024 at 04:18:40PM +0000, Jiasheng Jiang wrote:
> > Replace "slab_priorities" with "slab_dependencies" in the error handler
> > to avoid memory leak.
> >
> > Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
> > Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>
> You also forgot to keep all the original signed-off-by lines, and cc:
> them :(
>
> I've fixed it up, but next time be more careful please.
>
> thanks,
>
> greg k-h

Sorry for that. I will add these lines in the patch for 5.4.

-Jiasheng

