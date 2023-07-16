Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1C7553EA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjGPUY0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGPUY0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E99F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9974260E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB60C433C7;
        Sun, 16 Jul 2023 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539064;
        bh=qBtFdp1e0jD2FRtzRfkBKuXgyCv21xJRn5GLJe3/Aww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9gwUVc9xrSHLKe+WNW99MZghRKJSBxMspiJs4aKjIT7ROokNtR3ceBvXKZUyE9S7
         tD5Bkr6S7IcY75RlewYX0ukgSb+FpM01f6myzgXq3ZcdPM7e8nxqJdEX2EwZY5meSS
         2WrP+fGKNfYLHFyartTRiIXSiAtiUbON0p4bQTjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Habets <habetsm.xilinx@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 675/800] sfc: support for devlink port requires MAE access
Date:   Sun, 16 Jul 2023 21:48:48 +0200
Message-ID: <20230716195004.803308064@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Martin Habets <habetsm.xilinx@gmail.com>

[ Upstream commit 915057ae79692d47f9fb3504785855be49abaea4 ]

On systems without MAE permission efx->mae is not initialised,
and trying to lookup an mport results in a NULL pointer
dereference.

Fixes: 25414b2a64ae ("sfc: add devlink port support for ef100")
Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/efx_devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index ef9971cbb695d..0384b134e1242 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -622,6 +622,9 @@ static struct devlink_port *ef100_set_devlink_port(struct efx_nic *efx, u32 idx)
 	u32 id;
 	int rc;
 
+	if (!efx->mae)
+		return NULL;
+
 	if (efx_mae_lookup_mport(efx, idx, &id)) {
 		/* This should not happen. */
 		if (idx == MAE_MPORT_DESC_VF_IDX_NULL)
-- 
2.39.2



