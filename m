Return-Path: <stable+bounces-243181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KXMJnKo+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:08:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFE34BE9BA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209D230520AC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB56F347BA9;
	Mon,  4 May 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2PYNy3eX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FD3A7F4C;
	Mon,  4 May 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903224; cv=none; b=em0amshBeIlKoZa5qvfouPugaypMvbbOlhEwd9ggUCIyXdgxwTFTUEWUW3U9l/VZd5XFsfO5jiAe8oV94Y61WYdF2vKZ/iXi/xaZJimSAwsIzUHX+/6OKjXU+fLq+CPNJZg/G2vagsPLN0mtPZc0bBkYABtFrjZMqV9uUFGOstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903224; c=relaxed/simple;
	bh=B9P2JU63GE0/qmIJHe/IKrrY60a2GoFEtmEhugb/B8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwV3VH+JXt2azFJ3jHnjHdmvBdZPWDleJ4UcXFEzrWj1QpLzPCShqNK+BiQwvYcqwpSheYwpU8cgnOwG5mSnA/T+UUCx7BvOWz/KXhoI/KxWhhNoYVR3QB5Q9Fi0tFrCqHbMccFAVizGZ74OG47Exeoys4+NOwcEQ2irCJwGPdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2PYNy3eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48D4C2BCB8;
	Mon,  4 May 2026 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903224;
	bh=B9P2JU63GE0/qmIJHe/IKrrY60a2GoFEtmEhugb/B8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2PYNy3eXOIdKun9dvcJ0Cnk8iCcsoDOQw8CIj8KEdVOVYKqob2Q63++D2BBBUD6S6
	 5IoH8nMaupunAD/GmfF7fp9IF3PQ99iu8ht2F6OmtPtkNInmAaCbiADn6ta+saSkUR
	 hICRYCiNxnbgEV30+5tw8aM3Jg2GJVFy/0/WQg1k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiyang Chen <cyyzero16@gmail.com>,
	Balbir Singh <bsingharora@gmail.com>,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Fan Yu <fan.yu9@zte.com.cn>,
	Wang Yaxin <wang.yaxin@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.0 134/307] tools/accounting: handle truncated taskstats netlink messages
Date: Mon,  4 May 2026 15:50:19 +0200
Message-ID: <20260504135147.829167466@linuxfoundation.org>
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
X-Rspamd-Queue-Id: EFFE34BE9BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,uni-hamburg.de,zte.com.cn,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-243181-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,zte.com.cn:email,uni-hamburg.de:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yiyang Chen <cyyzero16@gmail.com>

commit cc82b3dcc6a8fa259fbda12ab00d6fc00908a49e upstream.

procacct and getdelays use a fixed receive buffer for taskstats generic
netlink messages.  A multi-threaded process exit can emit a single
PID+TGID notification large enough to exceed that buffer on newer kernels.

Switch to recvmsg() so MSG_TRUNC is detected explicitly, increase the
message buffer size, and report truncated datagrams clearly instead of
misparsing them as fatal netlink errors.

Also print the taskstats version in debug output to make version
mismatches easier to diagnose while inspecting taskstats traffic.

Link: https://lkml.kernel.org/r/520308bb4cbbaf8dc2c7296b5f60f11e12fb30a5.1774810498.git.cyyzero16@gmail.com
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
Cc: Fan Yu <fan.yu9@zte.com.cn>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/accounting/getdelays.c |   41 +++++++++++++++++++++++++++++++++++++----
 tools/accounting/procacct.c  |   40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 8 deletions(-)

--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -60,7 +60,7 @@ int print_task_context_switch_counts;
 	}
 
 /* Maximum size of response requested or message sent */
-#define MAX_MSG_SIZE	1024
+#define MAX_MSG_SIZE	2048
 /* Maximum number of cpus expected to be specified in a cpumask */
 #define MAX_CPUS	32
 
@@ -115,6 +115,32 @@ error:
 	return -1;
 }
 
