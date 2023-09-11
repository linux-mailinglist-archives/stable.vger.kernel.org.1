Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7D79BE5D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbjIKVO3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbjIKPLC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:11:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29058FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:10:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DD5C433CC;
        Mon, 11 Sep 2023 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445057;
        bh=vKYzlKUeoGh3gsbQrQKWSRlI6JtCXzYcUh7vuFmmlfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05pMw8SGqkGiocCd8me4Qr3qomOiED0XEFXzk9eIfoVpYEeLaoYbX5rTzbWhMy+nK
         yn+Gr9eY9u/2zKmIi+HqMpxzm+pn2R4j2kH3ip+YuU0W0Rncc34gRQuth7WLureVI/
         71gXg9UWJ/ihk6DVgrUL4GZWmRcDT8Uu9dUU72PU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Manish Mandlik <mmandlik@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 172/600] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_add_adv_monitor()
Date:   Mon, 11 Sep 2023 15:43:25 +0200
Message-ID: <20230911134638.684831154@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manish Mandlik <mmandlik@google.com>

[ Upstream commit a2bcd2b63271a93a695fabbfbf459c603d956d48 ]

KSAN reports use-after-free in hci_add_adv_monitor().

While adding an adv monitor,
    hci_add_adv_monitor() calls ->
    msft_add_monitor_pattern() calls ->
    msft_add_monitor_sync() calls ->
    msft_le_monitor_advertisement_cb() calls in an error case ->
    hci_free_adv_monitor() which frees the *moniter.

This is referenced by bt_dev_dbg() in hci_add_adv_monitor().

Fix the bt_dev_dbg() by using handle instead of monitor->handle.

Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
Signed-off-by: Manish Mandlik <mmandlik@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 561e8a77f64cd..146553c0054f6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1957,7 +1957,7 @@ int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	case HCI_ADV_MONITOR_EXT_MSFT:
 		status = msft_add_monitor_pattern(hdev, monitor);
 		bt_dev_dbg(hdev, "add monitor %d msft status %d",
-			   monitor->handle, status);
+			   handle, status);
 		break;
 	}
 
-- 
2.40.1



