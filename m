Return-Path: <stable+bounces-220173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNIaIScto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F551C54F6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFA1330B7795
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1894A3417;
	Sat, 28 Feb 2026 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2LVeUgD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307624A3410;
	Sat, 28 Feb 2026 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300081; cv=none; b=tgPAf4n5j4AtCVQZhmu5/BanaWq2omEc/M8AW1SijO7eaL/C4AYpMU7qIc6X8gMeMQKmo7l+TPcrbwC+3Z2gKfBgKO/S2o0c1DKe+5Vkf0XoMIWYR3ENkL+FVBSXzfI1xzGlXHhHPRX5gl8/3CEGua9qdNs1JBA45y/u5Zg2di4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300081; c=relaxed/simple;
	bh=Rv86ksDJSKVkNYqm19gbqZf2YHOvAYL0Z8AjVnsxgPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui8MRe60aATVojA6PwJcvVYwy1BTBBYGOFh5cbqnTOkEjT9T3wE4ukbGiwQqXsa7vwTMbLgfUFEIYmQYp08GGQMsRYxmHDiAJD1z5cDrWblvoyugCy/txFv4MmAFyoecIsuzqXWKnGhT8TyJH0XfMASIGa1MvhDd2zfUACYxn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2LVeUgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654C5C19424;
	Sat, 28 Feb 2026 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300081;
	bh=Rv86ksDJSKVkNYqm19gbqZf2YHOvAYL0Z8AjVnsxgPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2LVeUgDRiSFewiySwVU4hJS90i9NvVZzed3szLhIq7iwbtH2WZftK/0teI5LHM7b
	 G1+HmgwK0LfevbUkfDQmWNsa/wejdrM/GdM/dEpblKRa98JV6LvXZ6iBL/ESAjbK5Q
	 p1MvAvulQzf23E0bsIxWS37p1dV3cb31jS9jCFt7PiEK79npXaSB9cHs2hJsx2ycZk
	 hNfSDw3J3IDOMS869ZqcNQLDMHwINr78XmfLE/85cCdnt+wnsUjqoUqIwu+RoF/oAi
	 rMJu2n3Z7YpsKRC9OoR5YQj7oyRuefJPPJCLUHS2Jw4rvnAhglV8jcpBXkd7VjXi1P
	 qJFz6TA2ccdPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Schiller <ms@dev.tdt.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 095/844] perf/x86/intel: Add Airmont NP
Date: Sat, 28 Feb 2026 12:20:08 -0500
Message-ID: <20260228173244.1509663-96-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220173-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,infradead.org:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tdt.de:email]
X-Rspamd-Queue-Id: 35F551C54F6
X-Rspamd-Action: no action

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit a08340fd291671c54d379d285b2325490ce90ddd ]

The Intel / MaxLinear Airmont NP (aka Lightning Mountain) supports the
same architectual and non-architecural events as Airmont.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251124074846.9653-3-ms@dev.tdt.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bdf3f0d0fe216..d85df652334fb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7405,6 +7405,7 @@ __init int intel_pmu_init(void)
 	case INTEL_ATOM_SILVERMONT_D:
 	case INTEL_ATOM_SILVERMONT_MID:
 	case INTEL_ATOM_AIRMONT:
+	case INTEL_ATOM_AIRMONT_NP:
 	case INTEL_ATOM_SILVERMONT_MID2:
 		memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
 			sizeof(hw_cache_event_ids));
-- 
2.51.0


