Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE17D358F
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjJWLtf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjJWLtf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:49:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF8AF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:49:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8C0C433CB;
        Mon, 23 Oct 2023 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061772;
        bh=HpsbVmY+TzZjli1gxfLhaWOusPWRnV9PCb/vgwhyNCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tz/DJj67Ba93ueUqP0R7pURouwbSvpTEJPSRu5XflxRJETNnpvPonM1mPeU9koKjo
         Z7dbxbibvuhkrZz2uudV/UmhWYGnzek1CrFMwt7Lzj3CCdCT62R3fldP9rMefpv2Je
         WANhnIziJ3pWE5xE3ajPhZcHUG5gXbI2B6RZoIp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ying Hsu <yinghsu@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 160/202] Bluetooth: Avoid redundant authentication
Date:   Mon, 23 Oct 2023 12:57:47 +0200
Message-ID: <20231023104831.180748736@linuxfoundation.org>
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

From: Ying Hsu <yinghsu@chromium.org>

[ Upstream commit 1d8e801422d66e4b8c7b187c52196bef94eed887 ]

While executing the Android 13 CTS Verifier Secure Server test on a
ChromeOS device, it was observed that the Bluetooth host initiates
authentication for an RFCOMM connection after SSP completes.
When this happens, some Intel Bluetooth controllers, like AC9560, would
disconnect with "Connection Rejected due to Security Reasons (0x0e)".

Historically, BlueZ did not mandate this authentication while an
authenticated combination key was already in use for the connection.
This behavior was changed since commit 7b5a9241b780
("Bluetooth: Introduce requirements for security level 4").
So, this patch addresses the aforementioned disconnection issue by
restoring the previous behavior.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 63 ++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f93a5ef919d1c..a9f6089a2ae2a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1435,34 +1435,41 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 	if (!test_bit(HCI_CONN_AUTH, &conn->flags))
 		goto auth;
 
-	/* An authenticated FIPS approved combination key has sufficient
-	 * security for security level 4. */
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256 &&
-	    sec_level == BT_SECURITY_FIPS)
-		goto encrypt;
-
-	/* An authenticated combination key has sufficient security for
-	   security level 3. */
-	if ((conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_AUTH_COMBINATION_P256) &&
-	    sec_level == BT_SECURITY_HIGH)
-		goto encrypt;
-
-	/* An unauthenticated combination key has sufficient security for
-	   security level 1 and 2. */
-	if ((conn->key_type == HCI_LK_UNAUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_UNAUTH_COMBINATION_P256) &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
-		goto encrypt;
-
-	/* A combination key has always sufficient security for the security
-	   levels 1 or 2. High security level requires the combination key
-	   is generated using maximum PIN code length (16).
-	   For pre 2.1 units. */
-	if (conn->key_type == HCI_LK_COMBINATION &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW ||
-	     conn->pin_length == 16))
-		goto encrypt;
+	switch (conn->key_type) {
+	case HCI_LK_AUTH_COMBINATION_P256:
+		/* An authenticated FIPS approved combination key has
+		 * sufficient security for security level 4 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_FIPS)
+			goto encrypt;
+		break;
+	case HCI_LK_AUTH_COMBINATION_P192:
+		/* An authenticated combination key has sufficient security for
+		 * security level 3 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_HIGH)
+			goto encrypt;
+		break;
+	case HCI_LK_UNAUTH_COMBINATION_P192:
+	case HCI_LK_UNAUTH_COMBINATION_P256:
+		/* An unauthenticated combination key has sufficient security
+		 * for security level 2 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM)
+			goto encrypt;
+		break;
+	case HCI_LK_COMBINATION:
+		/* A combination key has always sufficient security for the
+		 * security levels 2 or lower. High security level requires the
+		 * combination key is generated using maximum PIN code length
+		 * (16). For pre 2.1 units.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM || conn->pin_length == 16)
+			goto encrypt;
+		break;
+	default:
+		break;
+	}
 
 auth:
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
-- 
2.40.1



