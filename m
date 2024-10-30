Return-Path: <stable+bounces-89287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFA99B5A3D
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 04:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D398284942
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 03:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644751991B4;
	Wed, 30 Oct 2024 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S38ja08N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6518B09
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258221; cv=none; b=l9v3QbwkJ/4/4CI/Pz041gK59dBSaYyaytlLCCxhq2PehI2bf/lgvp5hAuHXVH40BGjs4LMFXpbP22Ikk+qJPihx06WdcxGSYHIKz5uH8s1vulj6tPUT4GOUHXKR5fLSiYRjRtSf2iGrqDiQYRZyWOY2RWVr8J9hnzsyubSZjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258221; c=relaxed/simple;
	bh=PBsAKVJ6B9+yamO/DhmcmMqn2Z2bULm0iLY0gTnNrLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZS1AQ5Z+h2zNGd0CPpUTs1ba7IAq9AmuUFAi/Gxe6w4uM3EMRnKo4TRQja7ihcbJxVx3hqp6PG5rbCtcaBJFe2Xrr5FS9H7FhGw47xbqdTEZKSxHvUuxnx/fWLvW8U2sUfpCmxprpHxyywwE+PPCK2QjF9n6fBJR+3SMyE+LUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S38ja08N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso4767931a91.3
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730258217; x=1730863017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOkAHQrRWR68mUWgK22Q1GiCQ9kh+zI0wkYMgC8eCUQ=;
        b=S38ja08N+0W/g3FoJW9jruC/5aanjJGvzxnGYCQj4RXMlBTbh3U7pXxh70uGdhS8vQ
         oh9670eo3QNcOZR4QH3i6MSCp2I81QsJBXTSjeCoGjb+54d9hzRlEnT4mSt4CmKNQi0T
         wMO0sWvJkvm3mN5MlSKRdVr0vMu2vyzlBeECom5oO8HPSCtYcFdroye2DCK9eKkX0Yrv
         k4HujrcUdh5PNS8NViE3x2N6fFdWXTd4z0Zk6SBHcB6qip3yqcLZdCVRdN8u4u6rljTw
         QuKIx/Ki7wTBCvHPuPoKfetNHb063rKpqGjnqTHSIh4jJe0qhMd1wmzial4MuGL4vdvM
         qowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730258217; x=1730863017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOkAHQrRWR68mUWgK22Q1GiCQ9kh+zI0wkYMgC8eCUQ=;
        b=iiEOnLCm5vFVoH76Tb0BUSnrK0LND1o8K2sxX+ulh8kViQiE98fT/Yjqi1GRNcBKgb
         DOc5MgduOCIQrX2zgpXmDakJk8sixHoTmDKsi4hVfzI1GFoVEjR1K025bjwO1gJGi85a
         OgsHngsMAEwgat+38Lie5+QpMDra+mol9lGraq3Rd28LpiuoTVfY28T7XA0tzsGmMRFX
         qtCi3ofZteAVjK4XmQKHb9fwsaZeC2hsY9otaKGiChsYOG4dWLxWTX/r3RW/43cC2p+d
         eSe98pYF5BnznVfy31QD6pWzBIEvyPg1UDPvcNBAgcYu20hbUzueBTc0Q8M3LvkeRkHS
         xtrw==
X-Forwarded-Encrypted: i=1; AJvYcCWjrbofYbL81pIkNG6KJKP8PW/41pKRLvCjenQAzgtYakTRKW3HSO7QqGHA0Z7xADEURy0Ry0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKZ0/X/Xnj5W1uyil4klg6QOU1sJT08xqT57OOCMBm7I/+zWL
	0lgsPVK2yZtosO/l0vDZjo+2yQAZJWlyLZ1tKhTJGWpZuXXucnu65fjuCgIFGbo=
X-Google-Smtp-Source: AGHT+IHCWZPqicu+zBEO5ISCpJXDjDagWTSuQ1d4uht5fImHKQzKKPSKGEOWL+8DYHlMq7FTvt4Kxg==
X-Received: by 2002:a17:90b:50e:b0:2e2:e6bf:cd64 with SMTP id 98e67ed59e1d1-2e8f104a4d1mr15472363a91.5.1730258217352;
        Tue, 29 Oct 2024 20:16:57 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013378sm72539135ad.171.2024.10.29.20.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 20:16:56 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:46:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Markus Mayer <mmayer@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial
 command check"
Message-ID: <20241030031654.yfksespjetnirecb@vireshk-i7>
References: <20241029152227.3037833-1-colin.i.king@gmail.com>
 <51b6692c-4e71-4f4e-ac73-fc87b9f2ac5b@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b6692c-4e71-4f4e-ac73-fc87b9f2ac5b@broadcom.com>

On 29-10-24, 10:06, Florian Fainelli wrote:
> On 10/29/24 08:22, Colin Ian King wrote:
> > Currently the condition ((rc != -ENOTSUPP) || (rc != -EINVAL)) is always
> > true because rc cannot be equal to two different values at the same time,
> > so it must be not equal to at least one of them. Fix the original commit
> > that introduced the issue.
> > 
> > This reverts commit 22a26cc6a51ef73dcfeb64c50513903f6b2d53d8.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied. Thanks.

-- 
viresh

