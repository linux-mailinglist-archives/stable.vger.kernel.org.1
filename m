Return-Path: <stable+bounces-159175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17998AF0724
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 02:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E8E482F80
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 00:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80084139B;
	Wed,  2 Jul 2025 00:02:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6208B8F5A
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414536; cv=none; b=g7YOa+9wP2BhjLRo0zXTJ0DJxEffbkVHWTq5I9ng9KTOysDRcfoQyJ4KqD4zO40mQCdM/nrU9D7rXKypdLNAeEtyhrUN9odgfDrEBMwocXYy7hu1ti74xSrMB7HEYvKzrYQC2W8QLBAk7F9Obza2r/5T4nr+sonzCcqrrdTxYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414536; c=relaxed/simple;
	bh=ickQKZV3EzYbefbOPqDDS4oDEc4Iam+ms37JpNW9RIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZuQ9pcLPSZ4U3nNYB2eeMoJOp1AHxa7JxZFQ0KZR7bPy6mNlguiyFm7o7O2ionRnDKWYpJy2VWjbHmY1dgBN1zZmX/6f/EmKXJoQr688PvAjv64uDnvCC60p1qAT5F9ZP+8rxYFuFonBvv5KeMyPYcL1eSUmepDyDGUlbPlwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a0-686477002f7a
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] samples/damon: fix damon sample prcl for start failure
Date: Wed,  2 Jul 2025 09:02:01 +0900
Message-ID: <20250702000205.1921-2-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250702000205.1921-1-honggyu.kim@sk.com>
References: <20250702000205.1921-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsXC9ZZnoS5jeUqGwTELiznr17BZPPn/m9Xi
	3pr/rBaHv75hsliw8RGjA6vHplWdbB6bPk1i9zgx4zeLx4vNMxk9Pm+SC2CN4rJJSc3JLEst
	0rdL4MqY1zSDvWCPQMXv3vWsDYxnebsYOTkkBEwk1m8+xwpjr+lezgxiswmoSVx5OYmpi5GD
	Q0TASmLajtguRi4OZoE5jBLf3u0CqxEW8JNon9sAZrMIqEpsmtPCBGLzCphJXNnexwIxU1Pi
	8faf7CA2p4C5xMfm1WwgthBQzbzD79gh6gUlTs58AlbPLCAv0bx1NjPIMgmBGWwS7e0fGCEG
	SUocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERiYy2r/RO9g/HQh
	+BCjAAejEg/viSvJGUKsiWXFlbmHGCU4mJVEePlkgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	jb6VpwgJpCeWpGanphakFsFkmTg4pRoYna9XR+zdf3Nd0exffUzOnYWPL93TLdvs8mCq6EMB
	9wNKxy6cruGQfHmj5JxlkNmhy5PMyxa/2PP5RphOD+eSrzsnt5zw+Nh2c829fW8nvNIRcRO8
	Off5/t7KzzdfcbPvb2g5b7g75MSShZU7pe57B5uwvLioUpNfHyosuvlAzemy9NdTI1b62Cmx
	FGckGmoxFxUnAgA++TfTSAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsXCNUNLT5ehPCXD4NUsU4s569ewWTz5/5vV
	4vOz18wWh+eeZLW4t+Y/q8Xhr2+YLBZsfMTowO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfGvKYZ7AV7BCp+965nbWA8y9vFyMkhIWAisaZ7
	OTOIzSagJnHl5SSmLkYODhEBK4lpO2K7GLk4mAXmMEp8e7cLrEZYwE+ifW4DmM0ioCqxaU4L
	E4jNK2AmcWV7HwvETE2Jx9t/soPYnALmEh+bV7OB2EJANfMOv2OHqBeUODnzCVg9s4C8RPPW
	2cwTGHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzD0ltX+mbiD8ctl90OM
	AhyMSjy8B84mZwixJpYVV+YeYpTgYFYS4eWTBQrxpiRWVqUW5ccXleakFh9ilOZgURLn9QpP
	TRASSE8sSc1OTS1ILYLJMnFwSjUwnk/ck/tOKv7ZFFUPv+AU1ZirC6T/vG5QvWcly2nMz7OG
	1fDa+eKFG3dFvHZ+q/35s+BPqd2du1fnuM5bHhlQe3OOLlv/9XzVFSfrpnpu5hD7/t3xtWLL
	zsTD8196syqz9vUaaHRfKeDwidOS+JR9t/mFyx/N5S1Sq61rJWdN7pRiUM1W3LZKiaU4I9FQ
	i7moOBEAgwaSxTkCAAA=
X-CFilter-Loop: Reflected

The damon_sample_prcl_start() can fail so we must reset the "enable"
parameter to "false" again for proper rollback.

In such cases, setting Y to "enable" then N triggers the following
crash because damon sample start failed but the "enable" stays as Y.

  [ 2441.419649] damon_sample_prcl: start
  [ 2454.146817] damon_sample_prcl: stop
  [ 2454.146862] ------------[ cut here ]------------
  [ 2454.146865] kernel BUG at mm/slub.c:546!
  [ 2454.148183] Oops: invalid opcode: 0000 [#1] SMP NOPTI
  	...
  [ 2454.167555] Call Trace:
  [ 2454.167822]  <TASK>
  [ 2454.168061]  damon_destroy_ctx+0x78/0x140
  [ 2454.168454]  damon_sample_prcl_enable_store+0x8d/0xd0
  [ 2454.168932]  param_attr_store+0xa1/0x120
  [ 2454.169315]  module_attr_store+0x20/0x50
  [ 2454.169695]  sysfs_kf_write+0x72/0x90
  [ 2454.170065]  kernfs_fop_write_iter+0x150/0x1e0
  [ 2454.170491]  vfs_write+0x315/0x440
  [ 2454.170833]  ksys_write+0x69/0xf0
  [ 2454.171162]  __x64_sys_write+0x19/0x30
  [ 2454.171525]  x64_sys_call+0x18b2/0x2700
  [ 2454.171900]  do_syscall_64+0x7f/0x680
  [ 2454.172258]  ? exit_to_user_mode_loop+0xf6/0x180
  [ 2454.172694]  ? clear_bhb_loop+0x30/0x80
  [ 2454.173067]  ? clear_bhb_loop+0x30/0x80
  [ 2454.173439]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 2aca254620a8 ("samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org
---
 samples/damon/prcl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 056b1b21a0fe..5597e6a08ab2 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -122,8 +122,12 @@ static int damon_sample_prcl_enable_store(
 	if (enable == enabled)
 		return 0;
 
-	if (enable)
-		return damon_sample_prcl_start();
+	if (enable) {
+		err = damon_sample_prcl_start();
+		if (err)
+			enable = false;
+		return err;
+	}
 	damon_sample_prcl_stop();
 	return 0;
 }
-- 
2.34.1


