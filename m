Return-Path: <stable+bounces-236308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB0JMQIZ3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF2F3EEE14
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF3C3309B1F8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC73043BE;
	Mon, 13 Apr 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z37zpEA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A93033F7;
	Mon, 13 Apr 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096573; cv=none; b=IfOQBwHXWM+2Tm0HhmjUW7QdoPhP9F1U/7Q7nhsi5JpMkSvpjcTwAjxfyKpu3qqxeXqZgZFdwFjYVrVZTg+b2M71OxLtEbDwPsg7AZYp3YpP0xvrt/8ZeXy3QCqfe+wg4buJ8dDnTypDYYDgtBIIXl1NONm5ByENOgeMSd/augk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096573; c=relaxed/simple;
	bh=SPg/ZU3QwT7Lcc0ENZ4EbtZNMAw3n0nBOxVmqMVIqto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYTujHYKhXWxMg7NdtMe+fEDIoLnoSxc++t5vW7IxadwzrUPmKMQY7eqstHGZxJ+vSLy2J+MvUjjJ6Kz/Ks2s7xKEumZVVUMZlYJq3m0a14P3SrwyPGrXnZ6TyXNBbjb5brHm4bDHG04P8GWA+ugdYgEH/m8e5663JDikbrSjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z37zpEA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91FDC2BCAF;
	Mon, 13 Apr 2026 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096573;
	bh=SPg/ZU3QwT7Lcc0ENZ4EbtZNMAw3n0nBOxVmqMVIqto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z37zpEA03CdX3jPo80oOvfNj5yd0IN8yQN94Cmkv7S9CIHlg+oFQcAi0L88J8++pL
	 wWR/+CQ2w9XtScrlATL0plPnnfNBBvW6hjeJAHEXDCIQr+bZuIJTFOuXWgj2KP4DOH
	 HpKBY/tZy3ZWEww3mkRQnroBjXGCkSmtcwvIdrGA=
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
Subject: [PATCH 6.18 63/83] rxrpc: Fix key parsing memleak
Date: Mon, 13 Apr 2026 18:00:31 +0200
Message-ID: <20260413155733.360775849@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236308-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,infradead.org:email]
X-Rspamd-Queue-Id: 3BF2F3EEE14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit b555912b9b21075e8298015f888ffe3ff60b1a97 upstream.

In rxrpc_preparse_xdr_yfs_rxgk(), the memory attached to token->rxgk can be
leaked in a few error paths after it's allocated.

Fix this by freeing it in the "reject_token:" case.

Fixes: 0ca100ff4df6 ("rxrpc: Add YFS RxGK (GSSAPI) security class")
Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-3-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/key.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -274,6 +274,7 @@ nomem_token:
 nomem:
 	return -ENOMEM;
 reject_token:
+	kfree(token->rxgk);
 	kfree(token);
 reject:
 	return -EKEYREJECTED;



