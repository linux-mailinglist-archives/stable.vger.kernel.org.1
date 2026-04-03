Return-Path: <stable+bounces-233237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP18Mc8r0GkH4QYAu9opvQ
	(envelope-from <stable+bounces-233237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 23:06:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 454DE39859E
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 23:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 264123019116
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 21:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCCA357A5E;
	Fri,  3 Apr 2026 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKxTdiwN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F7281357
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250353; cv=none; b=AV+1w1gkRAEqL1gSbxjns0HcQME8kO/XyJVesKf2rQbb0G98HA3fylzaNpWP49PuzM8eRMGF7lIIRODYdMgVnvsFl0UiDu1dgB+4ychp+7sgGoKkMPnwFdi9USDY4p6JQqT3vOcuBoDeJ92nEG+aoMMese3/VJ2ZcCsb2fnuIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250353; c=relaxed/simple;
	bh=APWD87w1TeStgTviD2I3zcHP3gSyMXWMJ6kQhHNwCgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxZ0utk9u6khsdgTduADnX3nWIihK15hApewQQOqchADj2ZDpm9fzGa1p3rVYY+TYUFHeM/ujoCJzwuVRstjbXqC1qt8gDnOTknp6av63GB2QhJuWhvBIuejZi4MTyL3s3iuQ55DWEtZ5/U4+dI3zAzixAnFxFXwPUH6bMTTJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKxTdiwN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso1419173f8f.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775250350; x=1775855150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7niRLiAyFYEmVbefyl4m7ffliWzDDUetiQ50HdVjJVg=;
        b=XKxTdiwNaotZ0kNHiphyp+Zwhp3s85rf8LWXxkvrXuUJUPwuQzqt/xXL/VaLiaf0yL
         I5RuMnthZTMGeNu4EF/0FgleGjY5uiT/aC8Xus3K1BgxEf9F9sY513OceeskJJG6iw32
         Lu4msgTcOyyg9bAiXPGXuyWD46EjpHENel7ktkMZt4KVYV/s1/LnDlpM22oRsnMdgs6t
         6FhpiiFFiCOB0eRFvqT5iv5Wxm32Gi/y8kFTr8mKLUrBZmkvbomWrcTn/MejqHNFn1zU
         FQDfNiIXH1+leG8JqiX9ntY2zFiydHlF5YH/REsxbQf1AE9DlSzW8CGOMdJQ71cqtyOb
         Nogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775250350; x=1775855150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7niRLiAyFYEmVbefyl4m7ffliWzDDUetiQ50HdVjJVg=;
        b=n9ooaoE5R18InYwJosfb6He/M4N1+5W2wHw/cUqqdRLHHBq3bKm/ZmeVT/o0GACqJa
         F9/2HesMRl5SoCWD9kot7h7XzPFz5dLWLd4QYGH3DTN5p5kVPk3dOTjspY/hkuinO+Ru
         6HE8lH9CgPisFxZu+sOZEsxoR15eMA8qdh0pxRPhf1bQEj0yZgzFYd5z5w8zryr1zLuQ
         uzUlRCO7E7v03WHQQEZzlIKBz/8JVzPY9pdVjY4ldM9IZarEVmdhDJ15yhxCydwOmXSE
         uRXwzbcx0GhrzrmMUwjk0+TGYhE2qpbUs500Gj5CdOPzSPZXnrzgYaX+tA10SG58w9Q4
         VfFg==
X-Gm-Message-State: AOJu0YzXyE2rPqancH2NDYILpvxM0LKvJDz0R3XCaqKPqNyF/BaEOl2L
	YN6pJ30TPb2HWGAj/SgeWsLMLx1OPLK5Oq0YhDUPhOvSZf021ZPEiPtb
X-Gm-Gg: AeBDievbanZHrqBW9B9Fo8Sb34nl7UhV3EMEumcFEoTcPpnqQ3S8p2yqXAI4JIL8WFj
	zTiU/eKVColCKISl+I/U/PHGcZMhm5Lwh1TXyiv3gkRGhQvj+mNBPj2Atf0nl/uQrX3Pe+cUK95
	539piR/8/iTtf+1hChwmULjf3dD31ROhHl4PC1CtSTz5yJUtPpblYk1JdZdjkETqshThAr2x/pk
	+YtTMlkhmR4k1BKkLISn90CCiqjBhL/Tb++nxwtScitCQNwI1FMDUJwHoaXTVAOqSeCTgJlgAK9
	6UkJXGIpz8je6DnTkQK0TXwrymXt5IAGUX+ISNui70RybqKpNEeNxpMLwgrE4PlSdvbKeENWCjl
	4IKs+Yp22j5Af6jogsTjJpKM58azQSSK807YNLh2xyUmee4oM97XVOVAVuxgPFZyy97vFcwD1gT
	hqNMkZ/hs8BjymcvvPHAxYLkzctnpE2mu0aMLYJGYyMAZWXCh7AP4ZH5MdgfWAvBshB2RVPEWK4
	Tnp1ylcPFh73vrJ8GyZnmNj1tsPBUZWhYrpUQ99RsC/gMLbXXHYmGSsGV776lYKQAL6wbdaIUbS
	51SbM7+FH6sQ/1WdxfzQDmKnv3gI97EJkfNtL9mI95P2pTTzgHst8g==
X-Received: by 2002:a05:6000:1842:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-43d292ff4dbmr6568509f8f.37.1775250349980;
        Fri, 03 Apr 2026 14:05:49 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00ddf7d804cf24837b.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:ddf7:d804:cf24:837b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f843dsm17813285f8f.37.2026.04.03.14.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:05:49 -0700 (PDT)
Date: Fri, 3 Apr 2026 23:05:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH stable 6.6 0/6] bpf: Fix bounds when ranges cross sign
 boundary
