Return-Path: <stable+bounces-274142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ufYUKuzRVWrutwAAu9opvQ
	(envelope-from <stable+bounces-274142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:06:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9175155E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aEfDFPlJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274142-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274142-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D580A3009F02
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE003D6493;
	Tue, 14 Jul 2026 06:06:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AA3D7A01;
	Tue, 14 Jul 2026 06:06:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009189; cv=none; b=VNLw9dgYS8ntCmWaped5jPKwnjpKV7u5w++S5eGrJscs+zW9mMaB4tAOgRByvqsU2T4Re3CXbPijwvKkOxSvIMCfB/pafiH5/mNhf+57Ms/IFTWCdkY70wcXigfH6g5nJCzr6IN1Yp4lCijzSbD6YBuTESJ12mqVNcBUdkDmzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009189; c=relaxed/simple;
	bh=rxjMGCsyCVfoMcL5cJePZ85puAs5N7fe5njb4f07Bag=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRRfYFZ7wGV4NbqV/WiqfvuZUSClHg+NaV+Yx56KavW9R8WtYrcFRUXTjet9zmlDUr/acJ7ZTMowR/kirP7VEtXtU1zs84KHnoI8lSt0d3hb2qXooHO0j5EXQmfsC+eBpf3W0pUZKVJ43V1iEOp1POGIAqb2FziY1wVHmT5uGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEfDFPlJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ACE441F000E9;
	Tue, 14 Jul 2026 06:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784009188;
	bh=411yU0ScccAFgZa2VlXqY5m0dpuP2LHw9JDObfsfcAM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=aEfDFPlJx0KmafMobHHPianSn7ohq5iSdBQmLpT8caZrPVOB2nNJZVIXO3XsIbdwj
	 ZB4P679N44wTQaiwmVJ0q9+iQJagtLMLv6twhdaNg6MW9Q+bBnbDX5leOMkkzBH9NC
	 /N3vp2SUpycO8OPar1arJNRH6+NEElm1OnbQ2v4Brl97eDu14YciqhgehSzcghv+ks
	 MFe2UUeqEOhO37cp7q/L9oW4HcujnufySzjWE/WEIQJjvreVuWBuc8W0Rwp3dw1ro1
	 GjhY7BNMvwFOKERYB/xU+W3ooHI1RkY1+hKXm5vMRBlXFb0851LUsib97StRI8NO2Q
	 4s8YoApmllwIQ==
Date: Mon, 13 Jul 2026 23:06:28 -0700
Subject: [PATCH 2/6] xfs: fix off-by-one error when calling
 xchk_xref_has_rt_owner
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178400716859.268162.13837291911320452593.stgit@frogsfrogsfrogs>
In-Reply-To: <178400716782.268162.4846177784022689546.stgit@frogsfrogsfrogs>
References: <178400716782.268162.4846177784022689546.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274142-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:cem@kernel.org,m:hch@lst.de,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,frogsfrogsfrogs:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEE9175155E

From: Darrick J. Wong <djwong@kernel.org>

LOLLM noticed an off-by-one error when computing the length of the
rtrmap to cross-check.

Cc: <stable@vger.kernel.org> # v6.14
Fixes: 037a44d8277adf ("xfs: cross-reference the realtime rmapbt")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
---
 fs/xfs/scrub/rtbitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/rtbitmap.c b/fs/xfs/scrub/rtbitmap.c
index de3f22f310f7eb..52c24d3d4be6ce 100644
--- a/fs/xfs/scrub/rtbitmap.c
+++ b/fs/xfs/scrub/rtbitmap.c
@@ -258,7 +258,7 @@ xchk_rtbitmap(
 	 * the last free extent we saw and the last possible extent in the rt
 	 * group.
 	 */
-	last_rgbno = rtg->rtg_extents * mp->m_sb.sb_rextsize - 1;
+	last_rgbno = rtg->rtg_extents * mp->m_sb.sb_rextsize;
 	if (rtb->next_free_rgbno < last_rgbno)
 		xchk_xref_has_rt_owner(sc, rtb->next_free_rgbno,
 				last_rgbno - rtb->next_free_rgbno);


