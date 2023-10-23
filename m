Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAF7D339C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjJWLcN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjJWLcM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:32:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF3A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:32:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1CAC433C7;
        Mon, 23 Oct 2023 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060730;
        bh=J6pSaFpLYW/Ao/cABKJ4L8oU8+3LL7dOlmjPz/ucUr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWNogQh72GKDPigN7JukdXfw3sAH84ukhPQqJp/JlaODRv5Zg+y/ff79/MzwDBPi9
         vIxBJppQGqj4xmp09Sko0X2zO3hJoOv7iSa5wmRJhWumvPxhCvUJE6e0OhylGAWvd2
         rEjceV74ndMQq4bpi1/xIQ72BArl7EIv74+JS7YQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Lee, Chun-Yi" <jlee@suse.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Lee@vger.kernel.org
Subject: [PATCH 5.4 046/123] Bluetooth: hci_event: Ignore NULL link key
Date:   Mon, 23 Oct 2023 12:56:44 +0200
Message-ID: <20231023104819.266330469@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lee, Chun-Yi <jlee@suse.com>

commit 33155c4aae5260475def6f7438e4e35564f4f3ba upstream.

This change is used to relieve CVE-2020-26555. The description of the
CVE:

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

Thus, we can ignore null link key in the handler of "Link Key Notification
event" to relieve the attack. A similar implementation also shows in
btstack project. [3]

v3: Drop the connection when null link key be detected.

v2:
- Used Link: tag instead of Closes:
- Used bt_dev_dbg instead of BT_DBG
- Added Fixes: tag

Cc: stable@vger.kernel.org
Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the management interface")
Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_event.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3935,6 +3935,15 @@ static void hci_link_key_notify_evt(stru
 	if (!conn)
 		goto unlock;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR",
+			   &ev->bdaddr);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	hci_conn_hold(conn);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(conn);


