Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5C478AA8C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjH1KXW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjH1KWn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A6122
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9BD63956
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9748C433C7;
        Mon, 28 Aug 2023 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218151;
        bh=xXoyrM+fzErGoWcDhp9KGlfQpmFCtYz+J07oCviPflM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbKZhmhJKUBPeuQAlPMWVO4xUP4df44CoWibQ/vVACQCjb+8duERTiFjB6ml8utK1
         lGWuP8cwAqmWNfCOqp0ClZ9FbxeJg6uIqvrhBgLQefeQVlrzeLIEETG6Y7Tu6AS0nK
         4cEviUQgIUHJ/UUgICaQsKA6mTHI/YZHqg1jvyWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Manivannan Sadhasivam <mani@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 114/129] scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW major version > 5
Date:   Mon, 28 Aug 2023 12:13:13 +0200
Message-ID: <20230828101201.156567196@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <neil.armstrong@linaro.org>

commit c422fbd5cb58c9a078172ae1e9750971b738a197 upstream.

The qunipro_g4_sel clear is also needed for new platforms with major
version > 5. Fix the version check to take this into account.

Fixes: 9c02aa24bf40 ("scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW version major 5")
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230821-topic-sm8x50-upstream-ufs-major-5-plus-v2-1-f42a4b712e58@linaro.org
Reviewed-by: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/host/ufs-qcom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -225,7 +225,7 @@ static void ufs_qcom_select_unipro_mode(
 		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
 		   REG_UFS_CFG1);
 
-	if (host->hw_ver.major == 0x05)
+	if (host->hw_ver.major >= 0x05)
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
 
 	/* make sure above configuration is applied before we return */


