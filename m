Return-Path: <stable+bounces-236237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ElrFmQW3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:14:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D87333EE7CE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49132303B5FA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39478271443;
	Mon, 13 Apr 2026 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xhiKTNTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F106425332E;
	Mon, 13 Apr 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096396; cv=none; b=FkLj4ifyxYQyOEKcxA6EoxHZXUP1G5rq+XNAs6/iJnP5O8darBysSHIrcIcnOFSvntQIK4TJ2SIHD24ljOPkidwC0fxXnmbGCA7Crc0NypUPjPKK6YIZw/jBwcd3utN8P0P3Q51IWxuLYnprE5liF/CFKA0aEPAJV2Y+Mp0MV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096396; c=relaxed/simple;
	bh=r3giP86m/T+JpKKl9Uu/nylHpi+5KoRv7jKa/6Wav3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVKxtSh7+yIrLY5Dp5PPx3/Runfkg2Hkc8C6DaQqFym6ebZgIcJly5IF+Tl5lxZ6tGu4C8FGI0MBpB85tpEy9UsDA20jAdpemkrU0fqOxnS6JJbx1Nj2N/dfrPFEkRpuoEP/DEhxPwlF1zaoIGQPA9IVSyo5KtkqL4ztY6a37AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xhiKTNTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F776C2BCAF;
	Mon, 13 Apr 2026 16:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096395;
	bh=r3giP86m/T+JpKKl9Uu/nylHpi+5KoRv7jKa/6Wav3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xhiKTNTvVab9gUD4xrVDllt5ktXlnJjBPusPrlZeV/kDwjOtiRqs3nxso1MIXE20w
	 qOdjf3+cGQKDwCwSJHpXI+MqQ1zcRVRC4l//kNqd9ltTtkJphXQD4+h8wMHmBlr60t
	 1jnW/9CXMZMHcQGbZCbuB0rq/9ZEyIRgMoq13tnY=
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
Subject: [PATCH 6.19 82/86] rxrpc: Fix leak of rxgk context in rxgk_verify_response()
Date: Mon, 13 Apr 2026 18:00:29 +0200
Message-ID: <20260413155734.598192289@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236237-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,auristor.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D87333EE7CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 7e1876caa8363056f58a21d3b31b82c2daf7e608 upstream.

Fix rxgk_verify_response() to clean up the rxgk context it creates.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Closes: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-19-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxgk.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1270,16 +1270,18 @@ static int rxgk_verify_response(struct r
 	if (ret < 0) {
 		rxrpc_abort_conn(conn, skb, RXGK_SEALEDINCON, ret,
 				 rxgk_abort_resp_auth_dec);
-		goto out;
+		goto out_gk;
 	}
 
 	ret = rxgk_verify_authenticator(conn, krb5, skb, auth_offset, auth_len);
 	if (ret < 0)
-		goto out;
+		goto out_gk;
 
 	conn->key = key;
 	key = NULL;
 	ret = 0;
+out_gk:
+	rxgk_put(gk);
 out:
 	key_put(key);
 	_leave(" = %d", ret);



