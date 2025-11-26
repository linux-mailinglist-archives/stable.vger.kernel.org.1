Return-Path: <stable+bounces-197051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB96C8C08D
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 22:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8F534E2C39
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 21:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DAA2F362D;
	Wed, 26 Nov 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhjKowlb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E951F584C
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764192732; cv=none; b=d8J85mxWRwa3hkhrFCgQCcPsGjIgzflLkET4JIdOgIu2yvoPTahqc1xmeiug7AHrddwkKtGZlNTh7OfUewqT3sHO9iMrB+uNS41A4Ph0+vT6AHhcJj0f3rq8d3eOa5HEHY1c3CW+m6Jl44RaloJ5Rl4kg2whl01U7divcNftjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764192732; c=relaxed/simple;
	bh=LilEzDhcWjY57veICYfWfLCwFQ8k3uO5J7lq6Uiq/yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EXQ0T1iwyBlZrXgoE+w3ejLy1XtIRoVRJGxIh52rdfaBmAwU9cVunomIMpTucVw5O5WqdtWzlL+p/77/qGadYCphTIznMealnuIy8sCrkSCaKb8QdASRaxEWy8C7OSwGe0iIHfDk2H6rxALBxsy/0KBbaYrifP+OVMw1ImgAxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhjKowlb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b728a43e410so47095766b.1
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764192728; x=1764797528; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/IjEkSbir+5iDrD+cjTkZjSpdltDA21ZlX4G/dyJhg=;
        b=OhjKowlbkl+eBdWdhM0y0fbipEpp8Uh4w4Eq+BrS1/KoplnQA01HcoUTEqshA4qfKr
         eorF4hLGEQNAvkpOtBeRUTKtXSD6nfGX161yZhWLqyDYsZEoMVuxbYeCPBv/gCYLtP42
         G+yOq04jFLs+jwld2tO5iq7aUMPCamLlfjbLtkSupCxDxJDVkl9Sr5RJPXx125/aHzZy
         QfRcWuRrt149fpUsKEnP/kuBf8iNJP49In3SPz0ze2f2b5LHBeflzbdaJyim8UulxUnl
         TDlYp05qbZEfORgR0VXOqCyHQaue1ePlPPz59GUyKYAO38jGV4FhMNRbMVtSSBbvXe3x
         oMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764192728; x=1764797528;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/IjEkSbir+5iDrD+cjTkZjSpdltDA21ZlX4G/dyJhg=;
        b=ggkRzKzlFU7A2lEXVKJWPFBsxygPjV+XpkdwBGZFn1jS3YdU8kAsS9bBWblsya2fSM
         p9TB1IBaSoLYrJS5P4Hr6SizcdLO5WznlmyV61c2I9sUN4zLxiuFfkO5Cx7L3Aj1aepd
         9yiBTYx9OHaC0Q7qEXvDuYChUw/yAE/JVs2OFlf3IrJNtRQqDKXc4vlJNlar68aY72Jm
         SymB6Se6vnZoNvpBmWllgt0hm4bRB/KoO9w70QflTjuR6G6rprIs9BSdjiTOBJH/E3R+
         hoCF7sxMpibQm2HKlYtNxNrLp2628BJYO6ccQtYY3CY4LLjmFt2s/NLzEGUAlT/EB9ze
         Ul4g==
X-Forwarded-Encrypted: i=1; AJvYcCUFt5Ty0WM7KM/A8t4+GD+ZQc56tw/VmUAfhlu6MLtLaSCX2gQPwPE7aWpCjk7zOiLEIlorZjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rSZNLAbDN/Y2bMu/8iPxRBRsVwGol8qBIJDh5QinyviEVafc
	TIdGWxyweiDo9QPvEV7jhaPSi84LeSrTJySRFREbtlHv1ssBTGiOXhA=
