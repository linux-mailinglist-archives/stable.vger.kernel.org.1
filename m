Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD57A3B93
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbjIQUTq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbjIQUTX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:19:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F74F4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:19:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481D0C433C9;
        Sun, 17 Sep 2023 20:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981957;
        bh=Hz5E8IdhQqvW8pmiX2wABcPkRWvWRxLx3W0tRpkxf58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nd05krKVg+ddqPTgDSUF1fxvLO4HBAszI4lfHrd0lP9Q8D7s2xUJyTMdRDp1nflRO
         +3bTmpQG1nRrReQBn/kvVIZqPGqvr8U2CQLpKiRM9sHXeYutgMWmzahtmymHRA2Wyx
         dfotBX6jpnCRwXoAw4g96ju8zdUhuaOHiFdDioPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yanan Yang <yanan.yang@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 198/219] net: dsa: sja1105: fix multicast forwarding working only for last added mdb entry
Date:   Sun, 17 Sep 2023 21:15:25 +0200
Message-ID: <20230917191048.105167413@linuxfoundation.org>
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

[ Upstream commit 7cef293b9a634a05fcce9e1df4aee3aeed023345 ]

The commit cited in Fixes: did 2 things: it refactored the read-back
polling from sja1105_dynamic_config_read() into a new function,
sja1105_dynamic_config_wait_complete(), and it called that from
sja1105_dynamic_config_write() too.

What is problematic is the refactoring.

The refactored code from sja1105_dynamic_config_poll_valid() works like
the previous one, but the problem is that it uses another packed_buf[]
SPI buffer, and there was code at the end of sja1105_dynamic_config_read()
which was relying on the read-back packed_buf[]:

	/* Don't dereference possibly NULL pointer - maybe caller
	 * only wanted to see whether the entry existed or not.
	 */
	if (entry)
		ops->entry_packing(packed_buf, entry, UNPACK);

After the change, the packed_buf[] that this code sees is no longer the
entry read back from hardware, but the original entry that the caller
passed to the sja1105_dynamic_config_read(), packed into this buffer.

This difference is the most notable with the SJA1105_SEARCH uses from
sja1105pqrs_fdb_add() - used for both fdb and mdb. There, we have logic
added by commit 728db843df88 ("net: dsa: sja1105: ignore the FDB entry
for unknown multicast when adding a new address") to figure out whether
the address we're trying to add matches on any existing hardware entry,
with the exception of the catch-all multicast address.

That logic was broken, because with sja1105_dynamic_config_read() not
working properly, it doesn't return us the entry read back from
hardware, but the entry that we passed to it. And, since for multicast,
a match will always exist, it will tell us that any mdb entry already
exists at index=0 L2 Address Lookup table. It is index=0 because the
caller doesn't know the index - it wants to find it out, and
sja1105_dynamic_config_read() does:

	if (index < 0) { // SJA1105_SEARCH
		/* Avoid copying a signed negative number to an u64 */
		cmd.index = 0; // <- this
		cmd.search = true;
	} else {
		cmd.index = index;
		cmd.search = false;
	}

So, to the caller of sja1105_dynamic_config_read(), the returned info
looks entirely legit, and it will add all mdb entries to FDB index 0.
There, they will always overwrite each other (not to mention,
potentially they can also overwrite a pre-existing bridge fdb entry),
and the user-visible impact will be that only the last mdb entry will be
forwarded as it should. The others won't (will be flooded or dropped,
depending on the egress flood settings).

Fixing is a bit more complicated, and involves either passing the same
packed_buf[] to sja1105_dynamic_config_wait_complete(), or moving all
the extra processing on the packed_buf[] to
sja1105_dynamic_config_wait_complete(). I've opted for the latter,
because it makes sja1105_dynamic_config_wait_complete() a bit more
self-contained.

