Return-Path: <stable+bounces-55909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD1919E57
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 06:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBF4286D8E
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 04:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2FD1B949;
	Thu, 27 Jun 2024 04:46:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821361B285;
	Thu, 27 Jun 2024 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719463601; cv=none; b=r8PVx5LfukfqW+U41kzOR7Eplu/FNF2bV26VRQUEYXexwVEtoAVbx7aWaLiNPEHpIBXkTG38eAQEOoLlvhhXXRvs+hit2hc148/mNkGvE1Vm7JkXQpGlgcx8M1rulAAKRlAiSkQOJYgXHXZjwcgLJmpeM+cLxfqqQqmHW0+2tBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719463601; c=relaxed/simple;
	bh=Eyzwyg/tu5NPQedjnVbHLIo0K6W0fq/cXYtZla4SNtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAlh1c3cXeZZ0e+/S+t1F6ug7CYZRAGUFCBwT8n+8JefQ5v2OtEwspcH8qaHOG4SBBGGy0ExkcJwuY5LirT26P0iql2yCxRJwrMWARD7kGGJ/HWqGIhnZWujrGmO4SE36fExsNV8iwUIbNKazOMCgzcw81mrJ/8QwXc7oonMnv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so101504291fa.2;
        Wed, 26 Jun 2024 21:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719463595; x=1720068395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKv2o+iwUcFccFiTIdN0pCkxYMcGxRiXtYwoj0O/Tas=;
        b=rJ/U1NcTct1hfFPXXfbMIg0aiRi/PIPUJ6sYCMCO2V1UaPPhPI/jpLCXKAdJgy8UY9
         EtTJRkEhdxoCQHHzPSkYQ4JoW94CPwMMBFzSuvKbx5Erq9gRGlvK/P8PC6ezu3uqS9r7
         LCiFQokJQdgfifh0sephqksnvAF6NQJiD2KVIzZXY7UCGQjnQe1/8IRnW1BMbpXGdiBd
         VEtSJqV2i4qcNvHRCQwN9dD5HsKgqu+RhW/cZqrNolLsyWqfStoG0sazOqobJ+Knyvvk
         yQUpS9qeyxw7hgw1r+vdjiKb0qiguhBKXIzcOCb62HXh+DJ3k6HwRyvOPs6zu2K5QoNc
         i2aw==
X-Forwarded-Encrypted: i=1; AJvYcCVLGjoF4KGR6Tkenqv2bwoilDpnPOkuBA3JlwcOnCiI/vpNNhJNHYbyewiMO/lP32tXgl3smu2ABf8OJFui6lEnzlHQmTAsNoFrICFpcKJf+njpv1EHI/Dp2+QcX4AI2VAxWM8xotpnIoLdkcfXdBQWHwOaZGFgi6+xevBTD2qojdNw+PJTg8eitlwJRQy6tXSAH3xVW+APsQKGGQ==
X-Gm-Message-State: AOJu0YzAkucKXxnzxTBCkc9WepboCq6FXYyC4Y3hSekjYgPjYfwnvMR1
	zj8SbxyfUPsgpnhTpaOQ0vpSGCMrjXJ12REjG8rojRwH9DMtt7g27TUOIf++
X-Google-Smtp-Source: AGHT+IG3ZKqvsw5dcd6YAEuwe3x+/pDx/otqCpF2/ukLZYX17P9RSQZShdLpby7WY+Us3Nm4zU/Inw==
X-Received: by 2002:a2e:9917:0:b0:2ec:4bb7:d7f6 with SMTP id 38308e7fff4ca-2ec5b2c4daemr89803401fa.7.1719463595299;
        Wed, 26 Jun 2024 21:46:35 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a4cf7a3sm1050841fa.135.2024.06.26.21.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 21:46:34 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaea28868dso99587741fa.3;
        Wed, 26 Jun 2024 21:46:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGLuBRbWOS6IWo/a8WzWleVtmdfmmxTJ01PYD1s+P6bzO0kp3d78TpsJ6prmfXP/pzthtqFVmJ6ocb1pof7y/RlZwJ6Vvgprg8470ElB7UUc8Lc4LzwFdONCBg+9P3iXYxgliq0YRQ9GxMuCGXTy/GKXHcgnb0Ol7mI1xzG12W2zNUsib67xFof77epaWQ7qlNrCjQUys/wfZ6ww==
X-Received: by 2002:a2e:7c07:0:b0:2ec:4f0c:36f9 with SMTP id
 38308e7fff4ca-2ec5b31d140mr101577061fa.36.1719463593379; Wed, 26 Jun 2024
 21:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev>
 <DM6PR01MB58047C810DDD5D0AE397CADFF7C22@DM6PR01MB5804.prod.exchangelabs.com>
 <87wmmjfxcj.fsf@oltmanns.dev> <DM6PR01MB58043A518B836D1CC3509554F7D62@DM6PR01MB5804.prod.exchangelabs.com>
 <1b359d7e-fe85-48ca-87aa-37ab7e34aaf6@oltmanns.dev> <CH2PR01MB57990FBF72970DECF96294E2F7D72@CH2PR01MB5799.prod.exchangelabs.com>
