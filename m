Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844767BE0A8
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377389AbjJINmg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377381AbjJINmf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:42:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA79C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:42:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CCEC433CD;
        Mon,  9 Oct 2023 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858953;
        bh=IkBBfBHdIUb0IcnIxYaw4dhWoPL6i3nR2XwSqIpmdIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAgwsPzU1KxWQzpbMQU3FPeNR5Dqj1wRColfKPMwfp6prqyMBlaH/0MUmB6GOieBd
         AJHFK0mqQJov6UlNnVk7BTABnI4EjLN0Lx6JGKadk3LXSs7bhpxhRL0xrYrlG89/vG
         g7XlVLA/Q+HINdpCf6u7A0lUr3r2f/wpdSSdVOgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        David Hildenbrand <david@redhat.com>,
        Yikebaer Aizezi <yikebaer61@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 124/226] media: vb2: frame_vector.c: replace WARN_ONCE with a comment
Date:   Mon,  9 Oct 2023 15:01:25 +0200
Message-ID: <20231009130130.016752643@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 735de5caf79e06cc9fb96b1b4f4974674ae3e917 ]

The WARN_ONCE was issued also in cases that had nothing to do with VM_IO
(e.g. if the start address was just a random value and uaccess fails with
-EFAULT).

There are no reports of WARN_ONCE being issued for actual VM_IO cases, so
just drop it and instead add a note to the comment before the function.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/frame_vector.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index 0e589a9a88012..1cd81d38ad2d0 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -29,6 +29,10 @@
  * different type underlying the specified range of virtual addresses.
  * When the function isn't able to map a single page, it returns error.
  *
+ * Note that get_vaddr_frames() cannot follow VM_IO mappings. It used
+ * to be able to do that, but that could (racily) return non-refcounted
+ * pfns.
+ *
  * This function takes care of grabbing mmap_lock as necessary.
  */
 int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
@@ -77,8 +81,6 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 			goto out;
 	}
 
-	/* This used to (racily) return non-refcounted pfns. Let people know */
-	WARN_ONCE(1, "get_vaddr_frames() cannot follow VM_IO mapping");
 	vec->nr_frames = 0;
 
 out:
-- 
2.40.1



