Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A8C7D3184
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjJWLJ7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjJWLJ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:09:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8497610C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:09:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B36C433C9;
        Mon, 23 Oct 2023 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059396;
        bh=kMct34vET7QZdOtmuNDnWE1DoQwyAFQpjCCz4KPqt+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYK24M/58AG642Q/p/cNJKPXtG1T1Rqg/nemy5veuAxC3/teOLuu27FSyUM/Vfn/J
         SnhLUIiV5Gbzur2xBmUZTRMkuiP6+euSvFVMXOT+r8UcknBYDJksTEf4OnPplskVcS
         E6XtUuah7YNm2wYEW1EV8aLcxP5iPW+UVztUmdbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 146/241] Bluetooth: ISO: Fix invalid context error
Date:   Mon, 23 Oct 2023 12:55:32 +0200
Message-ID: <20231023104837.429426326@linuxfoundation.org>
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

From: Iulia Tanasescu <iulia.tanasescu@nxp.com>

[ Upstream commit acab8ff29a2a226409cfe04e6d2e0896928c1b3a ]

This moves the hci_le_terminate_big_sync call from rx_work
to cmd_sync_work, to avoid calling sleeping function from
an invalid context.

Reported-by: syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com
Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d331027363313..9d8aa6ad23dc2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6978,6 +6978,14 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static int hci_iso_term_big_sync(struct hci_dev *hdev, void *data)
+{
+	u8 handle = PTR_UINT(data);
+
+	return hci_le_terminate_big_sync(hdev, handle,
+					 HCI_ERROR_LOCAL_HOST_TERM);
+}
+
 static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
@@ -7022,16 +7030,17 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		rcu_read_lock();
 	}
 
+	rcu_read_unlock();
+
 	if (!ev->status && !i)
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
 		 * has completed.
 		 */
-		hci_le_terminate_big_sync(hdev, ev->handle,
-					  HCI_ERROR_LOCAL_HOST_TERM);
+		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
+				   UINT_PTR(ev->handle), NULL);
 
-	rcu_read_unlock();
 	hci_dev_unlock(hdev);
 }
 
-- 
2.40.1



