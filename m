Return-Path: <stable+bounces-40415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2B8AD955
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A4D1F21B00
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5206145BF3;
	Mon, 22 Apr 2024 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VeZc0T32"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C944366
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829930; cv=none; b=fZzDX+cJaUe7/gQjHaVfUatl0/r1qJeY0JJie7vZhxjqPveZ4Uw+1/a1jB+GAstkCAdpJjBz2e9iSG/P1qfFjKdgCbxYxyJT7gKoqeIdpGxRBQ754awzFIUB7pInf7Iq2s5V1lIOUZMIr1NJMnXDoCzfLFhGV4xqfcV9TvQD7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829930; c=relaxed/simple;
	bh=4r98zwDgiy1YfXNKtIkT0ExLUuEswdA2nBvFO8XbVmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMsm6aIvpksg6Gwi/Xz/vnU82vem+2+BOuy1dWNzwM1YFES/EeFpgZ+IwS1wEKRerPaW4MLHRqPUb+4dY0zbAwh/eXf1Xn609vxB50EOJaKtCSJoiDhZBxm7SkXpx+SGL48C5lg+Glw/9cXCLkBrPZhQmtMsJcOGxmq5aR5tzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VeZc0T32; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c709e5e4f9so3443431b6e.3
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829926; x=1714434726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFMZDFCKqtRsg+Es89BVufKPl3Pj2valoSZO9ZIhMr8=;
        b=VeZc0T32WzEUv4/+biDjr0w/2Cbn0OdVnZo3bZVW9GoJDPfIUJgI2cMogIQZdmIIip
         ZOFTPdMhPLLvN+vYVcUB3FtNba/KZI6ulVTcJQVH+mECP7PVx5kH00blshuymQbA+8SJ
         uN9cn6wA1GZxP2s9sgwUKATDkMNOSsYTkoEug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829926; x=1714434726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFMZDFCKqtRsg+Es89BVufKPl3Pj2valoSZO9ZIhMr8=;
        b=ODr0ulkW0N1Xy8yFO1OYCrsRZ1ujMuk57auSVMcQ7z5ubH6ivT+ClSAZWErS8fj6no
         q7tIvnYznVO6ha0bS00QhYBsvBH/AZFl3QxDmtOAnPzokigLlKhqDDv0pvIIIc68PC6N
         P+nv42UP6xm7Wr9poiToyQ3HRv4JHL2mINTNFBxWtb5ap/RyiIUsGnzWYkZBSY3w80vx
         Fdj54zGEfiuyvSXN4vtXqmkLItoIgkDBqdoMl/fUsQizNrH4EgsBJcVxr8e9gwMmiLE4
         fUBoPjsDp0D5aXT2twa2m8GdJDdVuiPwcIPbY/Aat6RU2WitMV2LSwa08Nsu+0/DYsSI
         YwzA==
X-Forwarded-Encrypted: i=1; AJvYcCWa0d/YAlSDXGVtbfmTsUI30sTER+IAT4sHlVxMZu6q79lb4+V5VvubsDCj14lsoWujcK+5NdOgnQGIziJX4FOPglyGnSNU
X-Gm-Message-State: AOJu0YzMsajQVRpmx+FQAg4eC7TNh9IDfXa1RVgPTW9pMr24H7pdEIfQ
	DHGNDyyjO/k7s0xkNZ+gMBLkFbpmWaQXMGTjE8QEgqmP/7z0OICZR4Vyqwg7spEPNZA5F4l/Zcc
	01EQI
X-Google-Smtp-Source: AGHT+IHQouib35fEvjrFJaI2DD8nSuIoE6zWO/CDNP20agib1M8KsAg54R+YhcV8RVc0p2ibAUhofA==
X-Received: by 2002:a05:6808:1190:b0:3c7:4b9c:122 with SMTP id j16-20020a056808119000b003c74b9c0122mr15212500oil.25.1713829926015;
        Mon, 22 Apr 2024 16:52:06 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id u9-20020a0c8dc9000000b006a0643df113sm3592957qvb.81.2024.04.22.16.52.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:05 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439b1c72676so100911cf.1
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwbud6W2Rre9ih/JzxGSVeTH4rqSEAaQucaqBlPrSDA5TfWKuOUQnnjx+qHcHowLfHfoLImv63gm66lGkmxrTAFppiA7jq
X-Received: by 2002:a05:622a:50a7:b0:439:a613:c4fa with SMTP id
 fp39-20020a05622a50a700b00439a613c4famr129884qtb.18.1713829924524; Mon, 22
 Apr 2024 16:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:51:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VrOSN8VFaRwH-k4wCLm6Xb=zJyozJac+ijzhDvH8BYxA@mail.gmail.com>
Message-ID: <CAD=FV=VrOSN8VFaRwH-k4wCLm6Xb=zJyozJac+ijzhDvH8BYxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kdb: Fix buffer overflow during tab-complete
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:37=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently, when the user attempts symbol completion with the Tab key, kdb
> will use strncpy() to insert the completed symbol into the command buffer=
.
> Unfortunately it passes the size of the source buffer rather than the
> destination to strncpy() with predictably horrible results. Most obviousl=
y
> if the command buffer is already full but cp, the cursor position, is in
> the middle of the buffer, then we will write past the end of the supplied
> buffer.
>
> Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
> calls plus explicit boundary checks to make sure we have enough space
> before we start moving characters around.
>
> Reported-by: Justin Stitt <justinstitt@google.com>
> Closes: https://lore.kernel.org/all/CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+Lqv=
C8deA8GziUJLpw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Boy, this function (and especially the tab handling) is hard to read.
I spent a bit of time trying to grok it and, as far as I can tell,
your patch makes things better and I don't see any bugs.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

