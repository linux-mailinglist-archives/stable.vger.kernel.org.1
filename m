Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAD79C057
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjIKWrn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbjIKOYN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:24:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3068EDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788A8C433C8;
        Mon, 11 Sep 2023 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442248;
        bh=vpRa5oAZ88UFx1KSM94pXMrh7Mx29kKq7yHjq2q12PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mPESp63BSH0YBIUucmwVKYrrHOWqPmHnw7aa7e1UbcMmnDHfUnaKwJN+qWMpvbsX
         e4KConRWPULooz01OMsI3HD5EdEZqcx0iTD/YUYPZYRGTNEr94xaWGw0de/nkcakxB
         tO6wUXeTD41AeFJDd65p0zCU1O3ndF3146QDjEDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.5 672/739] i3c: master: svc: fix probe failure when no i3c device exist
Date:   Mon, 11 Sep 2023 15:47:51 +0200
Message-ID: <20230911134709.874593468@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

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
@@ -789,6 +789,10 @@ static int svc_i3c_master_do_daa_locked(
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
@@ -1263,11 +1267,17 @@ static int svc_i3c_master_send_ccc_cmd(s
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


