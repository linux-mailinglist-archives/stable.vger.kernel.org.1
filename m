Return-Path: <stable+bounces-187845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD51BED24A
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 17:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BDD19C4563
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF571FF61E;
	Sat, 18 Oct 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsZwQ7zR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A61FECBA
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800454; cv=none; b=gxXzaA3ALRSjmIyGjCulwtOq3cisKucWjH7+QksMfla6QOUXJ/atul3KtQvCvZfK9ojig+b595b8XkaWRgWrLc+gA64oiWASRqq5DD5+In2x69qD6kPkuTYMnksmg2Wk6QaFsT/fsBOD/zIsFblHUUB2Toy6wyoRG/e7NbWhxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800454; c=relaxed/simple;
	bh=z03vyMCNeNgWIEcd/EmXRZJ6fHrL5Fy1yJ58SqTIvKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrexjexSDh7VLs8a/IvwyYA2zllK/9ESnqfe2BIcoDLIgPB4L9t5cWa6/6o+ZXA9vNVb+PErS9Ln/idvh5cNNKVADDgGom+WLvlPd1Z2nIOqRYE2tQsgP4Rm3BVodmvJUjg92kKRjehN3Q/6bU4Vme7O9zoH6A13tUYIxhEUw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsZwQ7zR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103CEC4CEFB;
	Sat, 18 Oct 2025 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760800452;
	bh=z03vyMCNeNgWIEcd/EmXRZJ6fHrL5Fy1yJ58SqTIvKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsZwQ7zRZACNV+gfNWX6RFsOL3Jt7raxoWPPYgV1RsrAkS8EWIJIbWmF3CZRIywUZ
	 56uxGavooArIyXJYtmuSAHnUn6YVBXsQr1XernyaUCGeeU4a2ftqbwaVhk81q4Ekuo
	 Pr9yln0q4HZPaNl36QOyc0WAWngIJ0uSpvUYhoIgYBA0F43Eet9nYplCHl3tzmcEX1
	 f9yUKFFOHRh2QFNc9B28USTZpkEc67x5leqP0v8xwrfJIAQBylMtqXYeTEwa4UzpAp
	 B4ZEbTnF+VqB5F7F+AV1LkyXAZHQr7qfb+m+Zubt9LeHMJi/uoRrQ4d3rLX7bB83AZ
	 cacUo6Vt9fnYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] irqdomain: cdx: Switch to of_fwnode_handle()
Date: Sat, 18 Oct 2025 11:14:09 -0400
Message-ID: <20251018151410.809778-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101657-coaster-squall-0e3f@gregkh>
References: <2025101657-coaster-squall-0e3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 2a87a55f2281a1096d9e77ac6309b9128c107d97 ]

of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
defined of_fwnode_handle(). The former is in the process of being
removed, so use the latter instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>
Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
Acked-by: Nipun Gupta <nipun.gupta@amd.com>
Link: https://lore.kernel.org/r/20250415104734.106849-1-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 76254bc489d3 ("cdx: Fix device node reference leak in cdx_msi_domain_init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cdx/cdx_msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index e55f1716cfcb2..0bb32829d9084 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -165,7 +165,7 @@ struct irq_domain *cdx_msi_domain_init(struct device *dev)
 	struct device_node *parent_node;
 	struct irq_domain *parent;
 
-	fwnode_handle = of_node_to_fwnode(np);
+	fwnode_handle = of_fwnode_handle(np);
 
 	parent_node = of_parse_phandle(np, "msi-map", 1);
 	if (!parent_node) {
@@ -173,7 +173,7 @@ struct irq_domain *cdx_msi_domain_init(struct device *dev)
 		return NULL;
 	}
 
-	parent = irq_find_matching_fwnode(of_node_to_fwnode(parent_node), DOMAIN_BUS_NEXUS);
+	parent = irq_find_matching_fwnode(of_fwnode_handle(parent_node), DOMAIN_BUS_NEXUS);
 	if (!parent || !msi_get_domain_info(parent)) {
 		dev_err(dev, "unable to locate ITS domain\n");
 		return NULL;
-- 
2.51.0


