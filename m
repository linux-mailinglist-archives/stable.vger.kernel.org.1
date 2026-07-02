Return-Path: <stable+bounces-270875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vt5gJQqVRmpcZAsAu9opvQ
	(envelope-from <stable+bounces-270875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:42:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECDD6FA6CD
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:42:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=kSgZPZMt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270875-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270875-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0809304D28F
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E9348C71;
	Thu,  2 Jul 2026 16:34:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976834FF78;
	Thu,  2 Jul 2026 16:34:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010078; cv=none; b=nOe3NHm5OKAThIGlgLNq0wlVLq6RwpJ6sbWS1mLiNPoucArH1GiQAB324jjPKn6tOozOe5c3jKYh8OrOGCKdss/IhBlTAnaEgywTaL5Mmb4SOCWyH9SKdDht9R1Bx74X9ay+YPf8/aJQp1cYjMCbl03lvvsW0GfH1uQTqat7XCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010078; c=relaxed/simple;
	bh=ENIjCpKiaIjPklPRh/d+M6UKyA0fmdMfUvlWYkA3lbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWIeczq3VYjadyQTRCbd+/EB9U5a4YzEt+dmF042V1PmntTe+Rdo8O1KvEAJAwnDZqa4nELWrvk+k3KSt86LSOaAlbanSUSbOp6koowMLIY9Fj4Btixvd2wm55X+shMPh4QKxuTThQmZaQUM8RzxTr6pR9VPLey2FCThadgVzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kSgZPZMt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230391F000E9;
	Thu,  2 Jul 2026 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010077;
	bh=HRQ9I04crAn2PEH7hGrMr0nf0hx7HShul0+PhKsMc7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kSgZPZMtHb78cGc7dosHVrmWXCcp565wTgFdMX8R3qEUwlAVNrzLMR8GQoQsm+Y7e
	 9wME28eeCahzdGnbVhdKctQ3g7EjPWRm04+PJPB2yhdyDALm2gUIfJCi6ebdHNINlK
	 UO14VPRWQAMakgPvEIlmngDiR3xdjE03jOV3nB3I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 6.1 100/129] 9p: avoid putting oldfid in p9_client_walk() error path
Date: Thu,  2 Jul 2026 18:20:19 +0200
Message-ID: <20260702155114.214116906@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
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
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn,codewreck.org];
	TAGGED_FROM(0.00)[bounces-270875-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:zhaoyz24@mails.tsinghua.edu.cn,m:asmadeus@codewreck.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tsinghua.edu.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,seu.edu.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,codewreck.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ECDD6FA6CD

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

commit 1a3860d46e3eb47dbd60339783cdad7904486b9f upstream.

When p9_client_walk() is called with clone set to false, fid aliases
oldfid. If the walk subsequently fails after the request has been sent,
the error path jumps to clunk_fid, which currently calls p9_fid_put(fid)
unconditionally.

This drops a reference to oldfid even though ownership of oldfid remains
with the caller. If this is the last reference, oldfid can be clunked and
destroyed while the caller still expects it to be valid. A later use or
put of oldfid can then trigger a use-after-free or refcount underflow.

Fix this by only putting fid in the clunk_fid error path when it does not
alias oldfid, matching the existing guard in the error path below.

This can be triggered when a multi-component walk is split into multiple
p9_client_walk() calls and a later non-cloning walk fails. A reproducer
and refcount warning logs are available on request.

Fixes: b48dbb998d70 ("9p fid refcount: add p9_fid_get/put wrappers")
Cc: stable@vger.kernel.org
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM 5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Message-ID: <20260528053918.53550-1-zhaoyz24@mails.tsinghua.edu.cn>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/9p/client.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1207,7 +1207,8 @@ struct p9_fid *p9_client_walk(struct p9_
 
 clunk_fid:
 	kfree(wqids);
-	p9_fid_put(fid);
+	if (fid != oldfid)
+		p9_fid_put(fid);
 	fid = NULL;
 
 error:



