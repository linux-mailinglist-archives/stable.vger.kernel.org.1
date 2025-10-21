Return-Path: <stable+bounces-188358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F425BF72B7
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD3E19A6AE9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1BF33F8AB;
	Tue, 21 Oct 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S2q5QIMA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D533FE25
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058160; cv=none; b=OXzOH+gYnWkUmSDZv3kYBYO1P7Vm68IFHTQ2VDbiEtkH2QtveiA+22eJO5OOSDKnSHwgks2MOiBdhjE6QgYqSPLr/g5zLrTDmP/vYvJM9NZPGmpzDZQzTalCk8+yKAtvfKFCICXUCsbOPElWEYkJ4w9kc/ZqTZ4z1+nUkmL1JZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058160; c=relaxed/simple;
	bh=W2POVoQrYUSZPm1A3yimS9utpyJqHWo6t34zYlrDD9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQVqSrapayhSAmTX3VLmXu3gXZQHEGOpc3qsyAdlejGhBKE6TI+tairCb960P+Oldvbh7vTy7J7ESoMKfmwInvxsDTtIrJep50jBJPXNQJdNWGPL4AP8PyC6NcdBRpfuWf6cnAOL20KLVXUO0EjvS9X7FGOX5UCILg4J1zWDHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S2q5QIMA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-591eb980286so1169516e87.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761058156; x=1761662956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2POVoQrYUSZPm1A3yimS9utpyJqHWo6t34zYlrDD9M=;
        b=S2q5QIMACELbpbw3BFkBp/ESgGRjNmUqDzIVGS32uUicB+JK9ljXMfHmxs+McXOoCU
         0UP1wC+Is2yy1abPxZmVo7zj5ySOcXaNSgMmJgXyomXLBECmjzEWKM5oPAwdzYi9fta2
         NwL0jk28BbuRXNHI52s2+e0kxLs9WSvOicja4pvzkMKDYEHpqUlvjmP/j/Tp5bdwoVqp
         gvUnH8GkCdkNEzuiaeeaj2CqJXHcNKz/V/g44BCf3+M7EYaYPCo/2lIiRDVtiXb61krj
         4tpMmCZJ88R0GUYlGvuJvRScYHB2M7o+cZfnHyyrORHe1xjmnC6ZVXnSTAdubGslsgqQ
         8ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058156; x=1761662956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2POVoQrYUSZPm1A3yimS9utpyJqHWo6t34zYlrDD9M=;
        b=V64p64gl8/wYlVUHHvonwHoId91K8vmp2x6RlmxIPHIf/00nCTC4BYpooIz5+zD428
         z/x9supNpjYtnxp4Jqe5uobf3UDCM1WKfwlem7Z9QZrLDC5xCnvnFIj/PpUZZvUv4ozB
         Ntorsn6HSd6s1WmURguAR0N5Sr1+jJa4rrZApblpedScH8yOrRSCQKX1CfVWN8+I5css
         SC3cOWBhvNcFupGAI+nkR+FZmyJKVI4et2Jtvt60gNpGf2wafvLgKOoRQ1t1v6RWmCGD
         FVyfKmsMX+v488BTl7Y2SMZmbC4WF8ejK7pmh7lvlk1J4f5HhWBvkUBTppgRPXlTKFZo
         6HBw==
X-Forwarded-Encrypted: i=1; AJvYcCWumRNwdazhmA8G6txAvHOYhqJWYUC1p3RMTJzmAR04cq1b4FOe+ef/ye4icfJJhD8X9eVAPDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwELtpfom3/2C7usuNFFm6VklitKJuR5UTtEJSwCDvjvtlzZq6o
	KQweZ1AkRyeUCHDr6QBwyoeiJNdedUROz4NBQKeQ3e1jsJLEYe1OKzpEX39eUUJnXNEyw01RtgI
	xFpRWNuSEub34Q+LaLpdmevUnCyUkBFQtrmEiYkrYbQ==
X-Gm-Gg: ASbGncvhDyPMkVQHzwqtDq1LOWBM4aQZJvFAoPF/YBjztVEJ5n4xK6oQruODrw6coVc
	/jRO8pzhzgCnm0RsdZyn4T3fCfT9kE/Rv63+WwYTx7fhRxeL/ItHCMouTsPf+eB4V2ZLppk8Oq8
	ZWVmL0fHz5UqGJBN9w1XxsP7Adj41874PJ6rhbqwvCuqwrpuFBoUb2TB3xVAAKE0PYNEmvO6nQj
	xsgwlRCZ0bQXPl/5f/2wKd+/hE0c05Mmay7yLowz5NYNCFns7K6ryrP6S+k2M9CQRkOOs7OlRVg
	zKm6tealTQQzpaWOxBKMSbTxQgI=
X-Google-Smtp-Source: AGHT+IHHKA/c0dnWyRU1/iLjLRkY7tyq+bIgrghSWb7MxAig1bIW1157IfXsr8EXnJ7WeHo/HrV20fw8YRwsJS23Kmk=
X-Received: by 2002:a05:6512:3ca6:b0:572:1f0b:5ef3 with SMTP id
 2adb3069b0e04-591d84e398dmr4722237e87.11.1761058156385; Tue, 21 Oct 2025
 07:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
 <20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org>
 <CAMRc=MeFZTDk4cgzEJNnkrJOEneFUBLwtKjkpV3-cLSm=xsxNg@mail.gmail.com> <aPebhGETy_3MIwkf@smile.fi.intel.com>
In-Reply-To: <aPebhGETy_3MIwkf@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 16:49:05 +0200
X-Gm-Features: AS18NWBSKJhK7qYwfMnb3aaDS0lyPca9mQ0P-5mXERBibCAphYq6tUO01p7bilc
Message-ID: <CAMRc=McPP6obWpnd7Y7duJDC=NLAOE7bjFN-iytDJ524nDr9mA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: idio-16: Define fixed direction of the GPIO lines
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 21, 2025 at 09:21:38AM -0400, Bartosz Golaszewski wrote:
> > On Mon, 20 Oct 2025 10:51:46 +0200, William Breathitt Gray
> > <wbg@kernel.org> said:
>
> ...
>
> > > Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fix=
ed_direction_output configuration parameter
>
> > Turns out, this requires commit ae495810cffe ("gpio: regmap: add the
> > .fixed_direction_output configuration parameter") so I cannot queue it =
for
> > v6.18. What do you want me to do? Send the first two ones upstream and =
apply
> > this for v6.19?
>
> Why can't this be pulled from some IB/IT as part of the fix?
>

These kinds of things should be signalled before applying the patches
that should go to an immutable branch. I would now have to rebase the
my for-next branch. Also: the commit in question brings in a new
feature, not a fix.

Bartosz

