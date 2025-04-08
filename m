Return-Path: <stable+bounces-130325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B861A803A7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553BA7A6874
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650692686B9;
	Tue,  8 Apr 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvbX0wvU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3E20CCD8;
	Tue,  8 Apr 2025 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113420; cv=none; b=ucJq0xwHL+9g/XJlUEdiIFNR3lYJnrO2XDtf0cjH1BCwRxxOSzMCIBa1H+R8XOL6r+zsHNTQozsm8aPrYhH4Rbdi/gqoGYpWH4WLBiZDsp33z8ekeLMaMFlrpI30w/W0FEBfHBG8LVJ10D4dvc3CyyLFGqq3OfaXqq57C63/vEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113420; c=relaxed/simple;
	bh=H6qiwYvKq4GsYSLil7iisyLEWa6YaioZL2hnwLeB6fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHX1JEbWP5d3nr74ULCmYGZtnWG93GFKEYftj9x3vKLOoXZiZbwYiSENBGLbXy0VKexKSIEv6GNClmmYEwzGp7O+6iwl2ys3LJkVUgo08ytV+5TKab41d9LEq2O+laz/owvwJjXUwcB4DZT7GeGyNdqwxr8yQZq7jkFtvwyEv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvbX0wvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7CCC4CEE5;
	Tue,  8 Apr 2025 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113419;
	bh=H6qiwYvKq4GsYSLil7iisyLEWa6YaioZL2hnwLeB6fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvbX0wvUIZTcQFiEWve6BpKguZrvFaliibzKbB4p58eZDZzxJr4ASKlDC21g1c4ak
	 j6uC4r4PEy7WlGEIqNCSB2vU4CVUe/KRwiRgvZf6p6ugQIh6yraONVaxaVwEgXbdWV
	 SaurkVluDrTNPNQ6cV+HZiOb5DuLxm4tmV55qgLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 113/268] perf arm-spe: Fix load-store operation checking
Date: Tue,  8 Apr 2025 12:48:44 +0200
Message-ID: <20250408104831.546892932@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Yan <leo.yan@arm.com>

[ Upstream commit e1d47850bbf79a541c9b3bacdd562f5e0112274d ]

The ARM_SPE_OP_LD and ARM_SPE_OP_ST operations are secondary operation
type, they are overlapping with other second level's operation types
belonging to SVE and branch operations.  As a result, a non load-store
operation can be parsed for data source and memory sample.

To fix the issue, this commit introduces a is_ldst_op() macro for
checking LDST operation, and apply the checking when synthesize data
source and memory samples.

Fixes: a89dbc9b988f ("perf arm-spe: Set sample's data source field")
Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Link: https://lore.kernel.org/r/20250304111240.3378214-7-leo.yan@arm.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/arm-spe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index afbd5869f6bff..9848310cee5f3 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -37,6 +37,8 @@
 #include "../../arch/arm64/include/asm/cputype.h"
 #define MAX_TIMESTAMP (~0ULL)
 
+#define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
+
 struct arm_spe {
 	struct auxtrace			auxtrace;
 	struct auxtrace_queues		queues;
@@ -520,6 +522,10 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
 	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
 
+	/* Only synthesize data source for LDST operations */
+	if (!is_ldst_op(record->op))
+		return 0;
+
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
 	else if (record->op & ARM_SPE_OP_ST)
@@ -619,7 +625,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	 * When data_src is zero it means the record is not a memory operation,
 	 * skip to synthesize memory sample for this case.
 	 */
-	if (spe->sample_memory && data_src) {
+	if (spe->sample_memory && is_ldst_op(record->op)) {
 		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
 		if (err)
 			return err;
-- 
2.39.5




