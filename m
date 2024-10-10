Return-Path: <stable+bounces-83366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9970998A7C
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 16:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C55C1F2740F
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2DB1E47AA;
	Thu, 10 Oct 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFwvTDLR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B61E47A4
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571334; cv=none; b=mafYC50Ag2FoOLl8fmgjiy8xgQgVph6cCkO1MA2yGY/jQ85DlYvOQoq96WiTRhLPPKm7yN/dDj+xw1Oax54MG/+AFsQxZFsyd4VNUQhN2eShCVIqQtyMy2c6EDMUNAnoH76DPHrmiSTO8oFWmdERx6+etU3GiVS0UNpK8zC3fFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571334; c=relaxed/simple;
	bh=J8h7ZogSRVYi3JZp242VuIB8P5Hx5C5R4FBhWsIGOgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbIQkfptijS0DuHXCVpBal4fs0djLb6fQvuX+kvp87LPFg2Ek4QT+Kz9EOHz4Snfk70OMGIDIBHKvppfJ0x7XXMDNZO7kC/+DQ1kcOC9VI14MbXnrVHpcL03mi3Fh+mEThr3bX95cH/GzrEpPcIcd+LWYLojx1ari18U7MpJdlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFwvTDLR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso15598091fa.3
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728571330; x=1729176130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TSCYi8JcMLXDaF73CrzXwPeVuGXfVTJYUL9WPyu/FF4=;
        b=sFwvTDLRAUoUFyGMt2lhgs0iOLJL8JKxM/29HP3LIkkwC1lvLo4hcExukLDQqOVAuf
         GfnINho++2kGxZwwAWCLLEDZAGPARBdPetTTsz7BL479RaJHfeG/KT1RmQ95av20eQgf
         D4xG/XXcw6QZQhwaYJmZJ64d5D8LSsOGe0KiHBYR2KCIp7nsttZ3OKaFeekT6QvOQ6tr
         DMCp1idfFO2mrqYFwazzrOft5p3CBxvXhA7eTNXpOdCSakU6D7+h5Gh8gAA5Lbfrgs36
         WugVMPPXgXcLGA+oY2dm4V3476VvctmoUYpQghM4VoR5hrTfHFSE3oqcKWzyfuZl1jEY
         Otvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728571330; x=1729176130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSCYi8JcMLXDaF73CrzXwPeVuGXfVTJYUL9WPyu/FF4=;
        b=RUNtyZjX/YSNbqCzHAFJd2E1Nu8N/VD8hq95HQh35UGJStZchdGiAyE1OogZB06Yzu
         dt82vNhclEOhUVDdwh7P+12mpS+W9+ojK/hhShpKE4LRgizpdp922YYw7uletvqMaErw
         Vb+Iqg8Jr4wBVVJCyHPZnKV3S7ln+7DDX9C0IqJSeLri6ftGqaasXsDFEKhf42i3LwOY
         YwGLy6vopkVKy0VkL6eD+YqKTPZ4FF6herESm6jfeIPPSno7LiLuBLmrYFrUzlKt2mbC
         99y8c8YLFJpK3Hi6H1juIi8g6cTZnf6xTs1HV7MypmRLRhpHdkrXqqgqv99UGviz/SOZ
         N2vA==
X-Forwarded-Encrypted: i=1; AJvYcCXS32jz/MT0184QCNh3QmFH6Jt2PjBkrzjLlh9rEWL86E1IZVio0We+VHRU92UUR1958egBnuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQX7NH6JWR3k2jYqaUeRF708Tcm/49oPhuqLvKzIKjvavcjsS
	0mdExC1T6lPRXN6g3a/hu6R4EwVfrwbWOaVKA0Y9bUJumKQi624T7zWL8pgKUg9DuVx9Jdlm857
	z/Lc=
X-Google-Smtp-Source: AGHT+IHTXbpgPQx1CNya5s++GATNvkC8R0h710vIpZWBj7Fxa5x0RbTR+gUaQHMlnVb3y0lAfmds6g==
X-Received: by 2002:a2e:be23:0:b0:2ef:1b1b:7f42 with SMTP id 38308e7fff4ca-2fb187e7de2mr63367001fa.36.1728571330142;
        Thu, 10 Oct 2024 07:42:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2459c93esm2249621fa.55.2024.10.10.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:42:08 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:42:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: neil.armstrong@linaro.org, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Chris Lew <quic_clew@quicinc.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mark pd-mapper as broken
Message-ID: <2fqd3hkj7j2lppxzfl2fjfzrik3jql2gk7chexaajeybcrz3kc@rvx565zzmlmp>
References: <CAA8EJpoiu2hwKWGMTeA=Kr+ZaPL=JJFq1qQOJhUnYz6-uTmHWw@mail.gmail.com>
 <ZweoZwz73GaVlnLB@hovoldconsulting.com>
 <CAA8EJprg0ip=ejFOzBe3iisKHX14w0BnAQUDPqzuPRX6d8fvRA@mail.gmail.com>
 <Zwe-DYZKQpLJgUtp@hovoldconsulting.com>
 <c84dd670-d417-4df7-b95f-c0fbc1703c2d@linaro.org>
 <ZwfVg89DAIE74KGB@hovoldconsulting.com>
 <jtxci47paynh3uuulwempryixgbdvcnx3fhtkru733s6rkip7l@jxoaaxdxvp3d>
 <Zwffi40TyaMZruHj@hovoldconsulting.com>
 <CAA8EJppWgcyzS14rY2TfX2UNR1iqKBo1=qxHAbwkbeXLrZ2MPw@mail.gmail.com>
 <ZwfiuJW1gkYPFic1@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfiuJW1gkYPFic1@hovoldconsulting.com>

On Thu, Oct 10, 2024 at 04:20:40PM GMT, Johan Hovold wrote:
> On Thu, Oct 10, 2024 at 05:13:44PM +0300, Dmitry Baryshkov wrote:
> > On Thu, 10 Oct 2024 at 17:07, Johan Hovold <johan@kernel.org> wrote:
> 
> > > Yes, Chris's analysis of the ECANCELED issue suggests that this is not
> > > SoC specific.
> > 
> > "When the firmware implements the glink channel this way...", etc.
> > Yes, it doesn't sound like being SoC-specific, but we don't know which
> > SoC use this implementation.
> 
> So let's err on the safe side until we have more information and avoid
> having distros drop the user-space daemon until these known bugs exposed
> by the in-kernel pd-mapper have been fixed.

Then default n + revert X1E sounds like a better approach?

> 
> Johan

-- 
With best wishes
Dmitry

