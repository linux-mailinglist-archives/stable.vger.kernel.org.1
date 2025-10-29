Return-Path: <stable+bounces-191603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B3C1A6ED
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9D5D359549
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11C33F8A7;
	Wed, 29 Oct 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlTsM2Mb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806EB3385B8
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741282; cv=none; b=qgeN4pFoK0GXjXQKcyY+IJSsOcSJtuZyLAJJHPai7UDXubkjJQwAed4mLjb3hoXFIxglNOTeLODUoX8TQeE34Z2c/zVXZkE+THQ7+0hjD9t1PiwXNfWCQfvpZ3efMkgVgcp2mFXGowdNSbbc8K0xn3dqvPZXiArG+eSUyPrstM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741282; c=relaxed/simple;
	bh=MXV1J4/+oon+M/oX4IvFjQMNXVSF1SduLg0p6csa7Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NNIZHkwT4GWhlt6x8nlh7et2hjNyWAL5dlc3tOLtk3FHniCr3K9ZR6wboEy7LzQiiMSmraD8Fm3kx+PPcY/XupMP6rmGvMMwbDgfdmzYthNNR9StaQTYogTbKIA1bIHMRMhSqkEmaEG9APmkWmr3ioqs2x3oCTyPjkCnM0QqEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlTsM2Mb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a4176547bfso4099329b3a.2
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 05:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761741280; x=1762346080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLbzXZCnL4JaNq6mgAHYUsHmpe2Hmi5djVf9Q/V9xNE=;
        b=YlTsM2MbR9EeECgQHr8kew7suP6O6K5qbkyH953T16wNEaAsdkyw1xC3Qah/vaKFRS
         uyPRip5w2rqcd2yRBia98hutLBpQ0PoSOSbX2UQlPjIxdVqEmmiTypqaHR3QZfZcVuwe
         vAuJXF2j2MdlZBTDnjwpkdSO1u8/bGYFnd6r33yMgFJ+IOAtSkQ0W9NwmMMb5bPwKUBq
         Ap1FFQc7VYsoTNNoajcmeNrfIMhaCeJTUUD/C471jonCD8/nFIunNDJDGKS78SBH409u
         FhD/HFFeo6UV4Mn5UUGVXE2OBYn4VhrcDp68yTn4zObfEj7XVy9V4FB3P5eS+Yi6rE9a
         g9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741280; x=1762346080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLbzXZCnL4JaNq6mgAHYUsHmpe2Hmi5djVf9Q/V9xNE=;
        b=T8PdA6nx58SmS3fUq6QtmmgEidOQGBCCRkqobcCO5HzL4PYqu1h7FtGS3DJM7OoBMc
         mPLOyq+6++4IrnF0GNacP1j31Rbo3jlnNeh3Nx9PnFQo9FuiHMxHs8Omf0Rdk6rfUgs/
         FoYVmb4cLdFxraDu8u2aoOaZY7T+V+lfW9F+ZKAfgsaGx7JQoCxHeJtN3+Qv5whaH0Dy
         lVkWExUZ12fqR7qRzaFbZBZ+3nVERGwLrFYVXNaYBClGEtNJy2x1zSqpG0I0Y5BranNV
         UFbat0/Smf1bqx+pYiG2QzoVPUHNcb1xqHcQnCJVOre3U/utlasyRh35P528me/DKoKL
         +18g==
X-Forwarded-Encrypted: i=1; AJvYcCUxhnOFnZbfqgUuThjFZoG2wz5paTdC6GrcEt87Jj//AdP10quCPhyRbdT8GMd63jtbOM+IOA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Ctib+NS/v4iLY0m1oBxpcfYJsF5p/XJXmh1oDAmaXCSi+hg2
	og2CqxcqN5GP3fSm7kwnRSdumVWf7ljlCjCXPl1SbjwIvy2yr5W7XgXC
X-Gm-Gg: ASbGncsdTkvQFM/UhvASrfAEvndxB6vX2tOek4FBWcS6ZbtL92qWcPvVivEFj8cF9jO
	x/CeSSgMUb7T/9cnuJnnAXL2FZlKH3WTTsLEBiF2H5I1stq5AV9RIN/iLK11flReACYp9+TJZwT
	H+nFP7NIFVrDdToXXbgjwD1sUHU1U5Q1ReLZnPkYbpu/nsa6d5D1TYp0OOQXx1X/5IxfY4eDc57
	RFkhSjmlTGN3Bqnk3wahhC8PoTH+O5iOV/HjzckUttZaXCJ4E7PyfgDWZ1ZqqIWLFTENI/vUiiV
	iFRSNtCJujQSOjGvPeGrgWLmiHa6AJHBtjy4cFcIFg2V2jiVPttG24J5Jf8WQSJbkJRCiYwtkDi
	OwvHB3GIyKpNok4vd4PLrHs4YcWmuu4Bwh/yV8+ZUwwsBQnECx4UeAyYZ+we8uAKSTkWKyeUg6Z
	q5Vi8vADUXIY5prana1w0flQ==
X-Google-Smtp-Source: AGHT+IF5zDqYY2uyyaccHKjplnekkK2/6d+ShgjS5kIKOgPfbgi53OKTaTURa3EPvj0xY3duZVdWCQ==
X-Received: by 2002:a05:6a00:b51:b0:7a2:7458:7fc8 with SMTP id d2e1a72fcca58-7a4e2dfbfc0mr3441055b3a.13.1761741279605;
        Wed, 29 Oct 2025 05:34:39 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414087cdbsm15206397b3a.64.2025.10.29.05.34.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 05:34:39 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] dma: qcom: gpi: Fix memory leak in gpi_peripheral_config()
Date: Wed, 29 Oct 2025 20:34:19 +0800
Message-Id: <20251029123421.91973-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a memory leak in gpi_peripheral_config() where the original memory
pointed to by gchan->config could be lost if krealloc() fails.

The issue occurs when:
1. gchan->config points to previously allocated memory
2. krealloc() fails and returns NULL
3. The function directly assigns NULL to gchan->config, losing the
   reference to the original memory
4. The original memory becomes unreachable and cannot be freed

Fix this by using a temporary variable to hold the krealloc() result
and only updating gchan->config when the allocation succeeds.

Found via static analysis and code review.

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/qcom/gpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 8e87738086b2..8908b7c71900 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1605,14 +1605,16 @@ static int
 gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 {
 	struct gchan *gchan = to_gchan(chan);
+	void *new_config;
 
 	if (!config->peripheral_config)
 		return -EINVAL;
 
-	gchan->config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
-	if (!gchan->config)
+	new_config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
+	if (!new_config)
 		return -ENOMEM;
 
+	gchan->config = new_config;
 	memcpy(gchan->config, config->peripheral_config, config->peripheral_size);
 
 	return 0;
-- 
2.39.5 (Apple Git-154)


