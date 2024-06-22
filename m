Return-Path: <stable+bounces-54865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0976913316
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 12:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0021C213C2
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C5814D716;
	Sat, 22 Jun 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="il2DHusE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369E14AD0D
	for <stable@vger.kernel.org>; Sat, 22 Jun 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719053766; cv=none; b=DOGBG5AARZ5b4MH3ZfrigarCOQSdqMFay3BUoGIKoH2+258lVp6/srl5wcxUv/O6S8ZUnxDzCZXoBeaXTdiccMdsVSqltpwmrlbFLKJYufPqONtD8JIF5HiO7quF2qt/MOY9jkzaav9i2f+bQKtnzEieJAzIwRc/fU1TL7lkUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719053766; c=relaxed/simple;
	bh=1Y9HPEMcJ1iknaJTXV/+AMvmBjcveTDRVuINDy+1WDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pyNZUeIAdGy+c/puepphLIidTxpe+0omjqFoim3nE+GGXapcmBavnDTpj4i8z+2k0mHILfj3fnysljsGJVs8G+DH7vlGU2LpY3ggT+vtrBBaBHs1cfOlSMlDpMuZwdV+0CPTMTkCJGdT6MGvYRoD4omaYodOeSx0fgGQaKsSMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=il2DHusE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-362b32fbb3bso1950754f8f.2
        for <stable@vger.kernel.org>; Sat, 22 Jun 2024 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719053762; x=1719658562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzETEzkS1Fm2zJRno4hPag8+EngUbtNwZKOXH+RkQms=;
        b=il2DHusER/+bt3n31gb/fGh8ChcTzBq0d7vRbeoQRTh6U+yPGdBnW/lMXaDcoBhNyO
         Oo0dgipooj7iWPixMAIqWi41w1Clv0JnHB+pyXdIXF1wpHJ5DjdteISUetomZ+EzJw3W
         /H16Mubcx9GAu03lp9B9PyE/xlhdehSR5oMDyHEKkHCQe89V3qkOvuc5Mz9Aweduf9g1
         x7uoyBThOP2Pwe2b9WV/gXkTC1juWD3uX+z3STnnqge6wYLg2NOaVEK4xerRZnNyBAiX
         HkUgIUnWb4xvO0L2t+QmaZ7T3G/0UOd8swXBMK0wfagZU3wuEIx74wFUhRDOdfr/HyvH
         34nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719053762; x=1719658562;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzETEzkS1Fm2zJRno4hPag8+EngUbtNwZKOXH+RkQms=;
        b=nNw7H5IHgknZq+nRRx1mXQBHtvj4ZPEM2gEMj2U21Wqj9jqeOtZ7yJTtbKpkT7SA5I
         zF/2CxSyaL/IHcLCM3wQXY8Ws6tD5GbLXdiMAzsGAznfYh/iI3nGt4Z6tm+1/KFa7YG4
         oK981PJgSI1rN3RnbYti7XzIzLhhkqwwvB0QsCSNtdC9yGzhHXPKsAiQei/Hrii84fBE
         cuEn+dFU1wyvbagmmblhPWnHSHRTz5RbnoIpcF8jotwIzNJeWwQXKNkjNsJjrDw7dl5s
         h711yvT97FQ4QwQNn5MPZapZqisxoeb4ANtGoMj9IGYplvxSvcoiMeEp+A4+zIc821h3
         PCMg==
X-Forwarded-Encrypted: i=1; AJvYcCXyE6MzgHkdiQ+T7pw7BSD9J3ItcFwZ1J4GSZ4XvNP12nXbq5CF8E1EfMwRLu6MsQm9h/fOmSV+grYLaKcX13tTizFN4OIz
X-Gm-Message-State: AOJu0YxiM28mhgFEdf+wnsw7KsJ4tbh5o5qIdSILWdD6QvuIzckCgS2A
	TOaCzFkFVHiKtwSJl4h+/MtTfIPZGulmuIn+sIgRNGfkYoqpn6lAm4VChdXm6gQVwb++tiBz/N5
	D2Ys=
X-Google-Smtp-Source: AGHT+IHnwj2xpZgweRvve1ZfwhHIVzDJ4mKsbzab2gI+BouwZgRbYq1HCA8LZtyuc1svC3odngOtOg==
X-Received: by 2002:adf:db4c:0:b0:362:8e0a:337a with SMTP id ffacd0b85a97d-366e7a5692bmr183107f8f.53.1719053762291;
        Sat, 22 Jun 2024 03:56:02 -0700 (PDT)
Received: from [172.20.10.4] (82-132-215-235.dab.02.net. [82.132.215.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6ac2sm4205701f8f.76.2024.06.22.03.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 03:56:00 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Marco Felsch <m.felsch@pengutronix.de>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net>
References: <20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net>
Subject: Re: [PATCH] nvmem: core: limit cell sysfs permissions to main
 attribute ones
Message-Id: <171905375974.245384.16472026896696063319.b4-ty@linaro.org>
Date: Sat, 22 Jun 2024 11:55:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2


On Wed, 19 Jun 2024 20:09:00 +0200, Thomas Weißschuh wrote:
> The cell sysfs attribute should not provide more access to the nvmem
> data than the main attribute itself.
> For example if nvme_config::root_only was set, the cell attribute
> would still provide read access to everybody.
> 
> Mask out permissions not available on the main attribute.
> 
> [...]

Applied, thanks!

[1/1] nvmem: core: limit cell sysfs permissions to main attribute ones
      commit: 4eeb1d829b54d16ee5bbe9188e6013d424c6e859

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


