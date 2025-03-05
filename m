Return-Path: <stable+bounces-121095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F47EA50B1E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D327A732E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D03253344;
	Wed,  5 Mar 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HK//WSce"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5921E5B91
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201783; cv=none; b=W1TSfUAlCcFe8PUXCJiRXXgxSZoNiaOJhtBVH5RGk+lD5p2yGegtiPekdp3Eo5vZXnCg0jNxZoas5gauAToiC0H1MDDslDEJlVejxkNkjAAMaVc7Wot5wI2vlc7TlNqarRuX4vdnaKymR8Zs02JVImGWwg+iiQjW6CZISwhqkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201783; c=relaxed/simple;
	bh=YXN8hyLuHQAhrc9NEQKCCoyB39SPARw+nLAxEXiu7nI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aQo48+wYoPpexEpoZoWDSMlAVOLhnRNAPnVsi83XKwm1exogAKZje5lNaU7so5W2A++CL+N29cqfcu3JkXlYeh/agyMH9r+iJkuFw3JuveA9HRt6BSUrYeope5AuTxYcUdPDUCvt5LGqyTzAtdH/oRMWvbhygk9VUvqawuk6BOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HK//WSce; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bca8cabc8so3338715e9.2
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 11:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741201779; x=1741806579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgIFZoxkbW0KwVO6zN97CfpiFd7piOBwwsm3LQac8GU=;
        b=HK//WSce+NmDOQYZFWgdWys+wby4qnHuMCS5n2Rjuhcya/4pyAFjzGvs5I7CHqcRgE
         CdjC8VZtrBOxUae7KZZencwDRWQP19KjHX/vZq3huCisginCQiNtENcOekHH07hNIqzJ
         LJ4zTJP7zNZq1zYgjGiL3GoqrMvxLH21LKzY49aX+GhTEesCBsuJZ8UrGDIskynoyNBh
         xJi9ViscitYAEmuX8oGV4TovYxzhZnDInwFQdkKQwDhOOVj9LkbaE8zuqY0sHHZLQSN/
         bNy5xVFVNi7KxJamVYw4htiZV8lyWq80236h7UAguTCICsfrDL3yrAlC5pUFMhz7yR0r
         2MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201779; x=1741806579;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgIFZoxkbW0KwVO6zN97CfpiFd7piOBwwsm3LQac8GU=;
        b=PXBPD2sG1U0917AXqf2FmIHtsFvdDS/3pJ/2imEmBY5jFCbUpqHe9urJVkUjcuYipc
         YGnMBts1ILBvhB8OvKPxXHrNJxpDbCcejNQ7ZTn1TWGUV0xKJhPtLG90TSDBPHEvshx0
         OGNeB1v92cEEEQqbdATLCWYc/74IUZm84tY1CCN8idZyfkC/kIqm8a/emO0U6NlgBq/x
         YJQ3K16zZLxMYccXkh0E/G4sKdnoIrD7zgUEqhkiDlPorzV7gMiQXjIko4tXLbLWopip
         G20+nG+E18HkDESzzM1NsX+rvECqA+77IzMs4wJvJBUt331Jlxd8QAeztWuJspAwZJWZ
         xH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVceRICQ1805jy9DbsAnw6tiYToW6tNMfM4Epr6OkB18thinf8NWpXFJ321oIGDQaW2HYMzAms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7UYLRE0jQHA6LaY/mUR3D9K4ViIRuftE9MGL5ruJIk/wT923I
	VHIvykuM5/9Ex6Mb5/yRaopjwvvQ4/nGMyOuHYaE3y+WS1FEUsVRQ2lWRzaYCaw=
X-Gm-Gg: ASbGnctBaMyz40zcILFw84uwEQ+7ThwhQNoIRIo+tN9uF8ngtUevM9DnNrOS/r3pLz5
	2K5wUhdMddWT8zGwGiuiZfWScrcyl3JobfrqaLBz2L18msqPGoteLqFN4b4YU6lMOehfApfKNLK
	N3JFjmAmZP8KK2wKdIy0VdnpoyyhTfrsXtMVgOmn6hgfu3UFRR/RJJsD+4q/wXmvV1u1Ni3RRDX
	36+Y57irNGPg7Pdblzbva5agAyqD/0lQD4MmK8he/i7gtacloCf5L0usk92nNIsnfk4qyI30jFg
	MZmwuPLRmoEMhdZYIkgnoaumPva1n0KSeVQ7XZ70DOtAnCh8ZC2zpmM6qejp
X-Google-Smtp-Source: AGHT+IFrSoo3gOE5FHktH87GAqLOOH8zzQprfwlqJYQydb/cjo2MTzmjtJwGHriaXSDaH9mOaM27Tg==
X-Received: by 2002:a05:600c:4750:b0:439:9b3f:2dd9 with SMTP id 5b1f17b1804b1-43bd29d8578mr15177295e9.7.1741201779287;
        Wed, 05 Mar 2025 11:09:39 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm25628705e9.31.2025.03.05.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:09:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20250303-clk-suspend-fix-v1-1-c2edaf66260f@linaro.org>
References: <20250303-clk-suspend-fix-v1-1-c2edaf66260f@linaro.org>
Subject: Re: [PATCH] clk: samsung: gs101: fix synchronous external abort in
 samsung_clk_save()
Message-Id: <174120177454.75135.6216013717633178470.b4-ty@linaro.org>
Date: Wed, 05 Mar 2025 20:09:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 03 Mar 2025 13:11:21 +0000, Peter Griffin wrote:
> EARLY_WAKEUP_SW_TRIG_*_SET and EARLY_WAKEUP_SW_TRIG_*_CLEAR
> registers are only writeable. Attempting to read these registers
> during samsung_clk_save() causes a synchronous external abort.
> 
> Remove these 8 registers from cmu_top_clk_regs[] array so that
> system suspend gets further.
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: gs101: fix synchronous external abort in samsung_clk_save()
      https://git.kernel.org/krzk/linux/c/f2052a4a62465c0037aef7ea7426bffdb3531e41

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


