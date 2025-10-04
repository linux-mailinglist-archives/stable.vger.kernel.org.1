Return-Path: <stable+bounces-183381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66573BB916A
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 21:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDE23C3675
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 19:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7849B28506A;
	Sat,  4 Oct 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ndtO7tNO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A5175BF
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759607569; cv=none; b=FrKzDhygJUD4aYObJUbns58nd/WZrbEXg6K0InCIN4r1y/F5XJGZeMhzozlJ1JV48IrOnLCvbd0zzQwdETexPPIEgf9m+G5fQDmTepXIcQIoc+0ke3pAM778J7ZcJI4eCIH1Y7+p/veVNIKa26LcVUvA+yrb1vIEUj1vK9otfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759607569; c=relaxed/simple;
	bh=q3rlMLW/7FdTo+d8ph/RndHkcCcZ+5q6bQTd2SLovSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFMxD0V5nx3xdQ2ajGIL7c7op5NeAXI7iUDYh/otrVw7D08g8d9g/r3ohyYdIbh9h5A+mrD+rkmdqD8cWLGGAMxdhtf9qZq+Z0NFb/h0HVKw86zCrkBdaMnyjkvBLArtCezq1DCt04b8GAiqRlsQ3fl+wo1LyckDG2HCNFyHGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ndtO7tNO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-273a0aeed57so57442035ad.1
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759607566; x=1760212366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAybQmudTYzSK/tcY3PtMZl0JJzvR+yKSsKri3KtNgc=;
        b=ndtO7tNOrxTjLHQPm0Yoext8CnrE4tfpMIxwc1m73ULUJMhvKQLZxacuTccpE48mWm
         MnS/oDMth4iSJORxGyLeHo+lX/a+GjM3oUJJmJ2nD5glylZPoxNC5N7HK0z2PGeXXNy+
         6k+KXeW12P9t96CKDloYs4CnuIsdtIO8pipxYNglki5ndG8q6UHEmwjOkD3ej5xfvmYs
         Sht14p/y0IQZJdBBQTzQcdbT6wLZ+qSUGoVbY0wLY+uX8RLps8AqTjzEanhnFH+d9zNA
         uKydS/t17a3GnzhIvjuorTztZIdHSee/BOzqpEC5zQu7E3DS9EfLQvL9Rx+O+8ckASVx
         HIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759607566; x=1760212366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAybQmudTYzSK/tcY3PtMZl0JJzvR+yKSsKri3KtNgc=;
        b=uVLRR02+2ErCdLXhWs/GIUISHCuBTWiGKWjy9LTwHxtx2Alvp7HM9oi0s/pow/8Fjg
         5CbAFMzFwG+RR2AD48mwcfVwQIP2c8JdCFgcLMtpy5nEeg1i5ap4DWWg4BJCHpx66Kkg
         HKTNWpjnephjlhKxVy22RKLawqNIWK3dnmOcGcDw3WRnXBWigpf9aHgeKZsU8TtOqew2
         NbGZnHqWpMyg80y/avTL/2OLouLR9N5RaZ2iMOn451ixJYeqt4dAhNSznfgbwTiS/sd1
         eF1Gcyv4HlRqIVp50sfAD27HygfodRxQQuxtF79U9HgPrgc6+R7Q2SkbLK0eoe9XpqZ+
         eulg==
X-Forwarded-Encrypted: i=1; AJvYcCWUHtz0HcNRhg3+39Q5W7QVHkqjoCwhphO+bNyzy34Yqv7u1Plib5d/SSH6LOfccMrNjMy3Lm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAICrZTPCMp1yrvn5BXlnEibeJU4mP3yFJDkKi37gdY9KEu19
	1QnCI2XeTbQYlt8LpOS47vhIpbqebz3bdwokwdSKjc7s+ufaUsd2EpGxoa4mkDmORswVsWiPfLG
	9S5bCXOn9KK9pCqrgyc8GTfQStdJF0QDdRNPj
X-Gm-Gg: ASbGncsMsfQU73QwQrcHWHcfvtyz0A/QsVPgoFTs1yxB8NqIVoxtifqMRAH3uTv9Y2o
	mk8Kcqtg7Qu+6r1QXCSKypylqIVSVTlNSPoHc+NyCfYfYwVZDysOMoK49c5d1XXcat9bI8yLaWZ
	xi+XimbowRMnojG16rR5PSb05RGIXUqUBfnXu3GjEe+iA61fejms9InyxD6COt0sfoM4/jHT59R
	dYJJrkb1Ous66+y/l6NOrnl7d561AZcjOp+P5pJ241CUexSf1qjUXqsft9LDvR3/a+xciN9SAo=
X-Google-Smtp-Source: AGHT+IHIGZbYkJ1SDHVdfJpS7K+FvOcrEyzv91AIf3qtubIlP9Lr0Nmn46Z8cwprgw4hxPvpGz40imPwq6+ElwKPvrU=
X-Received: by 2002:a17:903:acd:b0:27e:d66e:8729 with SMTP id
 d9443c01a7336-28e99a86748mr101512415ad.0.1759607565713; Sat, 04 Oct 2025
 12:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926142454.5929-1-johan@kernel.org> <20250926142454.5929-2-johan@kernel.org>
In-Reply-To: <20250926142454.5929-2-johan@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 4 Oct 2025 21:52:34 +0200
X-Gm-Features: AS18NWDU8ocZk0ezDCUadLBXAKIcA1Zy54NbZyjlAwDgH18dZXT8OTopz2n03m0
Message-ID: <CAFBinCBT+8aFH68gKja7PS6BtPUBcEfW4KRv8GFyADiK_QB7dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: amlogic: canvas: fix device leak on lookup
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yu Kuai <yukuai3@huawei.com>, Markus.Elfring@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:25=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Make sure to drop the reference taken to the canvas platform device when
> looking up its driver data.
>
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
>
> Also note that commit 28f851e6afa8 ("soc: amlogic: canvas: add missing
> put_device() call in meson_canvas_get()") fixed the leak in a lookup
> error path, but the reference is still leaking on success.
>
> Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
> Cc: stable@vger.kernel.org      # 4.20: 28f851e6afa8
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I haven't used the scope-based resource management myself as pointed
out by Markus.
That said, as far as I understand it's a feature in newer kernels and
this patch may be backported until 5.4 (oldest -stable kernel still
supported).
So let's go with this simple approach from Johan - we can still
improve this (without having to worry about backports).


Best regards,
Martin

