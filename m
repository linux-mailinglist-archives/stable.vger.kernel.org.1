Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847D379B32A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355425AbjIKV6I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbjIKN5M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:57:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4504ACD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:57:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C572C433C9;
        Mon, 11 Sep 2023 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440627;
        bh=ThiveC0KvlKmmG5kV4euqLhr0V5Ca7dahHZpsxVQmBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2Cehj2MswLvA7x4n+JOGCM2kdAg1HiRQ6potLmHe86QvHE5qlYH1sd91Nqdzi2RV
         Nvxvbk7JIRdx0DiuGIj2l7mS0WoFJ+PtXvuqaYt1pv22s3Sg51ajD+cjzv1fSuUztl
         2uuxQJbQURtHrEr0cS0IjUuO/fmil6m++faDEWyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 128/739] Bluetooth: hci_event: drop only unbound CIS if Set CIG Parameters fails
Date:   Mon, 11 Sep 2023 15:38:47 +0200
Message-ID: <20230911134654.663186136@linuxfoundation.org>
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

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 66dee21524d9ac6461ec3052652b7bc0603ee0c5 ]

When user tries to connect a new CIS when its CIG is not configurable,
that connection shall fail, but pre-existing connections shall not be
affected.  However, currently hci_cc_le_set_cig_params deletes all CIS
of the CIG on error so it doesn't work, even though controller shall not
change CIG/CIS configuration if the command fails.

Fix by failing on command error only the connections that are not yet
bound, so that we keep the previous CIS configuration like the
controller does.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bdacfcd7082de..c02a7ac6de39c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3803,6 +3803,22 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static void hci_unbound_cis_failed(struct hci_dev *hdev, u8 cig, u8 status)
+{
+	struct hci_conn *conn, *tmp;
+
+	lockdep_assert_held(&hdev->lock);
+
+	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
+		if (conn->type != ISO_LINK || !bacmp(&conn->dst, BDADDR_ANY) ||
+		    conn->state == BT_OPEN || conn->iso_qos.ucast.cig != cig)
+			continue;
+
+		if (HCI_CONN_HANDLE_UNSET(conn->handle))
+			hci_conn_failed(conn, status);
+	}
+}
+
 static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
@@ -3824,12 +3840,15 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E page 2554
+	 *
+	 * If the Status return parameter is non-zero, then the state of the CIG
+	 * and its CIS configurations shall not be changed by the command. If
+	 * the CIG did not already exist, it shall not be created.
+	 */
 	if (status) {
-		while ((conn = hci_conn_hash_lookup_cig(hdev, rp->cig_id))) {
-			conn->state = BT_CLOSED;
-			hci_connect_cfm(conn, status);
-			hci_conn_del(conn);
-		}
+		/* Keep current configuration, fail only the unbound CIS */
+		hci_unbound_cis_failed(hdev, rp->cig_id, status);
 		goto unlock;
 	}
 
-- 
2.40.1



