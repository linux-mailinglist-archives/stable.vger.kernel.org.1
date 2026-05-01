Return-Path: <stable+bounces-242262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBFgMxJ/9GmXBwIAu9opvQ
	(envelope-from <stable+bounces-242262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:23:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7D4AB97B
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3414300C587
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7EA386C15;
	Fri,  1 May 2026 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHUzMw0v"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0623EA89
	for <stable@vger.kernel.org>; Fri,  1 May 2026 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630990; cv=none; b=L6aGv2YHetjijrRtln/FCaBUpcdLzdap192gYOLwDTsxvyvRnqVcyeR5JKJ0y+ICdBcaYu6yaHkxLE5Nl7WyO2akfoKuEL+1tDoyTlZ289BLgrDV3CAyb0YXna+CyWiEiS/ot4Uub7BGYx9EbAoKBjrHPQolS7BzCQIlyldJfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630990; c=relaxed/simple;
	bh=1zaI1eOQZkIMp2A/7WYxuml1I3ZODhqYihYDuIphYpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRamEKyb1KlOZz/+3gjwQC3J2UZk6ZH6nG58R/9Gev0ddNM1zhmMD+vvNCIRO7y3EEC6/R1hgZx72Qx6tdQmTwM+YNelQB62gfVnNAL95zdJy/mCQUUboHxenyNd/u4fgZMCt8QYkKj9fCv4jVf2LjM5oGRH1waLDj2jLYVQsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHUzMw0v; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so1430573f8f.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777630988; x=1778235788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zaI1eOQZkIMp2A/7WYxuml1I3ZODhqYihYDuIphYpE=;
        b=YHUzMw0vecRmjOyhvTytv0zpgcejN/n1jB9EHV+fds1Yyg1nQk2fVwmjFD/KFEc/T0
         2xJbCFkI7Jd8H91UtIzXHzd3GAYzaVJhs0fWLTG/m27wVsNLcmFHRIlcVYtjY/p6N5kg
         Q+ACexBrHSA1oB2E2i9l6T1uCpAzdnght7voTd8vtmgZDUb2OdAlDYKW5Izk6u90v2Sj
         Rm7evl9F7huI6TGrLz7Y9qfaYwQ8IlEJKWikKFU6Zl3iNRbjn0GEeztLyPxRaDuZ2sSw
         uFP0nwGFYBLo1Ai0OHVYqOKvQZ44TOnQXrYmxhrAKKSa2w54oD7m7o0hHnEUbQYK0YLo
         VH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777630988; x=1778235788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zaI1eOQZkIMp2A/7WYxuml1I3ZODhqYihYDuIphYpE=;
        b=jyh9Z9cD1I03iFPti5PPuP3mMEPH/bFshQry0Sy9cINgSoYBeRwXBxMdlEaSMDqTJM
         3HVGfWWiQA9B8cVHihwVO2XKGHO8Q/aF063FhFhNJ2YSeM/B73hHMeuuFPCRj1IWVAor
         Zc9ICBhymzkxGAnR//KEUpGfDcr13Ue7jQGwZL+KPdaDxGlVYDouVGGYD9f7gmoe5c1p
         lxJ/demsMrzuUzHnN7XyDdC0KjLqzQDK7QVKRd1fDEIg1A6sMMYL1wFKWkOIpmgmwgRa
         Uu1WbJMou3FAF1wF0wfmb4KpQ8Ro44UhZO5/KowKu8GkLKQvDeDZiEKeg9nOrYUEQgzV
         Sobw==
X-Forwarded-Encrypted: i=1; AFNElJ86wi6VsjZS6FTOrgT/Q4BX9WuXo/LNqHyh7IwfBqJ4ZZd7/Z0qMgl/2VKIiGko/uaHvYUm+9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXlUoIsePq6NrC+RcFE6cu0RpzUK3CxoCoi7dPZFiBRgzQiv/p
	ZpIIcA5KCa4N9FqVeqx3BMW17bZN7YYIz1xf26OH8EVmjL/EgMXgQyJl9+LdGXPNwVSKKthylvg
	wI7Isg4o=
X-Gm-Gg: AeBDietEzsglw0iAl0wRbPAYDKcX8B1sQqd1ueFcjlchJ0Xezu/gNCoKA7ICIImuJ5r
	hvoFVrV6LNzs57Lgulgj7HD6dRvD/diqptXLqtV3uCccgTVEe58B6dppIijbYbEWfhuXogz4K46
	mxvCn4cmPkD3RR7y+SXKzB/+rOrWz22jmbsKrDf8xH2Cn/VbW0EGJ3PWz/GpoTPDtfdBq33VnM+
	kchKuLWJ4j9yzRjuul+SVryhlswbcde3zo/X47j0Am8DOAtxUfps8x4g93Ywf6cLhsw/ZWl0xZi
	GAQNyrLTQjGxEcSlE1RsxKVfWrfcfTrbizNxV4vHCR9phPedOS08SeHiivNwGI1sGioMR0TeUdk
	xNW2fIcmqzuzX+cS2mYB7l8B5GfZHaorKummLdGdcJBpcPaVNmqQAARw3vBKiV/8yAI5N1UGZel
	NpJLSotxRtl33XVEP4wgHYnv2FUTzzdEMQX1crGMiyVqo=
X-Received: by 2002:adf:f001:0:b0:44a:8880:ffd2 with SMTP id ffacd0b85a97d-44a88810005mr2603191f8f.4.1777630987660;
        Fri, 01 May 2026 03:23:07 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44b63d78692sm60672f8f.27.2026.05.01.03.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 03:23:07 -0700 (PDT)
Message-ID: <380547be-8eda-4395-b13c-b6cb6804ec5b@linaro.org>
Date: Fri, 1 May 2026 13:23:04 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] firmware: samsung: acpm: Various fixes for sashiko
 bug reports
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 stable@vger.kernel.org
References: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 81B7D4AB97B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242262-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:mid]


FYI, sashiko identified few improvements for the current set.
I'm preparing v4.

Thanks!
ta