+static int recv_taskstats_msg(int sd, struct msgtemplate *msg)
+{
+	struct sockaddr_nl nladdr;
+	struct iovec iov = {
+		.iov_base = msg,
+		.iov_len = sizeof(*msg),
+	};
+	struct msghdr hdr = {
+		.msg_name = &nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	int ret;
+
+	ret = recvmsg(sd, &hdr, 0);
+	if (ret < 0)
+		return -1;
+	if (hdr.msg_flags & MSG_TRUNC) {
+		errno = EMSGSIZE;
+		return -1;
+	}
+
+	return ret;
+}
+
 
 static int send_cmd(int sd, __u16 nlmsg_type, __u32 nlmsg_pid,
 	     __u8 genl_cmd, __u16 nla_type,
@@ -633,12 +659,16 @@ int main(int argc, char *argv[])
 	}
 
 	do {
-		rep_len = recv(nl_sd, &msg, sizeof(msg), 0);
+		rep_len = recv_taskstats_msg(nl_sd, &msg);
 		PRINTF("received %d bytes\n", rep_len);
 
 		if (rep_len < 0) {
-			fprintf(stderr, "nonfatal reply error: errno %d\n",
-				errno);
+			if (errno == EMSGSIZE)
+				fprintf(stderr,
+					"dropped truncated taskstats netlink message, please increase MAX_MSG_SIZE\n");
+			else
+				fprintf(stderr, "nonfatal reply error: errno %d\n",
+					errno);
 			continue;
 		}
 		if (msg.n.nlmsg_type == NLMSG_ERROR ||
@@ -680,6 +710,9 @@ int main(int argc, char *argv[])
 							printf("TGID\t%d\n", rtid);
 						break;
 					case TASKSTATS_TYPE_STATS:
+						PRINTF("version %u\n",
+						       ((struct taskstats *)
+							NLA_DATA(na))->version);
 						if (print_delays)
 							print_delayacct((struct taskstats *) NLA_DATA(na));
 						if (print_io_accounting)
--- a/tools/accounting/procacct.c
+++ b/tools/accounting/procacct.c
@@ -71,7 +71,7 @@ int print_task_context_switch_counts;
 	}
 
 /* Maximum size of response requested or message sent */
-#define MAX_MSG_SIZE	1024
+#define MAX_MSG_SIZE	2048
 /* Maximum number of cpus expected to be specified in a cpumask */
 #define MAX_CPUS	32
 
@@ -121,6 +121,32 @@ error:
 	return -1;
 }
 
+static int recv_taskstats_msg(int sd, struct msgtemplate *msg)
+{
+	struct sockaddr_nl nladdr;
+	struct iovec iov = {
+		.iov_base = msg,
+		.iov_len = sizeof(*msg),
+	};
+	struct msghdr hdr = {
+		.msg_name = &nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	int ret;
+
+	ret = recvmsg(sd, &hdr, 0);
+	if (ret < 0)
+		return -1;
+	if (hdr.msg_flags & MSG_TRUNC) {
+		errno = EMSGSIZE;
+		return -1;
+	}
+
+	return ret;
+}
+
 
 static int send_cmd(int sd, __u16 nlmsg_type, __u32 nlmsg_pid,
 	     __u8 genl_cmd, __u16 nla_type,
@@ -239,6 +265,8 @@ void handle_aggr(int mother, struct nlat
 			PRINTF("TGID\t%d\n", rtid);
 			break;
 		case TASKSTATS_TYPE_STATS:
+			PRINTF("version %u\n",
+			       ((struct taskstats *)NLA_DATA(na))->version);
 			if (mother == TASKSTATS_TYPE_AGGR_PID)
 				print_procacct((struct taskstats *) NLA_DATA(na));
 			if (fd) {
@@ -347,12 +375,16 @@ int main(int argc, char *argv[])
 	}
 
 	do {
-		rep_len = recv(nl_sd, &msg, sizeof(msg), 0);
+		rep_len = recv_taskstats_msg(nl_sd, &msg);
 		PRINTF("received %d bytes\n", rep_len);
 
 		if (rep_len < 0) {
-			fprintf(stderr, "nonfatal reply error: errno %d\n",
-				errno);
+			if (errno == EMSGSIZE)
+				fprintf(stderr,
+					"dropped truncated taskstats netlink message, please increase MAX_MSG_SIZE\n");
+			else
+				fprintf(stderr, "nonfatal reply error: errno %d\n",
+					errno);
 			continue;
 		}
 		if (msg.n.nlmsg_type == NLMSG_ERROR ||



