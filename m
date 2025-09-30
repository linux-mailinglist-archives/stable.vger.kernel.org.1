Return-Path: <stable+bounces-182848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1618BAE2C9
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7020F327B0F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACE930CB30;
	Tue, 30 Sep 2025 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sn2TgfN+"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F430C10B
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253300; cv=none; b=IAVwIB6+1EsKyCInhH24qND8TLFVA5+R3a1IAhG9bpbBRhGP2rN6x0zq+nneVJRmxKlArvMWieVXDBrvKZudSoGeS5j0igCN+GAF8mo+gc0d/4zjrNAEQeKu7mNPBD/pIdGXF6n9e5lYw83yjVeFJdtyEgYhLxY58aF5UghnTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253300; c=relaxed/simple;
	bh=Cy3b/aZmaZLpQYUPwsbTjVFhwsOtIrwg8MTNk8I/oLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2Bj3J9EWfIQfN7wWENbeSlWjm57hLotGbnJJP94C92m6Hjygb+RT0AZiVklYqIwDdYZwv1xKetsseyIQCVi6oy8xYtyRHqnEI4NQ82K8Fu5k6/uR2MHXCkZtCuey0LZwyi3AgLcz5oEEfwa/niW0+wHZRk9ibfWRUsMMRmjwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sn2TgfN+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759253297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQG43KGfuEkFCSweP9GZSaF1gWhd8Z37kD+dlH+jfn0=;
	b=Sn2TgfN+j63Snp99WEsY7AFOYLFd+lec23J5K1v+wcyWU9PWrGgWOgiK3LQ4RSLHrAc6Xh
	jLtk6bQ+ou8C6pDLL/XUYXu1OoZbv2+1N3k3HRYvkC5sSL6avamdKtdoBBEC1PAfgOmwum
	G3qI5m9mhDosXkd396+llNAK0nX3Tjw=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 2/6] cacheinfo: Return error code in init_of_cache_level()
Date: Wed,  1 Oct 2025 01:27:27 +0800
Message-Id: <25a40240ad8a65be2c868891ef266f62b7787c3d.1759251543.git.wen.yang@linux.dev>
In-Reply-To: <cover.1759251543.git.wen.yang@linux.dev>
References: <cover.1759251543.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit 8844c3df001bc1d8397fddea341308da63855d53 ]
Make init_of_cache_level() return an error code when the cache
information parsing fails to help detecting missing information.

init_of_cache_level() is only called for riscv. Returning an error
code instead of 0 will prevent detect_cache_attributes() to allocate
memory if an incomplete DT is parsed.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230104183033.755668-3-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/base/cacheinfo.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 7663eaddd168..480007210bcc 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -245,11 +245,11 @@ int init_of_cache_level(unsigned int cpu)
 		of_node_put(prev);
 		prev = np;
 		if (!of_device_is_compatible(np, "cache"))
-			break;
+			goto err_out;
 		if (of_property_read_u32(np, "cache-level", &level))
-			break;
+			goto err_out;
 		if (level <= levels)
-			break;
+			goto err_out;
 		if (of_property_read_bool(np, "cache-size"))
 			++leaves;
 		if (of_property_read_bool(np, "i-cache-size"))
@@ -264,6 +264,10 @@ int init_of_cache_level(unsigned int cpu)
 	this_cpu_ci->num_leaves = leaves;
 
 	return 0;
+
+err_out:
+	of_node_put(np);
+	return -EINVAL;
 }
 
 #else
-- 
2.25.1


