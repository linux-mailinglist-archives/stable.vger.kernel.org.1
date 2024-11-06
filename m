Return-Path: <stable+bounces-90275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941A9BE780
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA652846EA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE911DF24A;
	Wed,  6 Nov 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gyM3WeuG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC041DF737;
	Wed,  6 Nov 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895291; cv=none; b=Q8RQ8QLzB2ISZxBISW9Ws2NAh7tdqe7yLSHf0ZOgg/7PhsXY/jsqBBaCqdkvgEJYQYYXi2BIT6zpvBh4lUYSDxRjYe7OZN/KYWFbdbcngb8QwNznL7h6XCFTqI/27+OP9bkAk8jr8+5yGmWPZnkXvd0wXJIOVHX0WBZWXNV2ds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895291; c=relaxed/simple;
	bh=1a93myLSpzHo9k++CZiF8ni4Uvi53dPoWQUWhJv/rU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBVgbZAOCI1t37qLqSlgvHdRsY4TD5i1xKFYXAiGYP6uSWTuJiUMsxbAYs1wvaQ7QUSkvcZHIpWhHsjCFE4VYfUKZeKYMZ6t2celwOdp642LDu8DHzuu6S4wPOygzdT4oAVuA9w0SS63hwGpoqRS7RJ0300eK29ImFk7wptCQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gyM3WeuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E579AC4CECD;
	Wed,  6 Nov 2024 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895291;
	bh=1a93myLSpzHo9k++CZiF8ni4Uvi53dPoWQUWhJv/rU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyM3WeuGklJCgfevssBZCI4KDrluW+TPOZ0yTjz6O+fwnJN1Ey1hGo81L0XMu2Ni7
	 nuIf+aV7q8UUaRXtVIV1yd0kXwJoVePfBs5kDlYool1B0aevXVuelNrHXsQ1rK/MEz
	 c5Pbb5FuJWP71eUv47TRMZMw9seHgdb8F9YalRYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 167/350] ata: sata_sil: Rename sil_blacklist to sil_quirks
Date: Wed,  6 Nov 2024 13:01:35 +0100
Message-ID: <20241106120325.048719272@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 82adaf02887fb..8613a3cf2c8a5 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -144,7 +144,7 @@ static const struct pci_device_id sil_pci_tbl[] = {
 static const struct sil_drivelist {
 	const char *product;
 	unsigned int quirk;
-} sil_blacklist [] = {
+} sil_quirks[] = {
 	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
@@ -617,8 +617,8 @@ static void sil_thaw(struct ata_port *ap)
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
@@ -637,9 +637,9 @@ static void sil_dev_config(struct ata_device *dev)
 
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




