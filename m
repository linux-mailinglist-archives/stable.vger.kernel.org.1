Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743197A3D4B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbjIQUlG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241275AbjIQUkr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:40:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1D115
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:40:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473F7C433C8;
        Sun, 17 Sep 2023 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983240;
        bh=v7McN2ILIZvBGbn/NT91eDbi43k7lmNm7D/QZQHBAuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2ObDjCFOZM54Q/ApxQ8gKZZ52RlvFu8hCQnOZRm+ZbM9GYWwJ/6FWM4wkuPSHUpk
         Nsv9ECPVou03oHYFZ8uYABoWkjfW+8IHfQCjknCwzM5ChNzAlm6BpSOyZoGJ06Hrdl
         d86YsueKes9kzAG5zBA3x0UCtQIXIvsJs33MuL34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 485/511] pcd: move the identify buffer into pcd_identify
Date:   Sun, 17 Sep 2023 21:15:12 +0200
Message-ID: <20230917191125.448749640@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7d8b72aaddd3ec5f350d3e9988d6735a7b9b18e9 ]

No need to pass it through a bunch of functions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 1a721de8489f ("block: don't add or resize partition on the disk with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/paride/pcd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index f9cdd11f02f58..8903fdaa20466 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -630,10 +630,11 @@ static int pcd_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 	return CDS_DISC_OK;
 }
 
-static int pcd_identify(struct pcd_unit *cd, char *id)
+static int pcd_identify(struct pcd_unit *cd)
 {
-	int k, s;
 	char id_cmd[12] = { 0x12, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0 };
+	char id[18];
+	int k, s;
 
 	pcd_bufblk = -1;
 
@@ -664,15 +665,15 @@ static int pcd_identify(struct pcd_unit *cd, char *id)
  * returns  0, with id set if drive is detected
  *	    -1, if drive detection failed
  */
-static int pcd_probe(struct pcd_unit *cd, int ms, char *id)
+static int pcd_probe(struct pcd_unit *cd, int ms)
 {
 	if (ms == -1) {
 		for (cd->drive = 0; cd->drive <= 1; cd->drive++)
-			if (!pcd_reset(cd) && !pcd_identify(cd, id))
+			if (!pcd_reset(cd) && !pcd_identify(cd))
 				return 0;
 	} else {
 		cd->drive = ms;
-		if (!pcd_reset(cd) && !pcd_identify(cd, id))
+		if (!pcd_reset(cd) && !pcd_identify(cd))
 			return 0;
 	}
 	return -1;
@@ -709,7 +710,6 @@ static void pcd_probe_capabilities(void)
 
 static int pcd_detect(void)
 {
-	char id[18];
 	int k, unit;
 	struct pcd_unit *cd;
 
@@ -727,7 +727,7 @@ static int pcd_detect(void)
 		cd = pcd;
 		if (cd->disk && pi_init(cd->pi, 1, -1, -1, -1, -1, -1,
 			    pcd_buffer, PI_PCD, verbose, cd->name)) {
-			if (!pcd_probe(cd, -1, id)) {
+			if (!pcd_probe(cd, -1)) {
 				cd->present = 1;
 				k++;
 			} else
@@ -744,7 +744,7 @@ static int pcd_detect(void)
 				     conf[D_UNI], conf[D_PRO], conf[D_DLY],
 				     pcd_buffer, PI_PCD, verbose, cd->name)) 
 				continue;
-			if (!pcd_probe(cd, conf[D_SLV], id)) {
+			if (!pcd_probe(cd, conf[D_SLV])) {
 				cd->present = 1;
 				k++;
 			} else
-- 
2.40.1