In-Reply-To: <CH2PR01MB57990FBF72970DECF96294E2F7D72@CH2PR01MB5799.prod.exchangelabs.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 27 Jun 2024 12:46:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v64hwUcU5QntuJgFi3mvBzbgTrG4_vuErDB8X1jKNMgvOA@mail.gmail.com>
Message-ID: <CAGb2v64hwUcU5QntuJgFi3mvBzbgTrG4_vuErDB8X1jKNMgvOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] clk: sunxi-ng: common: Support minimum and maximum rate
To: "Pafford, Robert J." <pafford.9@buckeyemail.osu.edu>
Cc: Frank Oltmanns <frank@oltmanns.dev>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
	Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:23=E2=80=AFAM Pafford, Robert J.
<pafford.9@buckeyemail.osu.edu> wrote:
>
> Frank Oltmanns <frank@oltmanns.dev> writes:
>
> > Hi Robert,
> >
> > 26.06.2024 18:03:24 Pafford, Robert J. <pafford.9@buckeyemail.osu.edu>:
> >
> >> Hi Frank,
> >>
> >> Moving to a new for loop makes sense. Let me know when you have a patc=
h
> >
> > The patch is here, strange you didn't receive it:
> > https://lore.kernel.org/all/20240623-sunxi-ng_fix_common_probe-v1-1-7c9=
7e32824a1@oltmanns.dev/
>
> Ah, this must have slipped through my inbox. I just applied it on my boar=
d and it is
> now cooperating with the min/max clock rates!

Please reply to the thread and give a Tested-by.

ChenYu

> >
> >> and I'll be glad to test it on my board. I do also wonder if this may
> >> have contributed to some of the HDMI issues seen in the other thread.
> >
> > My thought's exactly!
> >
> > Best regards,
> >   Frank
> >
> >>
> >> Best,
> >> Robert
> >>
> >>> Hi Robert,
> >>>
> >>> I'm truly sorry for the trouble the patch has caused you and for my l=
ate
> >>> reply!
> >>>
> >>> On 2024-06-14 at 23:52:08 +0000, "Pafford, Robert J." <pafford.9@buck=
eyemail.osu.edu> wrote:
> >>>>> The Allwinner SoC's typically have an upper and lower limit for the=
ir
> >>>>> clocks' rates. Up until now, support for that has been implemented
> >>>>> separately for each clock type.
> >>>>>
> >>>>> Implement that functionality in the sunxi-ng's common part making u=
se of
> >>>>> the CCF rate liming capabilities, so that it is available for all c=
lock
> >>>>> types.
> >>>>>
> >>>>> Suggested-by: Maxime Ripard <mripard@kernel.org>
> >>>>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >>>>> Cc: stable@vger.kernel.org
> >>>>> ---
> >>>>>   drivers/clk/sunxi-ng/ccu_common.c | 19 +++++++++++++++++++
> >>>>>   drivers/clk/sunxi-ng/ccu_common.h |  3 +++
> >>>>>   2 files changed, 22 insertions(+)
> >>>>
> >>>> This patch appears to cause a buffer under-read bug due to the call =
to 'hw_to_ccu_common', which assumes all entries
> >>>> in the desc->hw_clocks->hws array are contained in ccu_common struct=
s.
> >>>>
> >>>> However, not all clocks in the array are contained in ccu_common str=
ucts. For example, as part
> >>>> of the "sun20i-d1-ccu" driver, the "pll-video0" clock holds the 'clk=
_hw' struct inside of a 'clk_fixed_factor' struct,
> >>>> as it is a fixed factor clock based on the "pll-video0-4x" clock, cr=
eated with the CLK_FIXED_FACTOR_HWS macro.
> >>>> This results in undefined behavior as the hw_to_ccu_common returns a=
n invalid pointer referencing memory before the
> >>>> 'clk_fixed_factor' struct.
> >>>>
> >>>
> >>> Great catch! At first glance, it seems to me that calling
> >>> clk_hw_set_rate_range() in sunxi_ccu_probe() should not have happenen=
d
> >>> in the loop that iterates over the hw_clks.
> >>>
> >>> Instead we should add one more loop that iterates over the ccu_clks.
> >>> Note, that there is already one such loop but, unfortunately, we can'=
t
> >>> use that as it happens before the hw_clks loop and we can only call
> >>> clk_hw_set_rate_range() after the hw_clk has been registered.
> >>>
> >>> Hence, I propose to move the offending code to a new loop:
> >>>         for (i =3D 0; i < desc->num_ccu_clks; i++) {
> >>>                 struct ccu_common *cclk =3D desc->ccu_clks[i];
> >>>
> >>>                 if (!cclk)
> >>>                         continue;
> >>>
> >>>                 if (cclk->max_rate)
> >>>                         clk_hw_set_rate_range(&cclk->hw, common->min_=
rate,
> >>>                                               common->max_rate);
> >>>                 else
> >>>                         WARN(cclk->min_rate,
> >>>                              "No max_rate, ignoring min_rate of clock=
 %d - %s\n",
> >>>                              i, cclk->hw.init->name);
> >>>         }
> >>>
> >>> I haven't tested (or even compiled) the above, but I'll test and send=
 a
> >>> patch within the next few days for you to test.
> >>>
> >>> Thanks again,
> >>>   Frank
> >>>
> >>>>
> >>>> I have attached kernel warnings from a system based on the "sun8i-t1=
13s.dtsi" device tree, where the memory contains
> >>>> a non-zero value for the min-rate but a zero value for the max-rate,=
 triggering the "No max_rate, ignoring min_rate"
> >>>> warning in the 'sunxi_ccu_probe' function.
> >>>>
> >>>> [...]
>
> Thanks,
> Robert

