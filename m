Return-Path: <stable+bounces-55856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7DE91882B
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F2F1F21FF0
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395C618FDA5;
	Wed, 26 Jun 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="VEgcI4vv"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4F17F370;
	Wed, 26 Jun 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421661; cv=none; b=PFV+I2EzAtSjl86SXy3RbDtwKbpa55+iCmRVVFpiTJfwAmiOuQ4Iak4J9nfg4GMKFe2sh+CwEtpPymydjj+lVjhAtpdb20gTXDPkDEds5AudmYwM63jbwzWDM+F/YYw6Uc8+nWCtxxYid7R3MZjnnD0lMWEHSZGGvytziXNAXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421661; c=relaxed/simple;
	bh=TMmpUeG6AgeBLdnpM+s0li9NSssKRCHhHc2Ibal07EQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NwlMAUwZADBOqVZsgcz1Lu1vcdiFOAHfPDepp9Ex6rujNFWUdqExfEAjgfyegPGjggP4IvZJduAEnvHUifKv2yJYHeP20f+x/EzSqodKS0Za51uuDUAHNdTh7yb/Rld7NL2MtIsuo+n4TJJGCdwAQBkDfxXIC3Ki/koNpUo2TA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=VEgcI4vv; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W8Smx29Hwz9sTk;
	Wed, 26 Jun 2024 19:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1719421649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMmpUeG6AgeBLdnpM+s0li9NSssKRCHhHc2Ibal07EQ=;
	b=VEgcI4vveCe7PzZUbnLJjFgOYUrCLf+1Xz+DL5HQC+/XDt9dQMmvtgL0MMXOzTk8NUgFrx
	BkpaB1W5uFUHQCty/47PffMM72gdJ3aH9kikvegJEiBe7IlUzkUjusb6R+hMS0NOEPthgx
	nkasDb1OBBjtH7Ptna1yU+2yPj7jOYFXLcwPE+JxiyNDQcKchLIpvv9/6S3OcHOdmJ0v4Z
	h+bzjYiiGqUxLv3Xu5ocpyraPN4DN2EyeJk5QAB0jPMEgt9l3M1hvW2bO834nqBH4pcKfZ
	7r7qZRlQURbkLVHtTbcbHZYJAm2AZ2jqhjfcQ86bQl8gnVFrfS3b5JM8F19neQ==
Date: Wed, 26 Jun 2024 19:07:19 +0200 (GMT+02:00)
From: Frank Oltmanns <frank@oltmanns.dev>
To: "Pafford, Robert J." <pafford.9@buckeyemail.osu.edu>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	=?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
	Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, stable@vger.kernel.org
Message-ID: <1b359d7e-fe85-48ca-87aa-37ab7e34aaf6@oltmanns.dev>
In-Reply-To: <DM6PR01MB58043A518B836D1CC3509554F7D62@DM6PR01MB5804.prod.exchangelabs.com>
References: <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev> <DM6PR01MB58047C810DDD5D0AE397CADFF7C22@DM6PR01MB5804.prod.exchangelabs.com> <87wmmjfxcj.fsf@oltmanns.dev> <DM6PR01MB58043A518B836D1CC3509554F7D62@DM6PR01MB5804.prod.exchangelabs.com>
Subject: Re: [PATCH v4 1/5] clk: sunxi-ng: common: Support minimum and
 maximum rate
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <1b359d7e-fe85-48ca-87aa-37ab7e34aaf6@oltmanns.dev>
X-Rspamd-Queue-Id: 4W8Smx29Hwz9sTk

Hi Robert,

26.06.2024 18:03:24 Pafford, Robert J. <pafford.9@buckeyemail.osu.edu>:

> Hi Frank,
>
> Moving to a new for loop makes sense. Let me know when you have a patch

The patch is here, strange you didn't receive it:
https://lore.kernel.org/all/20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32=
824a1@oltmanns.dev/


> and I'll be glad to test it on my board. I do also wonder if this may
> have contributed to some of the HDMI issues seen in the other thread.

My thought's exactly!

Best regards,
=C2=A0 Frank

>
> Best,
> Robert
>
>> Hi Robert,
>>
>> I'm truly sorry for the trouble the patch has caused you and for my late
>> reply!
>>
>> On 2024-06-14 at 23:52:08 +0000, "Pafford, Robert J." <pafford.9@buckeye=
mail.osu.edu> wrote:
>>>> The Allwinner SoC's typically have an upper and lower limit for their
>>>> clocks' rates. Up until now, support for that has been implemented
>>>> separately for each clock type.
>>>>
>>>> Implement that functionality in the sunxi-ng's common part making use =
of
>>>> the CCF rate liming capabilities, so that it is available for all cloc=
k
>>>> types.
>>>>
>>>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>>>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>> =C2=A0 drivers/clk/sunxi-ng/ccu_common.c | 19 +++++++++++++++++++
>>>> =C2=A0 drivers/clk/sunxi-ng/ccu_common.h |=C2=A0 3 +++
>>>> =C2=A0 2 files changed, 22 insertions(+)
>>>
>>> This patch appears to cause a buffer under-read bug due to the call to =
'hw_to_ccu_common', which assumes all entries
>>> in the desc->hw_clocks->hws array are contained in ccu_common structs.
>>>
>>> However, not all clocks in the array are contained in ccu_common struct=
s. For example, as part
>>> of the "sun20i-d1-ccu" driver, the "pll-video0" clock holds the 'clk_hw=
' struct inside of a 'clk_fixed_factor' struct,
>>> as it is a fixed factor clock based on the "pll-video0-4x" clock, creat=
ed with the CLK_FIXED_FACTOR_HWS macro.
>>> This results in undefined behavior as the hw_to_ccu_common returns an i=
nvalid pointer referencing memory before the
>>> 'clk_fixed_factor' struct.
>>>
>>
>> Great catch! At first glance, it seems to me that calling
>> clk_hw_set_rate_range() in sunxi_ccu_probe() should not have happenend
>> in the loop that iterates over the hw_clks.
>>
>> Instead we should add one more loop that iterates over the ccu_clks.
>> Note, that there is already one such loop but, unfortunately, we can't
>> use that as it happens before the hw_clks loop and we can only call
>> clk_hw_set_rate_range() after the hw_clk has been registered.
>>
>> Hence, I propose to move the offending code to a new loop:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < desc->num_c=
cu_clks; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct ccu_common *cclk =3D desc->ccu_clks[i];
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!cclk)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue=
;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (cclk->max_rate)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_hw_s=
et_rate_range(&cclk->hw, common->min_rate,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common->max_rate);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN(ccl=
k->min_rate,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "No max_rate, ignoring min_rate of clock %d - %s\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 i, cclk->hw.init->name);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> I haven't tested (or even compiled) the above, but I'll test and send a
>> patch within the next few days for you to test.
>>
>> Thanks again,
>> =C2=A0 Frank
>>
>>>
>>> I have attached kernel warnings from a system based on the "sun8i-t113s=
.dtsi" device tree, where the memory contains
>>> a non-zero value for the min-rate but a zero value for the max-rate, tr=
iggering the "No max_rate, ignoring min_rate"
>>> warning in the 'sunxi_ccu_probe' function.
>>>
>>> [...]


