Return-Path: <stable+bounces-252536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOP5NM79DWok5QUAu9opvQ
	(envelope-from <stable+bounces-252536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:30:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9CD59665E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 101F831C1ED1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A1A29B8D0;
	Wed, 20 May 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QbwkGrWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574F3F9267;
	Wed, 20 May 2026 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300932; cv=none; b=UzEowyY2CXeO7mA3CqnBXekRm5peyAuPbP6YadrZl6b5TVjEH3dC5VcLh9l4d0/kxR8l4Uo5rfLHNwVQIeJGsslhNmZrh8DGQgO5hwtUbnT1A9QbiFVfxcUFVPlWC64O4z1mFVULKolhSST6c49XSxDgt6BAypg5KXAi4pNMDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300932; c=relaxed/simple;
	bh=0EGPbw5Ppi+3ZnedbSBW+ilcQC91AwDsWWJNjVcMV00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDH8PqhYV4hpyBv5qswmMzUGqIC18ntqZE+7SmEG01iBYfjnP0sCG6LTwgz7NfZTuX4rYnszJIzwPHycQvbQHUmePs76BmkYSJLDAz0A93/El0CiE6R2L2QT7NDPBUIDjxplP7M2WR5YnIZAlt1yb0mwTHwSsnYfxCACP5vEv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QbwkGrWG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7221F00893;
	Wed, 20 May 2026 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300930;
	bh=AUW9FocTBwIoFGVq6i9zE+itWSxsR2Wr8wTxxsibWnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbwkGrWGoL3bUUZmWPntYklg2JaqiptwHejyNHhXj7EN3YUDX+7EgP2YYWb7qakJA
	 B7mQRrKvwCXfx/VpO0PGayeiDmo7AfXUhcRAr/5DpL1kSbtoAgNub+1RF8odgr+0a1
	 Bp99Hl6HfiHXJdiinvU7ueA/LGNRiTFNMGDhhkko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 362/666] perf branch: Avoid incrementing NULL
Date: Wed, 20 May 2026 18:19:33 +0200
Message-ID: <20260520162119.083691955@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252536-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BF9CD59665E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit c969a9d7bbf46f983c4a48566b3b2f7340b02296 ]

If the entry is NULL the value is meaningless so early return NULL to
avoid an increment of NULL. This was happening in calls from
has_stitched_lbr when running the "perf record LBR tests". The return
value isn't used in that case, so returning NULL as no effect.

Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/branch.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index b80c12c74bbbe..90f76910b23fb 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -65,6 +65,9 @@ static inline struct branch_entry *perf_sample__branch_entries(struct perf_sampl
 {
 	u64 *entry = (u64 *)sample->branch_stack;
 
+	if (entry == NULL)
+		return NULL;
+
 	entry++;
 	if (sample->no_hw_idx)
 		return (struct branch_entry *)entry;
-- 
2.53.0




