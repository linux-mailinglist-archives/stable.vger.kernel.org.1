Return-Path: <stable+bounces-33926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8A893B62
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FA1281EBA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60A3F8E0;
	Mon,  1 Apr 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fzcw0T97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059F21A0A
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977776; cv=none; b=nQHkB7gkh+J+xb0x2up0UCHW5pUAplDWI+pMeRqbLmm6iip3ffE2t1Tc7PMLNZliNzQxKuGAVQPyv5UmBdhBjc2UsZPry2mFuOnmSctyty5n7NzhyVzXKaRMFLiKYx+2uPu2LsFoGlbW99FKDjKX6itGmwdnWRBfcKiE42d7iRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977776; c=relaxed/simple;
	bh=hwMmXtzhJxWUejKBzArW947a55a3WfjuExLcogAgCec=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eNsSRQx2nkTOWF9FntgfxhAkAdqijYVxoYJpxGO7aOX7O59DQ9+TYlouXQAfcPu6JdqJTKqjaH7Z9AN7IhzLhLstyWgAMaONp0AazCt4pvmCPT9yfPIU44gATi/Hugmk9A9uwIO2hbYThfdp/VRpH2H5e38Ezvye4tbMnR6egdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fzcw0T97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC10C433C7;
	Mon,  1 Apr 2024 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711977775;
	bh=hwMmXtzhJxWUejKBzArW947a55a3WfjuExLcogAgCec=;
	h=Subject:To:Cc:From:Date:From;
	b=Fzcw0T97/alBzujk7+3BTTjAYFOV0j1EDxH5dJXkFDsH86HlnkloqmoYIwaqLZS+C
	 Vh4mGTdbFYVik2E3tX7wmDC6jAJ5PHsduTeXR9pkTjbYC2L1fQzrs0vHBHOQgosVbo
	 KCU0pN/UrJv9Zz11/2XdMJv+0W0fbW22WrkjFdkA=
Subject: FAILED: patch "[PATCH] scsi: libsas: Fix disk not being scanned in after being" failed to apply to 4.19-stable tree
To: yangxingui@huawei.com,john.g.garry@oracle.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 15:22:52 +0200
Message-ID: <2024040152-bobtail-animate-4d38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8e68a458bcf5b5cb9c3624598bae28f08251601f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040152-bobtail-animate-4d38@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

8e68a458bcf5 ("scsi: libsas: Fix disk not being scanned in after being removed")
d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
7b27c5fe247b ("scsi: libsas: Stop hardcoding SAS address length")
15ba7806c316 ("scsi: libsas: Drop SAS_DPRINTK() and revise logs levels")
71a4a9923122 ("scsi: libsas: Drop sas_printk()")
d188e5db9d27 ("scsi: libsas: Use pr_fmt(fmt)")
32c850bf587f ("scsi: libsas: always unregister the old device if going to discover new")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e68a458bcf5b5cb9c3624598bae28f08251601f Mon Sep 17 00:00:00 2001
From: Xingui Yang <yangxingui@huawei.com>
Date: Thu, 7 Mar 2024 14:14:13 +0000
Subject: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed

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

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index de9dee488277..5c261005b74e 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1945,6 +1945,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *phy = &ex->ex_phy[phy_id];
 	enum sas_device_type type = SAS_PHY_UNUSED;
+	struct smp_disc_resp *disc_resp;
 	u8 sas_addr[SAS_ADDR_SIZE];
 	char msg[80] = "";
 	int res;
@@ -1956,33 +1957,41 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
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
@@ -1994,7 +2003,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 			action = ", needs recovery";
 		pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
 			 SAS_ADDR(dev->sas_addr), phy_id, action);
-		return res;
+		goto out_free_resp;
 	}
 
 	/* we always have to delete the old device when we went here */
@@ -2003,7 +2012,10 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 		SAS_ADDR(phy->attached_sas_addr));
 	sas_unregister_devs_sas_addr(dev, phy_id, last);
 
-	return sas_discover_new(dev, phy_id);
+	res = sas_discover_new(dev, phy_id);
+out_free_resp:
+	kfree(disc_resp);
+	return res;
 }
 
 /**


