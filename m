Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2010B76AF72
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjHAJrg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjHAJrQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F3826B7
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23757614FD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3448CC433C7;
        Tue,  1 Aug 2023 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883146;
        bh=/1HgAWzQ7u0tzSC7w6aBcHD0ePLjlxyM3yJyuM29gN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtbDEoUSpTAwV8XruS0xJQ3ntduCVtuEtozCv+s6rPa7LsmEtXdH/vnXpA++jPlRb
         1Yj3Qy0b5uBIgeZ6239x2g1i4nPbYKBiajWfsw7T4NEqxNdOXWc3sGYPL94+VwojhM
         TClFfbN74V4ZD5nyNvXq/SZy4CFEAS4Ylvx1JlRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 132/239] RDMA/irdma: Report correct WC error
Date:   Tue,  1 Aug 2023 11:19:56 +0200
Message-ID: <20230801091930.463291978@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

[ Upstream commit ae463563b7a1b7d4a3d0b065b09d37a76b693937 ]

Report the correct WC error if a MW bind is performed
on an already valid/bound window.

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20230725155439.1057-2-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 1cfc03da89e7a..457368e324e10 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -191,6 +191,7 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 	case IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS:
 	case IRDMA_AE_AMP_MWBIND_BIND_DISABLED:
 	case IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS:
+	case IRDMA_AE_AMP_MWBIND_VALID_STAG:
 		qp->flush_code = FLUSH_MW_BIND_ERR;
 		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
 		break;
-- 
2.40.1



