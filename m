Return-Path: <stable+bounces-67570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A89511F1
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5060F282A45
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4BC381D4;
	Wed, 14 Aug 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+4qNn0+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8337144;
	Wed, 14 Aug 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601698; cv=none; b=TxWQWJRjMvtJQnn3xhAQSBDpEk7syNyni6eMBKf1KGbpc4inj6Yaimf7gHVunkmrsJOguWVuBJyMqUaOy1Yn3O3BdXjmijqGEhnCpy4DJiwqWqgOXzicRSpkTKIDmgx9Gl5UjdxRirr8bVaGbweLgjT9pahtInx25eQXeMVnhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601698; c=relaxed/simple;
	bh=VzmGJH4SqMfikXDzPrfWUxPLuJvhYGWU2jsK4t3Pu+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/u/A6OrxgSiJDYoj/BEV4x613MQWjbAYk2rG0Gf+Xua0DaHqZ5rsdD1K8LzeAXqHTtb8+BUSyBoFS2CVhXvduUx8WSGO/erutrx5X7RPjGITwfpuIfLrLmroJwcewejWQYFHoMFW/IhMxNkHhS74qoPz/cTq1NOBnDM+7MalxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+4qNn0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4451CC4AF0E;
	Wed, 14 Aug 2024 02:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601698;
	bh=VzmGJH4SqMfikXDzPrfWUxPLuJvhYGWU2jsK4t3Pu+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+4qNn0+EoqXhnMJY3sDrQEmeySJ1twd/WYogZP+H21fyjk1DuccNJDxHsLDacInc
	 ykl8IZ2XuordpDnYPc1V/x+jY1jTPTRBej8wqXahXML6b3IGoiT8VnNrBStXiBwEJe
	 BkojA1LhGc3nn+S6JOykzHV9lr8wQ+kx9W2NlmN+4St0PMQh9gX0R+yySrAa0+DgtB
	 iGIcjmL+1pvHBWfPQ0ZWQgPndHbo8N49ztJOyq0v/HGXKcTKCSj6mB+ePMeHEzCW8s
	 UeIFacWRY7eBTkPfOdlmoT+KFNlAN/gOinrk5ci/zHrvDx3SlDvzlQ+IYz069uwMzQ
	 eJGxfjtaHAPpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 04/13] platform/x86/amd/pmf: Add new ACPI ID AMDI0107
Date: Tue, 13 Aug 2024 22:14:35 -0400
Message-ID: <20240814021451.4129952-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit 942810c0e89277d738b7f1b6f379d0a5877999f6 ]

Add new ACPI ID AMDI0107 used by upcoming AMD platform to the PMF
supported list of devices.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20240723132451.3488326-1-Shyam-sundar.S-k@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 2d6e2558863c5..8f1f719befa3e 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -41,6 +41,7 @@
 #define AMD_CPU_ID_RMB			0x14b5
 #define AMD_CPU_ID_PS			0x14e8
 #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT	0x1507
+#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT	0x1122
 
 #define PMF_MSG_DELAY_MIN_US		50
 #define RESPONSE_REGISTER_LOOP_MAX	20000
@@ -249,6 +250,7 @@ static const struct pci_device_id pmf_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RMB) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_PS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
 	{ }
 };
 
@@ -382,6 +384,7 @@ static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0102", 0},
 	{"AMDI0103", 0},
 	{"AMDI0105", 0},
+	{"AMDI0107", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
-- 
2.43.0


