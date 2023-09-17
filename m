Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A28E7A3B9F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbjIQUUR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbjIQUTr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:19:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F09101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:19:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D716C433C8;
        Sun, 17 Sep 2023 20:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981982;
        bh=eyUaPxDvoBiSihAEMziXLBnWMtiD1hYaMGJpwl7jGIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inPiWdk97AmhAKU7xVsw2dbRsr1wBulB50WZeU+WgbvR3QMc0wyig6rnaHH1sohmq
         c1V/zAymMsdA0p210s1LY7F3kpd4iMoNnOpAtdGeDXBWWEMIXR24jPJ6Pi0189eose
         MJfkpRFo9iIYOR1/hbfwKLo6GPU6SldRfwtzQ45s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 201/219] r8152: check budget for r8152_poll()
Date:   Sun, 17 Sep 2023 21:15:28 +0200
Message-ID: <20230917191048.205044060@linuxfoundation.org>
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

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit a7b8d60b37237680009dd0b025fe8c067aba0ee3 ]

According to the document of napi, there is no rx process when the
budget is 0. Therefore, r8152_poll() has to return 0 directly when the
budget is equal to 0.

Fixes: d2187f8e4454 ("r8152: divide the tx and rx bottom functions")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 059d610901d84..fc1458f96e170 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2628,6 +2628,9 @@ static int r8152_poll(struct napi_struct *napi, int budget)
 	struct r8152 *tp = container_of(napi, struct r8152, napi);
 	int work_done;
 
+	if (!budget)
+		return 0;
+
 	work_done = rx_bottom(tp, budget);
 
 	if (work_done < budget) {
-- 
2.40.1



