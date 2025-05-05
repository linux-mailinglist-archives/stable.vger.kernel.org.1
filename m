Return-Path: <stable+bounces-140731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE2DAAAAFC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F3B1885C02
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D9938941E;
	Mon,  5 May 2025 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPhNXmyW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD1280CE4;
	Mon,  5 May 2025 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486089; cv=none; b=W6niixnNsgt5Bozu+WmB+XD0g2dTNX1+1lj5HPKNc/gghpE96A66/0QLpU+xZH4+cCjJZNVF4X7RefF7ix/0zORqaEAYsKthk7ckuA5UdCRk5llWa3jTnPUzVi4xBdTZTZSp5zVhKznEvyzKpXHgz0pnzkzQ8lpvFQKFoTQtC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486089; c=relaxed/simple;
	bh=Ebq6FPtPss/zzi/u4hlfPYAHa0WLxlQJcAjZnvV3q5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjblFVCnhbFwuNMdKwzFlmlEdmdSUMXge9AViKNOdsNkuV5o3/DFJrwrkpiXn2h3kDn/7LExkji6TsFmX4gdhL9llJCiFKIN4PPVI1TQjBxLrg/oSp+7of9XYgfb5cr0oDYP6ZNPnzU0EprCoal3JXpBm1H6BHPM2SCxswTl5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPhNXmyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D38C4CEE4;
	Mon,  5 May 2025 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486088;
	bh=Ebq6FPtPss/zzi/u4hlfPYAHa0WLxlQJcAjZnvV3q5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPhNXmyWawWeURty/+kcHMCVS0mgDtfxdd/W7HIGSkBx7j3khfR2V4VqlqmdAAelk
	 EVpSgg0vfZ7BIgyDdVBO+BncLjpgAZc7LTCVPnpSu5TXM72nL+6tYTk28TD5XrvGlO
	 wnFB2D56GIw3atNt3GZyqPINyFxraXgbWhNj0fPjQCI/5Wj2dOulO+Opc/8HlBtpx5
	 0k5KBm9RDhsp1vaIecZsUz56ZwQ9DCnhiRanOQeAClrk1VF3HtpxHG3ILKBP+2JV/2
	 HTnsCiirpCYmu5OFfsy5c6Y8bboCHIr1VPHPFeuI47R0Jvm8gUuNuyvO5LZxqQDM/I
	 eYXpVbOB3KyxA==
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
Subject: [PATCH AUTOSEL 6.6 149/294] net: xgene-v2: remove incorrect ACPI_PTR annotation
Date: Mon,  5 May 2025 18:54:09 -0400
Message-Id: <20250505225634.2688578-149-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 379d19d18dbed..5808e3c73a8f4 100644
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


