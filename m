Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF86726C12
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjFGUaj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjFGUaV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE661BFF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D2E644D5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9EAC433EF;
        Wed,  7 Jun 2023 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169799;
        bh=bYPKqGOexa4zdEV/V5Y5C6t6OzRwdDLELThUrPFcnr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iorvsdvQyCgJpl4e9qYQgESDyBuDIlHvhl+TGnEVgLEmndSJefudndPYCewuyiB6M
         lPs4KIc1wJVfg6cNWoKTxPTZQ+bPsXhw10aWYZvPqDU19V/u1lOeY8iWNGGs5z0dSB
         Z2670f/jlP0FAO9X/Fh/82zI6EqguwauD+VQFL14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 218/286] drm/amdgpu: enable tmz by default for GC 11.0.1
Date:   Wed,  7 Jun 2023 22:15:17 +0200
Message-ID: <20230607200930.400902246@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>

commit 663b930e24842f3d3bb79418bb5cd8d01b40c559 upstream.

Add IP GC 11.0.1 in the list of target to have
tmz enabled by default.

Signed-off-by: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -534,6 +534,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_de
 	case IP_VERSION(9, 3, 0):
 	/* GC 10.3.7 */
 	case IP_VERSION(10, 3, 7):
+	/* GC 11.0.1 */
+	case IP_VERSION(11, 0, 1):
 		if (amdgpu_tmz == 0) {
 			adev->gmc.tmz_enabled = false;
 			dev_info(adev->dev,
@@ -557,7 +559,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_de
 	case IP_VERSION(10, 3, 1):
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
-	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
 		/* Don't enable it by default yet.
 		 */


