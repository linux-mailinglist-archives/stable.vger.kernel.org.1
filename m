Return-Path: <stable+bounces-52705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDACF90CC35
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3F61C20CF1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB015DBA7;
	Tue, 18 Jun 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeTeAkIn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F615D5D2;
	Tue, 18 Jun 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714251; cv=none; b=XjLv/6buelfTLSeMFSuVreiPu5JVF1zsmH3gn4f+jbcuANgt8zqxqEStju/RW5dpOutYRTnnnWoSdNFdAipR3HHy8PY7TmgzBlASr4NOGEfGPWxsRUM4b9Dx+30UVxirqWhXw0tCKhfQqWi0Qy2eT+5cM/U/Wntjgg/D41F6bS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714251; c=relaxed/simple;
	bh=OP710bnuoVQuM+4OPjHQIkyv8tHjclqZH/v71uWFaN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdNQ6cFeuPJBlnloClTMPEUAjAI2+PFuNtiO9Excczk7IPB37tF26lLxGc78Tb2wx0yDEk5hFdDD1xWzcacvrw4YxeUdOOBzP+dunQaNHE9C17Yu9GQFp3x67lJUIkizjzLBiu3bIION2pxo7LTNI3+xJude23fBIuQb6ujEGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeTeAkIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AC5C3277B;
	Tue, 18 Jun 2024 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714251;
	bh=OP710bnuoVQuM+4OPjHQIkyv8tHjclqZH/v71uWFaN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeTeAkInCG1Nibh2Gl2PuaBry77aQuSRnm2TPcl2qK9BBa4f2k+x43VB0B2ODUGkN
	 qhQndcLlT8xleCkAnExoTr4vdcjU2zyx892NNtkJw/QvNCGyYksgRUbfSCIwC2UWf0
	 5tjz/J0dvUCu7U6oHRtRylDZKdtrguuKWf6YNJ9R/sWsaGrSju9kdMdXGFv0Pg11HM
	 emBAhjfr8d6NzWfhMRQGAE2HuhVZaKaTmU8c1WO7grtyJm4SQs0PD0SMsZNE2yn2WQ
	 FkEgiLhPPH3AgoT/LC3UbAohiZ/Lx+3nHOrn1AfMp7Va+6E1cQ5RCtFVibQdQjMw9f
	 FNXlBxLzI+mLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Suma Hegde <suma.hegde@amd.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 33/44] platform/x86/amd/hsmp: Check HSMP support on AMD family of processors
Date: Tue, 18 Jun 2024 08:35:14 -0400
Message-ID: <20240618123611.3301370-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Suma Hegde <suma.hegde@amd.com>

[ Upstream commit 77f1972bdcf7513293e8bbe376b9fe837310ee9c ]

HSMP interface is supported only on few x86 processors from AMD.
Accessing HSMP registers on rest of the platforms might cause
unexpected behaviour. So add a check.

Also unavailability of this interface on rest of the processors
is not an error. Hence, use pr_info() instead of the pr_err() to
log the message.

Signed-off-by: Suma Hegde <suma.hegde@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Link: https://lore.kernel.org/r/20240603081512.142909-1-suma.hegde@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/hsmp.c | 50 ++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 1927be901108e..272d32a95e216 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -907,16 +907,44 @@ static int hsmp_plat_dev_register(void)
 	return ret;
 }
 
+/*
+ * This check is only needed for backward compatibility of previous platforms.
+ * All new platforms are expected to support ACPI based probing.
+ */
+static bool legacy_hsmp_support(void)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return false;
+
+	switch (boot_cpu_data.x86) {
+	case 0x19:
+		switch (boot_cpu_data.x86_model) {
+		case 0x00 ... 0x1F:
+		case 0x30 ... 0x3F:
+		case 0x90 ... 0x9F:
+		case 0xA0 ... 0xAF:
+			return true;
+		default:
+			return false;
+		}
+	case 0x1A:
+		switch (boot_cpu_data.x86_model) {
+		case 0x00 ... 0x1F:
+			return true;
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
+
+	return false;
+}
+
 static int __init hsmp_plt_init(void)
 {
 	int ret = -ENODEV;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD || boot_cpu_data.x86 < 0x19) {
-		pr_err("HSMP is not supported on Family:%x model:%x\n",
-		       boot_cpu_data.x86, boot_cpu_data.x86_model);
-		return ret;
-	}
-
 	/*
 	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
 	 * if we have N SMN/DF interfaces that ideally means N sockets
@@ -930,7 +958,15 @@ static int __init hsmp_plt_init(void)
 		return ret;
 
 	if (!plat_dev.is_acpi_device) {
-		ret = hsmp_plat_dev_register();
+		if (legacy_hsmp_support()) {
+			/* Not ACPI device, but supports HSMP, register a plat_dev */
+			ret = hsmp_plat_dev_register();
+		} else {
+			/* Not ACPI, Does not support HSMP */
+			pr_info("HSMP is not supported on Family:%x model:%x\n",
+				boot_cpu_data.x86, boot_cpu_data.x86_model);
+			ret = -ENODEV;
+		}
 		if (ret)
 			platform_driver_unregister(&amd_hsmp_driver);
 	}
-- 
2.43.0


