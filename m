Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684026FAA5F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjEHLCh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjEHLBz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:01:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF1B2E83F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDD2262A18
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40E5C433EF;
        Mon,  8 May 2023 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543651;
        bh=8RvZ6CD/urFKyt593xqQj3UCzzjSscO1V/dj00aDjqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZsOltj171vfCZIqcnK9/2NEiXZzZKtjH0CoHpZRHT345Thr7HtKzxhyJ7PDj8AtY
         AqwTEq9SNwHPnGk9Uyle9PoVb+KSAd66a6ns2qvXCO7+i1jU+Ba1k83I4kcTyrEG+a
         9irZSJL/E5xR9rrDRg6a4abtx1PD8Xb0/sm7D6Y8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nicolas Frayer <nfrayer@baylibre.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Nishanth Menon <nm@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 158/694] soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_dual_ring()
Date:   Mon,  8 May 2023 11:39:53 +0200
Message-Id: <20230508094437.548405453@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicolas Frayer <nfrayer@baylibre.com>

[ Upstream commit 5f1732a8683c1da8faaa90d6ffc3bd6d33013a58 ]

When the k3 ring accelerator driver has been modified to add module build
support, try_module_get() and module_put() have been added to update the
module refcnt. One code path has not been updated and it has introduced
an issue where the refcnt is decremented by module_put() in
k3_ringacc_ring_free() without being incremented previously.
Adding try_module_get() to k3_dmaring_request_dual_ring() ensures the
refcnt is kept up to date.

Fixes: c07f216a8b72 ("soc: ti: k3-ringacc: Allow the driver to be built as module")
Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20221230001404.10902-1-nfrayer@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/k3-ringacc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index e01e4d815230a..8f131368a7586 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -406,6 +406,11 @@ static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
 
 	mutex_lock(&ringacc->req_lock);
 
+	if (!try_module_get(ringacc->dev->driver->owner)) {
+		ret = -EINVAL;
+		goto err_module_get;
+	}
+
 	if (test_bit(fwd_id, ringacc->rings_inuse)) {
 		ret = -EBUSY;
 		goto error;
@@ -421,6 +426,8 @@ static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
 	return 0;
 
 error:
+	module_put(ringacc->dev->driver->owner);
+err_module_get:
 	mutex_unlock(&ringacc->req_lock);
 	return ret;
 }
-- 
2.39.2



