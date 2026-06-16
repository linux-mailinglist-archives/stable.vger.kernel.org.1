Return-Path: <stable+bounces-264257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y7CuNlZ1MWpZjwUAu9opvQ
	(envelope-from <stable+bounces-264257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:09:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 195FE691C0F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jINOvFYk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264257-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264257-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 986C930652BD
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B564743E9CE;
	Tue, 16 Jun 2026 15:49:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62A43D4F7;
	Tue, 16 Jun 2026 15:49:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624985; cv=none; b=Fb+SST6C685ZApB2S8iFF0drc9mlpoLBcvydFT71qmJN/C+C7j++QXy2TFin4mJeXQV1mqagMtsB72PM59okSkt+DowGE6DWRj1dUsk743f7TUBmpedBPO9OZLOIVeSovNm2KjbPYtxAie2G4ZIlfN1gOEYBsyWrwrrvxEHUr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624985; c=relaxed/simple;
	bh=HEkO+znMDTQbgmvzIYoKg2IlT/vSKydwVE6DIey7khw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzNHqurg4p0R0M5zXN2pujSLPBgH4MWcwO5I1zCcC4isddNQ2wJ+v5koMU5j3iE82apfEta8oan+cvI9OJtxJ6PLTucUjzwAvwsb8GsgrUfHcjDJ6l2mdxEukdt2dI0WHHZtGW7TlwG/8YSbfgrUB7CZkkASA+2GdqWUp6mtiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jINOvFYk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660561F000E9;
	Tue, 16 Jun 2026 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624984;
	bh=P0h2VJSQ2mLjkVrrdQUgKoTyxHATr5V1cb88V+sEfZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jINOvFYky9wZwAaeoqlIwstBBG7bliZf63QTYDawzaABz3iJKGFGO7PP8acgtqgax
	 s6nwyTBTqytb3KSGnQ0EiVlF5fZEmb5Mz9MgAfxNUxkItX+/GSre9jguGrRl/QrUAr
	 2wu9JClfieHFTAMhBU7ZhUC+ktkXKE8VLg+pTWCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Geffon <bgeffon@google.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 061/325] sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
Date: Tue, 16 Jun 2026 20:27:37 +0530
Message-ID: <20260616145100.732151071@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264257-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bgeffon@google.com,m:lucien.xin@gmail.com,m:kuba@kernel.org,m:sashal@kernel.org,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 195FE691C0F

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 0861615c28de668669d748ef4eb913ea9262d13b ]

When a listening SCTP server processes a COOKIE_ECHO chunk, the cached
peer INIT chunk embedded after the cookie is parsed and its parameters
are later walked by sctp_process_init() using sctp_walk_params().

However, the chunk header length of this cached INIT chunk was not
validated against the remaining buffer in the COOKIE_ECHO payload. If
the length field is inflated, the parameter walk can run beyond the
actual received data, leading to out-of-bounds reads and potential
memory corruption during later parameter handling (e.g. STATE_COOKIE
processing and kmemdup() copies).

Add a bounds check in sctp_unpack_cookie() to ensure the cached INIT
chunk length does not exceed the available data in the COOKIE_ECHO
buffer before it is used.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_make_chunk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 2c0017d058d409..9014b095f52ddb 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1730,6 +1730,7 @@ struct sctp_association *sctp_unpack_cookie(
 	struct sctp_signed_cookie *cookie;
 	struct sk_buff *skb = chunk->skb;
 	struct sctp_cookie *bear_cookie;
+	struct sctp_chunkhdr *ch;
 	enum sctp_scope scope;
 	unsigned int len;
 	ktime_t kt;
@@ -1759,6 +1760,10 @@ struct sctp_association *sctp_unpack_cookie(
 	cookie = chunk->subh.cookie_hdr;
 	bear_cookie = &cookie->c;
 
+	ch = (struct sctp_chunkhdr *)(bear_cookie + 1);
+	if (ntohs(ch->length) > len - fixed_size)
+		goto malformed;
+
 	/* Verify the cookie's MAC, if cookie authentication is enabled. */
 	if (sctp_sk(ep->base.sk)->cookie_auth_enable) {
 		u8 mac[SHA256_DIGEST_SIZE];
-- 
2.53.0




