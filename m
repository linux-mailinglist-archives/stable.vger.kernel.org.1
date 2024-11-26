Return-Path: <stable+bounces-95497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882609D9256
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F212837D0
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2C31898FC;
	Tue, 26 Nov 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZopPgucA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A329539A
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605721; cv=none; b=nKiDRWIn9LPDLfr/tud//ZjKHF4qnXAr5wcW+pHT2Rm0qPhvBmxNFaiXUl2Y63vuMjGy+ZLmI5/8dxs6+LJNifcVQc+MvDFrjE83nPGE6hxWbkS3NL4jgeL8LOPJe9bdW3JzItj2WlK9HxklhV+3fpiK4TGhO482B/cYLIfttFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605721; c=relaxed/simple;
	bh=ZYVXtTB1eaT6BWV9aScRtbomQY3WCvay0fEMwQFuXis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjUKypJk4rQc/tRd/DRMjsflD/dc0k9vaS0+1eBEmcbsOvRd4nXTtw8n3phPSibsN8R+OQY0GD5jxU59tqOtEQkOZTPlzUV6Tx5JTeytnQIU3rZba3wnB6hP5qMzlU6yREvVgb5ZIK9vORnVL/BSUyb8pdctVP2lnFmMG134MEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZopPgucA; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-53da209492cso6671381e87.3
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732605715; x=1733210515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGFb6IuPspb8y+u0QPNYy/+Xky+6ZhDsptOVaVx6dcU=;
        b=ZopPgucA0h+3v/1nnPtIBSZzT1+N8A1WNfgqhB1AFGjb5HXyIQjxM9beBFGoxEepj/
         YFPgmrUJzWL5eUnK17Zhza2DAfLnqlTq3pRFeDBd/VsXP83PkV2mDPaSkJi9lA4lPEjk
         VrD0E4Hf/I33n6VrUS0/Fe99zkOR/dWWueUrTGfm2nucoUaZ+zAIDMbv7mzm2prp/VQa
         euQwrzaZbMhLaHYlIiMX3b3uUqksCgjO5Z1a5tPnO/NaHjjfJ8oNfI3T/l/3KN7IqY7Y
         xPkCouN88L5nXMeyApp1UA0hnq9Nc3EsAvqfFdc2sMuyBSQYixcAy9kRrOzhRHADVdpC
         +Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732605715; x=1733210515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGFb6IuPspb8y+u0QPNYy/+Xky+6ZhDsptOVaVx6dcU=;
        b=qudy0GyarWVHfzUpJj/9Z0Lr8jxOA9V01iB3ojwlzhNKp649VUL+aasoCReRCkgCEL
         7nHg97Cpydsnx94QqEw6PByTFpKiuZfVxNaNFzsQ0MQfE4dUYwfXx/oDJ3t0S4BUZtAR
         aZRP1YaZdrmcepug7WNbPqX+o5OumX8D6cBzjpL7Lghd3MemCwWjsTQNpaYE4Kqotk/h
         l6c/ZpFjQFE658mY40oaqZ8L9PVC0PZFvULb5bwErr8XjZlSrJy5fXOcwB/RapHqaH1u
         Jbc9XdHVgo6jkNzQ3pY5FbJt/p7zwO0MUP3r/hMKjXpgeKu2WGh6IlzWT/3BztFeCnf4
         fjvQ==
X-Gm-Message-State: AOJu0YyriSGKmy8CxL0BUUO0z4aF+RtDnbvjyhH2UwiV/B/HtBi8no8n
	D285YZV0cP5uRyJMnQRAyczBiayxvnvJ326EfUO3UiR8dVfm2WLcN7NhlI2uvM/A+ifcGIG/naS
	SAa3hZucGGD0=
X-Gm-Gg: ASbGncuAkIliIt1Zatv6lKDK/wASKn7QO1upRs6YXhKxzaQ9N0Bb4XG6gB4QuNrC3hp
	0FBzamn/FZ691lbrDDUunw11hRgIxRvA/pbTcT/b7INLQb29YzcX88pM12A7cOJVi5Q/ZqWCmtl
	5LpG7+HFMfKof4nnRlrO+lVrnalPgxKE6+CPm5lTzvvuDs/ODJIhvRpoudLdGBloa8byOGa71Gb
	7cLQK+mbMUW6KqSJMbpOVXiwWSJsQssVkv1cML/fFI2+abJPPk=
X-Google-Smtp-Source: AGHT+IHOI2XR181jSk3b5GOwEYrLUguvirSm76qfEiwI1EwUENqx8mcve1g2bXMWalhDcBUCiYPnjQ==
X-Received: by 2002:a05:6512:4012:b0:53d:ecda:24a7 with SMTP id 2adb3069b0e04-53decda2523mr453475e87.17.1732605714750;
        Mon, 25 Nov 2024 23:21:54 -0800 (PST)
Received: from localhost ([2401:e180:8891:cc8b:6df8:da33:1f62:8cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc149c2sm77792335ad.172.2024.11.25.23.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:21:54 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hou Tao <houtao1@huawei.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.6 1/8] selftests/bpf: Add netlink helper library
Date: Tue, 26 Nov 2024 15:21:23 +0800
Message-ID: <20241126072137.823699-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126072137.823699-1-shung-hsi.yu@suse.com>
References: <20241126072137.823699-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 51f1892b5289f0c09745d3bedb36493555d6d90c ]

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
---
 tools/testing/selftests/bpf/Makefile          |  19 +-
 tools/testing/selftests/bpf/netlink_helpers.c | 358 ++++++++++++++++++
 tools/testing/selftests/bpf/netlink_helpers.h |  46 +++
 3 files changed, 418 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f5a3a84fac95..4e569d155da5 100644
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
diff --git a/tools/testing/selftests/bpf/netlink_helpers.c b/tools/testing/selftests/bpf/netlink_helpers.c
new file mode 100644
index 000000000000..caf36eb1d032
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
diff --git a/tools/testing/selftests/bpf/netlink_helpers.h b/tools/testing/selftests/bpf/netlink_helpers.h
new file mode 100644
index 000000000000..68116818a47e
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
-- 
2.47.0


