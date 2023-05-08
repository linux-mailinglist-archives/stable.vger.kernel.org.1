Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728526FA438
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjEHJ4v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjEHJ4p (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B662E2ABF9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 960D16224E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA2C433D2;
        Mon,  8 May 2023 09:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539802;
        bh=n1IcSOAvQll2yh0jpLbA8jk4DZOpWW+3pcW7KM2DQYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rzn05nrGVCh39+KEJ+IADb9sd3j2v03iS+703jGLRsvvVgawzCrEPnK6Xr7N2g3ZH
         sR2ziBchvhqTa/Zwbxu52v1sB4aIhQWKeqI+l6vSpzkUPuQJCHDVXPw8UijAtz4GJJ
         Tnuvievd8EGNKuQ43kO8RM3CT0PejaNeHg6bQkJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.1 111/611] bus: mhi: host: Range check CHDBOFF and ERDBOFF
Date:   Mon,  8 May 2023 11:39:13 +0200
Message-Id: <20230508094425.869952558@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Jeffrey Hugo <quic_jhugo@quicinc.com>

commit 6a0c637bfee69a74c104468544d9f2a6579626d0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/host/init.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -516,6 +516,12 @@ int mhi_init_mmio(struct mhi_controller
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
 	mhi_cntrl->wake_set = false;
@@ -532,6 +538,12 @@ int mhi_init_mmio(struct mhi_controller
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


