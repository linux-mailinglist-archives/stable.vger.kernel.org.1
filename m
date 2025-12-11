Return-Path: <stable+bounces-200796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0096CB5E18
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 734233011A7A
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9D12E6125;
	Thu, 11 Dec 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHka6oOk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E705130F953
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456440; cv=none; b=IbS8jiNKInomVxOZ3QY1XuGW0JoRN4vCduh8ovMm4enRznvN4I53TRnErOhL42ECWOkei7e+nBr9OKzTPIbQTPz0qEnMc7xiXFz67nq6LrLduXBWb3eyItWvPvmz77GTKz+Xb2KKcySmyHNEDoV6gj2yMp65rILlEjsmSBrRqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456440; c=relaxed/simple;
	bh=lw0EwoqT+IslF2eir1EkiX1oESNKVQo/Z8AZKR+KMr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O38+gMhYrD+j+UdILneDry7I7ZMAYq1jXDYoJk8RSptkJt+lU7LoWMHqMrTNRwqHvEDCpyPQPTdj/xSJVGgTLYQiBxfNW9jLr1e22Lh7PnbTHjHmL9PpjZKGPakiCOjqVLYe/axjiRUwjrHLb5gGFCxSZL+lfuUrHjsNTnCngOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHka6oOk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7f1243792f2so7167b3a.1
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765456438; x=1766061238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3dXU3GOLINLe9EjEUjPXBDJ3oxRXZRIziVkVY2yv9CM=;
        b=GHka6oOkfhHWQ8bTpXvYATTeBh+/6xTUlYP1v3AT4P+RZyAuXnZN2k0B50V+TEqiVk
         176ZvdkKE/woXgNvnA6geFnmluGcwtzCN4PxWnYvhGvZVUVptVjJ+pYDpw3U9prbAG4u
         akM6eB6+jGL+Bb7ULxERrkYV26wy2pdowUF17Io6yoY7v2QhiqFWckGtjxXJWwFV/G50
         UGOat+RuHrU2w2VM+K4BjI3GX8W3fU554ixGrxY+nWnnZZySqSe6nkRWa77qc8X9gwn/
         h6pVrT3HPEEyr6kXOP2vR3HMM05nGOkL3LCDiRWWKFpLcih2hZ+XjlRMdTKNT8bFzhaO
         +nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456438; x=1766061238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dXU3GOLINLe9EjEUjPXBDJ3oxRXZRIziVkVY2yv9CM=;
        b=sA4Sxftp8UJ5jvIPHFqu4cPV83OOHJWF18HBpBZVOlrUIL6ozPrQ9Q6HhBRWV5les2
         V7YBVJvGxaXH8lBJ6YGRnZddw3uVUiA1JZ/Obfs+k4NSzi76blxu67nrGJWe3Op54CxI
         Uj5/leTR4GANHniqkvYLzRe9jWNV3y0da8TY3haMHklgRMns9RiVAc6MYiLfeqdN/Uer
         KIl9o3SH0rYZ3Qib0+ilO/Kyjge7+a8i69wSsh7UjFmrPbcj8b5eYVdjJdxnUErER0ge
         Gdv1gJ5YnzrtQqBklIeWsaLqtWwS1o5mv36PDj2PDVqjvl++539/N0edHXg6c/X6nEyS
         eCXw==
X-Forwarded-Encrypted: i=1; AJvYcCVqHVW6wdo6ik0MeKIl9UBmPLuTkT1K8fGIZij/Pz4t9e/SRc5Dq7Hpk62SxRTtVzxC3hKvzeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ubY686zYFZ8VWe7MnW2/lwo5OdMXrc9cJx4C4pG9rFxQJTML
	tt6atEzJ78k7Ybl7YCOQLOwa1nciKilMAwbNyYxdCf7G18PqrYVIzWJJZPSPrYEpZ7c=
X-Gm-Gg: AY/fxX6gbjyEHCDfVQ1Fgh9adG5S/f682wUt7brWLmFHvN5U0qR+9q/R9oG6uMQiLjR
	76E1NjOkt5oZtNsAiB4oNbUBYPQ/W9lEv/2OncXsmYwSm5rdwSF0Ql86k3cbKt/rbIv7YxpUKWi
	+DjIrgZ1m6hKDVb1dxhoNmB1cmVes8ecAJHSFxD9j8eKCl6vFfLTYtP2CvQrARYpQ5Oj22mpnM1
	KwsR5owulFACRUMq8g6BjHPNqy6oa9nlZ7RtrRArAPGKZKYXfjosOK/yW3tgIPy0V6UCCzUVHWe
	G1amR1pPm2IUeoQKCigMzXrEbfUKiy0Rei2aaKdtvWGRtbu9UUp0mLtv4K/ZZL7Lcyqa14rGnAs
	aNpETC6+vdKmABrFx4m//5nl/NwmL4YHvCVjG9AqPnhrjV+ukO1aGAYoelJpj7rPT51zw8/j/dj
	z590NYNPBcV6R+RiQ7jVauvVk=
X-Google-Smtp-Source: AGHT+IHDxSfBltK6rQPgl+NpCNPIOrqOJbDt51JmeLKoJKrrNu4oCo5oerpmzjaZy4g1sKK8owEQ/Q==
X-Received: by 2002:a05:6a00:18aa:b0:7b8:10b9:9bec with SMTP id d2e1a72fcca58-7f22dcb515cmr5589040b3a.19.1765456437862;
        Thu, 11 Dec 2025 04:33:57 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7f4c27771b3sm2471892b3a.27.2025.12.11.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:33:57 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tom Cooksey <tom.cooksey@arm.com>,
	Eric Anholt <eric@anholt.net>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/pl111: Fix error handling in pl111_amba_probe
Date: Thu, 11 Dec 2025 16:33:44 +0400
Message-Id: <20251211123345.2392065-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jump to the existing dev_put label when devm_request_irq() fails
so drm_dev_put() and of_reserved_mem_device_release() run
instead of returning early and leaking resources.

Found via static analysis and code review.

Fixes: bed41005e617 ("drm/pl111: Initial drm/kms driver for pl111")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 56ff6a3fb483..d7dc83cf7b00 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -295,7 +295,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 			       variant->name, priv);
 	if (ret != 0) {
 		dev_err(dev, "%s failed irq %d\n", __func__, ret);
-		return ret;
+		goto dev_put;
 	}
 
 	ret = pl111_modeset_init(drm);
-- 
2.25.1


