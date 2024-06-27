Return-Path: <stable+bounces-55940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C327A91A45E
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 12:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B34286C29
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02213F014;
	Thu, 27 Jun 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3s7sgTf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899A13BC31;
	Thu, 27 Jun 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485767; cv=none; b=QjCnnGoPyepLjAE2O3m1LvKDod3sX9hWzEzB53z0G1vltnFl5Aq9NwV7XQRSBO6yjQ9x/Wddg4/24LqiID85jxmCq4XjudcwVyvs3izCgNmfBGpwtLz/6oEQRb7s15gXkIV7925l0HIDlc0v6CYVfVyAfRLY9TnA1Pg6s78qOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485767; c=relaxed/simple;
	bh=ocokHTGjuqc7YZZdHPOvJoTvSuh1UUypP3BhnXhPb9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUh1JoSZB4MQVQw9CfUImdeMp0aH2Onwynv5Dk7sXCuxUG6rtjnkGq7iyOKSS2xqjHVM1+bqX/WC+d6oyxJnzYPX1c74F5AthKMYLVUYM7+kO0wuZCeMb2nhuVYC3PV/ZPgiD/i+zhmAghnaLWIzZ+XkJRbU82IwnhObNnNydAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3s7sgTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFC0C32786;
	Thu, 27 Jun 2024 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719485767;
	bh=ocokHTGjuqc7YZZdHPOvJoTvSuh1UUypP3BhnXhPb9Q=;
	h=From:To:Cc:Subject:Date:From;
	b=N3s7sgTfiGEtCkCCsnfEdXYYeCl4LIpuZAQ2aSuzgeEKDRVJ3sfNBhkw5Ti/N8V2A
	 xGDbiPm/GAkVQUEpTrW0jK703gOKQVhRFm2J1BCk/lY7QbptCT8kXnmNMr0U9e6xUq
	 NudUsEVt/kSEFAR8MYSSG30xytY28LIXtpYtXeVd9x1veHb/tDEf2hIz99U0P5HS2r
	 fzxKWXN/95QYQdxz0r3DPvfHrj7E2xri5Aar5Va6LnkVYpR+1NUhy7KgdALsP/EWRs
	 WfS0cgOoiT2isYgNdo6aCQchoMpK4/KPGrrNNv/Uy/jTX9pRGPJSE3F8/qjp82VEY3
	 8kODuQNjuX+6Q==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	lp610mh@gmail.com,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	Alessandro Maggio <alex.tkd.alex@gmail.com>
Subject: [PATCH v2] ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial BX SSD1 models
Date: Thu, 27 Jun 2024 12:55:52 +0200
Message-ID: <20240627105551.4159447-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=cassel@kernel.org; h=from:subject; bh=ocokHTGjuqc7YZZdHPOvJoTvSuh1UUypP3BhnXhPb9Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJqXc1vn71Ufsov6TBLzYWZroUMt9iuetWt7yp0EG3a/ 5lV4XdBRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACaSksLI0BrJZvqcOUP15KIa gYk+NwynVBkb7XpwccW2qK4Plx6teMPIsOylD+esEo3NQonsrjfrc049TWKJ+REUdbHq0sW68/w nmAA=
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
Reported-by: Alessandro Maggio <alex.tkd.alex@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Picked up tags.
-Use real name in Reported-by tag.

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


