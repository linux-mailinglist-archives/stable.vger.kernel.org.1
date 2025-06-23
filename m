Return-Path: <stable+bounces-156617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C26AE5066
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655051B625A7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91A1F3B96;
	Mon, 23 Jun 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wSMEBYqt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA31E5B71;
	Mon, 23 Jun 2025 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713850; cv=none; b=b2V7SxghnAHZpbKi2RB5WKinZtdCRtV4APsA3WCwUwORF3ehSif/siAnQithQeJzCposdO9vJtaGmsHKiejQ2uitsp/Akosp99VMPe4oWwvViBa1hRxTEyM0RmEA6K01AcPLTCJIQvkEpFzB8avYZ6BP0hO9O08kQ9Pq+J0R4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713850; c=relaxed/simple;
	bh=aM3O3mSV/whPylVJ34MGChCofZfuAiLhhQHJLsfxYNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXcLMfIvdk4q5TYUATvtUDoPTCtcWnLQF32oxQE8P/Uhc6GfMq/I7xhFjUXyLjG4HxM7jHOaBMOWbFON7lqdzSaP0vLzwzD5KnDWGqf0F9vn4t/KLV656vzPFME5tngr3DMNDea/sxPJyUfOqqhEEpnmD7bLYgvlb/UB4RTQPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wSMEBYqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7745CC4CEEA;
	Mon, 23 Jun 2025 21:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713849;
	bh=aM3O3mSV/whPylVJ34MGChCofZfuAiLhhQHJLsfxYNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wSMEBYqtRXbIm7R2Gtmp9l4AKedJK9z/WAHy+MYl9KKK/YnNlhkKDhF6aJIkTS0hV
	 76AEq+2+ICxmnntE/ttNmr6kK8aeNChfs24QXj+vnd+7o7bXxTBAemgA6eL3SUpYBD
	 LSJdU+UMtz7OXry8OACLkavVohgV6uilVJt3CiJc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 119/290] power: supply: collie: Fix wakeup source leaks on device unbind
Date: Mon, 23 Jun 2025 15:06:20 +0200
Message-ID: <20250623130630.517927523@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c73d19f89cb03c43abbbfa3b9caa1b8fc719764c ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250406202730.55096-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/collie_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/collie_battery.c b/drivers/power/supply/collie_battery.c
index 68390bd1004f0..3daf7befc0bf6 100644
--- a/drivers/power/supply/collie_battery.c
+++ b/drivers/power/supply/collie_battery.c
@@ -440,6 +440,7 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 
 static void collie_bat_remove(struct ucb1x00_dev *dev)
 {
+	device_init_wakeup(&ucb->dev, 0);
 	free_irq(gpiod_to_irq(collie_bat_main.gpio_full), &collie_bat_main);
 	power_supply_unregister(collie_bat_bu.psy);
 	power_supply_unregister(collie_bat_main.psy);
-- 
2.39.5




