Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C988F79ACF0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359827AbjIKWSt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240479AbjIKOpY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:45:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03D412A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:45:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98C1C433C8;
        Mon, 11 Sep 2023 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443520;
        bh=skXZl1EARMAgyaPznX1qmRxLDOh0bsYTkYNhUen53sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Afd2FRbuaEDggt+EFf976E3rnZzd9LgpCAWPq2L+EFsp42t5WdA6JlNXLj3foN3wy
         ZQQeGe+ZfGnFFq8KU0+FMQnU7C9sFXRR6x++TimDCBO2sb09ZnyLhe6zR6FEfQwocE
         fywqigBlQaPxyOPeBCdCUv6bwZrgl6gVm0HeM0Sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Corey Minyard <minyard@acm.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 407/737] ipmi:ssif: Add check for kstrdup
Date:   Mon, 11 Sep 2023 15:44:26 +0200
Message-ID: <20230911134701.993604290@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit c5586d0f711e9744d0cade39b0c4a2d116a333ca ]

Add check for the return value of kstrdup() and return the error
if it fails in order to avoid NULL pointer dereference.

Fixes: c4436c9149c5 ("ipmi_ssif: avoid registering duplicate ssif interface")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Message-Id: <20230619092802.35384-1-jiasheng@iscas.ac.cn>
Signed-off-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_ssif.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 3b921c78ba083..3b87a2726e994 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1600,6 +1600,11 @@ static int ssif_add_infos(struct i2c_client *client)
 	info->addr_src = SI_ACPI;
 	info->client = client;
 	info->adapter_name = kstrdup(client->adapter->name, GFP_KERNEL);
+	if (!info->adapter_name) {
+		kfree(info);
+		return -ENOMEM;
+	}
+
 	info->binfo.addr = client->addr;
 	list_add_tail(&info->link, &ssif_infos);
 	return 0;
-- 
2.40.1



