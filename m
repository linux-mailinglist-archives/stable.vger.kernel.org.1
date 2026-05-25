Return-Path: <stable+bounces-254138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHpIITdKFGpeMQcAu9opvQ
	(envelope-from <stable+bounces-254138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:10:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131C5CAEB6
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79BD6300F973
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B77383333;
	Mon, 25 May 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmNnpAHd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8BvTtm8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCF3806B6
	for <stable@vger.kernel.org>; Mon, 25 May 2026 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779714612; cv=none; b=LB8T5/RNPGUpQp4oJF7xGoSCdvlM6qgA1V1RmlVP6aT61g5/6nw/OtOj65z2yr+cYFNPD4OidUuh/quF63478m+bBf6Jbv1BhlqtVVoZJmywoxRY0oTPNy1zDhbs6tIdl8WasdipWObClDnviFQZi0HJU4ssd3JO0UuX7igKcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779714612; c=relaxed/simple;
	bh=BGZXA1mN8FhVP5FiDTI8b7j+Ir1HdkD6PebA7BvFpSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZwJHIpu7loFVcNsXvXMqtGzJ2r7GK6hDmvHk/KNleqNhJHCGLn+rNdYOPx2klOdX/eES1pnwlUCQYmGrRIIAgE+8xcuNrs9Pl6oNRaFrUkL/ktrFibbi2a3gBOofGywZs4aiKt5Pi8yDuGr7gDIBC4s8K8Kt7kmITVkAYRC0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmNnpAHd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8BvTtm8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779714609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwxIhTGbJtS9kc5tnabyAFBYHC9dUEXdNvoWrVinQAY=;
	b=PmNnpAHde1pm5Vfj7l+nhOwEOH5ccn25oT5/Ii2PZ7HDANOGUJJGF62IkqTH/a5jLJ3scL
	pGJJiNxpxZ2flDJn+YgqUFblaXYd8F8IOpV5F/XWHHAfIbFpc2JP3AspGerquXgysgakqS
	PHppSTbDjA4o8LMb6Fcj+6hkQyrJ+cE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-AJxD6hnUMwO_AxhzgSMYFw-1; Mon, 25 May 2026 09:10:08 -0400
X-MC-Unique: AJxD6hnUMwO_AxhzgSMYFw-1
X-Mimecast-MFC-AGG-ID: AJxD6hnUMwO_AxhzgSMYFw_1779714607
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4904bbc6094so14397095e9.3
        for <stable@vger.kernel.org>; Mon, 25 May 2026 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779714607; x=1780319407; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwxIhTGbJtS9kc5tnabyAFBYHC9dUEXdNvoWrVinQAY=;
        b=H8BvTtm8euxa1NUihupauXoSbQlt/i8Kg2/HWxUjob98BjTISOlQsKHINu3jXwsbqg
         C8UQ+BfgfTr2vitOt1MTp3tSWd8aR45IhSJ3s4+gdFsL75rsprGhD2oJHwH2Vb9OGsK9
         ubwimgUW+Dlt6TZovvWuFTXJFfWPyfDHtJv6lFMsbT97tEqUj6PZ1lMwmyb9lbzbtajc
         taTh2CbLK8vw87Zf+HH/we/9n4FzisBHCmT+T5W9sMHIXHkk7uCgJAFDdoZU8XKOq//y
         JDp/r1GIb/OAlRcv/KJtRwdBsal88ZRbmN1BkGdHgNlB9npsnZwA2OdOpFGlOn551Pv9
         mozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779714607; x=1780319407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwxIhTGbJtS9kc5tnabyAFBYHC9dUEXdNvoWrVinQAY=;
        b=ohp1Kf1mDPCXMNIVLuVp4CK7s6GALcApSZjdtEPrcLDg1MU4ajZm8oIj1Ny6pSGBRv
         A2E6MA2De7F4K9/nVYCVnh6+MA5JOIWe5UXjJzIqLhdgJat9jy8shUVwVguLCAb7WTjK
         6oXJwdw1stx5xKYAX7dEu3WK7MpUKy3b3J1UpvPsb5HiqOp9X1Amb8f+G+mhFyFFCbuM
         5H52M/F+H6LEV7qFXc/bq1d8b0ZsE2Nvs+fNAYTKpfBWoHjjTZccTNd/noNutqvMMsru
         wkSoj87a/nXeL8uE7mh7znbqdLnvvCv3o95SXuGuBBkILdnvblR5cbUxSwIn2GG0Xtgl
         2bzw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ikc5/Nts5EJvkal3CqBCVdFNFjVhrfThZnPiaQ5/JOb0K90QMYER/HKE69Wa1BnU9Oj9GnHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwJEERyav5GRdicZqP5eTyVz/UjuiGWuqkyDnqDpcP1erSiPf
	pYOzp4uSZcPWB8hiVFifQ5sE9oSxH6VdCagC77suvsOcplxPBd8VCTbQNmgBu0H4vTZBhyGNTIn
	pk15uhDi70zeeU2V5p3vgy2lpPExWV4BqE4baJw5+Ysv5x3yF94KtnsM9wQ==
X-Gm-Gg: Acq92OHcrLF72dfeoz+IzaGXdIrVAM9egkQklPLkpB2BayBO86nm5XgYKtz6XM1RyQY
	+4/DfZ+0qXV56IdPIz/nE1ItnKG4W7rQIZSf4z4052dQqR5q3kcOxFI1frFpWikzqDigExF3RMv
	Mtf+EVWjDLLLbXtzv6VK9BUMpE9HgWA17bupXpyGmgkvI1/p/MBaKEbcIrUssxKYXYbG/8b6XEa
	u+OVwKoPeCbyrexQqJlJ2dwyEmcdEN4vhrcRu1e9WHmLbmd39vlhBT3/JYIMkzkQGi3LN/SwsJx
	gC/xsYJ5aK5feXqb4cKQxplAq1pHR1+7RmE27rTSmBhX8bSAnZ+IJIAav/XhOJ4x6xTTF4fpLXX
	3B9uKmvh+crg8JNsVs0idG28Pf86CqsbLA23yYKk7IfqJI07REwz88LacjmmCveub8OZodhmbSV
	8cjgT2Tg==
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id 5b1f17b1804b1-490426bc6demr270215355e9.18.1779714605383;
        Mon, 25 May 2026 06:10:05 -0700 (PDT)
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id 5b1f17b1804b1-490426bc6demr270211505e9.18.1779714602516;
        Mon, 25 May 2026 06:10:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm118548825e9.5.2026.05.25.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 06:10:00 -0700 (PDT)
Date: Mon, 25 May 2026 15:09:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
	horms@kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, pabeni@redhat.com, 
	davem@davemloft.net, jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <ahRJS2bN9Bw_AKyo@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
 <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
 <20260525115314.3cf310e6@pumpkin>
 <20260525083859-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525083859-mutt-send-email-mst@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254138-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,linux.alibaba.com,lists.linux.dev,redhat.com,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdevbpf];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1131C5CAEB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 08:42:01AM -0400, Michael S. Tsirkin wrote:
