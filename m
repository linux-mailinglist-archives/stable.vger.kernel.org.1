Return-Path: <stable+bounces-227823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 72fbOGawv2mr7gMAu9opvQ
	(envelope-from <stable+bounces-227823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 10:03:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C92E8B06
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 10:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00452300EA8B
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6FC23C50A;
	Sun, 22 Mar 2026 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br5Xbk2F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88257224D6
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774170209; cv=none; b=YGMyKtr89FRdKyxFBhX4XOyU8uBCThYPGjxnvkiJOENRqjfnswBTqihaCzipRKkoLEy+VBra2w6iXg2TIiVS/7EXNEVLa5FJfFWmdOKu3kDlzG7KX5hK3xg4a+gmk67u/AasEgjcsuZNwMnF407nWaH6oCjITM+qGkIRLqBDKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774170209; c=relaxed/simple;
	bh=ZFnUsfbBwMlfUeVLtRh8A2xhphNQ34BK/UKQ1BxZg8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4Kw7XTYHGnwyhlkmJoIXjni3wGgsNclh9m66N22nG2xRP9ezuE2vfODTyRrkooyaUD5TLFtIWOcHQm7C92L0nkra5/+BVDdRHRLGWYnIAEgKmyMamkTslCtdzhWQMbsjNoVgyrCBJ2HustgAIAWOCSEXLMwnXxZnL8Wbzthlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br5Xbk2F; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1939385a91.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774170208; x=1774775008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpycnvHPDHkJbsXhHVIz+yo1HEECgH0T9yQbtY2fidc=;
        b=Br5Xbk2FNHY4xw7psVdZRCA+euWB0nZnwNENpGx7QZgrSi+4LjITd8D4gctrELqQj/
         oPf7GqWknA3VThY1liJAZ3CCccTpjpVpK2wGg//ucbNkrngb+6nWCsLtokDGAcMlu6bP
         JzREE5Lhrxt2a0XBUop/LinY2kJoFf2bMSf4//Y2lYYaJWx+Rzgfkra14gA17uVS7PkM
         0mGjFsA6ZX/OfI30SdmlcfJJ/aafeoAj4x3E+EREhieTJvqtggOWXJ9MD5hpEmTJ/ZcW
         dI8Uw1vq7dMemyfah5H5ctsefXrdkY5Y7wiN0ky3sJ5y7449ruZDBRiySNw1dt+End/9
         10XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774170208; x=1774775008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpycnvHPDHkJbsXhHVIz+yo1HEECgH0T9yQbtY2fidc=;
        b=LqsS+rPhnM96VOr7ioRoUIQUxxOfOZO2DEUZnyyzu3+xwNM8LOAuf0PvDrVjMBMJIQ
         qMi2Gc2s5/LIgjvEJlfaaYjP9quy46jnQ1QDluZDk7MsBpWmmQp9pLxJ7QmwChrRJSc9
         Zl2ocp1Bf43QfhQq1Dq2mFy0QnXa7V0b+lOB4cKgY+s+sfw2/tABwE+x14svJ7F4ka9U
         Sm45IliCzArg+0+bv+MG7cyvcppv6ldVCj14XDkfN9X1ovP8zptShXq4fzdfmueSl9Z1
         j+VcZw7bu2UqrmIhwQ/zRnhXmgqvYJ4ToZ/Pwls1DDoxIKJeeHJZqrue7fiUMJEBdb0h
         auRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ckc/OkOvUpQuy74vkfNNqUu3+jgKmfL2iE46kN75SgbYEH+kjzkt3kwHPb7WEwgT7Bgvol8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGKWqJyXh6GwUPLjcW/n7jJwzwrzDg7fTxsnMmUGhxmAY4Ngj
	qDX3UUvXp7liPOUVuyufinQ55UHPImR0nHc/DGa2qRu8IfcLEVBXFrTK
X-Gm-Gg: ATEYQzw+Nnup6sxztfEH+ZPWJxmLovfGzNYRsy33Bdax5GBj/5pAE5Xop2ndggVh+Tv
	nGKD/LQ3Poy4f25/TgJlkuY/eyXpGQRL2BDUUpoRmMzHWn/sTMgNoVWUt2iLNlmVNQtgSLM1mlh
	hv8LIHedrv0xEaa5OpzgU2aq3e+/21ddo77pZbN5kMQPFyN5QwkwoOSFjwyDD/rHdoVQa0UUe5s
	/et+VTmIlCN9yWfKt9mOPavPlR8p4wAMtSU9qVM7KZ9AXmqtwElB/DgbxtJ+kAa19GsqGmLjCjF
	WKFiOegyNHmowEfd2xfyfq607JIBFMMFa4VjUvG1E7OX7vgAdp3crdFg17/TguEYMFsFEItwAuF
	d3ccvQ+tCaXDDL6bI3XGMjj1uohAM6s2JFuKIEyTvMSnHmm7pK03WbhV7D0Cq3Oi3BhUriXqs5+
	plwKRgNqcaVK2JFfpWemca1JC0EoiOluDC7FKD3U5T4Ths4cNQVUBLsNmwOnc=
X-Received: by 2002:a17:90b:1b4a:b0:35b:a656:a614 with SMTP id 98e67ed59e1d1-35bd2cba183mr7387611a91.21.1774170207855;
        Sun, 22 Mar 2026 02:03:27 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3442d8csm2935622a91.3.2026.03.22.02.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 02:03:27 -0700 (PDT)
Date: Sun, 22 Mar 2026 17:03:23 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, xmei5@asu.edu, stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: xt_devgroup: reject unsupported families
 in checkentry
Message-ID: <ab-wW9b2ZQzKV68E@SLSGDTSWING002>
References: <20260322041844.983129-3-bestswngs@gmail.com>
 <ab-qwvT576uYX6ny@strlen.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab-qwvT576uYX6ny@strlen.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227823-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 3E3C92E8B06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-03-22 09:39, Florian Westphal wrote:
> bestswngs@gmail.com <bestswngs@gmail.com> wrote:
> > From: Weiming Shi <bestswngs@gmail.com>
> > 
> > devgroup_mt_checkentry() validates hook_mask using NF_INET_* constants,
> > but the match is registered with NFPROTO_UNSPEC, which allows it to be
> > used from any protocol family through nft_compat.
> >
> > On an ARP nftables output chain, nft_compat passes
> > hook_mask = 1 << NF_ARP_OUT. Because NF_ARP_OUT == 1 == NF_INET_LOCAL_IN,
> > the source-group hook validation incorrectly accepts the rule. At runtime
> > arp_xmit() invokes the chain with state->in == NULL, and devgroup_mt()
> > dereferences xt_in(par)->group, crashing the kernel:
> > 
> >  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000044: 0000 [#1] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x0000000000000220-0x0000000000000227]
> >  RIP: 0010:devgroup_mt+0xff/0x350
> >  Call Trace:
> >   <TASK>
> >   nft_match_eval (net/netfilter/nft_compat.c:407)
> >   nft_do_chain (net/netfilter/nf_tables_core.c:285)
> >   nft_do_chain_arp (net/netfilter/nft_chain_filter.c:61)
> >   nf_hook_slow (net/netfilter/core.c:623)
> >   arp_xmit (net/ipv4/arp.c:666)
> >   arp_solicit (net/ipv4/arp.c:393)
> >   neigh_probe (net/core/neighbour.c:1098)
> >   __neigh_event_send (net/core/neighbour.c:1277)
> >   neigh_resolve_output (net/core/neighbour.c:1604)
> >   ip_finish_output2 (net/ipv4/ip_output.c:237)
> >   </TASK>
> >  Kernel panic - not syncing: Fatal exception in interrupt
> > 
> > Reject families whose hook numbering differs from the NF_INET_* scheme
> > early in checkentry. NFPROTO_INET and NFPROTO_BRIDGE share the same
> > five-hook layout (PRE_ROUTING ... POST_ROUTING) and the same
> > state->in/state->out semantics as IPv4/IPv6, so they are safe.
> > ARP only has three hooks (IN=0, OUT=1, FORWARD=2) with different
> > semantics, causing the numbering collision that triggers this bug.
> 
> I think we should solve this in x_tables.c so we don't have to ensure
> all the .checkentry functions provide for this.
> While this patch solves the specific module at hand, it begs
> the question if the same bug pattern exist exlsewhere.
> 
> xt_check_match and xt_check_target should call a common
> helper, this helper checks that if the match/target is UNSPEC
> and has .hooks != 0, then the calling family is IPV4, IPV6 or BRIDGE.
> 
> All others can be rejected.
> 
> Would you make such a patch?
> 
> Thanks!

Hi,

Thanks for the review! I'll prepare a v2 patch that adds the family
check in xt_check_match/xt_check_target.

Weiming Shi

