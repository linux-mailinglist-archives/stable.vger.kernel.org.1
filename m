Return-Path: <stable+bounces-253537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL8BFdkJD2rREQYAu9opvQ
	(envelope-from <stable+bounces-253537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:34:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8FE5A5F47
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B86E833B0EEA
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB683D88F1;
	Thu, 21 May 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2/0osJ7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DB3D7D74
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368297; cv=pass; b=rF+HHOcROuXt1LkrTSLhUeINXTcucPFUIp6yImIL93BlVllGTxbHjMCpufGtzZLAAAnbdRpgFEkNYpqU2/RR2EZ/wgrmEG00kzJZsSL6skXcuOmzWPoDXfZmAbtvTKC3pF7TsrwUf28Bqnapv3uZGRJu9har4fJlv0WvOJ9CJKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368297; c=relaxed/simple;
	bh=8AFtc2rk4bePNoYXeigGiNXKbn88p89XeJbYTwvofZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlygXI5JOlly57ZtxskCyBRufhHjMqLl37FVvS94bQBH/CAT5r2r4LUhgp9hQi72Y/CPPP2mUtEslehZueYPR4EVNk6Tg17nOs2/VoI4oVEaFQ5964CFPVJTXVSsRde4/SH1In9WFem212qbp7sX3joEW68dVJ1gSlmCj0e4x1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2/0osJ7; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d146705b4so67572255e9.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 05:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779368294; cv=none;
        d=google.com; s=arc-20240605;
        b=ZRhvGdTP0GwnWHf35KXonEopHYJaxrpQKb/yxXvD2BSon/8E0IrvynIxNuk+23IzXE
         my/i9Ve8ptx8uX+4v5gmjDZMZyJ7lhxSAb6flT/tAv3DnFd0GLiCZHajPX6oOrRQBPVh
         DeD6ON5uvJrzcDhAQgAZL7Bgr5xGAALFT7dUjsik7TxbCwl+sMz6+60IDnWDEzQ0aYsp
         N2eYpupdyDBjIkMUKOGPn8cgcyGD52ei1DmB1v/4GdJ74HyPM0BYWtHA/1W3nwPkoaEA
         s97TUBLXGbN3P4ZYY/aCVDZOcYblI080abX0c3/0L3rMo4hoAaLq5vxgUq+N4CSEzMFZ
         kzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8AFtc2rk4bePNoYXeigGiNXKbn88p89XeJbYTwvofZs=;
        fh=041AZThnYnFUdZDYk1jyUJsKuSS1JcJvURCJkwB/U40=;
        b=YjfAIAjE+QX4yByR9md3iLVJbC67ryZeNXBQ+HzKcMmjAA1PE0jE/FXwSyWgL/8K8B
         ApgCzB/NFEfMOfCQEOPCRgAImzcx089iGd0Kq0zZBtYARuw2jRQcOHDzLj132S2fvIGT
         6Pz/RXv/Nm9pPQyNfDdDJIVedZbBfpzArQXuzetvIVDj6jcmTmrGPoeKGs/eRuGFrVTj
         Wqr2fYmJhYnpFkeAL++NGQ4OSBc+LFb4Wqtd+6bffKDojP7GbyCF+pvDDV8PBbxwpSzJ
         ZXbMsON+Db52FH2nJhk17vudzCg+y8fMiMcO2fgHvFnr1lRjDqNN2GmSmpLuHSt6VHcC
         rrTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368294; x=1779973094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AFtc2rk4bePNoYXeigGiNXKbn88p89XeJbYTwvofZs=;
        b=p2/0osJ7hu/UPGgScWRDe7eoKpMT+V3oi+j6a4CO1+7JM8Y2FC/iff+d0C6ukDUErX
         tx3AM9+e2vJLlIHzPLYsD17mEEdStB1rjpKOgdGtujH/7YV5oMA5t6EOl/vxIE2Qn7F4
         Gl/oOxnNoHeonz8p+wx2Pc03tUFHaSFXfFwlYEG7jGwx2l1D8VAfMVyEM37jARvl/Bro
         e0yMfKI8rdmYORFyznw706aCc7uF04pGP86dWb2+MjLQ47BJk4vQxOUL16UwJj//Y3nS
         N14bmYaVEqfUI6KQbYx3Ep9ZFYAHRaM7BUmeSrThR+YaMeAVpGwsa4uSlQ3msYlGB9Hn
         iBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368294; x=1779973094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AFtc2rk4bePNoYXeigGiNXKbn88p89XeJbYTwvofZs=;
        b=Gz2Id8IdvGKUEubi+CgHyFrVJIbAfONYufSaDOb2B3Pu0hcOgjY7JqG0Rx83EJag+f
         3qnv+XuZ2eb5Z2azmlAjqLrgZXBJ27rlGcXcXFvzZWiFQC+gSJMrYJYPNR2P5Oe5EQ5j
         VCIl9D26nxpnBvT1X3OYOvAwnLumOco0ejzGf3HrGL2/OvtiHfZY03ECWS3tcAjik3Il
         vPPZjMtr+wTKdGw17mD+vjx4mqrkQ+Mrq2HxD8NPkuCJIKQJ9bSKKwGQO8NOr/PoEq9w
         YxJsDG+Pfy1vd/YTutr77dhA3htBsHHQyKZZXAqu2LXHc3OrYgElOu+aMtswzlDMRuqE
         qT8A==
X-Forwarded-Encrypted: i=1; AFNElJ+4vIk5gjWE3svPRm8duNG9tUQgDxb2fRIeZueGPblUY1fIqAUyy+E3hV3YTq3750TPyi265HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsL6wMxGfcVONiplXCHE9bI6V2nwbAtcq4OuqQpwhQpILs3o9/
	k5GM64cGQXJ7qOxFhZOGPoJ501PXLPFioR0UPAQSj6d63RGRppxAWti/MZjivM82QWITwhvPz+D
	LlXnvLQWKfgUmhTQNLwVqt2Iub3XOrcE=
X-Gm-Gg: Acq92OFSz9TM/77yNZ8oREmjWEPNowKFAPkSS+3LlcjwGpg9mgxJxGvujAwSAuwOUF8
	MjV/fFUHqLkTKmbkqCgDnQsE48M6fqXSVyKANJ6lremDTAj6qtG+yi/gM790RThUMLa0ti4YSUr
	98vJFMDyoY6zrCy/XGtFCm7aekfPhvRl/CDP8jc/sFUTsJo6VK+49LUqrPXZ1Sak8synYfwQbss
	4cHi5WQqm+6Uw/JkFYjSp13zeHoJ1YybGJ8pdsY+xgtXiu6jFH2+i0BRvHDGyZQ+3D6nTIwwLvc
	VKH6fP6xsTq3ydaEHA==
X-Received: by 2002:a05:600c:a108:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-4903607c446mr32825335e9.14.1779368293415; Thu, 21 May 2026
 05:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
 <20260519123547.2055911-3-maoyixie.tju@gmail.com> <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
In-Reply-To: <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Thu, 21 May 2026 20:58:02 +0800
X-Gm-Features: AVHnY4IpVxDaUliQ4Mq2HwumVwDbGy0Z-Ii1rpU0I9GF6hF4hsW13wwbNRndpSM
Message-ID: <CAHPEe=GX7wsLetw7rnOpeSkc05Jgi3h5y56e0RGYa4dszK1E4Q@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253537-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0C8FE5A5F47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiao,

Thanks for the review, and sorry about the wrong Fixes tag.
5e72ce3e3980 is not where the bug starts. The dev_net(dev)
vs t->net divergence first became reachable in commit
61220ab34948 ("vti6: Enable namespace changing"), which
dropped NETIF_F_NETNS_LOCAL and let vti6 devices move through
IFLA_NET_NS_FD. v4 will use that on both 1/2 and 2/2. Same
shape Jakub took for the sibling fix 1d324c2f43f7.

Thanks also for the ns_capable suggestion. The top of the
switch case only checks dev_net(dev)->user_ns. After migration
that is the attacker's netns. With the v3 patch the lookup
uses self->net. The else branch still sets t = self, and
vti6_update() inserts the device into the creation netns
hash. I reproduced this on a v3 kernel. An unprivileged
caller in the migrated netns picked params absent from
init_net. The SIOCCHGTUNNEL returned 0. SIOCGETTUNNEL in
init_net for those params returned the migrated device.
v4 adds ns_capable(self->net->user_ns, CAP_NET_ADMIN) before
the lookup. With that check the call returns -EPERM.

I will send v4 shortly.

Thanks,
Maoyi

