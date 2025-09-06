Return-Path: <stable+bounces-178007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E661AB47769
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 23:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15983BE546
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642A0279DB2;
	Sat,  6 Sep 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llKzwfD/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247BD315D45
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193934; cv=none; b=LD64ImcXI0KIbxRkHP+iwI0Pd63AxP93BwedTzp5GuSDjhU28TpWx3gJnHS++S845ilbD3U0YSAml9F3/jaqtdzsGWMuK9auhyxE7I9O7ckD2Kd8VsUoiVND196zH29Ir+rOhYJhST2W6x2vGL29stYGUfPp8cvt6s5s8gfEoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193934; c=relaxed/simple;
	bh=FPYl0RVBQpaiPX1IsHVdBeRoQR+bvI+eO7ogqO8hcmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFFyjGjoZ++ea4kgM6cnCqBwDd8Qhx3pc2wusf7O58OZGcXqelbzVbkJXoh2oN02Rn/Ay13p9CpIe7ODp+CRSf86B47iXw2HV+goI2NvjANpwUWQmDJb/zrfKAaOJcqmv5q1StH7Sc7PoO7iYi1zt5rLdqxM1rgFcYOnzk0HqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llKzwfD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EDDC4CEF5;
	Sat,  6 Sep 2025 21:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757193933;
	bh=FPYl0RVBQpaiPX1IsHVdBeRoQR+bvI+eO7ogqO8hcmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llKzwfD/N6SSh/sSHW6OChPMbKCIS+iMcHTGMFulEXvoNFqyttWLPWzoYmZGa0l+4
	 aXKW0gTQAWL4Uhy4sJnGpQR8jQauIhLBfSREpsKTPKViQa+kZDJ/2W4nmLCfuKkS/E
	 PrWPyBASK89eXo1YmIJT182Fd1ssjNVegC+5IWqQW9QurXKQNacSpA7OO3S8tPuX0W
	 jHaG8V0ZxAX4zmKzrcv5tVE2bOkH+H1kxE5uZA+NJmy0VfGOPVFI/gqQu3HKBjQTXv
	 ixaYd17dyShazvwDTtiuA/VFer7fU/8Tt++bf2B4rpgk+Jlaj1l+X+UJB8d5NxeEI1
	 s6cWm/ZKRK8bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] mm: slub: Print the broken data before restoring them
Date: Sat,  6 Sep 2025 17:25:27 -0400
Message-ID: <20250906212530.302670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090618-patient-manlike-340f@gregkh>
References: <2025090618-patient-manlike-340f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyesoo Yu <hyesoo.yu@samsung.com>

[ Upstream commit ed5ec2e952595a469eae1f6dce040737359b6da2 ]

Previously, the restore occurred after printing the object in slub.
After commit 47d911b02cbe ("slab: make check_object() more consistent"),
the bytes are printed after the restore. This information about the bytes
before the restore is highly valuable for debugging purpose.
For instance, in a event of cache issue, it displays byte patterns
by breaking them down into 64-bytes units. Without this information,
we can only speculate on how it was broken. Hence the corrupted regions
should be printed prior to the restoration process. However if an object
breaks in multiple places, the same log may be output multiple times.
Therefore the slub log is reported only once to prevent redundant printing,
by sending a parameter indicating whether an error has occurred previously.

Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Stable-dep-of: b4efccec8d06 ("mm/slub: avoid accessing metadata when pointer is invalid in object_err()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index dc527b59f5a98..7282beba8ec5e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1191,8 +1191,8 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 
 static pad_check_attributes int
 check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
-		       u8 *object, char *what,
-		       u8 *start, unsigned int value, unsigned int bytes)
+		       u8 *object, char *what, u8 *start, unsigned int value,
+		       unsigned int bytes, bool slab_obj_print)
 {
 	u8 *fault;
 	u8 *end;
@@ -1211,10 +1211,11 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 	if (slab_add_kunit_errors())
 		goto skip_bug_print;
 
-	slab_bug(s, "%s overwritten", what);
-	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
-					fault, end - 1, fault - addr,
-					fault[0], value);
+	pr_err("[%s overwritten] 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+	       what, fault, end - 1, fault - addr, fault[0], value);
+
+	if (slab_obj_print)
+		object_err(s, slab, object, "Object corrupt");
 
 skip_bug_print:
 	restore_bytes(s, what, value, fault, end);
@@ -1278,7 +1279,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		return 1;
 
 	return check_bytes_and_report(s, slab, p, "Object padding",
-			p + off, POISON_INUSE, size_from_object(s) - off);
+			p + off, POISON_INUSE, size_from_object(s) - off, true);
 }
 
 /* Check the pad bytes at the end of a slab page */
@@ -1328,11 +1329,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
-			object - s->red_left_pad, val, s->red_left_pad))
+			object - s->red_left_pad, val, s->red_left_pad, ret))
 			ret = 0;
 
 		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
-			endobject, val, s->inuse - s->object_size))
+			endobject, val, s->inuse - s->object_size, ret))
 			ret = 0;
 
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
@@ -1341,7 +1342,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			if (s->object_size > orig_size  &&
 				!check_bytes_and_report(s, slab, object,
 					"kmalloc Redzone", p + orig_size,
-					val, s->object_size - orig_size)) {
+					val, s->object_size - orig_size, ret)) {
 				ret = 0;
 			}
 		}
@@ -1349,7 +1350,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
 			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
 				endobject, POISON_INUSE,
-				s->inuse - s->object_size))
+				s->inuse - s->object_size, ret))
 				ret = 0;
 		}
 	}
@@ -1365,11 +1366,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			if (kasan_meta_size < s->object_size - 1 &&
 			    !check_bytes_and_report(s, slab, p, "Poison",
 					p + kasan_meta_size, POISON_FREE,
-					s->object_size - kasan_meta_size - 1))
+					s->object_size - kasan_meta_size - 1, ret))
 				ret = 0;
 			if (kasan_meta_size < s->object_size &&
 			    !check_bytes_and_report(s, slab, p, "End Poison",
-					p + s->object_size - 1, POISON_END, 1))
+					p + s->object_size - 1, POISON_END, 1, ret))
 				ret = 0;
 		}
 		/*
@@ -1395,11 +1396,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		ret = 0;
 	}
 
-	if (!ret && !slab_in_kunit_test()) {
-		print_trailer(s, slab, object);
-		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
-	}
-
 	return ret;
 }
 
-- 
2.51.0


