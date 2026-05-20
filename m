Return-Path: <stable+bounces-250728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK7lDL0TDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-250728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C855D599134
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D89637FF92B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A43D7D7E;
	Wed, 20 May 2026 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xi5tyYXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683833B969;
	Wed, 20 May 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296161; cv=none; b=lsupSAWo5oR4O6tkAdi/Ti+87ysryf61EN8l1BRuQkBCXCAsutX8NZ/iYvRXVg3duUjRmS5YRNcx+PpyySpp/9ZF4laLfJMtyCVxisNSN3mUTHGqLjTdkm61V+szcazy4X+MTu2TSJKydxK/2OOKEgIq+dkkzy5Gvhprpb/d4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296161; c=relaxed/simple;
	bh=/u36lOQYKw+p7nClOQZEteQSAsVCbJPG8NMiFtJ7Q4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIjJogsJD5qwKRrbO6fserMm2VcV7kv10wmMwNEe1M/NDjIlENF2UdL+BV1EMeaVwRMIodE0s7KxOVoznuIAOj8Xw52AVcw0hRPOGyp8TDK3CwTCie1d6qUX6q5oTTHGwgKQtBT4j6MUfEs5IKih+QOpT8fVbkB/B08ZLgTEYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xi5tyYXq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB46B1F000E9;
	Wed, 20 May 2026 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296160;
	bh=o1fNIiUzpMLkiZrqIgmxUi/GOEb/0g3nL9mPHdDpQZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xi5tyYXqLhoIxGMoSAIMyd5Zp6HHIW1DCPzUbe0LyZCdPaSqKzntxkRWdbjA/X19A
	 TYtCmG6PlVwNpwN2yoW+ILvttUL+gQxsbSddhjDWXLKEAk6zpF9qJqN7pUmg81j7tn
	 lJZfZbSSXxP+VAha2aqq/Yo98aoJC/6z1t/zI22Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0654/1146] perf maps: Fix copy_from that can break sorted by name order
Date: Wed, 20 May 2026 18:15:04 +0200
Message-ID: <20260520162202.984727619@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250728-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C855D599134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit f552b132e4d5248715828e7e5c2bf7889bf05b2e ]

When an parent is copied into a child the name array is populated in
address not name order. Make sure the name array isn't flagged as sorted.

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/maps.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index c8b8081b7b31a..75b399a20b262 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1082,16 +1082,9 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 				map__put(new);
 		}
 		maps__set_maps_by_address_sorted(dest, maps__maps_by_address_sorted(parent));
-		if (!err) {
-			RC_CHK_ACCESS(dest)->last_search_by_name_idx =
-				RC_CHK_ACCESS(parent)->last_search_by_name_idx;
-			maps__set_maps_by_name_sorted(dest,
-						dest_maps_by_name &&
-						maps__maps_by_name_sorted(parent));
-		} else {
-			RC_CHK_ACCESS(dest)->last_search_by_name_idx = 0;
-			maps__set_maps_by_name_sorted(dest, false);
-		}
+		RC_CHK_ACCESS(dest)->last_search_by_name_idx = 0;
+		/* Values were copied into the name array in address order. */
+		maps__set_maps_by_name_sorted(dest, false);
 	} else {
 		/* Unexpected copying to a maps containing entries. */
 		for (unsigned int i = 0; !err && i < n; i++) {
-- 
2.53.0




