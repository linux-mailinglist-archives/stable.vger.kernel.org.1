Return-Path: <stable+bounces-254186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AJvFomDFGrhNwcAu9opvQ
	(envelope-from <stable+bounces-254186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:14:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB665CD3C4
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB1E43014C6D
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E53F7A9A;
	Mon, 25 May 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBKKHIJq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15A3F7861
	for <stable@vger.kernel.org>; Mon, 25 May 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729285; cv=none; b=XFdsMGqGmuA7ZUAybBZnsQKrV/s2cVg3yAvTDC/Hu8DEjpBp/xfhy8ttKP0hUfFvG4N6ri8hu3DNMW/LcNVuZo2Vo+oq207b81ILlD48TXoVm0qHoqH9E7RvZA5dHJUuH1wJd/QnBXWvcWIiWHSRgnPoAhrI7xqpoSgXPG6dvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729285; c=relaxed/simple;
	bh=2sV4pz6YR0OYuF0/R7iMTf2Mnfa/i7KDjcdfesmU1nU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2YaWVzr57Qu0nnO0hVVH030E6Z0r73lltGn7SGoVomElyPqAC12REHV02NiLpjcLUIG0Q2lUnHSXaBt0rV47UKTYSj9SKYDlZnlbPUEYOMLozTgDNY/RbsKygHasM2Jqug+eaZ949Mq/ar9rt6VhWMMlbdnDOGo38WVDTSYCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBKKHIJq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-444826c16ffso8342384f8f.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779729282; x=1780334082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBpakHiyp2Ixi6ETxg8xxyuYG4nYq7ywoAzoB8P6KoU=;
        b=rBKKHIJqBeVByHkP4pPb8OpYiOdtN++0V/VhA8o14xzAwl3DDAuoxgkRZs3FE1m/th
         394zKqYgB6xVOb/knFqxgajG/u9rwCs9CjYBd+hxjood2wTexs+X7hi+/syZjnqL2XzU
         JYh74o/GXTcH4OKGPr+eU2KjpdRCQ97wA5OaQbiT+LHa9dnbdd9EpcfKkEa4T5MZGZQA
         yuqwWB1d3ldlYBaCsI20Fji3Ta1XLXsdxDQ3c2OLBu7K6A3LDv9kTcaSso/rE146RVbW
         0Uoo0e12ay/14kljA/zeU02gMsVQkzSr7DumHcZfVgqpTQG5hcA6quY/Lf/VYTKKfhJK
         npgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729282; x=1780334082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBpakHiyp2Ixi6ETxg8xxyuYG4nYq7ywoAzoB8P6KoU=;
        b=IJr1JZ2HrZ5LzaF/ycR79LQhwEehyq8hPJSIp0Nd9GYy5nEVjHVrOUTvkOZwy8jGLB
         HR/uJ0SLx1pqwPsZ2yubKiEFI9OuNCI1fhj9e8H7WOhQqX//WURv3JOgU+muS2ABxrSf
         hARsK6afQ0hHVbodeWrNXNayI7C3F2oj3HNDUwWLt4Yi1vtr7lQOpW8NaduwtVgzv3t7
         MQmoEninLsQPL+Rhv5zxmrNxiZn1aYp3c8iMH7QWghwg+e067Za4QugTSREtynM+t8YI
         lOkuzHeiC7p4JCZCCl6IZ9VGU+Nu7az6jsztRtMpKfEwKRjlbZWICHo754IBwOhtHnyp
         qikQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EjLEMnli+NO+ztTBs0ChdFVCBZ01bBlAPpCVAOlftLpST8tBJOWKkE0RwrElqd0Ro7bC7BaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXzLNcH8bbvOET83KWWeIjc+wbdTbG7cCobD4UflA1vj8JNzi
	Pv5jo6bTBQgLyLaWtN84AHQLI4XH9ebYm8OkDyE8/JbWZGArhjuRWOq4
X-Gm-Gg: Acq92OHcszmwLZzYtTL0vZcrZ/HrsFWPQAOjBUM25rhDRcRkqFqVVASE0Wyj47rTfKX
	ptM1yJB+62+pAmZKb6s98dcBEsg36S94wQNo9Sk3OhWxxOGrr81twP3I1hF+wBeiUyQUCra9SMM
	sGsMDo1c9j1WBemNTzxnpjNtGlcKS9sl9XC5hM2xODQ2HFGKkwkZ2QyiNJyxmMRVvj1EhGC0xzY
	X/wZ2UOPUmoSBKyHS1OsIdWys1NroJwp7R8iN7efIi3k/3Bkr8pDMidQ2iIjPj573VvTnUeCP80
	Ci8F1mI8vKMqm+eqxjSZwe1R4sgQGUCuFGiXEgk+gO5vGfBmLT2XuNU6FEXekr4M3Oxt3xjd86p
	vzGnCdlSBbt9I33DSMfGhveiyd43vgfevdvKSUrrbKQvXbgVeBHiniHzoVNGGhtg6SMd0xwWLQ7
	l4FTnFA/Ls9rJwLiPynbvLbajfuf3dwDto4IdSKf+1l6RomwxYNhR4/OlHZOq78+fZ
X-Received: by 2002:a05:6000:4606:b0:45e:8727:be87 with SMTP id ffacd0b85a97d-45eb36aa72amr24711421f8f.15.1779729282272;
        Mon, 25 May 2026 10:14:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d7167dsm28840763f8f.35.2026.05.25.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:14:41 -0700 (PDT)
Date: Mon, 25 May 2026 18:14:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, davem@davemloft.net, jasowang@redhat.com,
 stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525181440.5a6cdb43@pumpkin>
In-Reply-To: <ahRmBTnNMrg-oano@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
	<20260523173557.5cc4f4f6@pumpkin>
	<ahQbVxvbBEJZ3TBU@sgarzare-redhat>
	<20260525115314.3cf310e6@pumpkin>
	<20260525083859-mutt-send-email-mst@kernel.org>
	<ahRJS2bN9Bw_AKyo@sgarzare-redhat>
	<20260525155322.240fbd87@pumpkin>
	<ahRmBTnNMrg-oano@sgarzare-redhat>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254186-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdevbpf];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BEB665CD3C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 17:16:18 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Mon, May 25, 2026 at 03:53:22PM +0100, David Laight wrote:
> >On Mon, 25 May 2026 15:09:54 +0200
> >Stefano Garzarella <sgarzare@redhat.com> wrote:
...
> >> >Indeed, I wasn't thinking. For this to even get close to overflowing
> >> >we'd have to have almost all of 4G available to the 32 bit kernel taken
> >> >up by this single queue.  
> >
> >Except there is usually only 1G or 2G available to the kernel.
> >And all the skb would have to contain no data.  
> 
> `skb_overhead` was introduced to prevent exactly queueing skb without 
> any data (essentially containing just the EOM for SEQPACKET) that we 
> plan to fix properly in some other way instead of queueing empty skb.

I think most of the network code counts skb->truesize so that it limits
kernel memory on the queue rather than the amount of data.

This does rather rely on the low level code setting it to a sane value.
Last time I looked some of the usbnet drivers lied badly.
(IIRC short packets in a 64k buffer with the truesize set to the data length.)

You need to do something to limit the number of single (or even zero) byte
SEQPACKET messages that can be queued.

-- David

