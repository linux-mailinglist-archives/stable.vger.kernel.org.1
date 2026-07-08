Return-Path: <stable+bounces-272549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MwYvHWHaTWqq/AEAu9opvQ
	(envelope-from <stable+bounces-272549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 07:04:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B324721B16
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 07:04:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="nKCg9/KM";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272549-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272549-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 083C43009CF9
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 05:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5914237CD3D;
	Wed,  8 Jul 2026 05:04:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3E1E51E0;
	Wed,  8 Jul 2026 05:04:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487068; cv=none; b=MRB9GAk9MFGVq/0MBmYXUeiQ9tXdC9WelXO+hz0046q6pB3o4HcZPBUhfIkcEgGbDvMfRX4xJ/zuIQjaEJ/yZ2dpP7E6qrRxQtVarPUmJ9qsxAPSDiDVYVFSsKc51C7xZFUCu19ItYH1MuKXXOXeqNKbY7+rPmTuC0cp7OwLQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487068; c=relaxed/simple;
	bh=OoDeBw1d3MtqV8UiZirvMaP4yCQa+/SgK1mAqDvxKLA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOz9v1VO8hAAvYMWbz+IhvCJ6upzVUQVKO36nad9QTmLurRaNP91Ti+Z2wbxiqL+653eSRsG2S5z+LqnLkM3XZ8zvhgXazXqW8yXk0Z88gTJU1xATkNuqzvCgEzCEPqMwY0vAKUDhTJooeqCizZMyfRP4HEWDgjlG+vpQV2NDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKCg9/KM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E31E11F000E9;
	Wed,  8 Jul 2026 05:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783487067;
	bh=z0eP1PC+9/ib/5UkCbwQ8BdVWAE/6FSGiiBAAI3MK1s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=nKCg9/KM6APsBdXr7vZ4ODSM8u8z/NRhQR1oeRcXneazA5ak+FIYdGfvBqYTlT29s
	 4au4+Vxfc5iLuhLdCO2vYgM3pvw6P3Y6goc5faP/CkEl5zwg3uuvKytm160vj2sn1k
	 uaABLzpJf48k5W4fB/t/tBEx2XZ6/sRQEf4xNVDb4qyRcFtqUBIA926n/Gm3ImoDRi
	 nOkgDsctdQ8MJhxP+u8fFIMQ7QQS9QOgDpmfeIU1x4z682u5by04cwQ1k4wsqfkkD6
	 lkw0TlMKSEoQD7BoYSeeL7HNyie56ShIoPpsSeXZFihA97VV+yyZJBdPL3b5oUqS8c
	 ENUUEU3NYZFGg==
Date: Tue, 07 Jul 2026 22:04:26 -0700
Subject: [PATCH 5/6] xfs: write the rg superblock when fixing it
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, hch@lst.de, cem@kernel.org
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178346726193.1271589.8429966417697809477.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-272549-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B324721B16

From: Darrick J. Wong <djwong@kernel.org>

The rtgroup superblock fixer should write the rtgroup superblock.
LOLLM noticed this, oops. :/

Cc: <stable@vger.kernel.org> # v6.13
Fixes: 1433f8f9cead37 ("xfs: repair realtime group superblock")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
---
 fs/xfs/scrub/rgsuper.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/fs/xfs/scrub/rgsuper.c b/fs/xfs/scrub/rgsuper.c
index 482f899a518a85..a52d37c33ca15a 100644
--- a/fs/xfs/scrub/rgsuper.c
+++ b/fs/xfs/scrub/rgsuper.c
@@ -80,9 +80,13 @@ int
 xrep_rgsuperblock(
 	struct xfs_scrub	*sc)
 {
+	struct xfs_buf		*sb_bp;
+
 	ASSERT(rtg_rgno(sc->sr.rtg) == 0);
 
 	xfs_log_sb(sc->tp);
+	sb_bp = xfs_trans_getsb(sc->tp);
+	xfs_log_rtsb(sc->tp, sb_bp);
 	return 0;
 }
 #endif /* CONFIG_XFS_ONLINE_REPAIR */


