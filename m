Return-Path: <stable+bounces-207896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BD7D0BB8B
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 18:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC59A3107BB1
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495C366DC3;
	Fri,  9 Jan 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTC+HK2q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7434366DAE
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980007; cv=none; b=SXOuIlIxQ55RJLR6JFq3OVPD1LeMgYdlGwZoEWQoya7KIe2+KyLQm4YrCMghbNoiy0dxoGBIn02KiVmRwhXaZXLQVEUq/xv2Ps1ZiS1WYlk4lreCQuHtJFAvy+4hPZylWCJglepsCl/EnIJC666yqL9gZgi7TASmZFNshNjPKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980007; c=relaxed/simple;
	bh=nXLy5W5e94zuvp1Zg7999BBbtgC+DgyZfKtir+OJFX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fShbg4pFptmFlw7CHOv3C+YMFD25C6TL0Sv9X2jJCiJM4EYultPK/vSsMD/r5w9BhlPc9sGWpLvWEN4v/WP3E08gzETU/1TsprYM8sqfuur10gODMR3qK9jfNMu7YLxxYP8F0MLgtvZ/l2ENsfkc+QCdE73yaDFqzmgj7i/EhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTC+HK2q; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso9207531a12.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 09:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767980004; x=1768584804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=In4E7Lb9VW0WC7y33ycYwwKdwNkFxrAqJLLZ+VhvaCQ=;
        b=YTC+HK2qoni8QCrnlExhfJ/4wqhUU2pGYSZ5Etk8PX2mJLAqfZorCn4ANUl2nuEluM
         i1AsJ973khk0G3HQz6z900Oqe6QUhK35jZSisAh/cVoW6xXheNAiaFpYFiWCFK6dNsgI
         yNSNbs9WXszU4281b9Rz5BjP2Q2N4002YfUmoc1wzeRE42gqnq31QHrYQNU6DyW2qZlg
         iSuAABIhBOs4o543g0Bms4LzCabBmVXYK3HiMsVVET2ZQKMe39wC9YxBXRnoqML0wwci
         SZL/2cwOssZAk2umtNQLN8x8YCZtCD7+L5Zljg7/WSd67ntLJt+sIsPolyN49+fAg67Z
         iWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980004; x=1768584804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In4E7Lb9VW0WC7y33ycYwwKdwNkFxrAqJLLZ+VhvaCQ=;
        b=oqwpHP54mrod8pmJcjH8QE9hD03acP1hsNQp618CNFm0JwvhwoSV/kIwPusVU//TEJ
         35JXIG1neC5rgqX+2ZUkRv4nUbZ8x3M/ZgEnTRF0oZFQwExk9GHiBn7UbmsP7F0NiBpp
         pRarZzXrSQNbVgZ2sKR+3sFO0UJTSSTYGtUZZs2Ww8k/h2RttrKjm53K67jQRVnpMz5D
         cx7LkPol1hwTUTcwxJc8Y25tSMD0Ib63/lpuw8Z2iLexPuWivXjuBGmOs+ozyOVjn2dt
         J5bifgt6c8fOzui9zav/0aU2m1HlxEQpJk408Iaz4S9ukMkeEfPJmpFCN33CJk0COmEp
         7gGw==
X-Forwarded-Encrypted: i=1; AJvYcCUKxHzW7xiWykFT5f0BQ+qB8WRK0AM9zkkiOHve91ABJxoh8m+rtecfwwOQoDv8ljXRBqogdPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIEqJwZC6jjTu6h7FJmCcbuT0k0QyTvd8Wj1NrcQme6xS6Bd4
	l02aUHRJynXeIfRr5+DlSg4xJEli357z6A0EABRyNF4O6MicLXbqdwFl+nxIYS5FRHU=
X-Gm-Gg: AY/fxX7aySN8mw/YzVT9MR2UjBMq5tJyy3gk03+n4VmP5ZlWetUFrk3hbj9fFu6j5Yw
	uqvCzHtsS+6D1GS5sbM1s4FZUQRs66Clc6RV45vbFXVyD7topIz4yOqO8DFT00VOc6lq1b7+904
	QFDcES5A6weRzJoZVnyeSPrLWYf7t8zygbmahiWW+DyVfF7U37rF+B0ubck773KKUz9GeAJNeJQ
	6NcHEgT+Yfemc0wnmdslHUdBYzSxcTx9SPbEJ290qwabFeghHCl6QuSrPKmC9tGnADb+YBA5O2Z
	z9hWOvsWGsMLXyIR6B+/WL1ukjOCI1CUMQHHChZ0f30SxzJjTIZPzDL67OfPw/3tyfLdZykM1eW
	2xeeQMjpbrX2KPfgFlQppsGBFCparu5SWotdbVTo7RnDWIBgNeV/kHYt73PO8Zfm4HX2E30f/sH
	i3vajluBr5vPodajhs
