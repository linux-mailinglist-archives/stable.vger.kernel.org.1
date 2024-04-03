Return-Path: <stable+bounces-35686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F92F896B01
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 11:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C231828DF6E
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1362134CE0;
	Wed,  3 Apr 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IrxgW6gg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3713664E
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137656; cv=none; b=GEWSU3VUmULr17CPnvHOHVlzszBeUhENBFzc005K42tySOX9aFpotn5ZmljFXF/tVwRHr5Al73CB3nE1eXh+vIerbfFCO5Ni3c35CYoV67PxdrBhleSoMrwse03PWC94XFndx9qJhB1ICB2s09+HrPakCqMFXByb2LmgPeaf1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137656; c=relaxed/simple;
	bh=qPteIPghEmNaFbFbiFtmdDCR/LlCAmuK8ocfUthHuZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctkqWSGMJc9VIj12sVrIWfINJl2aksDNsSfayy9hjaa3bp51ppQ2vxkqNK3hGqe+n2AY28sohzxJgMUgauq8JImjuhMDc+iw6O1KPaj3A7HIKpoThSfufNpz7ZCvx6OAjmuRrQRDloDGixprbarwrPKnIbLXWVbQS8H8YVMs8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IrxgW6gg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516a01c8490so649658e87.1
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712137653; x=1712742453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KABiyoA6kqLcaNOPFvDrUfGOgcIyRMqYJlYfREBWxQ=;
        b=IrxgW6ggp2laH/3u5v008fpHxZreyR21hYxus/LRUiAvd2IgTPhRUeu38SaK9I0Ddh
         mxUwKooL1kgXVcQ00aVGT7TK3KQZ4Q4Fmtge/oLlRp4aArlkZf4JDGJoZGTdQac9fIfm
         TQ0S03cX2SSGsCKhjWN89PiE/jafHfQQIh/OuvzGW5GmII8fMr+AaLrMm5hBRvqWm7mg
         9xfCRrqfIqYxUI5NJNiw1TmOPxPFNF2a54yK1iGOAh3rRY1RZi4b8g3gKi3sZw/L/LjR
         ydUvmXuL0qvz3J4mkfsVDDM24TEafweqaP1NWEGUMGoH1nAZsZl1U0a3WruvmWq3nI7S
         x1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712137653; x=1712742453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KABiyoA6kqLcaNOPFvDrUfGOgcIyRMqYJlYfREBWxQ=;
        b=oM18k5Uzr+eKTre02f/olSrYrtFMmWs1HsgviwTiQxmw5zX18heLmHD5tKp936phSM
         wXLGApKiUxgAx3qZNffXHvonD33U78HgvUWBsbFTpZmYYj8il2TwzQKSbpu5vlTp8XkC
         7ECPa7YHiC1sKqdq7yZ8EJooq3tOqE9kWX05nTEtxLpS1JLnDdMlOX5/O6ys1RnFuzto
         xWKwR7PzxTZ9KaqH3XEMU7+BCcxaLEoHc56+jHWX3qLEIVre+HIjD/TK666nhgjpjOlc
         ElFV2HVqkotPzmiazatI4kDNMtDa62xMX2dGKp+bUd6kE8bq2Lw7quUVYmguO+jiwSoV
         2syQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPwFU/e8+DINOATmTwkOJt7Vs99oXbhVLOEcQ99ThVkwu7MhVFSjixLvS+XQFPM4YeLOSG1ISLn7X5+lJTAW2i3EuBf09h
X-Gm-Message-State: AOJu0YzMysfHM+wvqLl7flTeoguZOeJZ0Mf2EDkjAApI5aG9LGpOjMO7
	Ldu71THIAw8AYjBwKuH+QW9xQHTKnoDPFpzg/hm2zk4SJfd0NF+yN7lGq3sHnYgBoHWvGee0ci4
	risdW5YB2qDjhhR+0RD8f2IAgo/crE05GZJXw9A==
X-Google-Smtp-Source: AGHT+IG3Db0aH5fVKWMjadssHxAGVYgs1vlEPlw4hlOgGoFOBb8OwTQCY0tQE/dJH4EGfGfs4wf5rTdQTC65LycruUs=
X-Received: by 2002:ac2:5399:0:b0:513:e1b6:40b9 with SMTP id
 g25-20020ac25399000000b00513e1b640b9mr721023lfh.28.1712137652596; Wed, 03 Apr
 2024 02:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402114159.32920-1-brgl@bgdev.pl> <20240403094205.GA158151@rigel>
In-Reply-To: <20240403094205.GA158151@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Apr 2024 11:47:21 +0200
Message-ID: <CAMRc=MePwq_rnWZUA6skVqiqjxTKNLXR7cdfrrVeeaxz8Osxmg@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: check for NULL labels when sanitizing them
 for irqs
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:42=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
>
> It occurred to me that none of my tests cover this case, as they always
> request edges with the consumer set, so I added some and can confirm both
> the problem and the fix.
>
> In the process I found another bug - we overlooked setting up the irq
> label in debounce_setup() - the alternate path in edge_detector_setup()
> that performs sw debounce.  That results in a double free of the
> req->label and memory corruption hilarity follows.
>
> I've got a patch for that - the unfortunate part being that
> debounce_setup() is earlier in the file than make_irq_label() and
> free_irq_label().  Those will need to be pushed earlier, so it is
> sure to conflict with this patch.
> How would you prefer to proceed?

Can you take my patch and just make it part of your series?

Bart

