Return-Path: <stable+bounces-28230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F0387C89A
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 06:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDF21F228D5
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 05:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291EFFC18;
	Fri, 15 Mar 2024 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmkDciih"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4ED52F
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481828; cv=none; b=kaEkmnGQfBsg38qX45VGOE5T+DkLiOfiTLT0qP3bdwKyP8M2C02LT2l+PSULvf3JE6BNbm3b26/9hfZCmbg/AR+7Usj1Ifn3Vc7kk1Dq2P2ZHWpRdeEoOLDO2R4pzcksRy7feEJecxy5NNta0XwGDeY4V7FVmks+1y06pC4sZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481828; c=relaxed/simple;
	bh=Naq9CDfVLJcnya6EOl3vtZ0oDKB1UwOPAMZ9XUdYhW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASHOcINtOFf8089QSu8T6krxbgPZ5H+92TU5wl/bf04pG3elTzGJSeM/2cfS0SWPPpa5qgx3fnDcUWFOc1+n+LVwtM6v4XSrdtc6D5kjJQmt8keSMiQ9gZhQy5nh6+CXwtsV4Ig5nz8rbiCWeDUX9I5cBPdU5UlBxfF41JCESKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wmkDciih; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1275784a12.0
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710481827; x=1711086627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmeqZQFsfILznkSe1TDD/d0MuJKx0Lhu/2GiKczhwds=;
        b=wmkDciihrW5uRQUtYyPQUML0MbOxl3cE4UMXLoxK+4OjAURzdiICFc7eyjTehN6NbL
         Vn1aNfWoAnALHvCy26hWFDGZ7d+V1qx/i80w2WLhv8A5CIeuTngMHORKOrlVEdGshCD9
         rbPuKbpexGMMJB0/tEyCHsl+YwPHRyP7J+XA+LeSwSk2AXvLk3bqdIhjKpCDxYz2770E
         3CK65OGZdd+ekC/VqPfHBsA0y1mgwVgqA3/3pjuRhvityKjMRbmJxaouRd5My8mFGJ+P
         iZgBLL/tuxedrVUoTVf+FKTDdpoRqety1tapZ9hBOTOFF4778Fc60NIhcd3xUWS8TA54
         IhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481827; x=1711086627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmeqZQFsfILznkSe1TDD/d0MuJKx0Lhu/2GiKczhwds=;
        b=pvsYbJ4usoj5QOThp7HRRAYEnCO79P7yUZy5eRd+X1XVJ++S1c7YnbLxZppuZTjBU5
         YTpETCC2DlC/qrc0pgR4C5CKBwGvs2vg+ZO8XDDu1iV0VhEyVlC+fhxySy8H3NQQm0cb
         hg/ElDX6xvrNlg1adiwy+HarGezooEzRPQuNKoyBpfuXaLs1TbT1MQLdyRCUrIrLrxm1
         sBDW9Dq3Bg7dBGPTQv/zWEfW8MhbpNyQ3OqLbaftr/jc+KQzo14nHuB9pFgOy3Y7FHYm
         VOtnevfvQid7UnM3ma0u2IuQ7WrL/w488rMHs3Gn0Hlk4QLxo5CMLhw3dCyaA6UpzcXF
         ZQZA==
X-Forwarded-Encrypted: i=1; AJvYcCU1fwxloapan64xEuHFO68VT7YOG2XVWLcjAMq5DkiKErV7q6DK97gIgkWgbWAfGxBpo+7zPjmJMIM/yVDTPWc6roiVix2z
X-Gm-Message-State: AOJu0YxLc5oMCbBBDOO6YVUGDCFQpZN65ze1rar96jshyMvH7U2yutux
	8plHwfkrlPLVMmaQ1/qgM6lEipkXdGUS8/acVcKqeTmotwBgjv2anvw2KuFQg6k=
X-Google-Smtp-Source: AGHT+IGfYH1h68xEMnxaFPv1hFUKOr5YSQLITq8lOAM9Fw+k62f3AwJ0HdbWBTJZFkUgfCmfapPMfg==
X-Received: by 2002:a05:6a20:9d94:b0:1a3:2f5e:6126 with SMTP id mu20-20020a056a209d9400b001a32f5e6126mr4304199pzb.22.1710481826596;
        Thu, 14 Mar 2024 22:50:26 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id le13-20020a170902fb0d00b001dcc2951c02sm2823712plb.286.2024.03.14.22.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:50:26 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:20:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Christoph Lameter <cl@gentwo.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: always allocate zeroed cpumask
Message-ID: <20240315055024.bm7vvznq3nzhfsno@vireshk-i7>
References: <CGME20240314125628eucas1p161af377a50fd957f445397bc1404978b@eucas1p1.samsung.com>
 <20240314125457.186678-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314125457.186678-1-m.szyprowski@samsung.com>

On 14-03-24, 13:54, Marek Szyprowski wrote:
> Commit 0499a78369ad ("ARM64: Dynamically allocate cpumasks and increase
> supported CPUs to 512") changed the handling of cpumasks on ARM 64bit,
> what resulted in the strange issues and warnings during cpufreq-dt
> initialization on some big.LITTLE platforms.
> 
> This was caused by mixing OPPs between big and LITTLE cores, because
> OPP-sharing information between big and LITTLE cores is computed on
> cpumask, which in turn was not zeroed on allocation. Fix this by
> switching to zalloc_cpumask_var() call.
> 
> Fixes: dc279ac6e5b4 ("cpufreq: dt: Refactor initialization to handle probe deferral properly")
> CC: stable@vger.kernel.org # v5.10+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8bd6e5e8f121..2d83bbc65dd0 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -208,7 +208,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
>  		return -ENOMEM;
>  
>  	cpumask_set_cpu(cpu, priv->cpus);

Applied. Thanks.

-- 
viresh

