Return-Path: <stable+bounces-65397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6838C947E6B
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151C31C21D14
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4315A86A;
	Mon,  5 Aug 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q8QUGhS0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C655155C8D
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872645; cv=none; b=C6dqmOQyCJzfrQjjfZ4E+v23mR13Jbe9e7NMfHeCocJqQTFc0nlGw8hdkG3EZw6bMEGorIru0VOtJimUO0kF+iDZ6nOaFGttjSIVuwS8gMdD/y9c5GSbgjjx/YtVnRxbxJxTmsaJaIMMHVuBv9qS2fOndR19MU49gk55cHDO2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872645; c=relaxed/simple;
	bh=WJQF1e1lGe1DHP8xXL81uq1JAQ4RrIakU9ICRRYsaow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ0XbFD0iqBTLri1UlmuXyAAtPwmKdJ9gs2Q5ljYPcE3P02c3NV0I4MEAHAuIjAPDrvhUGl+JJ5kgxhIKT7dsGNq1u4n220Nc1njilovCr9tNiLZ4QZ6Pmhcc4B/o0iC+Inij2Pzg0nHeynr2oafM7TrYSP3zi3z+qPtj8ovG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q8QUGhS0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-447d6edc6b1so51838731cf.0
        for <stable@vger.kernel.org>; Mon, 05 Aug 2024 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722872642; x=1723477442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chvXENSfxaRr9pj6GM068Pc8pK4QQqniclzsqJg41Ag=;
        b=Q8QUGhS03sv1yZ2cpQOLBjhaQUNEMgaBH+YWYVEJzzO0qIZkYn2Sl4/ldILE2UNMKi
         Tfqb+x1ntu2xbrfy0csL5OHUSry58tTbox14Sx1HQexBwS3UAX0inTLJaWV7GXNfv3Xl
         WUY+XNrJoFH7OlBKCJs1b+Yd1KPSRewT+2zw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872642; x=1723477442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chvXENSfxaRr9pj6GM068Pc8pK4QQqniclzsqJg41Ag=;
        b=rjg9CUhe4FboFbpnYJE4zPhCkJnwSZzJeKmP4s3ENSXKRwamQjyHNM/CH55bfuDLZ/
         B/fLUo2HofBPEn2kK0psgEUEDsxFPk2TFJE78Y0x8uZnWhbpNaZICtet9YsI8uKyffkZ
         1L/zr45QQCNQnjESed9roml17vFChO51ry7BiNUrpIV+wf3zlbO3G1JrF7eUDoO1EAGD
         1Ah9YFfbw8EQn76GKp/DNg992cOeD7AU1aXQwO7lphSUw40eChwlwYz4uc0E1z3ZBUwF
         8YausLqLAbRUvb+MaqAOgBP48MV5smpqGSXHY5YGDT5Dg5z1LkFZz6SgZ/TYwstU5ILH
         ChJg==
X-Forwarded-Encrypted: i=1; AJvYcCXES+8LeVfhZ3aFGBF/UURQmx3YuCP6JYpEf+2zGW9ph2lswRr7DEEUnEditkYCV4Mw4r25w527uvxX5i3gOgonrmN+87gp
X-Gm-Message-State: AOJu0Yy+hmQGEmdwSAU9aD/wzx1zhpsEunM/fGWzDyomICzcqeay3zDa
	IeH3Z6W4Sh/z5SPT2o1BkxlKUwPq98O3Y+8XmIE0PacWrmy4AWOfZK5dgtTBG4n57iDkVmNrZHs
	=
X-Google-Smtp-Source: AGHT+IHF36IsAh9jHR8niunqdTcY38wpzPTBeO61MtlgPHM6WOykFN22+EC7AmP017Mjf4DJF9U1XA==
X-Received: by 2002:ac8:5acb:0:b0:446:63e9:dc81 with SMTP id d75a77b69052e-451892cc1a5mr130496321cf.63.1722872641463;
        Mon, 05 Aug 2024 08:44:01 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a7572c3sm30449311cf.60.2024.08.05.08.44.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:44:00 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fee2bfd28so462881cf.1
        for <stable@vger.kernel.org>; Mon, 05 Aug 2024 08:44:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSpJcpHdYZn/Wv/8ZpT/D9XxPO6mWkZXiT6mub2pytcisaAeAKAOnHjcn6d+ED7OlOBlBdc2KCCQVGD8BXmVPMJfJkMXQQ
X-Received: by 2002:a05:622a:591:b0:44f:ea7a:2119 with SMTP id
 d75a77b69052e-4519ae21848mr5655501cf.18.1722872639887; Mon, 05 Aug 2024
 08:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-4-jirislaby@kernel.org>
In-Reply-To: <20240805102046.307511-4-jirislaby@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 08:43:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1a1a=kkJ9bWXWOmu0hz6HqRuK=Vo=bhvFfSzeAWSWyw@mail.gmail.com>
Message-ID: <CAD=FV=X1a1a=kkJ9bWXWOmu0hz6HqRuK=Vo=bhvFfSzeAWSWyw@mail.gmail.com>
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in uart_poll_init()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 3:21=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel.=
org> wrote:
>
> Coverity reports (as CID 1536978) that uart_poll_init() passes
> uninitialized pm_state to uart_change_pm(). It is in case the first 'if'
> takes the true branch (does "goto out;").
>
> Fix this and simplify the function by simple guard(mutex). The code
> needs no labels after this at all. And it is pretty clear that the code
> has not fiddled with pm_state at that point.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
> Cc: stable@vger.kernel.org
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/serial_core.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Thanks for the fix! Looks good.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: I'm happy to defer to others, but personally I'd consider
breaking this into two changes: one that fixes the problem without
using guard() (which should be pretty simple) and one that switches to
guard(). The issue is that at the time the bug was introduced the
guard() syntax didn't exist and that means backporting will be a bit
of a pain.

Oh, though I guess maybe it doesn't matter since the bug was
introduced in 6.4 and that's not an LTS kernel so nobody cares? ...and
guard() is in 6.6, so maybe things are fine the way you have it.

