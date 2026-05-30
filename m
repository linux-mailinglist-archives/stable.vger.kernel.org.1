Return-Path: <stable+bounces-259169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOPyKrowG2p5AAkAu9opvQ
	(envelope-from <stable+bounces-259169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:47:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D46127FB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF1193014266
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABFF18FDBD;
	Sat, 30 May 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NUY9bJpT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26317137750;
	Sat, 30 May 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166838; cv=none; b=oqpXIj4o8KQxlphlrrPSW5OZNMrnRozJKT4qkUGIVVT2OfKin94TUlmPV64mQ1gpK68Ycygo0UV2QSlQH/jvWwWv98UiYRZwqa/x99eacAbEcVC9xGREZBk0D5Uco2tK//DX6zKQSZUeA8T2qEZQIjfGq0CQ8teB8QwT8AZcs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166838; c=relaxed/simple;
	bh=+K2Ev/ZdGMMQxJk9Jju89/9Em6DOqU7oU8GHZc8m494=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ42xDOQdWwPjOUH/B5Lw/2UF6SZPtwMESVmcXEIfs2tgvG3hVDwUllgxw7S85XBI94/mrFxzAHDnDRu5rBcTgTbk8avpSO0pi3KxRHu5n1nJXMgyACGPOvC/zq4c3G3I9nccVv91DUnRMdUY6x2v29jCKJ/sAdWBCQ8Z0Y3o5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NUY9bJpT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5601F00893;
	Sat, 30 May 2026 18:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166837;
	bh=H+0Eoi1Cp77ala1c1vr2RAk8/nt7HNjJU8K01dlZel8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NUY9bJpTORC84iJLUyCSmbS9H4RnmBUdZYLLAyjQdDjruFAwtSSdRqhj0XkLhqaF8
	 A1RmE5lyBFaofjxQ3X7q2aI37ZfhAB7NxPUKzNt6H64JyH1XCqXayKyONsjFj22JU5
	 4uOZrv2bmxa67acXbKzy3lB/2Dkl67Jm7RJiHUUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 487/589] sctp: discard stale INIT after handshake completion
Date: Sat, 30 May 2026 18:06:08 +0200
Message-ID: <20260530160237.439331648@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-259169-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8A3D46127FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 8a92cb475ca90d84db769e4d4383e631ace0d6e5 ]

After an association reaches ESTABLISHED, the peer’s init_tag is already
known from the handshake. Any subsequent INIT with the same init_tag is
not a valid restart, but a delayed or duplicate INIT.

Drop such INIT chunks in sctp_sf_do_unexpected_init() instead of
processing them as new association attempts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Link: https://patch.msgid.link/5788c76c1ee122a3ed00189e88dcf9df1fba226c.1777214801.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_statefuns.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index c91f712ce1fab..af75b94085568 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1508,6 +1508,12 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	/* Tag the variable length parameters.  */
 	chunk->param_hdr.v = skb_pull(chunk->skb, sizeof(struct sctp_inithdr));
 
+	if (asoc->state >= SCTP_STATE_ESTABLISHED) {
+		/* Discard INIT matching peer vtag after handshake completion (stale INIT). */
+		if (ntohl(chunk->subh.init_hdr->init_tag) == asoc->peer.i.init_tag)
+			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+	}
+
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
 	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
-- 
2.53.0




