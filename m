Return-Path: <stable+bounces-95591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E528F9DA316
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 08:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53DC284160
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430FB149E1A;
	Wed, 27 Nov 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="csvODGo1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1FE1114
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692483; cv=none; b=JzTDRZLVw/sfU9yRvZk6IwVONSKfZLXr2XZCw0+kpM5C8Heu1VgYmKlbqleD94GTdBxCKGtAXNUZo1HzwNHS0oHKfdMZ4GnsAZBZ3q77IvQOwTB6ZWTHs/DAnNNXMXUh3kekIrKrexGAoo3c+rZye+5rtxHeT8fCZ83QqFDkcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692483; c=relaxed/simple;
	bh=KuWXTb4LcW8/bpSbKWNdmhYeKVa50JrbQlRXOqHDf6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4vjuXvaKzdJBZnzRC0RNClxEDllyfpizerTeaQr3zZwI4gJOj2QCTVZp6TaZ6NSy7J61KyJW3jJkMA5n55dv1X3oEd49WkgkapT30c06M0Hy/YDWBcuue0GtT2TeQBnOIfg9cTFGXJqlyYYQbRMzh6BD5aKmTEZFnCMkd0ai5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=csvODGo1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so46601421fa.0
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732692479; x=1733297279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oZqeCiNDi+VUMlqaFu0Cj3Hfsp6EOFS1u82qR+tNuM=;
        b=csvODGo1IkOAU13dGOKITD1LfPTKpoRFl597fbuKrT8A9novnBnw6GH9Fu4Xu39Wo6
         /uRqYUBRsBwPcrL9PC7MagUDB3+N28JUd3ulNQMzR+oXCsvVf7E9nqgrV9071XGzfnUR
         +E7Na+SNFCmdt1p+PGwRezTowmqXB33q+BGAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692479; x=1733297279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oZqeCiNDi+VUMlqaFu0Cj3Hfsp6EOFS1u82qR+tNuM=;
        b=NRmRg075NKysMe17xoizci3TGi+pYTo67YCrqNUN1i2WcL2jsHWTkWgAtxUsIZ6puh
         HVuCgtNLsyh2bHxpDLTmriOx7dJFQfFWV2faGNuvq8b61Re8z3YygMOJ9dclX6o5eVAe
         OT8sns/aU+L0mUUAvUE8nmyKShrhugPa6NTJI7SE1vCi9BwFH9xfZK9GdrDgDgpzV3Qv
         UHOgwAZ1QQVXRmzEFiyGhdcn2FfIIkU5GZ00ejGMRvlT5HYHQFiOGSOMeZ6/6gWNAoCu
         zKW8Mr+/8AJYxDSjBPkq6uKrwT/Npiv3RqyxsrFTJs3EQfMmUx5KMcLeFvez3vavPEh6
         EPQg==
X-Forwarded-Encrypted: i=1; AJvYcCWkuUgaG2CzXFmHSP5AoILVbGofq+eJasDKSxilvFkrFiT3V830XjelZcxHRuYXx+lU7O00P4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjE+eE4WmOnAe9Vr4rMNPV+unpnVjkm9lR9KuJskGN3AF1N+u
	KnupFq3eHoEorJnwE3P9TGbJsRYQCpnFYTe56POcZ8fprGNVVE8qrxt2Sxrx1gdC5TdLc7xhmz3
	+5Bkw
X-Gm-Gg: ASbGnctjURcgAMG5tOPfK4ckSvajgTjWLlCnA3J120zbUpTuYBS5xn+y1pf2pe2sxjN
	dbpRwWSiGwbTDfhLs0inx7tYqQghnlQTmRX5meIO1V5JsVxS2Edpi7n2lX7IWalegiF9GKAbT89
	AckAkPMm75lfDUM3zmWklkeAByhoLQLNkVlOImn0UkEN6U6ZP+fhpBzzeJfR0S/39V4i/FnqZ7d
	Ru2AN5lLVRdZAKc/LhHiQR1IN4+veS9ZWY1MUcqHubhTPbhI06dD+T1foQy83kqWZGT6uPK44xk
	ARsGj9HwqKr5pHnz
