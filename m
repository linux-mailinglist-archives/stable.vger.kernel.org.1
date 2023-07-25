Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC85A761626
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjGYLg6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjGYLgv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13519BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30AF46166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7C7C433C7;
        Tue, 25 Jul 2023 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284999;
        bh=B/zaJyWRtJTaQig9V1mXmcp0qBFPE/7hjoqWFcup0ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBF97e+4Wo1c/7xcqCbXWavUTLrj2yW7VrNMgEbamep79tpG8novKZoI2l3O4GyVW
         oe84Tx+6Zt/cHebWOsercD7kOZFhre0BzwzwIJv/0moa9XWbRyI/g37rt3IryX4q6g
         qwoLXu49rB3Zgp1u1u5JtdlU4R12p3GI9Iv8Qo/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 047/313] wifi: ray_cs: Drop useless status variable in parse_addr()
Date:   Tue, 25 Jul 2023 12:43:20 +0200
Message-ID: <20230725104523.105119956@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 4dfc63c002a555a2c3c34d89009532ad803be876 ]

The status variable assigned only once and used also only once.
Replace it's usage by actual value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220603164414.48436-2-andriy.shevchenko@linux.intel.com
Stable-dep-of: 4f8d66a9fb2e ("wifi: ray_cs: Fix an error handling path in ray_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ray_cs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 29dd303a7beae..be2d599536cd5 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -1643,7 +1643,6 @@ static int parse_addr(char *in_str, UCHAR *out)
 {
 	int i, k;
 	int len;
-	int status;
 
 	if (in_str == NULL)
 		return 0;
@@ -1652,7 +1651,6 @@ static int parse_addr(char *in_str, UCHAR *out)
 		return 0;
 	memset(out, 0, ADDRLEN);
 
-	status = 1;
 	i = 5;
 
 	while (len > 0) {
@@ -1670,7 +1668,7 @@ static int parse_addr(char *in_str, UCHAR *out)
 		if (!i--)
 			break;
 	}
-	return status;
+	return 1;
 }
 
 /*===========================================================================*/
-- 
2.39.2



