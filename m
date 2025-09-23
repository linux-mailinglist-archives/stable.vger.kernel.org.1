Return-Path: <stable+bounces-181537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9AAB97135
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 19:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB64A5B7A
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B062836A4;
	Tue, 23 Sep 2025 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRKNmqGM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682A284B2E;
	Tue, 23 Sep 2025 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649494; cv=none; b=MxCJUZ42QXy0PgonzmVQonowvnNdf7ol2G8BwYIp616gTHlu95zjnS4FLfJsO6vnsKJru3uteii2p9cFdTZkL34zf0wAIaR+Xr2h5ed6sekyrcxrKE37N9sFud7JRUAsGJ7QqzDKjaPEJVGb1apM5TDRW0oUhl7zkQ7dcoRW1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649494; c=relaxed/simple;
	bh=JOexoZ5R9SLbzJLtYrMGrjPiOfLw4FQV5NzkJc9be6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQyWOO+JFqjpgw1Me38wzFJi/fBt+V+JxrnrRGJVvZz4FcFiFULa3gJbgEqnkBbj1Qo7lq+6SYZea3BvYz9EnjMnAGzSJhLQ6zx6j/fr/599z2ECZ1SV9j0OQqFGCYT+IFAb8YZz94sOM52fppMFUyrLeWxuopr2LOX/MI1gb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRKNmqGM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758649493; x=1790185493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JOexoZ5R9SLbzJLtYrMGrjPiOfLw4FQV5NzkJc9be6E=;
  b=ZRKNmqGMettpCmIG79n+qAW5voIDUJyL1QZw/jPU+ugPxT7uvz03X4G1
   VjNMseqMT3N3OP0++aefbovBPG0MUBxNSZJ2AX0dSS20iII45x+Jo0wqp
   p9w2K08hurfpFiakiRvcIwKk14NYkKdFjzkix62944XB0m9GxmkIuRVWI
   PRlN/wlAYwBHwaQ7rKyIRjiAwwqDkuDsnIJSo9Er+vVcqwcI/ui2kRAXJ
   ws4Kvkm62kAciNxbg6CVUpvH3JegTcMl0xVXkbnAQAd35LS3+ah4jWlwC
   nkZB3okZnq/1GdfOLhJcATZ0i/iYS3VPudDbAeOan6DdW6ySh2q+eovJh
   Q==;
X-CSE-ConnectionGUID: AeqvM4hcR7uYF+DwBsO/yw==
X-CSE-MsgGUID: R4fhUjDKQnekY7miWoAp0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="59976681"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="59976681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 10:44:52 -0700
X-CSE-ConnectionGUID: ovezEIZLSmecp48n7Y4JBA==
X-CSE-MsgGUID: kjVKrTtXTwyqi3lqEfYZNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="176647347"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Sep 2025 10:44:50 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()
Date: Tue, 23 Sep 2025 23:13:08 +0530
Message-Id: <20250923174308.1771906-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
which causes the code to proceed with NULL clock pointers. The current
logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
valid pointers and NULL, leading to potential NULL pointer dereference
in clk_get_rate().

Per include/linux/err.h documentation, PTR_ERR_OR_ZERO(ptr) returns:
"The error code within @ptr if it is an error pointer; 0 otherwise."

This means PTR_ERR_OR_ZERO() returns 0 for both valid pointers AND NULL
pointers. Therefore !PTR_ERR_OR_ZERO(cpu_clk) evaluates to true (proceed)
when cpu_clk is either valid or NULL, causing clk_get_rate(NULL) to be
called when of_clk_get() returns NULL.

Replace with !IS_ERR_OR_NULL(cpu_clk) which only proceeds for valid
pointers, preventing potential NULL pointer dereference in clk_get_rate().

Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities with current freq")
Cc: stable@vger.kernel.org

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v4:
- recipient list adjustment as per kernel patch review process

Changes in v3:
- Used accurate "function call properties" terminology in commit description
  (suggested by Markus Elfring)
- Added stable backport justification
- Removed duplicate marker line per kernel documentation

Changes in v2:
- Refined description based on documented macro properties (suggested by Markus Elfring)
- Added proper Fixes

 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1037169abb45..e1eff05bea4a 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -292,7 +292,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(capacity_freq_ref, cpu) =
 				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);
-- 
2.34.1