X-Google-Smtp-Source: AGHT+IFIVBE96VtYP1bJdnro6aLdWEucKe2uBprQ+SMzEBL58CyTwZ40elxC1IZ7JLYqo6uH1TDj8g==
X-Received: by 2002:a05:651c:1611:b0:2fb:510c:7237 with SMTP id 38308e7fff4ca-2ffd60f15f5mr13035921fa.41.1732692474751;
        Tue, 26 Nov 2024 23:27:54 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f41fasm681391666b.65.2024.11.26.23.27.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 23:27:53 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so4369a12.1
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:27:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqiGnVunmb1mB3rH3xq598pu5mpGaC1ESlJbI/QDVjCIToWJeMCmB/fdPL3pnHAmb4kT3qxtY=@vger.kernel.org
X-Received: by 2002:aa7:d80b:0:b0:5d0:3ddd:c773 with SMTP id
 4fb4d7f45d1cf-5d0819b8bf8mr48974a12.4.1732692472728; Tue, 26 Nov 2024
 23:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
 <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com> <f38e4283-7133-4865-b4fe-eafb6bd30534@notapiano>
In-Reply-To: <f38e4283-7133-4865-b4fe-eafb6bd30534@notapiano>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 27 Nov 2024 15:27:16 +0800
X-Gmail-Original-Message-ID: <CAHc4DN+S6mBy_VRTWEqp-uA13zUyadtqPoo+-WZTmwYHofpkcg@mail.gmail.com>
Message-ID: <CAHc4DN+S6mBy_VRTWEqp-uA13zUyadtqPoo+-WZTmwYHofpkcg@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:37=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Nov 26, 2024 at 04:00:42PM +0800, Hsin-Te Yuan wrote:
> > On Tue, Nov 26, 2024 at 5:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > When configured in filtered mode, the LVTS thermal controller will
> > > monitor the temperature from the sensors and trigger an interrupt onc=
e a
> > > thermal threshold is crossed.
> > >
> > > Currently this is true even during suspend and resume. The problem wi=
th
> > > that is that when enabling the internal clock of the LVTS controller =
in
> > > lvts_ctrl_set_enable() during resume, the temperature reading can gli=
tch
> > > and appear much higher than the real one, resulting in a spurious
> > > interrupt getting generated.
> > >
> > This sounds weird to me. On my end, the symptom is that the device
> > sometimes cannot suspend.
> > To be more precise, `echo mem > /sys/power/state` returns almost
> > immediately. I think the irq is more
> > likely to be triggered during suspension.
>
> Hi Hsin-Te,
>
> please also check the first paragraph of the cover letter, and patch 2, t=
hat
> should clarify it. But anyway, I can explain it here too:
>
> The issue you observed is caused by two things combined:
> * When returning from resume with filtered mode enabled, the sensor tempe=
rature
>   reading can glitch, appearing much higher. (fixed by this patch)
> * Since the Stage 3 threshold is enabled and configured to take the maxim=
um
>   reading from the sensors, it will be triggered by that glitch and bring=
 the
>   system into a state where it can no longer suspend, it will just resume=
 right
>   away. (fixed by patch 2)
>
> So currently, every so often, during resume both these things will happen=
, and
> any future suspend will resume right away. That's why this was never obse=
rved by
> me when testing a single suspend/resume. It only breaks on resume, and on=
ly
> affects future suspends, so you need to test multiple suspend/resumes on =
the
> same run to observe this issue.
>
> And also since both things are needed to cause this issue, if you apply o=
nly
> patch 1 or only patch 2, it will already fix the issue.
>
> Hope this clarifies it.
>
> Thanks,
> N=C3=ADcolas

Thanks for the explanation!

Regards,
Hsin-Te

