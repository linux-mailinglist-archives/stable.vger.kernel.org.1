Return-Path: <stable+bounces-189911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0627C0BE5E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E23BD2B2
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B812D97BF;
	Mon, 27 Oct 2025 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhN0Udah"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7102D8385
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545179; cv=none; b=VrpOG28bDU7VXmHKH+KYwr75WTQ6YPROWlacHZvWnhgE53K33qPxdNXzUM3OpINU+Jp+CvBJyB0Ra5+lAeuL61lMVuHaYPJU4nKa8e4lz5RZZ990TRyyueRNycQURq5+sXFiy1QLGuGNGFYeCuoIRdxJGMfJPjOwGB4kVllkvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545179; c=relaxed/simple;
	bh=NkM5OOy0ytkuYdLV31rIkddcp0KAU5XfIo38O7mQLp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JYb05t7DOUoI0SDd+Yxq0JfM6r43XILXspFuiz8QyVrZxCSC+UtvBGFUu3x7aHKDuTcB2qQ68YB2b6jcTrekeFxLw4z/0Y4+61yAkMeld+HD9FTOXkCJg7o3fZygR+eyRtIXI/Z6g7RVHheKZrt8AEfs+BsAIt9NX+iAIbDcJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhN0Udah; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-273a0aeed57so58068195ad.1
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 23:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761545177; x=1762149977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awSfWJCX4NOY9wrF+e8kbd/fw7N/jjAHRA0gUFKf03w=;
        b=UhN0UdahpzrrAPhmvLivbhqb5qh3PL+X//OdV8ST4M+LYgORcTORh3+5sbxuafLuR5
         hLx4HuMWwkC5AltIB1R4B/tIkBCeiqoIA6oNmPpmi1BO2z4BlXwLwH/iwMN6JysbSdcf
         RdopUzLcfdKRBh0YuZNxzTInMFK+eVq+vWwszZ9EmbsPK/lq6NlVe7EG1HS8CcQ9bj5y
         zSR6XfHRSX80+eq81WVhrHJCLiYIOLdsmlsPij69C0MLg7lPS1t+hF8ajmujC936JB1A
         hJfc9pU7ldtLzrFlX/poKU8JLTJTfzFP8eyAGkFSNsYltLOhHbML8alI3sJhxAbhTBrQ
         Ydew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761545177; x=1762149977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awSfWJCX4NOY9wrF+e8kbd/fw7N/jjAHRA0gUFKf03w=;
        b=Fus/FOzau17dZSSOM6uv7YkwcWwPRErjUUU4LXZmrTVpyO7N53DXBN4/w7ITnJf5FN
         XJahIWZv0GQjjD7Fek9mDEMmCrmn15YNB7L9HKWLW/OrGsTJAIgDuhMqZVIqEzs3Mkaq
         X/9BSxig7jb5fHrgczAsg7cDUE0MYQzyYH8+1/4EDnQCuMaa2WmfhrKvcbOv76ZytQ2+
         FciHdkdoROqLMI//b3YVCfOtxiXAk7lsWXmpfFD5UhnYNx/XFBmu/E+LbSy7R3AfIPh5
         i2OiIn2BQksC5qnyfHWlHpQe2rOsbEDIyxHMo+gcKju/I7GS4kQ9SIqd9EapW6D3eczi
         4h0g==
X-Forwarded-Encrypted: i=1; AJvYcCW/SUPivbBmpA3xMYxk2zoGNUTJ5pDS0kykjbJJzvNWxhr7zV9dkF1ugwng5dKWAt79a/2L7PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZ5h74b5F7oAfcbNng3J0so+2ocLz3KBX9LGNgqmnEBhGwhDz
	ADfGe9UlLpBn6yTgSVC3cJ0Af0ixPjXnmitoU0KqFimqvVgmIzHLWGd+
X-Gm-Gg: ASbGncvfUHg5IEc2MjZqkCadV9/Y4hW82271ZvKmG0sbm4BEKkANvU8IZWbR2HaewPJ
	qu4g12W9z0a5hanNEbinLGQ/UyrcGpWUwqR6pxg+tI6aj4ceuudFdXxJgZIqla2IhYA7LhWQhSw
	MsIRum4UgtHI+aU2Q7HQTClYMsbaIajYMszGCnW7IGl/lmNZDoYsGO4RYjLcSq6YB3+Mz7W0VE5
	fk7kAF236pTw3YjWWAgEFdWKFPSG9QTasHiVT2YzFX6/yFKcZQVBL2+0ujnZzRrEaOveL+KxeVT
	rTi6lJyzzDoEwqixWF5B94onMYOTqeFuXRaLKGK4lSrFhdexBxt0FqprQSF0+X3n/PzE5/Lb+gs
	g4kRQ5GsFWLNobPGmiEhDktgFWGNJuxx6Ged0mybSqoQQMnh8PU2fvIm1m70ZB0F3N9OTezfc73
	AuCk87oG20J02xQXHoXiaZgw==
X-Google-Smtp-Source: AGHT+IGGfNR3pDzrLXsRHQ0DtnR/zCDD6PytEF/eEQoukh39nKst0A1lb0nK6x8BAecxfbckIr0K+g==
X-Received: by 2002:a17:902:ce81:b0:294:8c99:f318 with SMTP id d9443c01a7336-2948c99f5d2mr159955775ad.3.1761545176998;
        Sun, 26 Oct 2025 23:06:16 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e495e8sm67837735ad.110.2025.10.26.23.06.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 23:06:16 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] slimbus: ngd: Fix reference count leak in qcom_slim_ngd_notify_slaves
Date: Mon, 27 Oct 2025 14:06:01 +0800
Message-Id: <20251027060601.33228-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function qcom_slim_ngd_notify_slaves() calls of_slim_get_device() which
internally uses device_find_child() to obtain a device reference.
According to the device_find_child() documentation,
the caller must drop the reference with put_device() after use.

Found via static analysis and this is similar to commit 4e65bda8273c
("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 4fb66986cc22..cd40ab839c54 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1241,6 +1241,7 @@ static void qcom_slim_ngd_notify_slaves(struct qcom_slim_ngd_ctrl *ctrl)
 
 		if (slim_get_logical_addr(sbdev))
 			dev_err(ctrl->dev, "Failed to get logical address\n");
+		put_device(&sbdev->dev);
 	}
 }
 
-- 
2.39.5 (Apple Git-154)


