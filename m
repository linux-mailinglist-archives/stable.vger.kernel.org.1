Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5076AF62
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjHAJrA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjHAJqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67E910E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C816150C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71072C433C9;
        Tue,  1 Aug 2023 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883115;
        bh=WllhNuc1gDmBtDiE2Gcqukbw4COGXIC2Z1Z9agtAi8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUSCULs+8QTSBzuPqjSNpgerm955S4/6Npu2SBFp67+rDlrqsw/vjf6Zj3/3xAOKh
         k6eNWBBGOV/HiLsWSzpjD6h/zSPEJ/ccMw8y7oJ/lpFRhPm4RPkXxpeY1zUUmADThQ
         awnbEG/F5UyIgA/GBtqCHHl+slcZEZFlNnWvb9uM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Breno Leitao <leitao@debian.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 120/239] cxl/acpi: Return rc instead of 0 in cxl_parse_cfmws()
Date:   Tue,  1 Aug 2023 11:19:44 +0200
Message-ID: <20230801091930.042448907@linuxfoundation.org>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 91019b5bc7c2c5e6f676cce80ee6d12b2753d018 ]

Driver initialization returned success (return 0) even if the
initialization (cxl_decoder_add() or acpi_table_parse_cedt()) failed.

Return the error instead of swallowing it.

Fixes: f4ce1f766f1e ("cxl/acpi: Convert CFMWS parsing to ACPI sub-table helpers")
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20230714093146.2253438-2-leitao@debian.org
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 973d6747078c9..8757bf886207b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -297,7 +297,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
 		dev_err(dev, "Failed to add decode range: %pr", res);
-		return 0;
+		return rc;
 	}
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
 		dev_name(&cxld->dev),
-- 
2.40.1



