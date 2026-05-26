Return-Path: <stable+bounces-254382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFQVKpa9FWrYZgcAu9opvQ
	(envelope-from <stable+bounces-254382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:34:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92B5D8D4F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EE793038A4C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AEE1C6FF5;
	Tue, 26 May 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag/vMndQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00301ADFE4
	for <stable@vger.kernel.org>; Tue, 26 May 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808705; cv=none; b=c00ui4LPW0Iw1xLdN8dvIyUGeqIIXESBwhjWg8O4LqMlHrYuGArkNYmw27WtBCyNlD+jfjbhFSLLPDqIxkuh+7Y36J6PJo43cBMTbz/L0ZrCAv9foUG2XrHhl0kcegF0ozLv4lbtaiYKW2iAiKQnkoUefNCEwWFvzxPHjCK6ppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808705; c=relaxed/simple;
	bh=YdMB1LtyLqIriHtc7C7EYyISywkT2D2MpqY0VJfRR9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgJxqggIeP5FRTVnGXM/dtJd4zgBadZ/Xo2/RcWViO3NrQOSjlR+yx1vVGYvH92Uq+P42c/ddkqwZ5IlvFIksm4nYPXX2ek59UwISbnbPlI5reOFGGm4EmUhLQIOW6SbNIsUmW1NaIfZNF8QjOpD4BDszYQ+fLmh4u3c0D3CngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag/vMndQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d734223e4so6795196f8f.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779808702; x=1780413502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQeWuKcJdaKGP0co6PsxQWNihwyuFZGEvhAS+cv/Pqc=;
        b=Ag/vMndQ3m9ylA9teCUFtA4BXrRYoTUVYyxvrSW/XFYHWXIcftooR5fBPpaZG/wSuR
         ztbvP4nvyO99aaBRq6fQ0UjsH2cy9GopL8QakD5+gnUyK6B511QwUXrDsy2E/ilQgjf4
         z185bWiRtKLq+BUA8N5ncGYXqLoBUG/+8d2ePXIimUR7ojk/eiPe6crtCuIi8rU1lN+U
         Y1LwRG4OrWLbxTXBUuX6UgByFz6YEpamLm+ajPVyMAyPL23O+UYtE5PEWCb/0nu6ZoLE
         IDIk0N8p2lKFOkq8rn56KKFIEaqPLBPQOuqV8CX5C029Abd2QGRUdakuWFhSuyf4Iw5L
         G85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808702; x=1780413502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQeWuKcJdaKGP0co6PsxQWNihwyuFZGEvhAS+cv/Pqc=;
        b=prqWYmhK38fG1fENGl/V8/Q9L08mD+XdjYJR6EYKEaXLtpEeOhtS2bSmpzUY7zFyOr
         r+Ew3FTErbAjegoYrN27SwTkjB5ol2VA3Zw4jr6+7Y2JRP4hary3FwdP3M90IxX5umuB
         T/0CntNu2AOKPAN/cOMTg9WoMmAbGfPrKWFd+Qrv62a0ncbZnSaNM5+VRA0Hrew5+XkE
         ECcljf8cPLdxW6j2QAODnudmm2dmLGl7tMf/xrhQIeyxu2lovd58v0NiJYVGiWM8z9/A
         nYk23RqUCH2TU+vfWMd7UQYmmybMXSBcRJvuWHTBWhGToIChJOnxr84Jsr3zf473OigY
         7yvw==
X-Forwarded-Encrypted: i=1; AFNElJ8HhEimj1t0Pp8A+Iam4u/ntCnAkZ26OJZl2zJnGbWZjwE6IOxSnbJMedkSGSDrus5K5lOPhaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2Ga/rO5LJX9SOxbklHtfwQ3+bgRq9bM/WNAIVe9ARl8IEGHx
	cdCDRJD951BguqmaXuXiGZYsIUbkfw8mlW6mnlR4iOt/aBHaxMd2cU7X
X-Gm-Gg: Acq92OFUKLGitx3WrabiZAxMCpcOHHtWPQxDtD0h7H++ipdMCkn++lipK8cPCkW/KHm
	ADhmbBwwGenkABE46qpUl69KkT3kHDPGzH/YKQkb1tuiGSPi5qjmVFuJx8OtC+C7hO9ahsJF/EL
	nVh+VTXqqrOT5jkN8MI7AkVFYd09/5PFa5lBAw7rfFjPjf4wsVAGPL4R1TMK3vHSLN34YNV2MfH
	PAogkuf9yZfvulpd/Nxzf8UtZfU/HXv7UL6uEp7JPcEn2Wz1c8kceQQnwpnAorFlzJ9IQY8HngG
	gA7lQlY/i+aPbNEHfTDGvbXZ/VvoLuJgfsEVAH+8rjyvzBuFBg5XxstkdeJGW/juHuB8jJnKX64
	h55C2S9ONBltAhcWOkn8A0i3sD4FItpZ7qTxs6SNVu8ReKvtkQTQJLcjcNfpCRwec9CRBbQDQKD
	7oMHwZyd5gkrYXUdQqaKmlW9U0KV9Q5DcJSFLPKCeXt6gXO5lWeek2O4mDKlLkAWfES03YXMSnX
	ao=
X-Received: by 2002:a05:6000:18af:b0:45e:9304:a4c3 with SMTP id ffacd0b85a97d-45eb333aa31mr28185448f8f.19.1779808701891;
        Tue, 26 May 2026 08:18:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cd1780sm38974606f8f.16.2026.05.26.08.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:18:21 -0700 (PDT)
Date: Tue, 26 May 2026 16:18:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Kacper Kokot <kacper.kokot.44@gmail.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
 <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] netfilter: TCPMSS: fix dropped packets when MSS option
 is unaligned
