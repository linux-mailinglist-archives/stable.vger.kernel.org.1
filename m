Return-Path: <stable+bounces-140865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B17AAABE8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E397A8E68
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC33BE0C6;
	Mon,  5 May 2025 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICUdJNMD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D72EC285;
	Mon,  5 May 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486615; cv=none; b=jzUkd3aPzIDRHlakpr2UtnLG7lNeIJ1e736iBpbJewXRJn84LVm8+atfjcLfVKYaHf+j9zC8Rg+YEN8NBLTnQsi7XvWVk7vOYFmoBQvgHFjvXeP5X9xO+jYnaLw25hQrAf17bbsB/C5LwkGFSmBWWF15OZdFu/J6atfcKirt3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486615; c=relaxed/simple;
	bh=Ebq6FPtPss/zzi/u4hlfPYAHa0WLxlQJcAjZnvV3q5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPWh59luFpjdkXLqcxvNLIDsJfg2yB5OdzdSAzSk+m8tdP7J6tZhkM0u7NVTZ+RVRwWTNMdAaDozvBOZPFpgHn8COYeJigpDsRqujSDM8HlnUGOMBNA1vr1YK2vA89qjpVziPaZBhAavX1tEltLM+AtpnczCmYcIhpXbzyc+nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICUdJNMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CC5C4CEED;
	Mon,  5 May 2025 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486614;
	bh=Ebq6FPtPss/zzi/u4hlfPYAHa0WLxlQJcAjZnvV3q5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICUdJNMDWeuoLt6doROiiQLFTRe7iY3lvkR4AxDYQwzqKDbTUNTf9ORmLFLkyvl+b
	 K5dRE8pAfGCdYM5IfkNdsZi5RuBnk0k7j0qPyjBQA3VMUOB8G4NGneK0dGiQeJGqbj
	 U2ten/VzqSKQ0RM2UpACLma9NND8MWWUwtJv/jrCMjLC9Yx0gFXIMYZ1C/KsQsUFcL
	 JgkFtxemgybvd6K803BZtUz9LSyxbij5P0sBTSlCVHgr3KVLMexiIACAkbVy78dOC/
	 WmmgekErJjTIRJ/VGPPEfL0Q3EGVwY+B6BGtQrAPwPYm2G0Oxvwz9bwtef6cU7Cg9k
	 Sm/fjqJ9wpYXg==
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
Subject: [PATCH AUTOSEL 6.1 119/212] net: xgene-v2: remove incorrect ACPI_PTR annotation
Date: Mon,  5 May 2025 19:04:51 -0400
Message-Id: <20250505230624.2692522-119-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


