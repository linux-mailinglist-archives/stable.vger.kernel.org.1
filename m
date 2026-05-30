Return-Path: <stable+bounces-258140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMr1FzgjG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:49:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC78610783
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7FAE3008D5A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C52E06EF;
	Sat, 30 May 2026 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q/ToUOpT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA25346E55;
	Sat, 30 May 2026 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163351; cv=none; b=qe1k+L8FY5Evbgb06673uprnV4opB0c/mG0//AoNi2eocRh2UKWaGoFuxYMNx4o0WTjOqPX34/77unygqcpMmuO9bjrSHcdOM63Z9HpjVEMh9B3ohqRdkmvRbyKfK1Tv/n+/1pNrCh9bnD6hIzx+3S6no2yh3mr3UnL6T7Nyphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163351; c=relaxed/simple;
	bh=M3NetrKi7ubpmgXfH0UDvILM/nk3cPFj0yx9w03JcjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/UvC2axtP6V4EIyG8kzzhvo/3fTLF60+c00LBS1HctIxKAXxch9rxaWqB6RmFEozgq/87A4hcTf+VTxLDbUpvyCIq/A/G5QtcG2RVmYAB4j422nibSBgHibOhoHJkC5rTP8gX0bCtdsCXnUNuAGfL2OQjID4a/ohmZaEJZvI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q/ToUOpT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A7B1F00893;
	Sat, 30 May 2026 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163349;
	bh=cDyMtiELO3UYBh8GMLP+uZXzTMmFocjORpIdGtgfB2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/ToUOpTG/5B4RnyyG2UPaVn+ZXn3YMgDzmnRlwpwfFtCFtFKEBhahYFao8rNHt7i
	 e3EzHKsKZJHwEIdF4cKVVNSGLNopATT/Gh3GRnd9w9tgaN+kv82MWWaj40CBB0PKJF
	 sHUokRP/y7GiWIKqU0r/doPaviaS5hl13T/Brn6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Luxiao Xu <rakukuip@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 201/776] net: strparser: fix skb_head leak in strp_abort_strp()
Date: Sat, 30 May 2026 17:58:35 +0200
Message-ID: <20260530160245.705672679@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-258140-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lzu.edu.cn:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2DC78610783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luxiao Xu <rakukuip@gmail.com>

commit fe72340daaf1af588be88056faf98965f39e6032 upstream.

When the stream parser is aborted, for example after a message assembly timeout,
it can still hold a reference to a partially assembled message in
strp->skb_head.

That skb is not released in strp_abort_strp(), which leaks the partially
assembled message and can be triggered repeatedly to exhaust memory.

Fix this by freeing strp->skb_head and resetting the parser state in the
abort path. Leave strp_stop() unchanged so final cleanup still happens in
strp_done() after the work and timer have been synchronized.

Fixes: 43a0c6751a32 ("strparser: Stream parser for messages")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/ade3857a9404999ce9a1c27ec523efc896072678.1775482694.git.rakukuip@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -45,6 +45,14 @@ static void strp_abort_strp(struct strpa
 
 	strp->stopped = 1;
 
+	if (strp->skb_head) {
+		kfree_skb(strp->skb_head);
+		strp->skb_head = NULL;
+	}
+
+	strp->skb_nextp = NULL;
+	strp->need_bytes = 0;
+
 	if (strp->sk) {
 		struct sock *sk = strp->sk;
 



