Return-Path: <stable+bounces-129894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B1A80187
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1FF7A5335
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417A264A70;
	Tue,  8 Apr 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="re8sQ7BT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43EB224AEB;
	Tue,  8 Apr 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112261; cv=none; b=Wppu+JfLqiq2GscervYo59yG9I8HNKmsUjwxny7EfwH76NyJlfDVIfv2k7k+eaKLwO5Nqul2OVtaV3KIpq6L1zYNCX+4jXwrVYEm5U+1Nj4BjHEqzCvWCuV1Pjw+n7ypxcfw4jMCjH4TH532rA0azf7whTvoxa+487zkTPs7hZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112261; c=relaxed/simple;
	bh=131sPnFaX7psi/CGU4PDDV/MOf1ZAGz9fNGGm5APxFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYG4SXOTgmfcN0dl6bGWI6Lh3WKGRkrrOSnhoJLXP+xJGngqg56UXG8TZoncPZF8S+iGCAufyDrakf/tL4/6rt1M8+pD7ojCbUwZSTkOerYDiuyWXjlnWHV7uT5HGb9X9UWfG2XMahGeu+Jsw4YXlNPceG8PSrd6lhzh0D+FkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=re8sQ7BT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D91C4CEE5;
	Tue,  8 Apr 2025 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112261;
	bh=131sPnFaX7psi/CGU4PDDV/MOf1ZAGz9fNGGm5APxFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re8sQ7BTRTCE46JDk86us4XK+xanrqOxd9cFJ2eqnFYziem4G1P+Oia6EniZmHxwS
	 misNvVdLz8OTIqOyQoyfVFIphK1UEyBUb/Qk2hrjBVakYQwG1TQ3q7mcVKNVXbYLJC
	 HmgWM4xtgsTKuyicVi95YJtIgSkk/xWrN1Z1Gedw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.14 725/731] nfsd: allow SC_STATUS_FREEABLE when searching via nfs4_lookup_stateid()
Date: Tue,  8 Apr 2025 12:50:22 +0200
Message-ID: <20250408104931.137920511@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

commit d1bc15b147d35b4cb7ca99a9a7d79d41ca342c13 upstream.

The pynfs DELEG8 test fails when run against nfsd. It acquires a
delegation and then lets the lease time out. It then tries to use the
deleg stateid and expects to see NFS4ERR_DELEG_REVOKED, but it gets
bad NFS4ERR_BAD_STATEID instead.

When a delegation is revoked, it's initially marked with
SC_STATUS_REVOKED, or SC_STATUS_ADMIN_REVOKED and later, it's marked
with the SC_STATUS_FREEABLE flag, which denotes that it is waiting for
s FREE_STATEID call.

nfs4_lookup_stateid() accepts a statusmask that includes the status
flags that a found stateid is allowed to have. Currently, that mask
never includes SC_STATUS_FREEABLE, which means that revoked delegations
are (almost) never found.

Add SC_STATUS_FREEABLE to the always-allowed status flags, and remove it
from nfsd4_delegreturn() since it's now always implied.

Fixes: 8dd91e8d31fe ("nfsd: fix race between laundromat and free_stateid")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7051,7 +7051,7 @@ nfsd4_lookup_stateid(struct nfsd4_compou
 		 */
 		statusmask |= SC_STATUS_REVOKED;
 
-	statusmask |= SC_STATUS_ADMIN_REVOKED;
+	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
@@ -7706,9 +7706,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
-	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG,
-				      SC_STATUS_REVOKED | SC_STATUS_FREEABLE,
-				      &s, nn);
+	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);
 	if (status)
 		goto out;
 	dp = delegstateid(s);



