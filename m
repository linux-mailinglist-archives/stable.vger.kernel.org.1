Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7979B5B0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351116AbjIKVmq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjIKN4w (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:56:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4048310E
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:56:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0BEC433C7;
        Mon, 11 Sep 2023 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440607;
        bh=QxihB0PtO90yK4bvQasqjfHyOKxnR3iGBcmjrGourCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfPZIO9QJa8U8Leskgs7lVv0zFBApNmBu85Ih/aPX9oSnansCNq29513Z0sLZzAwD
         br/msPV4hJO1q3HAGKiXmeSambaK3BecHVkOBEIrlDqN620QDVwzBBlf2c2zJxjAlC
         dic+Vp/0YhFtCd98jpuVj31uTwwjJwYdsw+cL+9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 122/739] Bluetooth: hci_conn: Fix not allowing valid CIS ID
Date:   Mon, 11 Sep 2023 15:38:41 +0200
Message-ID: <20230911134654.503221546@linuxfoundation.org>
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

[ Upstream commit f2f84a70f9d0c9a3263194ca9d82e7bc6027d356 ]

Only the number of CIS shall be limited to 0x1f, the CIS ID in the
other hand is up to 0xef.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4b5223e62141c..b338e2585144e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1862,9 +1862,12 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 		cis_add(&data, qos);
 	}
 
-	/* Reprogram all CIS(s) with the same CIG */
-	for (data.cig = qos->ucast.cig, data.cis = 0x00; data.cis < 0x11;
-	     data.cis++) {
+	/* Reprogram all CIS(s) with the same CIG, valid range are:
+	 * num_cis: 0x00 to 0x1F
+	 * cis_id: 0x00 to 0xEF
+	 */
+	for (data.cig = qos->ucast.cig, data.cis = 0x00; data.cis < 0xf0 &&
+	     data.pdu.cp.num_cis < ARRAY_SIZE(data.pdu.cis); data.cis++) {
 		data.count = 0;
 
 		hci_conn_hash_list_state(hdev, cis_list, ISO_LINK, BT_BOUND,
-- 
2.40.1



