Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E17ED398
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjKOUxi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjKOUxg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:53:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627611A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:53:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB28DC4E77A;
        Wed, 15 Nov 2023 20:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081611;
        bh=zutMOxNYtgpPBd//sHGmNRGRuho/9QjsgS02uqR27xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thgs2d1l26xNTmN/t5Nzal5BoulnK03/3deRymSfEhgNsutp4aYWl7yzMS4F7H0vB
         0rhoDk2zxaqXvu/6JOpOvaAouZPfjA4tlIV+NWnPM6sRe4PW13eywy8oY/BUG+tncJ
         l9jats74DK915RZr2DcezGzFDR2jHqBBQ1+Yd+1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 015/191] mlxsw: Use size_mul() in call to struct_size()
Date:   Wed, 15 Nov 2023 15:44:50 -0500
Message-ID: <20231115204645.422576271@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit e22c6ea025013ae447fe269269753ffec763dde5 ]

If, for any reason, the open-coded arithmetic causes a wraparound, the
protection that `struct_size()` adds against potential integer overflows
is defeated. Fix this by hardening call to `struct_size()` with `size_mul()`.

Fixes: 2285ec872d9d ("mlxsw: spectrum_acl_bloom_filter: use struct_size() in kzalloc()")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index dbd3bebf11eca..2e8b17e3b9358 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -251,7 +251,7 @@ mlxsw_sp_acl_bf_init(struct mlxsw_sp *mlxsw_sp, unsigned int num_erp_banks)
 	 * is 2^ACL_MAX_BF_LOG
 	 */
 	bf_bank_size = 1 << MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_BF_LOG);
-	bf = kzalloc(struct_size(bf, refcnt, bf_bank_size * num_erp_banks),
+	bf = kzalloc(struct_size(bf, refcnt, size_mul(bf_bank_size, num_erp_banks)),
 		     GFP_KERNEL);
 	if (!bf)
 		return ERR_PTR(-ENOMEM);
-- 
2.42.0



