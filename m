Return-Path: <stable+bounces-273142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gkFNG+mBUGpH0QIAu9opvQ
	(envelope-from <stable+bounces-273142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:23:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D90DA737518
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:23:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b7FO+LZl;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273142-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273142-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B91B300E3AD
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D4E367290;
	Fri, 10 Jul 2026 05:23:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7224336D;
	Fri, 10 Jul 2026 05:22:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660980; cv=none; b=iOj0xu07u2TiVrRKS0WK+9VWSIqOuZT1+ee6KlRUTZBNBoVXDMx/dhxBvoy2YghIB4OJLWllLg+cR40fzc7Sc1KaILQRUPcsmvfpc6aI2uzwxlpyIbOu4bB9/QZBixErF9s4mB/ZDru3v+ux+yd+6rQa+KqTK4wHeLXTNUhjRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660980; c=relaxed/simple;
	bh=acN8/KG/UGZ03+FWD8TQf5mTnOIgAsZMVSzU9ynLSX4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCI9/XLbBcfd75GBmRV/wDIc08kd5zVC2qv+oLKOodhphWz5iMWwx53gnPSgGD7cS7ngA+fuiyQ3fbGQGTtTB84LAz84d+VE3EXEVQ24OJvNS8tkWK9Sz6s7JjcgoXBaIA2Gi90gkyVS/ZZoSaKVB4T11WWXAKIy3QR4c9tpsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7FO+LZl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 220231F00A3A;
	Fri, 10 Jul 2026 05:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783660979;
	bh=dQzDKXk99AtSaZNtTXaCmTADdTAMXSR0phrjIrwAYw0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=b7FO+LZltGr0ibVjtl1lLUxJ/PLW7bQDbQUUVDFIZ+n7UVZc76pYuMKrrAorRmCSH
	 Qjpeu798tQj6G5XVXJLtN3LYAfuep5Zy1L9Fl58bGf2LJvyD1OJix5z/GUfo0zdzjW
	 xfQ20SzGliCrZZ40zVw9KOAX2stRPay/ENc7HWT+mBm8ltckJnClVQvMR72cEjvLVa
	 B2QGayMEFDnT39PaOg+pv8zmyqLciZtcqq8M3D9VAtqMpHWDJAX3QZYJ39PtRS55Pd
	 23tMiRpyMZAxARFPau9paEVwZKhtydRIMqdzoA/UN4iXLqld1FDyISQPzzPwTl1bYA
	 vlKyec7obtD3w==
Date: Thu, 09 Jul 2026 22:22:58 -0700
Subject: [PATCH 5/8] xfs: use rtrefcount btree cursor in
 xchk_xref_is_rt_cow_staging
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178366081099.1173468.12035180432743902143.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-273142-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[frogsfrogsfrogs:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D90DA737518

From: Darrick J. Wong <djwong@kernel.org>

LOLLM points out that we pass the wrong btree cursor here.  We want the
rtrefcount btree cursor, not the non-rt one.  This is fairly benign
since it only affects tracing data.

Cc: <stable@vger.kernel.org> # v6.14
Fixes: 91683bb3f264c0 ("xfs: cross-reference checks with the rt refcount btree")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


