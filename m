Return-Path: <stable+bounces-220172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BLmN8sto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8CA1C55CF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6E1A312A58F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9A4A33FF;
	Sat, 28 Feb 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkjOwsRg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E733FE12;
	Sat, 28 Feb 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300080; cv=none; b=hjFdhJ89qyYKqmIEESZXflp6f4CQDBoqp+KwbCcyXIb/W5CREGpHtmeHH5CcbVq0AXdU0DIe8G5hcbvP8If7qSZaxi+ZyWEgbu61Mu8PutXqMrGnfyIlJTmaNbC/mc/wWRNu/c3UkPdfrbs/tw83kc5SBWsOBHQ7zI9ivN5LlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300080; c=relaxed/simple;
	bh=TmeLW5qr0QCHMuHsr+B7FWmNu2EJjch5/GeBaeSU8/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz6W7rpStsPLu7Pmfp3myAEuMToOzgaCxdAdYghb8OxEvE1CJLrtgWDV8JrR7TT1tMhXkqSn5LiKQNMuqk21+IuDQnFy34lJY/DoHw58Mou66v3O0xllotzLnNkGcp/JQvZa+//mXqUISS0caui5oOjdGSYrX+zVbF56aUswRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkjOwsRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A53C19424;
	Sat, 28 Feb 2026 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300080;
	bh=TmeLW5qr0QCHMuHsr+B7FWmNu2EJjch5/GeBaeSU8/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkjOwsRgHh6r3bbtk+qJb1hJJbmgTmlsDuR7hGNU3XlmioIESXJtkqiPxw7jTBa2v
	 bft12MUC6XgxN9u320xsAVq4FrDtiSwRG+2Ht6KJpbHVRV9Ms8MErGWTqZG6yJ/Qiz
	 O2ApWu7rXMXl6+6v86qZmr/zQXGsBz+MRTwtEGn4ExNinW2F6Q5H0MLE5dTpoMwZqr
	 2yXpb5AmTN2yYpQZFviJN9c/2MW+WGzv9MCH6AD42twJDk0FrMgrDgjAJ45POPj+cs
	 GKQRjgzf/YbAZ0ooIriEAchz4zUu0m2nGc+Q2ZqbNQfZjhnijZJ296UC4FUGdI/mMC
	 pqEd0a5VsaqHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Schiller <ms@dev.tdt.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 094/844] perf/x86/cstate: Add Airmont NP
Date: Sat, 28 Feb 2026 12:20:07 -0500
Message-ID: <20260228173244.1509663-95-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220172-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,infradead.org:email,msgid.link:url,tdt.de:email]
X-Rspamd-Queue-Id: 0B8CA1C55CF
X-Rspamd-Action: no action

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit 3006911f284d769b0f66c12b39da130325ef1440 ]

From the perspective of Intel cstate residency counters, the Airmont NP
(aka Lightning Mountain) is identical to the Airmont.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251124074846.9653-4-ms@dev.tdt.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index fa67fda6e45b4..c1e318bdaa397 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -599,6 +599,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&slm_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_D,	&slm_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&slm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_NP,	&slm_cstates),
 
 	X86_MATCH_VFM(INTEL_BROADWELL,		&snb_cstates),
 	X86_MATCH_VFM(INTEL_BROADWELL_D,	&snb_cstates),
-- 
2.51.0