X-Gm-Gg: ASbGnctoK13Qc9PDdkWPCFPfgyUAfIpXuJ/nAZTuOFGVnbmL5kjYpjRbn6vq6bzsnm7
	OIsmpXjwUs172ZdGrTZ/XA3OSNJ1Ii2LD0sTteXbTYbbx2n4Xfm9TWRQunBcrv4YbdFOKqUUcIh
	kSKLyHpEHLLw4L8J1rIlbl3wY+ejcTVJCluUvRbTAcGY+qQ8t0PurZ+29MFgNSmPYGJxlSCrJy6
	6/c2+AP4zrcPiuUbhodBHmOF9/han9BIUi5D/YeEYQ/rd2FJohKJAb0NdTmxNHHqO1u07613+8t
	LaUV6+yTIJMpJrX6IOSOOKfCB254WYgI2l3auALXF+fUej8DLF3MVbPcdiKa5Fj8bgTIFcz6/nn
	NQNMgYnlZZgxf9pGy20gqhH2pYrScu345ghb4BKXGMGdxvBw+xRyIt4XTwpxNAxWHyfMMDEXLuQ
	2PUDX+QLuN629TFXnltst+8VKsC5uCALnPo+31Km8OGpsJPbtN8DU5OQiDTKZdrP9P9RCHBLom6
	w==
X-Google-Smtp-Source: AGHT+IGvpQiDa98vuZ+r2RJ8KvDkUmhL1X9QjLRFojlbAheA3iOOln2ak/2qbylZFWsWbYzCZDCEow==
X-Received: by 2002:a17:906:50e:b0:b76:bb8e:9291 with SMTP id a640c23a62f3a-b76bb8e9627mr777562366b.0.1764192727897;
        Wed, 26 Nov 2025 13:32:07 -0800 (PST)
Received: from [192.168.1.17] (host-87-16-172-206.retail.telecomitalia.it. [87.16.172.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ce15e7sm2007828266b.8.2025.11.26.13.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:32:07 -0800 (PST)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Wed, 26 Nov 2025 22:31:30 +0100
Subject: [PATCH v2] drm/msm: add PERFCTR_CNTL to ifpc_reglist
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-ifpc_counters-v2-1-b798bc433eff@gmail.com>
X-B4-Tracking: v=1; b=H4sIALFxJ2kC/3XMQQrCMBCF4auUWRtpJkaLK+8hRUIyaQdsU5Ial
 JK7G7t3+T943waJIlOCa7NBpMyJw1wDDw3Y0cwDCXa1AVvUUuJZsF/sw4bXvFJMgjqnlTcKNRL
 UzxLJ83v37n3tkdMa4mfns/yt/6QshRQenaZLe+pahbdhMvw82jBBX0r5AjpbfQqqAAAA
X-Change-ID: 20251126-ifpc_counters-e8d53fa3252e
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764192726; l=1193;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=LilEzDhcWjY57veICYfWfLCwFQ8k3uO5J7lq6Uiq/yQ=;
 b=M/RIo1ohGCP4894QLZEeWHawQG421ypp8IgRCofThp6HqeZ3mrMcKYA3M691q+HNdFzOqT7b3
 o0RZiLYLO6xBaRZQ2hYP5JFmJVxtFFr5EaW/d1sVYGhM2cJld5cxQgQ
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Previously this register would become 0 after IFPC took place which
broke all usages of counters.

Fixes: a6a0157cc68e ("drm/msm/a6xx: Enable IFPC on Adreno X1-85")
Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
Changes in v2:
- Added Fixes tag
- Link to v1: https://lore.kernel.org/r/20251126-ifpc_counters-v1-1-f2d5e7048032@gmail.com
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 29107b362346..b731491dc522 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1392,6 +1392,7 @@ static const u32 a750_ifpc_reglist_regs[] = {
 	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(2),
 	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(3),
 	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(4),
+	REG_A6XX_RBBM_PERFCTR_CNTL,
 	REG_A6XX_TPL1_NC_MODE_CNTL,
 	REG_A6XX_SP_NC_MODE_CNTL,
 	REG_A6XX_CP_DBG_ECO_CNTL,

---
base-commit: 7bc29d5fb6faff2f547323c9ee8d3a0790cd2530
change-id: 20251126-ifpc_counters-e8d53fa3252e

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>


