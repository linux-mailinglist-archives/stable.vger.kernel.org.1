Return-Path: <stable+bounces-256124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAj3LK6pGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:46:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767A5F9852
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69A3230D2667
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61E52139C9;
	Thu, 28 May 2026 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mRs6jknf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2F25F7B9;
	Thu, 28 May 2026 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000823; cv=none; b=TRQMTA9zWRJuZZpuNYqZuoyVDlvHSxPfjTKEa+icdTXHDIf5GGjHJ9R8h81l8aLr8Art1AlYsGtAILB+IoQq+Srcy7Xgr8RZFhXdddtG1ejHK+SBIJKHhUz8SkxKQG68Mdu0t0BE5lm7UcbFwDcvFTWwz0He/vFT5T3sVTZYsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000823; c=relaxed/simple;
	bh=oRdy5y1V8tp10vp6+HxPBdexrB+Mr4594gcCNnBEDO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg/nQYfhd2MqTNLimfkVRVoo3A2y03PnY0e/ZCb9ro3x4KjKBkthG8AYQM1C6r4KgEa30UQPKS+kPgzT6/tEoMzgqjNzG4C2IR1rViaSkw6bfqXMgpjr8vPjHx2jRamcE4/suRfTNlY14FO5xHUibgKbIVQS30hHfZj50RXUT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mRs6jknf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A691F000E9;
	Thu, 28 May 2026 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000822;
	bh=AB9unhkrxcOF51KWsUSFOiZf9I7u3gXTiaeL5gzmm+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRs6jknfz8kOcPi9HIu4oazLpccoxI7vD64mm9ezS3e2Mxh/XvYXfwe8STxIl3UcL
	 vNT5rpow1+niIFW8O1YVP1TjuaOuCIfTmAyRA1/SyIs/TE1JkjYGb6eUURduZ0ZFEa
	 XDhruNBqAV7rO9d6m5uWhctG3UDWYiJaQzIs1kUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 182/272] NFSD: Fix infinite loop in layout state revocation
Date: Thu, 28 May 2026 21:49:16 +0200
Message-ID: <20260528194634.389290102@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256124-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email]
X-Rspamd-Queue-Id: 3767A5F9852
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4f8ef58c10bfe5f86a643c7c8331b37e69e3dae1 ]

find_one_sb_stid() skips stids whose sc_status is non-zero, but the
SC_TYPE_LAYOUT case in nfsd4_revoke_states() never sets sc_status
before calling nfsd4_close_layout(). The retry loop therefore finds
the same layout stid on every iteration, hanging the revoker
indefinitely.

Fixes: 1e33e1414bec ("nfsd: allow layout state to be admin-revoked.")
Reported-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1a15e458b178a..2d91747297820 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1832,6 +1832,13 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 					break;
 				case SC_TYPE_LAYOUT:
 					ls = layoutstateid(stid);
+					spin_lock(&clp->cl_lock);
+					if (stid->sc_status == 0) {
+						stid->sc_status |=
+							SC_STATUS_ADMIN_REVOKED;
+						atomic_inc(&clp->cl_admin_revoked);
+					}
+					spin_unlock(&clp->cl_lock);
 					nfsd4_close_layout(ls);
 					break;
 				}
-- 
2.53.0




