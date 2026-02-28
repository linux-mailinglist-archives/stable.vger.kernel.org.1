Return-Path: <stable+bounces-220772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIUQK6FDo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:36:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B01C72AE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC2023173DF7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED92408E48;
	Sat, 28 Feb 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNCp+/kG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581B408E41;
	Sat, 28 Feb 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300651; cv=none; b=cO0fsos/W8pXIzOywcpoNjrVjrimYw6QV1xF+GMX/6KhKvbcT8EnJofAIW+OAx0ltdYH/Eo99aM/mora+fwNvAn0h+ITfUUVGMkMD7TRhyuaS3vU5PsKyIWdydPT5vP1l9/+Qpx+SpMDGrDS8z4ikRuN+gc+TkC14lgqQ+xuctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300651; c=relaxed/simple;
	bh=TU8tjJbpGgqdlyzIOimmAedpFUlDG+LzupMVudAj6h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgV68BqnjYq15L/D4MchWgsLu2mFP6+s2GvAedZOIumTW4+ZL4ukCEIRCPvxGA+atewK4G7XhZ/QB7kg74yxmDRe5IcvkYVnG/ns2n628N874MEVxoxKfmYfSgEqfXFWC73dZ9+Q87i7B99SlZrtRf+twOVP/akbe7nHmPlsfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNCp+/kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1974AC19423;
	Sat, 28 Feb 2026 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300651;
	bh=TU8tjJbpGgqdlyzIOimmAedpFUlDG+LzupMVudAj6h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNCp+/kGw77R9RWPgVh8qvvUdHbp/Sja2SNt4CvnfP6TFTu9vnnwarZrqe7+eRvvu
	 +K7JstDbzK7uelfQeTAheTDZ+6qFR4IGqRm0h2PXiC/meuPHY/dp5TGXEoFDM1Fb3B
	 pmIVJFYw4N/8cEwQiaFhSzHBC+3BRakXW2+63gpOrGRHkBKfQpuumlg+GmrTRSlx9W
	 DIcW3GkL5juz7+vXwYiUPZbKtYBu4DqzKFEl8eyYUVO7u3m5DJuL0RLHfP4Dg8ZOuP
	 DN3yBLfWdq+js4xAcEExD7Z1V7uzo/BycL+lRRlhQhRW28bAO+ZswGf/CBv9fSEuzi
	 rop5JyPO72WQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 693/844] nfsd: fix nfs4_file refcount leak in nfsd_get_dir_deleg()
Date: Sat, 28 Feb 2026 12:30:06 -0500
Message-ID: <20260228173244.1509663-694-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220772-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email,oracle.com:email]
X-Rspamd-Queue-Id: 563B01C72AE
X-Rspamd-Action: no action

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 789477b849394afdb60507924d65f7ef18f078ce ]

Claude pointed out that there is a nfs4_file refcount leak in
nfsd_get_dir_deleg(). Ensure that the reference to "fp" is released
before returning.

Fixes: 8b99f6a8c116 ("nfsd: wire up GET_DIR_DELEGATION handling")
Cc: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5e0f3a52d4f0..45d486466cdc3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9520,8 +9520,10 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	spin_unlock(&clp->cl_lock);
 	spin_unlock(&state_lock);
 
-	if (!status)
+	if (!status) {
+		put_nfs4_file(fp);
 		return dp;
+	}
 
 	/* Something failed. Drop the lease and clean up the stid */
 	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
@@ -9529,5 +9531,6 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	nfs4_put_stid(&dp->dl_stid);
 out_delegees:
 	put_deleg_file(fp);
+	put_nfs4_file(fp);
 	return ERR_PTR(status);
 }
-- 
2.51.0


