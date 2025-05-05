Return-Path: <stable+bounces-140056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C05EAAA491
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56CE5A7CD8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16AE300369;
	Mon,  5 May 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTIXz1W+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92A300361;
	Mon,  5 May 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483993; cv=none; b=ANEM60RDJp0Lpx9LwX0jeeoFzpFKSfO2WjMLKXhrwzEx7vNmqMWU1R0alFGTiU9hbLF4Z+FEGE568JsVIJS1HfWRBC8FHC5R57taE+Tv+xvmXd3bAYPTUio/jYcn9UMvfGvQV/O2hisw2s3Uk2mKnlF81PJ1JQXsisaDqm/STAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483993; c=relaxed/simple;
	bh=pcw6Woza1IyjZa7/G4X5D6rAQhp83oO7yhfdr8xOrdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gylVUhQ/YFMxP+OclKok/MoyxKsh58EalGM+FzTpd+IGyy6mGoSsDjT9VR+s+JK/4gOEC6w52mf0I/0WhBA2oV6Gscme6SttPvlZEgeVRQJNb7EygGjL0xp8MVOdc3n/QMcY4WBiH8C2sH5LlQZso9InZ+s1EDRMqDrHwA5VlR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTIXz1W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCB5C4CEEE;
	Mon,  5 May 2025 22:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483993;
	bh=pcw6Woza1IyjZa7/G4X5D6rAQhp83oO7yhfdr8xOrdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTIXz1W+LRjBu7bg/XcmJK75igo7qg/nmbGijTToaM+MsqFWglgKXuMzqjLvUgTZj
	 YzvHKqaNGTrvfACfjbu6pbkmUfpMwKS4HHYD76nXHvXeQ95i4cxu6d+zDqPXQ1yQjv
	 L50QgOP1GCZ8tgcqwDNWJ7RpEI4Ln5sm5BuaQ+Nee1xNI+VMDz9Ce66L0n031JGzFQ
	 uziU8Ro3AsbtM4QyKjVppwD7O+ZgEL4YhRxzAo1bIx5KIxxhfqG27+JhpKVCpTl6GS
	 12wx56mzKcziEfT5nqIo8CIT4BVDI2naeayiiNqmQUbHcuOLZbxm6gToB7VlwXQWT7
	 Hd9zXFSB17I5A==
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
Subject: [PATCH AUTOSEL 6.14 309/642] net: xgene-v2: remove incorrect ACPI_PTR annotation
Date: Mon,  5 May 2025 18:08:45 -0400
Message-Id: <20250505221419.2672473-309-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 2a91c84aebdb0..d7ca847d44c7c 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -9,8 +9,6 @@
 
 #include "main.h"
 
-static const struct acpi_device_id xge_acpi_match[];
-
 static int xge_get_resources(struct xge_pdata *pdata)
 {
 	struct platform_device *pdev;
@@ -731,7 +729,7 @@ MODULE_DEVICE_TABLE(acpi, xge_acpi_match);
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


