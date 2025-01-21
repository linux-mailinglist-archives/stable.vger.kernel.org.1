Return-Path: <stable+bounces-110069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670CEA1872F
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 22:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EE13A5B91
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4971F8AD2;
	Tue, 21 Jan 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dcavbgJ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE11F8671
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494100; cv=none; b=CCf6muAcuAnsPGNl1RA7j++NUuDKN8et+WWtlSOq6P6uidXrhBf0vRebFw+3Mu51g1D//osMRqM1HAzLT7sism7bn31fyHmwXPAoSM7W6uCuG9aAHtD9+byp+x4yXJKEpN5QcpvRewIFKSRIhyB6QRt76BtedcGXmMsT9SD9vuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494100; c=relaxed/simple;
	bh=zrzukfd2RSwrlmdRmszMLWOu2Hr/r69/z88bNUjZyEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqAa319gWIyIk/mOwIydyeRG23fBGbfAQGUj0NSBSkadEPkWW1y2LykNdWeXgMKr4wa5HzbZ1UeyW1B7q5XcNadII2Y4FevGl51+M3M4rd8/V4FD6FQLWxeODvR2RGIWAtIrLS9nIwWLUrAwcEzokM6qkR6O0778O3+cAqXj7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dcavbgJ/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd1962a75bso51913136d6.3
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737494098; x=1738098898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rVEk0Dr4duA7/mRQLTXbAYgAr33LOipnA2cEKQfgjg=;
        b=dcavbgJ/PlCBN+f2NFcb/sRWK/nA90h2sFl2NXgxHquL54tapS9LM6zbb7MPtbITjG
         SYRLne3FFGDhORp4OiGpNxfis3Xg4CSGHHnVbnsQc8254BJw0OOu6mo7x7NEVrMVagpv
         AIfkLmo8oSdiez2aFk7QgZ6oS2rxhG7/qdcyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737494098; x=1738098898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rVEk0Dr4duA7/mRQLTXbAYgAr33LOipnA2cEKQfgjg=;
        b=qamab1+AVBZ0fR7usmajBxPcnUfxxobnu9OrJyBSj15SIYPdVDp3tQoA0mN+EmNp4I
         XbzKztVxoz0BV6k79LXNmVR6joKpWK7Ng1f8H66+PH3Mne+/ZEjBMIycem0Oa6XnF7ZP
         hYF3fIDixDfJtClmbbdzl/CFGCoBw+x8U8j/VZZbmF5A6lCXku8552sLasNLI74bJDzL
         iWt2pqu/el02WtJrV/5ixR3Tkfu3OrrZEZS3TBASwo84Rt7om1fANtNhQZmS/jgjejD4
         qzuixbZWlPMaVYvJnvTdswGMy04o35ouhK5rzMEL5VjBZFWueAq9gOuHYn6mxbHeu8i1
         wRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvfnBdHJXad1Ie3wnId9T4SSB2WzDTZ0hYc2ey4lB86b8GMKscic4nnCvfstRhTsMknY4Ucy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojLtFoR1utrOFiTUR+yO99NKH1LGI/7XAGFfPIrJrTJyoB2ea
	P3vA9ikCQqdzWScwf3DSAeAFJRyTCz+/0R97sjFinCr2KhopP0phSInczKrB9A==
X-Gm-Gg: ASbGncs7Xd7vmCcx6pT3VuH0u8Qe2oYN6ShsiP9tYTnm0iQXjotrcmLri91qZRMcEKe
	EIWZqkPgkTV14UgL8nYFi7Zubb4dDgkuquFKU9oLd/hsKklyQ3gz8xjEBTN3n+2+XWwub8FYTad
	AThMSdyJV/ZQTihJ1GCBwoDazJYEQS4V4Zxe/hCzRITBIrZXu+GQ0iIsZlObqZdghd5Iq53QV2M
	FPJLc424KBX4jyWTpKKk8n8Fxy6E1rFTjWfcbYYSLLs5Foxup7xGASZ1gmBOb4Kwm4T38ahJ3fd
	9THSNPGOUoPg31u0LApm1uUx5TWhS5eDVZNDGXCotmiEfktxyg==
X-Google-Smtp-Source: AGHT+IH+AfjXa1HWP93h0DvJI7kSSGAfNsF6+75hu7mgbzlxXWv7+fIY3EtnqV1a4Imfwy4GAdj7Jg==
X-Received: by 2002:a05:6214:762:b0:6d8:7ed4:3364 with SMTP id 6a1803df08f44-6e1b2168b97mr263725776d6.3.1737494097728;
        Tue, 21 Jan 2025 13:14:57 -0800 (PST)
Received: from denia.c.googlers.com (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc28f84sm54790186d6.63.2025.01.21.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:14:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 21 Jan 2025 21:14:50 +0000
Subject: [PATCH 1/4] media: nuvoton: Fix reference handling of ece_pdev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-nuvoton-v1-1-1ea4f0cdbda2@chromium.org>
References: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
In-Reply-To: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
To: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

When we obtain a reference to of a platform_device, we need to release
it via put_device.

Found by cocci:
./platform/nuvoton/npcm-video.c:1677:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
./platform/nuvoton/npcm-video.c:1684:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
./platform/nuvoton/npcm-video.c:1690:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
./platform/nuvoton/npcm-video.c:1694:1-7: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.

Cc: stable@vger.kernel.org
Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/nuvoton/npcm-video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 024cd8ee1709..7b4c23dbe709 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1673,6 +1673,7 @@ static int npcm_video_ece_init(struct npcm_video *video)
 
 		regs = devm_platform_ioremap_resource(ece_pdev, 0);
 		if (IS_ERR(regs)) {
+			put_device(&ece_pdev->dev);
 			dev_err(dev, "Failed to parse ECE reg in DTS\n");
 			return PTR_ERR(regs);
 		}
@@ -1680,11 +1681,13 @@ static int npcm_video_ece_init(struct npcm_video *video)
 		video->ece.regmap = devm_regmap_init_mmio(dev, regs,
 							  &npcm_video_ece_regmap_cfg);
 		if (IS_ERR(video->ece.regmap)) {
+			put_device(&ece_pdev->dev);
 			dev_err(dev, "Failed to initialize ECE regmap\n");
 			return PTR_ERR(video->ece.regmap);
 		}
 
 		video->ece.reset = devm_reset_control_get(&ece_pdev->dev, NULL);
+		put_device(&ece_pdev->dev);
 		if (IS_ERR(video->ece.reset)) {
 			dev_err(dev, "Failed to get ECE reset control in DTS\n");
 			return PTR_ERR(video->ece.reset);

-- 
2.48.0.rc2.279.g1de40edade-goog


