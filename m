Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE43379BAA0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjIKUxA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbjIKOfV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8ECF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:35:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EFCC433C7;
        Mon, 11 Sep 2023 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442917;
        bh=9PVdhk/bTlwJG2Wvl73ksfgpW/xJ31GciZBKYrGVeOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TW6vf+6Fb3FQkyPsOTr3amaUfyc5jYJNAGx5Fd5viw4t9+UbvCcy5OSYJzBgH0v4m
         gJzQZ20usVtMUe/Oqm7hoTyYVfHro/QzPGhifFynAwXa3YIGDoe//vIFstyKdLzgGX
         dVRrqB4i3yF4t0/p+1ryf4i9mFyz3iwOzcLBYORM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 194/737] Bluetooth: hci_event: Fix parsing of CIS Established Event
Date:   Mon, 11 Sep 2023 15:40:53 +0200
Message-ID: <20230911134656.014414622@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 2be22f1941d5f661aa8043261d1bae5b6696c749 ]

The ISO Interval on CIS Established Event uses 1.25 ms slots:

    BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
    page 2304:

      Time = N * 1.25 ms

In addition to that this always update the QoS settings based on CIS
Established Event.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 7f74563e6140 ("Bluetooth: ISO: do not emit new LE Create CIS if previous is pending")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 49 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cb0b5fe7a6f8c..b2b38d5014e7f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6788,6 +6788,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
+	struct bt_iso_qos *qos;
 	u16 handle = __le16_to_cpu(ev->handle);
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -6809,21 +6810,39 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (conn->role == HCI_ROLE_SLAVE) {
-		__le32 interval;
-
-		memset(&interval, 0, sizeof(interval));
-
-		memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
-		conn->iso_qos.ucast.in.interval = le32_to_cpu(interval);
-		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
-		conn->iso_qos.ucast.out.interval = le32_to_cpu(interval);
-		conn->iso_qos.ucast.in.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.ucast.out.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.ucast.in.sdu = le16_to_cpu(ev->c_mtu);
-		conn->iso_qos.ucast.out.sdu = le16_to_cpu(ev->p_mtu);
-		conn->iso_qos.ucast.in.phy = ev->c_phy;
-		conn->iso_qos.ucast.out.phy = ev->p_phy;
+	qos = &conn->iso_qos;
+
+	/* Convert ISO Interval (1.25 ms slots) to SDU Interval (us) */
+	qos->ucast.in.interval = le16_to_cpu(ev->interval) * 1250;
+	qos->ucast.out.interval = qos->ucast.in.interval;
+
+	switch (conn->role) {
+	case HCI_ROLE_SLAVE:
+		/* Convert Transport Latency (us) to Latency (msec) */
+		qos->ucast.in.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
+					  1000);
+		qos->ucast.out.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
+					  1000);
+		qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
+		qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.in.phy = ev->c_phy;
+		qos->ucast.out.phy = ev->p_phy;
+		break;
+	case HCI_ROLE_MASTER:
+		/* Convert Transport Latency (us) to Latency (msec) */
+		qos->ucast.out.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
+					  1000);
+		qos->ucast.in.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
+					  1000);
+		qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
+		qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.out.phy = ev->c_phy;
+		qos->ucast.in.phy = ev->p_phy;
+		break;
 	}
 
 	if (!ev->status) {
-- 
2.40.1



