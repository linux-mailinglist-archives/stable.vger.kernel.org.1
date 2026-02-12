Return-Path: <stable+bounces-215972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INs4EiDrjWn78gAAu9opvQ
	(envelope-from <stable+bounces-215972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:00:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A054512EB5B
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B47301187B
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CC35C1B4;
	Thu, 12 Feb 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Yvwdi7HJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66F346A1F
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908369; cv=pass; b=EpiChnhK3Jy1rWaTUZuUculzV6DDzPj7gyy2dXiyYLPnXHT2M/jBKObQlykrVvmkckIX5ZB9GZnyCdSaJoqXWmU1KVLPsf8NV22gF2pA7rrTx9D6S62RfaDki9VY1pB5s3r35wVLIPa0siCLeiTMrTx/MbmwWiU8ECjUpZYn58A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908369; c=relaxed/simple;
	bh=yGn21hxAcgcmG+63AgS3v0qYovGfQ2LjythatUWGR20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAQuHfqNpLDuh3EAe42L5o9Cni1VXhMEfPSCtOhvIbxxD+9uPytC1mvDXy18aWNrUQVDLVqJwDk2qVub+m0h0suTASVRfzXHN/gYT6vADFvROKMr4sjpPHDjqH0f4mSyroaoUJPQ+kDA6TM5QoruMQUrJUE5uXF/dNhHSNOre9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Yvwdi7HJ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64acd19e1dfso5813324d50.0
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 06:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770908367; cv=none;
        d=google.com; s=arc-20240605;
        b=hKHpXzsmtdQ7+FGHZ93dNYFGqxaLKwhd+0t1uGY1dBrY3hL3a6VibutC7lew0pXEIL
         trHwH5nz7i30eS64APT1/a7kAt8zj+U3mcWe3mz3YoNoNW/be5qMscbZnMGgBgkK1QkE
         GlbwA0T+hR4mPAZGLbb0iiZmrnnVnYex+wlRkSCGffxrAPrjASzNwhvHeYgb1snHFxx9
         5DNhWBw5S9vQ2y9PVWHyJPl1Bjzs63PGBhxi5K4RjeUoKyLG2jbnbDVzpK/NJAOfzigE
         z8fm4BqnEPtRqhQqkA/tCXO2onTR9T3+wUmEIdEHt5lms7FW06XdjpZXAzwZys9F6QpG
         hKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yGn21hxAcgcmG+63AgS3v0qYovGfQ2LjythatUWGR20=;
        fh=UynA+3jLEGYxcrmXpvT/CdJKV3yeZGugu/vn3QIGjRk=;
        b=kDX5+SVIkLjoASwXbkRh4zuL0rhPm/kcUMCnO8BX8fkaxBlCIu+VutoqEqZbFO444f
         cV8rU9HBieR/jKqCHFuMIKL5kyy382AZoqAlSXBTFiOcUo9aVRCV8vtYLb3QLB93LEij
         CObrv/DDKgIxZJEHLAFS7UYjNZA1raVaZmkt3ZWi3/sKZYxFWXPQkaHkSaUMhDlWBYUF
         Cxnzdy6S6XwcQiKaqjtknOI+hxeJF/xFjocJEQkkmdGV0sUWhDwqBW65fxp8ekYi4UeM
         WvivdCq3mra0dXCZ1jigowu+e5AB+joBULdk4mzqlXG97/0pLsrZ5q0Sla2IDmhGq/1s
         jz8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770908367; x=1771513167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGn21hxAcgcmG+63AgS3v0qYovGfQ2LjythatUWGR20=;
        b=Yvwdi7HJ/E6jYa4h50wEB/QaCtgajK2q4JzXlvGgT1cfgxnb51/j72cgaSW1PrzuV5
         REn7gVIVfLVuR/r514dbSbi1FdIy1eeDZXOuky1pSH7UTeE1or3V+DYnY9dLPF+0Wd/j
         UtJ+QD19NdJL4TZBrOStakGPbL29U+jxnV5FCOpmoeWpxM2/7jR8BBOyuQ4wlSYMoGph
         /Y/gTCS9n7F3Cr9ztxAoa62H+brzrwbkBbgBNxU2TKgO9B+sihQDR+jPZllYyBRpvhgR
         3OIJsXo64TBxe2Kiz+WpuXWq3oqvcZybpTBdNkSWgud1KJ9zSfrCNmAi/5eSL9FbZ7mv
         4k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770908367; x=1771513167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGn21hxAcgcmG+63AgS3v0qYovGfQ2LjythatUWGR20=;
        b=tLOD7LXtsBJo2hxz1aeRPXMYWjicUQF6nf6BcOa7eJECIvdoA+84LLBjKtiaEZrMXM
         4oFbokhtY0ZfggzCe71cMCRidjyzdg3/XZnlhkXnsCzjX0tQZST1kF71vScZMPfelOAm
         xrClX3uSCpWZfKDM/LTrPqHkRXv0RiUTQ4mwTbsUWNYS33kGd4M/qKO9Xw32ceoNxRgg
         kqSPyyFJy06/1cfOppHfX0iYnUpcCG+fiSMcdA5ybOVNHIxSJAW7eZluoV7XtRw7y86J
         MK4zIPD+NymZqXn9UnRwEsebDCn6bjOxzP+gNC1GQhDueW3qz52MNxC1D1s2X46/8/Fn
         yT3A==
X-Forwarded-Encrypted: i=1; AJvYcCXefG8qz4u+ZEc6lZsH+yMt98QcG68BjwZmFE2znPFGoQ86/IVuf5Nl8R/fbElGceJwAur/Vwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4wvJPTgI9DrCOmCDN/0SJgipVlJ6fodb/EB7BwRLFBTR1H9u
	gX5aObwZQ7fbN2wOqJi4nle9WxeVqJ1HTqKg44//dK4ANrOULKawf18it8L7HjsNfTwTUuO/6a8
	bQD72DVvwfFpI2gfrveFdyNl+NapdtFBngI9Rc+wi
X-Gm-Gg: AZuq6aKTXOsYbuHsU5LGx4KJCUvaDyzfsgfasRc9/NkxHJt5zzVNTvFWFCtf6i2QNtN
	gANQlyZdr4PocOXDSunuxlZyBq21D95Saoe6rw/tRgQaalB/oIOxpvOQvVdnNx5Z1wZGbpg3Z+H
	0tztOHelhasFwGGEPZxrfzcfIFTFV8MuZ7++YVSSv72seC9nYF8q2I2759ReiwIku0IxoIuxnGb
	Bmhsd6M2bw1zUu3NJibzkB3fJdwvtP586Fwrg7Xc7aXXyBKpYPSEa1sRr3W9gnbPrZ8/ZmQbiC/
	Jucxap2eFuqhWA2r+p2sCA==
X-Received: by 2002:a53:b1a2:0:b0:63f:af33:e413 with SMTP id
 956f58d0204a3-64bbaa3b703mr2031466d50.24.1770908367555; Thu, 12 Feb 2026
 06:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205150958.412278-1-p@1g4.org> <20260205150958.412278-2-p@1g4.org>
 <CA+NMeC_v8bQo2tFUYiD1faMJ0Gd9FFbqmPHCvBUD7HW_yoCx0A@mail.gmail.com> <nmLWEyw7BWgMgTdbfbxbYI1QqIF-IPdNFFsdf_T8qY8IBncn1bNnTPDe9Bz1AWfsGVt4pgj8wLzhB1DxZ1-RzuZiW2VZLamsaBS4WpjC8lw=@1g4.org>
In-Reply-To: <nmLWEyw7BWgMgTdbfbxbYI1QqIF-IPdNFFsdf_T8qY8IBncn1bNnTPDe9Bz1AWfsGVt4pgj8wLzhB1DxZ1-RzuZiW2VZLamsaBS4WpjC8lw=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 12 Feb 2026 11:59:16 -0300
X-Gm-Features: AZwV_QgRSL8UTzEEJf1PL2FE1zP9TG_DIZ0npWBwNFXgTFImvInzr5hzqmp5_ls
Message-ID: <CA+NMeC9XPutYDqbpYDuhyOp5tVUp-knoujWOHNf1reg=eY3Kcw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215972-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A054512EB5B
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 9:18=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> Proposed changes from v5...v6:
> [...]

I think I understand what you are saying, but I believe I'll be able to
give you better comments once I see the code.

cheers,
Victor

