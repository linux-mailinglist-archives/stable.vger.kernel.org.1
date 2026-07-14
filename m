Return-Path: <stable+bounces-274145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VlbkAyLSVWr5twAAu9opvQ
	(envelope-from <stable+bounces-274145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:07:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7D751589
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:07:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YMqPbsMP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274145-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274145-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3C773009CE8
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AF93D666F;
	Tue, 14 Jul 2026 06:07:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118F372696;
	Tue, 14 Jul 2026 06:07:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009236; cv=none; b=hhgcXt9wSvJGRnKi06cIlr0HqB/O8QzPtLY2vOO5ziFGlDydA+3IlHSEagIfSAPd1VazXTZKErr1hRnUVFCsi1mfcUPhwxh614YhQZRMN18w8mQUrAOoXJCF55TiaJ/ZGbAImdzoO0Fyjm4jWnZY4FYWUvA5AnVSEBT8fZ0QyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009236; c=relaxed/simple;
	bh=EIKwocMY9Mz16Gz80xSOpJj0MFnDIoaOtpxqAdHPjUM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFCIyTPAms53aDsa8HomBIRjQw5TEKv9qZNMPTi8gIfBi5Nds7sX+t12D1StPzjNbzTBpFB4JbTgW7nAg263B3lUahoKYiX4UbNqyPkKuZnjyrcpYauDV4qZJt0dXx3vBN/brO085VZTtLmhvHmFkPxBWclvgs/d7QVRlwDwL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMqPbsMP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 594F51F00A3A;
	Tue, 14 Jul 2026 06:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784009235;
	bh=VOnevRL2fUwJn3hTVi1t/RaCUkd0JBF3tRvHqDHD9hY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=YMqPbsMPldI+eCjIvRBaMxiKuQMGYGIqnPAbUL5q2ieW7PartREfOiGQGATj0ssAv
	 1U9dl0jJRiujfUljbT4eDxrjQM7gxWecWrnqyr2ZTgvSP0JofOlLPTdkCeZpD79Zoa
	 iRFunq7PFiA1hMhQ5QnI3rAqXK03HNQEg4UY8UBAM4ZR7xkaG4IwDRPRwm7dGreW/Y
	 CpFOrDDdVXSe/Db4sBS/3E7+XPfndAKMMLM2RPtd0nCBapOKVqzSqEPCE61L0CiL66
	 4KVRN2oxUnY3/p3e+ERcF+BbKTHAhGdwTZUEiXSF0bdsdQ/PFFKmjCrxAt2BtVlqH+
	 UF+YINhRt5vnA==
Date: Mon, 13 Jul 2026 23:07:15 -0700
Subject: [PATCH 5/6] xfs: clamp timestamp nanoseconds correctly
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178400716925.268162.444784889317482361.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-274145-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EC7D751589

From: Darrick J. Wong <djwong@kernel.org>

LOLLM noticed an off-by-one error in the nsec clamping; fix that so that
we never have tv_nsec == 1e9.

Cc: <stable@vger.kernel.org> # v6.8
Fixes: 2d295fe65776d1 ("xfs: repair inode records")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
---
 fs/xfs/scrub/inode_repair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index 493dcf5cc6c159..5565e80691a69e 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -1757,7 +1757,7 @@ xrep_clamp_timestamp(
 	struct xfs_inode	*ip,
 	struct timespec64	*ts)
 {
-	ts->tv_nsec = clamp_t(long, ts->tv_nsec, 0, NSEC_PER_SEC);
+	ts->tv_nsec = clamp_t(long, ts->tv_nsec, 0, NSEC_PER_SEC - 1);
 	*ts = timestamp_truncate(*ts, VFS_I(ip));
 }
 


