Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD47876A3
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbjHXRSE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbjHXRRv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BDB1993
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15C6267371
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257F8C433C7;
        Thu, 24 Aug 2023 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897468;
        bh=mockgQqDLqmvjw7/atApLHseIKKqiAb6oh7orAKDCRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SM2GCIsZQOSv1b4iC2ifY5UuVWDHOwEzuYR1A8bXetVESN7R1xVn3/X0gHJ39lJTR
         dgOR+lLPdIiwvqwglvY1BUUygU0Rpr1+EJaj2sOBu+MR2WjLbZ547bsT/fiVaQL/6o
         17fIbcZoaux641rswkbXkCiWpDYv9IXx9+G3yAKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 049/135] bus: mhi: Add MMIO region length to controller structure
Date:   Thu, 24 Aug 2023 19:08:41 +0200
Message-ID: <20230824170619.282068485@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

[ Upstream commit baa7a08569358d9d16e71ce36f287c39a665d776 ]

Make controller driver specify the MMIO register region length
for range checking of BHI or BHIe space. This can help validate
that offsets are in acceptable memory region or not and avoid any
boot-up issues due to BHI or BHIe memory accesses.

Link: https://lore.kernel.org/r/1620330705-40192-4-git-send-email-bbhatt@codeaurora.org
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20210802051255.5771-6-manivannan.sadhasivam@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 6a0c637bfee6 ("bus: mhi: host: Range check CHDBOFF and ERDBOFF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mhi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d4841e5a5f458..5d9f8c6f3d40f 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -303,6 +303,7 @@ struct mhi_controller_config {
  * @rddm_size: RAM dump size that host should allocate for debugging purpose
  * @sbl_size: SBL image size downloaded through BHIe (optional)
  * @seg_len: BHIe vector size (optional)
+ * @reg_len: Length of the MHI MMIO region (required)
  * @fbc_image: Points to firmware image buffer
  * @rddm_image: Points to RAM dump buffer
  * @mhi_chan: Points to the channel configuration table
@@ -383,6 +384,7 @@ struct mhi_controller {
 	size_t rddm_size;
 	size_t sbl_size;
 	size_t seg_len;
+	size_t reg_len;
 	struct image_info *fbc_image;
 	struct image_info *rddm_image;
 	struct mhi_chan *mhi_chan;
-- 
2.40.1



