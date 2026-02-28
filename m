Return-Path: <stable+bounces-220773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE5LDaxDo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:36:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE741C72C5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 026523180B6B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570D7408E6F;
	Sat, 28 Feb 2026 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfZWjRGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18074408E67;
	Sat, 28 Feb 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300653; cv=none; b=a0Pc15fvcPlKUDoOyIK8ToLRvoMhy8J385rOH3GHMiDicrD7dh42+3Yij+08ovu7EhXDaTxbjTNl1u7P0ysg0ESb+UyBnRyZl9G2CXdKtA1OWVQ9AVy7+nqo+pMcfKn7buDnbyfORKGQpjtiMT95pb5JIX+URUfm+tlTzSj4qzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300653; c=relaxed/simple;
	bh=Xcb95x740lu1XJg4kTK4/crhGdElR3gbj+YKv0KsAIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+xrXr4ytWapZXirZywD97+nBUaJJgXuxGEtkFXXAm76Ssa4YCadpxfuVS24eDznrV5n7/B9rn6BgnshcbOFgCLhpg5ht0+S7xApACkUrc1HEyVSeQwvVBex1l0/A2tAWjij1Uqfye3zjN76IC4pZFHeqHGFhL7rS+jBPf+na3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfZWjRGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB1C2BC87;
	Sat, 28 Feb 2026 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300652;
	bh=Xcb95x740lu1XJg4kTK4/crhGdElR3gbj+YKv0KsAIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfZWjRGOYkduHXBVNJjxPmR9jbBLJjGMMu4olAAoo7R7KGQYx7YIcd5a8iXuVCRdj
	 Lq/yXqo3772m2CMfsXxyS4nArCZ44zD0Pb1EdQZ9r7+uGHDeWzEqK/5HCxgvmX6jcP
	 NVryc1MM6WKTJ2fd5sB9lyJnTtZ4xwgr08wKYRMksDdXAU7ot1LkmFDVmnPkr8XMBR
	 EQ2vXc1xbvlmUaoX8kyDl0CqJRJDpL+OCR8OegnFGswDUUWprZ9QEX5l6b+DMcnkYY
	 vHFDR7zijqcXi6BWenz6rb/YMTMiYXJDZyHrPhxj9G3K0pfVxodP0WZU0kndH3mJ8s
	 mOClCsJYZC2ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 694/844] NFSD: fix setting FMODE_NOCMTIME in nfs4_open_delegation
Date: Sat, 28 Feb 2026 12:30:07 -0500
Message-ID: <20260228173244.1509663-695-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220773-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFE741C72C5
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
index 45d486466cdc3..c298ec2621ec9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6353,7 +6353,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
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


