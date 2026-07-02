Return-Path: <stable+bounces-271509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vH9iAGabRmoDaAsAu9opvQ
	(envelope-from <stable+bounces-271509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:09:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF206FB119
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:09:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="1zid8M6/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271509-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271509-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EAA0311A790
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC915335066;
	Thu,  2 Jul 2026 17:02:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9821FA859;
	Thu,  2 Jul 2026 17:02:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011728; cv=none; b=Z4ZdijsIJs2fm4gmkZCJov7/IfH1RleNT/nP93kzlg5skJ+NM0DuWsLMABfTdWW9CdW7s2n3UzVj2IfOIN6kHFA4TDMKPXuxiXUzxlJRfy4KTxz5ZoNR2fE/oQOAV/vsnjxO9HFRDY2Zj5xRMTfuJ6ESY6bOSHZqHiCCRzYw88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011728; c=relaxed/simple;
	bh=UWuztENTqo0qNEAjWItcYJ7qU2MlyJBpjf4aN6Z3WHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKDUVYVPSJDdul0Dv8edDf+3XGvoKM4VZECJMSnx4gzd+SBlM6iW+EQ/KaFwVoIkdFB/D1QFWUgMNTggDpmV+ffZ94EgxJ7fngekJXiZLL/BBpKM6b3KjajCSu9pJDrBho+QV6vdkJSO1qAY1vF50DaJSBy7ox83BreijEPTjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1zid8M6/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1018B1F000E9;
	Thu,  2 Jul 2026 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011727;
	bh=TdeDthDTBwZhiE9LgAJRfu+8Dk5DO546n0eh3HAyUgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1zid8M6/VJ+8dBlS9oghP0zj4CKRcUMCycG6oLrzHyswCWIgDSctpBFu6G08YxUad
	 ag5RDgPImfMofxKq9Ih9y2cZw32UMo8J4en01T1EjSFsfi0x690spSqJThICM0Qbyv
	 hdesdyHVB2mNEHaENLKOnV38wpka3ppAjOIYNuuA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 7.1 111/120] nfsd: fix dead ACL conflict guard in nfsd4_create
Date: Thu,  2 Jul 2026 18:21:47 +0200
Message-ID: <20260702155115.256779779@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271509-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:clm@meta.com,m:jlayton@kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FF206FB119

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

commit a60f25a800846ab8e5a13f8a9d05111f2aee55a7 upstream.

nfsd4_create() steals create->cr_dpacl/cr_pacl into the local
nfsd_attrs via the designated initializer, then immediately sets the
source pointers to NULL. The subsequent conflict guard tests the
already-nilled source fields, making it permanently dead code:

    if (create->cr_acl) {
        if (create->cr_dpacl || create->cr_pacl)  /* always false */

When a client encodes both FATTR4_WORD0_ACL and
FATTR4_WORD2_POSIX_{DEFAULT,ACCESS}_ACL in the same CREATE fattr
bitmap, nfsd4_acl_to_attr() overwrites attrs.na_pacl/na_dpacl without
releasing the originals, leaking two posix_acl slab objects per
request. Repeated requests cause unbounded slab exhaustion.

Fix by checking attrs.na_dpacl/na_pacl (the stolen values) instead of
the nilled create->cr_dpacl/cr_pacl, matching the correct pattern
already used in nfsd4_setattr().

Reported-by: Chris Mason <clm@meta.com>
Assisted-by: kres:claude-opus-4-6
Fixes: d2ca50606f5f ("NFSD: Add support for POSIX draft ACLs for file creation")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -840,7 +840,7 @@ nfsd4_create(struct svc_rqst *rqstp, str
 		goto out_aftermask;
 
 	if (create->cr_acl) {
-		if (create->cr_dpacl || create->cr_pacl) {
+		if (attrs.na_dpacl || attrs.na_pacl) {
 			status = nfserr_inval;
 			goto out_aftermask;
 		}



