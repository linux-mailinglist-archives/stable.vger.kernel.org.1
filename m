Return-Path: <stable+bounces-242076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMrzCQ0r82nMxwEAu9opvQ
	(envelope-from <stable+bounces-242076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:12:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC14A0916
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE23930254C5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E913FB072;
	Thu, 30 Apr 2026 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWH5Zasr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5473D8138
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543621; cv=pass; b=pkRTyubVI1aIHsivpsZdX15p149xCHAkN9vr/L6AcNlK/LYQYKYUJXfV5i/OZgA9Otc5tpwfn7j6KkhsgcqJs77H402kluUBWZavCgZUn0VO995q+v1SfiSlarnFlqQRapCyDGxmfU/PePAIKieXfy8MQtaBpyiBMVEDQcvWO1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543621; c=relaxed/simple;
	bh=Kyvgpw8dc+Zokvv11RDsVRqVEvvShTtobFoI32DJ6jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcKjzhj3d2K3tIU9/UrL0tEJxr4BIZlnNqTDUcKfopS1CCTR8aB8gVlCus5Vgis7A1xaX6bJXLiQJiTj5QItt7DLdU5WKTcPUVPfwY0oOIKM9bGaLuSQsmuJsoderZO3qtrwa3JUhkuPefckrfbnMxR7bGLpYpkLgeik+9D3xqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWH5Zasr; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so8262025e9.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 03:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777543618; cv=none;
        d=google.com; s=arc-20240605;
        b=MX5mz3w/mOZ/y2UUPf8GE+VO6eQ0MLselQ9md4UaFYL6rI4SWUKy4PESyVMa4+ljjM
         WDWkHPmjKxcnfeFqDsMPZ9+bGKMYbJhKap+VSKSV5IdSV59lefFQnB+y9xJ9Dbl+yeDI
         slsLUtIxdzuysywWKfmN/CjYXQJJXU4irHBDUvJiLE67dvodOm8JhKmfCCVFx1N7NnW3
         mW7aanjydN/LhsX1MAPjWDo/uZ1kp726zoEEpkYVrEQPV4j2chCROqd8r6TJPw7ERncW
         fMoHSYFKajZZzQaH6xhF2lOb/FccNdUhOjMhVl18VuTrrX8bIR1pAHkyPsvbTnl5yzAS
         Rm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kyvgpw8dc+Zokvv11RDsVRqVEvvShTtobFoI32DJ6jA=;
        fh=6MaSLzhkkR9zUzmxml/LhLSxDn5ea40O2L5rBDAoWIM=;
        b=QbUV11i2ub2ZjlHj9j7ahecgy3XigqcC7VSb8u7Co5M+cxCgo/yezQRMbkVSS5x3mx
         r0GHTm0NH8D+Yfq39CnqNBSxTTHmcHJfraKFEu876uQBuyNMbN03T7ZgD2YV6sNz7+6z
         6TFzrwuuS45VzyAjW6o2oFLXtxIc1qOHjmz6bZN3P+rGlJGVI8E6D65kxcAv1bVYTpeg
         L1/Cg8QvUsFBtYH7RCZWe51/670RHs1b1lPJg97IyTQzbkAPtcMf7Ky1+MdYUOZkM4qd
         ti0vFK/BsnsCJFLxE267YOO+inRSlz/4Tu3PdGg7m6JUTMsrCHoSe8JaNFBCVYWzXY7R
         PWEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777543618; x=1778148418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kyvgpw8dc+Zokvv11RDsVRqVEvvShTtobFoI32DJ6jA=;
        b=hWH5Zasr9qhJ764vlFS7lMMDRcKYOhbQeGl+nHGoaIKd+LMep7IBHAQT0V+ezw+II/
         AcrUtka3O1Oa83OrWRHei9M5TE/myPojJV4ndWF2nGXlFQWB1gPn5H/Bpsy/h2AcTS/t
         Y0aPnZz9ndgpcG9B0tpf3Bnq2i55rPEn7ig9Q7gCbmFG8CSFy8AfugsPqGV9JgwVwRJO
         ePwhjl4iZqXLwhPRGskY3R2d0awxtdcw2Xr7sQ7+Rb7l5LhazjhVctgNjkdTdiTEiQSP
         7LDYhr8ADn0K1vjH7qNyMZBzeoOcsn8QLv+DgVaiMHM0du5ey60CyQrmWWA+2Yx0vL91
         iQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777543618; x=1778148418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kyvgpw8dc+Zokvv11RDsVRqVEvvShTtobFoI32DJ6jA=;
        b=LcvzOplqdfGzD9yPlyNw1almFuTgbVspww35ve958UzIA+Byo54u1Zyh17jloZeVLZ
         690v2U7o6xMObD2PVm6VyBSYzsWWXnPIILUryF7wb5MjuxPXpi/Ao1ZuiePpLlcrn9pQ
         bv+D1jZVhWe0HJ9pGpJpG5OErGmNPEK++48ViS34EnTYy2qXzhbBDMtxyZ0RLzfg0S5F
         8/vLbDFmUUhvqXqL4M9dvoF6a6KVOPkUI5P6N/97ZEFQ7V468Ufo7sze7Hv7CfuSclMw
         Pa/gMR4b5G72HoLCRn7scMCmfMIQO06jdm+lAZFx0jws6+htspOwxge+d7Jo0zeKRaoh
         w/oA==
X-Forwarded-Encrypted: i=1; AFNElJ+TmLG0+5YXAn6qSwSypw6X+3YxTu1mwP56T2/tRab5NRYjjAAKHsEm32ceZJD6BN6zhRie2hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jvEjKkyUJ60WcCync79u9kbLWQ2xsGKEJ0CNGE3d8FSiW7/6
	fwvp3+nVNjbRoCWXvlBPZWAJaeUdZ5Q4aIWhuizuvf2J2wlKenRJB1xeuG2zTGWAC7iAa4gtMrf
	S8yOyMhZea2CRb1YNpcp7gc5PQ5yFnGI=
X-Gm-Gg: AeBDies/awSxisKt8yQl4BN2slhAihjRGBRTpkA9Sky117+GSvnJhPsBLoSVqTkmVwP
	NdqFA/d9FCs3/SPaqxKs6nNAI4BVGiKA38GG+165aQK8TG/ph4tstDvRsw1vQd2Htfy8AXVsQct
	CkXVlao/3TaP8FCU7d78eYTvYMtiPmxO70M5cvzSzSAPANTEpnwNVtpJDXQLLArLZJFEPM/bxQK
	HX+gy3OpOpFgzjAtL0FiEAnJITTh+cdDXMNGyHwNVXEf+n8rH4/jMF/DzQ2Ary7HGGv6zAYJMJE
	ZNT30bpLvUgqxTcPTr6an8YMDr0x
X-Received: by 2002:a05:600d:8408:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48a8452cd4amr28513795e9.24.1777543616751; Thu, 30 Apr 2026
 03:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-3-maoyixie.tju@gmail.com> <20260430011849.2345207-1-kuba@kernel.org>
In-Reply-To: <20260430011849.2345207-1-kuba@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Thu, 30 Apr 2026 18:06:45 +0800
X-Gm-Features: AVHnY4J_1Ckk_0_wc90cHEBhr1N2bAxmlonoBSKgk48Fyitc25vQe1jE3K00alc
Message-ID: <CAHPEe=G00_xFCx59KVRejzwJJVH0MkK4yB+7PFjHtyp+CBT8dQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, kuniyu@google.com, shaw.leon@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 93EC14A0916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242076-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,redhat.com,kernel.org,ms2.inr.ac.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Kuniyuki, Xiao, Eric, Jakub,

Sorry for the delay, I had a fever yesterday.

Thanks for the reviews.

> Kuniyuki:
> nit: Please keep reverse xmas tree order, and you can reuse *t below.
> nit: Reported-by is not needed if it's same with SOB.

Both noted. v2 reuses *t and drops the Reported-by trailer.

> Xiao:
> > Fixes: 5e72ce3e3980 ...
> But why is 5e72ce3e3980 mentioned here? It neither introduced nor
> was intended to fix this bug.
> Maybe 2d665034f239 ("net: ip6_gre: Fix ip6erspan hlen calculation")
> which initially introduced ip6erspan_changelink

5e72ce3e3980 was the wrong anchor. 2d665034f239 introduced
ip6erspan_changelink with the dev_net(dev) shape. v2 uses that as the
Fixes target.

> Jakub:
> > While reviewing this area, I noticed a regression further down
> > in ip6erspan_changelink() regarding the metadata tunnel
> > unlinking.

The ip6gre_tunnel_unlink_md / ip6erspan_tunnel_unlink_md naming
asymmetry is real. Whether collect_md_tun_erspan ends up dangling and
reachable by ip6gre_tunnel_lookup() requires tracing I have not yet
done. v2 stays scoped to the dev_net conversion. The unlink_md side is
better handled in a separate patch.

v2 sent on netdev as a separate thread.

Maoyi

