Return-Path: <stable+bounces-271998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RbESBn7LSWrG7AAAu9opvQ
	(envelope-from <stable+bounces-271998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 05:11:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89105708D63
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 05:11:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eJvAKvmF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271998-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271998-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78D77300B3F0
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 03:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A445225413;
	Sun,  5 Jul 2026 03:11:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3B2C9D
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:11:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221116; cv=none; b=oKDgQUurhc5zbknq6MDA+bFjwEGkmIOHNeHy2Kg+Anqa7K4SFmktGTf/91q8dI13rMpcmI00CnH+jjUjSGt/Z1LK9vUOTvaz6Y7qw+iVYwSWwhWJodt9rhQI4r8fhm3EPRCJpO1ZSs3me8yl4bKmIhkFIl6Eat0BC2LyXvYd04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221116; c=relaxed/simple;
	bh=vZUXEAD1FCBY1JN6EM1lD1nEIjH6B5ApX6jCvKalcZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nePPPseXqrWuwRUZQpTHppwgbD30ZNv3NSOTSQSF41M2DMBvMKEOCGq65QBOa70KA2HqHgSxQSysCafzzAaoNyOiDtkN+TD8SlWSRyiUY/gcYH4EijXKXWx8Eiq3RmsemsG/G1DMkb1T1jSMaVcYRMxrsWGiR5OOVOGGSteDAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJvAKvmF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535901F00A3D;
	Sun,  5 Jul 2026 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221114;
	bh=dERfe+sRnEwrYxnedPVJnCwWewOocmxZdnXJQqnqPCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eJvAKvmF8nE6Ux6dekmS2bcXP5sbizuPr6DZaWL0A82Ew3pVTHEHibHl5hll4TY85
	 zgdPU03YkcEty9G7KFvAlg7Y30iEk/IIL705uM7SyY9qCP1Z8pGQShX0leIeyDhUh+
	 Iq+f1EcXQfy7hRnfK2DnEHogndb/tVYyR/BnZqkyEPfDNL0qEt+RrB96j8PBk6LroH
	 9TRXfIeDeQd/JMlM7tO4FQ7Q8t2VVNGXekA8fT3IPyaaat7jOrER64X1mz5N9D1RbQ
	 qBrmiKgOQpcGDcWb79DANdzLn6i96FKKXcX4zeGX1vrv7Xy58gALOdYC80Qnkq/a3H
	 /3Jc2HT0outCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] NFSv4/flexfiles: Remove cred local variable dependency
Date: Sat,  4 Jul 2026 23:11:48 -0400
Message-ID: <20260705031150.1600970-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705031150.1600970-1-sashal@kernel.org>
References: <2026070242-poker-barricade-3a69@gregkh>
 <20260705031150.1600970-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:jcurley@purestorage.com,m:anna.schumaker@oracle.com,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271998-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89105708D63

From: Jonathan Curley <jcurley@purestorage.com>

[ Upstream commit fec80afc41afa3016421115427df8d00dc491ee5 ]

No-op preparation change to remove dependency on cred local
variable. Subsequent striping diff has a cred per stripe so this local
variable can't be trusted to be the same.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Stable-dep-of: 2c6bb3c40bc2 ("NFSv4/flexfiles: reject zero filehandle version count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 6469846971966b..8d43ba6e3ecc23 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -531,10 +531,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (mirror != fls->mirror_array[i]) {
 			/* swap cred ptrs so free_mirror will clean up old */
 			if (lgr->range.iomode == IOMODE_READ) {
-				cred = xchg(&mirror->ro_cred, cred);
+				cred = xchg(&mirror->ro_cred, fls->mirror_array[i]->ro_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
 			} else {
-				cred = xchg(&mirror->rw_cred, cred);
+				cred = xchg(&mirror->rw_cred, fls->mirror_array[i]->rw_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
 			}
 			ff_layout_free_mirror(fls->mirror_array[i]);
-- 
2.53.0


