Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0977A7DB5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjITMLj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjITMLh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:11:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5FAFB
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:11:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC135C433C8;
        Wed, 20 Sep 2023 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211888;
        bh=vukZFeq21dUfQA8lr0mMtuQdOi/JVGiNAcE9BPH/LL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrmA+P7ygjt5oaTd8J0bKIHBit+bPJpJpMUiJmrTpfT7Lg1TdzUDDAZiJTy6yzYmr
         1u9IOOCvTJxVlM6HhlBrZeEVeRD7T4zqWl8euLqMAiqsyH3eaVtuSCS/eC7CAV3hqo
         SpgWdUboh+rkj0R9EAxyqaFk7L484M6/tPt82FSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengguang Xu <cgxu519@zoho.com.cn>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/273] quota: avoid increasing DQST_LOOKUPS when iterating over dirty/inuse list
Date:   Wed, 20 Sep 2023 13:28:33 +0200
Message-ID: <20230920112848.716766950@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengguang Xu <cgxu519@zoho.com.cn>

[ Upstream commit 05848db2083d4f232e84e385845dcd98d5c511b2 ]

It is meaningless to increase DQST_LOOKUPS number while iterating
over dirty/inuse list, so just avoid it.

Link: https://lore.kernel.org/r/20190926083408.4269-1-cgxu519@zoho.com.cn
Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
Signed-off-by: Jan Kara <jack@suse.cz>
Stable-dep-of: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 01bec330d54b1..50aaa5b0706e8 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -594,7 +594,6 @@ int dquot_scan_active(struct super_block *sb,
 		/* Now we have active dquot so we can just increase use count */
 		atomic_inc(&dquot->dq_count);
 		spin_unlock(&dq_list_lock);
-		dqstats_inc(DQST_LOOKUPS);
 		dqput(old_dquot);
 		old_dquot = dquot;
 		/*
@@ -649,7 +648,6 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 			 * use count */
 			dqgrab(dquot);
 			spin_unlock(&dq_list_lock);
-			dqstats_inc(DQST_LOOKUPS);
 			err = sb->dq_op->write_dquot(dquot);
 			if (err) {
 				/*
-- 
2.40.1



