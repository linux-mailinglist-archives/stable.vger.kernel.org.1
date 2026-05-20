Return-Path: <stable+bounces-250072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JkTGYHsDWo04wUAu9opvQ
	(envelope-from <stable+bounces-250072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:16:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A727959339D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872A8354787F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAD23F39F9;
	Wed, 20 May 2026 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQn4STfC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A383F1AB8;
	Wed, 20 May 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294470; cv=none; b=Bk0/phC8ykJV5BW2CBKSSLk8TAWWTTQ3RQsdv/xRhXp4yItBcsF7Xx4R5SYEszaVY7c6bEqI+6+HLtKEy1TXqNyJPN8F4uzbNihxYMHL3v0nbY+9v5vINGVADVEZnPg9sqMe3i5vlUjjfsAcfTGtAci6aK4xFmMoRh9I+gcwhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294470; c=relaxed/simple;
	bh=swTAUfiA4bJaS0r50QhCnKYZIaqBhwECZEZsBc2tjmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvGUQHakEIldiIpLQPjhHQTwmE2KmXQv19Dt2f+R+xutzyA7nPG6GRFnu98PIUmmCD1ybYAdreXYrLcmskQCwEg9qD6DLu3u/7eVT2ZObIR2bXB9PWBZnNfe2nO0qv/4Akun0tAD22QMxwjHP5PtjSRe1W1gzt9qmwVCMX6Uslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQn4STfC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD951F00893;
	Wed, 20 May 2026 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294469;
	bh=FzlEFQTo8ss7pJXJGCX4EPedMiaUB7vFxgc9065gYrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQn4STfCbHeiZ90R3XnfWXi+7zg1SJ8kUUnbZkIayvgjsAhYGHLsTcP26P4/YtrB4
	 PxEV0RRJxv6weLHNk37EhMm/2cPMAqiPh4li6zyPxjhgy/b9LtBFWT2JlSq7VJ2Q2D
	 yUTWn8sT738nk3I3eXqvPWaaOCWxQ5Not5ZjWVe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0052/1146] perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
Date: Wed, 20 May 2026 18:05:02 +0200
Message-ID: <20260520162149.550577713@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250072-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: A727959339D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 705ef43325be3..ddd74eff3faef 100644
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




