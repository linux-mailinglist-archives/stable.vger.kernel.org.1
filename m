Return-Path: <stable+bounces-208251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14DD178A6
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 10:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 775D3300A6C3
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879A3387374;
	Tue, 13 Jan 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUPqI9/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52221389466
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295649; cv=none; b=psKT5N054WnrOuB5aioFboTnqgJtzOjiix+32ktCMqss+B+hHIckE5CfKihaZigXbBm3PNfnAcMrQZqLuBZyuPa+Gp1IDkADxXrW3Z9ziPc7bCoGmvHhyKD4l8VZMoolbupJ6ps2FS9hALcgQ9cVrnlxgwLF+12zU03TQ2JbZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295649; c=relaxed/simple;
	bh=4An26vrk+EGhP17aWX8TJcyqnb3x6gEpzXudj4ny8DM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sxnz5turuJzAGUZZuEHsoJsEVfNMux6NXTn1j2n0knpghtOsBGhqGPG8ZPZzmn2LI3N7dFQdCo3eXJTxuq3FvKpBCLueRJtpZHQHVFjKqVewfO7X5Wci1QHbKEndfh/bNnvpYlVjtsfo4+Yvqhi+DePe3Mg8XAKWpy8g+vLBOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUPqI9/4; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ed987d51aso4238025e9.2
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 01:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768295644; x=1768900444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t77eX7yaBvcCOvnjldeAucp/yf03hkwDiK7NZl34Ao=;
        b=vUPqI9/4kyD4iMRyCc3Pi5cbnB95TOx6Y5de3FVoVuhj1QZPqqHVnrMeqPX+SmRFxW
         VAMB5X0qWkXLnRyHZxELOpCTPv9yHJCNByRTjolAogRnJSqTkroCFJS14Buv+yZgJc6o
         Rvn8iPWe/nCZAjzNzAqulnDMb+tj/7+gCVcJCUIyoktX1wn0RsWU8wCGk6OCIK/s29kB
         nOJo/i8LAyZOqI267wDqpWBwKVEm0wV+za4loMVNKqCuJmHnyQLMNEDM8v0BK54iw8ZI
         XL7OPx03ZVb95dpwL4rvSHLBQ9GyX0gB1dD5XiNUUTNw8Gm6TwfM5CPRv+rQwxyeWTBO
         VIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768295644; x=1768900444;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6t77eX7yaBvcCOvnjldeAucp/yf03hkwDiK7NZl34Ao=;
        b=YlhJRQT3x8C3faMVIYWaVUyzTlvmqkAufkX9aN+NCcbn0kLDfRsCGeqiUc2diKaGFL
         k/EpEaJQ3SIl4hcmKejc9enKNlzREh2NG2MQEOcUtRrLXxxZnMPPfqoTKK6vsDAF8q3G
         YeUy17W2GNiRCSVTt+Gx7m8+tYC+kYUsRhTkl1weF2OB53hP5CX78P5llINdriK7wNnE
         AoC9y1j1KapqdOM7yCH60f7Ymt3yP47HY9ML4kNeyg3UplyH2SXo3MC2ywQLA0wrttRz
         dEtZbd3UMVclGa83yr+DzE5WII0vsNiKjWWww5+rDzTX77y27o5aqZcUMdo2zFjNREVV
         3jvQ==
X-Gm-Message-State: AOJu0YyHS9mnMcwm24s30J4BArY0jO6RsVl6Bd6xU3XXYd6gp0xNxiqJ
	MBeE8tTeeDtI9maE14x+44zVtldEPWtyTC15CA/ZrB/BQbPToOnBvybyuDGPFqs6Z6E=
X-Gm-Gg: AY/fxX6neKly0ZWuZucfNVMsaYf/QUdKrlzsiMfqD9sJ2U1hSWATb0I1USckC6qoG6R
	Dm5gBz1e0A4JnuAdtZeJcPC0EPMJWy5I8b9XP4JpzTR5L7cNFvoObsaX6dQAS4pwV74mzLz2ZG1
	X0iarPIeuPgYFZMrrdi9Rn9LZ6H5YVvwZi0DDWvyruWFgxwyPAZG2bBvyr61fTvW9pqyiupGzBK
	cE37qTfC4wC6D16nxzIlO9tM68cHFCU6iqinhyctcsx20Z8lSoAJzy8IebcJZRERjkPtGcnn4Mb
	n7dhe91VEpSf/fumfG7Paf9W0WT43zjXH1Gys2drBA3rEqYSDWElmwiqHgM5fVLFKobrMDPmjRO
	9a5BEFVrNKSKemU0cjPFfnI155cyKIsXmU9O2cuQTD45T6pHiMyWgdvRMLdENoBE/0fglP0WxIq
	9gamRMuFWWLRbkSYqN6uI=
X-Google-Smtp-Source: AGHT+IFdwglDB4crXEY7aXy9oh45LxhHLxaO2WfsMgiAukZiGDRTuNDlAiSJmqz3Kb/0VrBgLjUUog==
X-Received: by 2002:a05:600c:3b15:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-47d84b3472amr233883255e9.22.1768295643794;
        Tue, 13 Jan 2026 01:14:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080::17ad:35a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda0ee80bsm11389945e9.4.2026.01.13.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:14:03 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, Marek Vasut <marex@nabladev.com>
Cc: stable@vger.kernel.org, David Airlie <airlied@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, kernel@dh-electronics.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260110152750.73848-1-marex@nabladev.com>
References: <20260110152750.73848-1-marex@nabladev.com>
Subject: Re: [PATCH] drm/panel-simple: fix connector type for DataImage
 SCF0700C48GGU18 panel
Message-Id: <176829564314.3883041.15001190221335999378.b4-ty@linaro.org>
Date: Tue, 13 Jan 2026 10:14:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Sat, 10 Jan 2026 16:27:28 +0100, Marek Vasut wrote:
> The connector type for the DataImage SCF0700C48GGU18 panel is missing and
> devm_drm_panel_bridge_add() requires connector type to be set. This leads
> to a warning and a backtrace in the kernel log and panel does not work:
> "
> WARNING: CPU: 3 PID: 38 at drivers/gpu/drm/bridge/panel.c:379 devm_drm_of_get_bridge+0xac/0xb8
> "
> The warning is triggered by a check for valid connector type in
> devm_drm_panel_bridge_add(). If there is no valid connector type
> set for a panel, the warning is printed and panel is not added.
> Fill in the missing connector type to fix the warning and make
> the panel operational once again.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel-simple: fix connector type for DataImage SCF0700C48GGU18 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6ab3d4353bf75005eaa375677c9fed31148154d6

-- 
Neil


