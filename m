Return-Path: <stable+bounces-198118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D5C9C62E
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 18:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D89C3493E7
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B72C0F69;
	Tue,  2 Dec 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzSt+A/n"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F5287503
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696536; cv=none; b=N7n2+GHcLI0JDKEBJaGE+RbC6RpMACqTEKMK6n5YKm2m9yA+NWggy+LmIt9sVY7W3F+6TOxre9HHVCtFGTmvsFOkYLky2VSDjExnjdvkAtemlzOWpBk9M5v/g7oX96sUHrMManuR5NFxNErJ7famZLkinlQ7H7FlavgCj8oMpvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696536; c=relaxed/simple;
	bh=bbyXr8Rsfc1UFlXiWJBghoTTRdZXqJHgATkSXcF1OKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPuZqVS8tHDAT8pZDbmZzO2eS7kDShkqTbVZ16dVZVShC+EVNa0Sk+o6lNI2WOPfxlbbLThSnyGnsdsriMDIajvwI4pu0wGhILq3XN5ToAwnQXSSDbw+dYbk+3XYZxkSBMXmMpHxHIzauIu9C5eAbQyk1ddN+NNbET24jkkRQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzSt+A/n; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764696530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mXbJh4w+pouSRV49yhKkyT8jZ3EhfqR8F6nsdHsJ00Y=;
	b=rzSt+A/n2n/+AjP46vDOkkmHHALSfqeRG9IehgD7Cys7nHIW99RvlnXTndA27Jbi5WYp9Z
	deE0u43bXMt0Tl1udxFofkZ+FgVHLpGbtWeOILRU/mu4rbh9V8wXtWK4JqnTTK/xlmK6Mp
	cFdBLWBPsTQxBnP+Hj9dx64lk2+CpcQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: marvell-88q2xxx: Fix clamped value in mv88q2xxx_hwmon_write
Date: Tue,  2 Dec 2025 18:27:44 +0100
Message-ID: <20251202172743.453055-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'val' was never clamped to -75000 or 180000 because
the return value of clamp_val() was not used. Fix this by assigning the
clamped value back to 'val', and use clamp() instead of clamp_val().

Cc: stable@vger.kernel.org
Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/phy/marvell-88q2xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index f3d83b04c953..201dee1a1698 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -698,7 +698,7 @@ static int mv88q2xxx_hwmon_write(struct device *dev,
 
 	switch (attr) {
 	case hwmon_temp_max:
-		clamp_val(val, -75000, 180000);
+		val = clamp(val, -75000, 180000);
 		val = (val / 1000) + 75;
 		val = FIELD_PREP(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
 				 val);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


