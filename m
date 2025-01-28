Return-Path: <stable+bounces-110922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ECBA20288
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 01:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93677A04CC
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 00:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2085423BB;
	Tue, 28 Jan 2025 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="beU6vS3c"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7BBE40
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023497; cv=none; b=Px8IRqbT0HZV8qve0yhP6KsJbauBUtf6bESZynhGv5XRQHxw6iEMcxU3BrgB1ME+oXLs2oURW1M0ASEoHzgslwNfbuavSVmGqqIBJa7a5UTXcyGWKv42cDda6EqkbdT6b3Q2Ek0+TkgCMXu1jXcqIz5ACMUTIPB+mp5sd/5x/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023497; c=relaxed/simple;
	bh=wpndlb7UHHc3e2B1Lgm2UlMNmFdkTD9hEnAmwHCzwdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0Od8rG+tMyGtRcy5yqcd1MXMxfH0e1p5ZtJr94KuyGXBuVRwFUZbx2LFrybH9DYndf/zSJZmC3ISsvq+4n9YvYHHNn9hGllseXh4bCg87eGMe57VMkfwuqS2hSObe6+a3naGwFULLyWnEidQasHBt8veZvvbCGDYLFPMeoda2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=beU6vS3c; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738023478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aj8XDJDRrLpKv2EqPYDzMbVxZZ1cx8RY7GFt/SLk8Vw=;
	b=beU6vS3cNEuyQL3B+xtsVcRI0hzOTXuhi3dYC0RRXyNVmkC9RQlcZzg0+BOZhDhdNOha7o
	9qRNW3+XQ10BUuUsw6zkDZ7qdzIP1Vwg+PpFVuEfA+HBNJ7gtRSQ5Dm/PeCPDc5zN83git
	obwH0WdNZSvCObCoTpSrzSRYLiQRkLo=
From: Oliver Upton <oliver.upton@linux.dev>
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: GTDT: Relax sanity checking on Platform Timers array count
Date: Tue, 28 Jan 2025 00:17:49 +0000
Message-ID: <20250128001749.3132656-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Perhaps unsurprisingly there are some platforms where the GTDT isn't
quite right and the Platforms Timer array overflows the length of the
overall table.

While the recently-added sanity checking isn't wrong, it makes it
impossible to boot the kernel on offending platforms. Try to hobble
along and limit the Platform Timer count to the bounds of the table.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Zheng Zengkai <zhengzengkai@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 263e22d6bd1f ("ACPI: GTDT: Tighten the check for the array of platform timer structures")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/acpi/arm64/gtdt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 3561553eff8b..70f8290b659d 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -163,7 +163,7 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 {
 	void *platform_timer;
 	struct acpi_table_gtdt *gtdt;
-	int cnt = 0;
+	u32 cnt = 0;
 
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
 	acpi_gtdt_desc.gtdt = gtdt;
@@ -188,13 +188,17 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 		cnt++;
 
 	if (cnt != gtdt->platform_timer_count) {
+		cnt = min(cnt, gtdt->platform_timer_count);
+		pr_err(FW_BUG "limiting Platform Timer count to %d\n", cnt);
+	}
+
+	if (!cnt) {
 		acpi_gtdt_desc.platform_timer = NULL;
-		pr_err(FW_BUG "invalid timer data.\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	if (platform_timer_count)
-		*platform_timer_count = gtdt->platform_timer_count;
+		*platform_timer_count = cnt;
 
 	return 0;
 }

base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.48.1.262.g85cc9f2d1e-goog


