Return-Path: <stable+bounces-259885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g3tHEegnH2rniAAAu9opvQ
	(envelope-from <stable+bounces-259885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:58:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75963140F
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:58:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="W+d/SJpj";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259885-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259885-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 997383030F62
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5B4397350;
	Tue,  2 Jun 2026 18:58:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569939BFFA
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:58:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426725; cv=none; b=txQLuOTqD3KOfR/qZhPSQdP8c8QsBCMgJrG1+td06L6dfPvAvQDM0iC8cRPFQHSAxiU08jblPezYUrK9QyoLs7qrdwEyOQD+QclB4aSRzSocGbmRhsimZpBUBRoF+x6414amuv1e7R4zr1MeW5ww5W0pZIkWKAXrQ1JMUF8Mres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426725; c=relaxed/simple;
	bh=7LkdEUA0y3/p+ryu6li6oJvALaS5aTl826KcR1MWdA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdtYVfE15jZGGqO0YtwThdCuhCv32TA+pbdba7Tprh8ahxeFBieq3ggS/X1RwBleOXypbdOjkFOa4ifKWPPXvJb1SL6DiVYwWmkpDCnv/2iLvZEDdcsXkm9ZcKOofmegCZp+pwX/HwXcAUyn9oN547st3VDFrNu3cGiX+9Xs4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+d/SJpj; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso99545095e9.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780426723; x=1781031523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTzkY4YSmlGgs5z2MFn/des66hQt2BWZhG14P08s7yg=;
        b=W+d/SJpj8DW8X9/v1L7GN7C1tHYF5aJncrMH0y8SEKjvhCNkiH4ey/ocgUlJo/QqLj
         C7Kgu0KjlJAQBB5Dq8QZ6IEN7MQWNhUirSdSbcD8bvfNUKqzxurVLw7ww6MHGcIL2hXl
         GEWEBKOx7yj2nhpWfaH9FQIoCZFZxkAjp9YiF9P3dYJWw0Jz0A0/r1fkBbCdVHl0s2tI
         Jd7X0Aj75iW+SS9gtIj9tQt5jCqwWGpS2ALpIHJvPo4bcnys4/Hj9spE+QmL+/TuOP6d
         bRWPPSmCpl042Nkp0J6xLfSVvcJfz5/oTNWTJnmVADzJ+rWnMJwMd0JvGz8XPjku7Aee
         EzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780426723; x=1781031523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTzkY4YSmlGgs5z2MFn/des66hQt2BWZhG14P08s7yg=;
        b=W+TN4u16HgXoFNlKue3t6JEkVfZCS2aOXLjedFz6t5hT9mCIy6rMxBeM95ibjX1ZBK
         7l5+rG+kC7RFAE3BGkD8PYR/NyTG9wQBZwnOEjcS4hZwkWsQSp43Ez2Sv2NalLb9yfeQ
         aZEbU6rl/TYUqJ+Jd7Jn0sijWbCznpmN6MhX7X5CUKFb34fjbSGY7UL2ojlrm+Bgmo4o
         amSqD5YCSZTmT8buTMLxbUXUWgDwk47yZW2FyyKFIxCQL+WSUtUY+rby+TZ1Yzjn1XGy
         MPeQJPOOaJqb9RFKNFq8QB6CMU5Ur5TG3MtvoAAFH3wAD2raxUgRO2zm8V0YnSmc9+dN
         XmgA==
X-Gm-Message-State: AOJu0YwzZoIU+O4R0wkLDUMAq3sVsLYRlnQs2wt4iWs73D2XbG3AI6o2
	YdA64FPj9siD66KbRWLFoxksdzsfcZvt+3mhXZAZChErowDAW+HApPUMwOVsOUXQ
X-Gm-Gg: Acq92OEGwHgikBOUZTZknkvn7eRxWhmdRxyMS6S5Hh8EZbjNY8HNTG2NSKNKHWYX3rg
	3ZCa3lINHTJTgqfOOREg0qlET3wU91EUcobg3vmiTZ79zZWco63vGr8yvG7ujRtESzu0CJ2totg
	tgmF8We/2flSdXq3lNEICNhkZrXb5gwICteSeys+jB8zg6r77z3Eeu7ElsVaG5QN9vKTHxa9OfJ
	4pII2Otp5hZQ/RkmIjCJCasKYFI1tCDD8CEqJ8sHLwcP3II7fsoEFmu+7F+lQGL59xM4jk6K9t9
	WeKaLNmgHhQQiN1VrgZw8u/4RwS/IKRze9LIZPAmsKJ68B8lgk+N+h5YTX366+lacRF6QvRR0oE
	dD3QXG5Av5qaix5euy0P+bVc2yH79buq/Sfh+z2yBbha3AM5vRBxr46nFfm670PDRU1D2rPYDRK
	1B/JsjxzAy4V+dgahgcPsdDRtrP+an/jaz49490DPeB+q9qXez4TGgQS9KHWLcQUv7S2wOFQCOR
	DhPko5GXjcumEgeFNtuc+b9Y1lXtuaHX4QwyF80PemL/LP0R3RhNGbhxe8BxV3qvcYP3bx5VraZ
	JCbqueigkldj4/m03sLd/BsBqzID5gBBXWcPJj9qnid1TVQt/Za+8Q==
X-Received: by 2002:a05:600c:c48e:b0:490:625e:bb68 with SMTP id 5b1f17b1804b1-490b5eb7369mr1309565e9.3.1780426722598;
        Tue, 02 Jun 2026 11:58:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60fa46dsm346045e9.4.2026.06.02.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:58:41 -0700 (PDT)
Date: Tue, 2 Jun 2026 20:58:39 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: Re: [PATCH 6.1.y 00/11] Fix BPF selftests
Message-ID: <ah8n348Ad6LTDgdO@mail.gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
 <20260602180500.bpf-selftests-reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602180500.bpf-selftests-reply@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259885-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:shung-hsi.yu@suse.com,m:daniel@iogearbox.net,m:ast@kernel.org,m:eddyz87@gmail.com,m:andrii@kernel.org,m:martin.lau@kernel.org,m:sdf@google.com,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:paul.chaignon@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,google.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B75963140F

On Tue, Jun 02, 2026 at 02:21:19PM -0400, Sasha Levin wrote:
> On Tue, Jun 02, 2026 at 11:28:43AM +0200, Paul Chaignon wrote:
> > [PATCH 6.1.y 00/11] Fix BPF selftests
> 
> Thanks for the series. Patch 1/11 doesn't apply to current 6.1.y: its Makefile
> hunk context references json_writer.c in TRUNNER_EXTRA_SOURCES, but 6.1.y only
> has cap_helpers.c there.

Sorry about that. I know what I messed up. I'll send a v2.

> 
> -- 
> Thanks,
> Sasha

