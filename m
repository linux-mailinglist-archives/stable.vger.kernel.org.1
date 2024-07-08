Return-Path: <stable+bounces-58195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD1929DC8
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 09:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AF81C22253
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F8E38FA1;
	Mon,  8 Jul 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nlspGfP4"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B112D638;
	Mon,  8 Jul 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425409; cv=none; b=r8FLSBVmhAaBZcgDB0MIXSFxUmZxdp2Oz+LxI28OV953LbDQhu60VUKYnfoVymBPdmu7liqRguTcnBjqfAfDHu9CCnp+glexRes4gzvZLgWGytRKsMxS+/YLV71sQ561++66MmqmxT5ErBw30Av5yN5EzwUrDJZ7vG4jb56MB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425409; c=relaxed/simple;
	bh=a3Eu5o4OYY5c8wyupf0NyYJSM4qQ3YVK9pDqmRZWaSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgWqbV370+t07//yJiT9wFidjFNXwguP6ngGfve/zdVWFVmK3HsKQzneQXNjDSYrhIbShV1zmW5OFEfl97CYlgqa7Y1H8iHXl9Rqj3UCYcVmOqFMF/SxBi3yzbp5//bvTRyua2Jyp/u2yOisnoGWpL6KpmQskEqBWbje//lgXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nlspGfP4; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=o1jN8VRyIcfHumRP1KvLwsjLLnt/lHRWuKN52gcpPx4=; b=nlspGfP4A0tMOtPh4zYnRtT+SI
	Aj+aSVhrWD2EsHdlmEcTf56+gI+RHP1Pw7kPB/9wGSxS8GBF8rIhDogIfYBnCrB/MSplddEdMSZwK
	Afmw4YGMHEQ+x4e/Ywx6fPYkn+Rc2vqludS+1MKVYX8U3vkG07sZMNhq/ZBvZUsC7aBFezu821AT2
	5Xo75ff7lUw71Bj31K64ognlgrY6qBjjidvVRcNt8Iiu/PpUCaNPWPwDqrqx9IYKTsU40fPVQbtFw
	Z6mrjJD75z/wUyn90OF2X9J/90XFbcDT1Z3ZiPWTN6bh4ZiPgG0gz4SMrbq9JUZIeSC8Jfrb2yK67
	5PcGrOWw==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sQjEi-00CNGq-2K; Mon, 08 Jul 2024 09:56:36 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Huang Ying <ying.huang@intel.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] mm/numa_balancing: Teach mpol_to_str about the balancing mode
Date: Mon,  8 Jul 2024 08:56:32 +0100
Message-ID: <20240708075632.95857-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Since balancing mode was added in
bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes"),
it was possible to set this mode but it wouldn't be shown in
/proc/<pid>/numa_maps since there was no support for it in the
mpol_to_str() helper.

Furthermore, because the balancing mode sets the MPOL_F_MORON flag, it
would be displayed as 'default' due a workaround introduced a few years
earlier in
8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps").

To tidy this up we implement two changes:

Replace the MPOL_F_MORON check by pointer comparison against the
preferred_node_policy array. By doing this we generalise the current
special casing and replace the incorrect 'default' with the correct
'bind' for the mode.

Secondly, we add a string representation and corresponding handling for
the MPOL_F_NUMA_BALANCING flag.

With the two changes together we start showing the balancing flag when it
is set and therefore complete the fix.

Representation format chosen is to separate multiple flags with vertical
bars, following what existed long time ago in kernel 2.6.25. But as
between then and now there wasn't a way to display multiple flags, this
patch does not change the format in practice.

Some /proc/<pid>/numa_maps output examples:

 555559580000 bind=balancing:0-1,3 file=...
 555585800000 bind=balancing|static:0,2 file=...
 555635240000 prefer=relative:0 file=

v2:
 * Fully fix by introducing MPOL_F_KERNEL.

v3:
 * Abandoned the MPOL_F_KERNEL approach in favour of pointer comparisons.
 * Removed lookup generalisation for easier backporting.
 * Replaced commas as separator with vertical bars.
 * Added a few more words about the string format in the commit message.

v4:
 * Use is_power_of_2.
 * Use ARRAY_SIZE and update recommended buffer size for two flags.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
References: 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps")
Cc: Huang Ying <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: <stable@vger.kernel.org> # v5.12+
---
 mm/mempolicy.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index aec756ae5637..a1bf9aa15c33 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
  * @pol:  pointer to mempolicy to be formatted
  *
  * Convert @pol into a string.  If @buffer is too short, truncate the string.
- * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
- * longest flag, "relative", and to display at least a few node ids.
+ * Recommend a @maxlen of at least 51 for the longest mode, "weighted
+ * interleave", plus the longest flag flags, "relative|balancing", and to
+ * display at least a few node ids.
  */
 void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 {
@@ -3303,7 +3304,10 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	unsigned short mode = MPOL_DEFAULT;
 	unsigned short flags = 0;
 
-	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
+	if (pol &&
+	    pol != &default_policy &&
+	    !(pol >= &preferred_node_policy[0] &&
+	      pol <= &preferred_node_policy[ARRAY_SIZE(preferred_node_policy) - 1])) {
 		mode = pol->mode;
 		flags = pol->flags;
 	}
@@ -3331,12 +3335,18 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += snprintf(p, buffer + maxlen - p, "=");
 
 		/*
-		 * Currently, the only defined flags are mutually exclusive
+		 * Static and relative are mutually exclusive.
 		 */
 		if (flags & MPOL_F_STATIC_NODES)
 			p += snprintf(p, buffer + maxlen - p, "static");
 		else if (flags & MPOL_F_RELATIVE_NODES)
 			p += snprintf(p, buffer + maxlen - p, "relative");
+
+		if (flags & MPOL_F_NUMA_BALANCING) {
+			if (!is_power_of_2(flags & MPOL_MODE_FLAGS))
+				p += snprintf(p, buffer + maxlen - p, "|");
+			p += snprintf(p, buffer + maxlen - p, "balancing");
+		}
 	}
 
 	if (!nodes_empty(nodes))
-- 
2.44.0


