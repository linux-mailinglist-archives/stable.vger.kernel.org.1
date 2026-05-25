Return-Path: <stable+bounces-254117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFf4HzIdFGoGJwcAu9opvQ
	(envelope-from <stable+bounces-254117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 11:58:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5F5C8DB8
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE759301413F
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66C63E8335;
	Mon, 25 May 2026 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXJCNFrU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tF/2NOxH"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536133E8330
	for <stable@vger.kernel.org>; Mon, 25 May 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703080; cv=none; b=L+MFz1xTm3lRaJSRRWONs8I3Gdje3znzTQOxavKarmi3hUeKt6BaWMJeto5TYHr6n16W/C3LCmWSIloKMAyHM9tB7nfgjqot8RVOhV+OM7OA0IpqsYX0g8uUBN8CzvIQuUeUGd/QbZYDcJhx3mGwGHj5wSO6kzow1gemgXRGi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703080; c=relaxed/simple;
	bh=uK/vt7eLnOx5l8lJnbIVpEjTM2YvSAf8nXV0EaVRzsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsoKt2wic86kpxGouUZ3BzX9s/GN7+xGM/fyNRhmMx25V5HFFcoPEfkBtWj+R8l+sHCncjXEA9t3Q2q+fSM8dRHj7krPhmaiKOJ+1jR04PgOtcrCYzSA5DmiMLhuJmXy2tXnE4FvPkAomRupW9JviIBna9lHUBEVOnovxAfgWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXJCNFrU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tF/2NOxH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779703078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1gLqb9yQcrxGhMm5dozqHasfJujBtBwy62H+RJqRdg=;
	b=SXJCNFrUzM75Ukyy0U7laPw9r1EylOZ1JvO+ft+KLWGKJgUUXpNjAaSCwCts+Pt4P6roK+
	HmQJTgzM3L2MUQq4AVNOR3SD1nfawWwA/BcG35pumkPslHoELFOCp7kpzoXbuIDaAB9op6
	VbsnDZwKh0yw2V/+6ax3DdpKkE0mHFY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-Y2998BWMOw2pnAF8JNC8PQ-1; Mon, 25 May 2026 05:57:56 -0400
X-MC-Unique: Y2998BWMOw2pnAF8JNC8PQ-1
X-Mimecast-MFC-AGG-ID: Y2998BWMOw2pnAF8JNC8PQ_1779703075
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4904bbc6094so12720595e9.3
        for <stable@vger.kernel.org>; Mon, 25 May 2026 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779703075; x=1780307875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1gLqb9yQcrxGhMm5dozqHasfJujBtBwy62H+RJqRdg=;
        b=tF/2NOxHNQKgMBzqI4DH3UjknadLJPd/cS7dAoETtafHRBI/ldH5IsvB+dzWp72SDe
         4IfWp1vP/9pzTAF+yM56ckNwRXwZzZFW3eFxDVodxDqdxAqN+t74rJXLFER+IGUGtvzD
         sg1S/8drAws4E0nzlp4K8A77f5jpzgnhKXthYjSVVGGETenbKUAz4lEJG7tUqIQT2ebE
         aM2VjHX21qRp2Ndpfw40COzYoyeBvx/u2pl2t5SzoS6QmNrj5GPZsAdxS7PjttqtoIOK
         M4sye+pD0X/NVOae9sxBmH4KeQM9heHcEuP8qtbpXHuZBJT/0GjzmfC8f36pf9gdCsC3
         4/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779703075; x=1780307875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1gLqb9yQcrxGhMm5dozqHasfJujBtBwy62H+RJqRdg=;
        b=TjvJsBRYCIPdvlFZeIWRJPBoCgnJZvbkBNPHVXPG7qoSas6t6fP5Hj3Sbl+a2p/Dgb
         3HK7hWvk6iFkTbzbXGZjMJx5A3RODOk1xTd4RawH99TnzdG3xHClH8dOXtgjWi2K+kBM
         ux8bjaNMQFXDhGau3QT3LWG6OAMb8TsM5XI3XDGDk+cuLg4oQuNwnH9GyfwVM0gF4/IF
         xEGfpxuGYC0fsa3Tbj4k6Y5dZregI0t+jBbW+IxrIItlRvt1r3zsxU1uZH6xuDgvQZj+
         OANxfhT6/A3jq7hCsldfhvPOTGweUo6BPGZvJg4UsGESqPqvrgDC//5gYaQ5Hnx/xGuT
         TsXw==
X-Forwarded-Encrypted: i=1; AFNElJ8vm56d5oqKmHXwqybZV3jBNHeVbY9/a25eT2zlf/O//d8Zs29sUaVsJMWV85dCBsTuhVA6Iec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabeRTC2KCSZp0/60FAwNcD1avdRLs1+xpKegxRP3VH0k/2OL+
	ZJBTND+iiHsqS5hbLmCE2BUGl1H21AnQjDuDPQsB3pOJKbP+pEKKcjVwuiCebDDAzlo5cYATyet
	3657prwOVwaGZ49J/qgifcR0L17tkee7hOPbWjv9qHJSfH9n/z220d1JaeQ==
X-Gm-Gg: Acq92OHlyldr9jP9ZbjvdilNeyNZrx3km3QS6VCDy+Q+ziLqsmd5E8mrb+TVt1aQFw7
	+6gXgaE46rO1gL9L8Vnm603K2tC/UB8qKMKq8R5dZp0hAuERt/NHPmFbVCiCH+AJGfLn1VewfM1
	25qEek3pKI12QBHEEJP9lHOkwNaHK90uxeFfhz6Sk66N09elQDvuHLwanWJc1Fr4oCYodI9PH6A
	Jg/qbdMUNOMhGlkdyFcWtUMnNPiTbPGWNWPztqloZzP6mXBh3yZDm5zfWxyk1DkOw5mOIooH1bT
	v7UCMri87x1z/IA8WYaqU1MdFBhApLzudF1iNoTcg59MjdX4BRVbreJQN58Fm/3oWMK7IskhIP5
	4ywmGJ5LDgnVBu/Vl/Ly1hzhE8Ww2FWtAChwfQ5xUbNzaE4/aRYCnHv0OvGl/g7INe0c4oJn1io
	Rkl+VA2Q==
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id 5b1f17b1804b1-490482c44ddmr216835985e9.24.1779703075332;
        Mon, 25 May 2026 02:57:55 -0700 (PDT)
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id 5b1f17b1804b1-490482c44ddmr216835185e9.24.1779703074518;
        Mon, 25 May 2026 02:57:54 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490417b0680sm83957175e9.8.2026.05.25.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:57:53 -0700 (PDT)
Date: Mon, 25 May 2026 11:57:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, 
	xuanzhuo@linux.alibaba.com, horms@kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, 
	pabeni@redhat.com, mst@redhat.com, davem@davemloft.net, jasowang@redhat.com, 
	stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260523173557.5cc4f4f6@pumpkin>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254117-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdevbpf];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EEA5F5C8DB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
>On Sat, 23 May 2026 02:20:29 +0000
>patchwork-bot+netdevbpf@kernel.org wrote:
>
>> Hello:
>>
>> This patch was applied to netdev/net.git (main)
>> by Jakub Kicinski <kuba@kernel.org>:
>
>Did anyone else notice that is isn't a bug?
>
>There is no way that a 'count of bytes of kernel memory' can overflow
>the size of 'long'.

It's more of an estimate than an actual calculation of memory usage if 
we queue the incoming packet. In theory, an overflow could occur if the 
user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
the memory should run out before we get to that check.

Thanks,
Stefano

>
>-- David
>
>>
>> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
>> > From: Stefano Garzarella <sgarzare@redhat.com>
>> >
>> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
>> > to 32-bit values. The multiplication can overflow before being assigned to
>> > the u64 skb_overhead variable, making the skb overhead check ineffective.
>> >
>> > Cast skb_queue_len() to u64 so the multiplication is always performed in
>> > 64-bit arithmetic.
>> >
>> > [...]
>>
>> Here is the summary with links:
>>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>>     https://git.kernel.org/netdev/net/c/4157501b9a8f
>>
>> You are awesome, thank you!
>


