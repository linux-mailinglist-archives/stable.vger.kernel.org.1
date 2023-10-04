Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385097B8AA6
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244323AbjJDShb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbjJDShb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:37:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D505BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:37:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC603C433C7;
        Wed,  4 Oct 2023 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444647;
        bh=XWedYxNZ2aBZq2rjpxEn4K+p2nD8XMnGX9IaUkOwZ4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuJkRpifnCE4NYwcHj7pP61ioDadVS/58YOSBY1/QMngsLCYy4yqyWjW71kA2S9+E
         EmtMps11R8ET0HZb+Hb5iC7PJ4iwSnwL8se5oop6E2eDXQXO+slLVrP3WsznGE6aW8
         9S+SeVJPA4FhS8cyRki6oK043QSnDQGafmv4pjzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.5 307/321] i915: Limit the length of an sg list to the requested length
Date:   Wed,  4 Oct 2023 19:57:32 +0200
Message-ID: <20231004175243.523582072@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit 863a8eb3f27098b42772f668e3977ff4cae10b04 upstream.

The folio conversion changed the behaviour of shmem_sg_alloc_table() to
put the entire length of the last folio into the sg list, even if the sg
list should have been shorter.  gen8_ggtt_insert_entries() relied on the
list being the right length and would overrun the end of the page tables.
Other functions may also have been affected.

Clamp the length of the last entry in the sg list to be the expected
length.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 0b62af28f249 ("i915: convert shmem_sg_free_table() to use a folio_batch")
Cc: stable@vger.kernel.org # 6.5.x
Link: https://gitlab.freedesktop.org/drm/intel/-/issues/9256
Link: https://lore.kernel.org/lkml/6287208.lOV4Wx5bFT@natalenko.name/
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230919194855.347582-1-willy@infradead.org
(cherry picked from commit 26a8e32e6d77900819c0c730fbfb393692dbbeea)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 8f1633c3fb93..73a4a4eb29e0 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -100,6 +100,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	st->nents = 0;
 	for (i = 0; i < page_count; i++) {
 		struct folio *folio;
+		unsigned long nr_pages;
 		const unsigned int shrink[] = {
 			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
 			0,
@@ -150,6 +151,8 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			}
 		} while (1);
 
+		nr_pages = min_t(unsigned long,
+				folio_nr_pages(folio), page_count - i);
 		if (!i ||
 		    sg->length >= max_segment ||
 		    folio_pfn(folio) != next_pfn) {
@@ -157,13 +160,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 				sg = sg_next(sg);
 
 			st->nents++;
-			sg_set_folio(sg, folio, folio_size(folio), 0);
+			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
 		} else {
 			/* XXX: could overflow? */
-			sg->length += folio_size(folio);
+			sg->length += nr_pages * PAGE_SIZE;
 		}
-		next_pfn = folio_pfn(folio) + folio_nr_pages(folio);
-		i += folio_nr_pages(folio) - 1;
+		next_pfn = folio_pfn(folio) + nr_pages;
+		i += nr_pages - 1;
 
 		/* Check that the i965g/gm workaround works. */
 		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >= 0x00100000UL);
-- 
2.42.0



