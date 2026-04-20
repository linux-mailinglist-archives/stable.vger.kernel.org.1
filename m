Return-Path: <stable+bounces-239675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJq+Gi5n5mmlvwEAu9opvQ
	(envelope-from <stable+bounces-239675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:49:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53FB432245
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250B73677E0F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AF33F59D;
	Mon, 20 Apr 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="skb328LV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F333EAF9;
	Mon, 20 Apr 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700931; cv=none; b=qEtDZtOAUM7Fy8MvDTs5wxDpXtP7FKexFcnJCrKleSllyXJtNeDRJLmOJyTUxuUsFoh0fxIYUEI6UAM59smlbKUr9jwULmaNQcV/4oA7c1q9DPOeCJO9nuLWW36/uwqX91RtFscmhO1dFy6a385nucIhjrdqBUaNQH9AzumF/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700931; c=relaxed/simple;
	bh=d4jHjGk/mWBoSAwFM4A5vvHu+6c1yNQkjY3cMDXiICk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSj9y2zvGEoDlG0hRbi/EhF/nTJkZEUWrs+ZZKx5il6PO/shKCym6CEivCLd3o6/QUattLbT8Y9vqHC3/gCvT3nRmMVS8ZLv5q9xEqMJ60Z/EmqI2cflwnLXcFlbGREjLX4uFQCFjHZabFv08JERSX8lXgSNILP7G+17O/ItR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=skb328LV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C722C19425;
	Mon, 20 Apr 2026 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700931;
	bh=d4jHjGk/mWBoSAwFM4A5vvHu+6c1yNQkjY3cMDXiICk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skb328LVwj1EoPZSFtNmdZm2rwT2a0gT0FwvWNCUCjouWxvK5AGSe3g0mgxTH10ev
	 /eKLtLCLid/q1kwa0ut8v3bdrmMuyLZgzxFwzSGSJPM+7dV8hjRR+VKmBFydJwoGiQ
	 X4QfSUudcgOaH0bf+zbcYkfpahPJGHj3+xzkxrU8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve Wahl <steve.wahl@hpe.com>,
	Zide Chen <zide.chen@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 116/198] perf/x86/intel/uncore: Skip discovery table for offline dies
Date: Mon, 20 Apr 2026 17:41:35 +0200
Message-ID: <20260420153939.781288969@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[linuxfoundation.org:server fail,sea.lore.kernel.org:server fail,msgid.link:server fail];
	TAGGED_FROM(0.00)[bounces-239675-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,infradead.org:email]
X-Rspamd-Queue-Id: B53FB432245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zide Chen <zide.chen@intel.com>

[ Upstream commit 7b568e9eba2fad89a696f22f0413d44cf4a1f892 ]

This warning can be triggered if NUMA is disabled and the system
boots with fewer CPUs than the number of CPUs in die 0.

WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]

Currently, the discovery table continues to be parsed even if all CPUs
in the associated die are offline.  This can lead to an array overflow
at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
trigger the warning above or cause other issues.

Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
Reported-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://patch.msgid.link/20260313174050.171704-3-zide.chen@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 7d57ce706feb1..c5adbe4409047 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -383,7 +383,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
 				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
 
 			die = get_device_die_id(dev);
-			if (die < 0)
+			if ((die < 0) || (die >= uncore_max_dies()))
 				continue;
 
 			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
-- 
2.53.0




