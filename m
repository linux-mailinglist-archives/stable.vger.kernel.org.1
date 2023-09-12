Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCED79BF9B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350421AbjIKViL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbjIKN7x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:59:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C6CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:59:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D50EC433C8;
        Mon, 11 Sep 2023 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440788;
        bh=homkzxdMdrk8VOnJLAnbNMLLO6VDijDRXkzL58KGs1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEdyjJZH4OKEbcd3xXi2QC9iZcmX4dYzHK2ioLf5qm6AKbt6ON2PcJME5umghqUxM
         0LaoOvHZp8QzxL39UXrBO9mDMZiDfNOmyCYuIB0W5t3hyOdh/Vb5WNrWR5KvVavex+
         yDgpgPs9zDuaZVR5e+WJJwdQtr/W1iFGwAMhVwsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vadim Pasternak <vadimp@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 185/739] mlxsw: i2c: Limit single transaction buffer size
Date:   Mon, 11 Sep 2023 15:39:44 +0200
Message-ID: <20230911134656.361920735@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vadim Pasternak <vadimp@nvidia.com>

[ Upstream commit d7248f1cc835bd80e936dc5b2d94b149bdd0077d ]

Maximum size of buffer is obtained from underlying I2C adapter and in
case adapter allows I2C transaction buffer size greater than 100 bytes,
transaction will fail due to firmware limitation.

As a result driver will fail initialization.

Limit the maximum size of transaction buffer by 100 bytes to fit to
firmware.

Remove unnecessary calculation:
max_t(u16, MLXSW_I2C_BLK_DEF, quirk_size).
This condition can not happened.

Fixes: 3029a693beda ("mlxsw: i2c: Allow flexible setting of I2C transactions size")
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index 47af7ef7e4eee..d23f293e285cb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -48,6 +48,7 @@
 #define MLXSW_I2C_MBOX_SIZE_BITS	12
 #define MLXSW_I2C_ADDR_BUF_SIZE		4
 #define MLXSW_I2C_BLK_DEF		32
+#define MLXSW_I2C_BLK_MAX		100
 #define MLXSW_I2C_RETRY			5
 #define MLXSW_I2C_TIMEOUT_MSECS		5000
 #define MLXSW_I2C_MAX_DATA_SIZE		256
@@ -653,7 +654,7 @@ static int mlxsw_i2c_probe(struct i2c_client *client)
 			return -EOPNOTSUPP;
 		}
 
-		mlxsw_i2c->block_size = max_t(u16, MLXSW_I2C_BLK_DEF,
+		mlxsw_i2c->block_size = min_t(u16, MLXSW_I2C_BLK_MAX,
 					      min_t(u16, quirks->max_read_len,
 						    quirks->max_write_len));
 	} else {
-- 
2.40.1



