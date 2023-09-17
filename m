Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63547A3A32
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbjIQUAA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbjIQT73 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:59:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41F1F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:59:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39562C433C7;
        Sun, 17 Sep 2023 19:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980763;
        bh=Y/TkFpoUER/7l7r59y15FdXJlS49RVh62VhpLpRX+rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUPwvSMBKWuFpLCT0k/+Z3Hvp0v3hwmHzxs9gSyfkSQNLZcBuhIpanQwjzivbvXUG
         QDA8GgbcWatcZL7hY1pS/QwOGiaQz9aLEygTD3Zp0WeUm4OG5rXVWqxskMwyCoZlux
         0pEMObU5uJXMzj3Ck31wmvQli3xXwpVNTSNMkwe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 261/285] net: dsa: sja1105: propagate exact error code from sja1105_dynamic_config_poll_valid()
Date:   Sun, 17 Sep 2023 21:14:21 +0200
Message-ID: <20230917191100.278184777@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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



