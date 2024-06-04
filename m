Return-Path: <stable+bounces-47915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD938FAF32
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387A21F20FAA
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FF144D10;
	Tue,  4 Jun 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTRU5Khl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0921448C0
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494420; cv=none; b=h8gISHWRfJhKv3/OtJ86jAgTEonT6jIJ2Yb4kIrLnBcXdrUvd76KPAT7bA4cEALt+x/fRDc7Q+Ni0HmWQHN4p+bGrNuNknzY4V4r/ZoyppQo7x7t9iEbnuSzjeF8lIxtMCfCYfvb8NWMhkCjqSFIHknoF7QN3RPFF7OX5UdarDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494420; c=relaxed/simple;
	bh=mWx0HO7MnYdM2GA36+DT4q83BPtn9x4BGJwJUoyDg94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mghn8T4bsKJ1y9JVNXodoNRrhlT8DnwPc/TYcZjH8iKGfd5hXy+++ZHdmiuYYnBjHOZ1/c4+NYS9MJqmpxHTG2jdtqkS5e4vjLOc80P0d6RMA+f6Pm+XJ8ZNyqGaRvNHBwVdrhcpeLF+zqGoI4HarAlLVDQkBU7IaZORu7EolRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DTRU5Khl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e72b8931caso58404711fa.0
        for <stable@vger.kernel.org>; Tue, 04 Jun 2024 02:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717494417; x=1718099217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91LqZFlYL5/F2cNmD4SIK00pujZpSwxCmM3GgQD7Ylk=;
        b=DTRU5KhlxwdMUF1S+Dz1P8rnrh+QG0qfptY/yJfQYBz2PlwU1R9QcQAXU+NsoymoyR
         wgR8xzUk8Q9Y89dCE8+0Ydy1FzpAlNUqATs9m3LrlqcRhE1MzG61bWa9Eoxb8lf6GPJX
         pIc6EiVAmQgSK7WHoSl3FAV2XkymBNsRHdos/+djV3u2gkfNti66rCLy8Vf3TfrOg1PW
         LVPyA+8B3VEWuyC8mQlQxd0nUJb592oiecDsoTwFzUJk45hofF65j2Jchhva4mZena20
         FidNvvjY+AN6BpUufqL/xkDmY+ZGBCiISb+FsKjcmF5CTPfW0n1nAAnkPK5NLSfv4oWX
         1XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717494417; x=1718099217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91LqZFlYL5/F2cNmD4SIK00pujZpSwxCmM3GgQD7Ylk=;
        b=a3pIW+5EjrFlD2lPudpKaxtjvkwD+VwhgtK2mVRhM5Afbc8NsFE53B/mmK/hN4jrTN
         Q+Y1vEBTzim9UNG3JXcrrDgawZnd7T51yXQSOC+Ocao96fu+qtDjHOGr+V+0vxN/M0Iz
         1apBtkAwMaaWjK3pR15Vui3tTaGDclpdmfrkL7QJwNwplpcTZGLiJaLKkhYxqlDRcpug
         kfjw1xBNGSLJOjQNFZRE04wCIsZ747fPGz4EG7pcOKTdRRLWDX4Pa6O9ze0DW/S12pml
         Ud2xKELhAMyHiQctGTl2xN0JGcY0EdlGcr1O2GXl68LOvKonc7kcMYT4Bb8Vc+weGDlS
         LDiA==
X-Forwarded-Encrypted: i=1; AJvYcCWpJyzlUQxU1VqEFWXziXTcNj4z5Z5kas78NOJf8TAYOiqUppbW/XHLUo0gkmNcmcaUpE9uGrUvnk3sjkcDUCGYulFE7NkY
X-Gm-Message-State: AOJu0Yz7N35eyY1JLURbZlw8gYSH42Qxr92sKkm2vxHjEcl1wLVP6/Fh
	HeQmosiP7B5Sp6rUdJSo491y1OkwQORK+RTYXvj/SS3XCADh0nfq/5N81C2Z2tY=
X-Google-Smtp-Source: AGHT+IGP3Av98j9yu/1Mbhl+izjyOMD6OnhkoHEAMTZcSfCVzSQLxJFI5S0RbigNCtMU2ew04uBK9Q==
X-Received: by 2002:a2e:9295:0:b0:2ea:8d54:4516 with SMTP id 38308e7fff4ca-2ea951288aamr68154601fa.27.1717494417079;
        Tue, 04 Jun 2024 02:46:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91b9d683sm14655841fa.8.2024.06.04.02.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:46:56 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:46:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com, Doug Anderson <dianders@google.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7180: Disable SuperSpeed
 instances in park mode
Message-ID: <tbtmtt3cjtcrnjddc37oiipdw7u7pydnp7ir3x5u3tj26whoxu@sg2b7t7dvu2g>
References: <20240604060659.1449278-1-quic_kriskura@quicinc.com>
 <20240604060659.1449278-2-quic_kriskura@quicinc.com>
 <le5fe7b4wdpkpgxyucobepvxfvetz3ukhiib3ca3zbnm6nz2t7@sczgscf2m3ie>
 <e0b102b6-5ea5-4a86-887f-1af8754e490b@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b102b6-5ea5-4a86-887f-1af8754e490b@quicinc.com>

On Tue, Jun 04, 2024 at 01:34:44PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 6/4/2024 1:16 PM, Dmitry Baryshkov wrote:
> > On Tue, Jun 04, 2024 at 11:36:58AM +0530, Krishna Kurapati wrote:
> > > On SC7180, in host mode, it is observed that stressing out controller
> > > results in HC died error:
> > > 
> > >   xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
> > >   xhci-hcd.12.auto: xHCI host controller not responding, assume dead
> > >   xhci-hcd.12.auto: HC died; cleaning up
> > > 
> > > And at this instant only restarting the host mode fixes it. Disable
> > > SuperSpeed instances in park mode for SC7180 to mitigate this issue.
> > 
> > Let me please repeat the question from v1:
> > 
> > Just out of curiosity, what is the park mode?
> > 
> 
> Sorry, Missed the mail in v1.
> 
> Databook doesn't give much info on this bit (SS case, commit 7ba6b09fda5e0)
> but it does in HS case (commit d21a797a3eeb2).
> 
> From the mail we received from Synopsys, they described it as follows:
> 
> "Park mode feature allows better throughput on the USB in cases where a
> single EP is active. It increases the degree of pipelining within the
> controller as long as a single EP is active."

Thank you!

> 
> Even in the current debug for this test case, Synopsys suggested us to set
> this bit to avoid the controller being dead and we are waiting for further
> answers from them.

Should these quirks be enabled for other Qualcomm platforms? If so,
which platforms should get it?

> I can update thread with more info once we get some data from Synopsys.
> 
> Regards,
> Krishna,
> 
> > > 
> > > Reported-by: Doug Anderson <dianders@google.com>
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > ---
> > > Removed RB/TB tag from Doug as commit text was updated.
> > > 
> > >   arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > index 2b481e20ae38..cc93b5675d5d 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > @@ -3063,6 +3063,7 @@ usb_1_dwc3: usb@a600000 {
> > >   				iommus = <&apps_smmu 0x540 0>;
> > >   				snps,dis_u2_susphy_quirk;
> > >   				snps,dis_enblslpm_quirk;
> > > +				snps,parkmode-disable-ss-quirk;
> > >   				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
> > >   				phy-names = "usb2-phy", "usb3-phy";
> > >   				maximum-speed = "super-speed";
> > > -- 
> > > 2.34.1
> > > 
> > 

-- 
With best wishes
Dmitry

