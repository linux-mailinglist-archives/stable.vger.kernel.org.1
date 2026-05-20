Return-Path: <stable+bounces-251242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A7KIOryDWry4wUAu9opvQ
	(envelope-from <stable+bounces-251242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B35946EE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88E1E3069C13
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F26366075;
	Wed, 20 May 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vL5jaUA9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE8331220;
	Wed, 20 May 2026 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297474; cv=none; b=as7zkA+NiLEQZvce9/SEhSrM6YqCNkeafS+quX6B1DlXNStR6p1I19WTdOqT79CkLGtRCwGCS4gEVIVrtMrfMW5bfjThtrh19s99eRza/c8Qwg6fksxQGEvuNVrdy6nlp6sFi3g7cCXz3YF8xzo+wYT0NSyjWnD91+Ac/+bMjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297474; c=relaxed/simple;
	bh=LuE0uTaogFt45N3vtV53M7ByORfSHcSXjBlrhcMiXx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib8aWodlOcwocSPmNiPK97NJxO/b/Byl2kBuH3EODw/Nal22Sd9WG4sj0VYVyMveUUl/+zdn+Kx+IOmr+DSAbFVCFAOm97TZbDtJAG2e4hXVUpv7IgeNKZqrPrL7BvCElSIaak/tbpeVUMBKZ/DvTG88ZSeb+DNoBIhPi2zR8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vL5jaUA9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6EC1F00893;
	Wed, 20 May 2026 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297473;
	bh=RJvDPle6VPaZb3oXeSNPQWGRZ2am7mxw2QFfYlyYn34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vL5jaUA9E61H9nqPvuvIIr7xBCPqnA2aodGszB3tBvx28WHzsD4S+w5oQtM0ibsBz
	 PM7I5tf6Xptr5T6szs4B1adLzwCA82u2erzk/FSzWzFACf29whf4gTSPik5xQQSxTM
	 LbfDQVRlcvsZdyyi6iIlJ3wT0NVfQ3CrVDBjNo4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 038/957] perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
Date: Wed, 20 May 2026 18:08:41 +0200
Message-ID: <20260520162135.385733129@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251242-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 4E1B35946EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@amd.com>

[ Upstream commit 723a290326e015b07931eabc603d3735999377be ]

Commit 50a53b60e141 ("perf/amd/ibs: Prevent leaking sensitive data to
userspace") zeroed the physical address and also cleared the PhyAddrVal
flag before copying the value into a perf sample to avoid exposing
physical addresses to unprivileged users.

Clearing PhyAddrVal, however, has an unintended side-effect: several
other IBS fields are considered valid only when this bit is set. As a
result, those otherwise correct fields are discarded, reducing IBS
functionality.

Continue to zero the physical address, but keep the PhyAddrVal bit
intact so the related fields remain usable while still preventing any
address leak.

Fixes: 50a53b60e141 ("perf/amd/ibs: Prevent leaking sensitive data to userspace")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20260216042216.1440-4-ravi.bangoria@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/ibs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 112f43b23ebf8..10af127f779fe 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1214,12 +1214,10 @@ static void perf_ibs_phyaddr_clear(struct perf_ibs *perf_ibs,
 				   struct perf_ibs_data *ibs_data)
 {
 	if (perf_ibs == &perf_ibs_op) {
-		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)] &= ~(1ULL << 18);
 		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)] = 0;
 		return;
 	}
 
-	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)] &= ~(1ULL << 52);
 	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)] = 0;
 }
 
-- 
2.53.0




