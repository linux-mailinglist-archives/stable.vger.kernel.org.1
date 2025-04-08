Return-Path: <stable+bounces-130857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B9BA806CF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4824C3B82
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63510263F3B;
	Tue,  8 Apr 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rp7Qbadj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155A268FD0;
	Tue,  8 Apr 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114840; cv=none; b=LUesoNIxslvJup0zXJXS8yX3Fl9lYgIBYeNtIRLFZRfnoOC7SDpEA8cSvksI/NAQor4wPa3alb2X62CzCxzMrdxosnMXttSk3fcmHM6lz4KWQJTEj0T0qBQZjRsTAp8QkmmQgUVbugtxqdTx8o6/46C5g7UMxfNsXoagLLtSkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114840; c=relaxed/simple;
	bh=nnaYLt4U2lN5XdLhQlH6kVogwMM18z3MlfYeMlxY3vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWVXm1JOMGwZozUQbRPNwHVevpbsmPb5KYEoaYOjdCszjBr7cbLOHtd6u8bq895oTd5Ucq+fNHrTbeLOdGpwg1z6N/3v+Tkc1zC639puJ4PdaQHg0YrxPln5QYjUW2fc1yt69gW+XGpBA8Rht3ppgS43w2SfJYr/rDCMWNlNIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rp7Qbadj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BAAC4CEE5;
	Tue,  8 Apr 2025 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114840;
	bh=nnaYLt4U2lN5XdLhQlH6kVogwMM18z3MlfYeMlxY3vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rp7Qbadju5e7jytxDD6qaQ4pRJxCdGHfGREu0M2/15ZkTbCde2ZsAKmd72VpTHMH+
	 puy+qoCR015QPBEqSL8cdCBS+f6XItOWEdnEVBoG9w3h4clg8MkvNh0MNXSMGrkq2r
	 CwthfkVAFGRSuwI4QkSnldw7LsfxZYCc5UB5oySI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 214/499] coresight: catu: Fix number of pages while using 64k pages
Date: Tue,  8 Apr 2025 12:47:06 +0200
Message-ID: <20250408104856.545767932@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilkka Koskinen <ilkka@os.amperecomputing.com>

[ Upstream commit 0e14e062f5ff98aa15264dfa87c5f5e924028561 ]

Trying to record a trace on kernel with 64k pages resulted in -ENOMEM.
This happens due to a bug in calculating the number of table pages, which
returns zero. Fix the issue by rounding up.

$ perf record --kcore -e cs_etm/@tmc_etr55,cycacc,branch_broadcast/k --per-thread taskset --cpu-list 1 dd if=/dev/zero of=/dev/null
failed to mmap with 12 (Cannot allocate memory)

Fixes: 8ed536b1e283 ("coresight: catu: Add support for scatter gather tables")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20250109215348.5483-1-ilkka@os.amperecomputing.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-catu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 275cc0d9f505f..3378bb77e6b41 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -269,7 +269,7 @@ catu_init_sg_table(struct device *catu_dev, int node,
 	 * Each table can address upto 1MB and we can have
 	 * CATU_PAGES_PER_SYSPAGE tables in a system page.
 	 */
-	nr_tpages = DIV_ROUND_UP(size, SZ_1M) / CATU_PAGES_PER_SYSPAGE;
+	nr_tpages = DIV_ROUND_UP(size, CATU_PAGES_PER_SYSPAGE * SZ_1M);
 	catu_table = tmc_alloc_sg_table(catu_dev, node, nr_tpages,
 					size >> PAGE_SHIFT, pages);
 	if (IS_ERR(catu_table))
-- 
2.39.5




