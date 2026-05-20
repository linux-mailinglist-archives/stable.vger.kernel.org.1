Return-Path: <stable+bounces-251254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFTBM9XwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:35:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E853594061
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 061F8316E1C1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A903BED26;
	Wed, 20 May 2026 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="akgkpEbD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FF35AC18;
	Wed, 20 May 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297503; cv=none; b=Dq5e4ljW0nLegEnWrACk8IMU6/yaMLnRWppSBBqru/p2QiflV2BqKxWDUi7Yw/HVKLBfF0IROCLBaSBMRgLJGKrmWXl4Yiowd+vdKJkXAV8XpwLz2MvxGDgmqo/Mpm/4kbmQq3GST8UikDXgsNRl3T4+JVMIoZbDsKJEWpDVy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297503; c=relaxed/simple;
	bh=4KsXxs/yKRT3SljL7U1lqZLpBeScWb6VOSLzptDsHuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxBp02YELFoMiPIBdXv4UX8SOMV8GB5ambUBQr5ATTOZnLT8/LUKSfndpZPK8KZXhOhRNsNshpSBIcaHHrdDtSz5Fb1HAB07C5CYb9EPsWDpxGj+5thsBAj/WBeiaeklhMD2RGm+S4G+ug47MftjJz9CNr+6N6iTFg9LHljUGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=akgkpEbD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C831F00893;
	Wed, 20 May 2026 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297502;
	bh=QESP774M9ET3FZIAsdR8gacV4XrZUm5wzMJofw4Oik0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akgkpEbDaY4HnFnbKYNxDMx6MtK8/jej8DcOV2rrVmCGYsiOzGg6URygxt7ofjjLZ
	 pGiio9nQveG3jaYvlTGx5xoHyk44+aSWRgwsvWF86b+wF0fmvE2bUh4VL/0/CgkjzL
	 ez/WMrK55uBwlVK7Mk1umr3AlvehOvU4Gu1ZXVig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 039/957] perf/amd/ibs: Avoid calling perf_allow_kernel() from the IBS NMI handler
Date: Wed, 20 May 2026 18:08:42 +0200
Message-ID: <20260520162135.407340640@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251254-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,amd.com:email]
X-Rspamd-Queue-Id: 6E853594061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@amd.com>

[ Upstream commit b0a09142622a994c4f4088c3f61db5da87cfc711 ]

Calling perf_allow_kernel() from the NMI context is unsafe and could be
fatal. Capture the permission at event-initialization time by storing it
in event->hw.flags, and have the NMI handler rely on that cached flag
instead of making the call directly.

Fixes: 50a53b60e141d ("perf/amd/ibs: Prevent leaking sensitive data to userspace")
Reported-by: Sadasivan Shaiju <sadasivan.shaiju2@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20260216042216.1440-5-ravi.bangoria@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/ibs.c          | 5 ++++-
 arch/x86/events/perf_event_flags.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 10af127f779fe..56918cd91115c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -313,6 +313,9 @@ static int perf_ibs_init(struct perf_event *event)
 	if (ret)
 		return ret;
 
+	if (perf_allow_kernel())
+		hwc->flags |= PERF_X86_EVENT_UNPRIVILEGED;
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -1342,7 +1345,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * unprivileged users.
 	 */
 	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
-	    perf_allow_kernel()) {
+	    (hwc->flags & PERF_X86_EVENT_UNPRIVILEGED)) {
 		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
 	}
 
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 70078334e4a33..47f84ee8f5409 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -23,3 +23,4 @@ PERF_ARCH(PEBS_LAT_HYBRID,	0x0020000) /* ld and st lat for hybrid */
 PERF_ARCH(NEEDS_BRANCH_STACK,	0x0040000) /* require branch stack setup */
 PERF_ARCH(BRANCH_COUNTERS,	0x0080000) /* logs the counters in the extra space of each branch */
 PERF_ARCH(ACR,			0x0100000) /* Auto counter reload */
+PERF_ARCH(UNPRIVILEGED,		0x0200000) /* Unprivileged event (wrt perf_allow_kernel()) */
-- 
2.53.0




