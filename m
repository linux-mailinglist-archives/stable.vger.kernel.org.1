Return-Path: <stable+bounces-243342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELWZKBip+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 750BB4BEBBA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12059301064D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D338F3DE45B;
	Mon,  4 May 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nRGLvTLT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD83DE43F;
	Mon,  4 May 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903639; cv=none; b=QQ0grnCyRzYWK+P78ltysffFnZfbKCCMaJ8OMTQ+4DwdihyWR4mRalbnrhoQu9p39CdveHdhdyA0XbEZgze5tVZFDExlsQUMw+fYWUhpNAqjsMlMPCF7has8vyTReyDpJYLIB6mZv1QIyVv+T3mMNJNn5+MfJTnlq+GmAcZEswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903639; c=relaxed/simple;
	bh=HWegSQt77CbCFkE/XFRumkKPkXTaJcGDn7ZMBURBFng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7M4q20/TDL06fX2MTAKY01vmzF5oVHRMkmT2iJT9ruPTGq0pyXvjD6Wtw4VuIJoFuuR10OgtRG0KBbRU6ZBfoMMDiE9zIVRRUZsTE0L+ud775cdViR0GglBCATWxVKWXv/YvEC7NAfwXp+Oxbr/q+fpo3R65fCH8BQ+XM3/goY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nRGLvTLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C883C2BCB8;
	Mon,  4 May 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903639;
	bh=HWegSQt77CbCFkE/XFRumkKPkXTaJcGDn7ZMBURBFng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRGLvTLTg+OlhNZ/Is+ARdF6cEFTWe1EoFzxGP5PxnTCJ/O/KlqaSL6bH5s3whxMp
	 +GqURDxRlF326GaZkDUkYfdgE3CJFzTLcgm8p2sbCaFQ04XX5x4mzGZ97wkdl/x/mW
	 AfeLKmpnZzTHr5yEac+UycTCrFtUGVLUOQbBJU24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 281/307] rxgk: Fix potential integer overflow in length check
Date: Mon,  4 May 2026 15:52:46 +0200
Message-ID: <20260504135153.364123460@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 750BB4BEBBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243342-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,auristor.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 6929350080f4da292d111a3b33e53138fee51cec upstream.

Fix potential integer overflow in rxgk_extract_token() when checking the
length of the ticket.  Rather than rounding up the value to be tested
(which might overflow), round down the size of the available data.

Fixes: 2429a1976481 ("rxrpc: Fix untrusted unsigned subtract")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260422161438.2593376-6-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxgk_app.c    |    2 +-
 net/rxrpc/rxgk_common.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -214,7 +214,7 @@ int rxgk_extract_token(struct rxrpc_conn
 	ticket_len	= ntohl(container.token_len);
 	ticket_offset	= token_offset + sizeof(container);
 
-	if (xdr_round_up(ticket_len) > token_len - sizeof(container))
+	if (ticket_len > xdr_round_down(token_len - sizeof(container)))
 		goto short_packet;
 
 	_debug("KVNO %u", kvno);
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -34,6 +34,7 @@ struct rxgk_context {
 };
 
 #define xdr_round_up(x) (round_up((x), sizeof(__be32)))
+#define xdr_round_down(x) (round_down((x), sizeof(__be32)))
 #define xdr_object_len(x) (4 + xdr_round_up(x))
 
 /*



