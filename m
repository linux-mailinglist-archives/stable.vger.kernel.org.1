Return-Path: <stable+bounces-247209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LoxEvPNBWpGbgIAu9opvQ
	(envelope-from <stable+bounces-247209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:28:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FE4542555
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ABBF3021D14
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A23DFC81;
	Thu, 14 May 2026 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fX1VMRCZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s+CIV2Bl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D83E0747
	for <stable@vger.kernel.org>; Thu, 14 May 2026 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765204; cv=none; b=pK3uYndU0TKoYfsgWqqndvbwf/ZOmHnMI5TwWLinGURt11tkCE29aGyEyMaOJ6i5HAwU51fKFeHb9dp2Llfisokz2QCT0Ds5XOQwn4DQAvYXVX73nHObL3WMfQRDl29QTmwQxcOXeP3yfjm9MfBclWmwlJjduwVz17nOO7HNjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765204; c=relaxed/simple;
	bh=bPoqUeI0w81fhtEAjtDVf+m4QR0ei2EHtrHu0hVxMw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVqshd3dFTEM4x5gfmEfZ/YPFN4Ss+cLj1n6UQerXmt2MSbqltbJ/R68FRFZlPNDKcU7YZQFtH01GneVWCcLyOhGsnggJ1mPAMNZwKKZHmYKHr/WLfAyO71Bw51hDrOoojjfISW9XHU7xFiYUK/95opNIJ2o9q3LKJT5WGk0yUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fX1VMRCZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s+CIV2Bl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778765194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=megH/KafnN6bx24pbYimiNaRlToZucSV9fHWitX3fzE=;
	b=fX1VMRCZxHPeCPOEYouR/lgoo7WT+1UM4mfdOjE2h75eScWnlJIX2ZVdSSTXFpzdsKz2X1
	YxC6/gLJEEKVp9T+pEVSVL6Nfum75pGGLCU1nqZp+bb8OCURKttNJxS1HNverrIWbLTGvV
	1vuPBm132/jY9wSEG56anTIJ/nYP5eY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-lrK5JJI8N9-i-hJXt1RidA-1; Thu, 14 May 2026 09:26:32 -0400
X-MC-Unique: lrK5JJI8N9-i-hJXt1RidA-1
X-Mimecast-MFC-AGG-ID: lrK5JJI8N9-i-hJXt1RidA_1778765191
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d046fac74so46769225e9.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778765191; x=1779369991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=megH/KafnN6bx24pbYimiNaRlToZucSV9fHWitX3fzE=;
        b=s+CIV2BlIngmi3jjevIRRarndvmtD6v7qDh8Gh+ntXD45782ZSFpDF/3HcFYByIIz/
         89BweJ/viq5CtWSTAmoGonXFi2mKtUpjsjmlVHUD0ouxBbgJf6hm0NXscByOH252bQJB
         zU5EtFXmoeh8AhiZKMsDvAMhsIWTlXL4tc4ukPuWlFyUMJ5cFlGKYRJqqsrJ9uuhuHaZ
         H0j+BozMAXod+yOCjS8BgAw+U+0MxlA67yMsToJnBlVO+MBxYlJylKGqG8APRxX2bVd+
         sHH4LN7vF2wnm7MPlakjiV4t9wNjq1vtSxk0P2GNcccusaoeEZ7tLLXqFB4Ta8NyWDtR
         6AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765191; x=1779369991;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=megH/KafnN6bx24pbYimiNaRlToZucSV9fHWitX3fzE=;
        b=J8VX8H8UkJiErt7s3/WH80XrdjKGSnU9Yu6tPeLxUo0BCxhDrWGVE03OtigfYKzKt4
         XUT6aiA0drBf0+/SApw5CEnBQaIM8emUFx9Y3MKsSLqwjHhRAfkBDAIOgsjWrMdv14nc
         ySkVzSGwtd8HuWuO8d5aXooROwry/F1neXiSqwOZCKK+eLTHzvLZMRS1iDB1Aq4uBdlm
         6S8MBKKHWM/W5WwIuiC1x86zI5jYJA6r4Hh8gzhF02G1XxYV/5l1LXRfhMaoO79+Fmh+
         0dmRwafqDjtdNVoPvMninn1p4Hci/uXAG+o/InHC7JzSYVQTWXYEaQnXR2M9RPHRUebi
         NEUw==
X-Forwarded-Encrypted: i=1; AFNElJ/Mmnd+IdC5KGJFRk9Qsu7lBg9npdcx5T7a+G1ETgIOCSnmiPGhEPbB3F1Q6ECNFDCShYxiCuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KUMT67G+jEaMRKgkUxUFtJHEYRadlwhqhUCEIqWEkCHoFDSL
	DJHLIXHJBRrnWk+I4h4J0d5EQUXY08GQ+HiO0MAF6FcDERB/eQxa7p3jzFxeAwXg/TRX7rVBo0S
	3pl+WfLlpX1n7AbMWXxxR2HHcu2UvPlwjEvRI2JxY1ExfGJO9WlrAsnblyw==
X-Gm-Gg: Acq92OEDB03dwohZrKFWtiJ+jhLfV2DELMqORMJ3oJOjzrDJ96/1pGImmKmJimWzBbe
	/UhnBsTuWpv38dRbNXQyY5tKCKf3Av2CCSCcpQXwjBEChL9UxCNTXz9AWe8K2JPd1A/P5zWbejU
	CsIEAlApUJ0x28kk3WLZVTlz8r5T7CGaCOwbeJZ+bx9uGu5oJA1E+g29qNscqI1pNkW6yqvd5Wj
	aKiqFcvcQu/XOkV+uiTgTaajCTcTcyr8/fHxSye+Lz3MAZTMMMLU/iG/NnOiJzUmhs4Mqg/YLLL
	ygs0h2VzSGiMI8XhabRda/koc6gOa5NuNo6kKMgAK/vJU75HnklMs/2R2FN5S6sQZ/xCBYJCGoT
	4Ydlug8NEP/0ogN+TMZCCrEKuyK6Oqub3mhPn6b6zNRsXdNUccmOXWIA=
X-Received: by 2002:a05:600c:3e0c:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-48fc9a2ca70mr111956995e9.15.1778765191316;
        Thu, 14 May 2026 06:26:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0c:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-48fc9a2ca70mr111956425e9.15.1778765190797;
        Thu, 14 May 2026 06:26:30 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd7694754sm19931255e9.34.2026.05.14.06.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 06:26:30 -0700 (PDT)
Message-ID: <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com>
Date: Thu, 14 May 2026 15:26:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
To: Minh Nguyen <minhnguyen.080505@gmail.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B5FE4542555
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247209-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 4:58 AM, Minh Nguyen wrote:
> vmci_transport_recv_connecting_server() jumps to its destroy: label
> and performs an unconditional sock_put(pending) to release the
> explicit sock_hold() taken by vmci_transport_recv_listen() before
> schedule_delayed_work().  The existing comment claimed this was safe
> because the listen handler removes pending from the pending list on
> the way out, which would prevent vsock_pending_work() from dropping
> the same reference later.
> 
> That assumption breaks for a peer RST.  The default arm of the packet
> switch sets:
> 
> 	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
> 
> and vmci_transport_recv_listen() only calls vsock_remove_pending()
> when err < 0:
> 
> 	if (err < 0)
> 		vsock_remove_pending(sk, pending);
> 
> For RST (err == 0) the socket stays on the pending list, so when
> vsock_pending_work() fires it takes the is_pending=true path and
> drops all three references itself: the pending-list reference via
> vsock_remove_pending(), then the two trailing sock_put(sk) calls.
> The unconditional sock_put() in destroy: had already dropped the
> explicit sock_hold() reference, so the second trailing sock_put(sk)
> in vsock_pending_work() is a write into the freed AF_VSOCK slab
> object.  KASAN reports a slab-use-after-free write of 4 bytes from
> refcount_warn_saturate() on the workqueue path:
> 
>   BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>   Write of size 4 at addr ffff88800b1cac80 by task kworker
>   Workqueue: events vsock_pending_work
>   Call Trace:
>    refcount_warn_saturate
>    vsock_pending_work
>    process_one_work
>    worker_thread
> 
> Triggering the bug requires only the ability to open a VSOCK
> connection to the target and send a RST before the listener accepts.
> 
> Skip the sock_put() in destroy: when err == 0 so it only compensates
> the cases where vmci_transport_recv_listen() actually calls
> vsock_remove_pending().  RST is the only path that reaches destroy:
> with err == 0; every other path produces a negative value, so their
> behaviour is unchanged.
> 
> Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=y,
> kasan_multi_shot): same trigger binary, same VM, 100 iterations:
> without this patch 52 KASAN slab-use-after-free reports fire; with
> this patch applied, 0 reports.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> v2:
>   - Resubmit to netdev per Stefano Garzarella's request after v1 review.
>   - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
>     enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
>     same VM, 100 iterations); test summary captured in the commit
>     message.
>   - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
>     bug is no longer embargoed.
>   - Rebased onto net/main (no functional change to the diff).
> 
> v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
> no public link available).  v1 review summary, for reference:
>   - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
>     vmware guys on this that know this code better."  Asked for retest
>     and resubmission via the net tree workflow.
>   - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
>     me."  Also noted that no modern VMware product allows guest-to-guest
>     VMCI communication, so the practical attack surface is host -> guest.
> 
>  net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 4296ca1..88d7128 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock *listener,
>  destroy:
>  	pending->sk_err = skerr;
>  	pending->sk_state = TCP_CLOSE;
> -	/* As long as we drop our reference, all necessary cleanup will handle
> -	 * when the cleanup function drops its reference and our destruct
> -	 * implementation is called.  Note that since the listen handler will
> -	 * remove pending from the pending list upon our failure, the cleanup
> -	 * function won't drop the additional reference, which is why we do it
> -	 * here.
> +	/* Drop the reference taken by vmci_transport_recv_listen() before
> +	 * schedule_delayed_work() only on real errors.  For a peer RST
> +	 * (err == 0) the listener leaves pending on the pending list, and
> +	 * vsock_pending_work() will drop that reference itself when it
> +	 * later cleans the socket up.  Calling sock_put() here in that
> +	 * case would be a double-put and free the socket while
> +	 * vsock_pending_work() still holds it.
>  	 */
> -	sock_put(pending);
> +	if (err < 0)
> +		sock_put(pending);

