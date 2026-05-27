Return-Path: <stable+bounces-254525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJs/MAG9FmqHqQcAu9opvQ
	(envelope-from <stable+bounces-254525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:44:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB25E1FBC
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49CF53019127
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D93ECBFD;
	Wed, 27 May 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbRBo3sk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17CE3ECBE2
	for <stable@vger.kernel.org>; Wed, 27 May 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875015; cv=pass; b=bFxiLyxBBnK5PAxV2F2zMFwYMtuIkbOQ39IDzajLrQbkDwnfICEQXxGDBXwHN5a7UT2v+1py87GdmDKTKYikuWo/Ja4rnhDTv3KGGhuF96AnZOAC5wvuz8KQmkBT4f9/hxneVpH9LU6JZUYtoF8TDvYxBCtceaXgEdog3i1Jv2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875015; c=relaxed/simple;
	bh=Co6EHUesoW6BWBk60jtMfwAVc9623LbALcIYwj02eos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgYFKModxqMvHs4lUY51gnhRq60xZIagK9Y4wDc1oxdJug+iRAIORZOKTlfxQeOdG2Psa2VkC0amFhzJGfYTBAOhfj01cAOy+Gp67vSEPZDMSb3CQTCy7I0/LW51t7R2tLSb/oS9vX1awR1xThhPOQ71XDXU/2lzBsRzI+fVN6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbRBo3sk; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso6398163f8f.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 02:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779875009; cv=none;
        d=google.com; s=arc-20240605;
        b=gPRpWvps48fc2ekNAU2IGGwgINRfAL8ZdH+HPz7FM9P6PfNtXezm6DSbYsh+DEk8YA
         kqXOxoagvElwt9lAD6uhN0Lb1wbfwldhhWdsrqsIJHvOkKeox2te6dbeifUVXFWK8gxV
         EUeyaPDqgYiCVX866E/5G8AIvRNBaCrQgtrpW5ccqDl0oiCDPCsponr2yPT0835ONzrn
         Kdgl3X4UV85BSgk/SbL4EbaWjkfsSaYwK+Sv0hR3Qyt92gOsS1nclzvlGQDZ+95l7kyI
         clXwFyIaaJaZ9rOghApvOMwmwemRv1E5nv2wvBxontRJSIUKu1s/3ay6VllOHI2bzrN+
         NS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Co6EHUesoW6BWBk60jtMfwAVc9623LbALcIYwj02eos=;
        fh=klo+1ff9NogE/SbHN55IswolLIzjMMjVU/Nm0GyOddk=;
        b=jWdHLDgKFZWIBrSkaAp49Xp0KQUXc4mulTkNzCjnJIOBn0GmJ65p3RvA+8BK1OGXqW
         XTQDt1bmBqnbwbDNpA/br+VDG17rFO7StaXf4RVGGwhEOJVgviqt+LjMbK4GxmSQy5po
         IliiIgyr9RnQ0eNMp+U0X4smCuj3V9RRJTvTZxGIw0h9CnEvSv/bce42lSQH4jejdhGO
         L9JzknwQuwUDlf/hQMLn41GoVEoc3VqN0fmCbOLXiRkXWeIjko3+ykDSS+qkJ/m/d7Hk
         nK1ey491r6JSw356k7A2emYFQJPUn15TZWpnoA5uL4WwbHlnyhV4g8GlwKz+r6dTVtWz
         NB1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875009; x=1780479809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Co6EHUesoW6BWBk60jtMfwAVc9623LbALcIYwj02eos=;
        b=pbRBo3skRjG30PmujBmapUFdwcbta8xusdv7/j0x3HLrPYqwvR195Bo5cUaKHaWqyu
         m4vd9uJ3sUI4IJoydPZaCDQDPFagFpXmodO3g2S+iAS2y12Ao2vyplMPKUTDA5WdxScF
         V/pH7LzmjA5QoJCTeKDJIxeTSgCDjL2xeCXCVqE3dRAeEcMBerR7kGLNHcqcC2NnX4nD
         H/UGTi8JS7zmM2mEYRFINcG/VV5hxdJ1ACW/u1ayF5N6xtPU/7BtZsQJTbt3NShfwm2r
         nNe50cVPBoKhSJMzjLs8P8Kg4JS88XxM6tVlG54VeogqRWmTVQ92vvPSqn92hginPWCm
         dJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875009; x=1780479809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co6EHUesoW6BWBk60jtMfwAVc9623LbALcIYwj02eos=;
        b=q1OFdHIN+Iz1XDQsadqtGQg9oYs1cu5kdraNfjiZ1y0E2wNiMSTvKLGVfqTCGBjIDt
         fP3eCdJZv9/WwEzSc3sYwV6QQvznKeiTKkf7BYmhc8S5xQ/m1nJ0xi7Giqhuo+bsO0VM
         BUGsmje9KwQ84Z2FdvCDqboxAYG0ON4EbFFgiuPgob9hyPTBBX2ANnRHjrdBZEO5xNlk
         iGR16ERFcjLSHcyuKzwtCqoibGJ78rVzrHENKNCl4Tl9F2Uvh5Y/D8wUfcZOOOmg3cuS
         1zrJDzMXRZLhin3jO1TiM4t4V5rFuq3/xqTCRapuLnZSc/jFtkA8uxuuAyB1smfafc6o
         HpSg==
X-Forwarded-Encrypted: i=1; AFNElJ8nwHUy78jvYXFjNxo7Kyk0wcIGiHvDOBW77FV1/lSPYT6v/IERc7CtOgoCjqU9/9vXs7+oCMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFzw8ZWmqEX6VEQIOb63LBTxRWnbR19haErFkwWWRKxhgKPaR+
	vAcJbbFE3tOY9QJ4a2eMjfo7bkat0+BUnOC2JVdftqDuAoQl4Ksh2VssHHiSFzOy2ISlOF9jfOn
	pJVzdBXyK3f0mGYYZAYTxkxoQX75SzSA=
X-Gm-Gg: Acq92OG+qNnrUBd5NhDtO+75qYOIzcWsuJ4ssefiLmBBwwYubmpdJhv31aSLi1d6EfY
	VmQd5IuWHQWUWLuf3vp2L329pEEsoiB67UZCUTSKsA1DPIn9OvLiYkXjKhckqLLHHZi1l82bi0Q
	MI9mn+0yvxBS6XYofZT91lvtpKwLCcgVljrrwiR988iZNGivTMTtFC05JzNmNC/E9sKQ0aYR9WQ
	1T5DiMXWxOQEqdjyDraTZooN7d3v6nI3sTd4JDd1cqFVQFocYwP55c7NbbBba7oq5uEEBwqKy7R
	ncjvfFuIdmm5jOzJqd0=
X-Received: by 2002:a05:6000:4a09:b0:43d:762e:76c6 with SMTP id
 ffacd0b85a97d-45eb38a7f6fmr39074764f8f.7.1779875008738; Wed, 27 May 2026
 02:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527070824.2677331-1-maoyixie.tju@gmail.com> <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com>
In-Reply-To: <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Wed, 27 May 2026 17:43:16 +0800
X-Gm-Features: AVHnY4LnyhgAhekb1Oe672L5X-bWeTtJyQT5uTBldYwiDLPpoTVojrMYJ7auvMg
Message-ID: <CAHPEe=H5SFJN-=EFggXdNreN_A_LE2r_KHrpWU4UxJmq+g-bhg@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 83DB25E1FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

Thanks for looking.

> Do all other callers of ->get_link_net(), dev_get_iflink_dev()
> and batadv_getlink_net(), require the same capability check ?

No. Those are read paths. get_link_net feeds IFLA_LINK_NETNSID, the
iflink lookup feeds IFLA_LINK, and batadv_getlink_net resolves a hard
interface's parent netns. None of them mutates state, so none needs a
capability check.

But your question points at a real problem in my patch. get_link_net
is the wrong gate. For the ip tunnels and xfrmi it returns t->net, the
netns changelink mutates, so the check is right there. For peer types
like netkit and veth it returns the peer netns instead. netkit has a
changelink, and its peer usually lives in another netns. My patch
would then require CAP_NET_ADMIN in the peer netns for a plain change
to a netkit device, which netkit does not require today.

So the check belongs in the changelink path of the types that mutate
t->net, against t->net->user_ns. That mirrors the ioctl side in
8b484efd5cb4. I will send a v2 along those lines.

Thanks,
Maoyi

