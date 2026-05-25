Return-Path: <stable+bounces-254137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBRuKapDFGqmLQcAu9opvQ
	(envelope-from <stable+bounces-254137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:42:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E64135CA9FB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4B33015C8E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D726382369;
	Mon, 25 May 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOYnkIol";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoKsHsT+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E22E424F
	for <stable@vger.kernel.org>; Mon, 25 May 2026 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712931; cv=none; b=fYZWCViDAxfFzPwa8zU8aU02IYR5ROC/wOQRf7yFyzF/LGExdGUMpe36QTP4g46r68bwvK4Y2UP6Xhth999SmjYhNU3A7HBAv5wT1+ak9tCborMp0M/De/98rCS5YsEzgkkQatbqPx/cA5WeyHKLnkmQt8YOj362+M24EHRe19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712931; c=relaxed/simple;
	bh=nBZFB/qKiQFEmkpum3LmDBV+XZABkX4tDlOB6EU6g/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL0r3DgxRLDY8DCnY1VoUy9Gr4UGQpfbjt6/jfsY/dmscqyqMDn38oOtr/bK+Z+UA6LQsDU7+8F7bp6llJcMQZvj8XZuh2ty0kR74eoOfniqQVkNhzoVu0xRH+CzLKfHxKYHMv16saqSSekcQJcDLfw0V63qvmue9EdQBJNx9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOYnkIol; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoKsHsT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779712929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2mO9ihHPbnXM6c2+MtWPyD/ZxOr74sqrY+NK7spw+c=;
	b=BOYnkIolC/QsgdcBu0A7lXkN/AnR+4FlBO9j+CToxSx2HqeeSMTCbnCYbHoEWO9hnoQ5/v
	9MRrhskAbrtAhzPT3X/+hmxQaMveaL2RjmFnDcSthfVVT6xvcq2tu3YHepXsGbD94zB/w4
	85qIDlNrlBFKa+CiWSaEclZLhJoIArY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-y3_B1YypO3-1IdLklvas4A-1; Mon, 25 May 2026 08:42:07 -0400
X-MC-Unique: y3_B1YypO3-1IdLklvas4A-1
X-Mimecast-MFC-AGG-ID: y3_B1YypO3-1IdLklvas4A_1779712926
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4518f777225so6881671f8f.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779712926; x=1780317726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2mO9ihHPbnXM6c2+MtWPyD/ZxOr74sqrY+NK7spw+c=;
        b=VoKsHsT+E9v36NgANdIVDxnzvmPXBdCzjU182ePme/onYYVA+/QIX1cRo3OSvMcrQW
         Hayz8BQq8zdvo4QkHcpz589X3Lgjv57CqBO2YnEHh4u/kGKYltHLLXzgwXhmDKqh/8+v
         jO6v45NmFodBqyFBHAODgDWQomU4D4KW3ZzJ60tGZQz48rHML7i0n+nzRhquE3vOiSGA
         PWHv22G7hAifGs40ngnyx9YAPWd+0OsXktep1VnC+lqM4ixpMbjrvALcuXJ/3eGMWIZu
         GG+ovmkuSeESVggZECz4qsSQO8z/SzcXkN/uQDFBWxMsbDYuGtDrEgciI+wScgtxt/k6
         OwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779712926; x=1780317726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2mO9ihHPbnXM6c2+MtWPyD/ZxOr74sqrY+NK7spw+c=;
        b=Hlg4HkrX7M/iCpBKxPQaAa3trZaAJEz8tI94hxgxA+mnUnY69xBR8CPcteCFftCE/H
         fC/hpwg0FS1aLJ4tNyLOHP8d/YZ70E+BRVu6ctLCFNF18AGvfprwf5XNhw2KXstFrsuB
         96Fp9Bsj4/DJRkWPFxn5/HRcTPu9LfDb0NDPBIQGZkwUR+QstmPXjIFw+cYO3LYohzvh
         eUUrwEODocrh/Le9UrlObSNhn+bihhhcd3ao4E3Wm14KP573awmeyK0uP60As4mX9pTT
         UkrWWdxMvGO4JWjWh/0zKMhgUJYEl6Ajnx31ohjT5nUWCYA4CuqguwQx1U8mdHa8hBpK
         jAQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nMDwVBg1Ej9Im9SgO+YfHiyWYgFJI28fechbC2Wuv0BvWpC36RhnF9EgY2+D9+V6mSnbv1X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgwGVJHHwB9onePJKqdAWAKHqpDpNVjizj0kTGBFuNB76aAzi
	8CRGMFCqihzYBtMa/q3ids7MKmRzN5AB8EpEjNmU5Z9HSma/TXB7LyhAC+ujaViK+IzxSSrMvlm
	/J8tqbs77ZAb0wK9TCK+FPWFeckjTLZY6x4bgzRdKR8Nw1+4sXFBhQsTQ9A==
X-Gm-Gg: Acq92OHHOgdQk14Hm7X/T/gRJ8DFuoAIhLx7KXOdho6NTRPJzNATPPAiIegdS4hJWLY
	PoaRdm7yKmY/uic+3ePa8/CgbQgi9G5JkN1tkEx5nB4f/6tmWcV8E8BgTSEOMEpQnRU7wQRAzK5
	2iCBaxZeO8nDHzNrl/ArnCCjpma/+8rJvJK0S1GeQvPe0bFJQ51fykaeYcpGlIx7tv0MqY/K97E
	qDYPrtbLWgDnZk4okiAcnjSU97f9QiBKL2u22lqZE8uxkDvHQCOF8PIYCXHLXpuGLTycnMPsqQN
	nmsMGU5oJZrG5CTT7jJZfRMoCBND0roYzp9Hnry11LHyjNHFWqcD+KNIU/0CvfvV5crFi9ESvh/
	D5tzzRnuFOwSnRQkj07On98QJzcoVGCFUoLqwO+YtWwn4pzqrYSXAug==
X-Received: by 2002:a05:6000:4605:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45eb3687941mr23325973f8f.17.1779712925852;
        Mon, 25 May 2026 05:42:05 -0700 (PDT)
X-Received: by 2002:a05:6000:4605:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45eb3687941mr23325918f8f.17.1779712925385;
        Mon, 25 May 2026 05:42:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4850dsm25575281f8f.17.2026.05.25.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:42:04 -0700 (PDT)
Date: Mon, 25 May 2026 08:42:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, horms@kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
	pabeni@redhat.com, davem@davemloft.net, jasowang@redhat.com,
	stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525083859-mutt-send-email-mst@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
 <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
 <20260525115314.3cf310e6@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525115314.3cf310e6@pumpkin>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254137-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdevbpf];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E64135CA9FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote:
