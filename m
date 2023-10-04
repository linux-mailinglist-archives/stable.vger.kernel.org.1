Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4033E7B8840
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbjJDSOR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbjJDSOR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8943FAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82E2C433C7;
        Wed,  4 Oct 2023 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443253;
        bh=JQN0ZMM7fJEBDs8zFvKhxOogVV9OW9IxjgV75q4nQNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENACl3opfnxo2L2ggT/AGXa3qFNLPedQ0Pjw4f1vaGnG3vA3G76Ge/tB3pTaAZo/H
         qpJpL7Kejl0QYM6uyO5zrmmgWZBVMGbdrOjq57K6MYVGWHhYHr79tt/JNHsT5HXIId
         h7H1ws2fxz4kHFdl4cE0lYRQZhzOgnioZBYvk17o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang He <windhl@126.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 090/259] i2c: mux: gpio: Add missing fwnode_handle_put()
Date:   Wed,  4 Oct 2023 19:54:23 +0200
Message-ID: <20231004175221.488627758@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 73a23e117ebec..0930a51c8c7c0 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -105,8 +105,10 @@ static int i2c_mux_gpio_probe_fw(struct gpiomux *mux,
 
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



