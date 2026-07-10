Return-Path: <stable+bounces-273143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1JdYKx6CUGpU0QIAu9opvQ
	(envelope-from <stable+bounces-273143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:24:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E4737526
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:24:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="keZU1oF/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273143-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273143-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5013301F5C9
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549036DA0F;
	Fri, 10 Jul 2026 05:23:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A13321445;
	Fri, 10 Jul 2026 05:23:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660995; cv=none; b=Gdf+/CMhaSeIzw5X8wNM5qP/WUbl3zUuOyc3tsCbahDMM54iZ587pFWyZg0EdLXgOUPh6W/2cTMVGk1WqjO2M00fS1EMNPUQndubumtwaAd9Wl6y6zgCNBvSFEWZE5vKnI5GgA0Nmr26AuWed2Z+Sg/RJbE8OPr9P0bK0JNjmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660995; c=relaxed/simple;
	bh=s2YjLy7yJLaYvD1Vyf79m/xJ4rbdSAPmDboV1yWJ8UE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGcIPRObQdKCUWDMMJjvwjLWyfLfnURvEhIDUFQ2g8dEYN95j+y5/WWi6RTPNDS6AE6BnpY0ZwNKgK+VU+u9rf1csk3D1d3PCvBBj/aojbGiHVJPrmjvcmho/QXKlsVynYk8Y4DHttChZnyL92avkzxlO5s0l8Q8bUpR2os9XpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keZU1oF/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9F8951F00A3A;
	Fri, 10 Jul 2026 05:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783660994;
	bh=050siUOTgWiPSmWq54OI+FW7Xh+qogw4IQj65GpaE/s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=keZU1oF/+eyy5OiE1z0Q6XiKG4BgF5RPMHbB2cF0i37F0Q13yEz3No5vqo6kj8OqW
	 Ija6FES1VYY98X5wRjnXxxoXKaxwngmGruxqAtfbSPZ/EIywql9rOYlsHuTSAad6WN
	 0UEBbCgTrhmZwfZnZPtIswHY5iLXBtbGwExa3AWH+/cpEGdX5h8y3Nb5p86Fbbgpx3
	 IbRWhS0soh0wUFR6OWwo//HdelVdRrw3zwATXAVPO78LHCwgDDkAMy3RYon3LeUdxT
	 Iq9qAWbGTiW+CCuY11illg2svZ8F5UfuLQumEco7Hbua53IOmOcaBS/RO5QxkBugTX
	 NanAfnpbt0p5w==
Date: Thu, 09 Jul 2026 22:23:14 -0700
Subject: [PATCH 6/8] xfs: use the rt version of the cow staging checker
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178366081120.1173468.6221210858309097703.stgit@frogsfrogsfrogs>
In-Reply-To: <178366080946.1173468.2461850065055339934.stgit@frogsfrogsfrogs>
References: <178366080946.1173468.2461850065055339934.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-273143-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[frogsfrogsfrogs:mid,lst.de:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 089E4737526

From: Darrick J. Wong <djwong@kernel.org>

LOLLM also noticed that xchk_rtrmapbt_xref ought to be using the rtdev
version of the "is this a cow extent?" helper function, not the datadev
one.

Cc: <stable@vger.kernel.org> # v6.14
Fixes: 91683bb3f264c0 ("xfs: cross-reference checks with the rt refcount btree")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/scrub/rtrmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/rtrmap.c b/fs/xfs/scrub/rtrmap.c
index 043be93c714884..b3b2cf17ba2c08 100644
--- a/fs/xfs/scrub/rtrmap.c
+++ b/fs/xfs/scrub/rtrmap.c
@@ -209,7 +209,7 @@ xchk_rtrmapbt_xref(
 			xfs_rgbno_to_rtb(sc->sr.rtg, irec->rm_startblock),
 			irec->rm_blockcount);
 	if (irec->rm_owner == XFS_RMAP_OWN_COW)
-		xchk_xref_is_cow_staging(sc, irec->rm_startblock,
+		xchk_xref_is_rt_cow_staging(sc, irec->rm_startblock,
 				irec->rm_blockcount);
 	else
 		xchk_rtrmapbt_xref_rtrefc(sc, irec);


