Return-Path: <stable+bounces-274139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A3opIszRVWrktwAAu9opvQ
	(envelope-from <stable+bounces-274139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:06:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF5751534
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:06:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RTE4NdF+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274139-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274139-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C5CB302AF3F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8D3D3CF6;
	Tue, 14 Jul 2026 06:05:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9B1FFC59;
	Tue, 14 Jul 2026 06:05:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009158; cv=none; b=nW4TmubfE2k9ZHi58/RQjTSZsYXoL2b08a2CNNKqUMgihAiVx7Pi5vWLfHn6lPyblSLMndQLAyhxxJC+bPZh58qZN6/K0CyDd163TmQMHj3krLa6Q8APwVcpjn/LIrEh1mMovmPJ8ckgBp+uv0/PfsNIxRRPBaQSbFv/zqK3bJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009158; c=relaxed/simple;
	bh=ZUGNeCaIhOp2aiTrGjF76e0THENxkuunq/ieBoMewT4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h53tM+3BFmel9W/0mgAfVwVyhi2mx6FvZaahZeNeRM4yLvH1T27e1RuDm9SfrypRS7Ihdgeeks3tmbQdg6NpNZpcTgAaDGvtBdrjaZ+795fb27HuTe4um/y1SXyOgiJGEUBd1OIwMs0HFP5/7vEXIXUv+TaNf+/Ju3Xh6iNCp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTE4NdF+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9CE771F000E9;
	Tue, 14 Jul 2026 06:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784009157;
	bh=0a4r/CuVwtLPtdixj4JsF9xvRTAfAF5gZa8oqdwXv48=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=RTE4NdF+qutaWw6cbz9cYYvOSRh6hWd+xSEsyvBMQds9fd8M+2yF/R9Z0B1os2gbZ
	 KHUw/0gbsqfsXqX0ay68k3ksMJVA02XDNEOFou/CukoEAhb7PTnh4ZILO3h4zQylUK
	 oFs1LwDb88LUfRG+MfJrjE9u0p1f0DBvPdPk+5sRo+d2HlIlyi41q2xZYzWwZGfe1e
	 W/U4a8htD/CIBzxDyZLrX+HaPNlC7LiiXYWHu4ndHUozTzWsWeYOJlVGP9CkCaGKPp
	 MGodW47CybcDxv93VgvRuBnAY2KRZF9RVxSaCPUD3113GofG3IPspo+ZeLaDobWhgn
	 gb3XcCyFRhYvA==
Date: Mon, 13 Jul 2026 23:05:57 -0700
Subject: [PATCH 8/8] xfs: grab rtrmap btree when checking rgsuper
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178400716542.267810.5807049128183463210.stgit@frogsfrogsfrogs>
In-Reply-To: <178400716321.267810.14342805775513660564.stgit@frogsfrogsfrogs>
References: <178400716321.267810.14342805775513660564.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-274139-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1AF5751534

From: Darrick J. Wong <djwong@kernel.org>

LOLLM noticed that we aren't grabbing the rtrmap btree when we check the
realtime group superblock.  As a result, none of the cross-referencing
checks have ever run.  Fix this.

Cc: <stable@vger.kernel.org> # v6.14
Fixes: 428e4884656db9 ("xfs: allow queued realtime intents to drain before scrubbing")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/scrub/rgsuper.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/rgsuper.c b/fs/xfs/scrub/rgsuper.c
index 3dad6e5da74e55..2bd2c0351b35f7 100644
--- a/fs/xfs/scrub/rgsuper.c
+++ b/fs/xfs/scrub/rgsuper.c
@@ -23,6 +23,8 @@ int
 xchk_setup_rgsuperblock(
 	struct xfs_scrub	*sc)
 {
+	if (xchk_need_intent_drain(sc))
+		xchk_fsgates_enable(sc, XCHK_FSGATES_DRAIN);
 	return xchk_trans_alloc(sc, 0);
 }
 
@@ -43,6 +45,7 @@ xchk_rgsuperblock(
 	struct xfs_scrub	*sc)
 {
 	xfs_rgnumber_t		rgno = sc->sm->sm_agno;
+	unsigned int		flags;
 	int			error;
 
 	/*
@@ -63,7 +66,12 @@ xchk_rgsuperblock(
 	if (!xchk_xref_process_error(sc, 0, 0, &error))
 		return error;
 
-	error = xchk_rtgroup_lock(sc, &sc->sr, XFS_RTGLOCK_BITMAP_SHARED);
+	if (xfs_has_rtrmapbt(sc->mp))
+		flags = XFS_RTGLOCK_BITMAP | XFS_RTGLOCK_RMAP;
+	else
+		flags = XFS_RTGLOCK_BITMAP_SHARED;
+
+	error = xchk_rtgroup_lock(sc, &sc->sr, flags);
 	if (error)
 		return error;
 


