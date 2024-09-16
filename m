Return-Path: <stable+bounces-76248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F397A0C5
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DCD281EE9
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D551547C4;
	Mon, 16 Sep 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Das6YO/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35ED14B967;
	Mon, 16 Sep 2024 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488051; cv=none; b=ljC670DTiRhhvwxrFb+LABCweAC5BqomWFyzyIc83AakspqIyE/8cYvrlFmzlV8KnS7tLLpNcpGUyzQhujAblUrZzAv6pw+7RvOWTy/4gYfjsER0qP28MjkQUQM2ZOeE0NpKoLSMl8WD+JNHxQHbKGSxJ9DF0AYt6i8auwX+fI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488051; c=relaxed/simple;
	bh=RTYGH/6Fsor/n3StNji8S/c955FDREdt9xXDfYzfuI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=au7pf8vIgt5OSxRy+hA1UzHQYbgSnU+OoKTFzJmX20zT6OCLNind26sQn8vhmadKDuTMXTc7HLyo8VxNKDywTn5p8TMnpOFWsPDUWXN92hMDQbPFeUJCs0GUO527IyHjJc/qwH3vAkCD81qpoW9fc3rJPcI1r79RnZ7LkBmesT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Das6YO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F58CC4CEC4;
	Mon, 16 Sep 2024 12:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488051;
	bh=RTYGH/6Fsor/n3StNji8S/c955FDREdt9xXDfYzfuI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Das6YO/ssgdzEkCYjzFOyEydOa4riW7a5VBvLO1ObAGqX8F6wVSZLnxXTq3rmirI
	 3G1P3bWAzsU1JpyQEdMlv59se0ayk2jB6thGtrQ8zcV43txsChafaAclu3K2nYpBFc
	 /xZvmOxJ0/8vyXRhVbbplKg7S7NL4uogAnk/iNdE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maximilian Luz <luzmaximilian@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 14/63] platform/surface: aggregator_registry: Add Support for Surface Pro 10
Date: Mon, 16 Sep 2024 13:43:53 +0200
Message-ID: <20240916114221.557209032@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>
References: <20240916114221.021192667@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maximilian Luz <luzmaximilian@gmail.com>

[ Upstream commit 9c8e022567bbec53bee8ae75c44b3d6cd2080d42 ]

Add SAM client device nodes for the Surface Pro 10. It seems to use the
same SAM client devices as the Surface Pro 9, so re-use its node group.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Link: https://lore.kernel.org/r/20240811131948.261806-2-luzmaximilian@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/surface/surface_aggregator_registry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 023f126121d7..6882f32d239d 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -298,7 +298,7 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	NULL,
 };
 
-/* Devices for Surface Pro 9 */
+/* Devices for Surface Pro 9 and 10 */
 static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_root,
 	&ssam_node_hub_kip,
@@ -337,6 +337,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Pro 9 */
 	{ "MSHW0343", (unsigned long)ssam_node_group_sp9 },
 
+	/* Surface Pro 10 */
+	{ "MSHW0510", (unsigned long)ssam_node_group_sp9 },
+
 	/* Surface Book 2 */
 	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
 
-- 
2.43.0




