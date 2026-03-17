Return-Path: <stable+bounces-226395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDdYLV6KuWkjJwIAu9opvQ
	(envelope-from <stable+bounces-226395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:07:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8EC2AEFD1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F2A31E888E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D223F23AA;
	Tue, 17 Mar 2026 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hpz/0hu5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D25330B15;
	Tue, 17 Mar 2026 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766513; cv=none; b=KfWBrOF1y0RBdachb9NHvsEvKYcCuVB4nu5DWZhOARerE7hcbMFUDZ8CytHwFmvs4QdGi3WyjurqExMEaQZ/pWATse5FrQ75B4Q6wSd/9XrSRiNf3bnAGVdTpdcRsyfFOjqbBRS+e9ANaHtHKrJcvg0cD4KnZO+UflqZ4PbJICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766513; c=relaxed/simple;
	bh=9tuHPcC4TBxNj7xx8Xta4tdPJpzULewWUle8On0Y0Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj+pMM2qy/WkwdnFjgmAP9c1j4dvD+nhBZJJGx40CGWSz6bpwGph9aSCREZrUeCicU1yea6mBTF5KqljxWx8NhVpyVMz3jMyM9FL+1sYgupCY4D+VryLRxhchaqnGmSUtK8gTILamnVDvEu0ZUr6FIiFnbXTHBJRYWsO+BmwbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hpz/0hu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A792C4CEF7;
	Tue, 17 Mar 2026 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766513;
	bh=9tuHPcC4TBxNj7xx8Xta4tdPJpzULewWUle8On0Y0Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpz/0hu5sEY+H7decIAk8G+CWDHM3rrB/N6SfjKxKjfhLnSevSVQaFHgmz2fRrwxD
	 saFLC8yLXG2278Gbv9MQ+4n6FE2RHAc+b0fKB+jPFTJWcH0vCzDp12r1+dMuCYCJk9
	 tSKbypZpaWeN3m/5jocz1p3jhhmicxhd6VXpKpxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.19 235/378] nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
Date: Tue, 17 Mar 2026 17:33:12 +0100
Message-ID: <20260317163015.659364774@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226395-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 3D8EC2AEFD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

commit 92978c83bb4eef55d02a6c990c01c423131eefa7 upstream.

nfsd_nl_listener_set_doit() uses get_current_cred() without
put_cred().

As we can see from other callers, svc_xprt_create_from_sa()
does not require the extra refcount.

nfsd_nl_listener_set_doit() is always in the process context,
sendmsg(), and current->cred does not go away.

Let's use current_cred() in nfsd_nl_listener_set_doit().

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Cc: stable@vger.kernel.org
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfsctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1993,7 +1993,7 @@ int nfsd_nl_listener_set_doit(struct sk_
 		}
 
 		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, 0,
-					      get_current_cred());
+					      current_cred());
 		/* always save the latest error */
 		if (ret < 0)
 			err = ret;



