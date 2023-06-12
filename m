Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB3572C0E6
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbjFLKzV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjFLKys (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E8F2950
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F02E612B4
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54747C433EF;
        Mon, 12 Jun 2023 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566498;
        bh=EPrfcgyRH+Dolm41hnT1O4r/UhrJRvhHIXD5AOPeF+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arcHUDT6ZsEHuspOKqFG/lqMVnX+RCusu3UdFcLbx/AgQY93E+9zfFVZwWRDlY/Uo
         jG7gAQukdNpqrknLWtkyJOltFYFFsGl1CXZYscQjztih6rwsPdzOEDW9FzhGMzcArX
         O3BWGBQUKU/tM5zhCNh1gj0ien44nLaFp+RIFPVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 054/132] bnxt_en: Query default VLAN before VNIC setup on a VF
Date:   Mon, 12 Jun 2023 12:26:28 +0200
Message-ID: <20230612101712.720787724@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Somnath Kotur <somnath.kotur@broadcom.com>

[ Upstream commit 1a9e4f501bc6ff1b6ecb60df54fbf2b54db43bfe ]

We need to call bnxt_hwrm_func_qcfg() on a VF to query the default
VLAN that may be setup by the PF.  If a default VLAN is enabled,
the VF cannot support VLAN acceleration on the receive side and
the VNIC must be setup to strip out the default VLAN tag.  If a
default VLAN is not enabled, the VF can support VLAN acceleration
on the receive side.  The VNIC should be set up to strip or not
strip the VLAN based on the RX VLAN acceleration setting.

Without this call to determine the default VLAN before calling
bnxt_setup_vnic(), the VNIC may not be set up correctly.  For
example, bnxt_setup_vnic() may set up to strip the VLAN tag based
on stale default VLAN information.  If RX VLAN acceleration is
not enabled, the VLAN tag will be incorrectly stripped and the
RX data path will not work correctly.

Fixes: cf6645f8ebc6 ("bnxt_en: Add function for VF driver to query default VLAN.")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e3e5a427222f6..93c3b8316c46a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8808,6 +8808,9 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		goto err_out;
 	}
 
+	if (BNXT_VF(bp))
+		bnxt_hwrm_func_qcfg(bp);
+
 	rc = bnxt_setup_vnic(bp, 0);
 	if (rc)
 		goto err_out;
-- 
2.39.2



