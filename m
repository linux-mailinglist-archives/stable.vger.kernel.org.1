Return-Path: <stable+bounces-99048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3879E6E0D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E341882DF4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B352010F4;
	Fri,  6 Dec 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V2YEBAgl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1O58XH8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC39200136;
	Fri,  6 Dec 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487852; cv=none; b=sdU2tDqCAxVic1mBVRwEU+eNzWm8ZW1YIYu2rIbzVUjLL+5GHkxUSX57US5g9pycub4nTIO8i40bRnqZjq6+Zf+c8OVhxqlZpf7q+AL6RiyOENUhl0Eh45O9TnyYKEYqlsPDPyXjs4VWERSQsURhjBOYjDetyTQ0DKjMVsUwjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487852; c=relaxed/simple;
	bh=MISeZLy5UyOcuw6LX82eP+6NsTnmJzDaky2pC3F8ZAM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hRuRC1/NwZIse6DIi7v0X5xA+G50VQl5aecPwfa2VlcfG4pUk0MyZfVtLB9EC6rziIsmlz16lV4hofR6fVYwKQ1WpM+BhR1WAr4SjeCsaiyYt+7IMVIDrSAd+lJtDGqOmVaHZ1WlBzhGdgYJI1msB6qfKJb4qtKOcaG4y+j4ONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V2YEBAgl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B1O58XH8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 12:24:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733487848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtcnRox2TiWO2vrRFZIiPVfbtAPcjAIBFB5f/4WbeCo=;
	b=V2YEBAgldiEuq7mV4bq0mZaIshKGFr+F3tZ1x0Bb09Pu99SO3Up4c561RkB6ggpL2iKILS
	UIOj89Ft4YqxFNP2N6beVcNoNkcd6+br+AvH9rSQt+qxuB8/9UEUx8MlCLfcC40rY1Rjkl
	GQAImyTKxvwV0drWNShmSTju/qB9FgVqpMOs4H33NlHYtppVvubJSfgH1oP2QJK2RXF3Sl
	sVjX1INUJ77Ey/Ie4maJjzR6k2+BFHzrHtPL6P8ZChKMpN58sfE+/eNLIkv7cjwrtv5GSs
	BDqezbDdEvoMeHghw8/vQQRmCUM/W2Q9eepI35GDLPF65arBWkP7UkqQrGYFaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733487848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtcnRox2TiWO2vrRFZIiPVfbtAPcjAIBFB5f/4WbeCo=;
	b=B1O58XH8i4jt7XlSGoxms6wAKRbuXPbKY9jEDeEzdGlf2/g8YmvkuPWSlyCNgJ6zuDLECC
	sR5f23osO9mNdODg==
From: "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Radu Rendec <rrendec@redhat.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Andreas Herrmann <aherrmann@suse.de>,
	Sudeep Holla <sudeep.holla@arm.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.3+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
References: <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348784735.412.17119811902152182023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b3fce429a1e030b50c1c91351d69b8667eef627b
Gitweb:        https://git.kernel.org/tip/b3fce429a1e030b50c1c91351d69b8667eef627b
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Wed, 27 Nov 2024 16:22:46 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Dec 2024 13:07:47 +01:00

cacheinfo: Allocate memory during CPU hotplug if not done from the primary CPU

Commit

  5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")

adds functionality that architectures can use to optionally allocate and
build cacheinfo early during boot. Commit

  6539cffa9495 ("cacheinfo: Add arch specific early level initializer")

lets secondary CPUs correct (and reallocate memory) cacheinfo data if
needed.

If the early build functionality is not used and cacheinfo does not need
correction, memory for cacheinfo is never allocated. x86 does not use
the early build functionality. Consequently, during the cacheinfo CPU
hotplug callback, last_level_cache_is_valid() attempts to dereference
a NULL pointer:

  BUG: kernel NULL pointer dereference, address: 0000000000000100
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEPMT SMP NOPTI
  CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
  RIP: 0010: last_level_cache_is_valid+0x95/0xe0a

Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback
if not done earlier.

Moreover, before determining the validity of the last-level cache info,
ensure that it has been allocated. Simply checking for non-zero
cache_leaves() is not sufficient, as some architectures (e.g., Intel
processors) have non-zero cache_leaves() before allocation.

Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
This function iterates over all online CPUs. However, a CPU may have come
online recently, but its cacheinfo may not have been allocated yet.

While here, remove an unnecessary indentation in allocate_cache_info().

  [ bp: Massage. ]

Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Radu Rendec <rrendec@redhat.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: stable@vger.kernel.org # 6.3+
Link: https://lore.kernel.org/r/20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com
---
 drivers/base/cacheinfo.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 609935a..cf0d455 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -58,7 +58,7 @@ bool last_level_cache_is_valid(unsigned int cpu)
 {
 	struct cacheinfo *llc;
 
-	if (!cache_leaves(cpu))
+	if (!cache_leaves(cpu) || !per_cpu_cacheinfo(cpu))
 		return false;
 
 	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
@@ -458,11 +458,9 @@ int __weak populate_cache_leaves(unsigned int cpu)
 	return -ENOENT;
 }
 
-static inline
-int allocate_cache_info(int cpu)
+static inline int allocate_cache_info(int cpu)
 {
-	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
-					 sizeof(struct cacheinfo), GFP_ATOMIC);
+	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu), sizeof(struct cacheinfo), GFP_ATOMIC);
 	if (!per_cpu_cacheinfo(cpu)) {
 		cache_leaves(cpu) = 0;
 		return -ENOMEM;
@@ -534,7 +532,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
 	 */
 	ci_cacheinfo(cpu)->early_ci_levels = false;
 
-	if (cache_leaves(cpu) <= early_leaves)
+	/*
+	 * Some architectures (e.g., x86) do not use early initialization.
+	 * Allocate memory now in such case.
+	 */
+	if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
 		return 0;
 
 	kfree(per_cpu_cacheinfo(cpu));

