Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE387037DD
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbjEORYl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbjEORY1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874D11608
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 980CD620F5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89314C433EF;
        Mon, 15 May 2023 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171398;
        bh=doUGeYeK5D6hC+5KFMRRy2mVHjf3LgxF2nqwGpUT1Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1QuLC0j4ry3mxTN0qIExh5gl155ft2NtKhIBwW2D1gXzBvVRJu6rYIotuWIFUk9t
         11fQzusdatBckcVWvOED8O2GxAOxA3kvk93KunL0+fekN37M96tPWoNAC37kkKlHbg
         GBRhBkRQjw/rJciapZ1535lRvWHimKffGId9ClI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
        Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.2 196/242] drm/amdgpu/jpeg: Remove harvest checking for JPEG3
Date:   Mon, 15 May 2023 18:28:42 +0200
Message-Id: <20230515161727.825961259@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

commit 5b94db73e45e2e6c2840f39c022fd71dfa47fc58 upstream.

Register CC_UVD_HARVESTING is obsolete for JPEG 3.1.2

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -54,6 +54,7 @@ static int jpeg_v3_0_early_init(void *ha
 
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(3, 1, 1):
+	case IP_VERSION(3, 1, 2):
 		break;
 	default:
 		harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);


