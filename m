Return-Path: <stable+bounces-104838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB589F5352
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7441885A7D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D014A4E7;
	Tue, 17 Dec 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FB4pN+i/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE51DE2AC;
	Tue, 17 Dec 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456256; cv=none; b=XaezSpGfcpSGz41sJxc+eNg/Un0MxNH8CXOVWnwYfCVQvoU7eGHISMoPs8O6fXRenIdNnwXFfbP0VL0FzNmAW/G7cQS22FXWZ2Y2sf+J+XztlSCPDu5h0YN21Exl4PFDyFw04sCP+42oDCUTIiY9cB4H/B35v5bPlK9PddP5dY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456256; c=relaxed/simple;
	bh=0rccpfzV1o5Q/KQCF2k2oWhDaHCJNprI6uRvRJqAgps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGfO/PwdeFx8iWxhIpyb3Ar9k8FQMiCY6S+MYFhng5JWC7sIF3IO6z3tFh5VI2iy5k3aCjBVT0Mt7YUvdl1NPVvoN36PEDnJen/sYFK4Oz2pm0wW/2uUOHeVNr2P0dosCQdeGK/LwqlhFmvMlvbIuDfdAaCCKKDtz2jDsDVPWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FB4pN+i/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D62C4CEDD;
	Tue, 17 Dec 2024 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456256;
	bh=0rccpfzV1o5Q/KQCF2k2oWhDaHCJNprI6uRvRJqAgps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FB4pN+i/iIj6v68/VTcw9vJbgxDoIBeYQ/hZ7YXtutvHLJlXXZ/N+HGo3iWOCmVIk
	 rVoQJ6CiXQbpc1LDi4MwjLBh4v/KSU/ZHhQHrSjHHpfc8LH3JAa2Ac/eR2jALceul9
	 AffwLNsHh45Zz8bjwUSsIWuiiEsm+I2ovP+ZaiRY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 6.6 098/109] selftests/bpf: Add netlink helper library
Date: Tue, 17 Dec 2024 18:08:22 +0100
Message-ID: <20241217170537.483500429@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 51f1892b5289f0c09745d3bedb36493555d6d90c upstream.

Add a minimal netlink helper library for the BPF selftests. This has been
taken and cut down and cleaned up from iproute2. This covers basics such
as netdevice creation which we need for BPF selftests / BPF CI given
iproute2 package cannot cover it yet.

Stanislav Fomichev suggested that this could be replaced in future by ynl
tool generated C code once it has RTNL support to create devices. Once we
get to this point the BPF CI would also need to add libmnl. If no further
extensions are needed, a second option could be that we remove this code
again once iproute2 package has support.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20231024214904.29825-7-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/Makefile          |   19 +
 tools/testing/selftests/bpf/netlink_helpers.c |  358 ++++++++++++++++++++++++++
 tools/testing/selftests/bpf/netlink_helpers.h |   46 +++
 3 files changed, 418 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h

