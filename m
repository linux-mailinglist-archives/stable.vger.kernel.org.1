Return-Path: <stable+bounces-41458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FE28B2964
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 22:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097C2282B0D
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 20:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFF152533;
	Thu, 25 Apr 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bvPsQP2A"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8D152511
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075637; cv=none; b=Q3C9Mq+/VFzymWciwwc0T2IBEY03OMUBw8+hhYVQMRWPWGnFq0Lag5qvZoWel0ZK3ts3muAYMmxcQwpQSZ4k9yb9MqIwLK0eirnJQbWqgljEjpTblemAm1pnxn+6mAhc4X6ZhSxvPlVptPGjSzkJsPA843+wHHllzRRKXa7ftI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075637; c=relaxed/simple;
	bh=iLDVXZBBBSfq3MIRyVOzTLDBsVLEW6rL/JzxpMZY63s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bi4WS4B/pHzUDwxT3U4aAJz3jANItY9dtMiMqL4fK+OOmPuRK88Are+dQ85+6dsT1DlClDqz9RjoVJKyQUjTKCwVK3+KcYKLiha+yEUo4nbMDgqg4mGjwWZfkES2yBHw/jVFiNb7JmgFssv0vYKS9DmPdIYAq7IHHOq9rXWfPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bvPsQP2A; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4371955d27fso8896081cf.0
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 13:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714075635; x=1714680435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hrf5rMrA2Yr2VlKzee9lYWI7dYbsc6Gr+Xi/bDn+rz0=;
        b=bvPsQP2AXHRNUzbFQ+GUSz2Js3PxgBjG+YKnV24caBDI5Wgez2m1BIxpdWJM8MgAqS
         jn6uxcX+dseXrFuML4e9Ym2S7zAzdnFEBPuIOHQIEaAmz51i0aFf986sAk2rlN5z90TJ
         ABYSZynPwy/BLSMu6qbp3l5Y+ktrMfhwcaWbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075635; x=1714680435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hrf5rMrA2Yr2VlKzee9lYWI7dYbsc6Gr+Xi/bDn+rz0=;
        b=n5/e1G5/1kH6VLPsL/hAaEqsXgyNRvgjfPjzSdQ/LN6rh+cuo6BQ16aBFeIxIebg3A
         Ch9eMNN2YH2b0/pseBu4mwCDvxv84ivzsW+nQIuTSgcYO9udQl+5LskeoxYr9VfG+bpI
         RbNK0rSjmpddiqCyjFgKlegvHmwIWBFWHdJedW8pZaUv9YlYuefKBIi60KwieQr6DIeO
         EY31gvKqkaGKfZUvTEjt047cpsO+CUUSZFSR9AT0ucRq/obfegcE158PNgX+9DmqRnvq
         dZz4UoMN80Da2b5+IEbavbdnd4ShbmuZVCMLrDWEwPtVYFLNaYfTk97z1cEjZjnogbXC
         1lZw==
X-Forwarded-Encrypted: i=1; AJvYcCWAhD1j6QQpKEULHsKeiU2FtsWLqQO/+pd10E3u7hsqZgFkZmAsTVCurAL8jz47Qg5MG5sPn+hZcMddWADhxHGdBZliJfw+
X-Gm-Message-State: AOJu0YzOK9QtF+TsCJCP+JQsK9UrBWXZqVV+xuWh+c/DnyAJDsCa2wl7
	FtSFUNF7+ZrdU6Y2mnIW7rXxwzLSUDnYubShEeW9W2nZH8qMKze7C9Uwas0TSw==
X-Google-Smtp-Source: AGHT+IHyRkYUe/0gy0s0tS/OX5ymL0pDu2uagfpJmaEPf+YoGRhJF+xf+fM/3zk+kXdOrIq5GkZOSQ==
X-Received: by 2002:ad4:5d6c:0:b0:6a0:9fd9:faac with SMTP id fn12-20020ad45d6c000000b006a09fd9faacmr1131728qvb.9.1714075634874;
        Thu, 25 Apr 2024 13:07:14 -0700 (PDT)
Received: from localhost ([173.205.42.30])
        by smtp.gmail.com with ESMTPSA id x1-20020a0ce0c1000000b006a047d74b10sm1940226qvk.4.2024.04.25.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:07:14 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	zack.rusin@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Ian Forbes <ian.forbes@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix Legacy Display Unit
Date: Thu, 25 Apr 2024 15:07:00 -0500
Message-Id: <20240425200700.24403-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Legacy DU was broken by the referenced fixes commit because the placement
and the busy_placement no longer pointed to the same object. This was later
fixed indirectly by commit a78a8da51b36c7a0c0c16233f91d60aac03a5a49
("drm/ttm: replace busy placement with flags v6") in v6.9.

Fixes: 39985eea5a6d ("drm/vmwgfx: Abstract placement selection")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Cc: <stable@vger.kernel.org> # v6.4+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 2bfac3aad7b7..98e73eb0ccf1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -204,6 +204,7 @@ int vmw_bo_pin_in_start_of_vram(struct vmw_private *dev_priv,
 			     VMW_BO_DOMAIN_VRAM,
 			     VMW_BO_DOMAIN_VRAM);
 	buf->places[0].lpfn = PFN_UP(bo->resource->size);
+	buf->busy_places[0].lpfn = PFN_UP(bo->resource->size);
 	ret = ttm_bo_validate(bo, &buf->placement, &ctx);
 
 	/* For some reason we didn't end up at the start of vram */
-- 
2.34.1


