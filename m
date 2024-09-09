Return-Path: <stable+bounces-74039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D78971D52
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C683283DC2
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE21BC067;
	Mon,  9 Sep 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bFiG/umi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JV3DFSos"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0831BAEDF;
	Mon,  9 Sep 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893966; cv=none; b=i4GT9r3XuNS2o0K0C19kVavhR/YgjwkYonM0zC91GnBdy0hfQI2zxkYS6+M4+rqLchaxes3Zh2iIw5tdP7pOcxTUc2IXUhk0hJqiXDiKw5pbvTU8OQTLBMpDj4eBPLhIfq3poTWotos2tfJHqBOrf1iyIYNl59rqFWkOS+tL6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893966; c=relaxed/simple;
	bh=VZzWImaVGvZ+HusKi9+ZgeFstudne9VxMal0n8xtoyU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qN7D9bugrDSe7W+SqoSKvBFpKY4EXcxY2yEc5UEqB9xti9itevEinMyzRIzhqJPxAe6/Dw6nrZD0MhzGwauj9E4sGmTKF551w4fv1LE4JZXJqCbdeNGtxZlqrEBWGJ4VIpA9gBFzoiol7HMNSjTieJ/g1IYJK8wDLm3Ve2fjQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bFiG/umi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JV3DFSos; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 14:59:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725893963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGuLvSwhIs+7fXgB1ElI/IrUHRvHGd93VUeqQFY3cGI=;
	b=bFiG/umiE1Nw5kp1Cq/QBIcwPfGs+9AhZGgAdavVFGl3NT6SVN8I58IjWcTTXQD23nSnC7
	JjFfXDkkTATziVlAInRsKb/DyCtQrSEzatHxzEl9uANFEJl4CO6HoYOopcNdywCLolOh50
	zwrLhNMtPhZxe0gEME195UVjTZqN2t3lGlQqPeahgV7DbQO1igQ2qJSDg+irbW8tcB4tD2
	UQ0pdYbsk+24aJh167WBnmY/fTzHpUvanH/rvxJht3pwwLCsy3jpmdYvxUxFOSYUoC3tAW
	rLPsNga6Z5W3aPnZj1Xh/tc7PMsztmeHYJmW/YYLYxYqCw/LnBf5y257kPGgCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725893963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGuLvSwhIs+7fXgB1ElI/IrUHRvHGd93VUeqQFY3cGI=;
	b=JV3DFSosbTSbAnup3CLludGaLMTp1+jPqXq8WbTzWjKnSJF/rVplUJPTP+OhQXb1aTWxkX
	dhFiHonOYIY+mnCA==
From: "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Fix conditions in fill_pool()
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240904133944.2124-3-thunder.leizhen@huawei.com>
References: <20240904133944.2124-3-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172589396281.2215.10073639447636391501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     684d28feb8546d1e9597aa363c3bfcf52fe250b7
Gitweb:        https://git.kernel.org/tip/684d28feb8546d1e9597aa363c3bfcf52fe250b7
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 04 Sep 2024 21:39:40 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Sep 2024 16:40:25 +02:00

debugobjects: Fix conditions in fill_pool()

fill_pool() uses 'obj_pool_min_free' to decide whether objects should be
handed back to the kmem cache. But 'obj_pool_min_free' records the lowest
historical value of the number of objects in the object pool and not the
minimum number of objects which should be kept in the pool.

Use 'debug_objects_pool_min_level' instead, which holds the minimum number
which was scaled to the number of CPUs at boot time.

[ tglx: Massage change log ]

Fixes: d26bf5056fc0 ("debugobjects: Reduce number of pool_lock acquisitions in fill_pool()")
Fixes: 36c4ead6f6df ("debugobjects: Add global free list and the counter")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240904133944.2124-3-thunder.leizhen@huawei.com
---
 lib/debugobjects.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7226fdb..6329a86 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -142,13 +142,14 @@ static void fill_pool(void)
 	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
 	 * sections.
 	 */
-	while (READ_ONCE(obj_nr_tofree) && (READ_ONCE(obj_pool_free) < obj_pool_min_free)) {
+	while (READ_ONCE(obj_nr_tofree) &&
+	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
+		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
 			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
 			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);

