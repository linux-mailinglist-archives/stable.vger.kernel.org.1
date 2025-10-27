Return-Path: <stable+bounces-190026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FAFC0EFDF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CCE3AD538
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5144130ACE5;
	Mon, 27 Oct 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiIdaDij"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EDD25C6FF
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579215; cv=none; b=b2UEl3p+lmK0iKeQ4GbswMbiTpyPozFn3bxSWugEF+dpJCwTjZznOY0XRIAgLiN0fakYNlX0wez1xQqtcHrTdJ7ITJEltHm9SHXE6jshjodQJkonOvygaiENv3YH7oYE0Bve+5K/OQUUXf2/74dyCFe5w0bwU+zR5A9jMRknFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579215; c=relaxed/simple;
	bh=WdBEdLpSforioHhbukeXfUmMVDWPeJnblF0f8wKYRHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=revxQk518I8UreCAbt3zK95rKOpjnAHUD2mGaPE9RvU48PcIozrNfDcS0bsF6sCLMfPlDsFtWwK0xq5ubGAr2hTamUZD9i35e4Ct8BmOV8JQL5ZjDYgj7nZssFurqCGtv/kdOosMo4CBr3gohhlc/Qi2floNHeLrc8ScpxYwgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiIdaDij; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b67684e2904so3472118a12.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761579213; x=1762184013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gyCJFEF05gZrJ9JMkK8QYJcfOxWfVMGePa9EE1L1ZCg=;
        b=NiIdaDij8RPnXWj5KP9bBwW3FrHfB1ghyPDE6n0usJ9YA8UycbUr3YgbZG6mQqrl0C
         72emAI2qz26zXXMge2PohWi7BIchYLVh3yTPyDC5rUQd5g41O1yX49NxVx2kbMO0/uqk
         k1AKn+GP7QwYp1gAZYlSrhv0NMentposByT5A7ucW9TSaG9sE8v2r2OxDeH03xzWAGll
         RPjOEYjuxxRQoCXOp/wYVDcREfLlsRpGehLV86qjGeQRDL5nfjrPGbsVFCFIuM7Aj8aG
         72lg8xsHUz6MWUB5o7oTcIcIpXM8E6XcZwO7aE2VL9x5uaP1wknA2GwB/nTnOANX97pZ
         VkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579213; x=1762184013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyCJFEF05gZrJ9JMkK8QYJcfOxWfVMGePa9EE1L1ZCg=;
        b=s20wXpdsMqYMl6PZUIgKV9BEYP2g13WCFmZgPa/0cytIoteAGNwkaYrLI91inqosH/
         O6//8XRwju/bMALLHPKnmh0zmZ3PRumzCbojYyI3TzwknLvTmTcVriiE+ZyAh1TOEd4H
         aKHPa23gMOO5FyVOYHesZLJBNWgMxYw+rR6yAx5UglpHkz7ms6C2skGViHTq1fjY8l+Q
         kxcDAvqlwwWS5Y+jVMD5aIGRLT0raJOgxh9AryTekx7vwIVBu/2PPmkuDs61ZL7A0RjS
         LbCElO7HIK9IXhR6OZsCBRr8yxTZnrwYeA7Vn97Mt4+Df/QiH3E1TRrcUyyXpRiNaun2
         Xzcw==
X-Forwarded-Encrypted: i=1; AJvYcCWTEeo+BILsM00gg2PMgBZKJm911UrgBTyNMEJrq+F1PtqfvCJknmFac4SAaL02xXp4rhAdMs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZGnLuPA3maGzqkyl5NSmXjuqO5K4pIys0UyPq19Pyia1lEH7
	9UYIlppyJPlii7Ra+n1eW3kXKTKj+gY7pluKd1Ku7Fed8P8ShJ3InVze
X-Gm-Gg: ASbGncueKZEH3tzDO/pFneUks6q4VFzETRDpCOBK2sZlLDv53zfx5S+0AlU6QQbrtfO
	ZXxjFNvZUEtsJR15HEoxW0pncuy33FSovrpFTckWuhTI6cLtg3pY0DRbQ8gGgdJ6Qy+b0EGDAiC
	Ky1PugIcmyjuMfdPVX9wbJEy+X8EjWzE9Nd3laluw5A2IXzDHm77JtZvF8vYWeg5/j7/LF0q6HU
	bozmZPwTGB3z7CF2QaNQ6jAlLIO/DWdqy++cKDHOeNYZROYakoG7fGo1+L6pMx2W36db7zFfu/Z
	zgVZVSyj5AMHfzimXG1FSA0Ye4VUhGMAQouvy93t9JoUlFVA2VA8EF+hRYzzAGSWdeejLFyBNg/
	iTCwfcUI3VHvRkLe/n4/G8cpOxxX8iwTTtT/5Q2KzEUOBBCOuLrKuaA0V8xkejVLmjYgjTw1wey
	czQiWAFDgzWuJTR+Drerdc9g2Q54BlOtee
X-Google-Smtp-Source: AGHT+IEshwgNJwDO9dUyM9pXppLasDaedDty5cozPvWHVpiDiRN+D5hXAsbWqdxeVF4eaG1w7MO3rw==
X-Received: by 2002:a17:903:124e:b0:24b:270e:56cb with SMTP id d9443c01a7336-294cb3e5310mr4051855ad.27.1761579213005;
        Mon, 27 Oct 2025 08:33:33 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf4a40sm87272165ad.0.2025.10.27.08.33.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:33:32 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephen Warren <swarren@nvidia.com>,
	Hiroshi DOYU <hdoyu@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] amba: tegra-ahb: fix reference count leak in tegra_ahb_enable_smmu
Date: Mon, 27 Oct 2025 23:33:15 +0800
Message-Id: <20251027153317.66454-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver_find_device_by_of_node() function returns a device with its
reference count incremented. driver_find_device_by_of_node() is an inline
wrapper that calls driver_find_device(), which calls get_device(dev) and
returns the found device with an incremented reference count.

Fix this by adding the missing put_device() call after the device
operations are completed.

Found via static analysis.

Fixes: 89c788bab1f0 ("ARM: tegra: Add SMMU enabler in AHB")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/amba/tegra-ahb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index c0e8b765522d..6c306d017b67 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -147,6 +147,7 @@ int tegra_ahb_enable_smmu(struct device_node *dn)
 	val = gizmo_readl(ahb, AHB_ARBITRATION_XBAR_CTRL);
 	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE;
 	gizmo_writel(ahb, val, AHB_ARBITRATION_XBAR_CTRL);
+	put_device(dev);
 	return 0;
 }
 EXPORT_SYMBOL(tegra_ahb_enable_smmu);
-- 
2.39.5 (Apple Git-154)


