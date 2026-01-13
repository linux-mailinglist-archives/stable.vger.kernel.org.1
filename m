Return-Path: <stable+bounces-208252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7616BD178DF
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 10:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B2EC3008F50
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92784389477;
	Tue, 13 Jan 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogWIFmdN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8843876C5
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295650; cv=none; b=upRHbGn/EHj8l15OxOerXvDHjq8iLotzyIPJ1dkjJWehzHQ4T5PWNgR33uy+/0SJpaVNeEpMvvuHlbm4GNqP45DRgfv9rnzl2PPNSnJFYnLv5qQW2qDEUvjJglghlgbg8/pqzlfK0oHVYrrwyPBvjlQMtuyAOhS3970E/x8IOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295650; c=relaxed/simple;
	bh=+jeU1sJh/xqI30ir+NSH1K2fZf8Fgxc+Mto2qLTLG2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dzJaLguUbTd9MNwpDoyh6KnUO7NhMM+zCra7YmldhRffJ5poDkcDqx6Rmw1xPfsBOlfis3CrmxWqs/vF5gyZhhKT2NGmimUT1j22l/1bRi7Co4jC+C0BIyAkbVxKiMxzodJKAdOuWfvaXbWPPdhe+HwaCWuC7XNC6ZN7yi2Yp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogWIFmdN; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso42133175e9.2
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 01:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768295645; x=1768900445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMDgVPdIGJYUf6y5Oggv+7udOHVtwJ863RSkn2wJe9M=;
        b=ogWIFmdNXE7cR+k6/9fGAYTe99T304Xo/ZwjtWzpXFI3n9r5td7t6fZAVk4KVXINLQ
         eWsmK7hBe/D5BVK6Z618ueppY5kvXpfLM+TqLY8+GPAVUzvKLMXmqpy29F0qjB3KBCZu
         EaD2pjrQYx7wy1Ete6i1WHe/5pC2duU4YtFc22ur7htcLwellxniHeBZu6i0IpSfJe9+
         ylE+1yfTOxHJo/fysktSEp9pHdEYf8BTar99YPC5q9Xz5JhnbJNDMUOtY0/O7lV3wO9f
         Tyvkx5tXyGn4V8RUmg5alWTYyryeTBhqqTvZE7iLUrXl0/HpkNm9DX0cDKY5G6KPjTmX
         p5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768295645; x=1768900445;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMDgVPdIGJYUf6y5Oggv+7udOHVtwJ863RSkn2wJe9M=;
        b=lMkjf/6JQwQoBeXAts2Q9MkHz7CfB4oIHx1+pZ3TvIBgd6TEXrRg/IYfuC6ErcGW2D
         gG0G97ikb/8ir9XTQ59IUOc+O3vsjyqy5gcX3SOgI56lCnZGDzsH0qxqOfd7Kp/aGqZw
         TnJbcZTvVLsjHOg2AHjIcslHDAPNsfuiQu2u5R7fVzb7Z0wkEC6zsGB3A5QM3gq752rO
         whmi4ryFDJAgN4xeiPCHal4FJEEvNtVTgI6gUfQfBMLrIJJ8hZqp+z7KA/pjZK5n2bDP
         HGdLFV2YfzJvZbNdaph3WOGBeaLl3OqvTI6vqsEoQdprJWBe0wymD3sclwjivxJRdfSx
         5FOw==
X-Forwarded-Encrypted: i=1; AJvYcCVp6FR2FnkwB5EjIUyAGZZxU2GF5e9Om9UIGXoV1Ab2MhBTWqmuCAvgrf4/L5KEDvb+S8QkcZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfqMOQ5wcVVDkKYUGwYqlCpq0NGeAno84ofdS+YcVRuG81/ER
	wXWClxAOlDvxngmvJG5PRyIbxAdyYFDhwx1/1ASKLU689oIaF5GFdYaFUFMwNCgHEtV4GAiwydO
	+34km
X-Gm-Gg: AY/fxX4MvRKJsTVxQb+QWG8pYJNOy8bKiolZAsp2V1vDDv4DH+OSsbZ5Z+UpETZmeUF
	3zndD/hLJlzG4lqfYv16Hr1RzxuHku1EGrm89vcpW++hyUng1iYnWxUarEaOyuDdkaiEHOZRPcz
	zVwjWyyusOJGJW9xyj4orRs9FynpWX6WbeOi3t2JEkbZgBKbbOMpFAKEhS8G4h2mwo3K9Cka2a3
	KrB86D/lYSfJkn1ZANapyqiV8ZZb5+tT9smJR1VEBl41gVmEO1gySnmyIi5CRtjyJIvTmv0o41Z
	36w/qpIwhbU5biBBAEF4a5qxhnlLNXazZTCr6oLWCHLcPhepdSGeUis2otfg3WruBW/UKJJ3/Z/
	pC5WAQpMcIhCfVEXidqkRuxXaOq1KgQOysIBTACEoCWvuxn+x+zwTTXpNhI/QNatKIZLc4UABPb
	+CuP8wuS56cPawVFvQzOzSmNptbSL6/w==
X-Google-Smtp-Source: AGHT+IEPcscQv2ri8mOfi12wdz6zyBY4BZVDA7abTN2YTuRZ3izGc0ELm8FGAzpFw+QVhENdmw6gyA==
X-Received: by 2002:a05:600c:1385:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-47d84b0a227mr236803025e9.4.1768295644684;
        Tue, 13 Jan 2026 01:14:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080::17ad:35a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda0ee80bsm11389945e9.4.2026.01.13.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:14:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251218-lcd_panel_connector_type_fix-v3-1-ddcea6d8d7ef@microchip.com>
References: <20251218-lcd_panel_connector_type_fix-v3-1-ddcea6d8d7ef@microchip.com>
Subject: Re: [PATCH REGRESSION v3] drm/panel: simple: restore
 connector_type fallback
Message-Id: <176829564393.3883041.15471923198292664331.b4-ty@linaro.org>
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

On Thu, 18 Dec 2025 14:34:43 +0100, Ludovic Desroches wrote:
> The switch from devm_kzalloc() + drm_panel_init() to
> devm_drm_panel_alloc() introduced a regression.
> 
> Several panel descriptors do not set connector_type. For those panels,
> panel_simple_probe() used to compute a connector type (currently DPI as a
> fallback) and pass that value to drm_panel_init(). After the conversion
> to devm_drm_panel_alloc(), the call unconditionally used
> desc->connector_type instead, ignoring the computed fallback and
> potentially passing DRM_MODE_CONNECTOR_Unknown, which
> drm_panel_bridge_add() does not allow.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: simple: restore connector_type fallback
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9380dc33cd6ae4a6857818fcefce31cf716f3fae

-- 
Neil


