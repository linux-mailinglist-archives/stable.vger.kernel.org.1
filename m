Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EB06FA707
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjEHK03 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjEHKZ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D267DDB5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3B7625B3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD79BC433D2;
        Mon,  8 May 2023 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541552;
        bh=AjM985CdZ3WwBdPlkCZ2b4v7aJ2q6YqB8ie2S8+h5rM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1l8h86QMC9Rw6eefBpwuww0BhH9BfE8D9/L6rSmhTnpM4vfxRF6zwsvUf8vn9qpfs
         lLIZHZ0y0ycHSq5x8MJmBhRu88E9dtsGCzP/5t4wOTxDV2EqeYty6a0ZJBUSwTzN80
         2uHSwx1GHNUkvwZKNMBPNBV9svdKbCZRM0Dmcakg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matt Roper <matthew.d.roper@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 134/663] drm/i915/dg2: Drop one PCI ID
Date:   Mon,  8 May 2023 11:39:20 +0200
Message-Id: <20230508094432.880139818@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matt Roper <matthew.d.roper@intel.com>

[ Upstream commit 3a38be31ec82920a871963c086393bc0ba26a655 ]

The bspec was recently updated to remove PCI ID 0x5698; this ID is
actually reserved for future use and should not be treated as DG2-G11.

Bspec: 44477
Fixes: 8618b8489ba6 ("drm/i915: DG2 and ATS-M device ID updates")
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230208200905.680865-1-matthew.d.roper@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/i915_pciids.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 4a4c190f76984..8f648c32a9657 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -706,7 +706,6 @@
 	INTEL_VGA_DEVICE(0x5693, info), \
 	INTEL_VGA_DEVICE(0x5694, info), \
 	INTEL_VGA_DEVICE(0x5695, info), \
-	INTEL_VGA_DEVICE(0x5698, info), \
 	INTEL_VGA_DEVICE(0x56A5, info), \
 	INTEL_VGA_DEVICE(0x56A6, info), \
 	INTEL_VGA_DEVICE(0x56B0, info), \
-- 
2.39.2



