Return-Path: <stable+bounces-89978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563BF9BDC2E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCFF282D76
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148DD1DB922;
	Wed,  6 Nov 2024 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQzuS12O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DA1922DF;
	Wed,  6 Nov 2024 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859055; cv=none; b=G9mtDSwczXqAvFJvbQj4wJcfGQ9HtyS8/wqvHfp49sSlIA5mNdh/TT10vSinV9K8smoqlr+MtheRKIdYH+IRJdwbOoxIYUDNBVk1ssnMfhnGUo+EAcIrVk8sjN7MILN2zYD1IbsV+5uMXN+AV7N4lh6uBM/TOhEYFgHbVuIfEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859055; c=relaxed/simple;
	bh=TEWBpm+lf7IsNnBBoB9OWbtCVk6SgWLWwhWVyImTWTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ox/qnkv6kPh6VeCTnmtw766afz3O8XDFnCJVOCYV8/n4/apjleapqt8ZMrm+pBzKj8tpcOBxN3z0BezcdCiXQaLTjPF9ncyA1FqYH5p23psPKlGhtaYv5wV4eQbObAUVsu+30xCnwZA4iaedr9SG0lWDB2RQVy3LCiEMlJuBEG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQzuS12O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DF4C4CECF;
	Wed,  6 Nov 2024 02:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859055;
	bh=TEWBpm+lf7IsNnBBoB9OWbtCVk6SgWLWwhWVyImTWTk=;
	h=From:To:Cc:Subject:Date:From;
	b=rQzuS12OZQqQjGMrHNQRagEwCqh2xDf1X5oHDoH+5b3lSaguzQBUoxcfoEQKLFFG3
	 pCpQ+gWCGurl+reU6dT/3/P0qDNYRBGsZbiUmDRRqwSzw/Cqu2xTtK7RIXsdifmMBo
	 uEXXoLdISY6qbJNthaHx6/mIWwBpg3ZY7Bv5FSv0Wh5MA9Sv/zoDCloOwL8fQ/hvne
	 PxyU7xaiX3uvIEKyKwUuf5Vv25NKITPmWLwXq6AeFZXfrsmhRkE+1jl+Fbi7+IMsJB
	 SFF3jD4DzKNfl7U9FlnKepyo7boFKC8ngZDnKgLosfFrgeNQDlHkiCGi8T2zAN+Y1O
	 S4LHfxnv7k1Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dan.j.williams@intel.com
Cc: Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cxl/acpi: Ensure ports ready at cxl_acpi_probe() return" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:10:51 -0500
Message-ID: <20241106021052.181853-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 48f62d38a07d464a499fa834638afcfd2b68f852 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 Oct 2024 18:43:40 -0700
Subject: [PATCH] cxl/acpi: Ensure ports ready at cxl_acpi_probe() return

In order to ensure root CXL ports are enabled upon cxl_acpi_probe()
when the 'cxl_port' driver is built as a module, arrange for the
module to be pre-loaded or built-in.

The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
is merely by inspection since the bug that triggered the discovery of
this potential problem [1] is fixed by other means. However, a stable
backport should do no harm.

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://patch.msgid.link/172964781969.81806.17276352414854540808.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/acpi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 82b78e331d8ed..432b7cfd12a8e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -924,6 +924,13 @@ static void __exit cxl_acpi_exit(void)
 
 /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
 subsys_initcall(cxl_acpi_init);
+
+/*
+ * Arrange for host-bridge ports to be active synchronous with
+ * cxl_acpi_probe() exit.
+ */
+MODULE_SOFTDEP("pre: cxl_port");
+
 module_exit(cxl_acpi_exit);
 MODULE_DESCRIPTION("CXL ACPI: Platform Support");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0





