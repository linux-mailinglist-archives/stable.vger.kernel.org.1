Return-Path: <stable+bounces-124669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F399BA6588A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2272189C213
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805051E8334;
	Mon, 17 Mar 2025 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhxVEN1O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4181E7C12;
	Mon, 17 Mar 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229492; cv=none; b=najCjAMVGpSkrbpUEwqwnMZS1sjRV51GTv/c0FDe7r7uVKZ4gW9+0YYiR3Be5c7fZn+UB9rMbMSsYVeytMj4ZPnWRpwcIo6Q69RFfJG29FTcMZXeWdBRz18wIBivcPI+a4qBaQkGrei1tD8X/LRZiSBOilA6DkfvgBy1wNFcSW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229492; c=relaxed/simple;
	bh=emVXipuDOlFNR62gAzaZ6IAAI/DEUzysb7yfu28AqoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUTGNWjsyWv2ueHmtESyijpz4FKu7w7b5jlZtQD0qKySesz7MxEOs8qKQKEgCjt7W6fVUwrF1n4tobEArt/VXAPlX5nyZCpvRtO/u2mBCYLjr3zb3idPeNEjFUd/GPAVaG29zQRolCoxOfIypNoMxrX//B9Fq4OwfFMfQW+PKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhxVEN1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9BFC4CEE3;
	Mon, 17 Mar 2025 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229491;
	bh=emVXipuDOlFNR62gAzaZ6IAAI/DEUzysb7yfu28AqoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhxVEN1O6J6wTyLJZf94+0lFu5b8v6C6pIcEqb0G6kyAfjDgyLpjvENdDwAZA8NEr
	 5XzOQgFh2SvTiR2dajMEe5uzUPTAHP5D/ax0PQhfGdnjclNDxr6pG75Lw93H6EwJOa
	 zRPSFQ4r/WKIyLSCS8D1yiXJLx2wGtE1OXCBjDj3DKIB1X26P/60qLH8lDctrFBBqX
	 gb+1LZfoDgnT4Wrl4OrqRBRZ9zPg09kpnDDi5KfSvbX6TOdSbny35X6wpDeIH9o3oS
	 z6hrNJxh+qUmAbdz3gif2nKuq6F/yxVHvNCRM4FEcocztx9Fx9L48MF+3t2Xh+j8YC
	 UKcD81HWmFWUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lukas Hetzenecker <lukas@hetzenecker.me>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	luzmaximilian@gmail.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 14/16] platform/surface: aggregator_registry: Add Support for Surface Pro 11
Date: Mon, 17 Mar 2025 12:37:23 -0400
Message-Id: <20250317163725.1892824-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
Content-Transfer-Encoding: 8bit

From: Lukas Hetzenecker <lukas@hetzenecker.me>

[ Upstream commit a05507cef0ee6a0af402c0d7e994115033ff746b ]

Add SAM client device nodes for the Surface Pro 11 (Intel).
Like with the Surface Pro 10 already, the node group
is compatible, so it can be reused.

Signed-off-by: Lukas Hetzenecker <lukas@hetzenecker.me>
Link: https://lore.kernel.org/r/20250310232803.23691-1-lukas@hetzenecker.me
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/surface/surface_aggregator_registry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index d4f32ad665305..a594d5fcfcfd1 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -371,7 +371,7 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	NULL,
 };
 
-/* Devices for Surface Pro 9 (Intel/x86) and 10 */
+/* Devices for Surface Pro 9, 10 and 11 (Intel/x86) */
 static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_root,
 	&ssam_node_hub_kip,
@@ -430,6 +430,9 @@ static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
 	/* Surface Pro 10 */
 	{ "MSHW0510", (unsigned long)ssam_node_group_sp9 },
 
+	/* Surface Pro 11 */
+	{ "MSHW0583", (unsigned long)ssam_node_group_sp9 },
+
 	/* Surface Book 2 */
 	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
 
-- 
2.39.5


