Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0FD7E24E0
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjKFN0P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjKFN0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:26:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA326D6B
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:26:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC97C433CA;
        Mon,  6 Nov 2023 13:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277168;
        bh=C13GYRHHs69YR9LAV1pANN1Yh95owT7RiVYs7vpjB2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6GoeD4BCwOQ8FD3Sr3/FHh1+AueT21EdcBiWF1+8MOLaU9jsJuzikDpzdZeWMa2Q
         o6dnR1a7qWD612WmBHWcdjt+PKZ2pawkRFwEM9nlgnW199h1P09aid7DWgwGUF5Qly
         73fmCG9LkLa4DEYr3v/BX4xz9XRHixPhHYqa/6mU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 032/128] r8152: Run the unload routine if we have errors during probe
Date:   Mon,  6 Nov 2023 14:03:12 +0100
Message-ID: <20231106130310.573560913@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 89a1e40ff7005..52056b296b9f7 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9799,6 +9799,8 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	if (tp->rtl_ops.unload)
+		tp->rtl_ops.unload(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
-- 
2.42.0



