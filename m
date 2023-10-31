Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AEE7DD402
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjJaRGn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjJaRGZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E81D54
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:04:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACE4C433B7;
        Tue, 31 Oct 2023 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771869;
        bh=5+qBgBemsJGiK9IiPgAb5LF5CcavCnvR+id/562GP08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rL5t9Ea9xGcKRCpWZAERP3WTF00HzbQV5otWMcvWn49pTW5wM3fqGUD03GJKM9BqW
         KuQK4po0PY+6GVgZ+on5g4QOzb7ImOv0242sjcQD/rqvLo0WDK75zkPP00ymtDfcui
         84y/X5qZisZMXH8MKRm41/bIKODoWLWF4r7578q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 47/86] r8152: Run the unload routine if we have errors during probe
Date:   Tue, 31 Oct 2023 18:01:12 +0100
Message-ID: <20231031165920.064592278@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 5dd17689526971c5ae12bc8398f34bd68cd0499e ]

The rtl8152_probe() function lacks a call to the chip-specific
unload() routine when it sees an error in probe. Add it in to match
the cleanup code in rtl8152_disconnect().

Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 4c90f7053171c..3cc8e324c5c6c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9826,6 +9826,8 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	if (tp->rtl_ops.unload)
+		tp->rtl_ops.unload(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
-- 
2.42.0



