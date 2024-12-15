Return-Path: <stable+bounces-104276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB7F9F23ED
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 13:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C464164F3E
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482491865E9;
	Sun, 15 Dec 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkmwLr7E"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763681E871;
	Sun, 15 Dec 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734267242; cv=none; b=qaCSq+xWre2OQ2B6eNbqyXomdw+jMJxVtFqrixSWBRTyksJRnamV6eEEBbxN4Eanvuax48uklFbfqJmlIBDnGgnySyw1yyHD15hErqu1d5sGDjHhz+seutSM3QSLbJw43F3OnDLP6UVfvtkczs/d2lhJOzyKeTLfyenyzgcyV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734267242; c=relaxed/simple;
	bh=65wnhQy7uS0O6VI0KdEawV5PH9+4O1/ko8Or7TduxYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SiA1VKprdYqLidUmvpPMwGWP3TVrT9R++IGolqsMIuoB+Kf4zoXNG9tv35EDpbeoh4dz3WluzrL/Y0NQ3YPIILsudV/KATlv91LSAyeL1Ehg3ji7g51v1QPOA5B9dlqwlr72CpWqX0dgYh3XJnxjGfAPKuFPAi07VlaP+nxRXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkmwLr7E; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aab925654d9so315407066b.2;
        Sun, 15 Dec 2024 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734267239; x=1734872039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFvxqbbRTWoZ+TGL4KkSwITrWYOc2TJu0vqqiXJT5zA=;
        b=fkmwLr7EgHtgoVROVN0BrrQa+ak/YJ2R9HG8YKUIGXEZ4ROmop51y/7MmQlglyNIqT
         lrlzZGIbPSNeHHdfvEqgh4qTqsigcuyxg6IVFjNyj8Y+uLiAzT+ngDZAzDLcicR8VW4v
         hR55vtv6/M454VS08bDAS1YKzqBI4Wfe9jUATU0UhDjTqbQfJcqXTD2YarKfvEgui4TM
         gtq0TXeOn4n9KskYXA5tP3CMfg6+wsPp3SnXM6iH4B8gJW24TeJKz62VMTeg2oVbYr7m
         mSPc4Z3PwgpTg9coWPAR45xTxYPQXYF110C31q3hJcl/tJ7Nu+WtLPf/IttIPG3PrxJD
         u2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734267239; x=1734872039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFvxqbbRTWoZ+TGL4KkSwITrWYOc2TJu0vqqiXJT5zA=;
        b=lAOCrnJ/A8zidx57IkcrCbKpCEMc6dDbWN2twkFZPDa3zZ1FMoNvr63uKEX9I9Cy2F
         opwwhw7tnmULZscs9jd9283yFBVIgI5ydrEjWwi1Luba5f8PMyY/gWrhYNhdhr4CBxI/
         Gz80cdXVdmSsdXGTLkPTT7Ke//5W2iqVbeLVHgBS7/G9Ad9KZoOGjsgKdzidVa/u2LCK
         pM+lp1gcbqAuwdBcQlV9I4FFe80iLDeoGlBM3cVZjeKFJJWoYMgZ4Pflm2TNCmqy68Bh
         FapcvxGkQQXz8bdqh6sHP87kbPKx83mAyuZ8QTozfoCB0L2O6VvCf5S9DwgdkPbQe/3U
         7Kvw==
X-Forwarded-Encrypted: i=1; AJvYcCWI5ZM5hlyA2qDttGZQv6pKX4XIrvPjjPypcfxSLj5ujJ1GvqWorz1EAHsijvObI/WeRi5N8qZWU6FIVK0=@vger.kernel.org, AJvYcCWUU+fT+Efij9gEcR5EVL4lbYcRCBVumchPfK9l7KyZOQ9nm1nFc3IlP8XAYTVrxxwy6x8dxEID@vger.kernel.org
X-Gm-Message-State: AOJu0YxwimOqBtwKmozUZJmCuQisY7hc1n1tgHOPpubIkfVpy0q+cbI7
	rBnu69BZ0uK+8Khvt7fBkeoghC6wRlTM6/MRvn+6CUriQMy3Dgdf
X-Gm-Gg: ASbGncukGJ4/4P1TvVwjgiEJ67I09s7tcAP+qFi6aBnUnAiT4I7qqZ3IfAM5LV3o3PN
	f6YM97m6Xrns3Kz+PLDr2wKTRqFIKdATnSZCRT9Xt7/8q93ZfQbv+afiT/VTpA9dVHWtWsqItzX
	fCmWanNIvoI/4RdkIK64nAnvgmH5JmtG0MTaQAzx+Ix7obPCnX8LXfHUzx+ZUkXfI5zQG03hpdZ
	QIJEUwklzSweu5cxPOQzqoXYzE/MMtxdjRZ+zMjpWaGAnvN1Pk5G5467mmC99ANHI8=
X-Google-Smtp-Source: AGHT+IGzsljMyjy3J7dXhJasGjwSWHymnukngwVrGT5+zoVtlmSyNURrevS5QQnQ9x8fAdVpqXhemg==
X-Received: by 2002:a17:907:3f97:b0:aab:736c:5a7 with SMTP id a640c23a62f3a-aab779b4b90mr941982466b.25.1734267238510;
        Sun, 15 Dec 2024 04:53:58 -0800 (PST)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963910f7sm204578366b.166.2024.12.15.04.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 04:53:58 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: karprzy7@gmail.com,
	laurent.pinchart@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	michal.simek@amd.com
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv3] drm: zynqmp_dp: Fix integer overflow in zynqmp_dp_rate_get()
Date: Sun, 15 Dec 2024 13:53:55 +0100
Message-Id: <20241215125355.938953-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a potential integer overflow in the zynqmp_dp_rate_get()

The issue comes up when the expression
drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000 is evaluated using 32-bit
Now the constant is a compatible 64-bit type.

Resolves coverity issues: CID 1636340 and CID 1635811

Cc: stable@vger.kernel.org
Fixes: 28edaacb821c6 ("drm: zynqmp_dp: Add debugfs interface for compliance testing")
Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
Changes from previous versions:
Added Fixes tag
Added Cc for stable kernel version
Fixed formatting

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 25c5dc61ee88..56a261a40ea3 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -2190,7 +2190,7 @@ static int zynqmp_dp_rate_get(void *data, u64 *val)
 	struct zynqmp_dp *dp = data;
 
 	mutex_lock(&dp->lock);
-	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000;
+	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000ULL;
 	mutex_unlock(&dp->lock);
 	return 0;
 }
-- 
2.34.1


