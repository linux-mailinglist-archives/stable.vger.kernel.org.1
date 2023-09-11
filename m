Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9579B7AE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357602AbjIKWna (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjIKPK7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:10:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A737E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:10:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8217DC433CB;
        Mon, 11 Sep 2023 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445054;
        bh=86XXqldRbqwjwpXLLeiVOXAkmh+bxxt7Z54jaiopQrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HomcfWGX5jrCgGgCFFtJj4TJE7F58PqgzK+q1T4G6AqbBTXN//XYiTcjpg+5WZH+d
         hQWMni/xoW0zhbi1ocY2lXQs52OAKJb0JpbDSkNAB1jf0N2/PxoEqZ07Rmql35L/9q
         9+qKsep6u4PrtLMtDRVuVBRODG3xIpZub9fp+/s4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 171/600] Bluetooth: hci_sync: Dont double print name in add/remove adv_monitor
Date:   Mon, 11 Sep 2023 15:43:24 +0200
Message-ID: <20230911134638.656197144@linuxfoundation.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 6f55eea116ba3646fb5fbb31de703f8cf79d8214 ]

The hci_add_adv_monitor() hci_remove_adv_monitor() functions call
bt_dev_dbg() to print some debug statements. The bt_dev_dbg() macro
automatically adds in the device's name. That means that we shouldn't
include the name in the bt_dev_dbg() calls.

Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: a2bcd2b63271 ("Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_add_adv_monitor()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 26884447d72be..561e8a77f64cd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1949,14 +1949,14 @@ int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE:
-		bt_dev_dbg(hdev, "%s add monitor %d status %d", hdev->name,
+		bt_dev_dbg(hdev, "add monitor %d status %d",
 			   monitor->handle, status);
 		/* Message was not forwarded to controller - not an error */
 		break;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
 		status = msft_add_monitor_pattern(hdev, monitor);
-		bt_dev_dbg(hdev, "%s add monitor %d msft status %d", hdev->name,
+		bt_dev_dbg(hdev, "add monitor %d msft status %d",
 			   monitor->handle, status);
 		break;
 	}
@@ -1976,15 +1976,15 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered off */
-		bt_dev_dbg(hdev, "%s remove monitor %d status %d", hdev->name,
+		bt_dev_dbg(hdev, "remove monitor %d status %d",
 			   monitor->handle, status);
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
 		handle = monitor->handle;
 		status = msft_remove_monitor(hdev, monitor);
-		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
-			   hdev->name, handle, status);
+		bt_dev_dbg(hdev, "remove monitor %d msft status %d",
+			   handle, status);
 		break;
 	}
 
-- 
2.40.1



