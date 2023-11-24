Return-Path: <stable+bounces-1992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620357F824B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E2BB23B7C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6D535F04;
	Fri, 24 Nov 2023 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4sEVnA7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95934339BE;
	Fri, 24 Nov 2023 19:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1873DC433C7;
	Fri, 24 Nov 2023 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852782;
	bh=2RCne5sGsxQHx+wge2QhFIDg9ulH4CtPN0aNgxSnfUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4sEVnA7fQHgIV3DRJbuxcv+p2LyqSSb6ZsHsss5NXJvsH8Y+curBeBXm7RZLEPZa
	 MD8Mh6sgZU7fqu0XZQ8v7xgnxkqdB5pqxMawa+jKzo6WJXkc5RJWxD+HxTNuuZFLjs
	 ohjSXo1AwTgWt92CRoGmpvt5mK34iYDaXAuNNeq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nitin Yadav <n-yadav@ti.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.10 113/193] mmc: sdhci_am654: fix start loop index for TAP value parsing
Date: Fri, 24 Nov 2023 17:54:00 +0000
Message-ID: <20231124171951.764196682@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

From: Nitin Yadav <n-yadav@ti.com>

commit 71956d0cb56c1e5f9feeb4819db87a076418e930 upstream.

ti,otap-del-sel-legacy/ti,itap-del-sel-legacy passed from DT
are currently ignored for all SD/MMC and eMMC modes. Fix this
by making start loop index to MMC_TIMING_LEGACY.

Fixes: 8ee5fc0e0b3b ("mmc: sdhci_am654: Update OTAPDLY writes")
Signed-off-by: Nitin Yadav <n-yadav@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231026061458.1116276-1-n-yadav@ti.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci_am654.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -600,7 +600,7 @@ static int sdhci_am654_get_otap_delay(st
 		return 0;
 	}
 
-	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
+	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
 
 		ret = device_property_read_u32(dev, td[i].otap_binding,
 					       &sdhci_am654->otap_del_sel[i]);



