Return-Path: <stable+bounces-189751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E45C0A22D
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 04:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3903B12AC
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 03:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8A1FF1C4;
	Sun, 26 Oct 2025 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="EE0teduE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC81DE8BF
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761449042; cv=none; b=p1RUnlGJoNBp6CRN0K+2sKeXNMlxzhoDCuXw/9OSfQgejNtqP0heePJXgZ6MeCnLDog23cbm3/mfEAjBFCIvvEtLI0WzlKxnkLFuMmgbP5UV8mz+lN11ZnyXEK9A+eJlpWj+2dX7FyGPLAoYrML+Rv44zacf+BjUh9Hk78qNscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761449042; c=relaxed/simple;
	bh=bueBfTECE+wyjvffCJWaKFPOaYzuvYedLe0na1Ra2j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sbgx0TZ6CTo8CMAQyi/DbBfdc/IFtVwfLBBvt5zzNlkvbKfg80IQQ1y6UEV6YOSN6KC9/3zxEnNntKnZtU/sDp6z4aiJgqkCZxmXm/j2Ynfqb5oFcYkKOMHhaXFIPwHad0uDuZ/YNr/rXtD6JrzOlHWldbzDJv2/k6PWTXgrSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=EE0teduE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso4322043a91.0
        for <stable@vger.kernel.org>; Sat, 25 Oct 2025 20:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1761449040; x=1762053840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7im5kNRiOdk+Jyo+cdutLIE/HJaHEyQyI3+hJyiygc=;
        b=EE0teduEijq+jXYU3a1BA2t7s/btVQsnrLbsNlquDyE9WRAsN5WiWuyOwOvzu/66MW
         9URTv4EUh9Q1CqJDHT+uA3HSnfK3h2mppGnfudVxGpYN3okRwaQMb97NGreLVlXBB+VX
         tAj95wzztCKj2Mz9fBXRJfez3B6cEx/8VRMNm0otq6TrSy355w6p+77/Jksk36ymrnu+
         +FkxOZLXhBdkuGU3rKiUBRxbmc2ejEoUdTKp2zZwJQn5u9lK502OJOBnDtxpY4631fiO
         hFqiPGGag544pBDJkXmA8uAIWb5i0oMRh46DWqddbXZflJGljFxLy0jukhrcUvuV3A/B
         Ysgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761449040; x=1762053840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7im5kNRiOdk+Jyo+cdutLIE/HJaHEyQyI3+hJyiygc=;
        b=G75ioZUWMurVymxvIG52F19kUhhsYJIMZu/ntp3NbXPIbx3xgkOZgik59wPrMM9Psh
         kKuE1ae8KUUIEhrzRZjof+ifdQzI10oSaOCEIiqGGLdjOQjPDQD5NI1LKzhIn7pLnERK
         u324mnLCTbypCgNVxSn8LwwbjN8r/RdlKahWdfYAQjAuuCgztYk6X1S80unf/fHjVxnH
         HwVECSwt8XenleK+kNO66HFoNIoRQyFusnJef9Uwi3fnKGrDEGy8eSAAug+lhVUTMCxE
         Y0q5W0t4pUG0fD8Dy5+HTDygMjgptb8wFOyrMF5HFfjyOKnZqvm1efrxQ0JFSomiUaZK
         Ot/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNZABSJ91csS4K1Q46CogtcW6oWQ6kpigh/9HC8Wzf4O18Rk+rDpd1I2EZjbAJ2DV5OeZOH1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDh1jbkfQFnkhWY+T1fFEgyylOF9jmntYfNOyKNU/iuLkgh9w
	IArU6WQ0HCF9pFARUrdwIWSsrYC5e2ID+RfLUMcw8BIPkz4SZHQofzNx3bXkLqrXIH0=
X-Gm-Gg: ASbGncvBNOauI0Rm2TiOAMXOP7Esn4S7UYEWnX9EUxoZpjP8tt4hX6jFbStXTwKytzF
	QcBuqKpTFtkfwa/hr/AcmFfM5MprFyuUXQqJynOmYet4laQKFZxtjrAhjn5GQeKCxW3nPuUvIhs
	EsQoiAuK1lJJ9/p7K5Qo7zS835fz9Z2eQTa/LzowKaazoG35yBgq8hzDbFhtGB97KUgPlHkA0aP
	Nc66JrNBgxyxNk+z6TmyDoJWTeR5UN729mXaR69o/DAdxWV4w+enZrpVIi+GiT+zxTUt98pbWyO
	0yRJwUsjiuLiN1Jp7QQhp3+Kwz7l20WBY0BIELKPdaygM2HvxPPeoFzhWmLn83M7JyZPxcPx90O
	8oupEuhQiaEeN9j+/3JJ3i6l5O2dJlOk/Ohvxxh1DMvq/C2n1ImMUsBNEb5qkMlrKgK3vFX2znS
	Y86eWoZcUxcWJvS19qraiFUQopcKyCAKYIe3gJgVsieFuAOGyhe7rrl/3eDrO4ZsY=
X-Google-Smtp-Source: AGHT+IHq6wi7kD2Qrjii5aVezO6yzzAevLnvO8Q0TJGlZuunxWrS78THpTzzvJcj4iyYm6SADJp1Yg==
X-Received: by 2002:a17:90b:58b0:b0:33f:ebc2:644 with SMTP id 98e67ed59e1d1-33febc207abmr4170223a91.12.1761449040110;
        Sat, 25 Oct 2025 20:24:00 -0700 (PDT)
Received: from localhost ([60.227.210.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d7cdf28sm3342523a12.31.2025.10.25.20.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:23:59 -0700 (PDT)
Date: Sun, 26 Oct 2025 14:23:56 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, 
	stable@vger.kernel.org, Arien Judge <arien.judge@morsemicro.com>, 
	chunkeey@googlemail.com, pkshih@realtek.com, alexander.deucher@amd.com, 
	alexandre.f.demers@gmail.com, tglx@linutronix.de, namcao@linutronix.de, bhelgaas@google.com, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] wifi: mac80211: support parsing S1G
 TIM PVB
Message-ID: <ipjmlu4muicsgnm7kbkmp5pbcvjyjobne4zo4p4cjxv45la6cy@clmzwkjamyi7>
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-99-sashal@kernel.org>
 <72966d6ccecfcf51f741ca8243e446a0aaa9b5c1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72966d6ccecfcf51f741ca8243e446a0aaa9b5c1.camel@sipsolutions.net>

On Sat, Oct 25, 2025 at 08:36:04PM +0200, Johannes Berg wrote:
> On Sat, 2025-10-25 at 11:55 -0400, Sasha Levin wrote:
> > 
> > LLM Generated explanations, may be completely bogus:
> > 
> > YES
> > 
> > - Fixes a real functional gap for S1G (802.11ah):
> 
> I guess, but ... there's no real driver for this, only hwsim, so there
> isn't really all that much point.

This also only includes the decoding side.. so mac80211 would be able to
decode the S1G TIM but not encode it ? Additionally there's _many_ functional
gaps pre 6.17 so I agree that this probably isn't a good candidate.

lachlan

