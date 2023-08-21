Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411F67831D4
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjHUUHh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjHUUHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D49E4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1509D649B0
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF70C433C9;
        Mon, 21 Aug 2023 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648452;
        bh=hp73kmSVLXc9H1W2nqXbvVF35riPw7CH2ANVj0/YE+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXdvOTWHGCEgf3257L5qlmQJ5cghZffvNJR+GRZvDpsY1oc+3ziqKxBS9Lvv3QAZw
         DqHn+816AGy4PWWqGtmjoRpebf5AcEQAXEKDvDwSjoACfdjr0+Qcvoe2DPyXPEowzO
         rWQQcx6WrJvkMmtflOqHCflCdrF3R/K/YD8GxiKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "kernelci.org bot" <bot@kernelci.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 180/234] bus: ti-sysc: Flush posted write on enable before reset
Date:   Mon, 21 Aug 2023 21:42:23 +0200
Message-ID: <20230821194136.801684857@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 34539b442b3bc7d5bf10164750302b60b91f18a7 ]

The am335x devices started producing boot errors for resetting musb module
in because of subtle timing changes:

Unhandled fault: external abort on non-linefetch (0x1008)
...
sysc_poll_reset_sysconfig from sysc_reset+0x109/0x12
sysc_reset from sysc_probe+0xa99/0xeb0
...

The fix is to flush posted write after enable before reset during
probe. Note that some devices also need to specify the delay after enable
with ti,sysc-delay-us, but this is not needed for musb on am335x based on
my tests.

Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://storage.kernelci.org/next/master/next-20230614/arm/multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y/gcc-10/lab-cip/baseline-beaglebone-black.html
Fixes: 596e7955692b ("bus: ti-sysc: Add support for software reset")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 21fe9854703f9..4cb23b9e06ea4 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2142,6 +2142,8 @@ static int sysc_reset(struct sysc *ddata)
 		sysc_val = sysc_read_sysconfig(ddata);
 		sysc_val |= sysc_mask;
 		sysc_write(ddata, sysc_offset, sysc_val);
+		/* Flush posted write */
+		sysc_val = sysc_read_sysconfig(ddata);
 	}
 
 	if (ddata->cfg.srst_udelay)
-- 
2.40.1



