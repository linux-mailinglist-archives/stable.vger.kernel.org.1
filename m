Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209677A3A36
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbjIQUAG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbjIQT7j (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:59:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FCEE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:59:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD7EC433C8;
        Sun, 17 Sep 2023 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980774;
        bh=JXbuv8xzCrtIJliXqQOe0gj2JxD2APhy0dL+VzL7t2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P794QZu4fWAJjiCP6pe72MvRThgok4ZFRjop9AjJ97fflynL5Xg143pY4BeMdX8C7
         qV10wJDfe+oQMybEsYP0BKzR3PJFzNkUeu7f/DN/g9BuzaZxscCY5LBR9QXBaouEl2
         IHaHshiXS6DWHEVKG4nabVfIKuV7k5SD8k1VraJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 264/285] net: dsa: sja1105: block FDB accesses that are concurrent with a switch reset
Date:   Sun, 17 Sep 2023 21:14:24 +0200
Message-ID: <20230917191100.361496015@linuxfoundation.org>
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

[ Upstream commit 86899e9e1e29e854b5f6dcc24ba4f75f792c89aa ]

Currently, when we add the first sja1105 port to a bridge with
vlan_filtering 1, then we sometimes see this output:

sja1105 spi2.2: port 4 failed to read back entry for be:79:b4:9e:9e:96 vid 3088: -ENOENT
sja1105 spi2.2: Reset switch and programmed static config. Reason: VLAN filtering
sja1105 spi2.2: port 0 failed to add be:79:b4:9e:9e:96 vid 0 to fdb: -2

It is because sja1105_fdb_add() runs from the dsa_owq which is no longer
serialized with switch resets since it dropped the rtnl_lock() in the
blamed commit.

Either performing the FDB accesses before the reset, or after the reset,
is equally fine, because sja1105_static_fdb_change() backs up those
changes in the static config, but FDB access during reset isn't ok.

Make sja1105_static_config_reload() take the fdb_lock to fix that.

Fixes: 0faf890fc519 ("net: dsa: drop rtnl_lock from dsa_slave_switchdev_event_work")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 79927191ac623..013976b0af9f1 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2304,6 +2304,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	int rc, i;
 	s64 now;
 
+	mutex_lock(&priv->fdb_lock);
 	mutex_lock(&priv->mgmt_lock);
 
 	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
@@ -2416,6 +2417,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 		goto out;
 out:
 	mutex_unlock(&priv->mgmt_lock);
+	mutex_unlock(&priv->fdb_lock);
 
 	return rc;
 }
-- 
2.40.1



