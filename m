Return-Path: <stable+bounces-237901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKwcDUpb3mkyCQAAu9opvQ
	(envelope-from <stable+bounces-237901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:20:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6EF3FBABD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 964F53021C01
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B933E9585;
	Tue, 14 Apr 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlzwRS9M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD623E92BA
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179466; cv=none; b=e/jTjUbvelqQyS2Lif2W6jGSS1HR1XPjsu9sIF1LlRp2+jHZmgeyTg/gHbQRlTWMPsZ9Ohp8Ybvfr8Z9gbS50BG3lRyJCrtzHFm8kfXtTy46fgMr8V6rIHMTTW5XvewZRKYGmqHr9ESwvlzehsm3SAjE0cabuhVg/nrL01pLZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179466; c=relaxed/simple;
	bh=uvAze9brXq55JfAiOwZdyxIpCmyZUx29pAH3PQfKkNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvMqlFFzvnzoX2RgfsutCgMB5ECyX728v93vXHSuH3NZN9H2aIe7nGDYC2ejF2WnnKsNz2NPKO2Z42iBSdZf5xLjWzCQMnkoRsw/R6nnh9D0U7p2WDWcpSslX2Qqf7vIXBEIYyolC1OeAX69YVIXvfMpBFTV5inHvREDz6vzrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlzwRS9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D52AC19425;
	Tue, 14 Apr 2026 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776179466;
	bh=uvAze9brXq55JfAiOwZdyxIpCmyZUx29pAH3PQfKkNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlzwRS9MYfLUQHO+PqXe8G/ZlrSRyNmu0GT23jrZRfcuGqm1asWN1EYpr7QB1QuoJ
	 NxwCI/086lS9pJmOXCI9w79Y97F4zHorAbzhNAALs3UWBGvLJvUjl33I2m9oqdsVIj
	 1R9hhWix/XYe3i0dhzaMx7BtBSUb5mV1v3O5beJ9/WuyIlKZaM4rkWZDHlfanGw4qI
	 W9lC7ymFGnNNJCpv3T9u4VRcGRIpxYCP6X2E1RDip8M5xLu4lnl+RTJec3uNJdsV84
	 oAoYqfRlsvH4emKAvqOLlakDzc2QYZvB3THupL7HIHPwry3VzsnqJd7PiH7/ERLaks
	 CWhc5jNgvtJ9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] rxrpc: proc: size address buffers for %pISpc output
Date: Tue, 14 Apr 2026 11:11:03 -0400
Message-ID: <20260414151103.858622-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041328-kinswoman-emphatic-8d5f@gregkh>
References: <2026041328-kinswoman-emphatic-8d5f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237901-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 2E6EF3FBABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit a44ce6aa2efb61fe44f2cfab72bb01544bbca272 ]

The AF_RXRPC procfs helpers format local and remote socket addresses into
fixed 50-byte stack buffers with "%pISpc".

That is too small for the longest current-tree IPv6-with-port form the
formatter can produce. In lib/vsprintf.c, the compressed IPv6 path uses a
dotted-quad tail not only for v4mapped addresses, but also for ISATAP
addresses via ipv6_addr_is_isatap().

As a result, a case such as

  [ffff:ffff:ffff:ffff:0:5efe:255.255.255.255]:65535

is possible with the current formatter. That is 50 visible characters, so
51 bytes including the trailing NUL, which does not fit in the existing
char[50] buffers used by net/rxrpc/proc.c.

Size the buffers from the formatter's maximum textual form and switch the
call sites to scnprintf().

Changes since v1:
- correct the changelog to cite the actual maximum current-tree case
  explicitly
- frame the proof around the ISATAP formatting path instead of the earlier
  mapped-v4 example

Fixes: 75b54cb57ca3 ("rxrpc: Add IPv6 support")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Anderson Nascimento <anderson@allelesecurity.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-22-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted address accessors and variable declarations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/proc.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 245418943e01c..47d36554ad311 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -10,6 +10,10 @@
 #include <net/af_rxrpc.h>
 #include "ar-internal.h"
 
+#define RXRPC_PROC_ADDRBUF_SIZE \
+	(sizeof("[xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255]") + \
+	 sizeof(":12345"))
+
 static const char *const rxrpc_conn_states[RXRPC_CONN__NR_STATES] = {
 	[RXRPC_CONN_UNUSED]			= "Unused  ",
 	[RXRPC_CONN_CLIENT]			= "Client  ",
@@ -55,7 +59,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 	unsigned long timeout = 0;
 	rxrpc_seq_t tx_hard_ack, rx_hard_ack;
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == &rxnet->calls) {
 		seq_puts(seq,
@@ -72,7 +76,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	if (rx) {
 		local = READ_ONCE(rx->local);
 		if (local)
-			sprintf(lbuff, "%pISpc", &local->srx.transport);
+			scnprintf(lbuff, sizeof(lbuff), "%pISpc", &local->srx.transport);
 		else
 			strcpy(lbuff, "no_local");
 	} else {
@@ -81,7 +85,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 
 	peer = call->peer;
 	if (peer)
-		sprintf(rbuff, "%pISpc", &peer->srx.transport);
+		scnprintf(rbuff, sizeof(rbuff), "%pISpc", &peer->srx.transport);
 	else
 		strcpy(rbuff, "no_connection");
 
@@ -152,7 +156,7 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_connection *conn;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == &rxnet->conn_proc_list) {
 		seq_puts(seq,
@@ -171,9 +175,9 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 		goto print;
 	}
 
-	sprintf(lbuff, "%pISpc", &conn->params.local->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &conn->params.local->srx.transport);
 
-	sprintf(rbuff, "%pISpc", &conn->params.peer->srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &conn->params.peer->srx.transport);
 print:
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %08x %s %3u"
@@ -210,7 +214,7 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_peer *peer;
 	time64_t now;
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq,
@@ -223,9 +227,9 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 
 	peer = list_entry(v, struct rxrpc_peer, hash_link);
 
-	sprintf(lbuff, "%pISpc", &peer->local->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &peer->local->srx.transport);
 
-	sprintf(rbuff, "%pISpc", &peer->srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &peer->srx.transport);
 
 	now = ktime_get_seconds();
 	seq_printf(seq,
@@ -335,7 +339,7 @@ const struct seq_operations rxrpc_peer_seq_ops = {
 static int rxrpc_local_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_local *local;
-	char lbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq,
@@ -346,7 +350,7 @@ static int rxrpc_local_seq_show(struct seq_file *seq, void *v)
 
 	local = hlist_entry(v, struct rxrpc_local, link);
 
-	sprintf(lbuff, "%pISpc", &local->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &local->srx.transport);
 
 	seq_printf(seq,
 		   "UDP   %-47.47s %3u %3u\n",
-- 
2.53.0


