Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76B7B8A22
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbjJDScj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244358AbjJDSci (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:32:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0EC0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:32:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9993FC433C7;
        Wed,  4 Oct 2023 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444355;
        bh=WbyUb9hQSP+KvgTHuICnKU8XUshq9I99ixAO++GGUeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/tS9ZzDT0DumkC86E+QsKIYEP1HWorcbei8haXQHBU1vkR+y9QKwLlt0BjSe4gRJ
         LQr+sKC/4909Jn2KH0JlW5HP0bWgp32P5mZHNix7Zkt+W7zKX2c7hHWoDsOzA0AXvH
         C7W5c+jp34xtJO8/npgo4yXsrjnEHWH1EGl7GqyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        David Hildenbrand <david@redhat.com>,
        Yikebaer Aizezi <yikebaer61@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 221/321] media: vb2: frame_vector.c: replace WARN_ONCE with a comment
Date:   Wed,  4 Oct 2023 19:56:06 +0200
Message-ID: <20231004175239.451828296@linuxfoundation.org>
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
 drivers/media/common/videobuf2/frame_vector.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
index 0f430ddc1f670..fd87747be9b17 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -31,6 +31,10 @@
  * different type underlying the specified range of virtual addresses.
  * When the function isn't able to map a single page, it returns error.
  *
+ * Note that get_vaddr_frames() cannot follow VM_IO mappings. It used
+ * to be able to do that, but that could (racily) return non-refcounted
+ * pfns.
+ *
  * This function takes care of grabbing mmap_lock as necessary.
  */
 int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool write,
@@ -59,8 +63,6 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool write,
 	if (likely(ret > 0))
 		return ret;
 
-	/* This used to (racily) return non-refcounted pfns. Let people know */
-	WARN_ONCE(1, "get_vaddr_frames() cannot follow VM_IO mapping");
 	vec->nr_frames = 0;
 	return ret ? ret : -EFAULT;
 }
-- 
2.40.1



