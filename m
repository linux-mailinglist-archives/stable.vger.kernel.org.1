Return-Path: <stable+bounces-55014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DF9914E5E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF431C22167
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867C13D892;
	Mon, 24 Jun 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKT/8ndL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC11311A1;
	Mon, 24 Jun 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235655; cv=none; b=En41L5/axcE03YoeZvbH46xGORrs8F5sjxfhzsCYVXd4voQywCZqyjiEDzx3nGI0qeEOgkq9GOYVFWTmjrvMVPsUlfd1d+EbCOS1zMKlPYrvxgGZfpexSdcfTo/PX4ECLShaf6mYOfXFfJr02uEYDsXXXW7oI1ito96Uc/WGnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235655; c=relaxed/simple;
	bh=1e3z6vcF3WKxRwqZHX5NVT6nTrvCoZ7drBVb62m44C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqEq4L4R2BPPnx7uf/s2cQ4QPZ/AIvDocTtrKeiiNU+Zsb5vs4J2g36Zv3uc2JpjyolxAwM0+4wYcFSmMuUBTqOi7/TDyOq16u6lUo1FLJWDMCRm0OHGKniSI5JNVO11edNwZ7avxERkDzqD8cXv5UgMAqGiVVeGveYAq6LOV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKT/8ndL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE7C32782;
	Mon, 24 Jun 2024 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719235654;
	bh=1e3z6vcF3WKxRwqZHX5NVT6nTrvCoZ7drBVb62m44C8=;
	h=From:To:Cc:Subject:Date:From;
	b=fKT/8ndLjeusD9tfkfIaW+ylRhEcT+5+h4xq9WdaJ3tWZO883yCv8jG5vFcfuRII9
	 MEJ5DyLpOcGMHepB2m1nDS/38ede3gAyoSw25nMxnoizv/kd7YEYqB7485hKmHYaAH
	 Cxk0+6UOIua6pZnjYAuZoX6wrpmMPJsxZdXD9Qjm0DeO6YpJEVi/Y3hLQMftwEggL+
	 EV/aOq/9mWAkcjHFwBW21hh3MFZgOkpQxhrgQEHSh/qC+ARoGLoiWR/5eWQ2IuXsEl
	 1W8Q5iE63mer5j3YsuQduKhN3GgvJlDSbAK9CB6Pm3xQn767/gB9Xgo9w6+jZvjilh
	 jysbVjYSaNYkA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	lp610mh@gmail.com,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	Tkd-Alex <alex.tkd.alex@gmail.com>
Subject: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial BX SSD1 models
Date: Mon, 24 Jun 2024 15:27:30 +0200
Message-ID: <20240624132729.3001688-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=cassel@kernel.org; h=from:subject; bh=1e3z6vcF3WKxRwqZHX5NVT6nTrvCoZ7drBVb62m44C8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIqSxy543ffLM7dIX+wQFOtirV9nfXB6ArG535uQUfM+ /mEPDQ7SlkYxLgYZMUUWXx/uOwv7nafclzxjg3MHFYmkCEMXJwCMJGlKxn+Byp+zbEw6v5+U+xz EVt879+kFyt37Vl+zNt0Ncfhz1YtGQx/xacEMJ89tKv5TnL7wY0i+6qX/LN+7LLf6IPdIUOF+FO SfAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

We got another report that CT1000BX500SSD1 does not work with LPM.

If you look in libata-core.c, we have six different Crucial devices that
are marked with ATA_HORKAGE_NOLPM. This model would have been the seventh.
(This quirk is used on Crucial models starting with both CT* and
Crucial_CT*)

It is obvious that this vendor does not have a great history of supporting
LPM properly, therefore, add the ATA_HORKAGE_NOLPM quirk for all Crucial
BX SSD1 models.

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Cc: stable@vger.kernel.org
Reported-by: Tkd-Alex <alex.tkd.alex@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e1bf8a19b3c8..efb5195da60c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4137,8 +4137,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
 
 	/* Crucial devices with broken LPM support */
-	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
-	{ "CT240BX500SSD1",		NULL,	ATA_HORKAGE_NOLPM },
+	{ "CT*0BX*00SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.45.2


