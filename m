Return-Path: <stable+bounces-95592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554BA9DA344
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 08:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73A516205D
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA7314A4D1;
	Wed, 27 Nov 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAWT5veW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05E1547C0
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693375; cv=none; b=AlqluaPM9AgSjyPRVDDE5W0Ir/Afs4ragfZ2itPammEby4m4cNvfU50S1ZjfF399NYBIxATGcrHadTgnlffTyshKfA+OZPDCCDaztAjF5U7fBoKuyRs52lHoZTCUJQELDH1rYhnjXef5huXoJUuH7a8I92TiHcXd7s7sr2/ej18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693375; c=relaxed/simple;
	bh=LU6AwlYsk3CPKKY2s0mNL0hPX4NuZPGAywEkPk0vpeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EElZoPyp5wFqet2s7iejKNLt8JyLEUoQCSCm49jY6MUdvhi0FarbUmx2EEcZ9mbYs0OK/q/QR+HWzNf/IMFyVp8uZZEhIVGqMEX6L2jjy5iuQXun5LnstIpJKmQC0jaPnz8OYeRsPxulZw0t2hCtYSOCq68Tan2mqcojDyqt5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xAWT5veW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-212008b0d6eso52469715ad.3
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732693373; x=1733298173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMWDgk/n3j4GiaybswgAiKAVmYvm7oHmNlJIVMIMNac=;
        b=xAWT5veWFj/XYJ1A1tOPYsUPA5QLLbRSKq1cnhQPYGAcid7rDYrT61U9HlxPNax0QK
         2rok6R4SlfXLXShsS3Ae8TgXZP1Fr8A5FjLtZ+8/dtLgWgguCG1MeE/msauMNJyHWEe9
         6pA/Lgfrw9TzNDgH8l73V435/DD6/Yr4qyVTTdglwIU5gu4qpBd5z9siq4zGz7sngUrH
         tehw0J7GDcwIsgmrC6Fi1/RmtrW4rULmpDdNT/zKnTXK01H9LLPc6q+Y0RatrJPspGi5
         2gYi+9c1OYfJpUKty8iL5zGkrIuuxUTNj8ybKpthN2h94l898Y7HqduXYZeu4jmjeTwz
         nlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693373; x=1733298173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMWDgk/n3j4GiaybswgAiKAVmYvm7oHmNlJIVMIMNac=;
        b=kblZTvIZ3uZ1+S6MVwFuFY/BpgB9yDfbwTSVzcDye+mpayEN+YQIzJfpwevGIWapg4
         oNIy6xM88mzAXVN48v9EKla5zhpgJnKCcpmlPQ70p16O+Yp9PIcLotqo9Js/eyzq3bqj
         hMSc8ukC8+wr7cFxzVBqVpHN8kuompviOFWjO4N5r6AB+mE8giJdWdW6/VNQ1DQQKJl1
         B1nuf2DC5Ux5iXP+gkb8m2FKEmF/ALAJj0qs74awTOIk1/omvPQketj5J0ybECNl0EJw
         RvjTicR6aGt0z3Ko8JwkwqZwVjadtZSA6UPfyI0XjjxAY2hJav5wLlemuUMcEfygVGTr
         kvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMTyY6/gkAdForKKRKXHmhCxJiorb0ttpLHB9dkSgisYTfOZUe2ILKLxBKMR/p7nPWPkdc6wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5bX7iCEaha+cEcbLT7F1oep7pPWJXy+t6lV+GL8jLM8plXMg
	5R/ElUBKHazzHYfMxuw6VO/P8d7tX525Xi2Xif4/x/6hbGa4eYsC/M0Z8Yhk0w==
X-Gm-Gg: ASbGncutcODmJB/sc1vJCJ9zyjlN1vxaYTVcdniqcgf/yGPlSlCQzzF/G8hEodLpmQO
	06SEi3Ri0xpeoQVDfUkKmswvrXBFoo2Ky2gVs8E+IhGl/7encnUq1V5D8PmZiPQxDtl51HtLL8I
	8d8TFP3BAnHOcwxwSrSFQhIMTv2QyPTeLpp1ux4q9dwDxAtB8UYJYpNXZi5OKAaxKjz0SV/4n1S
	oOB0uecpP3yncQFTK2Dicxrtk+ozUJj0b/AipZ78Ou0A/otImh3Pamdka/Z
