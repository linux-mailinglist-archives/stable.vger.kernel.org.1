Return-Path: <stable+bounces-178010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F16B4776B
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 23:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17F05A0DA4
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850528E579;
	Sat,  6 Sep 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLhCynub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382FD315D45
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193936; cv=none; b=hQkbUNVxFZH1R3GrFBoqofJJUfMYEU1TzIil9yIZuxTaUf2rdEYou0bKjXPx8SqomLcdqm/pcnppGVKeOK6sG8a2lam1ePSthYuZGW7zALv5rOm5+c8Y+283+Xvu1qExgDlbvxXpKDSDcp17TSefYLiuqvqfBtS0kYeY3GVHFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193936; c=relaxed/simple;
	bh=m8KpHHKHw6wsdH+Qi68eqh0Lrd9JItJDjcZ0/aNp/A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6VBrgQqlxjetdNMridyCZxpaQbqzPpHCs5L3te6Z+5eRn7VHkaNculDNOq+w6QkNI4XcMzYMGjErq6OdebS8cZz1QEADfcXftuk/fkl9AS73iQsiV7s0ttJq0hlH6ueNgTN6g6F9T/JAJRU00iOXIc401YI6l3rsRpiygm0y7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLhCynub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D298C4CEFB;
	Sat,  6 Sep 2025 21:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757193936;
	bh=m8KpHHKHw6wsdH+Qi68eqh0Lrd9JItJDjcZ0/aNp/A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLhCynubkJCkDui27mNYZ9P/UqfvBdFt84AnfxOEkoPJlit3NeYyckEXyHR8v39B4
	 +A1zjqACgiPC2oXUeGZC2XTiVx4LYBZBahqL0PBkdH6iYTDzVnU+HaTixMEpYmqDyS
	 RnLNRdfe4ewEdVAYZAX22X2Qp+ZL5+4+jFok4/EzA0XE/j0UIHE+7xp+aZ8/gVAnjO
	 m173H1yqCikdcGfHYwPAecp1cendGg7c5ZiYpoxiykmW4tX3W08S2zFHU4kqWGAZ3A
	 xHE+U7c+opyjwmCdbLR2aX5csUWMwv378OEr8Za9pXkF2OeV0nYDAgBMF1t+e5vR9L
	 yoIgZ13pP8ixQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Qiong <liqiong@nfschina.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] mm/slub: avoid accessing metadata when pointer is invalid in object_err()
Date: Sat,  6 Sep 2025 17:25:30 -0400
Message-ID: <20250906212530.302670-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250906212530.302670-1-sashal@kernel.org>
References: <2025090618-patient-manlike-340f@gregkh>
 <20250906212530.302670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Qiong <liqiong@nfschina.com>

[ Upstream commit b4efccec8d06ceb10a7d34d7b1c449c569d53770 ]

object_err() reports details of an object for further debugging, such as
the freelist pointer, redzone, etc. However, if the pointer is invalid,
attempting to access object metadata can lead to a crash since it does
not point to a valid object.

One known path to the crash is when alloc_consistency_checks()
determines the pointer to the allocated object is invalid because of a
freelist corruption, and calls object_err() to report it. The debug code
should report and handle the corruption gracefully and not crash in the
process.

In case the pointer is NULL or check_valid_pointer() returns false for
the pointer, only print the pointer value and skip accessing metadata.

Fixes: 81819f0fc828 ("SLUB core")
Cc: <stable@vger.kernel.org>
Signed-off-by: Li Qiong <liqiong@nfschina.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 39fb2b930fdf7..6643fc0e29c1e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1113,7 +1113,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	slab_bug(s, reason);
-	print_trailer(s, slab, object);
+	if (!object || !check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, slab, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 	WARN_ON(1);
-- 
2.51.0


