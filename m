Return-Path: <stable+bounces-3186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FA7FE337
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 23:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF251C20BE2
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124B2B9D9;
	Wed, 29 Nov 2023 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KTrYV2Xr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23185B2
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 14:34:25 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2859c011cb0so346963a91.1
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 14:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701297264; x=1701902064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnm99jqQ5LZRgPNiiPzVL+B5VKBQnQt/eKM5uqfnZUU=;
        b=KTrYV2XrgEq6Y0xhsYvEtODc3OYjvcnGdBnNFddj9x8aODKgp0rpfJYkOYAF97O7bv
         D6Up8iAvTKhyKoK6afJ66zT4Wu+3FzGG2JspoRTehID7Pf/TUuauCeesha79L5DsG4NV
         seHDM2sf9l21JbhPkMyPelTpHCcp6VXYNmBlliJk7Zv4hQ+YRS5N0h5oQ3+ayZ1ud0WU
         ym35x2haZrD2j5yy1CKzj8UylMC/EQAMJ8nY2D1QkQhOU1DCf9n1vn7m1zAjIn5cc1an
         0CPcJyDfblzaqJRaFuNgQbmIHIRuFWheFiWhTfzwtDfRSX0D8GOH/acOdcZHsJWQ22+M
         Vhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297264; x=1701902064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnm99jqQ5LZRgPNiiPzVL+B5VKBQnQt/eKM5uqfnZUU=;
        b=uqvVT7Ps+DS2BnWmUKnkCTKo2iYmaoiZWt/nh1CKtdlMZYFNSI8D2Ifh93eZZ5ApQe
         9mv2F9Vnn1IV4EdJ3i43okgI8uxHPcEThi0NCM0/ARcT5oIi9ftvwnYH3lZVTFCyK9mT
         XJB+akB3EvLMjBxSsqP/Lun+hyUl4xh6Q36lXkH8uP8xg2ufjeq89y5nmsoo0U83gA8x
         r9OUGz9+X7wDGalE5YRksefFsnN6LjyjJzyBqQlY6lafHQHRbO9fdSdjzTOjnjGWwrrU
         z7T+hXsKQUKOykofVnSx0FL0ERLQ1Fy/83B+SRMs8WPBCM5SbCTiZHdU2vR9/rDjtBlY
         RcEA==
X-Gm-Message-State: AOJu0Yw4kNP9hphfHFM5Vl28C2U9FOvBDFQS/IMMslzBFDan9dkb4Llu
	5EdR8AWhy/YuAOzeaIiYsvvF0YP0zIzC6j4UliiFPw==
X-Google-Smtp-Source: AGHT+IH0alFbhyux92V1WZYTs36CZIO0U41SCJZeLRz21ETmzAJqO7Ml6enLVYzem3Tj55K02bcXJQG+91mwi5Wj52I=
X-Received: by 2002:a17:90b:3c2:b0:285:772b:91a3 with SMTP id
 go2-20020a17090b03c200b00285772b91a3mr19810082pjb.27.1701297264563; Wed, 29
 Nov 2023 14:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129220409.55006-1-ignat@cloudflare.com> <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
In-Reply-To: <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 29 Nov 2023 22:34:13 +0000
Message-ID: <CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com, 
	agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 10:23=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 29 Nov 2023 22:04:09 +0000 Ignat Korchagin <ignat@cloudflare.com>=
 wrote:
>
> > Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> > Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop =
select of KEXEC for CRASH_DUMP
> > Cc: stable@vger.kernel.org # 6.6+
>
> I doubt if anyone knows what the two above lines mean.  What are your
> recommendations for the merging of this patch?

Hmm... I was just following
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#opt=
ion-1
and basically wanted to make sure that this patch gets backported
together with commit f8ff234: kernel/Kconfig.kexec: drop select of
KEXEC for CRASH_DUMP (they should go together)

> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>

