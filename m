Return-Path: <stable+bounces-234554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHT7ESCh1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:40:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D633C130B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D5830A61D7
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6035B653;
	Wed,  8 Apr 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UfYgQMfB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA626FA5A;
	Wed,  8 Apr 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673160; cv=none; b=s7+e/1cJFzsYx9kvic7GeAnBaGvcWMxLecxfI70lX0DhdsBE01CnxVs9X8rnLVHpQQhbmSFIvXhGgpfbbii9Dtgfc/48o8OtoJT8ZNtzcRxOlv5lKPE+7+o1k1HLj1l1Plezk0PauAQh2HqY+DLbHXk8/imvPBhbyMyuOIrjeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673160; c=relaxed/simple;
	bh=WGs2DeUAeUl8n3xxtOihFyIMMyvDz3usYgTzOAlJDss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+QUGNTJqp//L+f8QM7eFJvsztDfEw12RJJMxU+r5Bk6BGa7tbrw/MtkSemb1KJ+g5+4DhVFX93pquymV80aDcGDo/HZPzBeSYZ8FcApaiHa8ivbqu7Roxg6hCTajEca4K5qZzQCumxvuoPFW/qfXxg74u8yam8kxXFqqgGFrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UfYgQMfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24159C19421;
	Wed,  8 Apr 2026 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673160;
	bh=WGs2DeUAeUl8n3xxtOihFyIMMyvDz3usYgTzOAlJDss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfYgQMfBXaclwwSlY0I1xCXIbEpWXnC0mcE86VVfZNbO0XGILTUKExp1ExYv5L+Ow
	 eOOdf5He2CYy0q5I5qvIWli/FgS2PauuCrLEuhCM4EO5b9gNxQPs/DAQwhKXTG4R3d
	 IIia0RDCWOPYXjlS+LNhe2eiRM3oPZKtMvnQDUpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 125/277] perf/x86: Fix potential bad container_of in intel_pmu_hw_config
Date: Wed,  8 Apr 2026 20:01:50 +0200
Message-ID: <20260408175938.543341319@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234554-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2D633C130B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit dbde07f06226438cd2cf1179745fa1bec5d8914a ]

Auto counter reload may have a group of events with software events
present within it. The software event PMU isn't the x86_hybrid_pmu and
a container_of operation in intel_pmu_set_acr_caused_constr (via the
hybrid helper) could cause out of bound memory reads. Avoid this by
guarding the call to intel_pmu_set_acr_caused_constr with an
is_x86_event check.

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Link: https://patch.msgid.link/20260312194305.1834035-1-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f43aba3ac779d..3046058e7e238 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4441,8 +4441,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		intel_pmu_set_acr_caused_constr(leader, idx++, cause_mask);
 
 		if (leader->nr_siblings) {
-			for_each_sibling_event(sibling, leader)
-				intel_pmu_set_acr_caused_constr(sibling, idx++, cause_mask);
+			for_each_sibling_event(sibling, leader) {
+				if (is_x86_event(sibling))
+					intel_pmu_set_acr_caused_constr(sibling, idx++, cause_mask);
+			}
 		}
 
 		if (leader != event)
-- 
2.53.0




