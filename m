Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2041D75CEA0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGUQWS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGUQVj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA949D5
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B790E61D3D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8544EC433AB;
        Fri, 21 Jul 2023 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956374;
        bh=lx0sYJ6p8HimMD0ZHfKMauYEW5ljtaNrXSpa2sHPqTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aH2LhNRYGSLBdY2QUV91mLSba0/TCIqSdlvod6uUJgCyApMn5wgz3W2yTQitL7Yts
         bqZoNEtNiIQBF8f6mqOATOw9NMO8jFHxArVjCfVg7stmqaeodfoK/e+0ySc0hLwzY1
         jdn4x4qtifYE1K8rpjNd6V3Psc+BERvcUKf4LUR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.4 160/292] soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup
Date:   Fri, 21 Jul 2023 18:04:29 +0200
Message-ID: <20230721160535.779053898@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Marangi <ansuelsmth@gmail.com>

commit bcb889891371c3cf767f2b9e8768cfe2fdd3810f upstream.

Commit ebeb20a9cd3f ("soc: qcom: mdt_loader: Always invoke PAS
mem_setup") dropped the relocate check and made pas_mem_setup run
unconditionally. The code was later moved with commit f4e526ff7e38
("soc: qcom: mdt_loader: Extract PAS operations") to
qcom_mdt_pas_init() effectively losing track of what was actually
done.

The assumption that PAS mem_setup can be done anytime was effectively
wrong, with no good reason and this caused regression on some SoC
that use remoteproc to bringup ath11k. One example is IPQ8074 SoC that
effectively broke resulting in remoteproc silently die and ath11k not
working.

On this SoC FW relocate is not enabled and PAS mem_setup was correctly
skipped in previous kernel version resulting in correct bringup and
function of remoteproc and ath11k.

To fix the regression, reintroduce the relocate check in
qcom_mdt_pas_init() and correctly skip PAS mem_setup where relocate is
not enabled.

Fixes: ebeb20a9cd3f ("soc: qcom: mdt_loader: Always invoke PAS mem_setup")
Tested-by: Robert Marko <robimarko@gmail.com>
Co-developed-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230526115511.3328-1-ansuelsmth@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/mdt_loader.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -210,6 +210,7 @@ int qcom_mdt_pas_init(struct device *dev
 	const struct elf32_hdr *ehdr;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
+	bool relocate = false;
 	size_t metadata_len;
 	void *metadata;
 	int ret;
@@ -224,6 +225,9 @@ int qcom_mdt_pas_init(struct device *dev
 		if (!mdt_phdr_valid(phdr))
 			continue;
 
+		if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
+			relocate = true;
+
 		if (phdr->p_paddr < min_addr)
 			min_addr = phdr->p_paddr;
 
@@ -246,11 +250,13 @@ int qcom_mdt_pas_init(struct device *dev
 		goto out;
 	}
 
-	ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
-	if (ret) {
-		/* Unable to set up relocation */
-		dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
-		goto out;
+	if (relocate) {
+		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
+		if (ret) {
+			/* Unable to set up relocation */
+			dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
+			goto out;
+		}
 	}
 
 out:


