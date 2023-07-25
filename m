Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB94376139F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjGYLML (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbjGYLL5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC34626AF
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4E56166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F9C433C8;
        Tue, 25 Jul 2023 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283472;
        bh=oz7/QPtMuVOwe2yBxSsqCPaxyc3ao3wWGv+i6Kv+yH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbPCv6knt8bkufHUTbWQpCb73M9wD4RsATdNMPSfvc5Vi+/VwF9Zuf1cw4PQzz24e
         SGchMAJt/wGeG6G3UH9oKT8XqBr8t7wzR2XZ3TKkS31thsGFtCs9ZIuZC8N1d8HC92
         KwUnZRdzlIKX0TXvNh/aPTAkv8pK5/aq7AHzgiFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10 010/509] drm/amdgpu: Validate VM ioctl flags.
Date:   Tue, 25 Jul 2023 12:39:09 +0200
Message-ID: <20230725104554.111141285@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

commit a2b308044dcaca8d3e580959a4f867a1d5c37fac upstream.

None have been defined yet, so reject anybody setting any. Mesa sets
it to 0 anyway.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3252,6 +3252,10 @@ int amdgpu_vm_ioctl(struct drm_device *d
 	long timeout = msecs_to_jiffies(2000);
 	int r;
 
+	/* No valid flags defined yet */
+	if (args->in.flags)
+		return -EINVAL;
+
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */


