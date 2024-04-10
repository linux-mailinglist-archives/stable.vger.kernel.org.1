Return-Path: <stable+bounces-37929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C993889EB8C
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 09:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE591F21B8A
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 07:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA213C91A;
	Wed, 10 Apr 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOBKYBzr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519613C910
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733210; cv=none; b=Su43MZkLgqU0J1OEBCARa4cljjgm8zciGXVA1gB18teI2OsFdVa5CWFltICPtJcUhPl2B2KnZh1f9+8IcRUi+kzuhOabXRwDN9Xr30dmamldM97MqFRy/5IUUOLSq6hTM3SR6+VTNDOMRi8EDzXNOZtmGmaFCTfCzYM7zQpufIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733210; c=relaxed/simple;
	bh=VAOQqcbH2fGAXKGAq1Y4ef6h5o32yaXYKlxq4mn9mXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQpvuHo3LUBWuEOsK4SAxbbnfMSFjkPFmDLZ4924DXejcrrktUBIbNrGgXWDi0VN3k0AEASWtlVzUccyyvkLIGlb7ZyriOcqZRiK3SolHlwBl+rcv+8k+KQzCG33mLhAyYKrtRsWzWyHq9RK7d+fyLZSLOrC9mzmTkbTudqKOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vOBKYBzr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so6031065b3a.3
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712733209; x=1713338009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftXkPjEuRHpJFhb+3Ti/S/TeSPGN8ml/FtACaummLvw=;
        b=vOBKYBzrFkMfGJA3GILy5k2TmjtGysWF31pf39xePWD1Lf4Af69noeTGW1Y6qnSmGU
         iLhKwNfPd5sEk6fiVOQRQPl6Se4C1a9jAlJaYMUdTROoo0QUqVCFjglO3OMht/yW15xz
         004CNtFdDTzjlzMSkzh50lRWe84q5TV6wypOBDCtFGW4Km1GwZUT9cHP69n1lUElw2Mr
         tPqy7YjqTMWTxaGDTBgIPVrwrdNeBiKcfQW8tZaRhHe7fpD9NOG8ibAE8W3xzYRGheJe
         PBaESjXIcUl4+KlJ8p3Tw98nDDZER1zAaCcwf/dRdrZpzzEglh8yIH6do1UYDdPLKTl6
         iw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733209; x=1713338009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftXkPjEuRHpJFhb+3Ti/S/TeSPGN8ml/FtACaummLvw=;
        b=ZRpInCgPwCxii5x1AtKPl/ixlAp7t87nU1xpaafjI83RW8s+Q5Odtn6u+/z//MmSmj
         hNRKho4LYpNrqD2+AMdmQajZNS2J3iLHdatOw62AP8dqSv28lJr3HbjwBGLq+LrVU3mJ
         Rnhb0oAsQ39t1EqFZy0QocGQSzLQJUCy8LVtZnjlXqFewRtpeTcpjkbVm5FMHKuLnWI1
         2bA0MClAfJLnkTdesG2kU0125yhLLNE2CMeoJ8MiemJJL8r0DnicJO9sWTUzyCchopsu
         kqt7EedpB0S64qdSX/ypZlCmeervM2M/lxOi1DgkGli8htE1FNz8XYzFwNtNdJHwOOAg
         MZCw==
X-Forwarded-Encrypted: i=1; AJvYcCXN5g0CC2qNOS57reIjZD/7hPobX0BXkQAuyOSP488cn4GJnxc09+vEHzDbmNKY/NgwQ1M5gADhw9NKiu49FAUGZ4xtv8aq
X-Gm-Message-State: AOJu0YzU6SaODGERbJAGS70SBb1SyXXij7r7TiDpcQMqPPi4//o/ZlYa
	JU8Rz2J0dxqFgwgvZl9sn51yTTh1VTrLSPRpqi9ERAu0G21MPYNrU+PLR/WvZQ==
X-Google-Smtp-Source: AGHT+IEqMko9xQaFiVxn2dbruZCRuL+ipkWsAHqTXxMQyDA1zkPELqZYc1dLKjJ7cOToCTcI/HKgDQ==
X-Received: by 2002:a05:6a00:1407:b0:6ed:d8d2:503d with SMTP id l7-20020a056a00140700b006edd8d2503dmr56767pfu.20.1712733208479;
        Wed, 10 Apr 2024 00:13:28 -0700 (PDT)
Received: from thinkpad ([120.60.76.50])
        by smtp.gmail.com with ESMTPSA id fn10-20020a056a002fca00b006ecfdcc2de9sm9827278pfb.10.2024.04.10.00.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:13:28 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:43:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: Fix the msi-map entries
Message-ID: <20240410071322.GB2903@thinkpad>
References: <20240318-pci-bdf-sid-fix-v1-0-acca6c5d9cf1@linaro.org>
 <171254262026.648987.5589442883549909128.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171254262026.648987.5589442883549909128.b4-ty@kernel.org>

On Sun, Apr 07, 2024 at 09:17:20PM -0500, Bjorn Andersson wrote:
> 
> On Mon, 18 Mar 2024 12:49:02 +0530, Manivannan Sadhasivam wrote:
> > While adding the GIC ITS MSI support, it was found that the msi-map entries
> > needed to be swapped to receive MSIs from the endpoint.
> > 
> > But later it was identified that the swapping was needed due to a bug in
> > the Qualcomm PCIe controller driver. And since the bug is now fixed with
> > commit bf79e33cdd89 ("PCI: qcom: Enable BDF to SID translation properly"),
> > let's fix the msi-map entries also to reflect the actual mapping in the
> > hardware.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] arm64: dts: qcom: sm8450: Fix the msi-map entries
>       commit: d6c0602429490ff90d3f79a431aec1be779650b7
> [2/3] arm64: dts: qcom: sm8550: Fix the msi-map entries
>       commit: 398b7c7dda6792c2646a2208a6cbab02da97d6e5
> [3/3] arm64: dts: qcom: sm8650: Fix the msi-map entries
>       commit: 3ac680a514b6e63428481b1e6fb069383e5b7add
> 

Can this series applied as fix for 6.9 since the driver patch went in during the
merge window?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

