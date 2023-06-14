Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F81713EB0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjE1Th4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjE1Thz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:37:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C15C7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C100461E73
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF037C433EF;
        Sun, 28 May 2023 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302673;
        bh=qrD8wfnTTJEc5E/cZKki5LTb+rfZyKWIc3jhkRz6Qb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/ebwPUTPmV8TUHvc85GtNSKvz53vMdEU09tWUtCRZL+DwE/dR8+993QyLwoAd/QN
         EGoNNjoWJgOtc8u3gSanBcjSOOe0AUgEqomqgLFnwDmwTxlmQmZMi9VUXwX8PUJCha
         jLqNzU9adZ6z0KpmsL4C3s6DuopeZPOsDjadcBxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 098/119] ASoC: Intel: avs: Access path components under lock
Date:   Sun, 28 May 2023 20:11:38 +0100
Message-Id: <20230528190838.781692587@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -173,6 +173,7 @@ static bool apl_lp_streaming(struct avs_
 {
 	struct avs_path *path;
 
+	spin_lock(&adev->path_list_lock);
 	/* Any gateway without buffer allocated in LP area disqualifies D0IX. */
 	list_for_each_entry(path, &adev->path_list, node) {
 		struct avs_path_pipeline *ppl;
@@ -192,11 +193,14 @@ static bool apl_lp_streaming(struct avs_
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


