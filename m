Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D15774BDB4
	for <lists+stable@lfdr.de>; Sat,  8 Jul 2023 16:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGHOGo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 8 Jul 2023 10:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHOGo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 8 Jul 2023 10:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F91723
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 07:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F32B60C82
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 14:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6834C433C7;
        Sat,  8 Jul 2023 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688825202;
        bh=GemB8oDF11KrRtnmNhpuuDODQkHivxkHcWaUZbHnVPw=;
        h=From:Date:Subject:To:Cc:From;
        b=fxlV24v+e+/KiTmdjNI23U7pH4XQNhA0g0GbWnwBNK6HJnGw/W2qdn0LMRg6/3+cW
         U3kkZ7KDrFx2UgsPKLJ6jGzMnKRYj6PfWpf13QtcOdYFO4YPVnBI2rS8AW9gy11xpb
         dhnhQ+oyiEI2Mt0d46FcfDb916BIGAHZdPX+vWC5ZMuGnTQLvCtY8F/xDAirqgZRaj
         2YaGewMGs+eGem7q5fkO2z/vdGrbGT4ssXnJJzziSDY0eziFzITFCVXvZ/odvP4wEA
         pXWkkVN14zP8ronpp6C492y+PfcOqF+jEnswf4jMjjXy76YV5XaTsNNWgaOI3fWOu+
         VrHOGkR7yqArA==
From:   Simon Horman <horms@kernel.org>
Date:   Sat, 08 Jul 2023 15:06:25 +0100
Subject: [PATCH net] net: lan743x: select FIXED_PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-lan743x-fixed-phy-v1-1-3fd19580546c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGBtqWQC/xXN0QrCMAyF4VcZuTZQ27GqryJeZGu0gRJHO2Uy9
 u5ml/+Bj7NB4yrc4NZtUPkrTd5qcT51MGXSF6Mka/DOBxfdBQtp7MOKT1k54Zx/GHwcfOqvaaA
 A5kZqjGMlnbJJ/ZRi41z5EMfRHZQXeOz7H5vZ7Dh9AAAA
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Pavithra Sathyanarayanan <Pavithra.Sathyanarayanan@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
        netdev@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The blamed commit introduces usage of fixed_phy_register() but
not a corresponding dependency on FIXED_PHY.

This can result in a build failure.

 s390-linux-ld: drivers/net/ethernet/microchip/lan743x_main.o: in function `lan743x_phy_open':
 drivers/net/ethernet/microchip/lan743x_main.c:1514: undefined reference to `fixed_phy_register'

Fixes: 624864fbff92 ("net: lan743x: add fixed phy support for LAN7431 device")
Cc: stable@vger.kernel.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/netdev/725bf1c5-b252-7d19-7582-a6809716c7d6@infradead.org/
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/microchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 24c994baad13..329e374b9539 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -46,7 +46,7 @@ config LAN743X
 	tristate "LAN743x support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
-	select PHYLIB
+	select FIXED_PHY
 	select CRC16
 	select CRC32
 	help

