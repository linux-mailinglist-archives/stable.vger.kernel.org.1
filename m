Return-Path: <stable+bounces-83162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12651996196
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 09:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDE1B22752
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B9188903;
	Wed,  9 Oct 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXyux1GE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC281885A1
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460564; cv=none; b=i5AsQKYSzgbWhXtZPG1v9sXBtufYz8lixJoFVs+noaIJsXrcj0tQCBCnosHL+AJV61YxIpdBWOc0gJF029KDjg+mDf3RUhjN0hBmPh8ujetr8vm2wbv387HT8AoywjArERRBFuz59GaI6BvPbSC5jwn43dUzhxTaWcpJdn4QGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460564; c=relaxed/simple;
	bh=5bDrW9FeH7jow12z7JCCd0C3C11s2ZFK9uhE9mhsRg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KdBCO/rgQ0OxxRMdxQ1ek3AcZSWL6GKCTphFiEtns4R7nhEUDtPgQ1RXoGsmx8971joKGDlMJtWnN1Y9dkLsSHDDghq7sp5TJENd7OwjnYpTXjKW+QOuLaYtSNw/nKYMN526SbOqnbGCrO3re1FBJwAIl2bYmIUwz7Wi+za2ARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JXyux1GE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430558cddbeso3523875e9.1
        for <stable@vger.kernel.org>; Wed, 09 Oct 2024 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728460561; x=1729065361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y07+yBgcOroVjHiX9PPEthxZxo0GpR0R3sF3xpne55c=;
        b=JXyux1GE6TV7cTJNrIO8828F7lwEKI0oJ3LPmyitrwht8jXnWfrBLiUCaB1v73m2nK
         B+csatpmawL4fOiIVfiyl2vlAgvd7NzgMbV2tuaCZ8jdc738xViMBQgKKHR5XCcTlBns
         IYwkrXcDVYAnmwn+nRViHwD6wpkTeHbrZqAwCnVx9+DSAFizIX7/09/91mT+L4d2eZZU
         7TcKo+O8Rt8gMcXbqMlwfEBvJEsQKJxVoQJMroV5yxgSCR7GOCE8lYzD9Wo9pVw1K+lu
         O4o6DSr8LZsdVulvcQ/hGAa25FDMhDQ2S/79Lf8lC/AciLduVn8YHhwNypiciMPCgTxo
         46Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460561; x=1729065361;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y07+yBgcOroVjHiX9PPEthxZxo0GpR0R3sF3xpne55c=;
        b=S1CAjbG0HGVPLbXKmIDSUfmsGW5u6Gk3N6ZaEptgANGeoMoDOquAcm0FVcrsUeG1tT
         HFUEQVria66R1pjr4eGsPUHXdq1VWuU//SN8HKZeeSrVJ7hQni1mYotShiPYvcIlqKWy
         JMX6eNBdOyoEOVr9wIaB6OiyMxdBLisUrEeLuXD52Cw7EuLVb82Pt5Vm8I6o1E0Rdpoh
         +nVmNAFth9INZQ+90DRRiSRNiTH0jp987cUIcpDqucojelOcj7s4ugA8J4NWQrV8SaFX
         DNpeFhhvnVH1Swu2CZTK9fZkeR//XEdgRXmh82e/14hh8zlYLiFOMVDap9Da27H2P5L8
         z2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUsCso8bwLLTG7eNG7Gtoje5ra83YxX7wPJV3CK4CFlMTU3qe0MKon9949Ox6QnhorcTYAiPFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BC2opkkUIaq6lOdTmS9SeHPuYkJKHtvC7hv33U0JwwAyBJf2
	RdhoyHupd0l9Jw2wB1Ve5Tc7qEYADaq3lYqaXo9swEfrqwsAI+l2cN7lQfxdtQI=
X-Google-Smtp-Source: AGHT+IEUTMyWoKYDFs0XFyBJ4bnVk79FYy8jhwf/yzMlTPUezsEK/9UOX2RPBUTNm5wGJUbXCAro6w==
X-Received: by 2002:a05:600c:cc3:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-43069960b49mr10023845e9.4.1728460561547;
        Wed, 09 Oct 2024 00:56:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972fd9sm9660342f8f.104.2024.10.09.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:56:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@edgeble.ai>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240930170503.1324560-1-hugo@hugovil.com>
References: <20240930170503.1324560-1-hugo@hugovil.com>
Subject: Re: [PATCH] drm: panel: jd9365da-h3: Remove unused num_init_cmds
 structure member
Message-Id: <172846056007.3028267.12851544842489974284.b4-ty@linaro.org>
Date: Wed, 09 Oct 2024 09:56:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Mon, 30 Sep 2024 13:05:03 -0400, Hugo Villeneuve wrote:
> Now that the driver has been converted to use wrapped MIPI DCS functions,
> the num_init_cmds structure member is no longer needed, so remove it.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm: panel: jd9365da-h3: Remove unused num_init_cmds structure member
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/66ae275365be4f118abe2254a0ced1d913af93f2

-- 
Neil