--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -590,11 +590,20 @@ endef
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
-TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
-			 network_helpers.c testing_helpers.c		\
-			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c test_loader.c xsk.c disasm.c	\
-			 json_writer.c unpriv_helpers.c 		\
+TRUNNER_EXTRA_SOURCES := test_progs.c		\
+			 cgroup_helpers.c	\
+			 trace_helpers.c	\
+			 network_helpers.c	\
+			 testing_helpers.c	\
+			 btf_helpers.c		\
+			 cap_helpers.c		\
+			 unpriv_helpers.c 	\
+			 netlink_helpers.c	\
+			 test_loader.c		\
+			 xsk.c			\
+			 disasm.c		\
+			 json_writer.c 		\
+			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
--- /dev/null
+++ b/tools/testing/selftests/bpf/netlink_helpers.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Taken & modified from iproute2's libnetlink.c
+ * Authors: Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <time.h>
+#include <sys/socket.h>
+
+#include "netlink_helpers.h"
+
+static int rcvbuf = 1024 * 1024;
+
+void rtnl_close(struct rtnl_handle *rth)
+{
+	if (rth->fd >= 0) {
+		close(rth->fd);
+		rth->fd = -1;
+	}
+}
+
+int rtnl_open_byproto(struct rtnl_handle *rth, unsigned int subscriptions,
+		      int protocol)
+{
+	socklen_t addr_len;
+	int sndbuf = 32768;
+	int one = 1;
+
+	memset(rth, 0, sizeof(*rth));
+	rth->proto = protocol;
+	rth->fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, protocol);
+	if (rth->fd < 0) {
+		perror("Cannot open netlink socket");
+		return -1;
+	}
+	if (setsockopt(rth->fd, SOL_SOCKET, SO_SNDBUF,
+		       &sndbuf, sizeof(sndbuf)) < 0) {
+		perror("SO_SNDBUF");
+		goto err;
+	}
+	if (setsockopt(rth->fd, SOL_SOCKET, SO_RCVBUF,
+		       &rcvbuf, sizeof(rcvbuf)) < 0) {
+		perror("SO_RCVBUF");
+		goto err;
+	}
+
+	/* Older kernels may no support extended ACK reporting */
+	setsockopt(rth->fd, SOL_NETLINK, NETLINK_EXT_ACK,
+		   &one, sizeof(one));
+
+	memset(&rth->local, 0, sizeof(rth->local));
+	rth->local.nl_family = AF_NETLINK;
+	rth->local.nl_groups = subscriptions;
+
+	if (bind(rth->fd, (struct sockaddr *)&rth->local,
+		 sizeof(rth->local)) < 0) {
+		perror("Cannot bind netlink socket");
+		goto err;
+	}
+	addr_len = sizeof(rth->local);
+	if (getsockname(rth->fd, (struct sockaddr *)&rth->local,
+			&addr_len) < 0) {
+		perror("Cannot getsockname");
+		goto err;
+	}
+	if (addr_len != sizeof(rth->local)) {
+		fprintf(stderr, "Wrong address length %d\n", addr_len);
+		goto err;
+	}
+	if (rth->local.nl_family != AF_NETLINK) {
+		fprintf(stderr, "Wrong address family %d\n",
+			rth->local.nl_family);
+		goto err;
+	}
+	rth->seq = time(NULL);
+	return 0;
+err:
+	rtnl_close(rth);
+	return -1;
+}
+
+int rtnl_open(struct rtnl_handle *rth, unsigned int subscriptions)
+{
+	return rtnl_open_byproto(rth, subscriptions, NETLINK_ROUTE);
+}
+
+static int __rtnl_recvmsg(int fd, struct msghdr *msg, int flags)
+{
+	int len;
+
+	do {
+		len = recvmsg(fd, msg, flags);
+	} while (len < 0 && (errno == EINTR || errno == EAGAIN));
+	if (len < 0) {
+		fprintf(stderr, "netlink receive error %s (%d)\n",
+			strerror(errno), errno);
+		return -errno;
+	}
+	if (len == 0) {
+		fprintf(stderr, "EOF on netlink\n");
+		return -ENODATA;
+	}
+	return len;
+}
+
+static int rtnl_recvmsg(int fd, struct msghdr *msg, char **answer)
+{
+	struct iovec *iov = msg->msg_iov;
+	char *buf;
+	int len;
+
+	iov->iov_base = NULL;
+	iov->iov_len = 0;
+
+	len = __rtnl_recvmsg(fd, msg, MSG_PEEK | MSG_TRUNC);
+	if (len < 0)
+		return len;
+	if (len < 32768)
+		len = 32768;
+	buf = malloc(len);
+	if (!buf) {
+		fprintf(stderr, "malloc error: not enough buffer\n");
+		return -ENOMEM;
+	}
+	iov->iov_base = buf;
+	iov->iov_len = len;
+	len = __rtnl_recvmsg(fd, msg, 0);
+	if (len < 0) {
+		free(buf);
+		return len;
+	}
+	if (answer)
+		*answer = buf;
+	else
+		free(buf);
+	return len;
+}
+
+static void rtnl_talk_error(struct nlmsghdr *h, struct nlmsgerr *err,
+			    nl_ext_ack_fn_t errfn)
+{
+	fprintf(stderr, "RTNETLINK answers: %s\n",
+		strerror(-err->error));
+}
+
+static int __rtnl_talk_iov(struct rtnl_handle *rtnl, struct iovec *iov,
+			   size_t iovlen, struct nlmsghdr **answer,
+			   bool show_rtnl_err, nl_ext_ack_fn_t errfn)
+{
+	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
+	struct iovec riov;
+	struct msghdr msg = {
+		.msg_name	= &nladdr,
+		.msg_namelen	= sizeof(nladdr),
+		.msg_iov	= iov,
+		.msg_iovlen	= iovlen,
+	};
+	unsigned int seq = 0;
+	struct nlmsghdr *h;
+	int i, status;
+	char *buf;
+
+	for (i = 0; i < iovlen; i++) {
+		h = iov[i].iov_base;
+		h->nlmsg_seq = seq = ++rtnl->seq;
+		if (answer == NULL)
+			h->nlmsg_flags |= NLM_F_ACK;
+	}
+	status = sendmsg(rtnl->fd, &msg, 0);
+	if (status < 0) {
+		perror("Cannot talk to rtnetlink");
+		return -1;
+	}
+	/* change msg to use the response iov */
+	msg.msg_iov = &riov;
+	msg.msg_iovlen = 1;
+	i = 0;
+	while (1) {
+next:
+		status = rtnl_recvmsg(rtnl->fd, &msg, &buf);
+		++i;
+		if (status < 0)
+			return status;
+		if (msg.msg_namelen != sizeof(nladdr)) {
+			fprintf(stderr,
+				"Sender address length == %d!\n",
+				msg.msg_namelen);
+			exit(1);
+		}
+		for (h = (struct nlmsghdr *)buf; status >= sizeof(*h); ) {
+			int len = h->nlmsg_len;
+			int l = len - sizeof(*h);
+
+			if (l < 0 || len > status) {
+				if (msg.msg_flags & MSG_TRUNC) {
+					fprintf(stderr, "Truncated message!\n");
+					free(buf);
+					return -1;
+				}
+				fprintf(stderr,
+					"Malformed message: len=%d!\n",
+					len);
+				exit(1);
+			}
+			if (nladdr.nl_pid != 0 ||
+			    h->nlmsg_pid != rtnl->local.nl_pid ||
+			    h->nlmsg_seq > seq || h->nlmsg_seq < seq - iovlen) {
+				/* Don't forget to skip that message. */
+				status -= NLMSG_ALIGN(len);
+				h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+				continue;
+			}
+			if (h->nlmsg_type == NLMSG_ERROR) {
+				struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);
+				int error = err->error;
+
+				if (l < sizeof(struct nlmsgerr)) {
+					fprintf(stderr, "ERROR truncated\n");
+					free(buf);
+					return -1;
+				}
+				if (error) {
+					errno = -error;
+					if (rtnl->proto != NETLINK_SOCK_DIAG &&
+					    show_rtnl_err)
+						rtnl_talk_error(h, err, errfn);
+				}
+				if (i < iovlen) {
+					free(buf);
+					goto next;
+				}
+				if (error) {
+					free(buf);
+					return -i;
+				}
+				if (answer)
+					*answer = (struct nlmsghdr *)buf;
+				else
+					free(buf);
+				return 0;
+			}
+			if (answer) {
+				*answer = (struct nlmsghdr *)buf;
+				return 0;
+			}
+			fprintf(stderr, "Unexpected reply!\n");
+			status -= NLMSG_ALIGN(len);
+			h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+		}
+		free(buf);
+		if (msg.msg_flags & MSG_TRUNC) {
+			fprintf(stderr, "Message truncated!\n");
+			continue;
+		}
+		if (status) {
+			fprintf(stderr, "Remnant of size %d!\n", status);
+			exit(1);
+		}
+	}
+}
+
+static int __rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
+		       struct nlmsghdr **answer, bool show_rtnl_err,
+		       nl_ext_ack_fn_t errfn)
+{
+	struct iovec iov = {
+		.iov_base	= n,
+		.iov_len	= n->nlmsg_len,
+	};
+
+	return __rtnl_talk_iov(rtnl, &iov, 1, answer, show_rtnl_err, errfn);
+}
+
+int rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
+	      struct nlmsghdr **answer)
+{
+	return __rtnl_talk(rtnl, n, answer, true, NULL);
+}
+
+int addattr(struct nlmsghdr *n, int maxlen, int type)
+{
+	return addattr_l(n, maxlen, type, NULL, 0);
+}
+
+int addattr8(struct nlmsghdr *n, int maxlen, int type, __u8 data)
+{
+	return addattr_l(n, maxlen, type, &data, sizeof(__u8));
+}
+
+int addattr16(struct nlmsghdr *n, int maxlen, int type, __u16 data)
+{
+	return addattr_l(n, maxlen, type, &data, sizeof(__u16));
+}
+
+int addattr32(struct nlmsghdr *n, int maxlen, int type, __u32 data)
+{
+	return addattr_l(n, maxlen, type, &data, sizeof(__u32));
+}
+
+int addattr64(struct nlmsghdr *n, int maxlen, int type, __u64 data)
+{
+	return addattr_l(n, maxlen, type, &data, sizeof(__u64));
+}
+
+int addattrstrz(struct nlmsghdr *n, int maxlen, int type, const char *str)
+{
+	return addattr_l(n, maxlen, type, str, strlen(str)+1);
+}
+
+int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void *data,
+	      int alen)
+{
+	int len = RTA_LENGTH(alen);
+	struct rtattr *rta;
+
+	if (NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len) > maxlen) {
+		fprintf(stderr, "%s: Message exceeded bound of %d\n",
+			__func__, maxlen);
+		return -1;
+	}
+	rta = NLMSG_TAIL(n);
+	rta->rta_type = type;
+	rta->rta_len = len;
+	if (alen)
+		memcpy(RTA_DATA(rta), data, alen);
+	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
+	return 0;
+}
+
+int addraw_l(struct nlmsghdr *n, int maxlen, const void *data, int len)
+{
+	if (NLMSG_ALIGN(n->nlmsg_len) + NLMSG_ALIGN(len) > maxlen) {
+		fprintf(stderr, "%s: Message exceeded bound of %d\n",
+			__func__, maxlen);
+		return -1;
+	}
+
+	memcpy(NLMSG_TAIL(n), data, len);
+	memset((void *) NLMSG_TAIL(n) + len, 0, NLMSG_ALIGN(len) - len);
+	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + NLMSG_ALIGN(len);
+	return 0;
+}
+
+struct rtattr *addattr_nest(struct nlmsghdr *n, int maxlen, int type)
+{
+	struct rtattr *nest = NLMSG_TAIL(n);
+
+	addattr_l(n, maxlen, type, NULL, 0);
+	return nest;
+}
+
+int addattr_nest_end(struct nlmsghdr *n, struct rtattr *nest)
+{
+	nest->rta_len = (void *)NLMSG_TAIL(n) - (void *)nest;
+	return n->nlmsg_len;
+}
--- /dev/null
+++ b/tools/testing/selftests/bpf/netlink_helpers.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef NETLINK_HELPERS_H
+#define NETLINK_HELPERS_H
+
+#include <string.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+
+struct rtnl_handle {
+	int			fd;
+	struct sockaddr_nl	local;
+	struct sockaddr_nl	peer;
+	__u32			seq;
+	__u32			dump;
+	int			proto;
+	FILE			*dump_fp;
+#define RTNL_HANDLE_F_LISTEN_ALL_NSID		0x01
+#define RTNL_HANDLE_F_SUPPRESS_NLERR		0x02
+#define RTNL_HANDLE_F_STRICT_CHK		0x04
+	int			flags;
+};
+
+#define NLMSG_TAIL(nmsg) \
+	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
+
+typedef int (*nl_ext_ack_fn_t)(const char *errmsg, uint32_t off,
+			       const struct nlmsghdr *inner_nlh);
+
+int rtnl_open(struct rtnl_handle *rth, unsigned int subscriptions)
+	      __attribute__((warn_unused_result));
+void rtnl_close(struct rtnl_handle *rth);
+int rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
+	      struct nlmsghdr **answer)
+	      __attribute__((warn_unused_result));
+
+int addattr(struct nlmsghdr *n, int maxlen, int type);
+int addattr8(struct nlmsghdr *n, int maxlen, int type, __u8 data);
+int addattr16(struct nlmsghdr *n, int maxlen, int type, __u16 data);
+int addattr32(struct nlmsghdr *n, int maxlen, int type, __u32 data);
+int addattr64(struct nlmsghdr *n, int maxlen, int type, __u64 data);
+int addattrstrz(struct nlmsghdr *n, int maxlen, int type, const char *data);
+int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void *data, int alen);
+int addraw_l(struct nlmsghdr *n, int maxlen, const void *data, int len);
+struct rtattr *addattr_nest(struct nlmsghdr *n, int maxlen, int type);
+int addattr_nest_end(struct nlmsghdr *n, struct rtattr *nest);
+#endif /* NETLINK_HELPERS_H */



