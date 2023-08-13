Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4368977AC99
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjHMVez (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjHMVez (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B410E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 538E462CCB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6799CC433C7;
        Sun, 13 Aug 2023 21:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962496;
        bh=Y4ZlPZHJBwFnZkix0rXiDMMLsEtVOyrOMTwhz/E39ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbVS349INl5g/FgLIUjLjp4nV+DLv7JkDxyxIj2Q8uLTpZ6rp0aaW3K1+xaKPzzHl
         9ktcdA+bHCneragD7v0djR5/Xc/ZErD47fc/afakDFUN81LVCsf+WihsL35C+N6ZYH
         k72Ey6lapENL4hO6NYPAV9BHmH5qdEg8leOUi92w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 050/149] drm/amd/display: trigger timing sync only if TG is running
Date:   Sun, 13 Aug 2023 23:18:15 +0200
Message-ID: <20230813211720.314143141@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

commit 6066aaf74f510fc171dbe9375153aee2d60d37aa upstream

[Why&How]
If the timing generator isnt running, it does not make sense to trigger
a sync on the corresponding OTG. Check this condition before starting.
Otherwise, this will cause error like:

*ERROR* GSL: Timeout on reset trigger!

Fixes: dc55b106ad47 ("drm/amd/display: Disable phantom OTG after enable for plane disable")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ NOTE: This is also 5f9f97c02dd2 ("drm/amd/display: trigger timing sync
  only if TG is running") ]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2284,6 +2284,12 @@ void dcn10_enable_timing_synchronization
 		opp = grouped_pipes[i]->stream_res.opp;
 		tg = grouped_pipes[i]->stream_res.tg;
 		tg->funcs->get_otg_active_size(tg, &width, &height);
+
+		if (!tg->funcs->is_tg_enabled(tg)) {
+			DC_SYNC_INFO("Skipping timing sync on disabled OTG\n");
+			return;
+		}
+
 		if (opp->funcs->opp_program_dpg_dimensions)
 			opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
 	}


