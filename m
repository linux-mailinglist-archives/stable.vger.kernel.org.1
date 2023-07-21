Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D175CEDB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGUQZL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjGUQYy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249013C2B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39BD461D1E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB02C43397;
        Fri, 21 Jul 2023 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956463;
        bh=tgFzvKUHYoeAKS0GWZZZ+yXSaLZV1Ogk6qV2XcgO2DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1PbsFtH4AEoQFyG1MKx3Uf/GVfbFxCkSyuzdZHP2RXXgnJAFPXgZXYQzMp4RU35r
         4WicLRnpJzQoma9x9SEm5fQZ9gtjegOxX12C+v1a5wkN4IoKnw8sGSGai0132PVOHf
         LLbxjXH+E0FYC3AAYrMTXFpDz5QjYEDdWE7MeyUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Leo Chen <sancchen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 202/292] drm/amd/display: disable seamless boot if force_odm_combine is enabled
Date:   Fri, 21 Jul 2023 18:05:11 +0200
Message-ID: <20230721160537.560584988@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Leo Chen <sancchen@amd.com>

commit 26518b39181876064850209ecdab48c0ee5924b1 upstream.

[Why & How]
Having seamless boot on while forcing debug option ODM combine 2 to 1
will cause some corruptions because of some missing programmings.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1602,6 +1602,9 @@ bool dc_validate_boot_timing(const struc
 		return false;
 	}
 
+	if (dc->debug.force_odm_combine)
+		return false;
+
 	/* Check for enabled DIG to identify enabled display */
 	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
 		return false;


