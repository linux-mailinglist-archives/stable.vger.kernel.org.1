Return-Path: <stable+bounces-200803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424DCB6594
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F6823017650
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD2304980;
	Thu, 11 Dec 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqTz0iwb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D045305E3A
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466894; cv=none; b=IgmqXABIoUBEUP8sp29poOMx2geFyKFCyoxtr5HMTiz204YI+Ktv8gK49mK+mHKcBTUYPMYfR5K7oMBqameWjni+Xe2J3xie+bx0eFEGzi3M9bj8cxJU+Pn/AUWUpfRnvU8L/HMqx9FplQX/ait6Fi/LICr6+rk/aKTb8wzoqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466894; c=relaxed/simple;
	bh=xePkpZbrNIejTV+/eBvIF3yGcCY2SKIZ1oKG3VWeink=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O9rU6NYj1Zotb+BUTlRtAyDz2FLfYF18IB6lRTtAlDMcsP6fKWksa6VLYI6pbbo0nrFSooZTIdP903C9R1SVz938GvpOqFYTMiVsqJBwCeEQAosWKJ1dxc/4RLF9UCExpsjstmK0Lmh0MymgMs9SMTP4PWijO+s+vCNGj3dtY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqTz0iwb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2956d816c10so2663585ad.1
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765466892; x=1766071692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IeE1L9lCPfTWMZGJYdbjvoHvkM1Avioc8h0oyJcvAGA=;
        b=QqTz0iwb61MlSKbFx/4kTR762hTUDXdSqCkmRnqkT0KyUKujtWV2dLrKKfcmmNyZK9
         PUP2yjaH4q53WYotfF7kyaT/RLmQiAm3w7BA7dHrOwM8HnKDDOhPOcDFGt2V5y7nvXAh
         ZeEFrVYLR7WJDvuAbCdMLvfCaIr0RF6x2k1tu691HcPg+eg8AFr6sgKxjcXKVOhfb79Y
         ovbMWWeocif77diAgfgp5CYXzBLxTfcdF0U+0Rqdl1RDcIcssir7qTv4GSj02JldDj63
         hH8/a+v725zP0oHnzuCAsjX8KbI6nrfGs1i/etmYTmIEQateK+ZLAU0MVYTDYBcPbFOB
         3lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765466892; x=1766071692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeE1L9lCPfTWMZGJYdbjvoHvkM1Avioc8h0oyJcvAGA=;
        b=P3NUZtCkHmYZIs+lM4QymDU8HwvNjblSeIuamtAOxVF0u7RqsrtsN3vlA+5Ba3dFmI
         Y7ORd+wa0AeTvOKvk2UHcLUwckRngRyARosE7iPiCfERFYGwwlx9JC6ymypNFO3GJdRl
         5gvmn2xZU7rs2IZ7yeIQo5hTw0kCAtc3FZ7cu1D0dkyFBG+xYJH+ivGlRBZlxMLNGwXB
         FjeL+MSo3C/QzxzU93yD9utoUpz4dHWfssmNNaaqGu3A0zORk/q4h0+FQ/2CnEe6524r
         mfnRgR0NstUmbfCcg24eQ/YXRPkB/TBhPzBAxxCPevP/PptkG64LxYpzz8YkMZlqHikF
         IWbw==
X-Forwarded-Encrypted: i=1; AJvYcCVSS0bOOEvtL1WyPuRtV/rLGULkEuHggTCoiG5tf4H1Wpcno5fVollD1DfsSWv4t3teARYP/DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8JD9LVwoRgIc1u3YCE2fBY8Li/cOvzVeDbGuJn5cKo+fLyns
	TuFA52EkKTKZHyKtkwPWqFQsXRJCU7wJfKydC+eYOQB3PAC70IuakAl+
X-Gm-Gg: AY/fxX7LDdLuLIrc2ZoDIp23b3Sr57V6hq5sZzDPBTSxC10ycXMmuz1E4C20F+Eoe00
	/WB0xXEdI1gduTdV7U/HAgBRhoACqc8H65q+U6EZ9EvW6181jLFmsVXqa8RxMct93afNDgrpei+
	ssVWZe89FKmbmvEEicI0d5Iciv+auRSTutQvBAg/xmbawd4lLzYPcj4YBcIGgvENdKvKfDaEzb6
	RaaPNf9rXz99qeS1T5Udwy1M8FG0RlHxBz95mp5rVkzNMlk4Ro+CG9kdMR6MhcZYJYNovzSxUqX
	DMS9Y+MpbhXaCkT+r5FhLJrDqGW3lflVp2MvgRwohVFI2rpvOd/Jy7ndQ89dJm7jS+f51Ts2rtF
	JWW3SGNy0KDhZIVIszwTha18Y0U55qFcp9FljkcZVHh3BOreruw5McHFr176PqPx2N6PXd6aKpr
	yqzKGaEwIO4ee4ywnhMSICW9A=
X-Google-Smtp-Source: AGHT+IHlArwVcYz3DUfciqyKswTQ68mcxdpSevFo5EUCuZKAfdt91RYKMdSWdPGZCDeyqbGrwmzkjg==
X-Received: by 2002:a17:903:2ec7:b0:295:745a:8016 with SMTP id d9443c01a7336-29ec22ca8e0mr60093495ad.11.1765466891603;
        Thu, 11 Dec 2025 07:28:11 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29eea0169easm28614045ad.50.2025.12.11.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 07:28:11 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alan Cox <alan@linux.intel.com>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/gma500: Fix refcount leak in oaktrail_hdmi_setup
Date: Thu, 11 Dec 2025 19:27:59 +0400
Message-Id: <20251211152759.2421435-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_get_device() increments the reference count on the PCI device.
Add missing pci_dev_put() in error paths to fix refcount leak.

Found via static analysis and code review.

Fixes: 1b082ccf5901 ("gma500: Add Oaktrail support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 20d027d552c7..2be12acc93d2 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -712,10 +712,10 @@ void oaktrail_hdmi_setup(struct drm_device *dev)
 	dev_info(dev->dev, "HDMI hardware present.\n");
 
 	return;
-
 free:
 	kfree(hdmi_dev);
 out:
+	pci_dev_put(pdev);
 	return;
 }
 
-- 
2.25.1


