Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2B7B8A33
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbjJDSdN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244377AbjJDSdM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:33:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AE3C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:33:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E4BC433C9;
        Wed,  4 Oct 2023 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444388;
        bh=pj2fRPnMmakSEcLxwnARoHmuEWJ6GVa54oTLcWuoc5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssorkt25Wu4nGwJq2NOYbXlnClmJVUqhni5g9mGH/KIHcMnJsHT9wjQBBoyknG8ax
         ZMZ8tP9BDwq0uWJyWl15z22QwjzZz3rVQ61dKOmpFmn9A7+Dt4waY6r+uMnQJr1sW0
         i4kX/ryqtoOhAZ296YT3zI+kIVAwYUi9N34EAi1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 232/321] gfs2: fix glock shrinker ref issues
Date:   Wed,  4 Oct 2023 19:56:17 +0200
Message-ID: <20231004175239.980052992@linuxfoundation.org>
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

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit 62862485a4c3a52029fc30f4bdde9af04afdafc9 ]

Before this patch, function gfs2_scan_glock_lru would only try to free
glocks that had a reference count of 0. But if the reference count ever
got to 0, the glock should have already been freed.

Shrinker function gfs2_dispose_glock_lru checks whether glocks on the
LRU are demote_ok, and if so, tries to demote them. But that's only
possible if the reference count is at least 1.

This patch changes gfs2_scan_glock_lru so it will try to demote and/or
dispose of glocks that have a reference count of 1 and which are either
demotable, or are already unlocked.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 1438e7465e306..59c1aed0b9b90 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2017,7 +2017,9 @@ static long gfs2_scan_glock_lru(int nr)
 		if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
 			if (!spin_trylock(&gl->gl_lockref.lock))
 				continue;
-			if (!gl->gl_lockref.count) {
+			if (gl->gl_lockref.count <= 1 &&
+			    (gl->gl_state == LM_ST_UNLOCKED ||
+			     demote_ok(gl))) {
 				list_move(&gl->gl_lru, &dispose);
 				atomic_dec(&lru_count);
 				freed++;
-- 
2.40.1



