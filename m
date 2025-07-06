Return-Path: <stable+bounces-159963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A336AF7BE2
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3643B4E42EE
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C12E3B1A;
	Thu,  3 Jul 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CSeHJMO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354422258C;
	Thu,  3 Jul 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555929; cv=none; b=e5chNf58mYSuMzv1ALrxUDh7QioadDIXYTFeDCNs/l616nJawAsEed3PHgagN9d7GQLBTFnErmrUjbm4CdR/wGUrBLnF2z0w1JaKsEPoUN8/pU4rcHdzBcuizcu+egA25M6CS+UDGHvt7+0LQd8hlWqqAsq/SBhdM9P7xivheno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555929; c=relaxed/simple;
	bh=CuqrrYKpf09BAl+r1W9nGcwYrdYguGeaHy3DPgdCgaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twzwu81ifhRMCHwJbRY07gXhf13b9i5xoaiEJiO+UzAhyzasnnj13I0S0Lr639mL434Sw9CbUVmoHn7QNnTRpuHItAngo+6F93mPVoJNmfcHRBTw+YBvgVN4MW7rhodmnvmqWfDz2FARhJea6j+6jdRQD+fK+QM7TmXGMenFfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CSeHJMO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1EEC4CEE3;
	Thu,  3 Jul 2025 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555929;
	bh=CuqrrYKpf09BAl+r1W9nGcwYrdYguGeaHy3DPgdCgaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSeHJMO1Mn7shRJwwLNMptptICr82HGl+6/ptTNQjLe3sXxa1QhgyGdxKEEJm9X5O
	 irjRn9YtVT/RnaLKM9zlO8+WHX9WjJkMXFch2vR8hjBcoVST3mtdGSsNOwCkM0xVPe
	 2WzXblHElqXUSqRDzMkGdF2yaF6lQHqqOVPgXZaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/132] coresight: Only check bottom two claim bits
Date: Thu,  3 Jul 2025 16:41:50 +0200
Message-ID: <20250703143940.230176802@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Clark <james.clark@linaro.org>

[ Upstream commit a4e65842e1142aa18ef36113fbd81d614eaefe5a ]

The use of the whole register and == could break the claim mechanism if
any of the other bits are used in the future. The referenced doc "PSCI -
ARM DEN 0022D" also says to only read and clear the bottom two bits.

Use FIELD_GET() to extract only the relevant part.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20250325-james-coresight-claim-tags-v4-2-dfbd3822b2e5@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-core.c |    3 ++-
 drivers/hwtracing/coresight/coresight-priv.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -189,7 +189,8 @@ static int coresight_find_link_outport(s
 
 static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
 {
-	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
+	return FIELD_GET(CORESIGHT_CLAIM_MASK,
+			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
 }
 
 static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -8,6 +8,7 @@
 
 #include <linux/amba/bus.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/coresight.h>
 #include <linux/pm_runtime.h>
@@ -32,6 +33,7 @@
  * Coresight device CLAIM protocol.
  * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
  */
+#define CORESIGHT_CLAIM_MASK		GENMASK(1, 0)
 #define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
 
 #define TIMEOUT_US		100



