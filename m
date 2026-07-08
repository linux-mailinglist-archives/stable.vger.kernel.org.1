Return-Path: <stable+bounces-272547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hh/6DV/aTWqp/AEAu9opvQ
	(envelope-from <stable+bounces-272547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 07:04:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7E4721B11
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 07:04:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZAbbEpEY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272547-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272547-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DAEE301FD62
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2D39989D;
	Wed,  8 Jul 2026 05:03:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E801E51E0;
	Wed,  8 Jul 2026 05:03:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487037; cv=none; b=F11XWK/ZqRU8H5QJGZXFPme8UpGbwqRQw7xrsOH7+qwjJa+3tjmF30WLCnRvRZEQutIdowxhK5ldRRrJxvBp6F+8LemHFvhV9V3d3NP8dcTKAtPxtSE/2U+lx5ayv6nlOXssIBW3bqcnIy5WLYAIRvNAiagxQgU8grCqv3B1j9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487037; c=relaxed/simple;
	bh=d8dS9MPWqQ9lK4iVeXJaV3gN1Z7ldBJ3hGoN0hvB9No=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrJyHqgf0eamPOZEhemv0zbiU8KU7fYehAvJ2eEGjsv+3knKA7kYLAPpqrX3p6EoDx1RFHkupLGQWKFLC3m98Nl2pnJciY8pGHIRqae47cXav6+hF1qGSSH4+bjYNrklYBtSAaYtNGEr9ajkzJdhwpSqNhR3EzvXizQLodc0tDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAbbEpEY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D8C1C1F00A3A;
	Wed,  8 Jul 2026 05:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783487035;
	bh=ltJbUE4dtJuUgo/6AR6BYLzKRMD7SW2e5iIqtsI4A4c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=ZAbbEpEYS6OobtAGYrom/qcZiRH1BmCDt32I7KUhZLfeBajjvNrf21JCAnf30Vl70
	 Eh/0EQKte9YOUeOVLlXImchyOF3ZuZHL1Lf4iXrhaxRiRxCmq/Fb3wcFeRn4Gpg6Jk
	 71f1zS7wrBioazj/9EuSTjSCelBQc/wIyINi7VvBDoKSkB9gnQBUNcqCenIj1kjfqW
	 LnmKpRrInMdgpOhtDKE+gzmoyIoTL0zzilQk3s8JsQObE1tA0HkfSpuiY7IHBqQZ3O
	 6HmUjrpzJCGbFFHvl3Ycn6gO4Tn7sl5s6SGb6mPOamunNZfhpgyJ7GN4ccv5/N+ROw
	 ySW0HpWU0hwVg==
Date: Tue, 07 Jul 2026 22:03:55 -0700
Subject: [PATCH 3/6] xfs: use rtrefcount btree cursor in
 xchk_xref_is_rt_cow_staging
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, hch@lst.de, cem@kernel.org
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178346726151.1271589.2993932219666082877.stgit@frogsfrogsfrogs>
In-Reply-To: <178346726054.1271589.14164163317011378817.stgit@frogsfrogsfrogs>
References: <178346726054.1271589.14164163317011378817.stgit@frogsfrogsfrogs>
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
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272547-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F7E4721B11

From: Darrick J. Wong <djwong@kernel.org>

LOLLM points out that we pass the wrong btree cursor here.  We want the
rtrefcount btree cursor, not the non-rt one.  This is fairly benign
since it only affects tracing data.

Cc: <stable@vger.kernel.org> # v6.14
Fixes: 91683bb3f264c0 ("xfs: cross-reference checks with the rt refcount btree")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
---
 fs/xfs/scrub/rtrefcount.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/rtrefcount.c b/fs/xfs/scrub/rtrefcount.c
index 0d10ce2910c2cb..4e7c540c8d2307 100644
--- a/fs/xfs/scrub/rtrefcount.c
+++ b/fs/xfs/scrub/rtrefcount.c
@@ -607,7 +607,7 @@ xchk_xref_is_rt_cow_staging(
 
 	/* CoW lookup returned a shared extent record? */
 	if (rc.rc_domain != XFS_REFC_DOMAIN_COW)
-		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
+		xchk_btree_xref_set_corrupt(sc, sc->sr.refc_cur, 0);
 
 	/* Must be at least as long as what was passed in */
 	if (rc.rc_blockcount < len)


