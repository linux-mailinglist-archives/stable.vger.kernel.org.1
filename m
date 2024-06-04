Return-Path: <stable+bounces-47917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315488FAF8A
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617191C21EA6
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1931448E3;
	Tue,  4 Jun 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMHz8RlX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EF1448C7
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495548; cv=none; b=C076TH2b0OazlEG4mSgKnB/wYB5axTbCd/OjTThXR/OU43VVwIZWvxnkns3mitkfYhtdKDSa4S4lBrxhnNpF9nn2eFKjzsqDH9mamd/Xau9T6tRsuLO8tTNTas4AN05P2KjnUTes1uqYE38NyDygAAwjXCSFSPyFT9SvSDTEd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495548; c=relaxed/simple;
	bh=OAakOdVgjZ4nC9mR9s5+Zmdm0H5Z7NkBLLcGbxvnrqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU6UdXQJIWe9kszZEJgyXbw8lh7eftystqQ5WOwz0vVK3WVVStnGKqKiM7tltRlAtm55DCEi3HNNOr8RGFZjlZYxd7Dt5jN2GWkF2vgwIVY3V/kmNDPj4pg5cKh+rpfj4BI9hAILJyUV2q8Wu5xCzf3FrzCxr4BuGg+08JHb2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hMHz8RlX; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df79380ffceso4186924276.1
        for <stable@vger.kernel.org>; Tue, 04 Jun 2024 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717495546; x=1718100346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45XbiKOvHoih0/tmcZdi7EWeN2ZUgWTnO7toZED0rFc=;
        b=hMHz8RlXz7G+CRjHR5M2/DU7LRShiiP8qcJ1GDc+OTxUSQN00Ul9vLdeHQdJH5gDWn
         V3ZI1r+LYpMHEFw8hU7Yi1LlBQ2EF16hX+kwepj7Se+ks/HGG9KpMciCHx2kElPfjNry
         vrQ9vi2t7EA7IZTzC08kYvvkqFSTg2owdsLQzmp3eM1duzlcVR96hKhvb/obrISvXiNi
         XTVBGXsKxjdcTSrRtLuHLGEdFqxwpgkt9ohUINbCcyKboiBNixCz/hOUl0szyShnF3uY
         AHCgOxdiWZYoUXwThtU1FBRGA7t6+r8PqnvrtaulKCl4mlt/QXTdLa7dZoffL2u9A4af
         OBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717495546; x=1718100346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45XbiKOvHoih0/tmcZdi7EWeN2ZUgWTnO7toZED0rFc=;
        b=HlRgMRSTRyVDy6oOM22ta69MIBFR7TBQOLqiIov66CXuohntetYV+f0YT3ajo9EDap
         o4PPX9uYsSX5VDxavFdva7IRV+rP5Qzihoo/GUcZcEX252Hd11rQZH2pTt5kOyIQy4WP
         YSCKwA+FWs/2z2/qYGXSDRt5aclp/g1j1pIrBW4Oih+LhKT17HTLnKcirxY+vjCxJFo/
         PrM7I5rvynv0CvOXHaNFAZ6/G0vz6P13mUEdQrD3LYuREqBk5UzSAzqYxOwfbU54WHS9
         wyXqwSxkjvZMoqgJZ3q1wlESda54LJGJdul8irClGVVLf3HnDNWxzR3pP8GN5yrr4HHW
         e0/g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9Evcpllqp0hk4la4fhz7Pb5rIaZqEKbCp6xQ57SHMmxJdLoWojErPAB6p5MX2Ez8EOwWd3/8oqw7p+jTD83fds8LSCHT
X-Gm-Message-State: AOJu0Yy9lEKwqI8wNoPBWAUZHD08vdJyiheCZVyMTnr4JxWgD4sxB/lN
	hJ5k3m193OrPPqybTvvT8cgKM7ujFahfCnMLVeA9vPTBnuc6TbuP81VKPdZERBYF4iHe7GMC/sZ
	Mcq0NduGx3gx33kcnNEW2O1Yzq8HMMJ/ZmjsdumgJPVUCqrv0
