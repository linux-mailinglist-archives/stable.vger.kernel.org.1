Return-Path: <stable+bounces-249517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLP0FC4yDGrdZAUAu9opvQ
	(envelope-from <stable+bounces-249517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:49:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD4757BA02
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44CB5306BAB3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB24611CE;
	Tue, 19 May 2026 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsWvEJTx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO2yYzcL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5A451049
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183721; cv=none; b=e0RdaE/2xxPbEBTS7hlRrFlLMm8Q+xYV+7VHhyk5hBZqSyujVbFBZvqXvk37wYyzj3qNlvuWJmFULOjm4EjZ1Qlr0D31K6bY+u+UhZlc6LrnCwmjhnqjl5ubgvZvo26/yi6dM4malw/uG0puB0Zim5hMpwq1NEv8kWpf3MfooKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183721; c=relaxed/simple;
	bh=yt0H3bvBRFcuJ9DYVM0S3Grsofv+ydRaNi8hw/H/mjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA4o5vYUWIEsZcOHOVMER+wVd1flqcNPfuZ+xNfvWirxQ4r9gmVGUamEjcovxUoJnLLYLGr28shnW454Ig4bN8gB5Yr31MkeVnh+f8DR0ar+NQTB2oFu5UnzGG0rsjAqTVLC0JAgTY2FsgGNFGfHAvghCJzMRD/7DXQguxwdvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsWvEJTx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO2yYzcL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tk6v1iOlM6Sc6be+bYwuVr8WIaK4VMHqbDmDqfyVw54=;
	b=DsWvEJTxEjMz9QABqBLgiYO4614/hfm+wUx+WhKi81zif/3hna5r3c9rOMgvF5Ww1MvSjB
	b+B3w+PcgGTlokrpLbc41nJOF7Z1bSVl7AgO2+LYf/eXr180GF/RAElB8Y9o1RBY17T3e6
	IpLAVa2rVLpJS6gD9Vz1kmX4pgrGRF0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-gnACHvHaNoiasExUV9kRPg-1; Tue, 19 May 2026 05:41:54 -0400
X-MC-Unique: gnACHvHaNoiasExUV9kRPg-1
X-Mimecast-MFC-AGG-ID: gnACHvHaNoiasExUV9kRPg_1779183713
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45aeac88af4so2729167f8f.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779183713; x=1779788513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk6v1iOlM6Sc6be+bYwuVr8WIaK4VMHqbDmDqfyVw54=;
        b=MO2yYzcLm49L+93RMyfoZ7e3aSRE0Vt6y/zTmzYK3ivNwMrBbGczvi692nr+ZeTdoJ
         HihyHPxRIxa13cvSWsGidW2MvMvaef5gCYGkMcQNC46Si8moHcHAAWYkAFGKATDL24ue
         8LMNeHpPBIC9EjrD/anW7wBw+UKaIlBX4gEvX5wKOyIvyDPVvGVbxHIGY2C3vt9D9+jT
         XF1kSxWcvfHfNo3B87rxrwr+nC/ixJD7O9dozQnvlq9HhbrluTL6y0uAFdC6VQ8252ok
         LYtHeZBpDgjKyoecZIUNQdJiIvlNVp250dFO+hragUSVR1EGxYF/OSNQBLDe3g34LO1v
         /ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183713; x=1779788513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk6v1iOlM6Sc6be+bYwuVr8WIaK4VMHqbDmDqfyVw54=;
        b=kChMLgR6i9NfItzPl67NfQHWRT3yn1BjjrLmJnjmAKPrKYkxCnfcAjdbx2YjjT00wX
         G8VTxk5OMG8W7I8CfESht/vJDy8Qpc1SXIci6dch/yPeBCqBjrQWm1xasdzM5alWY7hM
         Wv08aiqIVQLSlVVI4gWcE0zAgPsjfzbigq5wwjNfva9GWbXxsDzvPizpAqjaARX0g+j0
         nO7bx8nKQlRtndD3bJCZmthMeexp3ITj8UE34wVP3tYrsQj5g0aBwExNmHWAVvVd1gJP
         hx6uaxr0f5NW3uChzmRxpyTyWbC6yri3VZDTS6l7HbnOFEcBa0iGoWcHcoa+bPtpB3+1
         orZg==
X-Forwarded-Encrypted: i=1; AFNElJ/4BfNqMyoJgi+DA+AB+ATcXhcvPCLeVNOWfBLyTiYtRbW+zyW2UIKLIDTarDQMpgqtPjkkqxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsgyu2DiQjqj/7VBwK6eAOvkQZNX6BYdrOClrDx0LNZ7P+oY+W
	enW4NyGrEOCVafcZCyIVMRf8UvvM8Rn3N51tKAQ5ZngXkKg3AYCTZZQYKxATk1GxH0HmUNhnImX
	+WlkNOC9zE42tn71pcB26p6wcdNCKlwiQjT/aY/YNgUGJVm5Iu5H0QNavVA==
X-Gm-Gg: Acq92OGL0Z2ZE2PnJFcI2ul9NLk8jHlvIv9s+UJSyK85FsqwPnQfI+RtsIW33QWonjb
	MDB23wroFNHpmshcilnkEHZIGxPtImGbFBecu5GEIMcu5jjlihK2Y/p5nfip6TvcIMiNC0FAZa+
	uJtRuih1SCQkFew14vWFWvsnMHSPoCQPeUnhGc2WNkLC8grGpjJ7HpyPOUoer7X0witoaXt1le1
	x5tH4zlZvbvRdpEJs24w3pFA3CS6TXLBKKLFxNHCh+SYXLlYubSxpnsuNZg7kBBYbKEdz1NoWPm
	gPaaCfzizIBAC1g0eg0eCxKYN/bqW0kaNMm7YcxhmE3h5zMCUaOSeku8+Ir9inZFKMZZXv5SuHx
	OBqu9D3pGBK4msU9e5W5SDnJUHwmZ3ZBrCBj01uTe4lQJVf0YPPTMs974pBVENcEnOcFWnMdDWA
	==
X-Received: by 2002:a05:6000:25c1:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-45e5c5af3c9mr35164480f8f.13.1779183713278;
        Tue, 19 May 2026 02:41:53 -0700 (PDT)
X-Received: by 2002:a05:6000:25c1:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-45e5c5af3c9mr35164400f8f.13.1779183712778;
        Tue, 19 May 2026 02:41:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm43263408f8f.16.2026.05.19.02.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:41:52 -0700 (PDT)
Date: Tue, 19 May 2026 11:41:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, 
	Minh Nguyen <minhnguyen.080505@gmail.com>, Bryan Tan <bryan-bt.tan@broadcom.com>
Cc: Minh Nguyen <minhnguyen.080505@gmail.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
Message-ID: <agwv3YkxYIC7mvyj@sgarzare-redhat>
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
 <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249517-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AAD4757BA02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 14, 2026 at 03:26:28PM +0200, Paolo Abeni wrote:
>On 5/12/26 4:58 AM, Minh Nguyen wrote:
>> vmci_transport_recv_connecting_server() jumps to its destroy: label
>> and performs an unconditional sock_put(pending) to release the
>> explicit sock_hold() taken by vmci_transport_recv_listen() before
>> schedule_delayed_work().  The existing comment claimed this was safe
>> because the listen handler removes pending from the pending list on
>> the way out, which would prevent vsock_pending_work() from dropping
>> the same reference later.
>

[...]

>Sashiko says:
>
>---
>Could this change lead to a socket memory leak if another packet arrives
>before vsock_pending_work() executes?
>If a peer RST is received (err == 0), the socket stays on the
>pending_links list with its state set to TCP_CLOSE, and the base
>reference is kept.
>If the peer then sends another packet (such as another RST) within the
>delay window before vsock_pending_work() runs,
>vmci_transport_get_pending() might find this same socket.
>Since its state is TCP_CLOSE, vmci_transport_recv_listen() would hit the
>default switch case, set err = -EINVAL, and call vsock_remove_pending().
>This removes the socket from the list and drops the list reference, but
>it bypasses vmci_transport_recv_connecting_server(), meaning the base
>reference is never dropped.
>When vsock_pending_work() runs later, vsock_is_pending() evaluates to false.
>This sets cleanup = false and bypasses the sock_put(sk) call, leaking
>the pending socket.
>While not introduced by this patch, does this error path leak
>sk_ack_backlog slots on failed handshakes?
>If a handshake fails due to an error, vmci_transport_recv_listen()
>handles it by calling vsock_remove_pending(). This removes the socket
>from the pending_links list but does not call sk_acceptq_removed(sk).
>When vsock_pending_work() runs later, vsock_is_pending() evaluates to
>false because the socket is no longer in the list. This causes the work
>function to skip its own sk_acceptq_removed(listener) call, meaning the
>listener's sk_ack_backlog is never decremented.
>---
>
>it looks like the above is trading an UaF for a leak ?!?
>

@Minh @Bryan can you check this report?
It seems a real issue, so the patch was not applied.

Thanks,
Stefano


