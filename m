Return-Path: <stable+bounces-141065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D52AAB05D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C044A798C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7923E28ECD1;
	Mon,  5 May 2025 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJEBddhj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860272FAECC;
	Mon,  5 May 2025 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487388; cv=none; b=meWAhdr8IAhZ486BPEtS4hI2GnQSXO3bVy0Nz5UXWaMCSmXBN0p9sj6ztIeNhRATshjQH2z/kk+28DDElMKHs1S8lLdl0D/Ygrkc5+zQRJDhvUcUbaEkDGvt0y+3prrFK9ozuweUYK3TDgDrDCSbW3RxXiy/+inkgmjKCW/rfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487388; c=relaxed/simple;
	bh=r1tiKjuKfbd96zLtE+khOfPEPljsl9llIGk5isv3VwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8jzSF7SP9RduV+SL7shaD4mW5OcnNbRHGga7yCeWYdJqS60k90vat3E2HN7mvfSfsCwSdLSI4+rg9MKM5d6WKmfCA43LIBu70sPzs6cvdRz7B71eMZjt+eB5K8t0ssvdiJ0PcjGVtMfkBH4i5RaFWDj3tiAJI5cwd5TIexFaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJEBddhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC276C4CEEE;
	Mon,  5 May 2025 23:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487388;
	bh=r1tiKjuKfbd96zLtE+khOfPEPljsl9llIGk5isv3VwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJEBddhj9LiXDIz3E//MW/xvde+KlG9JD4MpM0pemEKOb+0yWKIEV+JwwdHav6TxH
	 CLeqR6Y/9LcwGxxhrqkXGfkC0iPHfZr7iRLtJ1f2Q+6Ix6oZYfYrDSeLC/4lry4cn+
	 g11wOlNRx3NJQtF7+Je5P2MD+eWBfjLDiwswemhNlDXXH9INA8ECEgs9fliTesDeyf
	 wuR6lZ1RvvOihpFJw9kw8pEH8roSl1yJWAxZQs/V4HjKz5r1EF0ZxOSYIUrkH1Npe3
	 c5OJ9qn6n/cTo7pBAuXu/CXQx1lq3aaMeF/unIMzIzKYmtbOXiI9N0lMsZzccYWDgd
	 oeQkGd1FOzMnw==
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
Subject: [PATCH AUTOSEL 5.4 43/79] net: xgene-v2: remove incorrect ACPI_PTR annotation
Date: Mon,  5 May 2025 19:21:15 -0400
Message-Id: <20250505232151.2698893-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 848be6bf2fd1f..514a121d96aeb 100644
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


