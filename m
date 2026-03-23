Return-Path: <stable+bounces-228619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLDtFsZMwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB72F4544
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A8343023D91
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74DB39A055;
	Mon, 23 Mar 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="blgretnI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CA1D63F3;
	Mon, 23 Mar 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275622; cv=none; b=Yqvo1bbparQ7ygdgS6CEcT0LNfksp57DNOz+wr9rXzumlVfMAieGiZox/ih02h83lDYX8vqL0HgXmZTP4bJamr0+EyYlSMF6Xu0eez4yykdGs4KmtEdWyqnQbvAQLK7vL2J1A3d60MuHhll2u0LxQFs8IjHSWA7Bb8+qKwb0ZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275622; c=relaxed/simple;
	bh=+6KUUtlb5f8pAA7MEJEga7rX3pz4eS2cfMBT4jFWknE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQJzn3YnkRceIqkG9Bk0nbpN8CUItedL16ufZWklpf8DLSzGYOy/hA3OBldUM+2NsYIRO3To2IQaZgT//iT3ZV2OyFVi0TxK2kzb1i8dHO3EMEum5QyltTrb41kJ8ahwE+oWYQx4B5lxPsOdbp2Vickecp+2rBaSnotLQ1KFNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=blgretnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DB7C2BCB1;
	Mon, 23 Mar 2026 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275622;
	bh=+6KUUtlb5f8pAA7MEJEga7rX3pz4eS2cfMBT4jFWknE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blgretnIToSc+/8B78Tc4OKshDxXEOwUOOJtFmoaFgCvZ1DHTdZgBr/h0TMColqaY
	 96fERg7BwPFu0ZHs1O4LiqybaBUHJSDzwBEEx1RB6zqkiK7WENxywQfuWC2Bvl9c/o
	 clr/nonS7spBJUqI/+dJNbU5/OGxUxT9+FC8LAtA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.12 146/460] nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
Date: Mon, 23 Mar 2026 14:42:22 +0100
Message-ID: <20260323134530.171524629@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228619-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,oracle.com:email]
X-Rspamd-Queue-Id: 8FBB72F4544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2081,7 +2081,7 @@ int nfsd_nl_listener_set_doit(struct sk_
 		}
 
 		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, 0,
-					      get_current_cred());
+					      current_cred());
 		/* always save the latest error */
 		if (ret < 0)
 			err = ret;



