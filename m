Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F979B1A0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbjIKVRe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbjIKN7u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:59:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61BCD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:59:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75692C433C8;
        Mon, 11 Sep 2023 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440785;
        bh=3t2BoGaPyniXSBiB40EU5084WlX1WgTgzE1ta99Kg0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0JlEFFsbugGevA0ZbJcNjFDTuAlEPN2emSNkXfQ2GlNtGXuNWvhu3IMPZuKcu3r9t
         L72c8whk2vBugcdfvNasAEsAdlbySqwhQJd8qOsQqkhvEEpycDob3d4YDwu4dhQA6J
         WZGaS4KlNArkLty4dhkDLuR1oqNysE8MPhiX9Ug4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vadim Pasternak <vadimp@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 184/739] mlxsw: i2c: Fix chunk size setting in output mailbox buffer
Date:   Mon, 11 Sep 2023 15:39:43 +0200
Message-ID: <20230911134656.335653245@linuxfoundation.org>
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

[ Upstream commit 146c7c330507c0384bf29d567186632bfe975927 ]

The driver reads commands output from the output mailbox. If the size
of the output mailbox is not a multiple of the transaction /
block size, then the driver will not issue enough read transactions
to read the entire output, which can result in driver initialization
errors.

Fix by determining the number of transactions using DIV_ROUND_UP().

Fixes: 3029a693beda ("mlxsw: i2c: Allow flexible setting of I2C transactions size")
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index 41298835a11e1..47af7ef7e4eee 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -444,7 +444,7 @@ mlxsw_i2c_cmd(struct device *dev, u16 opcode, u32 in_mod, size_t in_mbox_size,
 	} else {
 		/* No input mailbox is case of initialization query command. */
 		reg_size = MLXSW_I2C_MAX_DATA_SIZE;
-		num = reg_size / mlxsw_i2c->block_size;
+		num = DIV_ROUND_UP(reg_size, mlxsw_i2c->block_size);
 
 		if (mutex_lock_interruptible(&mlxsw_i2c->cmd.lock) < 0) {
 			dev_err(&client->dev, "Could not acquire lock");
-- 
2.40.1



