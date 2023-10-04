Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8197B8763
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbjJDSEn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbjJDSEm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:04:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EB59E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D97C433C9;
        Wed,  4 Oct 2023 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442679;
        bh=BJGvE/yTLa2gtIA3ZYI/jow58/JDjLp+6ugvlzCuQZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0ISex+62lZLW+V4FnzKv1dVbUQVP7ZFe2uTnjGWbOlmHn1AaNJbH80qBePjCwPlW
         Wz5bTcbWxhQfNc1Hxw/oqyTyWWxPKYUbI4Ffcl2vCdQA57k9CZpjGILxylnnyzPE1N
         EuqWcK50BDQ/HeR0/rONO48cJjp+Qg6VHSkzJqw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang He <windhl@126.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 071/183] i2c: mux: gpio: Add missing fwnode_handle_put()
Date:   Wed,  4 Oct 2023 19:55:02 +0200
Message-ID: <20231004175206.851291475@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liang He <windhl@126.com>

[ Upstream commit db6aee6083a56ac4a6cd1b08fff7938072bcd0a3 ]

In i2c_mux_gpio_probe_fw(), we should add fwnode_handle_put()
when break out of the iteration device_for_each_child_node()
as it will automatically increase and decrease the refcounter.

Fixes: 98b2b712bc85 ("i2c: i2c-mux-gpio: Enable this driver in ACPI land")
Signed-off-by: Liang He <windhl@126.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 31e6eb1591bb9..8bad785dce36f 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -103,8 +103,10 @@ static int i2c_mux_gpio_probe_fw(struct gpiomux *mux,
 
 		} else if (is_acpi_node(child)) {
 			rc = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), values + i);
-			if (rc)
+			if (rc) {
+				fwnode_handle_put(child);
 				return dev_err_probe(dev, rc, "Cannot get address\n");
+			}
 		}
 
 		i++;
-- 
2.40.1



