Return-Path: <stable+bounces-220082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GUlOAMno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 605241C4EA9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E7E73090EBD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228033DEE1;
	Sat, 28 Feb 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1ZtdQcx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EC328B78;
	Sat, 28 Feb 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299972; cv=none; b=M9gCU+rQOE9bbmBlAhmKs4iN0qblE6kXGM6wlcT1E3Qh660ASQbjGf/vmUVa4HQ9dGXEmuwzFfiEO3tjirIcs7d1zC0a0JgrGkFCVBnaPd7XID/KDeFLSzav27S7CIaIcVdHYx/W5Y8nEFyqy8uBJU9hx/nTQaRUIDAE98K1KPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299972; c=relaxed/simple;
	bh=mkR6AfW5Utma/fNsPijcJRYNsIfaMc2bi3R9oseisdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDZTg9oTbV4vza1mdw6MgKhZ5F0YD/tWOnvLHkeiHCkiwgRFjq1Zkf9nBSo/WAgaFOQKWMKU/vOI5Am/B7uTsz+hefOMRTNHMc1aP0AZbntvzXEW5Bth7aTEe4h/bstRY8ZYr02ixOPQjybZtbvbwe7huXx5qkokB8lgx1RY9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1ZtdQcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA69FC19423;
	Sat, 28 Feb 2026 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299971;
	bh=mkR6AfW5Utma/fNsPijcJRYNsIfaMc2bi3R9oseisdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1ZtdQcxYR61pv5DZpOvn4ZbrRFJzytREYjtHXn6hJd1PvYhbJAwqLLzjA250yO3W
	 Bsbsq+GkKHnbNmRMM8IUouZbdzLRifGHcswp9fe6zdk0bZQzBbp/1dV9kNZZHS8GxC
	 EJ8VQXL3GsnNwHPkLZqgS8/iCDcv/fBy4fOgzfcfmYW/NgMpXaMy1DYpoNC2j+1Pwk
	 dsOy26Ak1cw/i4gzkSYvphKDicFYSJShqXSsNczIYhwDOUYSRkBfpt2Ypgpbuhzhu+
	 1WTghdtdoJbOYPYjp1B+iINhV/CmcRalp+0qCW2FgdIiweDyr2qkOrBhnevl7oUfZX
	 duXyOmY6uJ76g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Ian Rogers <irogers@google.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Polensky <japo@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 004/844] perf test: Fix test case perf evlist tests for s390x
Date: Sat, 28 Feb 2026 12:18:37 -0500
Message-ID: <20260228173244.1509663-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220082-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 605241C4EA9
X-Rspamd-Action: no action

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit b04d2b9199129f4f0c992a518c0fb78c2efc1064 ]

Perf test case 78: perf evlist tests fails on s390.

The failure is causes by grouping events cycles and instructions because
sampling does only support event cycles.  Change the group to software
events to fix this.

Output before:
  # ./perf test 78
  78: perf evlist tests              : FAILED!
  #

Output after:
  # ./perf test 78
  78: perf evlist tests              : Ok
  #

Fixes: db452961de939225 ("perf tests evlist: Add basic evlist test")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Ian Rogers <irogers@google.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/evlist.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/evlist.sh
index 140f099e75c1e..5632be3917109 100755
--- a/tools/perf/tests/shell/evlist.sh
+++ b/tools/perf/tests/shell/evlist.sh
@@ -38,13 +38,14 @@ test_evlist_simple() {
 
 test_evlist_group() {
 	echo "Group evlist test"
-	if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true 2> /dev/null
+	if ! perf record -e "{cpu-clock,task-clock}" -o "${perfdata}" \
+		-- perf test -w noploop 2> /dev/null
 	then
 		echo "Group evlist [Skipped event group recording failed]"
 		return
 	fi
 
-	if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*instructions.*}"
+	if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cpu-clock.*,.*task-clock.*}"
 	then
 		echo "Group evlist [Failed to list event group]"
 		err=1
-- 
2.51.0


