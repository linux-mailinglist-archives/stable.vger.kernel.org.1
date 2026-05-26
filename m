Return-Path: <stable+bounces-254455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOGDBXkrFmqdigcAu9opvQ
	(envelope-from <stable+bounces-254455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:23:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 717695DD836
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3F33080C96
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2393CE0B1;
	Tue, 26 May 2026 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoF8Uarq"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156943B0AEF
	for <stable@vger.kernel.org>; Tue, 26 May 2026 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837712; cv=pass; b=Uqm9X290ya71g1Is0/bo6DRuJKKRqz4d0qKJm6jH/l0+j7NXi8LR81v3R04LqChaasbY8DTdF5+ruWalaIj0q8BkjQltk4sVMICa9gfWiXFA/5tPqhT7/9w4K8/rXc0ahIm2Rz4sB1Qywq16g0iPE6q3hXFFV5mEcStmvJptdJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837712; c=relaxed/simple;
	bh=u5AZ6lDvJHN6hkOMWJlEHdIYy+BPs1w8b0bOdZZRyJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8P1loUVUomiiqG9jxUxwmMUebwmX8mlQo+8Wpdy0jft0r43JcylwcnNbckyPyjoJFck8OCFktOuizbYdXtThk41HbgyFc4aVq2TynN5Q1N8nv3tM9JIwgnVvn2FjUsLWDOX4WWGLoZnoITs+NEORCwa+iygIRfRq/nriaBScMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoF8Uarq; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43bf6230cffso1231952fac.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 16:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779837710; cv=none;
        d=google.com; s=arc-20240605;
        b=cYaO0LUr6ih6AW/DrB2lP/V7bx5QjkMM3auB85bkleXraNVvmt1C3YpfV77TULg5xx
         3MfetcEyTjjv+0owa1JMExHYFOsoIPfSAMkZRD0DtpAvQCShNCLkTFH+dHSrG3IYKGWb
         ZP6irx1iXcRs/X+dWEDyZNTU+bpAb/0YCW0Oc8dsOOq1Mu1A+QIhdCKLqpSCrMbJAA5h
         aUs/T+0KFQbBgTa7Pide9ehP1RshMlcHZEvDnh9b34YdkmOKDgvFO+Ksa0OkjM+uQVDf
         NNCJql4WSxlHnqnE4lEhXGQWtSMK+oasEYMjJXakZrT/ygDIzIrg6GraCNgIDhNN8k+9
         +9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HujuVBuKdWWEfICM8n6u8a8X3rF3iweG2fpAlmRVj68=;
        fh=dXwfanbQM+LTLC38gj54wjFSWF3DTefQd9OmhpsZ5nc=;
        b=JP792RHv6J9IKhlUA0kTpM2dWeKDdTGkY7v9GlCp2Y0CeHSbNtU5z9+ken4nUoicbF
         A3kH/xkINj76tuKsDWTtVsKJV7qmjTirM/lm0yqceRc9yAc1giQ22a0YHp9wBA+hAibs
         UNZUtR4ZSUEIJWafU2yVmKItbqHUodfGAzHLHfgLEbjD03ZJS2UGa6X1VavN9gYzf9Sv
         PdxHTNchK4vv0bbBxQfWHdDvnBfxMnoUahWi20JNQvyF0Y4WN+eQBV3I6+JUE80xp6ou
         ixQsm/oNjf7FuZ0PCowkDsTthRIuG6rOBD04v5tc89HSNI5vDajLP0p9l64AlPUKr77u
         Wc6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779837710; x=1780442510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HujuVBuKdWWEfICM8n6u8a8X3rF3iweG2fpAlmRVj68=;
        b=ZoF8Uarq/TldyaYIzCoGeNZ4a27AC5yVtMW2qA6Tq9NzzWaOekALVchygvW560Li57
         VEI7YHopZ1NPwR5c4jDdIWBBGBy5szAPuY2g8Sebgwsu6Srwp+6KIZMbFR26UksalAqR
         /Ar4cOnt3DJDonqFEM5D8vyKYvVSvGsfoInObizwy3IygcHiBMTU9RUkLaauWzZGhZN4
         sJ8H7IfBEpqPZyeaRUURQi+O8KCm0ESpIrzqou+SbZh7vqjIF77HWQzXdCYKNcE2p5ja
         XdTYZPCEWLbvOKLLf6BiiK24XjBh+QgJlYovwsMDMFUdvrOkh/ahAXlltSyXVJPE7efq
         phmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837710; x=1780442510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HujuVBuKdWWEfICM8n6u8a8X3rF3iweG2fpAlmRVj68=;
        b=BD2LZ6xaxoTN2Qw8ikEYjWQnb6bUL3IJCNGW6Ng04SsNCwomxdVrMOv0wiUQ2xWZ5w
         alt+qMEZbgLAEYOKMo1fuls1dG1kjAvBW3YVgPA+6+Y4UoxafKQ3OyCvznUM548OwDGc
         wUcXMGDu3vk5IPhVYCb6seuWp7ke4DGwD28KCEQFnaY72NyyPe6sI04Y6ObVFx6/ISRn
         QYwQVsCdZhIOVka38SwuZl/+fLDduUXzwMHD21bPxiZp11oI5uLxPYzMcx8UOvt6niOg
         ySSFhvBXrGMdCk9AUiW45/D2u245dqLA8sG+JPRqrjsr6kRuBsop0xmsOQ/Evaxawi1l
         sbpA==
X-Forwarded-Encrypted: i=1; AFNElJ/durkAK6D9UDYP8eXXZ+5x1a4IvWx3VbMt0f+nD/9O4NiQS6OU2WSUij3itcYeYybix7KxRwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNz4+VUjTjmfQshI3ZzGZYSW7/W5Tuin96vS0SqjgWIs9z9bRu
	UmcXfqLKjYBtIDZ0Ml5ghq/rb/QpxquhOyt7Jxx6+ShlglbAOmMh8zWGR/KKuE2jvl6keOvTysA
	FisYTCXhUy0cat5Lb/vd+KfLphMzIRAdCFB9DwXk=
X-Gm-Gg: Acq92OEATy6TZJZovzvUk+yKvTY2naKl/c8cqBEaNSUIdetOAelf3wLJnNBGbsoEFtf
	INa2b15HgHdptzgrRX6aUW/IiUkH2ipqi/b2HQFWbHM8nbwI2XQta2qfVo9TpmifV/BDvM2kU/c
	ZdsTn2g6fFL4shbtuYpK2v85nDzOI05AuvXrb2fYZT5CMVi00QQcbF5PGusLVt1H48TTdSqx4Lo
	SsFBat70VNKjhOruUjnVTjjyDLbZylvpJDjQV/Pk+ZJUv7a9JJo/33J6aJYA8F8McnkNJsPhTw5
	fQO+BzFYI58T4bLoMPL2O/nmmdo=
X-Received: by 2002:a4a:e903:0:b0:694:9e2f:cfac with SMTP id
 006d021491bc7-69d7fcb51b6mr8951696eaf.9.1779837709977; Tue, 26 May 2026
 16:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525201116.407338-2-kacper.kokot.44@gmail.com> <202605261807.YY0PWuhX-lkp@intel.com>
In-Reply-To: <202605261807.YY0PWuhX-lkp@intel.com>
From: Kacper Kokot <kacper.kokot.44@gmail.com>
Date: Wed, 27 May 2026 00:21:38 +0100
X-Gm-Features: AVHnY4IeURuAw-7kug8a-6xqNpmP-8aoIQEcxEzrITr5eMpT52Lzw3oZg7lhaRo
Message-ID: <CAG-Fur7edB8_4iLnP4QWh+K96bGFBgYyfdoy8H7zvqa8NYdyow@mail.gmail.com>
Subject: Re: [PATCH] netfilter: TCPMSS: fix dropped packets when MSS option is unaligned
To: kernel test robot <lkp@intel.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254455-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kacperkokot44@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 717695DD836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> AFAICS, these issues are not present in real environments as MSS option
> is placed at the beginning of the options block making it aligned by
> default usually.

I agree, I haven't observed it in any real environment and wouldn't expect to.
I found it by reading the code and had to craft a SYN to reproduce. That said
the spec permits unaligned options and the kernel shouldn't silently drop legal
packets just because nobody sends them today. I can note in the v2 commit
message that this is a theoretical fix.

> > I wonder, if we are touching this code, we could use the opportunity
> > to make it use get_unaligned_be16() instead.
>
> gcc and clang convert x[0] << 8 | x[1] (etc) to the appropriate single
> instruction (and maybe byteswap) on cpu that support misaligned accesses.
> So there is little to gain from doing it any other way.

Happy to go with whichever you prefer for v2.

> and, of course, the code works fine because 0x1 != 0 is 1.

Ha - accidentally correct. I'll add the parens in v2 tomorrow.

Also the reproducer I sent with v1 was clunky. Here's a better
one with some results below:

  #!/usr/bin/env python3
  import argparse
  from scapy.all import *

  parser = argparse.ArgumentParser()
  parser.add_argument("target_ip")
  parser.add_argument("target_port", type=int)
  args = parser.parse_args()

  def gen_mss_syn_options(nops=0):
      return nops * [("NOP", None)] + [("MSS", 1460)]

  def syn_check(opts):
      sport = RandShort()
      ip = IP(dst=args.target_ip)
      syn = TCP(sport=sport, dport=args.target_port, flags="S",
seq=1000, options=opts)
      synack = sr1(ip/syn, timeout=1, verbose=False)
      send(ip/TCP(sport=sport, dport=args.target_port, flags="R",
seq=syn.seq+1),
           verbose=False)
      return not not (synack and synack.haslayer(TCP) and
synack[TCP].flags == 0x12)

  for i in range(7):
      n = 5
      ok = sum(syn_check(gen_mss_syn_options(i)) for _ in range(n))
      print(f"{i} nops + mss, {ok}/{n} probes responded")

Before:

  0 nops + mss, 5/5 probes responded
  1 nops + mss, 0/5 probes responded
  2 nops + mss, 5/5 probes responded
  3 nops + mss, 0/5 probes responded
  4 nops + mss, 5/5 probes responded
  5 nops + mss, 0/5 probes responded
  6 nops + mss, 5/5 probes responded

After:

  0 nops + mss, 5/5 probes responded
  1 nops + mss, 5/5 probes responded
  2 nops + mss, 5/5 probes responded
  3 nops + mss, 5/5 probes responded
  4 nops + mss, 5/5 probes responded
  5 nops + mss, 5/5 probes responded
  6 nops + mss, 5/5 probes responded

