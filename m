Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2717A3A6F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjIQUDU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbjIQUCz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:02:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D723A1B8
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:02:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B000C433CB;
        Sun, 17 Sep 2023 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980967;
        bh=WnWQWnWF/TWLOGRpyJPW12sP9rL/effd7bhur1lbaCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrQYnUzyHQW8gbSgLmpIk7Al9XLGktND7gAGO33uXlaAlizJHZM9GtDrNHsAEPdIa
         pfNbvluKHTbEeZMzF4B766bukbgFnGznCqZ97XiQbyp9uYllHgpeXRgd9XBovFzAnt
         rtDVyblAdUm21vDChh2OAY8qMIMFq2txG9p5qQk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonathan Marek <jonathan@marek.ca>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/219] mailbox: qcom-ipcc: fix incorrect num_chans counting
Date:   Sun, 17 Sep 2023 21:13:08 +0200
Message-ID: <20230917191043.213429803@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit a493208079e299aefdc15169dc80e3da3ebb718a ]

Breaking out early when a match is found leads to an incorrect num_chans
value when more than one ipcc mailbox channel is used by the same device.

Fixes: e9d50e4b4d04 ("mailbox: qcom-ipcc: Dynamic alloc for channel arrangement")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/qcom-ipcc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 7e27acf6c0cca..f597a1bd56847 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -227,10 +227,8 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
 			ret = of_parse_phandle_with_args(client_dn, "mboxes",
 						"#mbox-cells", j, &curr_ph);
 			of_node_put(curr_ph.np);
-			if (!ret && curr_ph.np == controller_dn) {
+			if (!ret && curr_ph.np == controller_dn)
 				ipcc->num_chans++;
-				break;
-			}
 		}
 	}
 
-- 
2.40.1



