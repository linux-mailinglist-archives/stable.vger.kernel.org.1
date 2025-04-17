Return-Path: <stable+bounces-132926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789EA91619
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E78179E69
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A2422D7BE;
	Thu, 17 Apr 2025 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6GoVa5G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5A2288C6
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877223; cv=none; b=uWTjiAefkyzNVNcz+e7UfayNkJe7oobVCSU0tTQ/QbTiZ8WcAmTIXj/mnCIBzBpSfNu2Y9d6UI+h36ZXK2ovf0MDH/WGWvjWfee0dOWSkzhNYXFiS18NK5hCyt+OXt0crebf0fB2pxyKsOHbPvJZ/sKGyKmw79t4bnk8gGzS5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877223; c=relaxed/simple;
	bh=oQW7F29atGBld5YpHbUvVkkrHeYES/dxTGRbEkLyYvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6wwtFCQW+HNSOE6a3X8CA6T4uM0Tt9JpHcAt3bkk2M3GUOAGxHjh0/IX25wvOJj7571nyOyaK3PpSuLum34u1iJNgLj3wQT7sBiNDi+dx6ItIE8hwnmTj06dASgW2ZFkbhWr0Vc1MdTydp3FIOtd00y1HOUtHKUFdsGROWWmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N6GoVa5G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso7507815ad.2
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744877221; x=1745482021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbStn/1mMmnWgEwNfLXRh0m0K6lLNoUi7YPIyXHV8Io=;
        b=N6GoVa5GgRHtKOg+65A/d16DuSfFzCPhjYU+xEzMy6acQfPrIJ/pxlJf6rCCITZKnL
         NgFaajcOk9FVWDA9JWQ9fhB7Eq4ZNVJ4qKREa3gq0tKsgKyXE5lO39NgatufJJxfgEIN
         xfykB7SC1pE4aQ73x+UkuBjVERaqTPXxvTTGCDjysMqRLUtEIHSfTnyzSqgiydtYJ3W0
         +5/Rajn4N2VMHRYfqB1nZ1rUcgI90l9DEtLLgrdhRqQ4w9zbPpe9Ao+GEwtk0luRlPY5
         aeMchopLh6ZRub2EWdJRqhSFviYy9AIyWL1YjAUVKlohMOsPtL3bSZ6OCeeyVh4Uux3A
         +klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744877221; x=1745482021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbStn/1mMmnWgEwNfLXRh0m0K6lLNoUi7YPIyXHV8Io=;
        b=RdCQoprt9Ziy92IP/m1LNcWV3wDPs1fmP3eP+mHwQHMkvU2TdFLq1Z2B3aZtzOj0Fp
         OW37ybo06431clNmLCzImN/IWDWIpMxUszFIFJB3MbQOUhJWT/qiOnNcbwGE99VOlMrN
         Mmh3LB2DpoDJVHpI67jZXEBikA5d4N8axfylxEJ1r+MzOtbFplt8u8abnIBWZayvo/SK
         ZTL15ANFRRYF0Hnl9ztWHLW2LAuecqpNMrFycOS57GwrnwNGb+YpAR0iuhZNc4uEfqnU
         VKlP9sgVb03UfTzSQB2iquLP+U9MUlK7y8mUYtnEgngp3V+ro8wh3rvUblfGHnM/R9bX
         85Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXGkNSOazlg8BlbLY1qV3hoJujRedpi8qe2j2gn10MWj5NfJcgOkSrx3mQWfOapfeMnRJDdTek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1eugNdQ8oq/CnaRGGeivUUkdDREsjYgPt92WKXaGzianMYJ/m
	3i9Lv27IfEuHvYENIy9em0jrAEdry0lMyWJzGiXp4Nnzu8mEeukeqi7JmUd0FBE=
X-Gm-Gg: ASbGncsJDsZ1tvUyj9u1vaJAhLOifwQrGFIg12cG398DxTDqni30SwWcWtCQAGZVEyT
	LjS8LwQ/BUhn+ii+aS8EQXmbrgWCpoH1XoHPQw89Ty7rq9Q6azjqifI7EnhLW4WXYvNpP8CWzU5
	ypnd7r6OzynXnciEcA/JeJWGbr7ABPgiQbryrbeNE1F7gqZkVWN81rzlL2uVo1FsfLxECzUioBk
	LM1e6crTSyKtKlXckwiN6w9Arb8zsLjdX748N0G5qA0qv2VUwqcspmkBryszf6eorbmdH9ImDyJ
	wgqrGmKCGjgO3SmBlGABjGQTPnea8QKzMp9sGT7Sdw==
X-Google-Smtp-Source: AGHT+IF8kAlRnm7dgvBGiP4dp8lCId2BiMHsLBv02PsMCD5r3qOQ9HE9u6StR0v7aFBT90CEbczcwQ==
X-Received: by 2002:a17:903:41c5:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22c35916c6fmr82576225ad.28.1744877221505;
        Thu, 17 Apr 2025 01:07:01 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11a6sm27376855ad.23.2025.04.17.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 01:07:01 -0700 (PDT)
Date: Thu, 17 Apr 2025 13:36:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: fix compile-test defaults
Message-ID: <20250417080658.dccdn6luc5ss7dgt@vireshk-i7>
References: <20250417072838.734-1-johan+linaro@kernel.org>
 <f151f848-d337-4bf3-b88d-8a032e843ae1@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f151f848-d337-4bf3-b88d-8a032e843ae1@linaro.org>

On 17-04-25, 09:56, Krzysztof Kozlowski wrote:
> On 17/04/2025 09:28, Johan Hovold wrote:
> > Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> > enabled compile testing of most Arm CPUFreq drivers but left the
> > existing default values unchanged so that many drivers are enabled by
> > default whenever COMPILE_TEST is selected.
> > 
> > This specifically results in the S3C64XX CPUFreq driver being enabled
> > and initialised during boot of non-S3C64XX platforms with the following
> > error logged:
> > 
> > 	cpufreq: Unable to obtain ARMCLK: -2
> > 
> > Commit d4f610a9bafd ("cpufreq: Do not enable by default during compile
> > testing") recently fixed most of the default values, but two entries
> > were missed and two could use a more specific default condition.
> > 
> > Fix the default values for drivers that can be compile tested and that
> > should be enabled by default when not compile testing.
> > 
> > Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> 
> I would not consider original code a bug, but a feature, however I am
> fine with other choice as well, so to close discussion from my side:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied. Thanks.

-- 
viresh

