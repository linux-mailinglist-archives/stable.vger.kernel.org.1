Return-Path: <stable+bounces-219140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP39DJxknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4F01910BD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 222503067A3C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB87E296BD1;
	Wed, 25 Feb 2026 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gEYi7NQ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3329992A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988110; cv=none; b=IAb2FaZ+p6Y8+41sRjgtqQHLR13Jd5YUFTwTbEvTEW99SDgOSJYqJh2+lavzW0MoXdbwt4VBptiLLEQPTg3Yy2LIYBS1L7cZAtHLg8iIYE+3LwzBqH0wyT+6tDINU0RrdKPHh8Z22Vi6g6WwykgsGqmarLn9Qy2UsDaes1q68zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988110; c=relaxed/simple;
	bh=SN6MHY1jameQTlrMyvLqUqIw24MEfDXyq5X1C/uzWWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkN6/QTK9MaGmqp/8u+bRFYTAsLEEE2lvr2rlihLJnLWZ72ATdWOMT3hCgrcq7Gib0N4w2/LOKuvXhK5h3qJ4/HSxaf+JGnl9TWjoOKF6c6VhqZ/qu37PS7f5NmsH4t9Jbi8uOJ0mdKQTdkQ7vCbg0rB1FBeGi5pGuCfQ966GD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gEYi7NQ3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806bf39419so2555885e9.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988107; x=1772592907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF1uMfGcZr2Wm15/OZnM6tFK9JXhRInsgsYGU/gKLNI=;
        b=gEYi7NQ3+ILmc1e7DFRFGtgKg9i6zokBLyAIvEwG62oDI8n7HxrkkLuLxBaIk0n2Ws
         lE5Px2T4GOQtmJn3jsVy9Di24YB3UW4Q8T52QWd4gE0DKEeGS9uUWsqfiWzR279hg7W2
         rk7GFBLSoXmEYOMHx/sNIC/VEiVLt3TiGiZ02X5Bp1BkYfJY0SSA9TjZgXf6helcsLB4
         +BjXlTv6dHJz9Y+bj04NVqZSwlY1enxGWPm99pM/DyRu5VN4GQ7dSZ2OVSiyfOG1uB0t
         raFukDkDjXtTV4b0R6DAFZ+HTiiWAQWya2pXDFjSdjHo3xaP84S6dfi8GAawI3aHsq3W
         cyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988107; x=1772592907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GF1uMfGcZr2Wm15/OZnM6tFK9JXhRInsgsYGU/gKLNI=;
        b=gvEQfm0J0PWVFiXdYCtJWqQB9uKWK+NU5en5aGDNhODd7UTQU/OSDZ3/BEOnShKHg4
         nBixTsgjuzAT+D0DQKUaUVoby6XGxhFpD2W2yc2K6I9vQoYqlXe7stpdlh69rX/QIYrb
         vPUFXOVKkTcEyN0oj+Hl3jVD5hpBSqv6WnCv5gyv/bXpf+NVhXcU3st3TZPwiiFuKDc0
         5frAuteY8DCUN+1nbUsvBCp+/nHS7vqc8xuQ8yO6OuA2AL7Y5sRbEIhorooEOZ8Q1XDi
         86M+NdieUCSuvaLq7iXpSBMQXCfnNdoOEqbPUDZKBDcIDC1pE8TRCW7Bdpk9haSoGeOF
         FkLg==
X-Gm-Message-State: AOJu0Yw7iMF/Y6gAAB6yJaqm8isq/53Q5kdU6RhnLgjgOE0K3y/Dejjh
	66b9AN+wv1y4apNF6HwC1iFcc4XFqPbOwZ622lgBiCJ0nd/be+3/3viR5EBZ5/stzh7NZco7Amv
	wibJu
