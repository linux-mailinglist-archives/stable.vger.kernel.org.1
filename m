Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A1735398
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjFSKqv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjFSKqQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00CA1982
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69B4860670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77208C433C8;
        Mon, 19 Jun 2023 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171561;
        bh=5SRHxz0VzTHZQEDld0p6FNwZpQKvc3mUFFQLp1lMavM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdFjSsmH1ptEEMldTpFG+JSBqUqBv3oCjJ88USlWdWsFlYUvBdts3tkoyQnQPeHvc
         9g/+uhqZ4ZatvvDKWS5K5MZ70B+SO0mupMQ6F9/ZGLaAQPuq+Q5Kwj0lGYP2nR0viJ
         oVnarBqC6Of/DTdQKKqcJSoYswWKjod/LuqkhuNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, michel@daenzer.net,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 075/166] drm/amdgpu: add missing radeon secondary PCI ID
Date:   Mon, 19 Jun 2023 12:29:12 +0200
Message-ID: <20230619102158.406902835@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit e61f67749b351c19455ce3085af2ae9af80023bc upstream.

0x5b70 is a missing RV370 secondary id.  Add it so
we don't try and probe it with amdgpu.

Cc: michel@daenzer.net
Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>
Tested-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1605,6 +1605,7 @@ static const u16 amdgpu_unsupported_pcii
 	0x5874,
 	0x5940,
 	0x5941,
+	0x5b70,
 	0x5b72,
 	0x5b73,
 	0x5b74,