Message-ID: <adArq7uWVYwwTR_4@mail.gmail.com>
References: <cover.1775206731.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775206731.git.paul.chaignon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,suse.com];
	TAGGED_FROM(0.00)[bounces-233237-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 454DE39859E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 05:33:59PM +0200, Paul Chaignon wrote:
> As discussed in [1] yesterday, this series backports two sets of fixes
> for BPF, with their selftests:
> - 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary")
> - 26e5e346a52c ("selftests/bpf: Test cross-sign 64bits range
>   refinement")
> - f96841bbf4a1 ("selftests/bpf: Test invariants on JSLT crossing sign")
> - 5dbb19b16ac4 ("bpf: Add third round of bounds deduction")
> - fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross min/max
>   boundary")
> - f81fdfd16771 ("selftests/bpf: test refining u32/s32 bounds when
>   ranges cross min/max boundary")
> 
> Using Shung-Hsi's stable CI repo [2], I verified the BPF selftests pass
> with these commits applied on top of v6.12.

As hinted here, the subject prefix is incorrect. This series is meant
for v6.12, not v6.6. Should I resend?

> 
> 1: https://lore.kernel.org/stable/2026040240-friday-gurgling-7088@gregkh/
> 2: https://github.com/pchaigno/stable-bpf-ci/actions/runs/23940850516/job/69826632354
> 
> Eduard Zingerman (2):
>   bpf: Fix u32/s32 bounds when ranges cross min/max boundary
>   selftests/bpf: test refining u32/s32 bounds when ranges cross min/max
>     boundary
> 
> Paul Chaignon (4):
>   bpf: Improve bounds when s64 crosses sign boundary
>   selftests/bpf: Test cross-sign 64bits range refinement
>   selftests/bpf: Test invariants on JSLT crossing sign
>   bpf: Add third round of bounds deduction
> 
>  kernel/bpf/verifier.c                         |  77 +++++++++
>  .../selftests/bpf/prog_tests/reg_bounds.c     |  62 ++++++-
>  .../selftests/bpf/progs/verifier_bounds.c     | 159 +++++++++++++++++-
>  3 files changed, 292 insertions(+), 6 deletions(-)
> 
> -- 
> 2.43.0
> 

