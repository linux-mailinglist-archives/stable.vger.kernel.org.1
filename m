Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEFA7CA239
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjJPIrT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjJPIrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:47:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B0103
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:47:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E24C433D9;
        Mon, 16 Oct 2023 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446030;
        bh=h7nE0oc3YyK1Cpe55FOTEcDZhQq5ve6t6yTJkaRTW2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNIMCa/NPovW1OcvB+4qKdrM66eCPkogY1eHP35W/zRpUUUbvcR/5W+aHhFX+Um94
         /NqVhGAe47MThcEJ8lET2/PBENKCny7qJNAZdQextEDuZ8gzmzRMnkNp10gTOkKCmH
         BW1NCjIvJ4AQHRZtXpw0XRrcb1+jrG2K9ZLgH/Fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Werner Sembach <wse@tuxedocomputers.com>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Calvin Walton <calvin.walton@kepstin.ca>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.15 063/102] thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge
Date:   Mon, 16 Oct 2023 10:41:02 +0200
Message-ID: <20231016083955.383442721@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 582620d9f6b352552bc9a3316fe2b1c3acd8742d upstream.

On some systems the IOMMU blocks the first couple of driver ready
messages to the connection manager firmware as can be seen in below
excerpts:

  thunderbolt 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0xbb0e3400 flags=0x0020]

or

  DMAR: DRHD: handling fault status reg 2
  DMAR: [DMA Write] Request device [04:00.0] PASID ffffffff fault addr 69974000 [fault reason 05] PTE Write access is not set

The reason is unknown and hard to debug because we were not able to
reproduce this locally. This only happens on certain systems with Intel
Maple Ridge Thunderbolt controller. If there is a device connected when
the driver is loaded the issue does not happen either. Only when there
is nothing connected (so typically when the system is booted up).

We can work this around by sending the driver ready several times. After
a couple of retries the message goes through and the controller works
just fine. For this reason make the number of retries a parameter for
icm_request() and then for Maple Ridge (and Titan Ridge as they us the
same function but this should not matter) increase number of retries
while shortening the timeout accordingly.

Reported-by: Werner Sembach <wse@tuxedocomputers.com>
Reported-by: Konrad J Hambrick <kjhambrick@gmail.com>
Reported-by: Calvin Walton <calvin.walton@kepstin.ca>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214259
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/icm.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -41,6 +41,7 @@
 #define PHY_PORT_CS1_LINK_STATE_SHIFT	26
 
 #define ICM_TIMEOUT			5000	/* ms */
+#define ICM_RETRIES			3
 #define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
 
@@ -296,10 +297,9 @@ static bool icm_copy(struct tb_cfg_reque
 
 static int icm_request(struct tb *tb, const void *request, size_t request_size,
 		       void *response, size_t response_size, size_t npackets,
-		       unsigned int timeout_msec)
+		       int retries, unsigned int timeout_msec)
 {
 	struct icm *icm = tb_priv(tb);
-	int retries = 3;
 
 	do {
 		struct tb_cfg_request *req;
@@ -410,7 +410,7 @@ static int icm_fr_get_route(struct tb *t
 		return -ENOMEM;
 
 	ret = icm_request(tb, &request, sizeof(request), switches,
-			  sizeof(*switches), npackets, ICM_TIMEOUT);
+			  sizeof(*switches), npackets, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		goto err_free;
 
@@ -463,7 +463,7 @@ icm_fr_driver_ready(struct tb *tb, enum
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -488,7 +488,7 @@ static int icm_fr_approve_switch(struct
 	memset(&reply, 0, sizeof(reply));
 	/* Use larger timeout as establishing tunnels can take some time */
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -515,7 +515,7 @@ static int icm_fr_add_switch_key(struct
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -543,7 +543,7 @@ static int icm_fr_challenge_switch_key(s
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -577,7 +577,7 @@ static int icm_fr_approve_xdomain_paths(
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1022,7 +1022,7 @@ icm_tr_driver_ready(struct tb *tb, enum
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, 10, 2000);
 	if (ret)
 		return ret;
 
@@ -1055,7 +1055,7 @@ static int icm_tr_approve_switch(struct
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1083,7 +1083,7 @@ static int icm_tr_add_switch_key(struct
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1112,7 +1112,7 @@ static int icm_tr_challenge_switch_key(s
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1146,7 +1146,7 @@ static int icm_tr_approve_xdomain_paths(
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1172,7 +1172,7 @@ static int icm_tr_xdomain_tear_down(stru
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1498,7 +1498,7 @@ icm_ar_driver_ready(struct tb *tb, enum
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1524,7 +1524,7 @@ static int icm_ar_get_route(struct tb *t
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1545,7 +1545,7 @@ static int icm_ar_get_boot_acl(struct tb
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1606,7 +1606,7 @@ static int icm_ar_set_boot_acl(struct tb
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1628,7 +1628,7 @@ icm_icl_driver_ready(struct tb *tb, enum
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, ICM_RETRIES, 20000);
 	if (ret)
 		return ret;
 
@@ -2295,7 +2295,7 @@ static int icm_usb4_switch_op(struct tb_
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 


