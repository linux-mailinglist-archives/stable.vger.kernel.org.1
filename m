Return-Path: <stable+bounces-89131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C199B3DD0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 23:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1565E1F22397
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 22:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4F1F9406;
	Mon, 28 Oct 2024 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFiWZcGp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4311F12E1;
	Mon, 28 Oct 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154880; cv=none; b=fCBSn9PEqGY53CGY/cNqG5+VoK/iAazVt6dK+fewGNTusFIVX5M7bIClsI4e1rOy/0aYr5+r2czmOX9Bx+0+1iyET/Yh3CWiLI4DHlqUHN7420PHT3Y1/oNo5ogbj6u2wJeM0Mo16qyub5ODaUDt6SMSRiz+HX3hiGR7S3VNfSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154880; c=relaxed/simple;
	bh=gKmGr/5ZnbM158J5N7jUh0J54APzNpxKlRD/E0i5/nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/Kd3BfuBoF600dmjuQ3YLA+p8GiUmFZC/Z3KIwoqbfzmgJvmp4T50aHMX7AI6l49gCZrcvCWS7CxNLTF+RXDPiRXv9vmge1uAubKjYnwNfz26vyFU6c8XJJLlsZmA6GzMq8/G7BSFTbK2210cuAFCiVnyTriEBkZKKwmYEXzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFiWZcGp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431ac30d379so11923165e9.1;
        Mon, 28 Oct 2024 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730154876; x=1730759676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3K5jfKAz+0lJ+9yVU83P5b7BV0bnKpsmzNSdRQX9b8=;
        b=hFiWZcGp9ArTLdPCCUYnxmLRaib/xbsFbIbh6sLiM27K2XMRxocYeuRMBYEdOlRWNP
         ywXefwYklsLhpMDRW2DJUUL04fhlHg0HeQtbvFybWC/SsSCxXatAV1ltps24ZfmAkm+2
         wMnyD95qbhLeZsHI3yCa3I0Di7rQujalYnazo98vH1taUA4uZRGWGWJpWwuZdSAZd5kf
         sxk3QWjqPsk5TRfjm+B6peoMG7YMaqnknQMhoIZX+q1Nn5oFVa0VBKH4Apc64stAYmi1
         bVlfzXbv+/YHw6v7fcu09MUos4JN60h8BqT70pBSZAWQCaE7VkHOA4W1+2K3IBdwq2qd
         tS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730154876; x=1730759676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3K5jfKAz+0lJ+9yVU83P5b7BV0bnKpsmzNSdRQX9b8=;
        b=TmtnezuYBKBJ5989kEogjWs6p+7XQIhcDRahPhX42qglpBk6y4dZOnnz17AudKmMmI
         hRB8R4XnF29Pmbjxe0aqdQ8lA5Mk+PISwJ/avPxCE8D6iOGREAD14Yn0SRWv8LjvCjeh
         WsoG0jn2iaH4v6RVquKYRp51Lad4A45lLyVXnpus4SU/1RTdtKKhcUUIxA1X4RvvFNDg
         O5bTh/C3NycqkkeAj3MsXkrU/pAOK2Ep4F1MMGuaht7Vo8GNg+wB/dWu2RvWeluKHDtB
         0iN7uaxr0VQza5gXgqSGtNZglJzSym0dQmh2THEgvS/hRs0mVVZpKjrJZyLFPLpBLSw1
         2Vzw==
X-Forwarded-Encrypted: i=1; AJvYcCVYg7EYJTxy9szONmu+9yP3Fv7YkOMWoGRZZoYbCO7edPDqT4/0yNNeAnhma1rA9JdayOar9KwRnvCO9lQ=@vger.kernel.org, AJvYcCWAQj6uRw+Ct6h1BlVXwMf1O5ucG+OM9o0JGjfVwKquekn95C7YQ89xs1c4aQcr/Cewej4eQJ7H@vger.kernel.org, AJvYcCWviXEBQTaCb3FBn8yxWsSX+UKbRIHvpCTi+nDBeG8ZrvCwIO//uZ0BqD43pxpa6UfWfS1Uob4SofLhNNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sHiX4CuCvLiXy8NDOORPaa9vvmJeFiPTMKwpvMBAPEuMDxAL
	4KDdrgcJYuCrhk1iF/RF1ZVdKklrfpbGyMD5EIisS8tdEh3qq39kUQTwlxtC
X-Google-Smtp-Source: AGHT+IEde5iw0He7F0LFyazRrBmm2/W/T0eRjGPmeLjtvDNEqAOpB5BmIqMtQsyL281eqhTV69MTow==
X-Received: by 2002:a05:600c:1390:b0:431:5d4f:73a3 with SMTP id 5b1f17b1804b1-4319acb226amr63557385e9.18.1730154875937;
        Mon, 28 Oct 2024 15:34:35 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f7213sm123899495e9.32.2024.10.28.15.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:34:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 23:33:59 +0100
Subject: [PATCH 2/2] phy: tegra: xusb: fix device node release in
 tegra210_xusb_padctl_probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-phy-tegra-xusb-tegra210-put_device-v1-2-28f74368c9ba@gmail.com>
References: <20241028-phy-tegra-xusb-tegra210-put_device-v1-0-28f74368c9ba@gmail.com>
In-Reply-To: <20241028-phy-tegra-xusb-tegra210-put_device-v1-0-28f74368c9ba@gmail.com>
To: JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-phy@lists.infradead.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730154870; l=944;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=gKmGr/5ZnbM158J5N7jUh0J54APzNpxKlRD/E0i5/nw=;
 b=KpcDPrw47pH11bD3BEXoFXs1mAg0X+fkMwnitv4El8oVws91tHTegbMBR8eatX78+ife0YUKS
 wYuBrsZ6YOlCVGkVRhAhsdX9BmDmUtpEHYFJGUsxyFE6FVqn5E5TqYm
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

A device_node acquired via of_parse_phandle() needs a call to
of_node_put() when the it is no longer required to decrement its
refcount and avoid leaking the resource.

Add the missing call to of_node_put() as soon as 'np' is no longer
required.

Cc: stable@vger.kernel.org
Fixes: 2d1021487273 ("phy: tegra: xusb: Add wake/sleepwalk for Tegra210")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 9c7fdd29b7c4..a77127d6c4fa 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -3164,6 +3164,7 @@ tegra210_xusb_padctl_probe(struct device *dev,
 	}
 
 	pdev = of_find_device_by_node(np);
+	of_node_put(np);
 	if (!pdev) {
 		dev_warn(dev, "PMC device is not available\n");
 		goto out;

-- 
2.43.0


