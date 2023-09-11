Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC43679BFA9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbjIKWe5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbjIKN4r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:56:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB0F10E
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:56:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A07C433C7;
        Mon, 11 Sep 2023 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440602;
        bh=X/L3kRyOQU/rTLC4zVWeP/v0gA4lxMhechOubwF9YS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7tAgz7Z2SS1YaXBWmhZOM748sBMfW31YgAuaMNiczuPbDQz70zhh30eXw10Ud263
         z0VqToXLFcqulOR8S8g5a6pHN7O9vpcsPlLfGqH0nbmtbIjcBwK/zVMcOouUMwdwj5
         1deIjO9NusrLcUmdkleymlPrOIIkmQzF2HymqZkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 120/739] Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()
Date:   Mon, 11 Sep 2023 15:38:39 +0200
Message-ID: <20230911134654.447834608@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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