Message-ID: <20260526161820.63c56e56@pumpkin>
In-Reply-To: <202605261527.v5NoRvES-lkp@intel.com>
References: <20260525201116.407338-2-kacper.kokot.44@gmail.com>
	<202605261527.v5NoRvES-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254382-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,git-scm.com:url,01.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E92B5D8D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 15:50:00 +0200
kernel test robot <lkp@intel.com> wrote:

> Hi Kacper,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on nf-next/main]
> [also build test WARNING on netfilter-nf/main linus/master v6.16-rc1 next-20260525]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kacper-Kokot/netfilter-TCPMSS-fix-dropped-packets-when-MSS-option-is-unaligned/20260526-041308
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git main
> patch link:    https://lore.kernel.org/r/20260525201116.407338-2-kacper.kokot.44%40gmail.com
> patch subject: [PATCH] netfilter: TCPMSS: fix dropped packets when MSS option is unaligned
> config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260526/202605261527.v5NoRvES-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260526/202605261527.v5NoRvES-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605261527.v5NoRvES-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    net/netfilter/xt_TCPMSS.c: In function 'tcpmss_mangle_packet':
> >> net/netfilter/xt_TCPMSS.c:140:66: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]  
>      140 |                         if (((char *)&opt[i + 2] - (char *)tcph) & 0x1 != 0) {
>          |                                                                  ^

and, of course, the code works fine because 0x1 != 0 is 1.

K (or maybe R) said that with hindsight they should have corrected the
priority of & and | when they added && and || and just fixed all the
existing code so it still worked.

-- David

> 
> 
> vim +140 net/netfilter/xt_TCPMSS.c
> 
>     69	
>     70	static int
>     71	tcpmss_mangle_packet(struct sk_buff *skb,
>     72			     const struct xt_action_param *par,
>     73			     unsigned int family,
>     74			     unsigned int tcphoff,
>     75			     unsigned int minlen)
>     76	{
>     77		const struct xt_tcpmss_info *info = par->targinfo;
>     78		struct tcphdr *tcph;
>     79		int len, tcp_hdrlen;
>     80		unsigned int i;
>     81		__be16 oldval;
>     82		u16 newmss;
>     83		u8 *opt;
>     84	
>     85		/* This is a fragment, no TCP header is available */
>     86		if (par->fragoff != 0)
>     87			return 0;
>     88	
>     89		if (skb_ensure_writable(skb, skb->len))
>     90			return -1;
>     91	
>     92		len = skb->len - tcphoff;
>     93		if (len < (int)sizeof(struct tcphdr))
>     94			return -1;
>     95	
>     96		tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
>     97		tcp_hdrlen = tcph->doff * 4;
>     98	
>     99		if (len < tcp_hdrlen || tcp_hdrlen < sizeof(struct tcphdr))
>    100			return -1;
>    101	
>    102		if (info->mss == XT_TCPMSS_CLAMP_PMTU) {
>    103			struct net *net = xt_net(par);
>    104			unsigned int in_mtu = tcpmss_reverse_mtu(net, skb, family);
>    105			unsigned int min_mtu = min(dst_mtu(skb_dst(skb)), in_mtu);
>    106	
>    107			if (min_mtu <= minlen) {
>    108				net_err_ratelimited("unknown or invalid path-MTU (%u)\n",
>    109						    min_mtu);
>    110				return -1;
>    111			}
>    112			newmss = min_mtu - minlen;
>    113		} else
>    114			newmss = info->mss;
>    115	
>    116		opt = (u_int8_t *)tcph;
>    117		for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen(opt, i)) {
>    118			if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
>    119				u_int16_t oldmss;
>    120				u16 csum_oldmss, csum_newmss;
>    121	
>    122				oldmss = (opt[i+2] << 8) | opt[i+3];
>    123	
>    124				/* Never increase MSS, even when setting it, as
>    125				 * doing so results in problems for hosts that rely
>    126				 * on MSS being set correctly.
>    127				 */
>    128				if (oldmss <= newmss)
>    129					return 0;
>    130	
>    131				opt[i+2] = (newmss & 0xff00) >> 8;
>    132				opt[i+3] = newmss & 0x00ff;
>    133	
>    134				csum_oldmss = htons(oldmss);
>    135				csum_newmss = htons(newmss);
>    136	
>    137				/* MSS may be unaligned; fix up the incremental checksum
>    138				 * to avoid an invalid checksum and a dropped packet.
>    139				 */
>  > 140				if (((char *)&opt[i + 2] - (char *)tcph) & 0x1 != 0) {  
>    141					csum_oldmss = swab16(csum_oldmss);
>    142					csum_newmss = swab16(csum_newmss);
>    143				}
>    144	
>    145				inet_proto_csum_replace2(&tcph->check, skb,
>    146							 csum_oldmss, csum_newmss,
>    147							 false);
>    148				return 0;
>    149			}
>    150		}
>    151	
>    152		/* There is data after the header so the option can't be added
>    153		 * without moving it, and doing so may make the SYN packet
>    154		 * itself too large. Accept the packet unmodified instead.
>    155		 */
>    156		if (len > tcp_hdrlen)
>    157			return 0;
>    158	
>    159		/* tcph->doff has 4 bits, do not wrap it to 0 */
>    160		if (tcp_hdrlen >= 15 * 4)
>    161			return 0;
>    162	
>    163		/*
>    164		 * MSS Option not found ?! add it..
>    165		 */
>    166		if (skb_tailroom(skb) < TCPOLEN_MSS) {
>    167			if (pskb_expand_head(skb, 0,
>    168					     TCPOLEN_MSS - skb_tailroom(skb),
>    169					     GFP_ATOMIC))
>    170				return -1;
>    171			tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
>    172		}
>    173	
>    174		skb_put(skb, TCPOLEN_MSS);
>    175	
>    176		/*
>    177		 * IPv4: RFC 1122 states "If an MSS option is not received at
>    178		 * connection setup, TCP MUST assume a default send MSS of 536".
>    179		 * IPv6: RFC 2460 states IPv6 has a minimum MTU of 1280 and a minimum
>    180		 * length IPv6 header of 60, ergo the default MSS value is 1220
>    181		 * Since no MSS was provided, we must use the default values
>    182		 */
>    183		if (xt_family(par) == NFPROTO_IPV4)
>    184			newmss = min(newmss, (u16)536);
>    185		else
>    186			newmss = min(newmss, (u16)1220);
>    187	
>    188		opt = (u_int8_t *)tcph + sizeof(struct tcphdr);
>    189		memmove(opt + TCPOLEN_MSS, opt, len - sizeof(struct tcphdr));
>    190	
>    191		inet_proto_csum_replace2(&tcph->check, skb,
>    192					 htons(len), htons(len + TCPOLEN_MSS), true);
>    193		opt[0] = TCPOPT_MSS;
>    194		opt[1] = TCPOLEN_MSS;
>    195		opt[2] = (newmss & 0xff00) >> 8;
>    196		opt[3] = newmss & 0x00ff;
>    197	
>    198		inet_proto_csum_replace4(&tcph->check, skb, 0, *((__be32 *)opt), false);
>    199	
>    200		oldval = ((__be16 *)tcph)[6];
>    201		tcph->doff += TCPOLEN_MSS/4;
>    202		inet_proto_csum_replace2(&tcph->check, skb,
>    203					 oldval, ((__be16 *)tcph)[6], false);
>    204		return TCPOLEN_MSS;
>    205	}
>    206	
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


