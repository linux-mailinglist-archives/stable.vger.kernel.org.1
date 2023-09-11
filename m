Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6479BFA6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbjIKUyU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbjIKOfl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2643AF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:35:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65116C433C8;
        Mon, 11 Sep 2023 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442936;
        bh=ndNycKOeTa45sY+QTdwiUct0jTCZAjE2D1gv40takS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8mB0um/CecinawRgDb+1XvkRS6rniQPGmBXCHtYsLDFew43cWxvJQjug/VcgBaid
         pZuciYKU9u/6uEPqCnECYvKdx9gZrXrul41v6iGS/2uOTUN2JYHshUa6tq7U18jrWE
         Vc/d5Ka+4DGbm3wMr5ImZLWQcLFyktGHx/huhmTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 200/737] Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy
Date:   Mon, 11 Sep 2023 15:40:59 +0200
Message-ID: <20230911134656.186154709@linuxfoundation.org>
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

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit 5b6d345d1b65d67624349e5de22227492c637576 ]

Use kmemdup rather than duplicating its implementation.

./net/bluetooth/hci_conn.c:1880:7-14: WARNING opportunity for kmemdup.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5597
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a09128921820 ("Bluetooth: hci_conn: Fix hci_le_set_cig_params")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ee9d6ff75246f..7516166652a08 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1886,12 +1886,10 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 	if (qos->ucast.cis == BT_ISO_QOS_CIS_UNSET || !data.pdu.cp.num_cis)
 		return false;
 
-	pdu = kzalloc(sizeof(*pdu), GFP_KERNEL);
+	pdu = kmemdup(&data.pdu, sizeof(*pdu), GFP_KERNEL);
 	if (!pdu)
 		return false;
 
-	memcpy(pdu, &data.pdu, sizeof(*pdu));
-
 	if (hci_cmd_sync_queue(hdev, set_cig_params_sync, pdu,
 			       set_cig_params_complete) < 0) {
 		kfree(pdu);
-- 
2.40.1



