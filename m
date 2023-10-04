Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32947B88B4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjJDSSn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjJDSSi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:18:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBBAAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:18:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA86C433C8;
        Wed,  4 Oct 2023 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443514;
        bh=haZobhCMmNPNuvABAblaq3zKyMuvCOyi8YyCbjuP1r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmF79D4VPznNh2bzp3Q3uRL6UrPSzqg1mfZVaFELGV7Ic3jjKP2EqEiUxOlOSBqo2
         8gA1pZFrcC5n14ZW95bMDKwYjoW3ITjZQ5axNVjByXBQoD2QiKax9PGz4rPJm/JMaW
         8DqO40MnwfctqIwpHn5S/xv7N2v9lMNDaq0JDS40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 183/259] firmware: cirrus: cs_dsp: Only log list of algorithms in debug build
Date:   Wed,  4 Oct 2023 19:55:56 +0200
Message-ID: <20231004175225.699381574@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 69343ce91435f222052015c5af86b550391bac85 ]

Change the logging of each algorithm from info level to debug level.

On the original devices supported by this code there were typically only
one or two algorithms in a firmware and one or two DSPs so this logging
only used a small number of log lines.

However, for the latest devices there could be 30-40 algorithms in a
firmware and 8 DSPs being loaded in parallel, so using 300+ lines of log
for information that isn't particularly important to have logged.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230913160523.3701189-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/cirrus/cs_dsp.c | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 81c5f94b1be11..64ed9d3f5d5d8 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1821,15 +1821,15 @@ static int cs_dsp_adsp2_setup_algs(struct cs_dsp *dsp)
 		return PTR_ERR(adsp2_alg);
 
 	for (i = 0; i < n_algs; i++) {
-		cs_dsp_info(dsp,
-			    "%d: ID %x v%d.%d.%d XM@%x YM@%x ZM@%x\n",
-			    i, be32_to_cpu(adsp2_alg[i].alg.id),
-			    (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff0000) >> 16,
-			    (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff00) >> 8,
-			    be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff,
-			    be32_to_cpu(adsp2_alg[i].xm),
-			    be32_to_cpu(adsp2_alg[i].ym),
-			    be32_to_cpu(adsp2_alg[i].zm));
+		cs_dsp_dbg(dsp,
+			   "%d: ID %x v%d.%d.%d XM@%x YM@%x ZM@%x\n",
+			   i, be32_to_cpu(adsp2_alg[i].alg.id),
+			   (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff0000) >> 16,
+			   (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff00) >> 8,
+			   be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff,
+			   be32_to_cpu(adsp2_alg[i].xm),
+			   be32_to_cpu(adsp2_alg[i].ym),
+			   be32_to_cpu(adsp2_alg[i].zm));
 
 		alg_region = cs_dsp_create_region(dsp, WMFW_ADSP2_XM,
 						  adsp2_alg[i].alg.id,
@@ -1954,14 +1954,14 @@ static int cs_dsp_halo_setup_algs(struct cs_dsp *dsp)
 		return PTR_ERR(halo_alg);
 
 	for (i = 0; i < n_algs; i++) {
-		cs_dsp_info(dsp,
-			    "%d: ID %x v%d.%d.%d XM@%x YM@%x\n",
-			    i, be32_to_cpu(halo_alg[i].alg.id),
-			    (be32_to_cpu(halo_alg[i].alg.ver) & 0xff0000) >> 16,
-			    (be32_to_cpu(halo_alg[i].alg.ver) & 0xff00) >> 8,
-			    be32_to_cpu(halo_alg[i].alg.ver) & 0xff,
-			    be32_to_cpu(halo_alg[i].xm_base),
-			    be32_to_cpu(halo_alg[i].ym_base));
+		cs_dsp_dbg(dsp,
+			   "%d: ID %x v%d.%d.%d XM@%x YM@%x\n",
+			   i, be32_to_cpu(halo_alg[i].alg.id),
+			   (be32_to_cpu(halo_alg[i].alg.ver) & 0xff0000) >> 16,
+			   (be32_to_cpu(halo_alg[i].alg.ver) & 0xff00) >> 8,
+			   be32_to_cpu(halo_alg[i].alg.ver) & 0xff,
+			   be32_to_cpu(halo_alg[i].xm_base),
+			   be32_to_cpu(halo_alg[i].ym_base));
 
 		ret = cs_dsp_halo_create_regions(dsp, halo_alg[i].alg.id,
 						 halo_alg[i].alg.ver,
-- 
2.40.1



