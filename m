Return-Path: <stable+bounces-132895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D43BA91236
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 06:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F055A2302
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 04:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9CF1D86ED;
	Thu, 17 Apr 2025 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWd9cHjI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABB1C460A
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744863907; cv=none; b=cjmVnqkLnR8qnx1TkfQe8jD8S1eftFnjy+YV4R7b5D5tzz8EiofAFEYxVia2LbmSfYxTX64XR6mLC3xcGXNW7gcgNnfDDvTbiStvAHpCwn/PlBDuAEDoildwWv6vaxbok2YcFy+IV+wADzbHvUaJQHdSn/P3BLmaxsqC7+kozG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744863907; c=relaxed/simple;
	bh=MlMsrIFgwNPUXQlQUeeWv3zwmDoBQ1Ow0x+5qtQ/UTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+Y1EDSQio5jUI9hzWU30uradnS4BS3zPKUcy5WtSoB3dJy9LBF1M3aL0NIbqCX8ZqVufYT0yDNxShMgOgS9/L67jKojjDcC7vK974RWCfiQK++mIXHdw7ZkrUISpMBZjeI8+S9ZN792jfIl4xa00P86HFKfp1gPtYWpqlEYiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cWd9cHjI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af51596da56so273429a12.0
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744863904; x=1745468704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmiUHUUBKI8PJIWV5sMJoVG3SND4wAcYpi9OlzawyYI=;
        b=cWd9cHjIVTvVSQg102VkIRw+6iNTK9k4thWf3OrpsHsGkb9K72QzzvVzMcNaB+NfyX
         O3+GLEAuLJW91+a8kV/PMc+WUYfxIOfx+Cy7hhRZ3JO18y5+alQ2SJBocZR9D8IWS97V
         qfjxdfAWUvA2WoXgAjRJl4ZlQV9gm6sKNzeHK1g+mM+PZbzxTeK6z41T6ItOkrdsnXbE
         lBCsCY4qR2LSjjuK27qoDLvtG2jB2cpWU1QYHjE3T+MtaHtdeA0OOiZwnqZl5pml86Hc
         CWaVuGOSbhEqpTb1JEIM9aq9wPFkW0h3oIgKF5q8TYkYHDFewkQTbCPn2VhKYLjE8Z1u
         tcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744863904; x=1745468704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmiUHUUBKI8PJIWV5sMJoVG3SND4wAcYpi9OlzawyYI=;
        b=unW1gLGK78Euhak8PTiR58djYXwGVdHjNha9axlPP8v4N4eoeWrT6PFd0LP5edts6F
         xJQ562viL8SuQmNrxSoyYG5+szaP6RH6P+HlQbCG1b4ccIbq2KpRuxkOUpfJS7/fbnlw
         OvP0HtpJUKyLNmA5X+2Uanb7h7sXqLjWvs6H49ho7mMqp6qOe5jpOGxw+U/80Rp9+82c
         w3/1nmLWaenNkhT3oEVfeNsZn2jSTb+0/CXc578f2PIQ1OFoViCvGxMHV7q7DM4iTHVE
         /N2n5/Z64nWlZ55YLAQ9knHbkFb29ickDhUp43osNxKfrK/91q0qm6YdS/wwYxO1c/0S
         NLPw==
X-Forwarded-Encrypted: i=1; AJvYcCW0rXxZZck7u1NqG9FAEJpiBJwn4cBVSQ4Oa/tBm3wo0fJk/kCn/rfp1B4kWJEXAosEN8DDJXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybfWalI6PubjfGuoFtbMBpAMuWPuBoCIOrmDVTSZfrCxKtOIz9
	lLzUAMCJqqITMPcvYiu9QEYp8eJqpNUJJqk2AUH7MqjCCCn6u3s4uTet3VBCc+XEDeFC+1iA7MB
	2
X-Gm-Gg: ASbGncuKintQ0hhYYyTHJyodWkn9ZMU7hqiCx0dNkSe1cHYjcSpPgFH0iMrON/NR2sj
	8Ickyilkh9dqx8lwtCs7sDFrUPVmy9duugzQGuOqPbeka89K1l+ODrhiLLiuLh/lugNhHltWQWk
	ocRTpx8k0yLIJSkFwNtwJyjOEA93LswcwxI+QPDHaCqOOzMIs6vRg4h72QSK7R7RilozRiHN4cz
	W4+1dLe/cTE5A/3D8oAKb+3KYhPmr6ey9YZoITtIl9c/lpocLp/Qb8L92AbtRV3lJLdsYexqTzo
	Euvc7T8XM9ewM0aYNESPOmjCzbzOzsru518n8F+WcA==
X-Google-Smtp-Source: AGHT+IG2v69nuDWH4FgYa76B5nKgqy58L4Wid65MFMUFPK5+zr5XnBZE9bRrkKyZECa0wTorHqTLjA==
X-Received: by 2002:a17:903:1cb:b0:224:721:ed9 with SMTP id d9443c01a7336-22c35981e16mr67570055ad.44.1744863903581;
        Wed, 16 Apr 2025 21:25:03 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2333859sm11288413b3a.158.2025.04.16.21.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 21:25:02 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:55:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix compile-test defaults
Message-ID: <20250417042500.tbuupp3jdpfkk7kh@vireshk-i7>
References: <20250416134331.7604-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416134331.7604-1-johan+linaro@kernel.org>

On 16-04-25, 15:43, Johan Hovold wrote:
> Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> enabled compile testing of most Arm CPUFreq drivers but left the
> existing default values unchanged so that many drivers are enabled by
> default whenever COMPILE_TEST is selected.
> 
> This specifically results in the S3C64XX CPUFreq driver being enabled
> and initialised during boot of non-S3C64XX platforms with the following
> error logged:
> 
> 	cpufreq: Unable to obtain ARMCLK: -2
> 
> Fix the default values for drivers that can be compile tested and that
> should be enabled by default when not compile testing.
> 
> Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> Cc: stable@vger.kernel.org	# 6.12
> Cc: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

I have already applied a similar patch:

https://lore.kernel.org/all/20250404124006.362723-1-krzysztof.kozlowski@linaro.org/

Can you rebase over that please ?

-- 
viresh

