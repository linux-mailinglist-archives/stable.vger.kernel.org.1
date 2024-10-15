Return-Path: <stable+bounces-86152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A15F99EBEC
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AFE1C2198C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF51D5ABD;
	Tue, 15 Oct 2024 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XXHvPUOn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3A1C07DF;
	Tue, 15 Oct 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997944; cv=none; b=k/IcniFrgZZQloCe9YjuuPXlN9e2ckabi65aB/UtGjYDyrEi4/dW9XxqtnUHgWtThcV3rFK6bl3uvqEaKPEZG6tjdUBvWh08JJBmIuWEHbP4SRBirGYY+Gzb4E4SR0Wc7jp9kbWWI25CPIXXmy+eC8gpyOJiR/c0m9l2KeLkjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997944; c=relaxed/simple;
	bh=PidjCc3xFaUhTYYfdmhvtD+Lq3KUh3UByPpMmQ2dE4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9Zct+YuimwT55Q+X0eQXPs+mFKiNABezXmzr8hUSQCJEGRapV2RfmwFR9nxbB5rSLT1OgzVW4EerkKwqM81ymOCQYuzmJb0DvaDbKjfDzTJLusyVrcotxlS+ziqRYFCvbCuWhFKSn1GHbHO3p6fo+oRmvpBG4i4OismCXGOjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XXHvPUOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB82C4CEC6;
	Tue, 15 Oct 2024 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997943;
	bh=PidjCc3xFaUhTYYfdmhvtD+Lq3KUh3UByPpMmQ2dE4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXHvPUOnJGyOdRaBlAwnbEvNnMqmLmXFQyz07a3fyOP94OoApLbxZUvQZdRIan4q4
	 zzFw9cswr03jAxaW9HjuvZDKctSpolkzdygj4t5JbK+W/0WNdLNqcdkF8Kk+6i81Un
	 GcTqUgv6MXhtrDgZLUKYUNQLH2jPerBXaaiG8X+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 332/518] ata: sata_sil: Rename sil_blacklist to sil_quirks
Date: Tue, 15 Oct 2024 14:43:56 +0200
Message-ID: <20241015123929.790562667@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 93b0f9e11ce511353c65b7f924cf5f95bd9c3aba ]

Rename the array sil_blacklist to sil_quirks as this name is more
neutral and is also consistent with how this driver define quirks with
the SIL_QUIRK_XXX flags.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_sil.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 75321f1ceba52..fc438c4518fb7 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -128,7 +128,7 @@ static const struct pci_device_id sil_pci_tbl[] = {
 static const struct sil_drivelist {
 	const char *product;
 	unsigned int quirk;
-} sil_blacklist [] = {
+} sil_quirks[] = {
 	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
@@ -601,8 +601,8 @@ static void sil_thaw(struct ata_port *ap)
  *	list, and apply the fixups to only the specific
  *	devices/hosts/firmwares that need it.
  *
- *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
- *	The Maxtor quirk is in the blacklist, but I'm keeping the original
+ *	20040111 - Seagate drives affected by the Mod15Write bug are quirked
+ *	The Maxtor quirk is in sil_quirks, but I'm keeping the original
  *	pessimistic fix for the following reasons...
  *	- There seems to be less info on it, only one device gleaned off the
  *	Windows	driver, maybe only one is affected.  More info would be greatly
@@ -621,9 +621,9 @@ static void sil_dev_config(struct ata_device *dev)
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	for (n = 0; sil_blacklist[n].product; n++)
-		if (!strcmp(sil_blacklist[n].product, model_num)) {
-			quirks = sil_blacklist[n].quirk;
+	for (n = 0; sil_quirks[n].product; n++)
+		if (!strcmp(sil_quirks[n].product, model_num)) {
+			quirks = sil_quirks[n].quirk;
 			break;
 		}
 
-- 
2.43.0




