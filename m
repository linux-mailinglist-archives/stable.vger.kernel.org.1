Return-Path: <stable+bounces-221086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKCsJF1Io2l//AQAu9opvQ
	(envelope-from <stable+bounces-221086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7741C791D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 017DD3785713
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3437136D9F4;
	Sat, 28 Feb 2026 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSgr2liE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A9301F0D;
	Sat, 28 Feb 2026 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301430; cv=none; b=GCBdiykEXRH7aOLO9lKn7YHvAQs2CnCBtEXPr5pfiYU++eJrcjYOKWl6FzIhWfAW6omQTNvNbSWLI2TdiLpGkqyKKXzspZ9EFxNt7HLuxEfLY5u8m1sy7nksUJicczC902I3DI0NxXO3q1EyR0a83ayWcoITOvPJanZrppfU5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301430; c=relaxed/simple;
	bh=iQnX+4o+AUZBwJkC+zOGV7Sf4aoS/SXbeAAQ5OCyguU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRkny/imQ9fdBiCY9CGBazYqwmzfO2tnPY1wKDRiLJ48b9TrOqJ+e2micrUa4t9sBpOSOB0w9IJ7pMTDp1W0exm+RV+u8JXLvFuNHoZCdRKyC3WE+0/z8tBFCu7vGZY92GbiHrH8fSFYVGS+HL7BXugjSlxLmD/tr6lbJ3XdIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSgr2liE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F926C116D0;
	Sat, 28 Feb 2026 17:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301429;
	bh=iQnX+4o+AUZBwJkC+zOGV7Sf4aoS/SXbeAAQ5OCyguU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSgr2liE/9qWaTMRR8Yp0mDbeEunteM35wDKNn16ZZlonjowLu8L6xtv6X35k6ieS
	 CZMYeGnQurD2lEyw2KRsgoYwEVN86DGSrjtgVA4Tqx+FCdqiSE+Fg3Q+20tPX0CqS7
	 ewQ2go42eTI2B9aYKubFkP+GIFGP+uH0h/RjqIxqQ4X6MH3lGjf3wh7VxG9H7taGKK
	 JjwGw6Mec5aIZ/PggEbRoxpwKomRprpgAiWTb0BUX5xKYmfoiX7+Dzhd1nup4O08FM
	 x29Xo10ZZYUUyAsC4/iyJoPkkUidxQEH6xsgdHii1w9iSroNAT+lxXTZ2uIjSKs0UC
	 eDjX51d3Bwkzw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	stable@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 620/752] NFSD: fix setting FMODE_NOCMTIME in nfs4_open_delegation
Date: Sat, 28 Feb 2026 12:45:31 -0500
Message-ID: <20260228174750.1542406-620-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221086-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA7741C791D
X-Rspamd-Action: no action

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit 41b0a87bc60d5ccfa8575481ddb4d4d8758507fa ]

fstests generic/215 and generic/407 were failing because the server
wasn't updating mtime properly. When deleg attribute support is not
compiled in and thus no attribute delegation was given, the server
was skipping updating mtime and ctime because FMODE_NOCMTIME was
uncoditionally set for the write delegation.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 740c40eb5b366..c5dba49c90356 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6356,7 +6356,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		dp->dl_ctime = stat.ctime;
 		dp->dl_mtime = stat.mtime;
 		spin_lock(&f->f_lock);
-		f->f_mode |= FMODE_NOCMTIME;
+		if (deleg_ts)
+			f->f_mode |= FMODE_NOCMTIME;
 		spin_unlock(&f->f_lock);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
-- 
2.51.0


