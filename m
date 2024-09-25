Return-Path: <stable+bounces-77470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66305985D8F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B98F1C20FF7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10CD1EC014;
	Wed, 25 Sep 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZuJICVj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C11B2EF6;
	Wed, 25 Sep 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265923; cv=none; b=AQ6FZrw0/h6stkCfMSpLQn6blhWB68rkpS/1cWNNyPrhE17p76H/Pw4Q8VhVLXoxjE/vEDu87ThsXx4CDBpjezfuxjfCv5jhNXLLFmnlUr9QuV2dh4gZa7PzYQqQbEpucFDtPE8Vo+4xGwL2koe0/FsGhMA33Io0UgjImQ0mLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265923; c=relaxed/simple;
	bh=PVqW7TtDbvhf11U/Tzj8Y84GMR5alsGy/6n8mfUubrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwqFOZN0FvHB0InSJfVn5Px8gLPWqG+SrqKGou9NCPrlcPQRaB3WP6gZqzGaBH/c/D0I9y0oQ6kYkNcqme3HzesWpTRbi+Jp+xE2fbO3kP+1jwRCy3cI3/p+jy943R+k/8yR42SoVjnS9O/TICqvwAWlu4UfanNrTjOTUlineh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZuJICVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBBBC4CEC3;
	Wed, 25 Sep 2024 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265923;
	bh=PVqW7TtDbvhf11U/Tzj8Y84GMR5alsGy/6n8mfUubrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZuJICVjrvpTxxo7f9VF8wQW7rDkie/4K9bB1pPV8WeSZEgeUQconWJY+iZe5+/uF
	 ycm8YlgcDUihAqzVr1Ke6vjC+/W+f63X8hc8ZcCMnwIor+VjZLgmKcooiChOedv8Xi
	 QSnt//6Vam86mrZ7JMuIMBtT4x4UiKZrCTPfQgiR2pe+DqPv8DI8Z4h/cVE70mewr7
	 7CK8LIHd/tZMx9/+YkvVtrTfMgyz4wplkj7BI7KFSU3MiXvmFA0I5qRbT7sW4op55E
	 uiOCbNtGNQz/y7lJL+FPI/QTKRY/8oFjWD3g6dCzRvPNOgdv8WwU1wtGRSjM7arJBF
	 95J0xZl5aDGSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 125/197] ata: sata_sil: Rename sil_blacklist to sil_quirks
Date: Wed, 25 Sep 2024 07:52:24 -0400
Message-ID: <20240925115823.1303019-125-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

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
index cc77c02482843..df095659bae0f 100644
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
@@ -600,8 +600,8 @@ static void sil_thaw(struct ata_port *ap)
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
@@ -620,9 +620,9 @@ static void sil_dev_config(struct ata_device *dev)
 
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


