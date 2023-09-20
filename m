Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80B37A7FF8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjITMbv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbjITMbv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:31:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F2E8F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:31:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180D2C433C9;
        Wed, 20 Sep 2023 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213105;
        bh=WhakkxabZuI1iVuqyCX3Q6we6eDTNVAl4NSObtxJKhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSSD2Xnm5EtqcCqLrwb+a56bJmEsCBPJnhFTxW/yZUvArGQGOrNtNWD6IbwudpPSU
         mh98dK+GSdDILRj66SaBSAIV9SJP5eNIC588AP2JlmjhuMubjfNMtxMMTtAm22dGmY
         l2BfipmPqR62/liPvhpXXmkXIEbgm0z6O/MRrJaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 163/367] serial: sprd: remove redundant sprd_port cleanup
Date:   Wed, 20 Sep 2023 13:29:00 +0200
Message-ID: <20230920112902.869025583@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit 72534077475fc489f8358c0e214cc1a4d658c8c2 ]

We don't need to cleanup sprd_port anymore, since we've dropped the way
of using the sprd_port[] array to get port index.

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Link: https://lore.kernel.org/r/20200318105049.19623-3-zhang.lyra@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f9608f188756 ("serial: sprd: Assign sprd_port after initialized to avoid wrong access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sprd_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index e6acf2c848f39..9cf771a9cff62 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1205,10 +1205,8 @@ static int sprd_probe(struct platform_device *pdev)
 	sprd_ports_num++;
 
 	ret = uart_add_one_port(&sprd_uart_driver, up);
-	if (ret) {
-		sprd_port[index] = NULL;
+	if (ret)
 		sprd_remove(pdev);
-	}
 
 	platform_set_drvdata(pdev, up);
 
-- 
2.40.1



