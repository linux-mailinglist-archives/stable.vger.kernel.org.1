Return-Path: <stable+bounces-204626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB055CF2D31
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D6693010CE2
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA353370EC;
	Mon,  5 Jan 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPN/Y6xV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62559336EEE
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606461; cv=none; b=ki2bpqITn6+taEAOU80gS8Ae8cSX0h2MU5rZdsDJyA9CcToBDYcjtQAvD2u1zpVk1S+mLPUVodTLGc0yTQs0MWBB4kLAPQnXBcZsh+9QElM4Mz3GHx/SPnFT9yUrXE4mrgPm7JG283brSTJDBXdHauUhrZ2AzKOwpFYIuD4pse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606461; c=relaxed/simple;
	bh=e9Sk/pAZClslZsNFls1Af5fvQTuuOQ2N2wBxEju3Gv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx6DGjL/SuG6cbkRMqdmfVXaXPNrTgeH0UYPDLVjwvnlhujj1ApKfX8VYzmtL4phQuwLLzNDMILxDU5Biql6+UmEwm7hsTUfQgr5vYFrAspusIkzq8ZIeiCbbp7aslad9ZIkgZpy6Q5T78iu4YDHcZtLK3/eXodY6Oio8xOcY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPN/Y6xV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7a6e56193cso2170634566b.3
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767606458; x=1768211258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7s0pU3R0ZSMnky2KP1pM8uey2sObBdI/T7yO/ZGH/N8=;
        b=TPN/Y6xVa9+GWWTjWs94ZJc37E5ySMPLP4jPvMEASn0iJAcGoA0gQX0z3rlu5OFR7A
         w6glF3ZxhNyzj19WsxUsfY3gL7/Lmxfgej5QdVVjHOS2fklSN91SGjWcBjI5AJb0096B
         cE02h7u7ApAwgnfbSX2bUYh7IpaKe+n7o84w1Jk4wZPDAC9/D0x3QQILCymV6r2grVh4
         EYnB22y0msUP2Fx30qkfGO+151vFwimVTifnBPkYTEZBdihl+NU/lwKSnqV9szkXwh4o
         Cm5tMHKWOqF5qbzbmlcQefejzHH61PdpgjmpaLbzpSsItNYkFK9dKggjGAi+UGN3roH5
         p5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606458; x=1768211258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s0pU3R0ZSMnky2KP1pM8uey2sObBdI/T7yO/ZGH/N8=;
        b=CpSicraEXbUj8yPNJ3+dqpuMX+rdhsfHB+ToZjEnTK6oQL9gIvG5j3zyF+ctXyk/qF
         ywFj3HdCgMwDNdlsf6UURykxL9xTpzwqStzdwHpEneQ5XV1XpZ9TDgwJYKKOoMrOheoK
         t+m65tY99X4bBsYuf0jhuJGCNziwcznlSeKbl7ycI0QNEVJBLs4ms+5dDb05mCz87L5L
         +1/T4uHWzZZNCtVgF8+soFX1zDWJWKsK7aMLAPx0NwBNiZ8QQaUA8U2SQ/W9jEhLD4DU
         2H0xJ40/rHQajeotxflDos3NtaM+DSd5Q0vqE1i4ofTVq6p+Th7hUZPC15h8lNCTdovH
         Q2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVAnbTO6kGp0kQyeezkFMCBziUMCYDext0vBZwLrW2/scNnaBWO95LCYr/IO+MXfVDC1i+L1Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0s9eiedlwyX9IhLP86wecMeXVhGGTjsPjJltiBtp/p+e9+fd/
	UBsWAvPUnmptw7iaUDrN+Yv2aw1a+f8ZsufHEZfUuXA68bT1hU//CWtBIk4KHdxqCb4=
X-Gm-Gg: AY/fxX57sF6hz4w12VxtAW8JUddIQry5jh0HzHYdtjqmN2vrDFJM7TzYFZ0WgKBTMfP
	bLGp3v2uYYrihr+5OhiP3OOp5OAb+KS3wJ8pFDuZeB5TzXS+oP2IwMt88GmaOlFECO2adHBqcmi
	eYr1b28WEGNfnM4kZbn7SX0izxlJwVFsVm5Peq31bn57aSdQZ3f6+657Ddt0iST/BniByoeJbPB
	TfxE+lOUL1xMpjDZSOfKHV0sHAoQA7Lc90Xdn4u9SD9SAXypnnXIKxix12/bVKPqfl/LD6hLNM+
	HJDmbJPB0RfyCZ3fLaARQ74G22cvE62khBQyy8sR+y2E0KIG3pDTcpTesVQ0F8V0ckKxRyQE4Hu
	Vhh7817T+e/hohfB+TG2+5pK/s3KlNnvS499mC2JgpxuX//rHQkkbOdegREKg4yFQfo0gr5Zydy
	2NzeGslUkx32uIpaG8
