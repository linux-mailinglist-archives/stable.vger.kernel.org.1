Return-Path: <stable+bounces-238053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJumD0Ax32n1PwAAu9opvQ
	(envelope-from <stable+bounces-238053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:33:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD039400DC4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F584301D096
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DD390201;
	Wed, 15 Apr 2026 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk5F4vRg"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BD283FEA
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776234811; cv=pass; b=AKchLLDO3w9SuAE3NWHrdzrqNpUh1vlv3SMzrtwTLKYCcTuZvtjmS00qZ34+cMkn7MDQM7jziESvmCFFJMLU1sYO/vBAkkK0g+nghyrPP6J5y4D4MlhkneqPA2yJcMy7ONy8/CGJrAwrgxIwsWOuMk85rsnqFVVeAZV3tldZpaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776234811; c=relaxed/simple;
	bh=I/YGk6diE6DwfvFh1WTj1ikmEooEeeXvUwgqkLXnYMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyAhMQu4lP6v/KiKrY0qv0KmekED/O09rbCN7pH+aahkzvronoEPDgWLq3QOnXwEyncfeGMSFsz1/IP6EvR03teNK2NjtTznCb0cHo1QG2tfhsOPET9CyQk0pSkKMo/U37kZUJS0y2jeH1OqeU+Ds5JriAqJ9KAIE/k0H7BdcEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk5F4vRg; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-797ab169454so88347847b3.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776234809; cv=none;
        d=google.com; s=arc-20240605;
        b=hnOXWMlDUlLLKdy9raiyyFtwrtNpQnAz83EPoxeLnVAx93PsS7HcfpJElLTVyO9lon
         jZsUKFnzWUJX3YW1yJCdXgQWzXMS+c5WzeFDSEpKAFwwmQxwVDaEzmLoR9vJeDvQJX1c
         ikbZVsZNrk2NAcgFWskqQg4mEPBD8CSLEjL7/QuXHLzRAas4f7/P8woCzdPVw4qQUAiq
         Ptv1p9DoWO99xgXKH78pztZl+Huck/MQxbvJRIQAKdfJa8nJbOlPGvLMJ6aqMJiaH7FW
         6et1da0+oM8U3KXL8ckxDjaxwftRzHXE0kjzUrxW+e4GNQus9Bz/B2UbctEQEefE2R6T
         Lihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I/YGk6diE6DwfvFh1WTj1ikmEooEeeXvUwgqkLXnYMI=;
        fh=qyHZfYUvMqkJag/OxAfOwop79q5Hv6ubCS6uL2Y03wU=;
        b=A2c3kqDkAE/r12qSL7k45zbZvw9ECsfvjY7XrQmVaL6j1FMFzNdRsIIQOpXAIAi3lT
         ytjMuW8wK232NeqdVeb/FlDg9yd2n19FrgB7MWSxyCqxl52tErQzlTMu2Wazfij4mSC9
         uljl5OUzTo7hqvPTc7ffoDuXiZXigdvucjSPicryZfyHeFBp1R/JZjnzLh2pEcPOnsmS
         Ia+6PHoQgcxBOG7Jjm1VFfP5CFzgFTsDlDyi1lTebtG0n+guXnqVRygrPTLh/hogzrxP
         UGnVNWqnfw0mFjPIgZ5xrvMdCZxhsA+6XPIvUohl1ZXMIW64X3EEjOBuavmBVlMicnmU
         AKmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776234809; x=1776839609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/YGk6diE6DwfvFh1WTj1ikmEooEeeXvUwgqkLXnYMI=;
        b=fk5F4vRgR3d32bKCoF0SveC9QkfCfs1LzXWLm/nAV+3/BcZ0m50sq+fVw7fKdwTLBT
         0XFDFENood4KmYUO+zkrYaov3OraNS6jPAkQOHu0RMkbz7kzbzfut3BXrau+lTOWNSaG
         55TXeb747lknnXfq0GWOdB8QoNDrog+7wSK6gn1mJKbCTvgOMhYqn1sjBTmeERTKnYk9
         2TRWukZW63APaLDnceFyKHgQR3g2YZuiSdcUiIFfQSkgGYSjAHx1chLo18LqYIFuUPxl
         EaLwoISicmXSfxV4L37cbjHUQZyQC5TbpZNkx949hPtW1EHRx1gZBlnaSRSjEIv31fr6
         LPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776234809; x=1776839609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/YGk6diE6DwfvFh1WTj1ikmEooEeeXvUwgqkLXnYMI=;
        b=JaKOVjplwaAItMGyUjVVi97WfTNDR1x6DPDWZdcRtE42qXomdjmADw0Tff4z9Uro9g
         mt93drCaBNwNvqxr40yChoAGJsyfqLVBOIRQsGoe4Fmpee8Ule51rIDJmKYY/hfMXD8S
         ts+J4JsFJdyssM301W9my+xzWrrlQwcEDEDjzSEMHs9RBtKFssW4qFtgIiQaGh6vqGPx
         SC6XTngEkkChPB1NIUvEGJqFo4LBiJrrlQgt4flV5ODBUsdSmRkUzuCKEPqZUas4kags
         XnG6nl3kjvV36IAZj5IjxcAuWTQNsoZzmooky3tKXwGRxbpw9rNneQcEJYXB3F3OE0O9
         ifpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BlpGM2fFWbGOKRfn0CDRH6SSTso+pt3ja1AdlyG1hWbOTyjHZ4blrJETkdlI50E+4EY62jk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL5z/AK44hpD/tw30udk694xHbBtpuAYnEo7r/4lEhcA9twq+S
	vz/+hEeukGF4Qrn3+yD3//cGG//63w1Rqno9njiWaWpmEzEZavqyhFbWgjHH1SDpOKmI2vQur4Z
	uD+2apoAJcG8d+oBjedr03lDc/oxjxmo=
X-Gm-Gg: AeBDietO+Pk6udh9oVWeEtgOvjnItnY8fOXzWRPQB+MCB0iM7mt491QYy1/PKxqdqYJ
	OOWJkOn2KUIKgAKJl/ljN7CCZHOIi0eBpNG40zoa9a84tFj8/ny6uUNd8qiEka/X2FecG4eRh+A
	oUgHOp/NiKkMbEYgZXgBKsrdKit5U1f/BctpluErWQJ+Rpe2J2TnC0XZ7Tw9hPLZA2naatOYg6I
	H3WgvE4Lw0K+YH3anUNNHuWdsej0N5IrL3P6mnWktmDtp0Lt0KarEZop+Wrmd77z9Tsc1PSQxqa
	LkDPFa+y0w5PcYxeRVV2v6jSmphD
X-Received: by 2002:a05:690e:14ca:b0:652:ddea:11f1 with SMTP id
 956f58d0204a3-652ddea24a2mr2317961d50.30.1776234809273; Tue, 14 Apr 2026
 23:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413112030.2694563-1-lgs201920130244@gmail.com>
 <5da15f31-e9af-4f8d-82fd-eac29a6d98f6@intel.com> <CANUHTR8uNVWR48xs90s+MtGQ6J-1j5R0+64MKVGin0cf-FjRWA@mail.gmail.com>
 <143881d9-02d5-42be-bf77-9fe9e8353c06@intel.com>
In-Reply-To: <143881d9-02d5-42be-bf77-9fe9e8353c06@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 14:33:16 +0800
X-Gm-Features: AQROBzB0J22GUf7_6jCosTMhAtK8yiANwxMUFPDIVG2xrZyTeQWs76gB0isBNRQ
Message-ID: <CANUHTR_ecExv+7JzJ9G0H7kTnPfOWr+epyvJ=qxGF=SvdCU9BQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] dpf: fix UAF and double free in
 idpf_plug_vport_aux_dev() error path
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238053-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CD039400DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jacob,

Thanks for reviewing.

On Wed, 15 Apr 2026 at 13:37, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> No problem. I had missed the other version, which explains my confusion.
> Still, to my eyes, the fix looks to be an equivalent fix as one
> submitted by GregKH:
>
> https://lore.kernel.org/intel-wired-lan/2026041116-retail-bagginess-250f@gregkh/
>
> Do you agree this is effectively a different fix for the same problem?
> Or is there really two different double-free issues here that both need
> patching? I haven't been able to fully convince my self either way, but
> I am leaning on this being one problem, and I think Gregs solution feels
> simpler to understand.
>
> Thanks,
> Jake
>
> >
> > Thanks,
> > Guangshuo
>
Yes, I agree Greg's patch addresses the same underlying issue.

For the other path in `idpf_plug_core_aux_dev()`, I had also
previously sent a fix, for reference:

v1:
https://lkml.org/lkml/2026/3/18/1822

v2:
https://lkml.org/lkml/2026/3/19/1285

The v2 for the core path was posted after discussion on the list and
incorporated the feedback I received there.

So my understanding is that Greg's patch covers the same class of
issue in both places, while I had sent them as separate fixes.

Thanks,
Guangshuo