> On Mon, 25 May 2026 11:57:45 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
> > >On Sat, 23 May 2026 02:20:29 +0000
> > >patchwork-bot+netdevbpf@kernel.org wrote:
> > >  
> > >> Hello:
> > >>
> > >> This patch was applied to netdev/net.git (main)
> > >> by Jakub Kicinski <kuba@kernel.org>:  
> > >
> > >Did anyone else notice that is isn't a bug?
> > >
> > >There is no way that a 'count of bytes of kernel memory' can overflow
> > >the size of 'long'.  
> > 
> > It's more of an estimate than an actual calculation of memory usage if 
> > we queue the incoming packet. In theory, an overflow could occur if the 
> > user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
> > the memory should run out before we get to that check.
> 
> The calculation is:
> 
> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0); 
> 
> skb_queue_len() will be the number of items on the queue.
> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).
> 
> Unless you either corrupt the queue length or manage to allocate skb that use
> less than the minimum about of memory that product can't overflow 'unsigned long'.
> 
> The later calculations might wrap - but the multiply can't.
> 
> -- David


Indeed, I wasn't thinking. For this to even get close to overflowing
we'd have to have almost all of 4G available to the 32 bit kernel taken
up by this single queue.

Revert, I'd say.

> > 
> > Thanks,
> > Stefano
> > 
> > >
> > >-- David
> > >  
> > >>
> > >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:  
> > >> > From: Stefano Garzarella <sgarzare@redhat.com>
> > >> >
> > >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> > >> > to 32-bit values. The multiplication can overflow before being assigned to
> > >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> > >> >
> > >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> > >> > 64-bit arithmetic.
> > >> >
> > >> > [...]  
> > >>
> > >> Here is the summary with links:
> > >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
> > >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> > >>
> > >> You are awesome, thank you!  
> > >  
> > 


