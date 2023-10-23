Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2247D3258
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjJWLTI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjJWLTH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:19:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172CAC1;
        Mon, 23 Oct 2023 04:19:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA6BC433C8;
        Mon, 23 Oct 2023 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059945;
        bh=XAbZ5kaxm126V21Hl92FcJE28deK8jqjpD30zUe88iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q44aBE86Ze0NSV7+dSYblZ76wq0GSg6DgKtHgg+dFcPRT/aiVa3qnhXv4Cav3a2JD
         /MN+BZUnEGsh2xqdlOnKybPcCTEfnx+AXcbOs+w+IAp3sFCVv2ZNjpmezAwDYKGFo0
         U2jiKdcQr6PGVIxfjCDuBC+dXidORy2vKrCvKGsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Edward AD <twuufnxlz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.19 97/98] Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name
Date:   Mon, 23 Oct 2023 12:57:26 +0200
Message-ID: <20231023104816.941063966@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit cb3871b1cd135a6662b732fbc6b3db4afcdb4a64 upstream.

The code pattern of memcpy(dst, src, strlen(src)) is almost always
wrong. In this case it is wrong because it leaves memory uninitialized
if it is less than sizeof(ni->name), and overflows ni->name when longer.

Normally strtomem_pad() could be used here, but since ni->name is a
trailing array in struct hci_mon_new_index, compilers that don't support
-fstrict-flex-arrays=3 can't tell how large this array is via
__builtin_object_size(). Instead, open-code the helper and use sizeof()
since it will work correctly.

Additionally mark ni->name as __nonstring since it appears to not be a
%NUL terminated C string.

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Edward AD <twuufnxlz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: 18f547f3fc07 ("Bluetooth: hci_sock: fix slab oob read in create_monitor_event")
Link: https://lore.kernel.org/lkml/202310110908.F2639D3276@keescook/
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_sock.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -430,7 +430,8 @@ static struct sk_buff *create_monitor_ev
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, strlen(hdev->name));
+		memcpy_and_pad(ni->name, sizeof(ni->name), hdev->name,
+			       strnlen(hdev->name, sizeof(ni->name)), '\0');
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;


