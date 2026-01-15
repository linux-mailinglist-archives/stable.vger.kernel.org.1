Return-Path: <stable+bounces-209051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39052D26A10
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE15A313AEF0
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464115530C;
	Thu, 15 Jan 2026 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BS2sDd8O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826E2D541B;
	Thu, 15 Jan 2026 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497595; cv=none; b=jSyWKDCbnX01QwITC9QctKVif89dw9Lc02aZAS2PRyJ07OT2jVvPd1GZomgoeru5OQDZNn8yHMvUa8k6CHQVszW2U0oRIFGofc2i8s0jEtEvk3bJVXx9ywOAgMcuedzt/DzLuKtL/6aG/pJT39mzrqbR15nxRay0c+c4aXZhvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497595; c=relaxed/simple;
	bh=+QSOwfRVTk1ULhLGiwuWQR154buGdLzuipkbBK1QxtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hz1H6bdAvHB0RDup/ba8b7nbDquqmy5/qwevA2RvmszrvLTvw2Km94YwRUXIKCQaXPt7ebWkgDTfe27sUgjJ8Fmpy8h69TTPYwTrfgs7rZ+kNsmuES2WW5R/eYedIk2CLrVYEr3r5lo+7TD+wHsaySh+XOzcMMkc0nOOf95HhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BS2sDd8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3399C116D0;
	Thu, 15 Jan 2026 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497595;
	bh=+QSOwfRVTk1ULhLGiwuWQR154buGdLzuipkbBK1QxtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BS2sDd8Opq95lcs5rCNWaAYlQhoVntF1LdjvT6/duMXEuHyrGA+0kjOsWMacArBhR
	 vt4lt6Qf7tDwJkmtJYynqBj3LAieSeVPzvoiIja1Q18+ePYOG8AUJCzELx/8e6pWlJ
	 2lBIBeO4Do2YKcm0FJ69POlMJLF7s1YHF3T6QcCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 103/554] ACPI: property: Fix fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
Date: Thu, 15 Jan 2026 17:42:49 +0100
Message-ID: <20260115164249.981428217@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 593ee49222a0d751062fd9a5e4a963ade4ec028a ]

acpi_fwnode_graph_parse_endpoint() calls fwnode_get_parent() to obtain the
parent fwnode but returns without calling fwnode_handle_put() on it. This
potentially leads to a fwnode refcount leak and prevents the parent node
from being released properly.

Call fwnode_handle_put() on the parent fwnode before returning to prevent
the leak from occurring.

Fixes: 3b27d00e7b6d ("device property: Move fwnode graph ops to firmware specific locations")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
[ rjw: Changelog edits ]
Link: https://patch.msgid.link/20251111075000.1828-1-vulab@iscas.ac.cn
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 4205c7fdc4cc9..7f0fa58b634a3 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1402,6 +1402,7 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	if (fwnode_property_read_u32(fwnode, "reg", &endpoint->id))
 		fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
 
+	fwnode_handle_put(port_fwnode);
 	return 0;
 }
 
-- 
2.51.0




