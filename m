Return-Path: <stable+bounces-54958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD53913D8C
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 20:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B1A1C21245
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828A184130;
	Sun, 23 Jun 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LkAuFYbU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YiUaPl94"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3918410F;
	Sun, 23 Jun 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719166230; cv=none; b=df2538x9h5eyQMy+Im4ptDR/BmheTvqR+WSawspbhluAtQAdk4i+5MOHzPRMKK+LjfiyPYcMPBgc+kIEbcCBufZ6SWEKd5gDoAz6RXOXXIEJ1uQNzGZWuUBjSicwZkYleNhofMJ4//NVbmRULsWco/eFAHob4JD+uhSnhN8lWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719166230; c=relaxed/simple;
	bh=v+0wMCepz0q4COGL4z8xN5Riklf1Q54BG20Mf+yrcx4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C/kpIRNW4sJdcNGa7j98QQ1cohH6G//TeZdPI7oyJJACfChZ1U67Uy63jLfpwCaSpUC0E0sj2i5M4Fnz6VJDfrTzNU1UVa1PxetFop+hjpQhOYNxGRCSJAB4wyJhZQsk4bRy+qGezGQe0TExV6A19YS/ZSYUTKXvLkRjD8fxsrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LkAuFYbU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YiUaPl94; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 18:10:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719166227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh2bAnLm3YZDzZFxO37dHGycVUv4ngpeet/vgZcAdQo=;
	b=LkAuFYbUnFurgMVPSDCue7Q42FFauEGOyOx2olnxgEDzcaa2x/yKUG3HUofrOfLaCTNwMD
	LZ5YSX4OzPqn70OMxyj4dpWNMRUPwDYSBLsNiJ4TX5UPEN7bZouRr5QvyKXf7upxH3kwMU
	oGTYIqt7dfohrmn+7PF86zGEmWRaSFMYp6BUTKJ/9baOeUmkgU5V8pmTeVfKIY7v96Cte4
	sZmq0HOcEKGnMRY1OcvSUWfLTvQmkLGWBzo40wWwkytNC7Jd8FYR/4cvAVtttWr7BwOFl9
	RF2+/UpmXceULkPPNjmH525DrqU9tVqfl4g/3GWSFQIPmEJGkmkIw3ZG/YYFUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719166227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh2bAnLm3YZDzZFxO37dHGycVUv4ngpeet/vgZcAdQo=;
	b=YiUaPl94i24Eu4jqq9RN02afeqkMR9nwXeS6vboiOqP0pnt7DsTMGVA4nHt0ZNHhpzROvM
	EGar3v0zsKV4JEDQ==
From: "tip-bot2 for Yuntao Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] cpu/hotplug: Fix dynstate assignment in
 __cpuhp_setup_state_cpuslocked()
Cc: Yuntao Wang <ytcoode@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240515134554.427071-1-ytcoode@gmail.com>
References: <20240515134554.427071-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916622725.10875.11057800130531608547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     932d8476399f622aa0767a4a0a9e78e5341dc0e1
Gitweb:        https://git.kernel.org/tip/932d8476399f622aa0767a4a0a9e78e5341dc0e1
Author:        Yuntao Wang <ytcoode@gmail.com>
AuthorDate:    Wed, 15 May 2024 21:45:54 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:08:04 +02:00

cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocked()

Commit 4205e4786d0b ("cpu/hotplug: Provide dynamic range for prepare
stage") added a dynamic range for the prepare states, but did not handle
the assignment of the dynstate variable in __cpuhp_setup_state_cpuslocked().

This causes the corresponding startup callback not to be invoked when
calling __cpuhp_setup_state_cpuslocked() with the CPUHP_BP_PREPARE_DYN
parameter, even though it should be.

Currently, the users of __cpuhp_setup_state_cpuslocked(), for one reason or
another, have not triggered this bug.

Fixes: 4205e4786d0b ("cpu/hotplug: Provide dynamic range for prepare stage")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240515134554.427071-1-ytcoode@gmail.com
---
 kernel/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563877d..74cfdb6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2446,7 +2446,7 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
  * The caller needs to hold cpus read locked while calling this function.
  * Return:
  *   On success:
- *      Positive state number if @state is CPUHP_AP_ONLINE_DYN;
+ *      Positive state number if @state is CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN;
  *      0 for all other states
  *   On failure: proper (negative) error code
  */
@@ -2469,7 +2469,7 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 	ret = cpuhp_store_callbacks(state, name, startup, teardown,
 				    multi_instance);
 
-	dynstate = state == CPUHP_AP_ONLINE_DYN;
+	dynstate = state == CPUHP_AP_ONLINE_DYN || state == CPUHP_BP_PREPARE_DYN;
 	if (ret > 0 && dynstate) {
 		state = ret;
 		ret = 0;
@@ -2500,8 +2500,8 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 out:
 	mutex_unlock(&cpuhp_state_mutex);
 	/*
-	 * If the requested state is CPUHP_AP_ONLINE_DYN, return the
-	 * dynamically allocated state in case of success.
+	 * If the requested state is CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN,
+	 * return the dynamically allocated state in case of success.
 	 */
 	if (!ret && dynstate)
 		return state;

