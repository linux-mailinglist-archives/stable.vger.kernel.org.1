Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9979BA90
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbjIKWAi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbjIKN7C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:59:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC6CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:58:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB15C433C7;
        Mon, 11 Sep 2023 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440738;
        bh=ugYk4hXk/ZFHMfuxMjHI+dO5Af9uyP12TN/BLKBXAqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/LjOiLuAyW56yA+YTCl8p28WwqpbrvA/u56udHBaU7q+qtMaLtZcDZm4hnr0QKoh
         qVs2cul8akuAvulhwRCrmKdxEbeQmLRBhwzS/H8rVt0S38MUuHtJ0JJjtj1V5M8XRk
         QA0Y0D/O5+jjlttnzw4g4SEmDfavXhe9CcxD42YY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaurav Jain <gaurav.jain@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 141/739] crypto: caam - fix unchecked return value error
Date:   Mon, 11 Sep 2023 15:39:00 +0200
Message-ID: <20230911134655.051476171@linuxfoundation.org>
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

From: Gaurav Jain <gaurav.jain@nxp.com>

[ Upstream commit e30685204711a6be40dec2622606950ccd37dafe ]

error:
Unchecked return value (CHECKED_RETURN)
check_return: Calling sg_miter_next without checking return value

fix:
added check if(!sg_miter_next)

Fixes: 8a2a0dd35f2e ("crypto: caam - strip input zeros from RSA input buffer")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caampkc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 72afc249d42fb..7e08af751e4ea 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -225,7 +225,9 @@ static int caam_rsa_count_leading_zeros(struct scatterlist *sgl,
 		if (len && *buff)
 			break;
 
-		sg_miter_next(&miter);
+		if (!sg_miter_next(&miter))
+			break;
+
 		buff = miter.addr;
 		len = miter.length;
 
-- 
2.40.1



