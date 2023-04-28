Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD666F16A8
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjD1L3O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345515AbjD1L3N (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D609E59E4
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708D0638BD
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834C5C433EF;
        Fri, 28 Apr 2023 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681350;
        bh=89AJIlv+eX2RQSjWzPOy1cjiYsERvx7x59ojXBCMBz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQ8TFB8wx/4ksh2GawT4iHaWoa6ccyYCpmNA8/9GG6Sgqq+o0JxELTu20NUv9fHHN
         UMUeAYIbmTS5xkq0SmAHB88pwFNjc43P6Qt9rTUVnXIyUbu7gjrtAxyBVvBdhJ5vVB
         b65CDWL6OeUU0owendjvM09Ifw4qZkJh1Iy2IiXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruihan Li <lrh2000@pku.edu.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 10/16] bluetooth: Perform careful capability checks in hci_sock_ioctl()
Date:   Fri, 28 Apr 2023 13:28:02 +0200
Message-Id: <20230428112040.398139972@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
References: <20230428112040.063291126@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

commit 25c150ac103a4ebeed0319994c742a90634ddf18 upstream.

Previously, capability was checked using capable(), which verified that the
caller of the ioctl system call had the required capability. In addition,
the result of the check would be stored in the HCI_SOCK_TRUSTED flag,
making it persistent for the socket.

However, malicious programs can abuse this approach by deliberately sharing
an HCI socket with a privileged task. The HCI socket will be marked as
trusted when the privileged task occasionally makes an ioctl call.

This problem can be solved by using sk_capable() to check capability, which
ensures that not only the current task but also the socket opener has the
specified capability, thus reducing the risk of privilege escalation
through the previously identified vulnerability.

Cc: stable@vger.kernel.org
Fixes: f81f5b2db869 ("Bluetooth: Send control open and close messages for HCI raw sockets")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_sock.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1003,7 +1003,14 @@ static int hci_sock_ioctl(struct socket
 	if (hci_sock_gen_cookie(sk)) {
 		struct sk_buff *skb;
 
-		if (capable(CAP_NET_ADMIN))
+		/* Perform careful checks before setting the HCI_SOCK_TRUSTED
+		 * flag. Make sure that not only the current task but also
+		 * the socket opener has the required capability, since
+		 * privileged programs can be tricked into making ioctl calls
+		 * on HCI sockets, and the socket should not be marked as
+		 * trusted simply because the ioctl caller is privileged.
+		 */
+		if (sk_capable(sk, CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		/* Send event to monitor */


