Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4387B70150D
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjEMHlE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjEMHlD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A775FC6
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13034619C8
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9766DC433EF;
        Sat, 13 May 2023 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963661;
        bh=dbkaqXo0ucm5pqJt5iLus9YVT+pv6kN7LikQyCAK5rk=;
        h=Subject:To:Cc:From:Date:From;
        b=unQtDD3pwpSIEMJV/IAFYIOhAypeWCessgaQecmyj9Mt99mq0dxneWEqv80/PzFvp
         XGkbvkMq1CY0gJ/OCYOey93PBH+chBS2f7uXFRW6VLkL5bqw5UNdmyF87tnKcschwm
         Ybh7hKIgi79b1AOwHJb8Me+9iVK9bgKURMe+0XQc=
Subject: FAILED: patch "[PATCH] drm/amd/display: Remove OTG DIV register write for Virtual" failed to apply to 6.3-stable tree
To:     SyedSaaem.Rizvi@amd.com, Alvin.Lee2@amd.com, Samson.Tam@amd.com,
        alexander.deucher@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com, qingqing.zhuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:21:12 +0900
Message-ID: <2023051312-cymbal-mop-58f0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 5d04d13954479292dd45e38a46dfa31abb8dc2e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051312-cymbal-mop-58f0@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

5d04d1395447 ("drm/amd/display: Remove OTG DIV register write for Virtual signals.")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d04d13954479292dd45e38a46dfa31abb8dc2e0 Mon Sep 17 00:00:00 2001
From: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
Date: Mon, 27 Feb 2023 18:55:07 -0500
Subject: [PATCH] drm/amd/display: Remove OTG DIV register write for Virtual
 signals.

[WHY]
Hot plugging and then hot unplugging leads to k1 and k2 values to
change, as signal is detected as a virtual signal on hot unplug. Writing
these values to OTG_PIXEL_RATE_DIV register might cause primary display
to blank (known hw bug).

[HOW]
No longer write k1 and k2 values to register if signal is virtual, we
have safe guards in place in the case that k1 and k2 is unassigned so
that an unknown value is not written to the register either.

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 5016b1313f3d..f9073b722b36 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1111,7 +1111,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 			*k2_div = PIXEL_RATE_DIV_BY_2;
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-	} else if (dc_is_dp_signal(stream->signal) || dc_is_virtual_signal(stream->signal)) {
+	} else if (dc_is_dp_signal(stream->signal)) {
 		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;

