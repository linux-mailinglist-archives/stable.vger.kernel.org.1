Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8179B1B8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358017AbjIKWHY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbjIKPDT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:03:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAF2125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:03:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A53C433C8;
        Mon, 11 Sep 2023 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444594;
        bh=XcNJ1AjaLVccpHTVNTIL1c/wz719v0WGrsWqEEKVoa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPFF4xw0u69A8kVefBhfzY/ca692W8O9bzljgwL9k+p34VT1RHGPxd5KwZovaeTxn
         PzuzgAU6kaHFI+mn4gRjYYUco0T+IQl6I7mN2xnIg8/3KLbXhW0QnLLgyhzkfdUkC2
         goiDhFjXZv0R0VBSPCW/GPLoY2CvzNhfhnF5NWFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmytro Maluka <dmy@semihalf.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 020/600] ASoC: da7219: Flush pending AAD IRQ when suspending
Date:   Mon, 11 Sep 2023 15:40:53 +0200
Message-ID: <20230911134634.211050892@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmytro Maluka <dmy@semihalf.com>

[ Upstream commit 91e292917dad64ab8d1d5ca2ab3069ad9dac6f72 ]

da7219_aad_suspend() disables jack detection, which should prevent
generating new interrupts by DA7219 while suspended. However, there is a
theoretical possibility that there is a pending interrupt generated just
before suspending DA7219 and not handled yet, so the IRQ handler may
still run after DA7219 is suspended. To prevent that, wait until the
pending IRQ handling is done.

This patch arose as an attempt to fix the following I2C failure
occurring sometimes during system suspend or resume:

[  355.876211] i2c_designware i2c_designware.3: Transfer while suspended
[  355.876245] WARNING: CPU: 2 PID: 3576 at drivers/i2c/busses/i2c-designware-master.c:570 i2c_dw_xfer+0x411/0x440
...
[  355.876462] Call Trace:
[  355.876468]  <TASK>
[  355.876475]  ? update_load_avg+0x1b3/0x615
[  355.876484]  __i2c_transfer+0x101/0x1d8
[  355.876494]  i2c_transfer+0x74/0x10d
[  355.876504]  regmap_i2c_read+0x6a/0x9c
[  355.876513]  _regmap_raw_read+0x179/0x223
[  355.876521]  regmap_raw_read+0x1e1/0x28e
[  355.876527]  regmap_bulk_read+0x17d/0x1ba
[  355.876532]  ? __wake_up+0xed/0x1bb
[  355.876542]  da7219_aad_irq_thread+0x54/0x2c9 [snd_soc_da7219 5fb8ebb2179cf2fea29af090f3145d68ed8e2184]
[  355.876556]  irq_thread+0x13c/0x231
[  355.876563]  ? irq_forced_thread_fn+0x5f/0x5f
[  355.876570]  ? irq_thread_fn+0x4d/0x4d
[  355.876576]  kthread+0x13a/0x152
[  355.876581]  ? synchronize_irq+0xc3/0xc3
[  355.876587]  ? kthread_blkcg+0x31/0x31
[  355.876592]  ret_from_fork+0x1f/0x30
[  355.876601]  </TASK>

which indicates that the AAD IRQ handler is unexpectedly running when
DA7219 is suspended, and as a result, is trying to read data from DA7219
over I2C and is hitting the I2C driver "Transfer while suspended"
failure.

However, with this patch the above failure is still reproducible. So
this patch does not fix any real observed issue so far, but at least is
useful for confirming that the above issue is not caused by a pending
IRQ but rather looks like a DA7219 hardware issue with an IRQ
unexpectedly generated after jack detection is already disabled.

Signed-off-by: Dmytro Maluka <dmy@semihalf.com>
Link: https://lore.kernel.org/r/20230717193737.161784-2-dmy@semihalf.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index bba73c44c219f..49b1622e7bada 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -863,6 +863,8 @@ void da7219_aad_suspend(struct snd_soc_component *component)
 			}
 		}
 	}
+
+	synchronize_irq(da7219_aad->irq);
 }
 
 void da7219_aad_resume(struct snd_soc_component *component)
-- 
2.40.1