X-Google-Smtp-Source: AGHT+IHtHz5vJ1UWzG+Etyf4fbI0hcKKBa1UrAp1qWDsuB1UqEaDANN85lzoP5jTefzne3dATAX6lQ==
X-Received: by 2002:a17:907:3da3:b0:b70:b93c:26cf with SMTP id a640c23a62f3a-b8036f2d0a0mr4542730466b.6.1767606457580;
        Mon, 05 Jan 2026 01:47:37 -0800 (PST)
Received: from linaro.org ([77.64.146.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f51144sm5542914066b.69.2026.01.05.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:47:37 -0800 (PST)
Date: Mon, 5 Jan 2026 10:47:29 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <aVuIsUR0pinI0Wp7@linaro.org>
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
 <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
 <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
 <4d61e8b3-0d40-4b78-9f40-a68b05284a3d@oss.qualcomm.com>
 <e917e98a-4ff3-45b8-87a0-fe0d6823ac2e@oss.qualcomm.com>
 <2lpx7rsko24e45gexsv3jp4ntwwenag47vgproqljqeuk4j7iy@zgh6hrln4h4e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2lpx7rsko24e45gexsv3jp4ntwwenag47vgproqljqeuk4j7iy@zgh6hrln4h4e>

On Mon, Jan 05, 2026 at 10:44:39AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 02, 2026 at 02:57:56PM +0100, Konrad Dybcio wrote:
> > On 1/2/26 2:19 PM, Krishna Chaitanya Chundru wrote:
> > > On 1/2/2026 5:09 PM, Konrad Dybcio wrote:
> > >> On 1/2/26 12:36 PM, Krishna Chaitanya Chundru wrote:
> > >>> On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
> > >>>> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> > >>>>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> > >>>>> can happen during scenarios such as system suspend and breaks the resume
> > >>>>> of PCIe controllers from suspend.
> > >>>> Isn't turning the GDSCs off what we want though? At least during system
> > >>>> suspend?
> > >>> If we are keeping link in D3cold it makes sense, but currently we are not keeping in D3cold
> > >>> so we don't expect them to get off.
> > >> Since we seem to be tackling that in parallel, it seems to make sense
> > >> that adding a mechanism to let the PCIe driver select "on" vs "ret" vs
> > >> "off" could be useful for us
> > > At least I am not aware of such API where we can tell genpd not to turn off gdsc
> > > at runtime if we are keeping the device in D3cold state.
> > > But anyway the PCIe gdsc supports Retention, in that case adding this flag here makes
> > > more sense as it represents HW.
> > > sm8450,sm8650 also had similar problem which are fixed by mani[1].
> > 
> > Perhaps I should ask for a clarification - is retention superior to
> > powering the GDSC off? Does it have any power costs?
> > 
> 
> In terms of power saving it is not superior, but that's not the only factor we
> should consider here. If we keep GDSCs PWRSTS_OFF_ON, then the devices (PCIe)
> need to be be in D3Cold. Sure we can change that using the new genpd API
> dev_pm_genpd_rpm_always_on() dynamically, but I would prefer to avoid doing
> that.
> 
> In my POV, GDSCs default state should be retention, so that the GDSCs will stay
> ON if the rentention is not entered in hw and enter retention otherwise. This
> requires no extra modification in the genpd client drivers. One more benefit is,
> the hw can enter low power state even when the device is not in D3Cold state
> i.e., during s2idle (provided we unvote other resources).
> 

What about PCIe instances that are completely unused? The boot firmware
on X1E for example is notorious for powering on completely unused PCIe
links and powering them down in some half-baked off state (the &pcie3
instance, in particular). I'm not sure if the GDSC remains on, but if it
does then the unused PD cleanup would also only put them in retention
state. I can't think of a good reason to keep those on at all.

The implementation of PWRSTS_RET_ON essentially makes the PD power_off()
callback a no-op. Everything in Linux (sysfs, debugfs, ...) will tell
you that the power domain has been shut down, but at the end it will
remain fully powered until you manage to reach a retention state for the
parent power domain. Due to other consumers, that will likely happen
only if you reach VDDmin or some equivalent SoC-wide low-power state,
something barely any (or none?) of the platforms supported upstream is
capable of today.

PWRSTS_RET_ON is actually pretty close to setting GENPD_FLAG_ALWAYS_ON,
the only advantage of PWRSTS_RET_ON I can think of is that unused GDSCs
remain off iff you are lucky enough that the boot firmware has not
already turned them on.

IMHO, for GDSCs that support OFF state in the hardware, PWRSTS_RET_ON is
a hack to workaround limitations in the consumer drivers. They should
either save/restore registers and handle the power collapse or they
should vote for the power domain to stay on. That way, sysfs/debugfs
will show the real votes held by Linux and you won't be mislead when
looking at those while trying to optimize power consumption.

Thanks,
Stephan

