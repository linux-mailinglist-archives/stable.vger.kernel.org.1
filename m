Return-Path: <stable+bounces-43616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEAC8C4085
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB423286107
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491F14F120;
	Mon, 13 May 2024 12:17:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1614EC7C;
	Mon, 13 May 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602673; cv=none; b=inwhWpy36e72A2sg3djpvagPnU5IqUcH4mZVE/wsKfFUSnYuTgef2g64EmY4A9v1P+q8PqL6tHpQ4sMw/CD8wb75GW8DRxnXdI6sy8wOW8O3UjdO1Aa7EhTvGsjw0D7Lzv6FIGG6oZmywSGfD2FSs6Qoo7TeKlsTzO+m18iIU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602673; c=relaxed/simple;
	bh=XudyOy0huXXsWE114Tie9lRpToFHKlMNTnQ/P4ZyNRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMctDd2kyP9wUItN3h9ID8xoDgaYpaSGOtwQSzpt6teOkjQI6ZfYsp15GU2YuwSDiqYm4UVxm3uXDn49vkdNl0/+4vEYR3tCNEaDdLe2eIXT/SAD0BQ3hN0KkXA4QEZX2E/dOIQKqkoec3Nil67vlPxO+5z2d2CU9CLYlfIsziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de607ab52f4so4508910276.2;
        Mon, 13 May 2024 05:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715602671; x=1716207471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9Ap844dmCuN2yhrZbST2/sYCrTDfuB5uNKh6TGhbNc=;
        b=hLOR3ooNZvMO9f4MRNCrDAljZsgayLeJPiC1re+mbfe3p1IIQDnEqxuMDTphbE6qBp
         4bFeRYq7svnSvVGMh2V3LL8PiH9rIdlhUV4cTcP7+XCTMlUurhpdtDJhj0HLfOZefGZe
         s9drlibmjTyidwxjrgBYmkfysydNSTg54V5ANvxss8WKjfLReDtACTSm9C31TqxQQHom
         h6Hp4ySGh2I5AZXE4BqNwxXFFGr7Vo5XDNR2pi/N8aTM6DcnMFCnMHJh+iYMc2SXWflw
         rHde9c/PSd8wV87n5vRpftIQ4FY71Pfkh6Ag4gredkKSzTRD+63LgJ4ueOfYakdIJIll
         epXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/dYvP+/z6QcRN6ddJv/ln7qrkEK9lN3kd+6egZ01QjpjzCuSAfTraJ8/LFskqgLgpa9R+hVADHTeO5s9OJHKgXDBDgqsZaqKhA19SPRHum370DRLatJhMDGZgTFmUNslDcWFE
X-Gm-Message-State: AOJu0YzHp6YO2gmBPEN6vXzP9shAtF21oxz4Ckw9EZKt4pWM2XTEDCRg
	+dimv9zvjTUXuDWmOp6wt4UsPnIipOfy96MsVgEk7ULjvICh26Pv3NqE0+DK
X-Google-Smtp-Source: AGHT+IE4ide/2ftw2u3Nj85PX2TxmQfL6xuau3SkoPTdXq7dOwcilAjd3gmuF8WP0amq5J//nFU6Zg==
X-Received: by 2002:a25:204:0:b0:de6:1083:1fc0 with SMTP id 3f1490d57ef6-dee4f368fa0mr8089922276.33.1715602671040;
        Mon, 13 May 2024 05:17:51 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd374517asm2041195276.33.2024.05.13.05.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 05:17:49 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61d35d266e7so49995507b3.1;
        Mon, 13 May 2024 05:17:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfZ27TWpvQC4ysLA6QCGmGDKytCA+2Yy73CGwPXH0nYvv0NyK/bcVYhScKDc7t9cRkYUcqWH3muyUSkT8ltJ2lXywbTGuXT8liME6kAlFKgOFyXDv5heTKFfzag5jscHYKHljW
X-Received: by 2002:a25:ef05:0:b0:de4:7603:e888 with SMTP id
 3f1490d57ef6-dee4f368604mr8264777276.29.1715602669176; Mon, 13 May 2024
 05:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509133304.8883-1-johan+linaro@kernel.org>
In-Reply-To: <20240509133304.8883-1-johan+linaro@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 May 2024 14:17:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrJkYYyCM72pYjFwCDbfO3W6HjSTEiMu_M8yH4Wsf9mQ@mail.gmail.com>
Message-ID: <CAMuHMdXrJkYYyCM72pYjFwCDbfO3W6HjSTEiMu_M8yH4Wsf9mQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: fix debugfs creation regression
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 3:34=E2=80=AFPM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
> regulator_get() may sometimes be called more than once for the same
> consumer device, something which before commit dbe954d8f163 ("regulator:
> core: Avoid debugfs: Directory ...  already present! error") resulted in
> errors being logged.
>
> A couple of recent commits broke the handling of such cases so that
> attributes are now erroneously created in the debugfs root directory the
> second time a regulator is requested and the log is filled with errors
> like:
>
>         debugfs: File 'uA_load' in directory '/' already present!
>         debugfs: File 'min_uV' in directory '/' already present!
>         debugfs: File 'max_uV' in directory '/' already present!
>         debugfs: File 'constraint_flags' in directory '/' already present=
!
>
> on any further calls.
>
> Fixes: 2715bb11cfff ("regulator: core: Fix more error checking for debugf=
s_create_dir()")
> Fixes: 08880713ceec ("regulator: core: Streamline debugfs operations")
> Cc: stable@vger.kernel.org
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

FTR,
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