X-Gm-Gg: ATEYQzzbJ0N4apkRNtGT1Ntw4nCcvHc+Xi8F8vdt+9vTtoky9BUFJsL6rKKKsZSDadU
	AJv+Szcn7s8/1L8BnvczCbhPVZMoo4cmFuwohYroDrt6stR/a9ed5Jn6XsaTWP3/YbujbUb1qqq
	yihigqKNGMphbOG3A9wldeX9XNP70UkkImYZXdL51yXk2JVTekfPM9LmUskrAeztQV5/QCrdvNP
	NbAZQ6sQ+YQGiScHYDwzyRXzKfdcea4TMLVIDqhBuyIEIQ2xvmmcYdRu90eNIeu2o1JIsnkWoij
	PGU7NeYJk6GU50kqqKvj4dwqyElZMKRJBMydC0123ff3+FkEP2KTx56ofBvhYG4wusnGSbuxA6Q
	kYS/NQQ3Of/1QzsWNzRjAS5m91hf0j1+zu1m3Lu+vr+HxLljQ4JtPi4c4bwpTLQeN5UmTKJDDiT
	VLH11whrNkNu7NCfFQxyHxsD8xkA==
X-Received: by 2002:a05:600c:1551:b0:483:a2b0:d210 with SMTP id 5b1f17b1804b1-483bd726f78mr34379465e9.7.1771988106668;
        Tue, 24 Feb 2026 18:55:06 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5db00sm163892575ad.23.2026.02.24.18.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:06 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.6 01/11] selftests/bpf: Add traffic monitor functions.
Date: Wed, 25 Feb 2026 10:54:39 +0800
Message-ID: <20260225025454.17398-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225025454.17398-1-shung-hsi.yu@suse.com>
References: <20260225025454.17398-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,fomichev.me,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219140-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.944];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tcpdump.org:url,fomichev.me:email]
X-Rspamd-Queue-Id: 6B4F01910BD
X-Rspamd-Action: no action

From: Kui-Feng Lee <thinker.li@gmail.com>

commit f52403b6bfea6994b017c58367aee9acdb9d9fd4 upstream.

Add functions that capture packets and print log in the background. They
are supposed to be used for debugging flaky network test cases. A monitored
test case should call traffic_monitor_start() to start a thread to capture
packets in the background for a given namespace and call
traffic_monitor_stop() to stop capturing. (Or, option '-m' implemented by
the later patches.)

    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 68, SYN
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 60, SYN, ACK
    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 60, ACK
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, ACK
    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 52, FIN, ACK
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, RST, ACK
    Packet file: packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log
    #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK

The above is the output of an example. It shows the packets of a connection
and the name of the file that contains captured packets in the directory
/tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.

This feature only works if libpcap is available. (Could be found by pkg-config)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Link: https://lore.kernel.org/r/20240815053254.470944-2-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: c047e0e0e435 ("selftests/bpf: Optionally open a dedicated namespace to run test in it")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +
 tools/testing/selftests/bpf/network_helpers.c | 454 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  19 +
 3 files changed, 477 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4e569d155da5..2eeb51b13249 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -33,6 +33,10 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += -lelf -lz -lrt -lpthread
 
