Return-Path: <stable+bounces-253423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOujGXdeDmo4+AUAu9opvQ
	(envelope-from <stable+bounces-253423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:23:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A75E659DA23
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 145BA303206A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69242233957;
	Thu, 21 May 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sg4KjT3w"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E41F2B8D
	for <stable@vger.kernel.org>; Thu, 21 May 2026 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779326536; cv=none; b=oDx+LsEXaMFXyF+Jf2o5EvwfNGlFGLv0U2MO8GLfLUTbKRAqvfYb3miPaeba0SmUbNHtdtPUxjuZihqhSGw+oYhFYevrvucNiBqD8BXYwgoG2PrMyQKvIu4zoX2hB+dGGjH1ALOLSqzbu7q454FXl0yidLzyQYZG2vwXFQQpGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779326536; c=relaxed/simple;
	bh=iXYeNMolJbRd39MbtVrFvn+d8uBKryjaTMV1KB7WaTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbjcPsItw9lf7Z1ctvz/fQyBfFyD7w0qrPp42rzON9tmk4sVrYkuMMLhgk9i2YOAvpkzurW7wSwV4b5zDpJjSIfMTeSZhipJlgfpIMF2NxzhtIH9WXKuLXujt9JoKA5DoUMczSYIzzGud7I4DjPgalj7z4dT8CHm7u5hyfYW4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sg4KjT3w; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 May 2026 09:21:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779326531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izokvCRecj6YBkBqGekrB2lOtI15tTbxtnpgYepVM60=;
	b=Sg4KjT3ws7EB4Eoxlkn0/e8cFM4rPLHz1g35SPVQTTOgwB+ZD1uu6MPVOxcFCWppfRphyu
	HoHk7NGweenTLlfQ+VLYaDtXajjO8IjK1roUlG1nZNxqw4q0uTaySHtmCMqTMkxQewUgGB
	+XKfSvYk5AGvxLFxgfzmrUwZqUyQaYQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bot+bpf-ci@kernel.org, rollkingzzc@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com, 
	stable@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <otd2foetoykizfxkoxmcfmjv2pb7wilm44q77kyzi23zoudbeq@oun3vnsfzwio>
References: <20260520102715.3033936-1-rollkingzzc@gmail.com>
 <646104384170b8d95ce979ba3d0bd87a808e5dd2a1f6b2bc4e0a346ca38e654d@mail.kernel.org>
 <ds3zog2r7avfbiu6je6v24oevvg3ogaegkrjdv3w7ibm5eb7hy@unozyvsnb2ou>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ds3zog2r7avfbiu6je6v24oevvg3ogaegkrjdv3w7ibm5eb7hy@unozyvsnb2ou>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253423-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,meta.com];
	TAGGED_RCPT(0.00)[stable,bpf-ci];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A75E659DA23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:59:14AM +0800, John Fastabend wrote:
> On Wed, May 20, 2026 at 11:09:36AM +0000, bot+bpf-ci@kernel.org wrote:
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 9590877b0714..223d78708486 100644
> > > --- a/net/core/filter.c
[...]
> > 
> > Could the ring buffer state become corrupted when data is appended exactly
> > at the end of the message and the ring buffer is full?
> > 
> > If data is appended exactly at the end of the message (start == offset +
> > l), the loop finishes with i pointing to the unused slot msg->sg.end. If
> > the ring buffer is full (!space), the coalescing fallback logic reads:
> > 
> >    copy = msg->sg.data[i].length
> > 
> > Because i points to an unused slot, its length is 0, making copy == 0, and
> > the fallback coalescing block is bypassed. The function then
> > unconditionally calls:
> > 
> >    sk_msg_iter_next(msg, end)
> > 
> > which increments msg->sg.end. Since the ring buffer was already full,
> > advancing msg->sg.end causes it to wrap around and equal msg->sg.start.
> > This could corrupt the ring buffer state and overwrite the first element
> > without calling put_page(), leading to page leaks.
> 
> ^^^
> 
> This one I haven't looked into yet. Let me know if you have time to get
> to above two issues this week would be great to get a v1 out at least.
> 
> Thanks,
> John

Hi John,

Those issues have been reported by Weiming and corresponding patchs look good to me.

https://lore.kernel.org/bpf/11e4c78b-dd7b-44f7-800f-cf64517f4a1d@linux.dev/
https://lore.kernel.org/bpf/1f2485da-257f-4654-a2cd-8108228ece46@linux.dev/
https://lore.kernel.org/bpf/daab27eb-2763-462b-8a9f-34adf0c92e0b@linux.dev/

But unfortunately those patchs has been archived automatically. I think I can
just resend those patchs with Weiming's credit (author), and with your review
tags, those patchs can be merged sucessfully.

