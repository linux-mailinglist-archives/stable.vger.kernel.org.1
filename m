Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34EF7A7B92
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjITLx3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjITLx0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:53:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2216D92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:53:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B1EC433C9;
        Wed, 20 Sep 2023 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210800;
        bh=FTPkM7qBNY85lgEHBouOnm0QUdNyKd/pZVrLO/9ZZJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYwD+TSLcD88MJ5I5hxa2+Fosgc4nRkqVAvWJSDuAQXoZuUKA1JWgNHgEcsjLxzj5
         RIENaFdaPuavj+2MJYcqG4vZfAafr/wMBp9OmOn+mvjrtn8JCE1LIF0a9tCixxhbpd
         Klb2jC1TVEvBPrJMAVW/lVcJkU/JAygn+SxnQG4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cruise Hung <cruise.hung@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Mustapha Ghaddar <mghaddar@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.5 209/211] drm/amd/display: Fix 2nd DPIA encoder Assignment
Date:   Wed, 20 Sep 2023 13:30:53 +0200
Message-ID: <20230920112852.341132893@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mustapha Ghaddar <mghaddar@amd.com>

commit 29319378449035c6fc6391b31a3c2cbaf75be221 upstream.

[HOW & Why]
There seems to be an issue with 2nd DPIA acquiring link encoder for tiled displays.
Solution is to remove check for eng_id before we get first dynamic encoder for it

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -395,8 +395,7 @@ void link_enc_cfg_link_encs_assign(
 					stream->link->dpia_preferred_eng_id != ENGINE_ID_UNKNOWN)
 				eng_id_req = stream->link->dpia_preferred_eng_id;
 
-			if (eng_id == ENGINE_ID_UNKNOWN)
-				eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
+			eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
 		}
 		else
 			eng_id =  link_enc->preferred_engine;
@@ -501,7 +500,6 @@ struct dc_link *link_enc_cfg_get_link_us
 	if (stream)
 		link = stream->link;
 
-	// dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
 	return link;
 }
 


