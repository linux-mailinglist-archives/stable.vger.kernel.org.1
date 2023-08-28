Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9878AB4E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjH1K3r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjH1K3f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A75EB9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE6663C1D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D9EC433C8;
        Mon, 28 Aug 2023 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218571;
        bh=5NmSEfcnsJuKNVFQh3/Blo4SSYxSkP1oN2wy3wymNhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFps9upgUqHV0MhQ9s8baNUscnphz/UB/kCwk94uc7ZCHJg+3FbK2RAPCtfFz45VU
         nYPWz/QmZZ+1NdVwiICksOzS8B9nKxtFOB+O4gZVYMEQzBdDAipb2WwwpQNd94brXK
         TupzT8PC1tZox4rKmnLLYNW6J9GHZsM1Ah49Z7Vc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 4.19 125/129] irqchip/mips-gic: Dont touch vl_map if a local interrupt is not routable
Date:   Mon, 28 Aug 2023 12:13:39 +0200
Message-ID: <20230828101157.768097361@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit 2c6c9c049510163090b979ea5f92a68ae8d93c45 upstream.

When a GIC local interrupt is not routable, it's vl_map will be used
to control some internal states for core (providing IPTI, IPPCI, IPFDC
input signal for core). Overriding it will interfere core's intetrupt
controller.

Do not touch vl_map if a local interrupt is not routable, we are not
going to remap it.

Before dd098a0e0319 (" irqchip/mips-gic: Get rid of the reliance on
irq_cpu_online()"), if a local interrupt is not routable, then it won't
be requested from GIC Local domain, and thus gic_all_vpes_irq_cpu_online
won't be called for that particular interrupt.

Fixes: dd098a0e0319 (" irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230424103156.66753-2-jiaxun.yang@flygoat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-mips-gic.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -396,6 +396,8 @@ static void gic_all_vpes_irq_cpu_online(
 		unsigned int intr = local_intrs[i];
 		struct gic_all_vpes_chip_data *cd;
 
+		if (!gic_local_irq_is_routable(intr))
+			continue;
 		cd = &gic_all_vpes_chip_data[intr];
 		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
 		if (cd->mask)


