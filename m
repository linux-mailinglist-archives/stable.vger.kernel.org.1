Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1177E254A
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjKFNa2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjKFNa2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:30:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163A592
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:30:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B948C433C9;
        Mon,  6 Nov 2023 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277424;
        bh=GMGocPZlTT3V1qSon/YTDIJelOdclIqiVUs8Mblc3Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tETuw/lwvAKATmxuGumkqjrz2FvEm3PmvnWIgnq5DpmFp0I/jIQgDjwKSBLpyCQ6t
         ahjUO3ln+5zMYOZzNjkjUzNKklWAuwCPsB3JIUPUXJxhpdTPdtITDLvmO+cAtU0kVy
         j2rm9iA1k8RO8g/pHA+4FtgInSvDnV0dg3C3MXKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 18/95] r8152: Run the unload routine if we have errors during probe
Date:   Mon,  6 Nov 2023 14:03:46 +0100
Message-ID: <20231106130305.397753024@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index d0ab761dad189..517334aab278a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6825,6 +6825,8 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	if (tp->rtl_ops.unload)
+		tp->rtl_ops.unload(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
-- 
2.42.0



