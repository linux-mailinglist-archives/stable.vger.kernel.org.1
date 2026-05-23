Return-Path: <stable+bounces-253961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL0mCnXXEWoorQYAu9opvQ
	(envelope-from <stable+bounces-253961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:36:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F45BFDA3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 250723007BA3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6E31F985;
	Sat, 23 May 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns5JaW3q"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D731327A
	for <stable@vger.kernel.org>; Sat, 23 May 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554162; cv=none; b=BrwIa6sXTXvlzcrg+SM184Peihj4/QqjvhFp6eGK6qPPzOwb/jElUc0hBucfUmtFXXEVJTHVPVPQ+v20Bxbl9j38dpXJf8epY7oWvxzJCrBuTGryPRVM6SX22hulWYwRW3LkdHXJ99+DuhbmrnW3N23LD1ha98jnAAobypKNndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554162; c=relaxed/simple;
	bh=SnLk0HaLAeDp9CB1O+cT5QTtRXJhfOlf8pVOAJpSIsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmqiTACty9agSPMEXU65vlWoXCwiJwUjW/QiETnKbW8P6bG9XgPa+N+BpzxkEo9z6cqVf08mOanfiv8DibJ8ccOWZvewJzZFZ/EAN5pQmjeQysW6JgW9QrWu7sKcGj/MFEn6/ET0YBSna4AbiKKJshf9gwOPXX3wB/LMBE2ieW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns5JaW3q; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45297094718so6498613f8f.3
        for <stable@vger.kernel.org>; Sat, 23 May 2026 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779554159; x=1780158959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iqbi0SmV4l8cOiZU/jCD2RWz3CBg4dHUkTOED22sLyI=;
        b=ns5JaW3qxh1lKB1A1AMfQL/YNs5W71qvnoee8vLAr5LSlbmqX2Dqx/ltWDQ0JyqyQq
         j9Dyrhxwh+elQ1GwyrdeuUJ0eERgcDjdOIGbJ78IdpOsbkLY18/bJ4NlDgPuPnJclrlV
         IT4M8ixDjUtmC78JvcnUc0TZooSMJxLoKwDLeobqUeM5+CH0cc9ol1c0ntLESuS1H1Hb
         eEPuU+gpiJo7bagCd1eekOZIz/EU7Lt5ci9GXppLJqY2qCUBk7/qW5c6/QpMr/Rusbo7
         p2QWaZwx5gO9PUHjRAzf0HEFly+cqoeLuBvDSkzfQErmOz/PoG2DHXu0ERATHhxuDCSh
         2w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779554159; x=1780158959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iqbi0SmV4l8cOiZU/jCD2RWz3CBg4dHUkTOED22sLyI=;
        b=myR+etgxqnI8E22sO7mxHWQKspJYzCB6iCmNf24un2yA8JrnwEoBPAFn1EdSoB0lmI
         qzF8ceL8JagOwSJScIFgPkzXDL7y/VC283t65WjTJiJKPfCOG45NW+8fGZx97ulZDptH
         reDP/5XA1EfDllXog3FQTbRcmExh1kTBk0deF4FCWPAcdkIBJnoTbh8XlpLtUhrHRmUC
         B8UGADIBGC8zmWwPwYb1OVUMlX9gsGOfQokVVoPjpyPacDg4OUKZ2HVuiJDeFWfI4Q2+
         3V6h2UcUFOMjAbR+Agpbmt8s6tAu6DcKr8rToc+Yi9C4CZtzezTSrWLGrqg9CNhPG+Pa
         sz7g==
X-Forwarded-Encrypted: i=1; AFNElJ9/RrJFZwSrSxE8FPc60WICMgs6+kJHGIU0dHv6KWnPA4RJ/3U+uSyammwUbL9Wy0w2KJ9wiQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTx/xIhhkwwwNjoeyU3E1ch2//UEoM9SOrmwLdwti9DASZoHi8
	bgjzX7ir9vrEZNDxqGYacfCVR3zgscItWLF05hEzEoHUai6xqytnyJaP
X-Gm-Gg: Acq92OFWLU4It8MKNYUE1dgisldHYoCKDQEkW9K+pINPzz6mwt7SCOW3VmS40EhJDeO
	+g5inyWgKJNF5VqOWrSOfZbCWmG3UCV3YIgeK23jh0jTJ70fn9WrCN9yZ4JvGi8U7cE5Xh0Y30D
	2MxOPgTfPCZWY6aC5WDwDbQDBwPCgarAd7wydD4NpjJ1shNivWtuUmnwVHz9aYr+uxXTzGLxorX
	a0Ipo2h+R9Yn8OkhPCnpumOsHmj7B8keYFPmUT3pvQbzdIKNCFN70uiRFABu2RikAnSbCTPiBLq
	bT6k3EHHbjyrGKMjBeSFNwnHaV+OmPENfmuLEII5EZ1xaUFBzfvq4jlUxx3e8vp5WqN8K2XWYlh
	ZJwKwR48qqa9gO5Tw2ekd/clk01xCcYwQ8hfc+98+Rs3uqW0kTsDlfj3nREao8Q/YA7LGvfofqh
	gKT3V2cvfTFZAtzWaaeJrwHYgW2++QZjUf+O+IyMqUIhQ4Hr7EDKzPGjIYSoO1eBX7
X-Received: by 2002:a05:6000:29d3:b0:45d:3cbf:bdda with SMTP id ffacd0b85a97d-45eb38bb000mr9671985f8f.20.1779554159363;
        Sat, 23 May 2026 09:35:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d493dfsm13521078f8f.23.2026.05.23.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:35:59 -0700 (PDT)
Date: Sat, 23 May 2026 17:35:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, mst@redhat.com, davem@davemloft.net,
 jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260523173557.5cc4f4f6@pumpkin>
In-Reply-To: <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253961-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdevbpf];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C59F45BFDA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 02:20:29 +0000
patchwork-bot+netdevbpf@kernel.org wrote:

> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Did anyone else notice that is isn't a bug?

There is no way that a 'count of bytes of kernel memory' can overflow
the size of 'long'.

-- David
 
> 
> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> > to 32-bit values. The multiplication can overflow before being assigned to
> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> > 
> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> > 64-bit arithmetic.
> > 
> > [...]  
> 
> Here is the summary with links:
>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> 
> You are awesome, thank you!


