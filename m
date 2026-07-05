Return-Path: <stable+bounces-272079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y+SSF+BsSmqGCwEAu9opvQ
	(envelope-from <stable+bounces-272079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:40:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D57DB70A58B
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:40:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FF2UOJyd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272079-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272079-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47C4D3011079
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D1A384CFA;
	Sun,  5 Jul 2026 14:40:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9237DAA9
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:40:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262428; cv=none; b=rurO3ANjedVGB/RuYbQaweJbBpk+LSCipietNvoP7AhSKg9ydpNJkacgGAjRgvqSgg6Wl8lpaY/wwscJ6k6tffnAulg2G+WZThyCljdhy8VSvlTiJ2gfkX0TkEjLb60vyljlDC27Q3Tcr3R6F6xlDMMZx9EDwUrMK526cLgH9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262428; c=relaxed/simple;
	bh=jS2XdumNaVIUBbJ3VBT9LmBp6rlqyvgUHpNcx52Pba0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUrOANnDQg2qb2zl5kf2OexgXjrNahqQ6X+lY8y9fxcRZK9c98PdBWzdjoFCT7P46C7613iIN/vXirOnyP7lPZQwCCNMlkkFE1HENe6xNgXfM7r3fefObgRaWdctFu2bT6CNMVqg7I41o2wBJl/4LYFOYi1XyYuSQsXA3WJq5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF2UOJyd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFEF1F00A3E;
	Sun,  5 Jul 2026 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783262426;
	bh=pcxN3JEVKE+57r4qQ7Ay7nyfKAR0Au4Vg8C8OAzupn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FF2UOJydQexG46y0zlmiKM8sHMVBYKkiKvDIeib5+G20hRG2bS3T+DltYAEv0q7Pv
	 H3wkBwcZ7UfG19icds283Ap5tHDbZjoZT7lGmcrynsejXhj3qhRuYqtc7bniLQUYC9
	 LGK73O9XaLpKlVDeBOjEmLFE9P1VDM9vhmMtLLlUiTPy7iDhhUKyNKugi7dQ26txSv
	 G52OdX8AsrxUF4fXAKr/57tQ7ehmDYB87Ip3HiJlq0baNvHAH4/oTuEz9GHWW2GSBj
	 cMycsDwkf7y9TW9d8yYIZmFvNajINDoLbITHdBcsYK/B45TKE0oDpogtcq5jERrXw5
	 lTBTexvH12/vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] nfsd: reset write verifier on deferred writeback errors
Date: Sun,  5 Jul 2026 10:40:23 -0400
Message-ID: <20260705144023.1865360-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705144023.1865360-1-sashal@kernel.org>
References: <2026070203-tipping-straw-267a@gregkh>
 <20260705144023.1865360-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:jlayton@kernel.org,m:clm@meta.com,m:chuck.lever@oracle.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272079-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D57DB70A58B

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 2090b05803faab8a9fa62fbff871007862cac1b7 ]

nfsd_vfs_write() and nfsd_commit() both call filemap_check_wb_err() to
detect deferred writeback errors, but neither rotates the server's write
verifier (nn->writeverf) when this check fails. Every other
durable-storage-failure path in these functions calls
commit_reset_write_verifier() before returning an error.

The missing rotation means clients holding UNSTABLE write data under the
current verifier will COMMIT, receive the unchanged verifier back, and
conclude their data is durable — silently dropping data that failed
writeback. This violates the UNSTABLE+COMMIT durability contract
(RFC 1813 §3.3.7, RFC 8881 §18.32).

Add commit_reset_write_verifier() calls at both filemap_check_wb_err()
error sites, matching the pattern used by adjacent error paths in the
same functions. The helper already filters -EAGAIN and -ESTALE
internally, so the calls are unconditionally safe.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 555dbf1a9aac ("nfsd: Replace use of rwsem with errseq_t")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f83b312fe3b4d4..a37137d722c9e7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1201,8 +1201,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
-	if (host_err < 0)
+	if (host_err < 0) {
+		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
+	}
 
 	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
@@ -1344,6 +1346,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 			nfsd_copy_write_verifier(verf, nn);
 			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
 						    since);
+			if (err2 < 0)
+				commit_reset_write_verifier(nn, rqstp, err2);
 			err = nfserrno(err2);
 			break;
 		case -EINVAL:
-- 
2.53.0


