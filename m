Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30007D30BC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjJWLBn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjJWLBm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:01:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A310CF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:01:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93184C433C8;
        Mon, 23 Oct 2023 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058899;
        bh=Ng03jGX9Y5yxyCbQsIIfxpE/atkKtI6GiOwcphL6x04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H858ZOTF9FGwWXnsOKH86qUXGdPgYmnuWEKD5zZb0goq0TeTnzsjvNoLMbYTRJxn7
         6eTbMPjfNgEBMdP3kPkboaBxicX9d6qy8R53joVn6vBROk+pnFTzuV9AreLKibiUf0
         kSm0v38RXADEdn1rIm3slJOEARhUMe8JVtWjNn7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com,
        Edward AD <twuufnxlz@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 4.14 64/66] Bluetooth: hci_sock: fix slab oob read in create_monitor_event
Date:   Mon, 23 Oct 2023 12:56:54 +0200
Message-ID: <20231023104813.197549920@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward AD <twuufnxlz@gmail.com>

commit 18f547f3fc074500ab5d419cf482240324e73a7e upstream.

When accessing hdev->name, the actual string length should prevail

Reported-by: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_sock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -425,7 +425,7 @@ static struct sk_buff *create_monitor_ev
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, 8);
+		memcpy(ni->name, hdev->name, strlen(hdev->name));
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;


