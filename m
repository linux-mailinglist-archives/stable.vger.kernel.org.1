Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958857B89A0
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbjJDS1d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244224AbjJDS1c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:27:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3BC1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:27:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96B6C433CA;
        Wed,  4 Oct 2023 18:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444044;
        bh=R1mUvpqov8KW19G7tEh6Bw+dLStodwvSEyyH7S4yJDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZ6kMn8pJ6NmULfGl0ch+2QvaIYeCr9S0AKvacXr9z7ATpsfb4m3WKE8+ncAP7Oum
         dzHaTAJd3W+NcA1+IqVhCWvNOg30xdiiSkBmnINndfvIN1pGFVmSugK89Z2NNwBrU3
         5YWprWNCcqbCNiM/V41wXK7GsvFxYB1egKc9Zfjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 110/321] i2c: xiic: Correct return value check for xiic_reinit()
Date:   Wed,  4 Oct 2023 19:54:15 +0200
Message-ID: <20231004175234.327676019@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Scally <dan.scally@ideasonboard.com>

[ Upstream commit 59851fb05d759f13662be143eff0aae605815b0e ]

The error paths for xiic_reinit() return negative values on failure
and 0 on success - this error message therefore is triggered on
_success_ rather than failure. Correct the condition so it's only
shown on failure as intended.

Fixes: 8fa9c9388053 ("i2c: xiic: return value of xiic_reinit")
Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-xiic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index b3bb97762c859..71391b590adae 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -710,7 +710,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 		 * reset the IP instead of just flush fifos
 		 */
 		ret = xiic_reinit(i2c);
-		if (!ret)
+		if (ret < 0)
 			dev_dbg(i2c->adap.dev.parent, "reinit failed\n");
 
 		if (i2c->rx_msg) {
-- 
2.40.1