X-Google-Smtp-Source: AGHT+IFufH9pLYfFOpesr9W4L4nrLY4vxaniIrFRt9iWfYXL4Lhfdv08BIs6/KNDkF0ZULaE58CdVA==
X-Received: by 2002:a17:907:cd0e:b0:b7a:1bde:a01a with SMTP id a640c23a62f3a-b8445411cffmr1126366466b.62.1767980003837;
        Fri, 09 Jan 2026 09:33:23 -0800 (PST)
Received: from linaro.org ([77.64.146.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a511085sm1162275466b.46.2026.01.09.09.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:33:23 -0800 (PST)
Date: Fri, 9 Jan 2026 18:33:18 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Shazad Hussain <quic_shazhuss@quicinc.com>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajendra Nayak <quic_rjendra@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
Message-ID: <aWE7wy4tyLsnEdXc@linaro.org>
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
 <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
 <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
 <4d61e8b3-0d40-4b78-9f40-a68b05284a3d@oss.qualcomm.com>
 <e917e98a-4ff3-45b8-87a0-fe0d6823ac2e@oss.qualcomm.com>
 <2lpx7rsko24e45gexsv3jp4ntwwenag47vgproqljqeuk4j7iy@zgh6hrln4h4e>
 <aVuIsUR0pinI0Wp7@linaro.org>
 <jejrexm235dxondzjbk5ek46ilq2gbrrhoojfcghkcpclqvtks@yfsgrxueo5es>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jejrexm235dxondzjbk5ek46ilq2gbrrhoojfcghkcpclqvtks@yfsgrxueo5es>

On Fri, Jan 09, 2026 at 09:49:52AM -0600, Bjorn Andersson wrote:
> On Mon, Jan 05, 2026 at 10:47:29AM +0100, Stephan Gerhold wrote:
> > On Mon, Jan 05, 2026 at 10:44:39AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jan 02, 2026 at 02:57:56PM +0100, Konrad Dybcio wrote:
> > > > On 1/2/26 2:19 PM, Krishna Chaitanya Chundru wrote:
> > > > > On 1/2/2026 5:09 PM, Konrad Dybcio wrote:
> > > > >> On 1/2/26 12:36 PM, Krishna Chaitanya Chundru wrote:
> > > > >>> On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
> > > > >>>> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> > > > >>>>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> > > > >>>>> can happen during scenarios such as system suspend and breaks the resume
> > > > >>>>> of PCIe controllers from suspend.
> > > > >>>> Isn't turning the GDSCs off what we want though? At least during system
> > > > >>>> suspend?
> > > > >>> If we are keeping link in D3cold it makes sense, but currently we are not keeping in D3cold
> > > > >>> so we don't expect them to get off.
> > > > >> Since we seem to be tackling that in parallel, it seems to make sense
> > > > >> that adding a mechanism to let the PCIe driver select "on" vs "ret" vs
> > > > >> "off" could be useful for us
> > > > > At least I am not aware of such API where we can tell genpd not to turn off gdsc
> > > > > at runtime if we are keeping the device in D3cold state.
> > > > > But anyway the PCIe gdsc supports Retention, in that case adding this flag here makes
> > > > > more sense as it represents HW.
> > > > > sm8450,sm8650 also had similar problem which are fixed by mani[1].
> > > > 
> > > > Perhaps I should ask for a clarification - is retention superior to
> > > > powering the GDSC off? Does it have any power costs?
> > > > 
> > > 
> > > In terms of power saving it is not superior, but that's not the only factor we
> > > should consider here. If we keep GDSCs PWRSTS_OFF_ON, then the devices (PCIe)
> > > need to be be in D3Cold. Sure we can change that using the new genpd API
> > > dev_pm_genpd_rpm_always_on() dynamically, but I would prefer to avoid doing
> > > that.
> > > 
> > > In my POV, GDSCs default state should be retention, so that the GDSCs will stay
> > > ON if the rentention is not entered in hw and enter retention otherwise. This
> > > requires no extra modification in the genpd client drivers. One more benefit is,
> > > the hw can enter low power state even when the device is not in D3Cold state
> > > i.e., during s2idle (provided we unvote other resources).
> > > 
> > 
> > What about PCIe instances that are completely unused? The boot firmware
> > on X1E for example is notorious for powering on completely unused PCIe
> > links and powering them down in some half-baked off state (the &pcie3
> > instance, in particular). I'm not sure if the GDSC remains on, but if it
> > does then the unused PD cleanup would also only put them in retention
> > state. I can't think of a good reason to keep those on at all.
> > 
> 
> Conceptually I agree, but do we have any data indicating that there's
> practical benefit to this complication?
> 

No, I also suggested this only from the conceptual perspective. It would
be interesting to test this, but unfortunately I don't have a suitable
device for testing this anymore.

> > The implementation of PWRSTS_RET_ON essentially makes the PD power_off()
> > callback a no-op. Everything in Linux (sysfs, debugfs, ...) will tell
> > you that the power domain has been shut down, but at the end it will
> > remain fully powered until you manage to reach a retention state for the
> > parent power domain. Due to other consumers, that will likely happen
> > only if you reach VDDmin or some equivalent SoC-wide low-power state,
> > something barely any (or none?) of the platforms supported upstream is
> > capable of today.
> > 
> 
> Yes, PWRSTS_RET_ON effectively means that Linux has "dropped its vote"
> on the GDSC and its parents. But with the caveat that we assume when
> going to ON again some state will have been retained.
> 
> > PWRSTS_RET_ON is actually pretty close to setting GENPD_FLAG_ALWAYS_ON,
> > the only advantage of PWRSTS_RET_ON I can think of is that unused GDSCs
> > remain off iff you are lucky enough that the boot firmware has not
> > already turned them on.
> > 
> 
> Doesn't GENPD_FLAG_ALWAYS_ON imply that the parent will also be always
> on?
> 

It probably does, but isn't that exactly what you want? If the parent
(or the GDSC itself) would actually *power off* (as in "pull the plug"),
then you would still lose registers even if the GDSC remains on. The
fact that PWRSTS_RET_ON works without keeping the parent on is probably
just because the hardware keeps the parent domain always-on?

> > IMHO, for GDSCs that support OFF state in the hardware, PWRSTS_RET_ON is
> > a hack to workaround limitations in the consumer drivers. They should
> > either save/restore registers and handle the power collapse or they
> > should vote for the power domain to stay on. That way, sysfs/debugfs
> > will show the real votes held by Linux and you won't be mislead when
> > looking at those while trying to optimize power consumption.
> > 
> 
> No, it's not working around limitations in the consumer drivers.
> 
> It does work around a limitation in the API, in that the consumer
> drivers can't indicate in which cases they would be willing to restore
> and in which cases they would prefer retention. This is something the
> downstream solution has had, but we don't have a sensible and generic
> way to provide this.

I might be missing something obvious, but mapping this to the existing
pmdomain API feels pretty straightforward to me:

 - Power on/power off means "pull the plug", i.e. if you vote for a
   pmdomain to power off you should expect that registers get lost.
   That's exactly what will typically happen if the hardware actually
   removes power completely from the power domain.

 - If you want to preserve registers (retention), you need to tell the
   hardware to keep the pmdomain powered on at a minimum voltage
   (= performance state). In fact, the PCIe GDSC already inherits
   support for RPMH_REGULATOR_LEVEL_RETENTION from its parent domain.
   (If RPMH_REGULATOR_LEVEL_RETENTION happens to be higher than the
    rentention state we are talking about here you could also just vote
    for 0 performance state...)

With this, the only additional feature you need from the pmdomain API is
to disable its sometimes inconvenient feature to automatically disable
all pmdomains during system suspend (independent of the votes made by
drivers). I believe this exists already in different forms. Back when
I needed something like this for cpufreq on MSM8909, Ulf suggested using
device_set_awake_path(), see commit d6048a19a710 ("cpufreq: qcom-nvmem:
Preserve PM domain votes in system suspend"). I'm not entirely up to
date what is the best way currently to do this, but letting a driver
preserve its votes across system suspend feels like a common enough
requirement that should be supported by the pmdomain API.

> 
> Keeping GDSCs in retention is a huge gain when it comes to the time it
> takes to resume the system after being in low power. PCIe is a good
> example of this, where the GDSC certainly support entering OFF, at the
> cost of tearing link and all down.
> 

I don't doubt that. My point is that the PCIe driver should make that
decision and not the (semi-)generic power domain driver that does not
exactly know who (or if anyone) is going to consume its power domain.
Especially because this decision is encoded in SoC-specific data and we
had plenty of patches already changing PWRSTS_OFF_ON to PWRSTS_RET_ON
due to suspend issues initially unnoticed on some SoCs (or vice-versa to
save power).

Thanks,
Stephan

