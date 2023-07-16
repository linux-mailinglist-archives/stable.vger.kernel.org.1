Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883D8755479
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjGPUar (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjGPUaq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB2E45
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE1FC60EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB05C433C8;
        Sun, 16 Jul 2023 20:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539442;
        bh=7cc0PnaJmdFU76YjjptSHjlQuxq+M58aSoWEzgtEz9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJxX29Ojgkr1nGTl7hPcttMncwoBn4tWztF3Ax7mkauG8Amcl21jquVl2936l+M+T
         zPzdDoFgsDYohAq1kQkuo0Sj+XatHcS0k0s+tmGantVfXh8EWKNVnrA94iOKEfRsig
         V2Ojn76cu4VTxiqzfzfyvLfKKpS3+FmGF81KQhUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jani Nikula <jani.nikula@linux.intel.com>,
        Jeff Layton <jlayton@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [PATCH 6.1 001/591] drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2
Date:   Sun, 16 Jul 2023 21:42:20 +0200
Message-ID: <20230716194923.904478972@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 54d217406afe250d7a768783baaa79a035f21d38 upstream.

I've been experiencing some intermittent crashes down in the display
driver code. The symptoms are ususally a line like this in dmesg:

    amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 000000006d3a3885: -5

...followed by an Oops due to a NULL pointer dereference.

Switch to using mgr->dev instead of state->dev since "state" can be
NULL in some cases.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2184855
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230419112447.18471-1-jlayton@kernel.org
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3404,7 +3404,7 @@ int drm_dp_add_payload_part2(struct drm_
 
 	/* Skip failed payloads */
 	if (payload->vc_start_slot == -1) {
-		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
+		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
 			    payload->port->connector->name);
 		return -EIO;
 	}


