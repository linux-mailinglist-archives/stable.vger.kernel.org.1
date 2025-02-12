Return-Path: <stable+bounces-115039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307DA322E5
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38683A1EEC
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D2D206F10;
	Wed, 12 Feb 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rJNs5C6o"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6388205AC8
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354042; cv=none; b=YVpq8Wv+ijL1pE3V5p3dP41+jHjngkN/uNdYDK4RqonzKn4o7xpm74UHd3w6ojseS8yw0mYy6H4QaDMOLz1NAa1OkP0WiyZbYbu4c95V8iD9Glb9omRDEPjk3KMKuVQ+94g/yQGqR24ywb9N5Fl+4fnai4djo47CbA0jddKR3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354042; c=relaxed/simple;
	bh=PZMdbK+5409eVJVCWqtfrQHw1QcFuT5g6apO0nOaPtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lC/Ho+CKRjHVHrG3E6vtwMPdig+xqagu9oUDB4tdryzuuCCgomxtwDQgVGZ8u+dIIx8ZG9qC56SEG0jhfq4YIksW4hfKHBLSJzd0G0IG2EYQ1q8vkU9Y/qPOlbxYABwb3+AXFqN/tOfz+yN6qyZObS85gvvl5BHJrk59M8ZjgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rJNs5C6o; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dcb33cba1so2661620f8f.2
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 01:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739354039; x=1739958839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIR7kxuCYlEHmDo3YVqs1C3HW9gsJqd1zOT7FkNeONI=;
        b=rJNs5C6o1myS/dabDPlyvOgRNVMkwHsc3AftOwVes5E68Oqlul7ykNq/gZNJkTRBZx
         Vx7SzN9uY4uSbn6ihsrFNgMDpzkKjH7HBv9qyaLSxfeaXfFcndkQ5MTy70IWc6hChzgV
         b2dTbhPcO7qoGWCbI9fWU23Lmt3U/5VThnSYqV3CwGiuAliDbIQni5/Fjn6lm7Xibn/C
         pSEJ+QGXP1uNk6tFBB7xWZf1ugfK5bK1H8aBaKIud6arS9XefFWZk0rkqPnnk6yzvS9Q
         t1XbsO4YA9AzjWQ40G7DNrNvIzBv2Sk7VHwUYk1Ys8M2rfECKiywBfjtEM5Pc1rDpAhI
         ND5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354039; x=1739958839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIR7kxuCYlEHmDo3YVqs1C3HW9gsJqd1zOT7FkNeONI=;
        b=aLU05W+69is92pyYk4h9/2WS27isnCZy/tqwaA+zMlDbLLbrttCRoHr1RS5aLAEPDo
         LoxfM22G4GsFIcmyicvYLbsjCFejB4ZYHHNGt/hyrO8X62tIPc5wroW3lvUfKcCmPYHe
         lg8+lfVxNxfSXBg4EU00LC8hPh2w2vCvVChJ2EK50Oc2hkaaH0pK37ZqtvbeFjAMZDN2
         Ih/a2XiOmmdpUlaXv5+SKBWKYZICiw9gZ5MTSIrpjWLGn3puMcgI4cCax1B7JFvDRfmk
         cRCTO3BXEEF0mNNT7q+zjekLvP7QI8Ok7vO7z9FHKX8TV0PeCi+r6YSN2HPFn3CzhiqN
         fSrg==
X-Forwarded-Encrypted: i=1; AJvYcCVo+/FPWGC9oErK+eCdzNQoHLTYfDAza7qS4rnTJpamsQYW1zwZwv4t0tBOYx8UPyFlOBrd4Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFy9Ih5Bgc5MlpBPYJs1Hfv2ojifymQep/OkyNabrEIlEflftL
	13znuW5aRHFpDFPqq5qz3UMCt/RhGxiu2FaJUeS81wRqOPY+crMKQY/pQ3cjpb4=
X-Gm-Gg: ASbGncsaguPrWXbE1NSrXHOX4icRJ0RofFUYgVaujpaLjy2f7fPVX2zCWjdU1ezqalJ
	LhRzsypjGqebqMVmfNI9ZGwOWMEuVfJcf+su/X1C508/ECWSKTw0tClYI6bRv/L2nlNX38WUqpT
	0I15wIkGh38mT0/KF6LiuKB1XjLl2Kz7GPYalku4yVeHc76aRy/NkyysJ2ZaVZDWuT3jwQsS5AU
	YnjZ05WwHqjVcORs4gfJeQ2MMmOey0JiRv/SFWeYudS0cRfe+txJplC/67ajvHyxu16UrfY3qDf
	FKRqLQ97AXBTpGE=
X-Google-Smtp-Source: AGHT+IE1AuIEYHupLeeT9Nxbe+qdld3vOkKKKz82MsP6O3GVbjl5NUVtbZU3jbI1vKhF91kVaT9XZA==
X-Received: by 2002:a5d:6908:0:b0:38d:db8b:f505 with SMTP id ffacd0b85a97d-38dea262832mr1371554f8f.17.1739354039252;
        Wed, 12 Feb 2025 01:53:59 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38ec2d9b299sm842935f8f.56.2025.02.12.01.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:53:58 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock
Date: Wed, 12 Feb 2025 10:53:57 +0100
Message-ID: <173935403447.13404.4893974637827879328.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212021849.275-1-vulab@iscas.ac.cn>
References: <20250212021849.275-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 12 Feb 2025 10:18:49 +0800, Wentao Liang wrote:
> The stmpe_reg_read function can fail, but its return value is not checked
> in stmpe_gpio_irq_sync_unlock. This can lead to silent failures and
> incorrect behavior if the hardware access fails.
> 
> This patch adds checks for the return value of stmpe_reg_read. If the
> function fails, an error message is logged and the function returns
> early to avoid further issues.
> 
> [...]

Applied, thanks!

[1/1] gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock
      commit: b9644fbfbcab13da7f8b37bef7c51e5b8407d031

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