+LDLIBS += $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
+CFLAGS += $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null)
+CFLAGS += $(shell $(PKG_CONFIG) --exists libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
+
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
 CFLAGS += -Wno-unused-command-line-argument
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 0877b60ec81f..0c09324bc111 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -11,16 +11,30 @@
 #include <arpa/inet.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/eventfd.h>
 
 #include <linux/err.h>
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/limits.h>
 
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <netinet/tcp.h>
+#include <net/if.h>
+
 #include "bpf_util.h"
 #include "network_helpers.h"
 #include "test_progs.h"
 
+#ifdef TRAFFIC_MONITOR
+/* Prevent pcap.h from including pcap/bpf.h and causing conflicts */
+#define PCAP_DONT_INCLUDE_PCAP_BPF_H 1
+#include <pcap/pcap.h>
+#include <pcap/dlt.h>
+#endif
+
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
@@ -465,3 +479,443 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
+
+#ifdef TRAFFIC_MONITOR
+struct tmonitor_ctx {
+	pcap_t *pcap;
+	pcap_dumper_t *dumper;
+	pthread_t thread;
+	int wake_fd;
+
+	volatile bool done;
+	char pkt_fname[PATH_MAX];
+	int pcap_fd;
+};
+
+/* Is this packet captured with a Ethernet protocol type? */
+static bool is_ethernet(const u_char *packet)
+{
+	u16 arphdr_type;
+
+	memcpy(&arphdr_type, packet + 8, 2);
+	arphdr_type = ntohs(arphdr_type);
+
+	/* Except the following cases, the protocol type contains the
+	 * Ethernet protocol type for the packet.
+	 *
+	 * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
+	 */
+	switch (arphdr_type) {
+	case 770: /* ARPHRD_FRAD */
+	case 778: /* ARPHDR_IPGRE */
+	case 803: /* ARPHRD_IEEE80211_RADIOTAP */
+		printf("Packet captured: arphdr_type=%d\n", arphdr_type);
+		return false;
+	}
+	return true;
+}
+
+static const char * const pkt_types[] = {
+	"In",
+	"B",			/* Broadcast */
+	"M",			/* Multicast */
+	"C",			/* Captured with the promiscuous mode */
+	"Out",
+};
+
+static const char *pkt_type_str(u16 pkt_type)
+{
+	if (pkt_type < ARRAY_SIZE(pkt_types))
+		return pkt_types[pkt_type];
+	return "Unknown";
+}
+
+/* Show the information of the transport layer in the packet */
+static void show_transport(const u_char *packet, u16 len, u32 ifindex,
+			   const char *src_addr, const char *dst_addr,
+			   u16 proto, bool ipv6, u8 pkt_type)
+{
+	char *ifname, _ifname[IF_NAMESIZE];
+	const char *transport_str;
+	u16 src_port, dst_port;
+	struct udphdr *udp;
+	struct tcphdr *tcp;
+
+	ifname = if_indextoname(ifindex, _ifname);
+	if (!ifname) {
+		snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
+		ifname = _ifname;
+	}
+
+	if (proto == IPPROTO_UDP) {
+		udp = (struct udphdr *)packet;
+		src_port = ntohs(udp->source);
+		dst_port = ntohs(udp->dest);
+		transport_str = "UDP";
+	} else if (proto == IPPROTO_TCP) {
+		tcp = (struct tcphdr *)packet;
+		src_port = ntohs(tcp->source);
+		dst_port = ntohs(tcp->dest);
+		transport_str = "TCP";
+	} else if (proto == IPPROTO_ICMP) {
+		printf("%-7s %-3s IPv4 %s > %s: ICMP, length %d, type %d, code %d\n",
+		       ifname, pkt_type_str(pkt_type), src_addr, dst_addr, len,
+		       packet[0], packet[1]);
+		return;
+	} else if (proto == IPPROTO_ICMPV6) {
+		printf("%-7s %-3s IPv6 %s > %s: ICMPv6, length %d, type %d, code %d\n",
+		       ifname, pkt_type_str(pkt_type), src_addr, dst_addr, len,
+		       packet[0], packet[1]);
+		return;
+	} else {
+		printf("%-7s %-3s %s %s > %s: protocol %d\n",
+		       ifname, pkt_type_str(pkt_type), ipv6 ? "IPv6" : "IPv4",
+		       src_addr, dst_addr, proto);
+		return;
+	}
+
+	/* TCP or UDP*/
+
+	flockfile(stdout);
+	if (ipv6)
+		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d",
+		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
+		       dst_addr, dst_port, transport_str, len);
+	else
+		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d",
+		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
+		       dst_addr, dst_port, transport_str, len);
+
+	if (proto == IPPROTO_TCP) {
+		if (tcp->fin)
+			printf(", FIN");
+		if (tcp->syn)
+			printf(", SYN");
+		if (tcp->rst)
+			printf(", RST");
+		if (tcp->ack)
+			printf(", ACK");
+	}
+
+	printf("\n");
+	funlockfile(stdout);
+}
+
+static void show_ipv6_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
+{
+	char src_buf[INET6_ADDRSTRLEN], dst_buf[INET6_ADDRSTRLEN];
+	struct ipv6hdr *pkt = (struct ipv6hdr *)packet;
+	const char *src, *dst;
+	u_char proto;
+
+	src = inet_ntop(AF_INET6, &pkt->saddr, src_buf, sizeof(src_buf));
+	if (!src)
+		src = "<invalid>";
+	dst = inet_ntop(AF_INET6, &pkt->daddr, dst_buf, sizeof(dst_buf));
+	if (!dst)
+		dst = "<invalid>";
+	proto = pkt->nexthdr;
+	show_transport(packet + sizeof(struct ipv6hdr),
+		       ntohs(pkt->payload_len),
+		       ifindex, src, dst, proto, true, pkt_type);
+}
+
+static void show_ipv4_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
+{
+	char src_buf[INET_ADDRSTRLEN], dst_buf[INET_ADDRSTRLEN];
+	struct iphdr *pkt = (struct iphdr *)packet;
+	const char *src, *dst;
+	u_char proto;
+
+	src = inet_ntop(AF_INET, &pkt->saddr, src_buf, sizeof(src_buf));
+	if (!src)
+		src = "<invalid>";
+	dst = inet_ntop(AF_INET, &pkt->daddr, dst_buf, sizeof(dst_buf));
+	if (!dst)
+		dst = "<invalid>";
+	proto = pkt->protocol;
+	show_transport(packet + sizeof(struct iphdr),
+		       ntohs(pkt->tot_len),
+		       ifindex, src, dst, proto, false, pkt_type);
+}
+
+static void *traffic_monitor_thread(void *arg)
+{
+	char *ifname, _ifname[IF_NAMESIZE];
+	const u_char *packet, *payload;
+	struct tmonitor_ctx *ctx = arg;
+	pcap_dumper_t *dumper = ctx->dumper;
+	int fd = ctx->pcap_fd, nfds, r;
+	int wake_fd = ctx->wake_fd;
+	struct pcap_pkthdr header;
+	pcap_t *pcap = ctx->pcap;
+	u32 ifindex;
+	fd_set fds;
+	u16 proto;
+	u8 ptype;
+
+	nfds = (fd > wake_fd ? fd : wake_fd) + 1;
+	FD_ZERO(&fds);
+
+	while (!ctx->done) {
+		FD_SET(fd, &fds);
+		FD_SET(wake_fd, &fds);
+		r = select(nfds, &fds, NULL, NULL, NULL);
+		if (!r)
+			continue;
+		if (r < 0) {
+			if (errno == EINTR)
+				continue;
+			log_err("Fail to select on pcap fd and wake fd");
+			break;
+		}
+
+		/* This instance of pcap is non-blocking */
+		packet = pcap_next(pcap, &header);
+		if (!packet)
+			continue;
+
+		/* According to the man page of pcap_dump(), first argument
+		 * is the pcap_dumper_t pointer even it's argument type is
+		 * u_char *.
+		 */
+		pcap_dump((u_char *)dumper, &header, packet);
+
+		/* Not sure what other types of packets look like. Here, we
+		 * parse only Ethernet and compatible packets.
+		 */
+		if (!is_ethernet(packet))
+			continue;
+
+		/* Skip SLL2 header
+		 * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
+		 *
+		 * Although the document doesn't mention that, the payload
+		 * doesn't include the Ethernet header. The payload starts
+		 * from the first byte of the network layer header.
+		 */
+		payload = packet + 20;
+
+		memcpy(&proto, packet, 2);
+		proto = ntohs(proto);
+		memcpy(&ifindex, packet + 4, 4);
+		ifindex = ntohl(ifindex);
+		ptype = packet[10];
+
+		if (proto == ETH_P_IPV6) {
+			show_ipv6_packet(payload, ifindex, ptype);
+		} else if (proto == ETH_P_IP) {
+			show_ipv4_packet(payload, ifindex, ptype);
+		} else {
+			ifname = if_indextoname(ifindex, _ifname);
+			if (!ifname) {
+				snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
+				ifname = _ifname;
+			}
+
+			printf("%-7s %-3s Unknown network protocol type 0x%x\n",
+			       ifname, pkt_type_str(ptype), proto);
+		}
+	}
+
+	return NULL;
+}
+
+/* Prepare the pcap handle to capture packets.
+ *
+ * This pcap is non-blocking and immediate mode is enabled to receive
+ * captured packets as soon as possible.  The snaplen is set to 1024 bytes
+ * to limit the size of captured content. The format of the link-layer
+ * header is set to DLT_LINUX_SLL2 to enable handling various link-layer
+ * technologies.
+ */
+static pcap_t *traffic_monitor_prepare_pcap(void)
+{
+	char errbuf[PCAP_ERRBUF_SIZE];
+	pcap_t *pcap;
+	int r;
+
+	/* Listen on all NICs in the namespace */
+	pcap = pcap_create("any", errbuf);
+	if (!pcap) {
+		log_err("Failed to open pcap: %s", errbuf);
+		return NULL;
+	}
+	/* Limit the size of the packet (first N bytes) */
+	r = pcap_set_snaplen(pcap, 1024);
+	if (r) {
+		log_err("Failed to set snaplen: %s", pcap_geterr(pcap));
+		goto error;
+	}
+	/* To receive packets as fast as possible */
+	r = pcap_set_immediate_mode(pcap, 1);
+	if (r) {
+		log_err("Failed to set immediate mode: %s", pcap_geterr(pcap));
+		goto error;
+	}
+	r = pcap_setnonblock(pcap, 1, errbuf);
+	if (r) {
+		log_err("Failed to set nonblock: %s", errbuf);
+		goto error;
+	}
+	r = pcap_activate(pcap);
+	if (r) {
+		log_err("Failed to activate pcap: %s", pcap_geterr(pcap));
+		goto error;
+	}
+	/* Determine the format of the link-layer header */
+	r = pcap_set_datalink(pcap, DLT_LINUX_SLL2);
+	if (r) {
+		log_err("Failed to set datalink: %s", pcap_geterr(pcap));
+		goto error;
+	}
+
+	return pcap;
+error:
+	pcap_close(pcap);
+	return NULL;
+}
+
+static void encode_test_name(char *buf, size_t len, const char *test_name, const char *subtest_name)
+{
+	char *p;
+
+	if (subtest_name)
+		snprintf(buf, len, "%s__%s", test_name, subtest_name);
+	else
+		snprintf(buf, len, "%s", test_name);
+	while ((p = strchr(buf, '/')))
+		*p = '_';
+	while ((p = strchr(buf, ' ')))
+		*p = '_';
+}
+
+#define PCAP_DIR "/tmp/tmon_pcap"
+
+/* Start to monitor the network traffic in the given network namespace.
+ *
+ * netns: the name of the network namespace to monitor. If NULL, the
+ *        current network namespace is monitored.
+ * test_name: the name of the running test.
+ * subtest_name: the name of the running subtest if there is. It should be
+ *               NULL if it is not a subtest.
+ *
+ * This function will start a thread to capture packets going through NICs
+ * in the give network namespace.
+ */
+struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
+					   const char *subtest_name)
+{
+	struct nstoken *nstoken = NULL;
+	struct tmonitor_ctx *ctx;
+	char test_name_buf[64];
+	static int tmon_seq;
+	int r;
+
+	if (netns) {
+		nstoken = open_netns(netns);
+		if (!nstoken)
+			return NULL;
+	}
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx) {
+		log_err("Failed to malloc ctx");
+		goto fail_ctx;
+	}
+	memset(ctx, 0, sizeof(*ctx));
+
+	encode_test_name(test_name_buf, sizeof(test_name_buf), test_name, subtest_name);
+	snprintf(ctx->pkt_fname, sizeof(ctx->pkt_fname),
+		 PCAP_DIR "/packets-%d-%d-%s-%s.log", getpid(), tmon_seq++,
+		 test_name_buf, netns ? netns : "unknown");
+
+	r = mkdir(PCAP_DIR, 0755);
+	if (r && errno != EEXIST) {
+		log_err("Failed to create " PCAP_DIR);
+		goto fail_pcap;
+	}
+
+	ctx->pcap = traffic_monitor_prepare_pcap();
+	if (!ctx->pcap)
+		goto fail_pcap;
+	ctx->pcap_fd = pcap_get_selectable_fd(ctx->pcap);
+	if (ctx->pcap_fd < 0) {
+		log_err("Failed to get pcap fd");
+		goto fail_dumper;
+	}
+
+	/* Create a packet file */
+	ctx->dumper = pcap_dump_open(ctx->pcap, ctx->pkt_fname);
+	if (!ctx->dumper) {
+		log_err("Failed to open pcap dump: %s", ctx->pkt_fname);
+		goto fail_dumper;
+	}
+
+	/* Create an eventfd to wake up the monitor thread */
+	ctx->wake_fd = eventfd(0, 0);
+	if (ctx->wake_fd < 0) {
+		log_err("Failed to create eventfd");
+		goto fail_eventfd;
+	}
+
+	r = pthread_create(&ctx->thread, NULL, traffic_monitor_thread, ctx);
+	if (r) {
+		log_err("Failed to create thread");
+		goto fail;
+	}
+
+	close_netns(nstoken);
+
+	return ctx;
+
+fail:
+	close(ctx->wake_fd);
+
+fail_eventfd:
+	pcap_dump_close(ctx->dumper);
+	unlink(ctx->pkt_fname);
+
+fail_dumper:
+	pcap_close(ctx->pcap);
+
+fail_pcap:
+	free(ctx);
+
+fail_ctx:
+	close_netns(nstoken);
+
+	return NULL;
+}
+
+static void traffic_monitor_release(struct tmonitor_ctx *ctx)
+{
+	pcap_close(ctx->pcap);
+	pcap_dump_close(ctx->dumper);
+
+	close(ctx->wake_fd);
+
+	free(ctx);
+}
+
+/* Stop the network traffic monitor.
+ *
+ * ctx: the context returned by traffic_monitor_start()
+ */
+void traffic_monitor_stop(struct tmonitor_ctx *ctx)
+{
+	__u64 w = 1;
+
+	if (!ctx)
+		return;
+
+	/* Stop the monitor thread */
+	ctx->done = true;
+	/* Wake up the background thread. */
+	write(ctx->wake_fd, &w, sizeof(w));
+	pthread_join(ctx->thread, NULL);
+
+	printf("Packet file: %s\n", strrchr(ctx->pkt_fname, '/') + 1);
+
+	traffic_monitor_release(ctx);
+}
+#endif /* TRAFFIC_MONITOR */
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 5eccc67d1a99..3a046dc42c34 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -70,4 +70,23 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+
+struct tmonitor_ctx;
+
+#ifdef TRAFFIC_MONITOR
+struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
+					   const char *subtest_name);
+void traffic_monitor_stop(struct tmonitor_ctx *ctx);
+#else
+static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
+							 const char *subtest_name)
+{
+	return NULL;
+}
+
+static inline void traffic_monitor_stop(struct tmonitor_ctx *ctx)
+{
+}
+#endif
+
 #endif
-- 
2.53.0


