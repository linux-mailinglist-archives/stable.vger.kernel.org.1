Return-Path: <stable+bounces-96139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDAD9E0932
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AD4282256
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4A1D95A3;
	Mon,  2 Dec 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OGm7CBJd"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577513C8E8;
	Mon,  2 Dec 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158713; cv=none; b=f69gYvNsUpECvrM66Lm448lgmnfucUHW43/OUgBdQrFiPcy5W3aw4Vwkg3zyaO8YbzNINDBR/rWQIC/HDGLYK1hNCYy6yY262eUjIiRPpA1mHF/wRuoClYTLkFsZTRjCA3YcEwXD22aENEHRX1VOlFQ8t9kWmTYfXFCooLxCFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158713; c=relaxed/simple;
	bh=+/aze2XdCAbp3s1wCqprW1SADqz2t0OMsYVnR+C5QD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r25C9x4a26zUxHb9VGjBx+9G7m99bo3zttvG3OmcNT9KFTtTNGeAZuG1LLBUlPQDyKudysQkRGJ+oQVPTowGRvqZhYwj800GZnWomHLy+kg7su+JJcv0vAZuT6aE4aDUGFMuezK7/zaEWnhW0eyHXe04Utrb2rhSxG8qtDKPpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OGm7CBJd; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 236B2E0003;
	Mon,  2 Dec 2024 16:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733158709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=crHXj6kSMxBwiHS4OFprzVGLLYPQotmxut5qDRHbC9A=;
	b=OGm7CBJdwa/YOzj/A+yWhzEDKMSlz4FKa+GbTgVCyqjDEmP20x1pXABhO0rP2HKdX2UPUs
	OfsxFl1WVvv4q7n4OT2/Ne3MtYcmxHpJ/RUDI+QaXypAZfPYdWlTOkYf2y7m3G4KQDYx94
	bS/x2idB9+NXlDCAd7zQy+ixQP9vdCaXPrO9tzFijLXKN29OU1rh0vEp+WwZN0i+u3BwMm
	PzgPC1wUKGW6DTNfNcHNTKYefvgc0khHOYcmF36L3s63aIS10UWlYTeGubjPGu/ER7sqKE
	iFE7LGuXU55yNc4D5FwdF4QbeE58rSmbYn9Yc45LvcOIun//70kzgF4pMHLoag==
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <stephen.boyd@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH] of: Fix error path in of_parse_phandle_with_args_map()
Date: Mon,  2 Dec 2024 17:58:19 +0100
Message-ID: <20241202165819.158681-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The current code uses some 'goto put;' to cancel the parsing operation
and can lead to a return code value of 0 even on error cases.

Indeed, some goto calls are done from a loop without setting the ret
value explicitly before the goto call and so the ret value can be set to
0 due to operation done in previous loop iteration. For instance match
can be set to 0 in the previous loop iteration (leading to a new
iteration) but ret can also be set to 0 it the of_property_read_u32()
call succeed. In that case if no match are found or if an error is
detected the new iteration, the return value can be wrongly 0.

Avoid those cases setting the ret value explicitly before the goto
calls.

Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/base.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7dc394255a0a..809324607a5c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1507,8 +1507,10 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 			map_len--;
 
 			/* Check if not found */
-			if (!new)
+			if (!new) {
+				ret = -EINVAL;
 				goto put;
+			}
 
 			if (!of_device_is_available(new))
 				match = 0;
@@ -1518,17 +1520,20 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 				goto put;
 
 			/* Check for malformed properties */
-			if (WARN_ON(new_size > MAX_PHANDLE_ARGS))
-				goto put;
-			if (map_len < new_size)
+			if (WARN_ON(new_size > MAX_PHANDLE_ARGS) ||
+			    map_len < new_size) {
+				ret = -EINVAL;
 				goto put;
+			}
 
 			/* Move forward by new node's #<list>-cells amount */
 			map += new_size;
 			map_len -= new_size;
 		}
-		if (!match)
+		if (!match) {
+			ret = -ENOENT;
 			goto put;
+		}
 
 		/* Get the <list>-map-pass-thru property (optional) */
 		pass = of_get_property(cur, pass_name, NULL);
-- 
2.47.0


