Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F29A713E91
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjE1Tgo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjE1Tgn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322FA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50DBB61E43
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEAFC4339B;
        Sun, 28 May 2023 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302601;
        bh=lmhsUYHYcurU8VICbyaQ8xb9bQ9uleMxwfjXVYCnCpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzplkH/9qE6oUuZKPBk31GhMZoOOsGxWjcCgWK33hmuWjQFpnA/+T2JSfbr7gS1qt
         NEs16zWKDGlKp4LHGCdcJBA5yhjjJThqP86oB0TXhP25xaIowva0FLDZwt9U4I4+Yl
         qVmgQpfOF8lie+IqjBbconk4IY2POGzP9z5i1/dM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 042/119] drm/radeon: reintroduce radeon_dp_work_func content
Date:   Sun, 28 May 2023 20:10:42 +0100
Message-Id: <20230528190836.787090458@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit a34fc1bcd2c4d8b09dcfc0b95ac65bca1e579bd7 upstream.

Put back the radeon_dp_work_func logic.  It seems that
handling DP RX interrupts is necessary to make some
panels work.  This was removed with the MST support,
but it regresses some systems so add it back.  While
we are here, add the proper mutex locking.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2567
Fixes: 01ad1d9c2888 ("drm/radeon: Drop legacy MST support")
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_irq_kms.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -100,6 +100,16 @@ static void radeon_hotplug_work_func(str
 
 static void radeon_dp_work_func(struct work_struct *work)
 {
+	struct radeon_device *rdev = container_of(work, struct radeon_device,
+						  dp_work);
+	struct drm_device *dev = rdev->ddev;
+	struct drm_mode_config *mode_config = &dev->mode_config;
+	struct drm_connector *connector;
+
+	mutex_lock(&mode_config->mutex);
+	list_for_each_entry(connector, &mode_config->connector_list, head)
+		radeon_connector_hotplug(connector);
+	mutex_unlock(&mode_config->mutex);
 }
 
 /**


