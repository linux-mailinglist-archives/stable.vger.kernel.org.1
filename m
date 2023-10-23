Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1407D3539
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjJWLq3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjJWLqN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:46:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0461707
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:46:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C499BC433C9;
        Mon, 23 Oct 2023 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061561;
        bh=wpzdIhzvC/n6XVgsScI9F6679C7xoNyT6I9Wj2UYVQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/Iq/OhquEXLw0Dwq4fki/ZtexUfmen8Tf+7eO+GW2XCs0kqSUR2W48tBiXbAHzUk
         7A4wszxoiE/qkdSgAlxSbh/k5zdBW5OrNNFQ7QUq4d+Lj033X4VKQqodWVS1s8BogU
         f4RaT0ap2bNt5NXzqULsLHM6j9F1TAEvcAvYYx1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10 088/202] Bluetooth: Fix a refcnt underflow problem for hci_conn
Date:   Mon, 23 Oct 2023 12:56:35 +0200
Message-ID: <20231023104829.103088968@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyang Xuan <william.xuanziyang@huawei.com>

commit c7f59461f5a78994613afc112cdd73688aef9076 upstream.

Syzbot reports a warning as follows:

WARNING: CPU: 1 PID: 26946 at net/bluetooth/hci_conn.c:619
hci_conn_timeout+0x122/0x210 net/bluetooth/hci_conn.c:619
...
Call Trace:
 <TASK>
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

It is because the HCI_EV_SIMPLE_PAIR_COMPLETE event handler drops
hci_conn directly without check Simple Pairing whether be enabled. But
the Simple Pairing process can only be used if both sides have the
support enabled in the host stack.

Add hci_conn_ssp_enabled() for hci_conn in HCI_EV_IO_CAPA_REQUEST and
HCI_EV_SIMPLE_PAIR_COMPLETE event handlers to fix the problem.

Fixes: 0493684ed239 ("[Bluetooth] Disable disconnect timer during Simple Pairing")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_event.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4617,7 +4617,7 @@ static void hci_io_capa_request_evt(stru
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn)
+	if (!conn || !hci_conn_ssp_enabled(conn))
 		goto unlock;
 
 	hci_conn_hold(conn);
@@ -4862,7 +4862,7 @@ static void hci_simple_pair_complete_evt
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn)
+	if (!conn || !hci_conn_ssp_enabled(conn))
 		goto unlock;
 
 	/* Reset the authentication requirement to unknown */


