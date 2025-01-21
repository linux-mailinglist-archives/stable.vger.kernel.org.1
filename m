Return-Path: <stable+bounces-110070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E126FA18723
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 22:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CC3161D25
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D11F91E9;
	Tue, 21 Jan 2025 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ub7PetYP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB581F8911
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494101; cv=none; b=p86kj+PEgPdShiDeWS9PHh2Bn1dvbIvpeKbYbAx7dxQfcGk3WhnK+m8+wWXazfHZfSChSUx/LMHwSgwUsLOzt5fiKztO/6JYcSL76n5Fcz7AMVlmb19Ub/kNAC8sM7Hn7Ug2AzXLcUo+J48lVM2txEEnE28GFYzM4KMVhX5y410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494101; c=relaxed/simple;
	bh=LyRuB8tAdiqBEUlnUkNNhNkm4Ba24Qlh5k9HJRNz30o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hM1Ji7yW9cYxW/PhFgB53szvYuWCt35rxdyCyBTvpHYwHYGW73GRCsWdWkAK4BQYTp6NW23sIlITqRn3NSIpgbxJlggnFEzjvYvU4pxue7CQxbEhaixqjxmu+FRPPbfDmhJ6UccX6i9pcMDtr8myK52YSGGK4df6LuCI61NdN1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ub7PetYP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6e5c74cb7so505819385a.2
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737494099; x=1738098899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKIWMYbFrbAqwI1LUECt3RJuovYReI3o7uvAyeGPPzQ=;
        b=Ub7PetYPHpvycfl+SO+DvKyHOl0tdhn9hxO1Gxu7M6iyxsFZ/bkUlnX6hzCmsWk+XR
         JJZ71a+wCQf2kXyHsuukXsvUiCPZ6U6zkXwhgmNpKIx0BqVx3Oazl9GQfrJ26LieXxTY
         QxjrBS5hl0XWsSvlN1mTt2T+F9hBq/fgN8M6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737494099; x=1738098899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKIWMYbFrbAqwI1LUECt3RJuovYReI3o7uvAyeGPPzQ=;
        b=iGh5Bei6MkFqGVo+mJQwrTdX4jmWU0ML037CnyKedD6UB7g/pzTOPRNO8hQprWmz0n
         H3dMknrre3BUYCF6pBDgaejZZaYnuSZXLqsshx4le+sT13CmFtm074mLZoKjgYgval9s
         Ek8ZK4RiAG9xUt83owvbNETeFpKi+uYn88Vx7c5nJYPbbgUdORE8c7SXCRL2CRMnhxn5
         k/ZZ9C8fKoCpqsCKLhhNZCaycKUs+lkyzXB7gMeiu399pcV3s0Um1w1YwtjI+MUXeOSY
         whLzCBcL+lC/Fb0b3/RGKyUrNik846nSSKxvDizvW057kgIby/VodMjkfPqcZAbmoH7O
         d1ag==
X-Forwarded-Encrypted: i=1; AJvYcCW6CSKXf3Kw8iOypzd4tLUbEe4Zha5XlYZv73cqTRErQrm2zD17/xacIem6g32nEQySL4nRfnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5hJmH9BwghgTtDcrSzt2t0zvUIxmt1jYMFRBeybP5Lferizj
	YE/8abl3+iGZrUm0L9E0Ae6l6ytclA18xFAHNLohV7NShEFtzTUOamA+pU167w==
X-Gm-Gg: ASbGncupTO5qGdOPRH+5kV6oknYL5+tDetTVjH+6rjG1wXZwbUVjVX/AkmBZbhAY3mO
	WcP3WfEEWJARdUokoJ0SM+UaQHtCFKA8AISwCiDKAcfnoYAq7qTvSk9uOO7V9MTW0O2y5m+sNaT
	FmKF8zs2i/TPVzYlEkn4QgmLBeZufYAHj19AaAFjEdxr29RN3IIZfb3KXnKwWslVh+p45SnSP/P
	WXOww+4KImvf2hJU2naoOriZ2tKY5Ck2mJG8G58lOWFsw15T2/hn7MxvzI8mqG4D8Ved3X2zZ2t
	2XH5Biedel7cQyJAYmSsdZHKykpd3eRaRqz0Ba6ywN/Wmzxg2w==
X-Google-Smtp-Source: AGHT+IGahO5uMTq52/oBAxLhuuA75vO0AMXdFYbDv0vle1LutgvuSuhG7TKF9rnDFYbC8l6q7rTkxQ==
X-Received: by 2002:a05:6214:486:b0:6d8:95c9:af2b with SMTP id 6a1803df08f44-6e1b224ca45mr298377446d6.35.1737494099195;
        Tue, 21 Jan 2025 13:14:59 -0800 (PST)
Received: from denia.c.googlers.com (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc28f84sm54790186d6.63.2025.01.21.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:14:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 21 Jan 2025 21:14:51 +0000
Subject: [PATCH 2/4] media: nuvoton: Fix reference handling of ece_node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-nuvoton-v1-2-1ea4f0cdbda2@chromium.org>
References: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
In-Reply-To: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
To: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Make sure all the code paths call of_node_put().

Cc: stable@vger.kernel.org
Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/nuvoton/npcm-video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 7b4c23dbe709..f6cba17a7924 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1665,11 +1665,11 @@ static int npcm_video_ece_init(struct npcm_video *video)
 		dev_info(dev, "Support HEXTILE pixel format\n");
 
 		ece_pdev = of_find_device_by_node(ece_node);
+		of_node_put(ece_node);
 		if (!ece_pdev) {
 			dev_err(dev, "Failed to find ECE device\n");
 			return -ENODEV;
 		}
-		of_node_put(ece_node);
 
 		regs = devm_platform_ioremap_resource(ece_pdev, 0);
 		if (IS_ERR(regs)) {
@@ -1692,6 +1692,8 @@ static int npcm_video_ece_init(struct npcm_video *video)
 			dev_err(dev, "Failed to get ECE reset control in DTS\n");
 			return PTR_ERR(video->ece.reset);
 		}
+	} else {
+		of_node_put(ece_node);
 	}
 
 	return 0;

-- 
2.48.0.rc2.279.g1de40edade-goog