Sashiko says:

---
Could this change lead to a socket memory leak if another packet arrives
before vsock_pending_work() executes?
If a peer RST is received (err == 0), the socket stays on the
pending_links list with its state set to TCP_CLOSE, and the base
reference is kept.
If the peer then sends another packet (such as another RST) within the
delay window before vsock_pending_work() runs,
vmci_transport_get_pending() might find this same socket.
Since its state is TCP_CLOSE, vmci_transport_recv_listen() would hit the
default switch case, set err = -EINVAL, and call vsock_remove_pending().
This removes the socket from the list and drops the list reference, but
it bypasses vmci_transport_recv_connecting_server(), meaning the base
reference is never dropped.
When vsock_pending_work() runs later, vsock_is_pending() evaluates to false.
This sets cleanup = false and bypasses the sock_put(sk) call, leaking
the pending socket.
While not introduced by this patch, does this error path leak
sk_ack_backlog slots on failed handshakes?
If a handshake fails due to an error, vmci_transport_recv_listen()
handles it by calling vsock_remove_pending(). This removes the socket
from the pending_links list but does not call sk_acceptq_removed(sk).
When vsock_pending_work() runs later, vsock_is_pending() evaluates to
false because the socket is no longer in the list. This causes the work
function to skip its own sk_acceptq_removed(listener) call, meaning the
listener's sk_ack_backlog is never decremented.
---

it looks like the above is trading an UaF for a leak ?!?


