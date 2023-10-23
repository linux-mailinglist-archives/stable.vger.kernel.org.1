Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB47D33FA
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjJWLfu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjJWLfs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:35:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3383DD6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:35:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E5CC433C9;
        Mon, 23 Oct 2023 11:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060945;
        bh=trMC+7/EYh2fo/vxFUAGbq9ZN+8J0yAGSAXzoBku6Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGIQ/ORrohDPP6BHsOtPZcWrAx4/SMkW3oLRKZrtGgAvDFaH9qRhQqCHGO2LvQS+9
         lCzLLX8p2u1UXTVAemWSblVxB2lLrPZyjpPqtq3ZsumiuXdF1UjC+VFnbgCDbT14QO
         dKV5OWtrQ1MM4AybHm0j5LGbHMxAh8uNSl2WypJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.15 009/137] Bluetooth: avoid memcmp() out of bounds warning
Date:   Mon, 23 Oct 2023 12:56:06 +0200
Message-ID: <20231023104821.206733518@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 9d1a3c74746428102d55371fbf74b484733937d9 upstream.

bacmp() is a wrapper around memcpy(), which contain compile-time
checks for buffer overflow. Since the hci_conn_request_evt() also calls
bt_dev_dbg() with an implicit NULL pointer check, the compiler is now
aware of a case where 'hdev' is NULL and treats this as meaning that
zero bytes are available:

In file included from net/bluetooth/hci_event.c:32:
In function 'bacmp',
    inlined from 'hci_conn_request_evt' at net/bluetooth/hci_event.c:3276:7:
include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
  364 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add another NULL pointer check before the bacmp() to ensure the compiler
understands the code flow enough to not warn about it.  Since the patch
that introduced the warning is marked for stable backports, this one
should also go that way to avoid introducing build regressions.

Fixes: 1ffc6f8cc332 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
Cc: Kees Cook <keescook@chromium.org>
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2797,7 +2797,7 @@ static void hci_conn_request_evt(struct
 	/* Reject incoming connection from device with same BD ADDR against
 	 * CVE-2020-26555
 	 */
-	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+	if (hdev && !bacmp(&hdev->bdaddr, &ev->bdaddr)) {
 		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
 			   &ev->bdaddr);
 		hci_reject_conn(hdev, &ev->bdaddr);


