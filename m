Return-Path: <stable+bounces-51924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD13907240
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA7A1F2171B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9456458;
	Thu, 13 Jun 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJ2wXVld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5BC17FD;
	Thu, 13 Jun 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282716; cv=none; b=upQKs3dMEdGQOdhm35IbWVE/iUQdKjukAGfqgkb6TZStwUFAIOkpDC0YOJS5UefedsexsZOoCjgq5LfKix/uBu9jIsBTOWk3C6cfERNf1GiCJpB9pQrFkrvq8WlyDjLsVc939DPsIfPDRZWIpzBErxwfgzDAx+95fjeSKC4HzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282716; c=relaxed/simple;
	bh=DXHTB8tj2MqZgW7QRWOWtG0HsduzSX7dIdo6cfqrfwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syRA7LcoRe99Zovi/VXyFpK2ocb1fCBrwlRnNbs8P3oTwnm/x9vXV9YZ2OAfsU1xUX92XeUFH193bQqksEPmDYRkpUDYEUR70HLnJ6Pp9liTN5adaNnYdOX5SG6qx7M+GAAGqOjYTW29Q4eI/gzcAXSujXEfG0/rPdymhCmNUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJ2wXVld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539F7C2BBFC;
	Thu, 13 Jun 2024 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282716;
	bh=DXHTB8tj2MqZgW7QRWOWtG0HsduzSX7dIdo6cfqrfwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJ2wXVldzT7aer5Z1mYnKx5+rBo9H0Jd5biW3fg5jkQg6B3aBPiqYYZMJlU2WvGMP
	 ar+pPLPf5kAb9dpnW3xW68fSBB4dQgcop8O199JpEAWNWL6G5emmVT4OwwBx1o1jqE
	 Jgc1bk44BTxopJizXkS7Fucj/mylEt3tTd5J3U4k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 371/402] mmc: sdhci-acpi: Sort DMI quirks alphabetically
Date: Thu, 13 Jun 2024 13:35:28 +0200
Message-ID: <20240613113316.608714434@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit a92a73b1d9249d155412d8ac237142fa716803ea upstream.

Sort the DMI quirks alphabetically.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240410191639.526324-4-hdegoede@redhat.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-acpi.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -795,9 +795,22 @@ static const struct acpi_device_id sdhci
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
+/* Please keep this list sorted alphabetically */
 static const struct dmi_system_id sdhci_acpi_quirks[] = {
 	{
 		/*
+		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
+		 * reports the card being write-protected even though microSD
+		 * cards do not have a write-protect switch at all.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
+	{
+		/*
 		 * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
 		 * the SHC1 ACPI device, this bug causes it to reprogram the
 		 * wrong LDO (DLDO3) to 1.8V if 1.8V modes are used and the
@@ -812,18 +825,6 @@ static const struct dmi_system_id sdhci_
 	},
 	{
 		/*
-		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
-		 * reports the card being write-protected even though microSD
-		 * cards do not have a write-protect switch at all.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
-		},
-		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
-	},
-	{
-		/*
 		 * The Toshiba WT8-B's microSD slot always reports the card being
 		 * write-protected.
 		 */



