Return-Path: <stable+bounces-141004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F7AAAD2A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BA4C5908
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70328D8F0;
	Mon,  5 May 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIc5RRoQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26333AFA8A;
	Mon,  5 May 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487215; cv=none; b=tdFJUzs6OSNr5izybS5J8mZDh4v5mEOMmzK16H5oEpmx+acs/kU4yukKJ9t+m5oojrVtDUzzczcg6/h0R4eXIhJJ1mPoNJu9Q5JSskAJwWVlGzRSyrWMGKg7Wb6MtTE41fZz1A9zvzry2i5m5GzYmQ2ZdgXcbJCF1/6mJWyzK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487215; c=relaxed/simple;
	bh=JkHI0b1zow/nDmNd3xJ8u6Z6ausDsIzQ8YeaD5Xhb7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEauauyehuMgYrWXB+3cnSM1VijH8GezB5eOCAa7QN+croWbAL5vytjtna9ggC/7tncicDUWIo8aelxTGpNuOOnZJd9VL3mt4/00TNKTZkBqegnqRQQFjpowzaK6c7hWlF9XZ7/oZG82My2PoBKF3Dydfm6HFxFHWcV1mrURyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIc5RRoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AB9C4CEEE;
	Mon,  5 May 2025 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487214;
	bh=JkHI0b1zow/nDmNd3xJ8u6Z6ausDsIzQ8YeaD5Xhb7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIc5RRoQc6whsVTbSJWWsmGPZXGWAr/gVrfCbRGkq1oWsDSRvsndeHWGojZ24mVPy
	 HNYT1MyZss8OAWS3kX4cBHa9ISIed/BHmclO8iovV6D+//TqlFUu+8QaFgHu6Nu+8c
	 MYBXXftien4BwNi1Lqdm5wdUAdCJ0b6SMAAD/Ul5ouVVtsnL4wkR19Qe5y9iKM1vEQ
	 HaulASUj4ZjSpUbwuV/Gorz3GVkR3c3h2GzzDRYjLrtIZPrmSDh8q/1j2QHUmA+3Rx
	 ysWDfJAdyPrgklslJBIZgbQbqY5tCgaliZpk2EJORPd3bO6ovno6DyyCYgMn++ADZn
	 ldufaJ70ySRTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	iyappan@os.amperecomputing.com,
	keyur@os.amperecomputing.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 061/114] net: xgene-v2: remove incorrect ACPI_PTR annotation
Date: Mon,  5 May 2025 19:17:24 -0400
Message-Id: <20250505231817.2697367-61-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 01358e8fe922f716c05d7864ac2213b2440026e7 ]

Building with W=1 shows a warning about xge_acpi_match being unused when
CONFIG_ACPI is disabled:

drivers/net/ethernet/apm/xgene-v2/main.c:723:36: error: unused variable 'xge_acpi_match' [-Werror,-Wunused-const-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20250225163341.4168238-2-arnd@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/apm/xgene-v2/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 80399c8980bd3..627f860141002 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -9,8 +9,6 @@
 
 #include "main.h"
 
-static const struct acpi_device_id xge_acpi_match[];
-
 static int xge_get_resources(struct xge_pdata *pdata)
 {
 	struct platform_device *pdev;
@@ -733,7 +731,7 @@ MODULE_DEVICE_TABLE(acpi, xge_acpi_match);
 static struct platform_driver xge_driver = {
 	.driver = {
 		   .name = "xgene-enet-v2",
-		   .acpi_match_table = ACPI_PTR(xge_acpi_match),
+		   .acpi_match_table = xge_acpi_match,
 	},
 	.probe = xge_probe,
 	.remove = xge_remove,
-- 
2.39.5


