Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217DE77ABBB
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjHMVZG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHMVZG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0882D10FD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CA062928
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3BBC433C7;
        Sun, 13 Aug 2023 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961906;
        bh=sGCVX2XvXjnUKF5JnjXQ+vR0KXHj6eznL6bBpn3yR3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2CiuqSHsc9FNsOJ0Sg3ysHtY5xnwEiTpRysEP8aAWyWAvdX+BBWaqgrzosbnOGx1
         t76faEqiGopO2L6Tp03YEhB56pUFH88yFhS9UdTtntMwxzacGNNxZ3+xHL9JC66zzD
         dvv8qrh++8bZstpChD/6MK/D89Xpxg2tCtzWMs7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guchun Chen <guchun.chen@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 042/206] drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
Date:   Sun, 13 Aug 2023 23:16:52 +0200
Message-ID: <20230813211726.196614631@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 90e065677e0362a777b9db97ea21d43a39211399 upstream.

Since the gang_size check is outside of chunk parsing
loop, we need to reset i before we free the chunk data.

Suggested by Ye Zhang (@VAR10CK) of Baidu Security.

Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -291,7 +291,7 @@ static int amdgpu_cs_pass1(struct amdgpu
 
 	if (!p->gang_size) {
 		ret = -EINVAL;
-		goto free_partial_kdata;
+		goto free_all_kdata;
 	}
 
 	for (i = 0; i < p->gang_size; ++i) {


