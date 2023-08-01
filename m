Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E649276AEDC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjHAJmh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjHAJmZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB75B98
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD016151C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88187C433C8;
        Tue,  1 Aug 2023 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882798;
        bh=yKDvqHR7T0FSWMpV0dFske5p3OC0K1EEr0nAJOCfDUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvk/BY2ceOWCRjZ7r1/8rI0jY+DAcFUqhgfxkUDnoOWVXz9aOHECJ39vax0HjwC63
         wrVR/ztrBglgimtdh+agNBGcvFEQw2WFhs51Aul0S8+R/nbrAbxkvxeXN8IC0x3dj4
         Yhxt7L5/RnruU2aBRsM2yW8kv07/Hfcp6cXkP5rA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Jeffery <djeffery@redhat.com>,
        Joe Thornber <ejt@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.1 213/228] dm cache policy smq: ensure IO doesnt prevent cleaner policy progress
Date:   Tue,  1 Aug 2023 11:21:11 +0200
Message-ID: <20230801091930.553879927@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

commit 1e4ab7b4c881cf26c1c72b3f56519e03475486fb upstream.

When using the cleaner policy to decommission the cache, there is
never any writeback started from the cache as it is constantly delayed
due to normal I/O keeping the device busy. Meaning @idle=false was
always being passed to clean_target_met()

Fix this by adding a specific 'cleaner' flag that is set when the
cleaner policy is configured. This flag serves to always allow the
cleaner's writeback work to be queued until the cache is
decommissioned (even if the cache isn't idle).

Reported-by: David Jeffery <djeffery@redhat.com>
Fixes: b29d4986d0da ("dm cache: significant rework to leverage dm-bio-prison-v2")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-cache-policy-smq.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -855,7 +855,13 @@ struct smq_policy {
 
 	struct background_tracker *bg_work;
 
-	bool migrations_allowed;
+	bool migrations_allowed:1;
+
+	/*
+	 * If this is set the policy will try and clean the whole cache
+	 * even if the device is not idle.
+	 */
+	bool cleaner:1;
 };
 
 /*----------------------------------------------------------------*/
@@ -1136,7 +1142,7 @@ static bool clean_target_met(struct smq_
 	 * Cache entries may not be populated.  So we cannot rely on the
 	 * size of the clean queue.
 	 */
-	if (idle) {
+	if (idle || mq->cleaner) {
 		/*
 		 * We'd like to clean everything.
 		 */
@@ -1719,11 +1725,9 @@ static void calc_hotspot_params(sector_t
 		*hotspot_block_size /= 2u;
 }
 
-static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
-					    sector_t origin_size,
-					    sector_t cache_block_size,
-					    bool mimic_mq,
-					    bool migrations_allowed)
+static struct dm_cache_policy *
+__smq_create(dm_cblock_t cache_size, sector_t origin_size, sector_t cache_block_size,
+	     bool mimic_mq, bool migrations_allowed, bool cleaner)
 {
 	unsigned int i;
 	unsigned int nr_sentinels_per_queue = 2u * NR_CACHE_LEVELS;
@@ -1810,6 +1814,7 @@ static struct dm_cache_policy *__smq_cre
 		goto bad_btracker;
 
 	mq->migrations_allowed = migrations_allowed;
+	mq->cleaner = cleaner;
 
 	return &mq->policy;
 
@@ -1833,21 +1838,24 @@ static struct dm_cache_policy *smq_creat
 					  sector_t origin_size,
 					  sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, true, false);
 }
 
 static struct dm_cache_policy *mq_create(dm_cblock_t cache_size,
 					 sector_t origin_size,
 					 sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, true, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    true, true, false);
 }
 
 static struct dm_cache_policy *cleaner_create(dm_cblock_t cache_size,
 					      sector_t origin_size,
 					      sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, false);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, false, true);
 }
 
 /*----------------------------------------------------------------*/


