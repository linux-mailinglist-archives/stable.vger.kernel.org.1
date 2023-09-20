Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77727A7C89
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjITMCQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjITMCM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:02:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EECFD8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:02:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A426CC433C7;
        Wed, 20 Sep 2023 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211326;
        bh=BYW8HUiBF0kyh11FNsD+N4QIkPpCb+62heK35vtFuvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geexigheZhcU0sUyx9Cp4+lUOTZZlrzJBFMTGepH1SY8qe6g13mcajeT9Nz4nveBe
         iuJtPNhEM2MdDfa7SPrle91TNWEKX24deRc/nUPAaHYcmYRbm3ps97mSiV6FjTeqEZ
         3eTBzpRRxwj5rAXedoW9d+10QJiJVcV2DwIye5FM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaurav Jain <gaurav.jain@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/186] crypto: caam - fix unchecked return value error
Date:   Wed, 20 Sep 2023 13:29:07 +0200
Message-ID: <20230920112838.529221033@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 6f3f81bb880b5..01f9053db287b 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -194,7 +194,9 @@ static int caam_rsa_count_leading_zeros(struct scatterlist *sgl,
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



