Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADC07D30E3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjJWLDW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjJWLDV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:03:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11717D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:03:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544DEC433C7;
        Mon, 23 Oct 2023 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058999;
        bh=hvzz+QMVhQFFmO4/BYaqRURsQ8yQEyq2RJZQrRMPke4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=weSNqyoAkWaXOdo9lhd6pcPC6lyWw9UnoA7H3KOUsrx3pxfPoKpKUnq68RuEofe6i
         YdEu7Qzd+qguWnRqjS4VkOBb1RwYmibnO6lbV7br91puHDMEfNnKr7mEighFI/Puwb
         5kf5Fz3q92HEb+BpEtw5jB8OtdpWg/Gvb8uhfcdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.5 005/241] Bluetooth: hci_event: Fix coding style
Date:   Mon, 23 Oct 2023 12:53:11 +0200
Message-ID: <20231023104833.979958278@linuxfoundation.org>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 35d91d95a0cd61ebb90e0246dc917fd25e519b8c upstream.

This fixes the following code style problem:

ERROR: that open brace { should be on the previous line
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
+	{

Fixes: 1ffc6f8cc332 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_event.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3275,8 +3275,7 @@ static void hci_conn_request_evt(struct
 	/* Reject incoming connection from device with same BD ADDR against
 	 * CVE-2020-26555
 	 */
-	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
-	{
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
 		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
 			   &ev->bdaddr);
 		hci_reject_conn(hdev, &ev->bdaddr);


