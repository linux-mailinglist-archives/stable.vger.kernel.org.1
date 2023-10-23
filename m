Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0507D30D8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjJWLCx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjJWLCw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:02:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45034D7C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:02:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AA5C433C8;
        Mon, 23 Oct 2023 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058968;
        bh=aEojCat8KpQ+l/jmlbm8MDc1sXzifGFCOkg2zxFRn34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5Cocz951qwWijfcEO481m/hkb5z+wlGWmLQI7tdSsRz7sP82uLHALmUi127/lA7P
         FoF3WYmD6AEX2MONarqWMtFyeTsIXix8U/wJE/MLNQq2xI0eJeIxtZ+toCcpasjxgP
         YOG4fnfTPrkWMaQufB680ncMeod6w84BXrWx+QxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Lee, Chun-Yi" <jlee@suse.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Lee@vger.kernel.org
Subject: [PATCH 6.5 002/241] Bluetooth: Reject connection with the device which has same BD_ADDR
Date:   Mon, 23 Oct 2023 12:53:08 +0200
Message-ID: <20231023104833.899551700@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lee, Chun-Yi <jlee@suse.com>

commit 1ffc6f8cc33268731fcf9629fc4438f6db1191fc upstream.

This change is used to relieve CVE-2020-26555. The description of
the CVE:

Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
1.0B through 5.2 may permit an unauthenticated nearby device to spoof
the BD_ADDR of the peer device to complete pairing without knowledge
of the PIN. [1]

The detail of this attack is in IEEE paper:
BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
[2]

It's a reflection attack. The paper mentioned that attacker can induce
the attacked target to generate null link key (zero key) without PIN
code. In BR/EDR, the key generation is actually handled in the controller
which is below HCI.

A condition of this attack is that attacker should change the
BR_ADDR of his hacking device (Host B) to equal to the BR_ADDR with
the target device being attacked (Host A).

Thus, we reject the connection with device which has same BD_ADDR
both on HCI_Create_Connection and HCI_Connection_Request to prevent
the attack. A similar implementation also shows in btstack project.
[3][4]

Cc: stable@vger.kernel.org
Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3523 [3]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L7297 [4]
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_conn.c  |    9 +++++++++
 net/bluetooth/hci_event.c |   11 +++++++++++
 2 files changed, 20 insertions(+)

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1589,6 +1589,15 @@ struct hci_conn *hci_connect_acl(struct
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Reject outgoing connection to device with same BD ADDR against
+	 * CVE-2020-26555
+	 */
+	if (!bacmp(&hdev->bdaddr, dst)) {
+		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
+			   dst);
+		return ERR_PTR(-ECONNREFUSED);
+	}
+
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3272,6 +3272,17 @@ static void hci_conn_request_evt(struct
 
 	bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_type);
 
+	/* Reject incoming connection from device with same BD ADDR against
+	 * CVE-2020-26555
+	 */
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
+	{
+		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
+			   &ev->bdaddr);
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
+
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
 				      &flags);
 


