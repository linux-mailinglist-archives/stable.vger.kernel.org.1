Return-Path: <stable+bounces-246293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLiYNAltA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:10:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 581F4526F13
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EF4831C123B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AF34D90D;
	Tue, 12 May 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P3c33DgO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8E3EDE4A;
	Tue, 12 May 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608853; cv=none; b=saCV+j/sqNwaWTURgVyWKPNJGAnivQsst8NeV7dK2vonF7NB/YX7tbHHn5rDX+8E3f8kZfjbekb1cpqxFgPu32Z/BpV3DOQ7TSrY9tg+1R4nrmXKxeP8VwH9ysSkw5sfNJCOHr+UjWWdTEW3iIyXEmOufyRnnfNu6YLQIK/Y2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608853; c=relaxed/simple;
	bh=i4vMjvCu7wUNmy1FVJvm21H5QnBX1c2fWGuLUBGoXk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K98cIO7K3wImmIF5pMHdL4mZh1e/32wQdvO5jTW0xbUWPTGQuzq7YgBywIuFHPOP6T9sylSN73IY+ZclN5Z0eez8oInylfqGSne0+w8bs4iS91+eKV7PgXqyPeCeKutcLb6Ji1Evg42qeQEilWRANtO/0R6udfyvmlddxEB2Gsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P3c33DgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5B8C2BCB0;
	Tue, 12 May 2026 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608853;
	bh=i4vMjvCu7wUNmy1FVJvm21H5QnBX1c2fWGuLUBGoXk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3c33DgO+PF5bOJRnKS3vDn+5MD+3vmopemyJpyUPm1ljcch+19fkbi8PHJ0e5Zp6
	 A1JfVntKTY1noXjrQPLSDam86gN6lgGWMNXDQMRHK0l4J/7IiVZFjMk0g2n+/tFo60
	 6B2m6k8baLGC7vceVYbecEHQ4VUpejO9bCdgroME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 213/270] mptcp: fix rx timestamp corruption on fastopen
Date: Tue, 12 May 2026 19:40:14 +0200
Message-ID: <20260512173942.930841214@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 581F4526F13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246293-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 6254a16d6f0c672e3809ca5d7c9a28a55d71f764 upstream.

The skb cb offset containing the timestamp presence flag is cleared
before loading such information. Cache such value before MPTCP CB
initialization.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260501-net-mptcp-misc-fixes-7-1-rc3-v1-3-b70118df778e@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/fastopen.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -12,6 +12,7 @@ void mptcp_fastopen_subflow_synack_set_p
 	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
+	bool has_rxtstamp;
 
 	/* on early fallback the subflow context is deleted by
 	 * subflow_syn_recv_sock()
@@ -39,12 +40,13 @@ void mptcp_fastopen_subflow_synack_set_p
 	 */
 	tp->copied_seq += skb->len;
 	subflow->ssn_offset += skb->len;
+	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
-	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);



