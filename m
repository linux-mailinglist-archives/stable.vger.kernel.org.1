Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242AD7A3C9B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbjIQUdK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241177AbjIQUcz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:32:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EF1CCE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:32:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927F9C433C8;
        Sun, 17 Sep 2023 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982755;
        bh=K44H1wk9Vd1L+9n9AGRa04th3NlKgC/dsyVzKUcNggc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nq0art5z2GJeq5b51/iTiZu3FCLUdhHhtLttAwOcb9dHAV54wJsLkwooSlKbCSaz2
         YQu3TLKSh52kLutN2UGTpugFBanFmG6oTs0j02qFi2CVKydtcMx53W9+YqDVqcppOV
         z8U4NRSzqiV5G3MMXids8oGVvlD8zDoV4ASYh9eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.15 336/511] i3c: master: svc: fix probe failure when no i3c device exist
Date:   Sun, 17 Sep 2023 21:12:43 +0200
Message-ID: <20230917191121.927792757@linuxfoundation.org>
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

From: Frank Li <Frank.Li@nxp.com>

commit 6e13d6528be2f7e801af63c8153b87293f25d736 upstream.

I3C masters are expected to support hot-join. This means at initialization
time we might not yet discover any device and this should not be treated
as a fatal error.

During the DAA procedure which happens at probe time, if no device has
joined, all CCC will be NACKed (from a bus perspective). This leads to an
early return with an error code which fails the probe of the master.

Let's avoid this by just telling the core through an I3C_ERROR_M2
return command code that no device was discovered, which is a valid
situation. This way the master will no longer bail out and fail to probe
for a wrong reason.

Cc: stable@vger.kernel.org
Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20230831141324.2841525-1-Frank.Li@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/master/svc-i3c-master.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -723,6 +723,10 @@ static int svc_i3c_master_do_daa_locked(
 				 */
 				break;
 			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
+				/* No I3C devices attached */
+				if (dev_nb == 0)
+					break;
+
 				/*
 				 * A slave device nacked the address, this is
 				 * allowed only once, DAA will be stopped and
@@ -1152,11 +1156,17 @@ static int svc_i3c_master_send_ccc_cmd(s
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	bool broadcast = cmd->id < 0x80;
+	int ret;
 
 	if (broadcast)
-		return svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
+		ret = svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
 	else
-		return svc_i3c_master_send_direct_ccc_cmd(master, cmd);
+		ret = svc_i3c_master_send_direct_ccc_cmd(master, cmd);
+
+	if (ret)
+		cmd->err = I3C_ERROR_M2;
+
+	return ret;
 }
 
 static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,


