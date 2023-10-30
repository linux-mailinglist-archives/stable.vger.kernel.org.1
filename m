Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DBB7DBF66
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 18:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJ3Rx1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjJ3Rx0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 13:53:26 -0400
X-Greylist: delayed 1198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 10:53:24 PDT
Received: from 9.mo575.mail-out.ovh.net (9.mo575.mail-out.ovh.net [46.105.78.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192D9C
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 10:53:23 -0700 (PDT)
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.1.112])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id EC07D2778D
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 17:17:53 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-7pdj5 (unknown [10.110.115.40])
        by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A3AD81FE93;
        Mon, 30 Oct 2023 17:17:52 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.108])
        by ghost-submission-6684bf9d7b-7pdj5 with ESMTPSA
        id ciZaJEDlP2V+SAEAhpL/bw
        (envelope-from <jose.pekkarinen@foxhound.fi>); Mon, 30 Oct 2023 17:17:52 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-108S002f7264df6-502a-4d3d-8901-f89f427d1744,
                    1521F8BC68C4446D6F30831D87711B1BDC7B9471) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 91.157.109.247
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dillon.varone@amd.com, Jun.Lei@amd.com, aurabindo.pillai@amd.com,
        george.shen@amd.com, samson.tam@amd.com, SyedSaaem.Rizvi@amd.com,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drm/amd/display: remove redundant check
Date:   Mon, 30 Oct 2023 19:17:48 +0200
Message-Id: <20231030171748.35482-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16519484912439764646
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeeftdelueetieetvdettdetueeivedujeefffdvteefkeelhefhleelfeetteejjeenucfkphepuddvjedrtddrtddruddpledurdduheejrddutdelrddvgeejpdefjedrheelrddugedvrddutdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch addresses the following warning spotted by
using coccinelle where the case checked does the same
than the else case.

drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10: WARNING: possible condition with no effect (if == else)

Fixes: 974ce181 ("drm/amd/display: Add check for PState change in DCN32")

Cc: stable@vger.kernel.org
Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ecea008f19d3..d940dfa5ae43 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4661,10 +4661,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
 	} else if (AllowForPStateChangeOrStutterInVBlankFinal == dm_prefetch_support_uclk_fclk_and_stutter) {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 0;
-	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
-			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
-		*MinPrefetchMode = 0;
-		*MaxPrefetchMode = 3;
 	} else {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 3;
-- 
2.39.2

