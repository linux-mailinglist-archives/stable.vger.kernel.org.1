Return-Path: <stable+bounces-155175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973DBAE2041
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 18:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0796A0396
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909328D8F3;
	Fri, 20 Jun 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ6JDpwo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879661E0E0B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437812; cv=none; b=VLL8YhQHZFMiiQybn9Wjddh9okLdqvbQyXBishnI0G+FAyFRMrmSE3sk2zt0El8iBHgKvyZQyG+KlGOgaoyZvZk8tnHivLIFi2JcWmbF7bn15kWqRfykxGJfcDQ4jHTwx4UpKu16oBAFAq0zSMQGKXv0Es/HOjQDeJzlNdt1BOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437812; c=relaxed/simple;
	bh=L/rYiKH1cv2jxry2cH4eo4AWl6hRPgtRki2C2dHKU/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p8bbVKd7FJY36ggMlfzxRkCn106rl+yV+TixkK6sgiSUqWE0w6Qg+TgH1ro8zB/BMew39m7+Tvsh476SkkRcaX6ilQCKVw5MmXcnVFaDOyW82WwRud4CxU00hrCv/M37Ls5WT5atpvvztgqPwSboDp+DIb1CuzOAm9BDUtsUO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ6JDpwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20D2C4CEE3;
	Fri, 20 Jun 2025 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750437812;
	bh=L/rYiKH1cv2jxry2cH4eo4AWl6hRPgtRki2C2dHKU/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQ6JDpwoMHu+tEtssOotf7Pw7Xx8vZebxO9eXhnr1LpgIRfom4QMsy8Zu4cKAFgii
	 VGJA1if4vaG2o3UaPAhJRhS8IXVCNAPB0BIELwdiGW9JfP24ufEoRT4Uzz3LUs4/vQ
	 nx5zh+NmZb3uR4hTM4+V3RcaMRQBpHZhFpRf0+RX0QqsEHnyURT7ZhFRXdUjEt5TEB
	 WKXMIJ1GTjGrznNeaCUfAxwjSgtbBGm4OwYF+PkRSVralVlvN+8pDPaluAl29con/c
	 PehUDoCJsU8LgbRzdpTJohwIFzikkBtnXZ/s2HEEwFpEDrPOEBVK0bDeu8KcDlyyAE
	 1Hf2/z29zFmKA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Barry Song <21cnbao@gmail.com>,
	Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.15.y] mm/madvise: handle madvise_lock() failure during race unwinding
Date: Fri, 20 Jun 2025 09:42:57 -0700
Message-Id: <20250620164257.92454-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062020-gambling-poker-8b0c@gregkh>
References: <2025062020-gambling-poker-8b0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unwinding race on -ERESTARTNOINTR handling of process_madvise(),
madvise_lock() failure is ignored.  Check the failure and abort remaining
works in the case.

Link: https://lkml.kernel.org/r/20250602174926.1074-1-sj@kernel.org
Fixes: 4000e3d0a367 ("mm/madvise: remove redundant mmap_lock operations from process_madvise()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Reported-by: Barry Song <21cnbao@gmail.com>
Closes: https://lore.kernel.org/CAGsJ_4xJXXO0G+4BizhohSZ4yDteziPw43_uF8nPXPWxUVChzw@mail.gmail.com
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 9c49e5d09f076001e05537734d7df002162eb2b5)
---
 mm/madvise.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b17f684322ad..69510e737783 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1830,7 +1830,9 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 
 			/* Drop and reacquire lock to unwind race. */
 			madvise_unlock(mm, behavior);
-			madvise_lock(mm, behavior);
+			ret = madvise_lock(mm, behavior);
+			if (ret)
+				goto out;
 			continue;
 		}
 		if (ret < 0)
@@ -1839,6 +1841,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 	}
 	madvise_unlock(mm, behavior);
 
+out:
 	ret = (total_len - iov_iter_count(iter)) ? : ret;
 
 	return ret;
-- 
2.39.5


