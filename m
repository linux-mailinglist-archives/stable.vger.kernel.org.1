Return-Path: <stable+bounces-58137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E7F928ABC
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E981A1C22843
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759516CD19;
	Fri,  5 Jul 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SSD/AEN2"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378616B39C;
	Fri,  5 Jul 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189958; cv=none; b=DEcdRi0oxksMCPtaYFtSq42WsIMYoMcONsn+6euvfb4azxww+n5NNz6JR7p/vJubLi2CkTyB8ut8Rkm0wekWOD6jj7GZMA4CFP+kIkXTLvk3kMeL/EeAqhebsU4PyWxyqvc44Uj+2JCyP8ibFS0liZuSMWSkwqWdM0AVYhV1+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189958; c=relaxed/simple;
	bh=dMEv2jfhQay1PRP0F8D7K+qHB8tPJsk6OTg6yexz3CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=us+gauA6OQuiVz1N92h6t4A28lgLqeND/BNTon+UV9i2KOUu7by5pIx4/RL1lbAADPlWMl+/qQ7FIa+qeetP6f90klN1GXYjAnebQg9ww7Zo1zTMIF9TahFT6HE9876cuXXVuYt3JRQoQfBExJ5PMo04t30lYxxg97zAi7MitzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SSD/AEN2; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=opyGsOS5gTWbtKMXLvZ+LW0gPGKD6PmlB4hhJBfIAk8=; b=SSD/AEN2jADr4l9v9RZlVYHvjp
	A3x45ohowbXs9oFZU/yhviOVuj82gRBjK7bwhk7iCTDR8xiwWXnKQ/eQt7Olz9W38xbiDHyydOxZW
	gZjuz1slPup83FMr2+8hY6TuqKUPJQYE/Jv7jNzEwzJshwb+/kI/kSb8VPVJqFcMCdGTIQTbphq+C
	OuQgMuVQvW7S+Nkb/u3eZR+3UCBRfB3y4B2hXr+XVonVsAJTtvgKVawrpJUKBJm2/VGsCSdPVjnPd
	vi0lMy62mUO9TA2VPdAsQvlrPBW2QssgnqizoscBO/WW2JcM16rU1lBJ5CsYeucffcjnu0Vsr3G8H
	28qSEsUg==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sPjz3-00BSm3-9U; Fri, 05 Jul 2024 16:32:21 +0200
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
Subject: [PATCH 1/3] mm/numa_balancing: Teach mpol_to_str about the balancing mode
Date: Fri,  5 Jul 2024 15:32:16 +0100
Message-ID: <20240705143218.21258-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705143218.21258-1-tursulin@igalia.com>
References: <20240705143218.21258-1-tursulin@igalia.com>
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
index aec756ae5637..1bfb6c73a39c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
  * @pol:  pointer to mempolicy to be formatted
  *
  * Convert @pol into a string.  If @buffer is too short, truncate the string.
- * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
- * longest flag, "relative", and to display at least a few node ids.
+ * Recommend a @maxlen of at least 42 for the longest mode, "weighted
+ * interleave", the longest flag, "balancing", and to display at least a few
+ * node ids.
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
+	      pol <= &preferred_node_policy[MAX_NUMNODES - 1])) {
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
+			if (hweight16(flags & MPOL_MODE_FLAGS) > 1)
+				p += snprintf(p, buffer + maxlen - p, "|");
+			p += snprintf(p, buffer + maxlen - p, "balancing");
+		}
 	}
 
 	if (!nodes_empty(nodes))
-- 
2.44.0


