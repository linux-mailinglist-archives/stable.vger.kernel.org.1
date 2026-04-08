Return-Path: <stable+bounces-233759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNbRDlLr1Wkd/QcAu9opvQ
	(envelope-from <stable+bounces-233759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:44:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C68913B756E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E02D3016524
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 05:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48F35A933;
	Wed,  8 Apr 2026 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B1QZrFsu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31D35AC2B
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627044; cv=none; b=GaLy9B/AQPyClNhWgDDlpLR/C9VPebosZx7PLTnJyBy4SnQNREbbnaBwFl429GUp4zKVIIxKHG0AaUIbY9X6TA4xUEvq+GrtQ0mGNo11bvrrsvTQ/ntH1Hzh6sh/a4hF16pd8+YUk5cvGCzxMy22givUXKPOJWhoPVMOnXweilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627044; c=relaxed/simple;
	bh=BDT7Qm2fqqnYPI3dSRtcTXDHcWY+5BksXvBw2+moe+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiaFI197F+Q0xSg4Hj021HsbwkQ5pDnmZe9zzwgYy4ll3HUJa2hZGj7v23x8xJnWqRho9ZPQHw9EQOQZnE/wYXGyg7tH5zOvkXf6EzNPVtFyU46hI8Ip/UGNXunMu9Vs12CZhH6BcG6540z+Jqt5wAAbQPLE+wMTEnCyBjxYKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B1QZrFsu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0046078so29197805e9.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 22:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775627041; x=1776231841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f4CTw1zZ+1g6N8RAuGXFjoPZ4xIpArIKPStEduXE09Q=;
        b=B1QZrFsuQOEcoRyfhzhQeqthqzevNqoUiUENqF2ZQyAqt6aExtrkoOFXVD5yTT6wtS
         75fjMY5zrAEGzR1jGzXuWW6v8JX3viGInwVKjZ5BEZKgIIUd/jS9tlRukv2CJws0NsTj
         HpnmpfKetlFbp4vSTMOudRQlrjGoZ6IBQ+ICK7f2GA2D5Ne+/mZnFZrjncPHZiMTlNA6
         dFVhSKwzl/cZABz3VpPmwlnWutrt8+G1MWCXmR5vOFZSpfIIw+8T0Q4wClIFwpp+fik6
         HpHLA5axXVml2rHAo/HNDuY+RuPD179KHVUBSuR2SIjIExbPSadBsaUkiUyC4dV+R9Ej
         WaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775627041; x=1776231841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4CTw1zZ+1g6N8RAuGXFjoPZ4xIpArIKPStEduXE09Q=;
        b=brnnraJ3bOJN6GtruePWEWIfdduIVp4zVpofDFskz2t2ar7vlQuoKjb4wyCRU4z/6t
         QDcWjItATGnjnawGu4OZC7a6KITcii6x14Fhpv5Y1qrhc99AMcJGNHFNHiqOamRih8FT
         vtV+q833xHuli0tEKxbwQNOWWPTPSGIPi7fNNy9pXxpNNlXVz/hqNLTQI6qZhVCWch8r
         8M8EFIwDcA7GbEMtuxjK7fKVWJJmYd5ZSiA2VPZCFol5WHUqKnmyioBz/8sj3s9nzIHx
         PNizD6/kVdej7lBiWX9l2/Xg2skRSk6hhkaWdaIUo3UJANA+BDItO4AEW0B/zGnGGAAp
         IB2g==
X-Forwarded-Encrypted: i=1; AJvYcCVhQ9oEWFWnDq/9SDCJkRd3sV7Uk8/nano3HSmG+ew3VVikM5G7vdsGIrTOIMjr689tARDYWfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QmYmToRYz0dFyyuRHVU+XUqdNgZpBVL+ZhsPC/+Tajzr9VHz
	xiPBsOp/wTxua+oxd5r38xzpSkGDe/LJWnEEUF2pvO/YvGe1Y6DZaAYe5jXSEwyAHso=
X-Gm-Gg: AeBDievMefyPJHgg+z7IxlMTAIH4D+glBAdmLwwM/jykcgqIZ/q15NpfmDsmCTz2Gj4
	v4QD/0B4oPlMMjaa6eNWzCELTUKsqT1YuLAuvEFqhPUQwJgyE+QQwrOkLJJuRT230NP/LM9sSwg
	99hHZ1ZIT1whGcKQn98uJemjPIy7hyeSqktx9bCZG6GtaMrhTHUkp3Kwb5yfeVX1K16VXJnW5NB
	UfzftgI31JpPdOTLOv3XIC2dMXCcflKnh/bWxYg/I5CfIh2vRjnTckluz6nVn9Q3s0OGDVN4WCf
	oF1JQy6JVTz9vMKQI47nJpbRoGkDCPqY+AXXyNWhaXx8RCoWUTofm8u9gVddNTK0dqRjuAMv3c/
	aGE9gojarXGz+X5LLBtN3rGnvg6j52E0+xfFnwr+c0LqU9lreDigWiRFQhbZiThojdYD2Wt3GYg
	W4uCaD1WJeo3ugjvb0j6Vm3nAhQvKHDzvNRiQCYyKym8sxMg==
X-Received: by 2002:a05:600c:4e86:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-488997c9b69mr259346165e9.29.1775627041321;
        Tue, 07 Apr 2026 22:44:01 -0700 (PDT)
Received: from u94a (27-240-66-218.adsl.fetnet.net. [27.240.66.218])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6058304af93sm19968010137.7.2026.04.07.22.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 22:43:59 -0700 (PDT)
Date: Wed, 8 Apr 2026 13:43:46 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, stable <stable@vger.kernel.org>, patches@lists.linux.dev, 
	Andrea Righi <arighi@nvidia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 034/244] bpf: Fix u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <uhk2bpssg5mm4u4mgxqa236rzvzph5e6r45i2dwxidiywk6qrp@62v35ebjwya2>
