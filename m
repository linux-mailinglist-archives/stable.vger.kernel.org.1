Return-Path: <stable+bounces-238073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ+TGfBX32n1RwAAu9opvQ
	(envelope-from <stable+bounces-238073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:18:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA3402771
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7E2430C43E9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836793314B9;
	Wed, 15 Apr 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="obf7TaQD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43F1A6811;
	Wed, 15 Apr 2026 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244553; cv=none; b=eKjMIXSkzqvczF1m7arDOBDFOg6k6PFF+nnGD9sBbY0sXR4p391EqWfDMx8MQkKJt4En1qYVUp6xsgZ22pBna0+izqc92JCzbNEp/czoK71Y/wUnhvS7pTctaZsc9Yr8grCWtGT/Nhhqvh+VrdwTNnU2M1+NIfT2g3pB2o+So9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244553; c=relaxed/simple;
	bh=BXBra3R2CjRzvAj1nDBR5jHZlsWPGvRQ+inLS1Tc9bs=;
	h=Date:To:From:Subject:Message-Id; b=Ynv3C6AlY5xYlzcwFpz1GRmVMGSa+8Xb9uPqYJHmmTdKCYXS9kYEXczGeQKL+DPOTwRODdl2j2FfsSH/ctQXWbE7p8VoMlSdAgd9tj/MijtlzsC8pxCzDS6p4+2goh5i6gd3/5DEgkDiebN5xEHEaM5v3x9xLFkUJPLHpFK9CZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=obf7TaQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FC4C2BCB5;
	Wed, 15 Apr 2026 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776244552;
	bh=BXBra3R2CjRzvAj1nDBR5jHZlsWPGvRQ+inLS1Tc9bs=;
	h=Date:To:From:Subject:From;
	b=obf7TaQD+qvkeOA800CJ+EmQkPXyC/BPwUBGNpPNi+1DerHlWp1bnZCOwtusaqII2
	 GwfUeCIvsBvS+G0GJZwzw2nsK4Oh4KDW9jQOJY2s/VtnPlgbC1LQB1NukNabFVYVNO
	 koKOtrTb95ogSFh791ntWu8xkxeMrG9kydR8idAA=
Date: Wed, 15 Apr 2026 02:15:49 -0700
To: mm-commits@vger.kernel.org,wang.yaxin@zte.com.cn,thomas.orgis@uni-hamburg.de,stable@vger.kernel.org,fan.yu9@zte.com.cn,bsingharora@gmail.com,cyyzero16@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] tools-accounting-handle-truncated-taskstats-netlink-messages.patch removed from -mm tree
Message-Id: <20260415091552.17FC4C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238073-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,zte.com.cn,uni-hamburg.de,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,uni-hamburg.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:email]
X-Rspamd-Queue-Id: 01CA3402771
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: tools/accounting: handle truncated taskstats netlink messages
has been removed from the -mm tree.  Its filename was
     tools-accounting-handle-truncated-taskstats-netlink-messages.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Yiyang Chen <cyyzero16@gmail.com>
Subject: tools/accounting: handle truncated taskstats netlink messages
Date: Mon, 30 Mar 2026 03:00:41 +0800

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
---

 tools/accounting/getdelays.c |   41 +++++++++++++++++++++++++++++----
 tools/accounting/procacct.c  |   40 ++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 8 deletions(-)

--- a/tools/accounting/getdelays.c~tools-accounting-handle-truncated-taskstats-netlink-messages
+++ a/tools/accounting/getdelays.c
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
--- a/tools/accounting/procacct.c~tools-accounting-handle-truncated-taskstats-netlink-messages
+++ a/tools/accounting/procacct.c
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
_

Patches currently in -mm which might be from cyyzero16@gmail.com are



