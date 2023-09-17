Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAD7A37A7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbjIQTXN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbjIQTXC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:23:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714111C
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:22:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556C3C433C7;
        Sun, 17 Sep 2023 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978576;
        bh=FOWPYc5RtPOhEzhHIG08ntJExMu5gzhzvik3BlFem9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1EJWsSkaicO3/k7epN5mC7w5BGwFwNFiG7/lpq1jQoEySurWAnstnpvsehZ8UWq2
         9IwD2HrhbOAWcVV4zh/1k9kkd4SljImDgmqvQWxZpvQ/BY7Q4TXL+1hyja5T6PAep/
         e8ay/oM4zg9LUlyv3DcVANT7PlGdmhYgSwIK9Fgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 098/406] Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()
Date:   Sun, 17 Sep 2023 21:09:12 +0200
Message-ID: <20230917191103.720006959@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit e8b5aed31355072faac8092ead4938ddec3111fd ]

in nokia_bluetooth_serdev_probe(), check the return value of
clk_prepare_enable() and return the error code if
clk_prepare_enable() returns an unexpected value.

Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_nokia.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 05f7f6de6863d..97da0b2bfd17e 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -734,7 +734,11 @@ static int nokia_bluetooth_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
-	clk_prepare_enable(sysclk);
+	err = clk_prepare_enable(sysclk);
+	if (err) {
+		dev_err(dev, "could not enable sysclk: %d", err);
+		return err;
+	}
 	btdev->sysclk_speed = clk_get_rate(sysclk);
 	clk_disable_unprepare(sysclk);
 
-- 
2.40.1



