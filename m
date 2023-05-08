Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A76FAAC8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjEHLGj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjEHLGN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215033D4D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B49E62AA6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1E1C4339B;
        Mon,  8 May 2023 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543909;
        bh=FB5zIdNKUsbBvvRi0nukRLj+XGzkU2XSMGo4o80cqr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZRH6Jltrx9w79NepjlXYPPs+UGt7HeX9JuTujsUoPFD3tl5a3fMzHpm4UN7ztnfA
         RKD4lxewehUzrRSUs7mOUm3cXrfrdFNVSaxK3KCsbKpNxdITyhDpPT8Z5/HepPdXic
         gXRjH5P3hbfq2K74gVHf0wcmrjiAie9mWg1Y12P8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 213/694] accel: Link to compute accelerator subsystem intro
Date:   Mon,  8 May 2023 11:40:48 +0200
Message-Id: <20230508094439.278092401@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Bagas Sanjaya <bagasdotme@gmail.com>

[ Upstream commit 6d179f84f274a87da51f24ac3e9427221bbaed51 ]

Commit 2c204f3d53218d ("accel: add dedicated minor for accelerator
devices") adds link to accelerator nodes section of DRM internals doc
(Documentation/gpu/drm-internals.rst), but the target doesn't exist.
Instead, there is only an introduction doc for computer accelerator
subsytem.

Link to that doc until there is documentation of accelerator internals.

Fixes: 2c204f3d53218d ("accel: add dedicated minor for accelerator devices")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_file.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0d1f853092ab8..ecffe24e2b1b0 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -408,7 +408,8 @@ static inline bool drm_is_render_client(const struct drm_file *file_priv)
  * Returns true if this is an open file of the compute acceleration node, i.e.
  * &drm_file.minor of @file_priv is a accel minor.
  *
- * See also the :ref:`section on accel nodes <drm_accel_node>`.
+ * See also :doc:`Introduction to compute accelerators subsystem
+ * </accel/introduction>`.
  */
 static inline bool drm_is_accel_client(const struct drm_file *file_priv)
 {
-- 
2.39.2