>On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote:
>> On Mon, 25 May 2026 11:57:45 +0200
>> Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
>> > >On Sat, 23 May 2026 02:20:29 +0000
>> > >patchwork-bot+netdevbpf@kernel.org wrote:
>> > >
>> > >> Hello:
>> > >>
>> > >> This patch was applied to netdev/net.git (main)
>> > >> by Jakub Kicinski <kuba@kernel.org>:
>> > >
>> > >Did anyone else notice that is isn't a bug?
>> > >
>> > >There is no way that a 'count of bytes of kernel memory' can overflow
>> > >the size of 'long'.
>> >
>> > It's more of an estimate than an actual calculation of memory usage if
>> > we queue the incoming packet. In theory, an overflow could occur if the
>> > user sets `buf_alloc` to 4GB. In practice, though, I think you're right:
>> > the memory should run out before we get to that check.
>>
>> The calculation is:
>>
>> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>>
>> skb_queue_len() will be the number of items on the queue.
>> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).
>>
>> Unless you either corrupt the queue length or manage to allocate skb that use
>> less than the minimum about of memory that product can't overflow 'unsigned long'.
>>
>> The later calculations might wrap - but the multiply can't.
>>
>> -- David
>
>
>Indeed, I wasn't thinking. For this to even get close to overflowing
>we'd have to have almost all of 4G available to the 32 bit kernel taken
>up by this single queue.
>
>Revert, I'd say.

I also blindly added the cast to silence sashiko :-(
I see now that it could never actually happen, but semantically it’s 
correct, so maybe we can avoid the revert.

Thanks,
Stefano

>
>> >
>> > Thanks,
>> > Stefano
>> >
>> > >
>> > >-- David
>> > >
>> > >>
>> > >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
>> > >> > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >> >
>> > >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
>> > >> > to 32-bit values. The multiplication can overflow before being assigned to
>> > >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
>> > >> >
>> > >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
>> > >> > 64-bit arithmetic.
>> > >> >
>> > >> > [...]
>> > >>
>> > >> Here is the summary with links:
>> > >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>> > >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
>> > >>
>> > >> You are awesome, thank you!
>> > >
>> >
>


