Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8036F78731A
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbjHXPAa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241987AbjHXPAI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B21BE5
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2163670BD
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3FBC433C7;
        Thu, 24 Aug 2023 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889203;
        bh=BaJjNJu5WjowfW36FEg+XIigdjzyfjlt+NoohJy7LOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=om+cIuwWVoRtov2Ja9IXNDri7k1t4cHc2pFaUTSQKc3IyDwKg3eZy55uvDKqdgxGj
         LcW7ujk+kKmdcI1pFvsXW7T8bs1ulpcIGqSH77uM9xCqT06+0ufyu1Btq7eLycjajz
         4P7oTEfrZZpPIz/NBaE1vMgM+8StRwtNEQoWuRls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 051/135] bus: mhi: host: Range check CHDBOFF and ERDBOFF
Date:   Thu, 24 Aug 2023 16:49:54 +0200
Message-ID: <20230824145029.113990101@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jeffrey Hugo <quic_jhugo@quicinc.com>

[ Upstream commit 6a0c637bfee69a74c104468544d9f2a6579626d0 ]

If the value read from the CHDBOFF and ERDBOFF registers is outside the
range of the MHI register space then an invalid address might be computed
which later causes a kernel panic.  Range check the read value to prevent
a crash due to bad data from the device.

Fixes: 6cd330ae76ff ("bus: mhi: core: Add support for ringing channel/event ring doorbells")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1679674384-27209-1-git-send-email-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/host/init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 0d0386f67ffe2..2cc48f96afdbc 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -498,6 +498,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 	}
 
+	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
+		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB));
+		return -ERANGE;
+	}
+
 	/* Setup wake db */
 	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
 	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 4, 0);
@@ -517,6 +523,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 	}
 
+	if (val >= mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings)) {
+		dev_err(dev, "ERDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings));
+		return -ERANGE;
+	}
+
 	/* Setup event db address for each ev_ring */
 	mhi_event = mhi_cntrl->mhi_event;
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
-- 
2.40.1



