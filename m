Return-Path: <stable+bounces-35888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3A898104
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 07:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D345CB27DFA
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 05:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219751B810;
	Thu,  4 Apr 2024 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OTlW4a1e"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB043DBBC
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712208886; cv=none; b=K2e6HmLyBDhzcJocPcTAWUumKyh0r++gpz9UzOwCAxuXN8EYyxHDzCUhebkGDbDLdt0HYB+ptvJVhBIFn+oWxvxw5kxPZR8wQupHCy6Y5dUPgMJZHyxmIwy8HblfpikTJx99hB/dS0dcRQopgHtnzVQIrhGdgiHwSE4SFwtp5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712208886; c=relaxed/simple;
	bh=WWX8HIycwcDoz5v1T7/AnGfwGw0kxkJW3X3Dh3o+8pE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ndp49s3SGSNjs0lXrcaRb7dSA3LsdcFQov9mZ/iSIoam74NGhYGCrMPK1OnlQJVZZxsWUBFUafcpNY42AHS5f38DFu121b2RjTCl2vqA0Bryx9VtvxLaJBTexFmVImr3+2AI+xA/WTUfUELs/qIzzcFs6HWNYonYBzHa5Qyw5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OTlW4a1e; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4345YTl5077873;
	Thu, 4 Apr 2024 00:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712208869;
	bh=r5Nz0eCaAzh1clXCADE3VvKOgag315tg+ksjJBlLL18=;
	h=From:To:CC:Subject:Date;
	b=OTlW4a1ekL9qrmU7Aiqoxpn+rokvbzaOAx7nM2PQ2EJ33HQAVZoQtwugkIhUVCrdK
	 L75Vw/S6KOq1McNs4quTRZnS4GFRF5iqYW8j5hr+6qx6xwu78xKYBbqAVK2a5QqgUq
	 XVkz3YU8F6gr151+oclMD8tb2mSXw1g4V0S5svIc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4345YTlQ021978
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 00:34:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 00:34:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 00:34:28 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4345YQZh004553;
	Thu, 4 Apr 2024 00:34:27 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <stable@vger.kernel.org>, <francesco@dolcini.it>
CC: <vigneshr@ti.com>, <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>
Subject: [PATCH] clk: keystone: sci-clk: Adding support for non contiguous clocks
Date: Thu, 4 Apr 2024 11:04:00 +0530
Message-ID: <20240404053400.486272-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

commit ad3ac13c6ec318b43e769cc9ffde67528e58e555 upstream.

Most of clocks and their parents are defined in contiguous range,
But in few cases, there is gap in clock numbers[0].
Driver assumes clocks to be in contiguous range, and add their clock
ids incrementally.

New firmware started returning error while calling get_freq and is_on
API for non-available clock ids.

In this fix, driver checks and adds only valid clock ids.

[0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
Section Clocks for NAVSS0_CPTS_0 Device, clock id 12-15 not present.

Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Link: https://lore.kernel.org/r/20240213082640.457316-1-u-kumar1@ti.com
Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
Patch needs manual backporting only for LTS kernel version 4.19

 drivers/clk/keystone/sci-clk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 35fe197dd303..eb2ef44869b2 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -516,6 +516,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 	struct sci_clk *sci_clk, *prev;
 	int num_clks = 0;
 	int num_parents;
+	bool state;
 	int clk_id;
 	const char * const clk_names[] = {
 		"clocks", "assigned-clocks", "assigned-clock-parents", NULL
@@ -586,6 +587,15 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 				clk_id = args.args[1] + 1;
 
 				while (num_parents--) {
+					/* Check if this clock id is valid */
+					ret = provider->ops->is_auto(provider->sci,
+						sci_clk->dev_id, clk_id, &state);
+
+					if (ret) {
+						clk_id++;
+						continue;
+					}
+
 					sci_clk = devm_kzalloc(dev,
 							       sizeof(*sci_clk),
 							       GFP_KERNEL);
-- 
2.34.1