X-Google-Smtp-Source: AGHT+IGp9I4DmuKPduEUQ+Vs8HvCWxBrCkbO+5RyEgGe/YSQ1SwDti6JUnGKKHfl4zUAgD/Vk310rA==
X-Received: by 2002:a17:902:d551:b0:211:f8c8:372c with SMTP id d9443c01a7336-21501381ba1mr22923355ad.21.1732693373062;
        Tue, 26 Nov 2024 23:42:53 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc12f22sm96678915ad.186.2024.11.26.23.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:42:52 -0800 (PST)
Date: Wed, 27 Nov 2024 13:12:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
	Nitin Rawat <quic_nitirawa@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sm8550: Keep UFS PHY GDSCs ALWAYS_ON
Message-ID: <20241127074245.4fhr3gypxbjipqnq@thinkpad>
References: <20241107-ufs-clk-fix-v1-0-6032ff22a052@linaro.org>
 <20241107-ufs-clk-fix-v1-1-6032ff22a052@linaro.org>
 <tebgud2k4bup35e7rkfpx5kt7m5jxgw3yo3myjzfushnmdecsj@e4cb44jqoevp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tebgud2k4bup35e7rkfpx5kt7m5jxgw3yo3myjzfushnmdecsj@e4cb44jqoevp>

On Tue, Nov 26, 2024 at 10:21:10PM -0600, Bjorn Andersson wrote:
> On Thu, Nov 07, 2024 at 11:58:09AM +0000, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Starting from SM8550, UFS PHY GDSCs doesn't support hardware retention. So
> > using RETAIN_FF_ENABLE is wrong. Moreover, without ALWAYS_ON flag, GDSCs
> > will get powered down during suspend, causing the UFS PHY to loose its
> > state. And this will lead to below UFS error during resume as observed on
> > SM8550-QRD:
> > 
> 
> Unless I'm mistaken, ALWAYS_ON makes GDSC keep the gendpd ALWAYS_ON as
> well, which in turn would ensure that any parent power-domain is kept
> active - which in the case of GCC would imply CX.
> 

That's correct. But there is one more way to fix this issue. We can powerdown
UFS (controller and device) during suspend and the ufs-qcom driver can specify
the default suspend level based on platform. I think that would be more
appropriate than forbidding CX power collapse for the whole SoC.

Let me cook up a patch.

> The way we've dealt with this elsewhere is to use the PWRSTS_RET_ON flag
> in pwrsts; we then keep the GDSC active, but release any votes to the
> parent and rely on hardware to kick in MX when we're shutting down CX.
> Perhaps this can't be done for some reason?
> 

UFS team told me that there is no 'hardware retention' for UFS PHYs starting
from SM8550 and asked to keep GDSCs ALWAYS_ON. So that would mean, there is no
MX backing also.

- Mani

> 
> PS. In contrast to other platforms where we've dealt with issues of
> under voltage crashes, I see &gcc in sm8550.dtsi doesn't specify a
> parent power-domain, which would mean that the required-opps = <&nom> of
> &ufs_mem_hc is voting for nothing.
> 
> Regards,
> Bjorn
> 
> > ufshcd-qcom 1d84000.ufs: ufshcd_uic_hibern8_exit: hibern8 exit failed. ret = 5
> > ufshcd-qcom 1d84000.ufs: __ufshcd_wl_resume: hibern8 exit failed 5
> > ufs_device_wlun 0:0:0:49488: ufshcd_wl_resume failed: 5
> > ufs_device_wlun 0:0:0:49488: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x84 returns 5
> > ufs_device_wlun 0:0:0:49488: PM: failed to resume async: error 5
> > 
> > Cc: stable@vger.kernel.org # 6.8
> > Fixes: 1fe8273c8d40 ("clk: qcom: gcc-sm8550: Add the missing RETAIN_FF_ENABLE GDSC flag")
> > Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Suggested-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/clk/qcom/gcc-sm8550.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
> > index 5abaeddd6afc..7dd08e175820 100644
> > --- a/drivers/clk/qcom/gcc-sm8550.c
> > +++ b/drivers/clk/qcom/gcc-sm8550.c
> > @@ -3046,7 +3046,7 @@ static struct gdsc ufs_phy_gdsc = {
> >  		.name = "ufs_phy_gdsc",
> >  	},
> >  	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
> > +	.flags = POLL_CFG_GDSCR | ALWAYS_ON,
> >  };
> >  
> >  static struct gdsc ufs_mem_phy_gdsc = {
> > @@ -3055,7 +3055,7 @@ static struct gdsc ufs_mem_phy_gdsc = {
> >  		.name = "ufs_mem_phy_gdsc",
> >  	},
> >  	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
> > +	.flags = POLL_CFG_GDSCR | ALWAYS_ON,
> >  };
> >  
> >  static struct gdsc usb30_prim_gdsc = {
> > 
> > -- 
> > 2.25.1
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

