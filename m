Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B16FA729
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjEHK22 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjEHK17 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63CE711
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C92D762626
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD40FC433D2;
        Mon,  8 May 2023 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541650;
        bh=FB5zIdNKUsbBvvRi0nukRLj+XGzkU2XSMGo4o80cqr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2Vt4/bFubkm94gF+4GoKLxeWUex/Ud044y2EVGKPSWejSIFfKJ8bhrIXFaAmUJj+
         hd4r/pTzDBi2NYzJW2rFNWVw/tTS9lehsBmdY+7SmeTUrUpAgxopJAEozHOmW8W+3P
         n3ZsbYLQIPG6+X0BTuBv/A0dicJIu+uMRqLoIKj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 183/663] accel: Link to compute accelerator subsystem intro
Date:   Mon,  8 May 2023 11:40:09 +0200
Message-Id: <20230508094434.376820909@linuxfoundation.org>
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



