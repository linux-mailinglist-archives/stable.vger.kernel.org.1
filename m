Return-Path: <stable+bounces-73602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B97CA96DA74
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B9CB2418D
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524819AD87;
	Thu,  5 Sep 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyxNjFgj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2E19993E
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543297; cv=none; b=ARRUD/qtFWldl2dAXViXG+gTJslcMqkVnVj1k+xXuyQUpKrqJjgk+xg0EqCFAjl/rIUK2RTOXzRY1D2k9T3XaXeTDaSKKO6J1qtTv87fspPswMT5NJQcEukgvgaJWoCURG5k3/fyRzQ8X54vNEvAs4C1kSgSsVU6EHBS6HKENH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543297; c=relaxed/simple;
	bh=T55wTvnsZWK7wKLe5Azg7ktcef5YrLYi9qJ1TyKnki8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpnOTWERxtWiTg8ihcwv28fxL3ZvrSbNFD5M4d0WnFNUAR0Vy2L5eCg4FxykdpZ5s8aQRajijA0gtv0/cIdpNBtN2FzzPBz0gMIMKhWTbo9uEI0sl9hrXrFI9HAQE8otLAXWCJfPpcM6KSOpDV8N7/YBM8R1o/SVoQGQJffH39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YyxNjFgj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso6284385e9.2
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725543294; x=1726148094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A55MoqOFsldxwQXlxzpGNFUwndW79rlievwxBfz+hvY=;
        b=YyxNjFgjY3aZUPzmVi4Rv4j7nk/zhRxsBMCRKzjuRRsnasWhr2MZlqGoncChzpuqXa
         VV/0cpp8TU47xN/86SLtleBauGiZQuwuQz2tK/4lD+5bptzliAduXnR/AFto9Rw2J/Hu
         IIsw1VtwDh+Ona59UAUIM9nGPiZkgMv8yn9+yghjP7jh5FZJzR+C1kAl2De5QZGMMH/4
         RGumw8N0gVPGe/lSF/gAvTHyb+gOPbKiXp2+PaX+09kFBMmfc+3KY1PvmAtjS47e58yO
         OgOQa5DvdNrjaKXF7spAm7NyOA4AGnGdqEwpNPNu5qVC9+CU/am2s3VeYln4t8sJQHuR
         cu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543294; x=1726148094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A55MoqOFsldxwQXlxzpGNFUwndW79rlievwxBfz+hvY=;
        b=WZjRKFBRw6O4Zr60ah7p53hWG8xPXKJCPGJu9jJz3VbkO9c6Y/zqdQhu7AyEjsrcNJ
         QYUFvg9ZtmAdx+a+yX9FqrDp6xbac5rhlxSIiTc8TPALjyrZJN7voxUIvTvrXpPEiOac
         rNF2a9w6yQpWi0V/Ka3c3ueQm9p3SwlwHkq6Lcy7+qpRBpYmYAUIUImxJuk+bDpuHOX0
         DshTThhFGkPC+qsRpq+hFRMmvG/LBlMmF6Z69YInlu1vzstvm4FktmZWTCvXraO+lgB9
         OTe6FY2aT8LfhKausDMTV9MZAnQGtiX6ZWZs2fpgtwPYXIijuZbtX+1iH5cK5awU4lnp
         0S4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8OTQFIlTQlqdpYflv8t+1KGgoGUr1W34osfSdSX3s5GYLvT2cdITf1V35wHDHecAkGoRTcbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WdyIYPcu+l9VBW5V/IH3R3eX1kNWKc5Kl4IfC5LiqF4hQiJw
	XpG+FrXszDtApV1wa363037PdHFqtu4N35DX8PJP6xQ5bmB67k9mD/XtU0lJPQ0=
X-Google-Smtp-Source: AGHT+IHlLHcFxIGMisRnkKc2CYZtGFT0jClDM/towcNZCE2ZiiV3MyJQRjAtcBerBGUGlmpJOrdV0A==
X-Received: by 2002:a05:600c:4687:b0:426:68dd:bc92 with SMTP id 5b1f17b1804b1-42c8de5f5demr58972415e9.5.1725543293907;
        Thu, 05 Sep 2024 06:34:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-376548acb59sm6788520f8f.58.2024.09.05.06.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:34:53 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:34:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Hillf Danton <hdanton@sina.com>,
	alsa-devel@alsa-project.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2 4.19.y] ALSA: usb-audio: Sanity checks for each pipe
 and EP types
Message-ID: <2adfa671-cb11-4463-8840-a175caf0d210@stanley.mountain>
References: <76c0ef6b-f4bf-41f7-ad36-55f5b4b3180a@stanley.mountain>
 <599b79d0-0c0f-425e-b2a2-1af9f81539b8@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599b79d0-0c0f-425e-b2a2-1af9f81539b8@stanley.mountain>

Sorry,

I completely messed these emails up.  It has Takashi Iwai and Hillf Danton's
names instead of mine in the From header.  It still has my email address, but
just the names are wrong.

Also I should have used a From header in the body of the email.

Also the threading is messed up.

Will try again tomorrow.

regards,
dan carpenter


