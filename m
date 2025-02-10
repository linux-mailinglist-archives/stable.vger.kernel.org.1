Return-Path: <stable+bounces-114469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84869A2E39E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 06:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC041882300
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 05:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B8189902;
	Mon, 10 Feb 2025 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="YUh93J9j"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442E16F858
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165229; cv=none; b=TOghVkRlyOyJgWY0YHZVr5gnfLlT0vwwasiBe3ECD3mrYXzJ4ow4EkKf8RN7CAxRrNdQPGxnzTUIWi+DXFhhwQr5XCubhhcSvLq2ivoCrJy3gdwXbkPnEkZ/FQSi8bw29mZCDst6ABWPUVtENIycMjR+iqm00x/kXab4JjFedcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165229; c=relaxed/simple;
	bh=ZaZzKvk7Jpw0Xk+IM63SQtNmtlnk3CxqcAOuqfBd0y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1BBjlYKbJ7xpDDgsUMpKhmmm/VTV/2ag9HrgE0i1IFgOvTVmYvI/Gap8nxJmtH8VIVcddkD2QTgd7FAoUVNKBDXbWGnsPE9ieqw7lKlFyoRYFry9jpBLDEVZGd2v9x49bplbXqs3hZ/Uhv5vpOLhmb/M6FVKf79r01qlHzJcWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=YUh93J9j; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de5bf41652so2975706a12.1
        for <stable@vger.kernel.org>; Sun, 09 Feb 2025 21:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1739165226; x=1739770026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YPOmzVXXpww8b7P9KurA43+r96Qxt23SjHf/CrmgaYM=;
        b=YUh93J9jC1obNHeeEGPIkWgW1cJguy3tw6DIyWUy/mM+ixte3w2PddKcPg2xo8UcXy
         lK5ZXgF40qBME2VTjrMjXCEbef/QAyh+Pg+AOGVRPHqdblPMhkX1jennOuT+s+3GDKja
         qWwNQ3QHcVDRrfvdA8pBTtuysxLasfXux0BGmpA/wIeRhtbJ37gqnnySFFK/1iQbYbW+
         pxOuD12/kJTfQGY0DFrle7VOmZ/PqUl+y+gNyeWtKrErhCwrZHShyoK3Lvk0vGUaaxGO
         i8muMzdiiHwmrT03OPEAaIHwTbx4Oi6w68p1ZPQaeH0377rb1TC7EBji8SpHS3zJKBuN
         ZjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739165226; x=1739770026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPOmzVXXpww8b7P9KurA43+r96Qxt23SjHf/CrmgaYM=;
        b=ccvSHz8H+eli9L/YMav26zLwU5JjbGxMM7qXMspHxanuQvjmZ/PAGOG4AedAVsflkL
         77qXUxOwqrEdYKwsJyxm/mR7txYSBTSqGBYaYGWMJhs9XcykEkFNKj6iqvFHQcy6tK8C
         he+XVFvkbcxeliz+BeDq+SSSbsGUXFQYmw0Of+mRg7djEA1DG+ltv8Tf4Uwvq5skf41A
         HuHxKpV5/kFvwSQnd0LdPOYA9/wutknLPqSEu+1F5rCkIg2OQou92TeUMhADpYUY4LI9
         HUSNiOE2L9Uy3gJy8QLj80O+KltAn+z7/2/fbFjB5mu9d11IWZAdsNw/YZX/A352bYAf
         CEtw==
X-Forwarded-Encrypted: i=1; AJvYcCUjEVnrFw1fSgjWZBBEPcwIfM/Wr1dsa/desQbJ2qfwDZV2+qovGDupZbBffhQZLxLsepKsQ/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWs44V08c9gDIiREm0ZoWz9+sSR8+JikzaQT3boD4QkP0dDVUO
	RTAmlfBalddgH6Xytwbu07KqxIjSsZXbzEmgI4e9C1Gm/0vSgtcZCFbKu/RWPWbjaB6mPQUKwEs
	RjUekl5Iu37kgjm3lixbknCk8Tmr5eWz/sdDrHw==
X-Gm-Gg: ASbGncsgbl37dEO5B0bAcUUSJeALn4zGBG9yAMPNK2PvM3leQs5Wqqbp99ALnAeKIE5
	37wsloena+uVqXrVEGxZo7Hpjd633Gb1m6ppgZB+ihl2kqpPLTa1wbItXJ1XJEGspw//MDvy+xQ
	==
X-Google-Smtp-Source: AGHT+IGjQIlzFHCfcDhIb4mXCz1GCQin1Sf8Lm53FCexRLyu5mlSb7CIelWVQUH61W9fRtlXczKUZxn27b99cpM/+8o=
X-Received: by 2002:a05:6402:3806:b0:5d8:253:b7df with SMTP id
 4fb4d7f45d1cf-5de450988e0mr12327805a12.27.1739165225957; Sun, 09 Feb 2025
 21:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205-qcom_pdm_defer-v1-1-a2e9a39ea9b9@oltmanns.dev>
 <2vfwtuiorefq64ood4k7y7ukt34ubdomyezfebkeu2wu5omvkb@c5h2sbqs47ya>
 <87y0yj1up1.fsf@oltmanns.dev> <87msez1sim.fsf@oltmanns.dev>
 <CAKXuJqhuNh1mV-40LpO3bffoGSOiFLkRB+uZ8+5+0eThctm+-g@mail.gmail.com> <87msev9v9k.fsf@oltmanns.dev>
In-Reply-To: <87msev9v9k.fsf@oltmanns.dev>
From: Steev Klimaszewski <steev@kali.org>
Date: Sun, 9 Feb 2025 23:26:53 -0600
X-Gm-Features: AWEUYZmIZnrYQpuBSNLsNqjCDTjp8CehJeNFZ2kQMJArY-kRSvx_e5-GL-m08oo
Message-ID: <CAKXuJqi4h3QPBQjnvMeYTJbu-tiAL7Ti+nX-rADgENvwv4GhqA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pd-mapper: defer probing on sdm845
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Chris Lew <quic_clew@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Joel Selvaraj <joelselvaraj.oss@gmail.com>, 
	Alexey Minnekhanov <alexeymin@postmarketos.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Frank,

> > I know that Bjorn already said this change is a no, but I wanted to
> > mention that I have a Lenovo Yoga C630 (WOS) device here that is also
> > an sdm845, and with this patch applied, it has the opposite effect and
> > breaks audio on it.
>
> Interesting! Just so that I get a better understanding: Is remoteproc3
> loaded at all? Can you please send me the output of:
>
> $ dmesg | grep "remoteproc.: .* is available"
>
> and
>
> $ dmesg | grep "remoteproc.: .* is now up"
>
> (no need to apply the patch for that)
>
> Thanks,
>   Frank

Here they are, this is without the patch applied.

steev@limitless:~$ dmesg | grep "remoteproc.: .* is now up"
[    5.746470] remoteproc remoteproc1: remote processor
remoteproc-cdsp is now up
[    5.880144] remoteproc remoteproc0: remote processor
remoteproc-adsp is now up
[    5.975094] remoteproc remoteproc3: remote processor
5c00000.remoteproc is now up
[    8.642160] remoteproc remoteproc2: remote processor
4080000.remoteproc is now up
steev@limitless:~$ dmesg | grep "remoteproc.: .* is available"
[    5.491202] remoteproc remoteproc0: remoteproc-adsp is available
[    5.546421] remoteproc remoteproc1: remoteproc-cdsp is available
[    5.565271] remoteproc remoteproc2: 4080000.remoteproc is available
[    5.580100] remoteproc remoteproc3: 5c00000.remoteproc is available

