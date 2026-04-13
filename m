Return-Path: <stable+bounces-236067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ImGEs/m3GkZYAkAu9opvQ
	(envelope-from <stable+bounces-236067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:51:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E42A3EC341
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F061E300B8E9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959713C660A;
	Mon, 13 Apr 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d+PHyeRS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A23C8722
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084682; cv=none; b=ioOY5XIXvKRsWobu7rCtb949AicVnUdbG/UkzCkuEBKTUObUqM8m167TJ2ITPZ214Ic8H8HH1WlvJLgdFtYUMHBEhQU14qVj9cx2vYhcbJj2/M60nIwRDaobCdb+hOegQFmplcH3Vgi5eppPPZIMQBfAAeWSR2EJoWzg0JeWllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084682; c=relaxed/simple;
	bh=n/1fcw6p+Lp+hveqhGJ7PAmZX36Osg5BBW7HWBv6zlI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ccVmPCvR8TUpbxZWAufk52rsar2OmKzxyNL0MfQuY+RJFYio81wj9S1mlUpJVJB0NZ2BJRO41oze+SUp2xxe3NytQGRi/cibBNsqCfuXa7j4zyZnnN9RcvzwTG5jLTw36DbAeYvKcjnyc7YFi+r6MmeBQxGb7bwzzKlZPAgwK8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d+PHyeRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4185C2BCAF;
	Mon, 13 Apr 2026 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776084682;
	bh=n/1fcw6p+Lp+hveqhGJ7PAmZX36Osg5BBW7HWBv6zlI=;
	h=Subject:To:Cc:From:Date:From;
	b=d+PHyeRS7NXp/Bi3KzhHawGpOuPc4Ts7mJsYNqT9I0JRENd76z1lOioSbxmad9QFf
	 8beTkoV4ox03RdaBltNCCvGq/nkEtXuLbQM5rqY+gGcdCkd43rNN9xsiMfZOUOTsCv
	 2GID+AyKG1jk1ZNppajV+442bjixYu8AHOYiqoMY=
Subject: FAILED: patch "[PATCH] rxrpc: proc: size address buffers for %pISpc output" failed to apply to 6.12-stable tree
To: pengpeng@iscas.ac.cn,anderson@allelesecurity.com,dhowells@redhat.com,horms@kernel.org,kuba@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:37:26 +0200
Message-ID: <2026041326-engaged-snowbird-df74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236067-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,infradead.org:email,allelesecurity.com:email,auristor.com:email,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 4E42A3EC341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a44ce6aa2efb61fe44f2cfab72bb01544bbca272
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041326-engaged-snowbird-df74@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a44ce6aa2efb61fe44f2cfab72bb01544bbca272 Mon Sep 17 00:00:00 2001
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Wed, 8 Apr 2026 13:12:49 +0100
Subject: [PATCH] rxrpc: proc: size address buffers for %pISpc output

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

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 7755fca5beb8..e9a27fa7b25d 100644
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
 	[RXRPC_CONN_CLIENT_UNSECURED]		= "ClUnsec ",
@@ -53,7 +57,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 	enum rxrpc_call_state state;
 	rxrpc_seq_t tx_bottom;
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 	long timeout = 0;
 
 	if (v == &rxnet->calls) {
@@ -69,11 +73,11 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 
 	local = call->local;
 	if (local)
-		sprintf(lbuff, "%pISpc", &local->srx.transport);
+		scnprintf(lbuff, sizeof(lbuff), "%pISpc", &local->srx.transport);
 	else
 		strcpy(lbuff, "no_local");
 
-	sprintf(rbuff, "%pISpc", &call->dest_srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &call->dest_srx.transport);
 
 	state = rxrpc_call_state(call);
 	if (state != RXRPC_CALL_SERVER_PREALLOC)
@@ -142,7 +146,7 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_connection *conn;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 	const char *state;
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == &rxnet->conn_proc_list) {
 		seq_puts(seq,
@@ -161,8 +165,8 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 		goto print;
 	}
 
-	sprintf(lbuff, "%pISpc", &conn->local->srx.transport);
-	sprintf(rbuff, "%pISpc", &conn->peer->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &conn->local->srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &conn->peer->srx.transport);
 print:
 	state = rxrpc_is_conn_aborted(conn) ?
 		rxrpc_call_completions[conn->completion] :
@@ -228,7 +232,7 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_bundle *bundle;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == &rxnet->bundle_proc_list) {
 		seq_puts(seq,
@@ -242,8 +246,8 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
 
 	bundle = list_entry(v, struct rxrpc_bundle, proc_link);
 
-	sprintf(lbuff, "%pISpc", &bundle->local->srx.transport);
-	sprintf(rbuff, "%pISpc", &bundle->peer->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &bundle->local->srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &bundle->peer->srx.transport);
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %3u %3d"
 		   " %c%c%c %08x | %08x %08x %08x %08x %08x\n",
@@ -279,7 +283,7 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_peer *peer;
 	time64_t now;
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq,
@@ -290,9 +294,9 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 
 	peer = list_entry(v, struct rxrpc_peer, hash_link);
 
-	sprintf(lbuff, "%pISpc", &peer->local->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &peer->local->srx.transport);
 
-	sprintf(rbuff, "%pISpc", &peer->srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &peer->srx.transport);
 
 	now = ktime_get_seconds();
 	seq_printf(seq,
@@ -401,7 +405,7 @@ const struct seq_operations rxrpc_peer_seq_ops = {
 static int rxrpc_local_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_local *local;
-	char lbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq,
@@ -412,7 +416,7 @@ static int rxrpc_local_seq_show(struct seq_file *seq, void *v)
 
 	local = hlist_entry(v, struct rxrpc_local, link);
 
-	sprintf(lbuff, "%pISpc", &local->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &local->srx.transport);
 
 	seq_printf(seq,
 		   "UDP   %-47.47s %3u %3u %3u\n",


