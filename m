Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7740A719DE8
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjFAN1a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjFAN1P (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050DCE75
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B309D617B9
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5F2C433EF;
        Thu,  1 Jun 2023 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626017;
        bh=rDwedX+hq+XP/ATgD1lAa5+JqAMDXO2MBgD1SysOhTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eey8QerBMcqXxCzPg7n1cEkh8YcYktjq+bgfKGow99lsU6Vy2Z7yk1BfGLUxxTy/t
         4ZQpGXu8Qu+V2nYUXklGU8OGxPZFgmFnc7I9KnVmOzUuHrqBSr0i33BayIwBGNuOO9
         kHh/+yHnWr6JVuI+nl6A0jsPFfsKMri5nHelphkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruihan Li <lrh2000@pku.edu.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Dragos-Marian Panait <dragos.panait@windriver.com>
Subject: [PATCH 6.3 42/45] bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()
Date:   Thu,  1 Jun 2023 14:21:38 +0100
Message-Id: <20230601131940.626550790@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

commit 000c2fa2c144c499c881a101819cf1936a1f7cf2 upstream.

Previously, channel open messages were always sent to monitors on the first
ioctl() call for unbound HCI sockets, even if the command and arguments
were completely invalid. This can leave an exploitable hole with the abuse
of invalid ioctl calls.

This commit hardens the ioctl processing logic by first checking if the
command is valid, and immediately returning with an ENOIOCTLCMD error code
if it is not. This ensures that ioctl calls with invalid commands are free
of side effects, and increases the difficulty of further exploitation by
forcing exploitation to find a way to pass a valid command first.

Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Co-developed-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_sock.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -987,6 +987,34 @@ static int hci_sock_ioctl(struct socket
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
 
+	/* Make sure the cmd is valid before doing anything */
+	switch (cmd) {
+	case HCIGETDEVLIST:
+	case HCIGETDEVINFO:
+	case HCIGETCONNLIST:
+	case HCIDEVUP:
+	case HCIDEVDOWN:
+	case HCIDEVRESET:
+	case HCIDEVRESTAT:
+	case HCISETSCAN:
+	case HCISETAUTH:
+	case HCISETENCRYPT:
+	case HCISETPTYPE:
+	case HCISETLINKPOL:
+	case HCISETLINKMODE:
+	case HCISETACLMTU:
+	case HCISETSCOMTU:
+	case HCIINQUIRY:
+	case HCISETRAW:
+	case HCIGETCONNINFO:
+	case HCIGETAUTHINFO:
+	case HCIBLOCKADDR:
+	case HCIUNBLOCKADDR:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {


