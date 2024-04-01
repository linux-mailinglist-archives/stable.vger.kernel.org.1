Return-Path: <stable+bounces-35182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A574A8942C9
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A31F26A97
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47A481D7;
	Mon,  1 Apr 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eNtffWgP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A72EB0B;
	Mon,  1 Apr 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990567; cv=none; b=ObDfdZLy1TD++h3EMoGhWnnmas3yV53p9fu4oFogz4RtzgCvc66H6l+XTr3ppbs738R7r/twAVvlQ9NHm8BdFUbxCkIZfscTH1nCpjoEootxeLyES466gzmJpzcx8T0Rw2HVGaICmglmYKfC8GJcnC9ZMwyeTTtZWTsaJhdyX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990567; c=relaxed/simple;
	bh=s58ct+hF5ud/BVRZ9ZsKLbq//S2/mH9wjITzR/v28Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyI0BtLC3DeoctBNKp4uqf/ZQrRUGIV1YCM27u4LtytjiYr+tTKZcV7R0Gs2OZOsnAL+X81RKTma5zHzJyIFWlatED/KQHH52uxZ1oFz5Y5fADvbXlCMIsgfwWSio1RXhdoVlbPLjNyWgbtN1m9S9QyCupk21/aG62NwmZO/0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eNtffWgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA2DC433C7;
	Mon,  1 Apr 2024 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990567;
	bh=s58ct+hF5ud/BVRZ9ZsKLbq//S2/mH9wjITzR/v28Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNtffWgP09SOzjQa3m5CW5rsh+DOojsOqApaiTpkq46f6+X/50hu59nRbKeOqsFuE
	 TCpwgr+yYOhuA3pbJ4UIRYoqCsx8C2nLJRZRRk1/6l7wPNZsoLuinyCxZhp1D0OGzC
	 VSXRJ9wsR4e5ofDDDx5rgR1AgjQEwJUt04lux1Y0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 394/396] scsi: libsas: Fix disk not being scanned in after being removed
Date: Mon,  1 Apr 2024 17:47:23 +0200
Message-ID: <20240401152559.655820243@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xingui Yang <yangxingui@huawei.com>

commit 8e68a458bcf5b5cb9c3624598bae28f08251601f upstream.

As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
update PHY info"), do discovery will send a new SMP_DISCOVER and update
phy->phy_change_count. We found that if the disk is reconnected and phy
change_count changes at this time, the disk scanning process will not be
triggered.

Therefore, call sas_set_ex_phy() to update the PHY info with the results of
the last query. And because the previous phy info will be used when calling
sas_unregister_devs_sas_addr(), sas_unregister_devs_sas_addr() should be
called before sas_set_ex_phy().

Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Link: https://lore.kernel.org/r/20240307141413.48049-3-yangxingui@huawei.com
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libsas/sas_expander.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1945,6 +1945,7 @@ static int sas_rediscover_dev(struct dom
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *phy = &ex->ex_phy[phy_id];
 	enum sas_device_type type = SAS_PHY_UNUSED;
+	struct smp_disc_resp *disc_resp;
 	u8 sas_addr[SAS_ADDR_SIZE];
 	char msg[80] = "";
 	int res;
@@ -1956,33 +1957,41 @@ static int sas_rediscover_dev(struct dom
 		 SAS_ADDR(dev->sas_addr), phy_id, msg);
 
 	memset(sas_addr, 0, SAS_ADDR_SIZE);
-	res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
+	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
+	if (!disc_resp)
+		return -ENOMEM;
+
+	res = sas_get_phy_discover(dev, phy_id, disc_resp);
 	switch (res) {
 	case SMP_RESP_NO_PHY:
 		phy->phy_state = PHY_NOT_PRESENT;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		return res;
+		goto out_free_resp;
 	case SMP_RESP_PHY_VACANT:
 		phy->phy_state = PHY_VACANT;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		return res;
+		goto out_free_resp;
 	case SMP_RESP_FUNC_ACC:
 		break;
 	case -ECOMM:
 		break;
 	default:
-		return res;
+		goto out_free_resp;
 	}
 
+	if (res == 0)
+		sas_get_sas_addr_and_dev_type(disc_resp, sas_addr, &type);
+
 	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
 		phy->phy_state = PHY_EMPTY;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
 		/*
-		 * Even though the PHY is empty, for convenience we discover
-		 * the PHY to update the PHY info, like negotiated linkrate.
+		 * Even though the PHY is empty, for convenience we update
+		 * the PHY info, like negotiated linkrate.
 		 */
-		sas_ex_phy_discover(dev, phy_id);
-		return res;
+		if (res == 0)
+			sas_set_ex_phy(dev, phy_id, disc_resp);
+		goto out_free_resp;
 	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
 		   dev_type_flutter(type, phy->attached_dev_type)) {
 		struct domain_device *ata_dev = sas_ex_to_ata(dev, phy_id);
@@ -1994,7 +2003,7 @@ static int sas_rediscover_dev(struct dom
 			action = ", needs recovery";
 		pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
 			 SAS_ADDR(dev->sas_addr), phy_id, action);
-		return res;
+		goto out_free_resp;
 	}
 
 	/* we always have to delete the old device when we went here */
@@ -2003,7 +2012,10 @@ static int sas_rediscover_dev(struct dom
 		SAS_ADDR(phy->attached_sas_addr));
 	sas_unregister_devs_sas_addr(dev, phy_id, last);
 
-	return sas_discover_new(dev, phy_id);
+	res = sas_discover_new(dev, phy_id);
+out_free_resp:
+	kfree(disc_resp);
+	return res;
 }
 
 /**