References: <20260331161741.651718120@linuxfoundation.org>
 <20260331161742.960922011@linuxfoundation.org>
 <i4c753x3y67ek3r7dp774pcmaaaid3gvxcsvdssosdingre4in@od45qzitwtrf>
 <2026040115-dose-aerobics-7c6d@gregkh>
 <CAADnVQLSfDtqeLFw=DjG-dG=xD_qS7p2LHsT9jAxO5aAK0YJig@mail.gmail.com>
 <ac1LCTbV5ZnqUgG0@mail.gmail.com>
 <2026040240-friday-gurgling-7088@gregkh>
 <ac5MrSA8VbSNdlG_@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5MrSA8VbSNdlG_@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233759-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,vger.kernel.org,lists.linux.dev,nvidia.com,etsalapatis.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,suse.com:dkim]
X-Rspamd-Queue-Id: C68913B756E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:02:05PM +0200, Paul Chaignon wrote:
> On Thu, Apr 02, 2026 at 12:46:10PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 01, 2026 at 06:42:49PM +0200, Paul Chaignon wrote:
> > > On Wed, Apr 01, 2026 at 07:32:26AM -0700, Alexei Starovoitov wrote:
> > > > On Wed, Apr 1, 2026 at 4:44 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Wed, Apr 01, 2026 at 02:22:58PM +0800, Shung-Hsi Yu wrote:
...
> > > > I suggest ignoring the selftest failures.
> > > > The patch is necessary for stable and backports.
> > > > It's fixing a real issue.

Ack. I was only thinking about register invariant violation, but hadn't
thought about the scx_layered sched_ext scheduler load failure that was
reported by Andrea.

Come to think of it efc11a667878 ("bpf: Improve bounds when tnum has a
single possible value") probably should be brought in for similar
reason. I'll prepare and sent it to 6.12 (and earlier, if possible)
later this week.

...
> > Can you send the 2 patches needed here and I will queue them up.
> 
> Will do. Thanks!

Thanks!

