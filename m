Return-Path: <stable+bounces-110312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A4A1A8CF
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AE5189086B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AB214600F;
	Thu, 23 Jan 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="hclYN++n"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CA13E02E
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652533; cv=pass; b=sl4soxXoAqmQzIMVe4dTDOkSh5/FK8jd3QiUPWGl8/Snz561BbIAfQltUkJKfbNYSpPNXruru1naCh+40tjkrvmQaIcMRQUC5Hk1G7zSkytwi+zwhHE8PUMhmtvsRyF5BoV80vjlFs6ZkOfdKqtpu0zgT1ZGYK17OaC7h6MeZ+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652533; c=relaxed/simple;
	bh=txvogRLlq36U+AmTqQUDdMV72LyTqNjSCjEcCLiNMQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kFHsBAc79tKT+9df5bgeVFvb/VeyHpdLphCkQPXqgzpFnRykO931r/DfICGol04zyw8mnB7txgIfNhTXzhm15MMTFv6b06TQtMq/Sd0i9Ot4ZS84FfYYZT0OjNaeENHVHIfnuaFLj8dNVgbl5kI6HtOfQr+UT+eoc6Zjv6JyzQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=hclYN++n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1737652520; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ew/zwLVxjevLTQDSUFdsKGtiI9HYYuXAUr8V4H9RPc1ZKGcn9/WomO5ff4M9LuIZlDcnLXYptR930GessK8JewrcZ8lDyZ8LTEeWWqrGXrtk0c/oO3D7ZT9/Z6/CNcCzE/WI22gc0LeIk+Y6CNpTD+nmqgXbknHFFMuodYlbEcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737652520; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kaI1RePGs9WnWousomVSW4phm7C1en3laBuzQvrTTNI=; 
	b=aHSiisExs0cu//iLIUhPZnB2h0yI8OoPh6Djcf4NHQPAf32jqIP4BG4SHxSVOPMTa8kcXGbmBIeeL4lfT9wlaVzo/PvQcZk4tSbtvmmmMWP05/kt0koeOj37y7UnfF0FW0zEy7KhyKhdsmWuEtandyxmkPcyiocYieG6CUiJlIc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737652520;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=kaI1RePGs9WnWousomVSW4phm7C1en3laBuzQvrTTNI=;
	b=hclYN++nqhU/dMRidqvUVnpgOUE4nzY2KKIXzB0NAs9l89sbgvWIHLou+CPB0CFw
	odThcD9AImtu7RKOmLzV31NG2FiGcz2o7sTB3SYe71r3YNiUS+lMQBb7KJcUmLdP4Hn
	asyVyjmJ4H6ZVlICBLlfk3rTHc5ueS/SNakgLFHk=
Received: by mx.zohomail.com with SMTPS id 173765251363692.22556778831415;
	Thu, 23 Jan 2025 09:15:13 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: stable@vger.kernel.org,
	akihiko.odaki@gmail.com,
	groeck@chromium.org,
	pmalani@chromium.org
Cc: kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 5.15.y] platform/chrome: cros_ec_typec: Check for EC driver
Date: Thu, 23 Jan 2025 18:15:29 +0100
Message-Id: <20250123171529.597031-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Akihiko Odaki <akihiko.odaki@gmail.com>

[ upstream commit 7464ff8bf2d762251b9537863db0e1caf9b0e402 ]

The EC driver may not be initialized when cros_typec_probe is called,
particulary when CONFIG_CROS_EC_CHARDEV=m.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Link: https://lore.kernel.org/r/20220404041101.6276-1-akihiko.odaki@gmail.com
Signed-off-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
This solves the kernel NULL pointer dereference exception detected
by KernelCI on many x86_64 Chromebooks - see e.g.:
https://staging.dashboard.kernelci.org:9000/test/maestro%3A6790c13e09f33884b18d7b09?df%7Cbp%7Calert=true&p=bt&tf%7Cb=a&tf%7Cbt=f&tf%7Ct=a&ti%7Cc=v5.15.176-124-ga38aec37d68a&ti%7Cch=a38aec37d68a477d59deca3dad2b2108c482c033&ti%7Cgb=linux-5.15.y&ti%7Cgu=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fstable%2Flinux-stable-rc.git&ti%7Ct=stable-rc


 drivers/platform/chrome/cros_ec_typec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2b8bef0d7ee5..c065963b9a42 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1123,6 +1123,9 @@ static int cros_typec_probe(struct platform_device *pdev)
 	}
 
 	ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
+	if (!ec_dev)
+		return -EPROBE_DEFER;
+
 	typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
 	typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
 							EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
-- 
2.30.2


