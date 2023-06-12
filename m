Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6969D72C1D7
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbjFLLA7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjFLLAn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:00:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4C4492
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECDDD6247E
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D013C433D2;
        Mon, 12 Jun 2023 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566848;
        bh=UN19CGw7I1DGGDy7DyrUm/b4QNzIKtsAoQg6iX1pm70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzuNbRBHuLPqXy7LHVDad2CQvohZPmRVPH7c4N9pYrEJxhkO+pfOuPMBUTPgJKVtP
         OXKIrQBEkRV68ZeX6/JBcNzlu1VjtI723MmnShWfuCtp8jiREk1pnzrTXAZwKvYbfi
         QEeR9TN8A23DKSgsc4HsTsp9pFPU5lkduoHEp6/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 025/160] Bluetooth: ISO: dont try to remove CIG if there are bound CIS left
Date:   Mon, 12 Jun 2023 12:25:57 +0200
Message-ID: <20230612101716.194618885@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 6c242c64a09e78349fb0a5f0a6f8076a3d7c0bb4 ]

Consider existing BOUND & CONNECT state CIS to block CIG removal.
Otherwise, under suitable timing conditions we may attempt to remove CIG
while Create CIS is pending, which fails.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 96df87692f962..e02afdc557e7b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -968,6 +968,8 @@ static void cis_cleanup(struct hci_conn *conn)
 	/* Check if ISO connection is a CIS and remove CIG if there are
 	 * no other connections using it.
 	 */
+	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_BOUND, &d);
+	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_CONNECT, &d);
 	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_CONNECTED, &d);
 	if (d.count)
 		return;
-- 
2.39.2



