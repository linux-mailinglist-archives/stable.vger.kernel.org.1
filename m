Return-Path: <stable+bounces-71420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70768962BEC
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC61287932
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD961A38DF;
	Wed, 28 Aug 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RdwHPzvo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C661A38D5
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858212; cv=none; b=oCv02ZQIGkof0nUq/YlOLcVsWA+CM332WAst4654sesw0g0VlcUNl7vVe/3uflYXy1in1SynzsTUafiX6HeFpL0sv8stwU2IGy/Euw6J9wypJ+vOgoqZl0XA7XOSDoWWw8UHucFyPFjYPFMFcnX2eOdvk958Nz0gRtsZPNwWN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858212; c=relaxed/simple;
	bh=xSsUE8O0OBLsJlAbTZSDyVIm8np/3o39QtfG850Mahs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ip2zrHslgA/Zofkq8H4V+rFDd6UG2/KpO5Mj6VgitxnzCUczkjiNMy+iXTUMfse2oe7cwjeqdSecoBzHYXbPJTcseiLS5XHMw3Plcv5cXjwpsZv/Cj/Fiq1PA5MnnYlaJWsnxwHzHYjFf6WVKTUoDCKYtE5Tey/AiGcxe08HtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RdwHPzvo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-715c160e231so2022591b3a.0
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724858210; x=1725463010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGorGxckmvbXxL6wgNnUsbdoW3Ac8a0ImG5glZMucZ8=;
        b=RdwHPzvotPt52kSEm+lfiPu2J1yWJAJ/aC05lzjdNpsK37wFi/Fu4pOlDr24J3fi7u
         xsljEsFxlWq/QxDc9YO/9bX8usuzP7qsYiOBIo8l8+OK56ud+XtwDXpKQ4eEtiWuPBSN
         tzCOMLlRcDpIajQ4S4O4TAPgL767foRtdMr38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858210; x=1725463010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGorGxckmvbXxL6wgNnUsbdoW3Ac8a0ImG5glZMucZ8=;
        b=s/yh+bt00zZecr4BQTVSK2udNKxK7uLkU+k+u3SZ7udA/H438OalpOtuKKxuOIoGa/
         /1T+8WxRTuGNvd7lpjjyjJ/VuHDltWB6upF61y6DNL5nAARb7cWCklhwxfMS7KijG+5b
         +vB0tox0edGIe3IgkyzMxfWfZHW1VTHsbojPj9bu1t5vC1UfiV1VWHBstuBygShTOIwD
         GOorE6M8lizCy7zM0aYJbhO5HhVkZlkw3XH7lNi7fx7sNLCIZyQ9aZDN20/kudjWvnnO
         ypsiN7zGJ1ukRsfYt/1HhdTO5QO0EGJvrCe2ZuStxgduN1W/tbxRJlrrUQqc976gk0wN
         7QMQ==
X-Gm-Message-State: AOJu0Ywq0q27QA8TbVHOZU62RM9H5dEEZFDZ47WdirDqtmAShvdt/Rpy
	BXyPHt9i1cjafxpisxNx44teAlEnYXKPdZV7TEP+0Dl0PIJT15X08Dz5iDBcLI1itkatDHMefpG
	SzUN0ADeYBuHnGi1epX96wnBXHTeDJi2GAoCgxfzua/l/zRTG4kxP+zFtsQUdj+tYz9fRXGgPHf
	NNC4YCYvy7gvQGfr4yUtLn9VWxtKuReDUeTBqwdRiEZQ2aY4YnvC6t0SfTXI+zQIk=
X-Google-Smtp-Source: AGHT+IHh7AFyXRDDkAshsWM9475dqzQbE9aMYa4K9mjb6QVCeNbGlYkoS7LO5r9jYiUaTcHHtxhNHA==
X-Received: by 2002:a05:6a20:d492:b0:1c4:a7a0:a7d4 with SMTP id adf61e73a8af0-1cc89d15ec2mr21365161637.7.1724858210082;
        Wed, 28 Aug 2024 08:16:50 -0700 (PDT)
Received: from fedora.. ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430608csm10273508b3a.153.2024.08.28.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:16:49 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jesse.zhang@amd.com,
	alexander.deucher@amd.com,
	sashal@kernel.org,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v4.19-v6.1] drm/amdgpu: Using uninitialized value *size when calling
Date: Wed, 28 Aug 2024 10:15:56 -0500
Message-ID: <20240828151607.448360-2-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 88a9a467c548d0b3c7761b4fd54a68e70f9c0944 ]

Initialize the size before calling amdgpu_vce_cs_reloc, such as case 0x03000001.
V2: To really improve the handling we would actually
   need to have a separate value of 0xffffffff.(Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index ecaa2d748..0a28daa14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -725,7 +725,8 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 	uint32_t created = 0;
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
-	uint32_t *size = &tmp;
+	uint32_t dummy = 0xffffffff;
+	uint32_t *size = &dummy;
 	unsigned idx;
 	int i, r = 0;
 
-- 
2.39.4


