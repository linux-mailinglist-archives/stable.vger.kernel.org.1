Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E024E7BDE52
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377023AbjJINSQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377011AbjJINSP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:18:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381FC99
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:18:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DAEC433C7;
        Mon,  9 Oct 2023 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857493;
        bh=yYEsDG/wiJI3s0I741RTq9ca47b5Bhk2dk0BMyNKRDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Q5JBjrJYJhIhKHVDqVy9/zP/57b1IHo+/nK2v6UOX9pgEAibBTX0xwxmNAyEjRGD
         mj0oxBKXXT//bZcnDoStb2vJIxn2Tp1/F6jhdwLYogsG1k6jb23hinuaDfUYMFw19A
         hvjfU5ny/pCVYoydXeTX9scAazMWdKpu+X2k1uA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Jeffery <djeffery@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH 6.1 063/162] md/raid5: release batch_last before waiting for another stripe_head
Date:   Mon,  9 Oct 2023 15:00:44 +0200
Message-ID: <20231009130124.667771053@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Jeffery <djeffery@redhat.com>

commit 2fd7b0f6d5ad655b1d947d3acdd82f687c31465e upstream.

When raid5_get_active_stripe is called with a ctx containing a stripe_head in
its batch_last pointer, it can cause a deadlock if the task sleeps waiting on
another stripe_head to become available. The stripe_head held by batch_last
can be blocking the advancement of other stripe_heads, leading to no
stripe_heads being released so raid5_get_active_stripe waits forever.

Like with the quiesce state handling earlier in the function, batch_last
needs to be released by raid5_get_active_stripe before it waits for another
stripe_head.

Fixes: 3312e6c887fe ("md/raid5: Keep a reference to last stripe_head for batch")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: David Jeffery <djeffery@redhat.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20231002183422.13047-1-djeffery@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -854,6 +854,13 @@ struct stripe_head *raid5_get_active_str
 
 		set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
 		r5l_wake_reclaim(conf->log, 0);
+
+		/* release batch_last before wait to avoid risk of deadlock */
+		if (ctx && ctx->batch_last) {
+			raid5_release_stripe(ctx->batch_last);
+			ctx->batch_last = NULL;
+		}
+
 		wait_event_lock_irq(conf->wait_for_stripe,
 				    is_inactive_blocked(conf, hash),
 				    *(conf->hash_locks + hash));


