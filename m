Return-Path: <stable+bounces-168493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82729B23585
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9195762740F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D352FD1B2;
	Tue, 12 Aug 2025 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e5dpL3HI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FF1A01BF;
	Tue, 12 Aug 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024359; cv=none; b=bHn6iNKmE3UIieebQChg2fmL6xCsbCZqExX22Js1URBZvLOI9nNoCCQK2r+WD87CLeErkQLWagh7wJgM9TmNfSnG2rzBvoK24fUu5FplcfYsSwgn5Iq4Xs8qKcklcXTGqaOtBtn4O79IFAL12LOpxPM5Tfc6XoJv8QVfJhjlDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024359; c=relaxed/simple;
	bh=IBDFCIMUBENT9zHggZ8jfbTeAIWOgP2QAqFazH2nz7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoHpaX71xnlvML9UEFeNTrZ0abh97YL9/FZMI+Khy4J6kltnb8ZiHou6xnDS4KUeoMC6JzrFgr88GpQJLoOV4yJ9sc59nSeIWjpRLOGQ3rLsq6RInlJF5hvjY2w/6nVYIzc30YQoIQOyRMxnM7VvC1SNXpzHnDhEDm1sWHtPN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e5dpL3HI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAFFC4CEF0;
	Tue, 12 Aug 2025 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024358;
	bh=IBDFCIMUBENT9zHggZ8jfbTeAIWOgP2QAqFazH2nz7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5dpL3HIklu/3ez3d/3YQkVhZp2RveNUsFDmiWe1JZHu5/KuR2RdiGVFT42RaLKrI
	 TNausTbfQ4LPMPMMS0w7iQ7dpiJ5niXMbftiq/p/lpCNVeUpPwdvF+5qcpereYXT8N
	 xrf5FVUP2sOzRz6FnQ9exZqTw6zAbvXrDRtdWs5I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Han <hanchunchao@inspur.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 317/627] power: supply: cpcap-charger: Fix null check for power_supply_get_by_name
Date: Tue, 12 Aug 2025 19:30:12 +0200
Message-ID: <20250812173431.363306304@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Han <hanchunchao@inspur.com>

[ Upstream commit d9fa3aae08f99493e67fb79413c0e95d30fca5e9 ]

In the cpcap_usb_detect() function, the power_supply_get_by_name()
function may return `NULL` instead of an error pointer.
To prevent potential null pointer dereferences, Added a null check.

Fixes: eab4e6d953c1 ("power: supply: cpcap-charger: get the battery inserted infomation from cpcap-battery")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
Link: https://lore.kernel.org/r/20250519024741.5846-1-hanchunchao@inspur.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cpcap-charger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 13300dc60baf..d0c3008db534 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -689,9 +689,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 		struct power_supply *battery;
 
 		battery = power_supply_get_by_name("battery");
-		if (IS_ERR_OR_NULL(battery)) {
-			dev_err(ddata->dev, "battery power_supply not available %li\n",
-					PTR_ERR(battery));
+		if (!battery) {
+			dev_err(ddata->dev, "battery power_supply not available\n");
 			return;
 		}
 
-- 
2.39.5




