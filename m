Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313E87B89C9
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbjJDS3S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbjJDS3R (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:29:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C378698
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:29:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1227AC433C8;
        Wed,  4 Oct 2023 18:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444154;
        bh=FMDinPtqb7+KctuzoDP51lE8htaYs12N/yg2HmFppz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqe0a6CjxMtMsSidZykMmGX/xSxBwwYdFO6Pd5C8FwDqi5aupaCj5pjlJTP3FMZmY
         ikL/jZDaxe3Q8Tf/sk//4fom3P/ynrjX2hDDxZh6LhT4AIaU6ctRfrkERoqvqiJc4o
         LpVp6zljRo9UqmANXSj13IC4nJhnep1oOVlYP778=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Charles Kearney <charles.kearney@hpe.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 120/321] spi: spi-gxp: BUG: Correct spi write return value
Date:   Wed,  4 Oct 2023 19:54:25 +0200
Message-ID: <20231004175234.790194065@linuxfoundation.org>
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

From: Charles Kearney <charles.kearney@hpe.com>

[ Upstream commit 1a8196a93e493c0a50b800cb09cef60b124eee15 ]

Bug fix to correct return value of gxp_spi_write function to zero.
Completion of succesful operation should return zero.

Fixes: 730bc8ba5e9e spi: spi-gxp: Add support for HPE GXP SoCs

Signed-off-by: Charles Kearney <charles.kearney@hpe.com>
Link: https://lore.kernel.org/r/20230920215339.4125856-2-charles.kearney@hpe.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-gxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
index 684d63f402f34..aba08d06c251c 100644
--- a/drivers/spi/spi-gxp.c
+++ b/drivers/spi/spi-gxp.c
@@ -195,7 +195,7 @@ static ssize_t gxp_spi_write(struct gxp_spi_chip *chip, const struct spi_mem_op
 		return ret;
 	}
 
-	return write_len;
+	return 0;
 }
 
 static int do_gxp_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.40.1



