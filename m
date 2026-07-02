Return-Path: <stable+bounces-271276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gJ0DNnOlRmq4awsAu9opvQ
	(envelope-from <stable+bounces-271276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:52:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D37206FBAEB
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:52:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="eM/PYik1";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271276-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271276-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D773632D757C
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBBC353A8D;
	Thu,  2 Jul 2026 16:52:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6E3446A7;
	Thu,  2 Jul 2026 16:52:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011124; cv=none; b=Tf533QFSPZ37/6Sx9h8EFNXpYkIktw1Nker3hMihLmOH8BBalc3j3ptlBSokXtxTyeD4VzyJTTCWzClDZ+ItXnA3tXVScK5DCeNAk0M5UPyERriyWNkmiv8phpGk8SzzwbM8lKnIMxSunH4YRZGNKSIdkCbbd1TqEDqUawPj5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011124; c=relaxed/simple;
	bh=zZu2GNK+e8k/iSPwRIeE5wUOhWULAJ9s7Kmit8bKplM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zgo6IxqTLHQ69lXMTKCu7HRpmoAeiAoEFyQ9+zgtodZfIicRT+lRS7yDk1rGDIRGuXrYRbVNJRr5vE3AaBBlH8kmp+E9A7Oe7vVGxLbWWFQyDzSgD+11GdW/9cnAnPwvWfdeyUFzp5G32bxgCZsbXhW1iNFD+pA0sSrtDT691rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eM/PYik1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0951F000E9;
	Thu,  2 Jul 2026 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011123;
	bh=/MaRaMAndue6PuVL6ykvt84XF/AFb8WV1pQ5MIT7umw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eM/PYik1GnRjmnDxbdS+lZWn+aXp5RQFxTquTlkn5qYo3xn8Kir98ziB3GeND5G2A
	 elvu7r73vJmCQ3PM19Yp8trMNRI6G+TJbwFz3UqwsoZilZhKthVxaUv8EBvSMrBNZz
	 69SQKIU7lj4mdO+7xrEb4lwiVG3JzCMl1RsxruFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Dominik=20Wo=C5=BAniak?= <stalion@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 165/175] nfsd: check get_user() return when reading princhashlen
Date: Thu,  2 Jul 2026 18:21:06 +0200
Message-ID: <20260702155119.265392683@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271276-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stalion@gmail.com,m:jlayton@kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,oracle.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,princhash.data:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,oracle.com:email,name.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D37206FBAEB

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Woźniak <stalion@gmail.com>

commit e186fa1c057f5eccb22afb1e83e34c0627085868 upstream.

In __cld_pipe_inprogress_downcall(), the get_user() that reads
princhashlen from the userspace cld_msg_v2 buffer does not check its
return value. A failing copy leaves princhashlen with uninitialised
stack contents, which are then used to drive memdup_user() and stored
as princhash.len on the resulting reclaim record. The other get_user()
calls in this function all check the return; only this one is missed,
which is most likely a copy-paste oversight from when v2 upcalls were
introduced.

Mirror the existing pattern used a few lines above for namelen.
namecopy is declared with __free(kfree) so the early return cleans up
the already-allocated buffer automatically.

Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Woźniak <stalion@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4recover.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -815,7 +815,8 @@ __cld_pipe_inprogress_downcall(const str
 			if (IS_ERR(name.data))
 				return PTR_ERR(name.data);
 			name.len = namelen;
-			get_user(princhashlen, &ci->cc_princhash.cp_len);
+			if (get_user(princhashlen, &ci->cc_princhash.cp_len))
+				return -EFAULT;
 			if (princhashlen > 0) {
 				princhash.data = memdup_user(
 						&ci->cc_princhash.cp_data,



