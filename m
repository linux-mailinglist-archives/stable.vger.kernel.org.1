Return-Path: <stable+bounces-89742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294909BBD57
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92A21F22381
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B21CB9EB;
	Mon,  4 Nov 2024 18:35:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D11C728E
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745329; cv=none; b=F0Dzdqa1us0+4DTRQjsoTvPvAg5n6nymGELw3/mEWZIJsgG9rXPYG8Epqzo+JIhus0oC+dD+nKWbD05Rt2sJPfArp0pR+6uUzLyHsTCwYlK1NnE6dkBpn2mrISlGYnIccnpM3ERVDbXodEfcTGRwu4zsdiCPxM8zBl0JaX25stk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745329; c=relaxed/simple;
	bh=0q8JDwWzDntd/aeV9gPiXXtsjosur55lq2xvMgVntdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMvS+6Qc/THRVwqUPZ/4oQb9gHAsIWM0bblMdtKrAGRdz9k1CX6mMMU+MmTZJvVR7CyPSBsvkgs417S8+IZJt6JEoIKKyr9QTVkrjzlSLp8hojLv8PmVl+50uxkUgjWGwUGwpNnR7er+Uvopr66hfXO2tnzknK437sgkl5RYQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso3396924b3a.1
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 10:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730745327; x=1731350127;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5psdNGZt7yO/EGDxsF0O7Dn6TNWS1865Oba3g5L+Z4=;
        b=Qa+FiMBfaQOBBXEesEBMKupQlerjclF4IOuweBALl94Z/qtpkdoHqLTiibh42Q5Wsl
         bzhBRu7xmIQljc+kLkBrf4Lyp9lh+xmYmEfuvjQmri5dxwj028ErzDOAU2XwuAo08gjw
         jmSLHFlPhB5BImL7pLRrUjZuXaXi2h9nd4XI5Y6x2LWAriGHlJjB2XUVEkn5jkMKMtQN
         zvHpzCDA8JMQVEB03wSjTV3B+583O6lpN+1P4JdvBRWdlXlLtFm1+ACPKQqGnwQKdCPl
         k7AblYr8J1CAHvSHc/4bDaUDh2tHBt1GNiPlQ6Y1yL4Buf1DFdF299tl3rWWxcyUmOGN
         io1g==
X-Forwarded-Encrypted: i=1; AJvYcCXGLwWY8dDnmfpL1tex5mMzHwaZqeZWUoLGp1PH3kGCXJHAsJaCKH7KRmFoqXPSxkQUewR5YAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5u/6wPKXNndvcuqlunnz6QyDIwCS3xCqQCG15JDPIeza33565
	VNTNvw2CgnCzOJrqDK3L5yWzA6ap1FBCS+9cp6ueqPCM2fVDmxPNMeA51+nQSo8=
X-Google-Smtp-Source: AGHT+IFdG0hVRz4dPBfiFMJhFlY8swzM18DsMZV8IwIUprVfLFdN6Gv/FIxkJZSrzjoyHAC39n6arw==
X-Received: by 2002:a05:6a20:4389:b0:1d8:a3ab:720b with SMTP id adf61e73a8af0-1d9a83aeab7mr46788718637.9.1730745327258;
        Mon, 04 Nov 2024 10:35:27 -0800 (PST)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a0eae9sm7369576a12.84.2024.11.04.10.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:35:26 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhipeng.wang_1@nxp.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix using cpufreq-dt as module
In-Reply-To: <20241103210251.762050-1-andreas@kemnade.info>
References: <20241103210251.762050-1-andreas@kemnade.info>
Date: Mon, 04 Nov 2024 10:35:26 -0800
Message-ID: <7httcmonip.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> E.g. omap2plus_defconfig compiles cpufreq-dt as module. As there is no
> module alias nor a module_init(), cpufreq-dt-platdev will not be used and
> therefore on several omap platforms there is no cpufreq.
>
> Enforce builtin compile of cpufreq-dt-platdev to make it effective.
>
> Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

I'd much rather see this fixed to work as a module.  You already hinted
at the right way to do that, so please do that instead.

Kevin

