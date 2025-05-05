Return-Path: <stable+bounces-141133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50212AAB64E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FF23A7086
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661D3278D1;
	Tue,  6 May 2025 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh7ha+9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA237533D;
	Mon,  5 May 2025 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485271; cv=none; b=RVqc9/hYvLsHeQdjvQkyKxjqCwWWBBY72tmaGwLJP6w/uoJ6kGShecKKWBh0MeykRukAUqJZAUd0QwA0DDURq1udZx5jb6zFQ1S/0nQqSjcTEXDcemLO1N3NczrlryAxmcruWZh7pPmBjk6OKlYFOTOvVJPUhyT9e/SMBGkVOL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485271; c=relaxed/simple;
	bh=pb2oVT93ib72xdnlaAdoQ8z1PWQRPnFU+pEqI39w8SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkueUyM5+F2I4D+AZcefHtzWNFL44vDGXFTBD98v9ISGMXGhXc6X2Kb9lsYxKKu1Uad2bPKG5T0S6J/aEvubL0Y0yfhX708c+VsFh7mHJbMemviZs2jdfUbOssNLdi8F0FX9MzhwDDPFbHEa4O92y41tuYXBl0eBHhlv8xDqboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh7ha+9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7166C4CEF1;
	Mon,  5 May 2025 22:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485271;
	bh=pb2oVT93ib72xdnlaAdoQ8z1PWQRPnFU+pEqI39w8SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gh7ha+9WrBIxuYo/8MIbkpLMXXWvtUO3Kw+dpDlGyfa6rOuzhrrSk4LTZO4U9yxM9
	 4VyzV2QGag+6ZereS7z0bUxv0lsvlcHW0QtWz2tkCwvw94HYCVrLIQ+7xoG9LCnKFV
	 hf/gOHqbi6JI7MBtzPNV2ghh+2NZmjFF1wrMW2IhjDPCfGibHqaWbain65dPpC7Ecx
	 5v4EhVcvlzihvtjPYJYuU25w1mU59anmm/Hbx7Pu+4j9C/QB19ipIOYxhR943054o/
	 dvdh29SANV9MzcDsuZfocevvgDPgizRfiLzYzaopQ0OZ71OqLrDQdwXAljhn0edvjT
	 DbNi3czDnM5Ww==
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
Subject: [PATCH AUTOSEL 6.12 245/486] net: xgene-v2: remove incorrect ACPI_PTR annotation
Date: Mon,  5 May 2025 18:35:21 -0400
Message-Id: <20250505223922.2682012-245-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 9e90c23814910..68335935cea77 100644
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
 	.remove_new = xge_remove,
-- 
2.39.5