X-Google-Smtp-Source: AGHT+IHToEzjTH40XGqeDWHPED2Ye/fukC8yKkTKMcVBqpRI731pI5udKIlMq+lNHr40OrjBpl5P9fyWg3F/dPP7Olw=
X-Received: by 2002:a25:dcd0:0:b0:dfa:48d9:b0 with SMTP id 3f1490d57ef6-dfab8b0312fmr1498084276.22.1717495545726;
 Tue, 04 Jun 2024 03:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604060659.1449278-1-quic_kriskura@quicinc.com>
 <20240604060659.1449278-2-quic_kriskura@quicinc.com> <le5fe7b4wdpkpgxyucobepvxfvetz3ukhiib3ca3zbnm6nz2t7@sczgscf2m3ie>
 <e0b102b6-5ea5-4a86-887f-1af8754e490b@quicinc.com> <tbtmtt3cjtcrnjddc37oiipdw7u7pydnp7ir3x5u3tj26whoxu@sg2b7t7dvu2g>
 <2b8e5810-6883-4b6d-8fa7-f13bbc0e897e@quicinc.com>
In-Reply-To: <2b8e5810-6883-4b6d-8fa7-f13bbc0e897e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 4 Jun 2024 13:05:34 +0300
Message-ID: <CAA8EJppS4+Kv+BTKxxUjEoo8H8XCoPBK-uhdTx6bGWgH6AvK6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7180: Disable SuperSpeed
 instances in park mode
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com, 
	Doug Anderson <dianders@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 12:58, Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 6/4/2024 3:16 PM, Dmitry Baryshkov wrote:
> > On Tue, Jun 04, 2024 at 01:34:44PM +0530, Krishna Kurapati PSSNV wrote:
> >>
> >>
> >> On 6/4/2024 1:16 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Jun 04, 2024 at 11:36:58AM +0530, Krishna Kurapati wrote:
> >>>> On SC7180, in host mode, it is observed that stressing out controller
> >>>> results in HC died error:
> >>>>
> >>>>    xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
> >>>>    xhci-hcd.12.auto: xHCI host controller not responding, assume dead
> >>>>    xhci-hcd.12.auto: HC died; cleaning up
> >>>>
> >>>> And at this instant only restarting the host mode fixes it. Disable
> >>>> SuperSpeed instances in park mode for SC7180 to mitigate this issue.
> >>>
> >>> Let me please repeat the question from v1:
> >>>
> >>> Just out of curiosity, what is the park mode?
> >>>
> >>
> >> Sorry, Missed the mail in v1.
> >>
> >> Databook doesn't give much info on this bit (SS case, commit 7ba6b09fda5e0)
> >> but it does in HS case (commit d21a797a3eeb2).
> >>
> >>  From the mail we received from Synopsys, they described it as follows:
> >>
> >> "Park mode feature allows better throughput on the USB in cases where a
> >> single EP is active. It increases the degree of pipelining within the
> >> controller as long as a single EP is active."
> >
> > Thank you!
> >
> >>
> >> Even in the current debug for this test case, Synopsys suggested us to set
> >> this bit to avoid the controller being dead and we are waiting for further
> >> answers from them.
> >
> > Should these quirks be enabled for other Qualcomm platforms? If so,
> > which platforms should get it?
>
> In downstream we enable this for Gen-1 platforms. On v1 discussion
> thread, I agreed to send another series for other platforms.
>
> I could've included it for others as well in this v2, but there are
> around 30 QC SoCs (or more) on upstream and many are very old. I need to
> go through all of them and figure out which ones are Gen-1. To not delay
> this for SC7280 and SC7180 (as chrome platforms need it right away), I
> sent v2 only for these two targets.

Ack, this is fine from my point of view. Thank you!

>
> Regards,
> Krishna,
>
> >
> >> I can update thread with more info once we get some data from Synopsys.


-- 
With best wishes
Dmitry

