Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5648D77AC93
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjHMVen (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjHMVem (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452A10FE
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 702E562CB5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8050BC433C7;
        Sun, 13 Aug 2023 21:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962480;
        bh=KEYt2EZeQuv+8xak4srLqg77f8XzZPeeclI6iBcWDlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aoSCukdoHcKZjB3toojMeOpgzuCUnPiXLORM33M94H/wzrNm2YjHPhEZTHZPxgnJp
         JYkmA/iwFLP/JRYdIo1SZtSh6W+6VkmsnmpZyj8+IGh/cv/W8SVtb/whWmr0WDCD/U
         MN10RhkzVV7nFbGDLMVj3gQJ+zlq0UVaO326I5kE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 044/149] drm/amd/display: Update OTG instance in the commit stream
Date:   Sun, 13 Aug 2023 23:18:09 +0200
Message-ID: <20230813211720.131313503@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

commit eef019eabc3cd0fddcffefbf67806a4d8cca29bb upstream

OTG instance is not updated in dc_commit_state_no_check for newly
committed streams because mode_change is not set. Notice that OTG update
is part of the software state, and after hardware programming, it must
be updated; for this reason, this commit updates the OTG offset right
after hardware programming.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1995,6 +1995,12 @@ enum dc_status dc_commit_streams(struct
 
 	res = dc_commit_state_no_check(dc, context);
 
+	for (i = 0; i < stream_count; i++) {
+		for (j = 0; j < context->stream_count; j++)
+			if (streams[i]->stream_id == context->streams[j]->stream_id)
+				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+	}
+
 fail:
 	dc_release_state(context);
 


