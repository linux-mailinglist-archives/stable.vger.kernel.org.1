Return-Path: <stable+bounces-183685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F143BC8D5E
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B63E7BE2
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C191F3FE2;
	Thu,  9 Oct 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="Oya/88nz"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1122.securemx.jp [210.130.202.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28062A1CA
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009703; cv=none; b=E2RbjhXmagdn2pSWFV/ZRde0u9BP56XyROjx/SMMEQ8TjEVcIhb9Wnm0JPHCtWunrq614X7H0Tq1Tep0wiUriAlb6GbqNMmA4d8WxZK4Sp1Mn/Wox7eZthV+1IXkkvXDbJZCtvjROK+yFKEo02A3wiYJEYdWW7HdiZ4JEgeG/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009703; c=relaxed/simple;
	bh=XIZONmzgg9hE/QMIfFBqq5Qc+pn+2ZDaiYR/r+q2zWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nghZza9aMxO1BIr+A8UTLo3lgmO+A4+nr1VTUPlTAJimfMatR72w/tYgUpsCuFEgifn3oe+of1KQD9u/Vw65RFCiDz8pDthAFJoty9FBSD/yoyWGFbxWX9bIzuE/xFLTYxxa1ukay77glBT7PEW+9ndY+PZT0OnK3UKcGILnE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=Oya/88nz; arc=none smtp.client-ip=210.130.202.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 5998FYLL3355056; Thu, 9 Oct 2025 17:15:42 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1759997709;x=1761207309;bh=
	XIZONmzgg9hE/QMIfFBqq5Qc+pn+2ZDaiYR/r+q2zWo=;b=Oya/88nzhqKxBF9L832o65N4B2TWFV
	yXkRchea6Qge8JTMCSTlDFUOO2j2WUJp8+y2qneM18tKtjXVOX5McsikcFYNwRPDuCRjJp7p8ANmb
	Oa6MDrGF0eOPDG3gQGMzhJr+JnHQtuoKtwhVpSNx3SH/J3H1QVaaq4svsJy0L72MP9RRgI0t5e3SN
	B7iCoN8MVH711MzW7QsJzMUWMIouiU13Rb0bRQhZQHMyq7b9smjCWDYRAqAzDT/xzxxgG4yTqjlw6
	CwT3aaeE9xbt08iPvaoJY3iMEr8/N4w+dhdHx6h0TjdP8L8XHs2KOO6DFwybe3RTGD+3HexUC6R1b
	z4jA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5998F8Ul2414734; Thu, 9 Oct 2025 17:15:08 +0900
X-Iguazu-Qid: 2rWhqFKk7rwnP0jIro
X-Iguazu-QSIG: v=2; s=0; t=1759997708; q=2rWhqFKk7rwnP0jIro; m=oSCVMdv+VMTtV+oQLnzu4yznINdTyh6QafBpwwjtUDo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cj2jm1XT3z4vym; Thu,  9 Oct 2025 17:15:08 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH for 5.15] platform/x86: int3472: Check for adev == NULL
Date: Thu,  9 Oct 2025 17:15:04 +0900
X-TSB-HOP2: ON
Message-Id: <1759997704-14581-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

commit cd2fd6eab480dfc247b737cf7a3d6b009c4d0f1c upstream.

Not all devices have an ACPI companion fwnode, so adev might be NULL. This
can e.g. (theoretically) happen when a user manually binds one of
the int3472 drivers to another i2c/platform device through sysfs.

Add a check for adev not being set and return -ENODEV in that case to
avoid a possible NULL pointer deref in skl_int3472_get_acpi_buffer().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20241209220522.25288-1-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[iwamatsu: adjusted context]
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/platform/x86/intel/int3472/discrete.c | 3 +++
 drivers/platform/x86/intel/int3472/tps68470.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 401fa8f223d622..31494f4247864e 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -345,6 +345,9 @@ static int skl_int3472_discrete_probe(struct platform_device *pdev)
 	struct int3472_cldb cldb;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	ret = skl_int3472_fill_cldb(adev, &cldb);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't fill CLDB structure\n");
diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index fd3bef449137cf..b3faae7b23736a 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -102,6 +102,9 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	int device_type;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
-- 
2.51.0



