Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368287D358D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjJWLtd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjJWLt3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:49:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C9F5
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:49:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D41C433C8;
        Mon, 23 Oct 2023 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061767;
        bh=CSlHwl3t7kbx4FTd9HY1HYKuKV+RWZBzBbThpBj1UAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrNHcudMfdziAueMV1W0mW4CbsXk9QU9NLt76XhFDGAFRiPHrtazsBNMWsVmp1UgO
         LW1/xBcE7+8LgZ/T53x8ExCjseGb5nBgrBqwbzuU6mjd70H/Yfdbhk6YyYIWc7cU0B
         qLQIqg63s/GQl0hsRBWAr/hZpN/9K4z7DVnLKegk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Werner Sembach <wse@tuxedocomputers.com>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Calvin Walton <calvin.walton@kepstin.ca>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 121/202] thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge
Date:   Mon, 23 Oct 2023 12:57:08 +0200
Message-ID: <20231023104830.067979336@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 582620d9f6b352552bc9a3316fe2b1c3acd8742d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/icm.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index b2fb3397310e4..90f1d9a534614 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -41,6 +41,7 @@
 #define PHY_PORT_CS1_LINK_STATE_SHIFT	26
 
 #define ICM_TIMEOUT			5000	/* ms */
+#define ICM_RETRIES			3
 #define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
 
@@ -280,10 +281,9 @@ static bool icm_copy(struct tb_cfg_request *req, const struct ctl_pkg *pkg)
 
 static int icm_request(struct tb *tb, const void *request, size_t request_size,
 		       void *response, size_t response_size, size_t npackets,
-		       unsigned int timeout_msec)
+		       int retries, unsigned int timeout_msec)
 {
 	struct icm *icm = tb_priv(tb);
-	int retries = 3;
 
 	do {
 		struct tb_cfg_request *req;
@@ -394,7 +394,7 @@ static int icm_fr_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 		return -ENOMEM;
 
 	ret = icm_request(tb, &request, sizeof(request), switches,
-			  sizeof(*switches), npackets, ICM_TIMEOUT);
+			  sizeof(*switches), npackets, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		goto err_free;
 
@@ -447,7 +447,7 @@ icm_fr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -472,7 +472,7 @@ static int icm_fr_approve_switch(struct tb *tb, struct tb_switch *sw)
 	memset(&reply, 0, sizeof(reply));
 	/* Use larger timeout as establishing tunnels can take some time */
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -499,7 +499,7 @@ static int icm_fr_add_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -527,7 +527,7 @@ static int icm_fr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -559,7 +559,7 @@ static int icm_fr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -996,7 +996,7 @@ icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, 10, 2000);
 	if (ret)
 		return ret;
 
@@ -1026,7 +1026,7 @@ static int icm_tr_approve_switch(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1054,7 +1054,7 @@ static int icm_tr_add_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1083,7 +1083,7 @@ static int icm_tr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1115,7 +1115,7 @@ static int icm_tr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1141,7 +1141,7 @@ static int icm_tr_xdomain_tear_down(struct tb *tb, struct tb_xdomain *xd,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1460,7 +1460,7 @@ icm_ar_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1486,7 +1486,7 @@ static int icm_ar_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1507,7 +1507,7 @@ static int icm_ar_get_boot_acl(struct tb *tb, uuid_t *uuids, size_t nuuids)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1568,7 +1568,7 @@ static int icm_ar_set_boot_acl(struct tb *tb, const uuid_t *uuids,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1590,7 +1590,7 @@ icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, ICM_RETRIES, 20000);
 	if (ret)
 		return ret;
 
-- 
2.40.1



