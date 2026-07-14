Return-Path: <stable+bounces-274146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzHnKFXSVWoBuAAAu9opvQ
	(envelope-from <stable+bounces-274146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:08:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31CD7515A7
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hg7vyg35;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274146-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274146-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4002A30488E6
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A33016F7;
	Tue, 14 Jul 2026 06:07:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207143D666F;
	Tue, 14 Jul 2026 06:07:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009252; cv=none; b=XX+cfm8AQx+3lGKtP1usZSaUUwpbXVprfuOm/k518mD+ezKWk1OfLB1JvuMS4hT3HQ47lFmH0hxMllwKAtLBSWpERuFSdDst1NdvmaQM2Ti7DyFhTdmwCP8hImiBO4RdDTp0ddhT6xReP2tc4DMH/tLdfjish4Nm1CRG3Og6b9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009252; c=relaxed/simple;
	bh=Cetr1bQndrsAVypnNfbtmGSlC8a4+hsuihBnoXbU8jI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGB5AAbUVaMxJG0Gx7RVpFmB5jQM5cSAq8WuWmbZLTChilhqnoNvz1e2Krpg/apQZqJwHchNuVn5N/zs1JrEibZJF2RSxcbTcwkAbuSwWrF1uSSGKoOf134bQh6jyj6KxdQUoWqyUEzWWl4dHfblrBI9g8HAGVO4xmoneVeGoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg7vyg35; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D8DD11F000E9;
	Tue, 14 Jul 2026 06:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784009250;
	bh=ZxYKo0sRpEti0pQnZnKyjrDyOGZ+Pr3nGZtSujy8hwQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=hg7vyg35n2n7XrWHkCEpXSFd4tC1JSMpWnKbasuV47QddmSK3dFQWxasNpKkFdhie
	 +BgmSin8EzhDQy8llHOvy9E0gluM49ecbdN+EIItypDPGrgEFImw4y4qM51C3/QuqG
	 IxrWpQLMulIjF/7Gq4K198Ykj6l+bwnCxsfxqYQahEfETSOaOwLC40GppR/Ete0qMT
	 Lv6oSKAsA2eI1P+hcZmk+VdMCp2JwBzW8lMpBu7KkTXMxeBk1LJj29eJp3rvL5zl13
	 HYBeaHW+f9eHwZNuqGGZKuhOMP5IlE5Xr57FXJ2LFdD6Q3tKnJuMYGbd61eHBfpKj2
	 XGI0uDfHvxwOQ==
Date: Mon, 13 Jul 2026 23:07:30 -0700
Subject: [PATCH 6/6] xfs: don't zap bmbt forks if they are MAXLEVELS tall
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178400716946.268162.18317924649043454437.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-274146-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F31CD7515A7

From: Darrick J. Wong <djwong@kernel.org>

LOLLM noticed a discrepancy between the bmbt level checks in the libxfs
bmbt code vs. the inode repair code.  We do actually allow a bmbt root
that proclaims to have a height of XFS_BM_MAXLEVELS.

Cc: <stable@vger.kernel.org> # v6.8
Fixes: e744cef2060559 ("xfs: zap broken inode forks")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
---
 fs/xfs/scrub/inode_repair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index 5565e80691a69e..3ec41c19835116 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -921,7 +921,7 @@ xrep_dinode_bad_bmbt_fork(
 
 	if (nrecs == 0 || xfs_bmdr_space_calc(nrecs) > dfork_size)
 		return true;
-	if (level == 0 || level >= XFS_BM_MAXLEVELS(sc->mp, whichfork))
+	if (level == 0 || level > XFS_BM_MAXLEVELS(sc->mp, whichfork))
 		return true;
 
 	dmxr = xfs_bmdr_maxrecs(dfork_size, 0);


