Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150A27A3B96
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbjIQUTq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbjIQUTQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:19:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B571F4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:19:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7DFC433C8;
        Sun, 17 Sep 2023 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981950;
        bh=I8qwLVSvqwlIKTOAkZ/7p/v9QfiokpzvX9miXBbY2M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPJE8ruYZUnYso1cBdrJ1ULEDn6QrF2V3owgjr5S916YVULjsVckeChwerkMZgxxR
         7pIP47a0lKjA9q/jN8obK2FV/yRMpCCis3IkmN15TXlqZceLZj5IJoKdFEDN+EsudE
         VgPIEx0bjLQGFIztB0cHjxGbd795QhSPs5iOh3oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 197/219] net: dsa: sja1105: propagate exact error code from sja1105_dynamic_config_poll_valid()
Date:   Sun, 17 Sep 2023 21:15:24 +0200
Message-ID: <20230917191048.064928591@linuxfoundation.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit c956798062b5a308db96e75157747291197f0378 ]

Currently, sja1105_dynamic_config_wait_complete() returns either 0 or
-ETIMEDOUT, because it just looks at the read_poll_timeout() return code.

There will be future changes which move some more checks to
sja1105_dynamic_config_poll_valid(). It is important that we propagate
their exact return code (-ENOENT, -EINVAL), because callers of
sja1105_dynamic_config_read() depend on them.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 7cef293b9a63 ("net: dsa: sja1105: fix multicast forwarding working only for last added mdb entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
index 7729d3f8b7f50..93d47dab8d3e9 100644
--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -1211,13 +1211,14 @@ sja1105_dynamic_config_wait_complete(struct sja1105_private *priv,
 				     struct sja1105_dyn_cmd *cmd,
 				     const struct sja1105_dynamic_table_ops *ops)
 {
-	int rc;
-
-	return read_poll_timeout(sja1105_dynamic_config_poll_valid,
-				 rc, rc != -EAGAIN,
-				 SJA1105_DYNAMIC_CONFIG_SLEEP_US,
-				 SJA1105_DYNAMIC_CONFIG_TIMEOUT_US,
-				 false, priv, cmd, ops);
+	int err, rc;
+
+	err = read_poll_timeout(sja1105_dynamic_config_poll_valid,
+				rc, rc != -EAGAIN,
+				SJA1105_DYNAMIC_CONFIG_SLEEP_US,
+				SJA1105_DYNAMIC_CONFIG_TIMEOUT_US,
+				false, priv, cmd, ops);
+	return err < 0 ? err : rc;
 }
 
 /* Provides read access to the settings through the dynamic interface
-- 
2.40.1



