Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C726FAAD7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjEHLHA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjEHLGk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C431ED5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59EC862A7B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC72C433EF;
        Mon,  8 May 2023 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543946;
        bh=Mc6Fs4GXzKxOExO+sI2J1Iy2NjpIb3MQHdp7Y5CI6s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTVLx4MLRy2u+TpVmWYElUq8tLtNT/6cHIHltbMXlB3zEYxg6LLA/EfKZpeykLVeC
         9y/W6ITtFOYs3HEdvIdS8kU/UDrX2gdMjvb8Rqc1oZS8JQjNzEkb13BAzU2o9en4Ny
         aJ3laGKWMFzidxnbmf9gn0X8hQ2WSOi7QNsGeohA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Yang <lidaxian@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 245/694] soc: renesas: renesas-soc: Release chipid from ioremap()
Date:   Mon,  8 May 2023 11:41:20 +0200
Message-Id: <20230508094440.266168251@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Yang <lidaxian@hust.edu.cn>

[ Upstream commit fc187a46a8e682f0f1167b230792b88de01ceaa0 ]

Smatch reports:

drivers/soc/renesas/renesas-soc.c:536 renesas_soc_init() warn:
'chipid' from ioremap() not released on lines: 475.

If soc_dev_atrr allocation is failed, function renesas_soc_init()
will return without releasing 'chipid' from ioremap().

Fix this by adding function iounmap().

Fixes: cb5508e47e60 ("soc: renesas: Add support for reading product revision for RZ/G2L family")
Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
Reviewed-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230331095545.31823-1-lidaxian@hust.edu.cn
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/renesas/renesas-soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 468ebce1ea88b..51191d1a6dd1d 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -471,8 +471,11 @@ static int __init renesas_soc_init(void)
 	}
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
+	if (!soc_dev_attr) {
+		if (chipid)
+			iounmap(chipid);
 		return -ENOMEM;
+	}
 
 	np = of_find_node_by_path("/");
 	of_property_read_string(np, "model", &soc_dev_attr->machine);
-- 
2.39.2