Fixes: df405910ab9f ("net: dsa: sja1105: wait for dynamic config command completion on writes too")
Reported-by: Yanan Yang <yanan.yang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/dsa/sja1105/sja1105_dynamic_config.c  | 80 +++++++++----------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
index 93d47dab8d3e9..984c0e604e8de 100644
--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -1175,18 +1175,15 @@ const struct sja1105_dynamic_table_ops sja1110_dyn_ops[BLK_IDX_MAX_DYN] = {
 
 static int
 sja1105_dynamic_config_poll_valid(struct sja1105_private *priv,
-				  struct sja1105_dyn_cmd *cmd,
-				  const struct sja1105_dynamic_table_ops *ops)
+				  const struct sja1105_dynamic_table_ops *ops,
+				  void *entry, bool check_valident,
+				  bool check_errors)
 {
 	u8 packed_buf[SJA1105_MAX_DYN_CMD_SIZE] = {};
+	struct sja1105_dyn_cmd cmd = {};
 	int rc;
 
-	/* We don't _need_ to read the full entry, just the command area which
-	 * is a fixed SJA1105_SIZE_DYN_CMD. But our cmd_packing() API expects a
-	 * buffer that contains the full entry too. Additionally, our API
-	 * doesn't really know how many bytes into the buffer does the command
-	 * area really begin. So just read back the whole entry.
-	 */
+	/* Read back the whole entry + command structure. */
 	rc = sja1105_xfer_buf(priv, SPI_READ, ops->addr, packed_buf,
 			      ops->packed_size);
 	if (rc)
@@ -1195,11 +1192,25 @@ sja1105_dynamic_config_poll_valid(struct sja1105_private *priv,
 	/* Unpack the command structure, and return it to the caller in case it
 	 * needs to perform further checks on it (VALIDENT).
 	 */
-	memset(cmd, 0, sizeof(*cmd));
-	ops->cmd_packing(packed_buf, cmd, UNPACK);
+	ops->cmd_packing(packed_buf, &cmd, UNPACK);
 
 	/* Hardware hasn't cleared VALID => still working on it */
-	return cmd->valid ? -EAGAIN : 0;
+	if (cmd.valid)
+		return -EAGAIN;
+
+	if (check_valident && !cmd.valident && !(ops->access & OP_VALID_ANYWAY))
+		return -ENOENT;
+
+	if (check_errors && cmd.errors)
+		return -EINVAL;
+
+	/* Don't dereference possibly NULL pointer - maybe caller
+	 * only wanted to see whether the entry existed or not.
+	 */
+	if (entry)
+		ops->entry_packing(packed_buf, entry, UNPACK);
+
+	return 0;
 }
 
 /* Poll the dynamic config entry's control area until the hardware has
@@ -1208,8 +1219,9 @@ sja1105_dynamic_config_poll_valid(struct sja1105_private *priv,
  */
 static int
 sja1105_dynamic_config_wait_complete(struct sja1105_private *priv,
-				     struct sja1105_dyn_cmd *cmd,
-				     const struct sja1105_dynamic_table_ops *ops)
+				     const struct sja1105_dynamic_table_ops *ops,
+				     void *entry, bool check_valident,
+				     bool check_errors)
 {
 	int err, rc;
 
@@ -1217,7 +1229,8 @@ sja1105_dynamic_config_wait_complete(struct sja1105_private *priv,
 				rc, rc != -EAGAIN,
 				SJA1105_DYNAMIC_CONFIG_SLEEP_US,
 				SJA1105_DYNAMIC_CONFIG_TIMEOUT_US,
-				false, priv, cmd, ops);
+				false, priv, ops, entry, check_valident,
+				check_errors);
 	return err < 0 ? err : rc;
 }
 
@@ -1287,25 +1300,14 @@ int sja1105_dynamic_config_read(struct sja1105_private *priv,
 	mutex_lock(&priv->dynamic_config_lock);
 	rc = sja1105_xfer_buf(priv, SPI_WRITE, ops->addr, packed_buf,
 			      ops->packed_size);
-	if (rc < 0) {
-		mutex_unlock(&priv->dynamic_config_lock);
-		return rc;
-	}
-
-	rc = sja1105_dynamic_config_wait_complete(priv, &cmd, ops);
-	mutex_unlock(&priv->dynamic_config_lock);
 	if (rc < 0)
-		return rc;
+		goto out;
 
-	if (!cmd.valident && !(ops->access & OP_VALID_ANYWAY))
-		return -ENOENT;
+	rc = sja1105_dynamic_config_wait_complete(priv, ops, entry, true, false);
+out:
+	mutex_unlock(&priv->dynamic_config_lock);
 
-	/* Don't dereference possibly NULL pointer - maybe caller
-	 * only wanted to see whether the entry existed or not.
-	 */
-	if (entry)
-		ops->entry_packing(packed_buf, entry, UNPACK);
-	return 0;
+	return rc;
 }
 
 int sja1105_dynamic_config_write(struct sja1105_private *priv,
@@ -1357,22 +1359,14 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
 	mutex_lock(&priv->dynamic_config_lock);
 	rc = sja1105_xfer_buf(priv, SPI_WRITE, ops->addr, packed_buf,
 			      ops->packed_size);
-	if (rc < 0) {
-		mutex_unlock(&priv->dynamic_config_lock);
-		return rc;
-	}
-
-	rc = sja1105_dynamic_config_wait_complete(priv, &cmd, ops);
-	mutex_unlock(&priv->dynamic_config_lock);
 	if (rc < 0)
-		return rc;
+		goto out;
 
-	cmd = (struct sja1105_dyn_cmd) {0};
-	ops->cmd_packing(packed_buf, &cmd, UNPACK);
-	if (cmd.errors)
-		return -EINVAL;
+	rc = sja1105_dynamic_config_wait_complete(priv, ops, NULL, false, true);
+out:
+	mutex_unlock(&priv->dynamic_config_lock);
 
-	return 0;
+	return rc;
 }
 
 static u8 sja1105_crc8_add(u8 crc, u8 byte, u8 poly)
-- 
2.40.1



