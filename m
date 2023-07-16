Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCB07556B4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjGPUxM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjGPUxM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CAB10D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E98A560E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04941C433C9;
        Sun, 16 Jul 2023 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540790;
        bh=hKNWUXNZcOWVuU1YDo7CVRHECdh+lhkt/o3IYjMKjcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAq2+m8/mQOOD7HXNzmOXRI71IGb2RgJWjtcVNvJgFraYVzVw2Cg5Q2z+M2WZIGil
         2ZPaTt2Q2Bp54hgT2HMn0S6R+3lokFHiRi0PYNR6kPNMFMpHOoJ9jzt6xw6Vy0yD6C
         RoXI6cVs3Lwu9UDRnzzDLzdOz5DI526XUH3nN/ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 488/591] mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init
Date:   Sun, 16 Jul 2023 21:50:27 +0200
Message-ID: <20230716194936.519359049@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit 08fc75735fda3be97194bfbf3c899c87abb3d0fe ]

The line cards array is not freed in the error path of
mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
freeing the array in the error path, thereby making the error path
identical to mlxsw_m_linecards_fini().

Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20230630012647.1078002-1-shaozhengchao@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/minimal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
index 55b3c42bb0071..15116d9305f8e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
@@ -430,6 +430,7 @@ static int mlxsw_m_linecards_init(struct mlxsw_m *mlxsw_m)
 err_kmalloc_array:
 	for (i--; i >= 0; i--)
 		kfree(mlxsw_m->line_cards[i]);
+	kfree(mlxsw_m->line_cards);
 err_kcalloc:
 	kfree(mlxsw_m->ports);
 	return err;
-- 
2.39.2



