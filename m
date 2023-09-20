Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2857A7FE0
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjITMa6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjITMa5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:30:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B699
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:30:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE1FC433C8;
        Wed, 20 Sep 2023 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213051;
        bh=50CSQ2/TBdpfkWsVeqL2SkDxhDmiGqNHWTH8wIYg1V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KB10GVAEA2bx1PsvUA71rHXLZxW8nw8wvucvo9+LGlyECOBjfZTR65tSTLvnBmutp
         +zIUqiX74+Km4RqU8PCzBOjg8fstgUx971uOEpij0i/fOVJgJn29/p8enZBFNlZJbg
         Uf7XV1FULbx9FzhbQdPp6DWXxg4s7ZlAglG9sWrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Corey Minyard <minyard@acm.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 125/367] ipmi:ssif: Add check for kstrdup
Date:   Wed, 20 Sep 2023 13:28:22 +0200
Message-ID: <20230920112901.901992834@linuxfoundation.org>
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
index 2907b0bca1af0..0061f2207f318 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1609,6 +1609,11 @@ static int ssif_add_infos(struct i2c_client *client)
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



