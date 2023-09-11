Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9594079B701
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350862AbjIKVlx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbjIKN4t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:56:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7359910E
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:56:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E78C433C8;
        Mon, 11 Sep 2023 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440605;
        bh=FqPRaSRt/ahvt2OvH9QTY1QDA+ktWuIE/LdBW7Qrk4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEQGbekuB/SDIoysqz99ppCP2cRMFdn9B+80NJsaMk+xZb8Ky2rHBS/hujid51Czy
         occnLL12q/Y22jbBB7ASv/0i7zCecv7olZK2XarXeuAuGPD3ueVs3pkc0tSJ9SfCKJ
         EodO5HH5fdVmsYO9Y+NgUaN754iY1m5d95NDdyAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 121/739] Bluetooth: ISO: Fix not checking for valid CIG/CIS IDs
Date:   Mon, 11 Sep 2023 15:38:40 +0200
Message-ID: <20230911134654.476710350@linuxfoundation.org>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit b7f923b1ef6a2e76013089d30c9552257056360a ]

Valid range of CIG/CIS are 0x00 to 0xEF, so this checks they are
properly checked before attempting to use HCI_OP_LE_SET_CIG_PARAMS.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5db4d68c96d5c..fa3765bc8a5cd 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1216,6 +1216,12 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
 
 static bool check_ucast_qos(struct bt_iso_qos *qos)
 {
+	if (qos->ucast.cig > 0xef && qos->ucast.cig != BT_ISO_QOS_CIG_UNSET)
+		return false;
+
+	if (qos->ucast.cis > 0xef && qos->ucast.cis != BT_ISO_QOS_CIS_UNSET)
+		return false;
+
 	if (qos->ucast.sca > 0x07)
 		return false;
 
-- 
2.40.1



