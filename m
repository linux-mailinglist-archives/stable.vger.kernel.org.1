Return-Path: <stable+bounces-132833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405EDA8B2F5
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 10:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0DD4433A0
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD60622F15C;
	Wed, 16 Apr 2025 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQTIoTgN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD31DB34E
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744790908; cv=none; b=DudrItH9IHFuQZadpRGMh1B3avFkm1b0F3H2uH1wEMb4jLxPpcR+9oRpHSyU6Yr8HqsZpiDh9fFNz4tv27GMrTA2U/1k3Rhy1qe5r8E4Mmr8FDMYpEkAiUTme/7kQDraScOi/CzTOlv8HmUE35gytbl40aXvNRT2N/sCdHkrmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744790908; c=relaxed/simple;
	bh=cISqzIV2rgmQuFECu6naEw6ahnHMaxpCS8NBxarpuTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI3a/DjG3Rt9EpcL8DigUju9ztvrLroq6LWB52IX5cdreCX8/xj4aJsK/c8mEALLZ5xops1ZWnTT9jW/YqodPDo/NnO1RZlI7ZPDfi65/md2ZZ41pikBqyAnzOJd8JpwFvYajIu5SbNZgMtpNnzWOJuGmq3UA7ipnH1qe0/3UWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tQTIoTgN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22435603572so61950715ad.1
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 01:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744790906; x=1745395706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmSfwQ+4oMYT6Kcqo2GkIzn25RS/V98reH2HMxWJJ1E=;
        b=tQTIoTgNqAXrldVnYkxogF62Z+ZlQyDqc2J0yfJ4ymfY0EKOxKgkWd5Ry7DLfvbBEj
         2Qvzkzc/SeNL82IPXzfPMNOdnJX+bKPJRaDCM8V6VJEN5Miw3hNYaHH2RkIVFNG5F1ct
         BLckGogd3SidOrpGdqs8bOuFTJMgkyUrbyCx2iEZoHQaLc8WFxuZBQxIpSjXAMXLWWO8
         Hf1uepXj5lFF6C78eh0NjPYu9wxZKWwTZEl5LtRxhwjnpNnls+8moRRBcaWpuwtG1Jkl
         K2hzK13e9RGBV7WfgnRW23jrTlcbRCBVMjRDDuWuv1JQOGcBsoVgP63V0UgF3LSLZuH5
         pq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744790906; x=1745395706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmSfwQ+4oMYT6Kcqo2GkIzn25RS/V98reH2HMxWJJ1E=;
        b=e1PTiG34Ox94ggczMm0rVK+lNSVSIYDc1+8e9bVRmBDHmqWAceCLT0uEeLE3WVjG5T
         8atoO1spQnlQe9sTmn+cGQaOrEMMaONhFrWvsx/7djCpFiPcUkWCGsr2w3t0yCw+OdnE
         VSs8s2Vn26ZQcgqJSeGIjzb8d4EBf2uN/Q3jg1GNmI4gKf5StfzGdANtIg0Z2jjxOa7H
         +jCduD2i/Kts7H+pS0Azl/P+lYTFB67xsnmUZzmKH5ZaFacD44Rnes9Rm/dx9Xn33spq
         aAhrE3thtqkbIECpxBmcNA/DgnKLeCD0N9nL7OVTfyQ/eHPP0lrNO29IUGgCkRMYBhN6
         QVuA==
X-Forwarded-Encrypted: i=1; AJvYcCW0b74zmKqFOFtdPo/g6sx7rHPPXqE8HPApthvU6F+PvmNN1SrC+DMm+fNR4HpYRigLyXR2dV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFSYiPgXGhWvtDUeZsHgvjuOQt8S8h4iEHgziuV8zgdBfGjNQ
	4nsiEGh9y2LhydNZAZAmbtgDdHvlKP16A/76iDf+6KqHGGTQlJ4Phb4phdenA4M=
X-Gm-Gg: ASbGncu++zLlI/V4jbR3CVjXVkooCRRwZ1ESfc6lBfk0UPhVtjYmoCvHKQFAsWbewix
	w9VKspy2Z5p0TEiSUfWdmG3wsbtyMYi2OOBDUY1Y4YYCUcwHoNZAStLu4wlqgH2LJsyhuw3EU7F
	DYD8muhiwsg3XiwCAvdVInTUxnaw9Uf9KGk3mrVXTlZkmgAi1oUsAIdiU/Fy26bLyWXfc4NYXJj
	SqDSJ3pRTKogMqhw5hXVd84K8UX8YDxnlXQ23wCOALib9l++gyKCVR7Xm4nHrg2xgO8z9uJzR0+
	wgzNmWlVxO4w/dWTM2mIeaO9dQL8qcWDqxi8oqbwBw==
X-Google-Smtp-Source: AGHT+IE6TlfbDAIcOi0+kKiF9dSLIx1avDG6iWMigbvyHt10Iqv0HYIjEVBLNqGX+RGWKXXryiaNag==
X-Received: by 2002:a17:902:f643:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-22c35964dc7mr16617625ad.32.1744790906135;
        Wed, 16 Apr 2025 01:08:26 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fa5f4dsm8011945ad.121.2025.04.16.01.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:08:25 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:38:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: cppc: Fix invalid return value in .get()
 callback
Message-ID: <20250416080823.o6urglwgm4qdx263@vireshk-i7>
References: <20250413101142.125173-1-maz@kernel.org>
 <23466140-5d0c-435f-8e73-d1c4826930ec@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23466140-5d0c-435f-8e73-d1c4826930ec@huawei.com>

On 14-04-25, 09:35, zhenglifeng (A) wrote:
> On 2025/4/13 18:11, Marc Zyngier wrote:
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index b3d74f9adcf0b..cb93f00bafdba 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -747,7 +747,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> >  	int ret;
> >  
> >  	if (!policy)
> > -		return -ENODEV;
> > +		return 0;
> >  
> >  	cpu_data = policy->driver_data;
> >  
> 
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Applied. Thanks.

-- 
viresh

