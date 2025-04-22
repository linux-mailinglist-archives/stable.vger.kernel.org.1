Return-Path: <stable+bounces-135051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF987A95FC5
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53ABE7A2A1C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7C1EB9F7;
	Tue, 22 Apr 2025 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VY9c+Gan"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF91EB5FE
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307893; cv=none; b=gT+mI7kzEEMzxtqIzjj/0yTAKyefhubSAayHI3BIEZEfiA2s9Xz9dAPBr3gHrFjjZmH5jCdIwYFC5Zhsbl2EzwBVPICmqfeVtSS9Zvj+LoJDtYfQe7dfq9Djz3eO4SADRx1mCcAAYakG/NDVTxX0ccEw+2K8lZkXJ8J6TNnG8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307893; c=relaxed/simple;
	bh=5yz43yL7k3tfBxAmtI0zYzcrPR23DOuFrXMUCxKyO3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D+e1rUhiipKu5zF/i+KcK+5YsmGt2C1yAZRdZvn/kluClcvJmrqYPQbG6Yt7ku4cbQLQqOyWElqAmV35XB8EL6PBxqKtOSme8tWwOwuQ9nKgY/lVbIGKf78mLeEiy+DKsAvL4lzqJXtNsIU4euSh2cQ6PdK5zTvQG2W69KErphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VY9c+Gan; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so48342965e9.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745307890; x=1745912690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgK3a7wLnoljW2o1N7kchVd14A0Rfs+vpaS3Ag30LgM=;
        b=VY9c+GanrN7+b5Z/ZQxof5vvHUydLVkNJ4LQcbJOjkABiRyBENElwLHHEcc31LLmOW
         24TTtl/mLXZ4FwqxKm0eAegOPQPQHl7fuSjOgq1OmLZFoiy5gMMg8Tte8FeCLofdzfJu
         byJ7iIfhvQEbsVYsrO0jnIvgDryWOD3uoqes2YtLiLqwXWMvvpW3ra8gtzvoyjrZNFvW
         +XQzLXeTPytjNH0Ulcr/buCvXasG3e4R31aEMvJJ03L+M+szbh9jNPxQZGFo8BrWbaQE
         +6K+7kooNJndU4vF13rRGzuDCx5RRuRmbfAQlx/+y/FZyb9gYk0UQHrPgjumuMDtaca8
         esxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745307890; x=1745912690;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgK3a7wLnoljW2o1N7kchVd14A0Rfs+vpaS3Ag30LgM=;
        b=vXv9p4FFBwg4oXVzpK8NFNNy67jf5o3rgz4dSnVtE1TcFzaERjXbTzvk028O7EXyE0
         ElKBsflBIBIoABOhdheA3KcDszCUBcdxT8iwGu/4+jCgoWb93LIsW4wGu7wXFbe92vlo
         meoa7wCAL9zbYa1uh3vvmRYdptPj8T76J8EgtZ5hK3eBSxo27Bt+GwolUFlXIku2SvDF
         3TyeuI4IFdDGTlIb456VdZuhJF01OqNgGjFSt++vkAL53Yid0AaqIXXaIg4/EgRTbrIq
         T8zOVLvkNBh47ZKd1uG2eLSi4jihl2rJNufAM2QVb8ffxT791k0Pcoklq8DgdYb45XBj
         i6aw==
X-Gm-Message-State: AOJu0Yy8bdqNGmp2Vww3TcCBPGotbPBRT6hb6viPxi8k/2o4UhNpXZ5y
	K/sy9pqz34IH2iuVHCG/MKClt9r/wZtWu/S92vBdNaWj3lRTg99g4f8XHP2h7LqkHQFx2r2TWWS
	N
X-Gm-Gg: ASbGncvPI8pJBLWPFc19QPU9wexjT2w8SIuvdBspd4WTvVbeHdR0TOcjPim4s8CpL7Z
	XRTnrizNWbi+leMJ1IMh/V6yPmy51CxdyyJmGUsgAtnqdiIE2b52riILFm49mppxRtWGEWoc6jR
	D/zaujXZ9tEp0S7fKv7FFb2iyS8RS81sR2QLbUazFIaZklvraPZ/pWxRo+vpdgzQv4lXOxusaL6
	JF4+lfRMSGVUEyAWfJ27+amqqGIArkM2EpHv5O6YgjgCSO4ZIZQywhBLffd0defReWoRXG/d/eu
	Kuz0qwWtMXvcIQxmC5kkvKlGmLAoJEqxDIFWNG+KMjYvYhNuZPvJ8J4AdAWcIg==
X-Google-Smtp-Source: AGHT+IGLlnDAxBOPlwHZaIDg6mBq4R6Kpd8YZK+9dm41VFGVOnrsjJ4xvgJsjjZwn8EYlnSwLGHSqg==
X-Received: by 2002:a05:600c:4708:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-4406ab97c6cmr118259525e9.12.1745307890356;
        Tue, 22 Apr 2025 00:44:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9e38sm166628775e9.2.2025.04.22.00.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 00:44:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@edgeble.ai>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Hugo Villeneuve <hugo@hugovil.com>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250417195507.778731-1-hugo@hugovil.com>
References: <20250417195507.778731-1-hugo@hugovil.com>
Subject: Re: [PATCH] drm: panel: jd9365da: fix reset signal polarity in
 unprepare
Message-Id: <174530788965.2868524.14547275141165599808.b4-ty@linaro.org>
Date: Tue, 22 Apr 2025 09:44:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Thu, 17 Apr 2025 15:55:06 -0400, Hugo Villeneuve wrote:
> commit a8972d5a49b4 ("drm: panel: jd9365da-h3: fix reset signal polarity")
> fixed reset signal polarity in jadard_dsi_probe() and jadard_prepare().
> 
> It was not done in jadard_unprepare() because of an incorrect assumption
> about reset line handling in power off mode. After looking into the
> datasheet, it now appears that before disabling regulators, the reset line
> is deasserted first, and if reset_before_power_off_vcioo is true, then the
> reset line is asserted.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm: panel: jd9365da: fix reset signal polarity in unprepare
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/095c8e61f4c71cd4630ee11a82e82cc341b38464

-- 
Neil


