Return-Path: <stable+bounces-253760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEhcJmE8EGrUVAYAu9opvQ
	(envelope-from <stable+bounces-253760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16995B2EA4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02572300CF15
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8DB3B442B;
	Fri, 22 May 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2ama/YN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111E3D4126
	for <stable@vger.kernel.org>; Fri, 22 May 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447696; cv=pass; b=DA9GErtp55tWRpNIQ3cy5xuR99cgMsUghR2WxCIDge9OHkn5et+RGMpjblKCqGV1Ppf+J6ea0sDPIydOXfwaXzotlUkJQJ8/27QOvSWVNypi4p8HqMQPFaLJETq+tFyj32/bAYpQ9e6TAtLJrDBJ99fuuTPqlIkQ+xfid0dvxrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447696; c=relaxed/simple;
	bh=0RyR3TKKWIpuE5do03Aczoxc8RftN/xDiBn9xSJHGIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qISum5eZ/WRwy6dcgILXaucplcLvEGB5VQd4Vxpdmo+WBFFtRVRkHaNEK4VggcEpZZ/2JhY5gp0toShqut1BQJKD4thyaucPYuwB37OmOobIEU2b9P0JG1Ui2wsYtsSiGNuXq7rE5dY+8Prh80vTn21ypKCU3AmImlLLTX4G/3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2ama/YN; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48d146705b4so77670615e9.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 04:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779447692; cv=none;
        d=google.com; s=arc-20240605;
        b=A9jNwREk0kKHt0DT5fdad4yNF2dgeQKCQ7/ZBVYGdKGpWj52qKCdubSen7VusqxkRO
         MZVK2QitOn34Oc6TdEn27fWTcNarPkL7/filBqsA/Ru0/5PawMDNI19cbtY2NHC49ltX
         rw/VTjrs055StbugWhNQj6vhxs9d0aFLc+jGEgqO9CqNkKyQQCgDkCIpub87l1efSTK5
         C0jVP93Ead0xTYXXoysvw6VrCRNdToaoem2h/OogjW6DRffvACnTwDyLzLOVtvAnK/hr
         RvO1Oa2oG8uIIojWT0OORG+eN2ZaC+fwrVdAmfxTQxeRdR/jxZhmbzypFTwLZ+mrU3b+
         qt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0RyR3TKKWIpuE5do03Aczoxc8RftN/xDiBn9xSJHGIs=;
        fh=Kfw7Bsjud0rm6JO6LRYxRfbzYxTICpdUhrCe7/4E10k=;
        b=HrROwOa2vGyhWbteW01ig/NuDaRINu9a73UF0V1HreySUB+cSko20EqF+T2Hiw6OWb
         Ks7vQyRxEea576qUcEcLMsFZOqXofguzpl4HZh3eudA/43wYslmBpWKVUoIcApphZUGq
         TsQ4CEpq9kj03NGoSFZHtmdjWS7H/fHfYGX4AikTqDmZupSrOdsKdl6yH+PJRzzLw4rW
         dqCJ2vxuA2hK3smAR6gAjk6d/o33DdBb25TAXSA1yZbiSiEZ0VVEkKvR1h0VivM8qBWZ
         uU3o9KiUe046v5lxnjB3bmTWmf8iFYTpoOQBqSyeQcrGxAno6oJNMnzDaVLuT+5sm15X
         3o4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779447692; x=1780052492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RyR3TKKWIpuE5do03Aczoxc8RftN/xDiBn9xSJHGIs=;
        b=G2ama/YN6BqHHD92rLtnUgboNyaSdbPx5JeuIYG9tWEucIiPkW/3VQ6S+P7jX/pk+c
         +WrIPSFm54dy4POtO1vQgh+uIieWMcMrMFm+5wdEQVcla167KBsu4sx6m58FFGX40lOF
         LEnlpO9mbUafc5Pa2hDlLpjLdlNIxsOB034HCBmADKlDUkbXDwgBr4ibBdHuGQaVfs4E
         hjiB9p7W/L5qvoc9aVqvHKFb4pwSmRkQWq5y1Zzd+oaGiZPcq0kWkwsyh8/3dhMGj9Ln
         nNnVTZqHsa6/ypQG9cvLKVfx/MFdATO0ooBFJuaPiU1TDj9EGBkGuyd0+SATSThc4S5z
         ZDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779447692; x=1780052492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RyR3TKKWIpuE5do03Aczoxc8RftN/xDiBn9xSJHGIs=;
        b=R2AnHdkNcu23HMp8pPXUWv2vrl/3wrschqRt9qGdmBjb8jI2yLV/JSX5UwabWULDKI
         1GR4I2gjfHhvrWtvtu5SwDL904viqaGlQ6VD+dAyNFAmmjN3JVEBX3EGp5xmkqvZBCL+
         fVW3xnW/AX7CbBPRdwgCAbsRaSA+yBCwFGcuFvJjGoYWitiKEWWiu0Q4MLiAlPigNj8h
         uBqO12BSJkvoiYPBkgx2dLuTrji5WVT9L1CHttAg+SkvHei2nZ0cfkERoochnu3hONbh
         7v1dR9y/R63O/UGAV6lBDj33sqYGriVROf1UK2JtRItsMRHVbeSJM18eI4PUa7obNtY1
         G99Q==
X-Forwarded-Encrypted: i=1; AFNElJ8MzZp2+N3HfRRTwaVQTP72X9/uHXmsyP8Ot/5KBLNL7g/VjWduzBWU5Ywe0dvXfcRoLy/pKYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySnbFxpZSq34YW8XlJA0PjtQc3F0RpNPocOOt515VnyW3jn7LN
	1fHOhn1g8YoHJpyLr1c6/uBUZdfllKgK+VVz94KFf7OLv8uAzwqRT6ZMscnl4himcf3Djspz+RW
	bmD+KKpZN71VHqiNDgI/078hA5COPZDo=
X-Gm-Gg: Acq92OEL5rka0s/GkGtrUmVJYj/wa4Q43UuYdI7jdDfnTtV7EGMJ2HvFTKaDb0Mm9df
	UJk4B28tbA1HFKNInGgB1LZ3RLW2MNMY7QuHqjJGVhEmrwbHccO1n5gEcDeX0TMpuzuplHa7nem
	1AJv3RbxXWkmI4CMS9EOzgx/hA7cMexWWKqfs371jnq1X7BzyJ79xl9yZBrZe3ktmxCDFhFacQO
	jSAvPJyUh5L03UqnmklaLRW9Qgf5fXIDlf51Gs9h7KHT5fk5KkzpEgUm1ru6aQdsefgSOZEwmg1
	85AqH+mH
X-Received: by 2002:a05:600d:6409:20b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-490426d4292mr30314705e9.26.1779447691467; Fri, 22 May 2026
 04:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
 <20260519123547.2055911-3-maoyixie.tju@gmail.com> <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
 <CAHPEe=GX7wsLetw7rnOpeSkc05Jgi3h5y56e0RGYa4dszK1E4Q@mail.gmail.com> <CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com>
In-Reply-To: <CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 22 May 2026 19:01:20 +0800
X-Gm-Features: AVHnY4I0Fvyme3rhgKLHLJz5BAKgNMgi22LPqHMxJDUysTWcY-y0ZIQ1DE4YnIE
Message-ID: <CAHPEe=GQpn75GcRM9C_Y+EOSQWhER9DM6o0E3NG_hgobBB0dLQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253760-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B16995B2EA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiao,

You are right. I wrote a PoC and confirmed it on v4.

I used the same setup as the v4 test, just swapped the
SIOCCHGTUNNEL ioctl for `ip link set <name> type vti6 remote X
local Y` from inside the migrated netns. The ip command sends
RTM_NEWLINK with IFLA_INFO_DATA and no IFLA_LINK_NETNSID, so
rtnl_newlink() only checks the attacker's own user_ns. The
message lands in vti6_changelink(), vti6_update() inserts the
device into init_net's hash, and a SIOCGETTUNNEL in init_net for
the new params resolves to the migrated device. The primitive is
the same one v4 2/2 closes for the ioctl path. Only the entry
point differs.

For a fix I tried a small hunk in __rtnl_newlink(), before the
rtnl_changelink() dispatch. The hunk derives the link netns
through dev->rtnl_link_ops->get_link_net() when that callback
exists. If the link netns differs from tgt_net, it requires
netlink_ns_capable() against link_net->user_ns. I put it there
instead of in vti6_changelink() because the same gap applies to
other link_types with get_link_net (ipip, gre, sit, ip6_tnl),
and one site covers them all. link_types without get_link_net
would see no behaviour change.

I re-ran the PoC on v4 with that hunk applied. It returns
"Operation not permitted" and init_net's hash is unchanged.

I'd like to send this as a follow-up after v4 lands, since the
fix lives in net/core/rtnetlink.c rather than in vti6. v4 would
stay scoped to the ioctl path. Would that work for you?

Thanks again,
Maoyi

