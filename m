Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB7713E2A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjE1Tch (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjE1Tcg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009BA8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A916E61DBC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C743AC433EF;
        Sun, 28 May 2023 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302355;
        bh=njPBgyPrNWxrnHbHrzinzv56yGbS6VOLK5FOXExyefI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1IWJAoLCm7ignqoTUhriXybOe/0dRr3gqYJhQjA6VUhZL/PSCyxDuhZiyLt3oAtTw
         lyUP6GkiWNIu/FnkutW46I+nK/woj61LXVo8GbpTkVRZTjJ99q32XeHTK5R6KLcGhS
         +qm5DmZ2KjHKm57QHuhf9LorL7+5XDfzgtA1B9H4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.3 102/127] ASoC: Intel: avs: Access path components under lock
Date:   Sun, 28 May 2023 20:11:18 +0100
Message-Id: <20230528190839.602119150@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

commit d849996f7458042af803b7d15a181922834c5249 upstream.

Path and its components should be accessed under lock to prevent
problems with one thread modifying them while other tries to read.

Fixes: c8c960c10971 ("ASoC: Intel: avs: APL-based platforms support")
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-3-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/avs/apl.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/avs/apl.c
+++ b/sound/soc/intel/avs/apl.c
@@ -169,6 +169,7 @@ static bool apl_lp_streaming(struct avs_
 {
 	struct avs_path *path;
 
+	spin_lock(&adev->path_list_lock);
 	/* Any gateway without buffer allocated in LP area disqualifies D0IX. */
 	list_for_each_entry(path, &adev->path_list, node) {
 		struct avs_path_pipeline *ppl;
@@ -188,11 +189,14 @@ static bool apl_lp_streaming(struct avs_
 				if (cfg->copier.dma_type == INVALID_OBJECT_ID)
 					continue;
 
-				if (!mod->gtw_attrs.lp_buffer_alloc)
+				if (!mod->gtw_attrs.lp_buffer_alloc) {
+					spin_unlock(&adev->path_list_lock);
 					return false;
+				}
 			}
 		}
 	}
+	spin_unlock(&adev->path_list_lock);
 
 	return true;
 }


