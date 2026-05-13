Return-Path: <stable+bounces-246787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DstFbc4BGo+GAIAu9opvQ
	(envelope-from <stable+bounces-246787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:39:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3F52FC78
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D91773019972
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A7B388893;
	Wed, 13 May 2026 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKXatW5V"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA63E4C8F
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661546; cv=none; b=Wo8jA8+Cw0xlQ8trQsb+a0fCQhQfBXvYPgcwqFNVC3rd8yfwKMXYuQt2N6GDdd1ub9UEKdNYAt/D6lq8uPdKhH9OK2KF2UAkQ310vamYJeDyqHRUgLuBecGMPKAwxMXSbqw3wTTmIJ/ex8wm2nwSzRGZwm3VSzf2mropoBaDFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661546; c=relaxed/simple;
	bh=pTT/ekNAAZAKvuxgJ0KaVMxrbVpLfjklVq9WeNrI11Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJWmvmi7C7Ov38RNFOBzJHQctFs+gEJe3CA3Esmftp0qdd8sVkkt9LTK0UGYVNWuGhNfsAhPTB7IxJ1mz7Wi13Wis5t9nVfBYTnOYqyhRFvY5Fe0hLAoNf4N14t7H0fmkw1sS2FZJb6aIJKRzdyhhjcnnJ8scQk2tWXKAGp0LQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKXatW5V; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44e5624c053so3604102f8f.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778661538; x=1779266338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KesSWdL2Stm6MiwFGUiQlAQX7y+yCKBxrCzt+Lahfko=;
        b=DKXatW5Vk89wNwOSxan7cCdx9RdMewPoxx+njGZWdIv3nJzj3jqwG8iLD5C8YvTxbe
         0+pBYu8DeYJwRqYCuL14L0txeZy+0bHmKom+hispuqvfZIYNvTDQ2AocKXmKDzj6sUmk
         im3oyJwkxgvyd0ZiwRf9HPxBcFjca5AiMCDtimh98R1nEH4TSIOpzR0M1GoCXC5WJNiN
         TjpKRpCuTqWnXtzDPGeE/bzktNeVFf/LXfTG9ggL0dhQIg9WojYozGZRnruvUdZd5s7Y
         j+xl/2zx++z4uUiuNTu6WYVXD0UUOVkLWdhBPfcH66tj++kdMFQ3jqBoO+TXSAI5WVBH
         nFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661538; x=1779266338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KesSWdL2Stm6MiwFGUiQlAQX7y+yCKBxrCzt+Lahfko=;
        b=RYUwab2O6bORNx4o1HwEMhXEQ3sjNXMoVJpkeXFL0SGdLgCCW3BRwH1Y/R5/2sFZQ8
         SGctgVYphrlfNrXfDZWsaj/X/6MH5S62eQXrFWk6EQUGtMADceBAYAReBDC9HmB+UWHb
         Ded5gxK3CVmCxzxnavV23TU2h07n6BEyXkeGuZn7vvVWhD/scNgkkaK/PFlZ3+Vr5rl7
         675DuRFrX4Cxr+WHEt9/bjxQrSwVHB4y5qQ+vpHxlEkWlqiTCj5WBDJGXUVU6Imppgtl
         d8w9aabX5kf8o9cGPhn69LQ06cMMq6atqHYNkgAlEW5O8Z1q6ljxylLWkQXRAJQA2GnS
         mipg==
X-Forwarded-Encrypted: i=1; AFNElJ/IGH7si4sm1tiUPh63nJSUujS8QTck+9nWyLT/64hoHoVgqO/ILvd9hZfIkekn2LC7/3meqrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7d9b0l7RQoVHsfW6WBdkIv6IiX7Cns9zH7AV9+I+iHu9KtMhG
	U2XXKDx4nEEuuZov2H8kWKFwLK1K4g/goGQF+3qitcIBWch6tjEtB61N
X-Gm-Gg: Acq92OFTYnQH/J9xgQrVmJImA1W3jCCmzyIWnDbVLIv5StkQudpX6XvhXQRlfr8wyEw
	U7OtruxJmQ0cDhCRIXvDaSs56gLSmf8twSOj9dQdYOYBtyMuTHeSir0CLG06H0AnjmbwfFvxGPe
	7GIg4SBZvG1Xu9ieJPSqoeURKQOX0YOq1Z3xmMs5NqRG9Q886A9RSAsHQdDiHbgh3IRPCAWtZ22
	gqqJEj4a/w0giNPr9DRrY6o4FzlWCy/KtjYR9l67jr8g6nUTaM8l5Pxo3PXFKBaURSYUOG9B3zl
	peETXBplCgbZO5uSEuw0p1Wwi6D37PsKpC3Z0l0or3v6D00U0zAsu6n3hGOXvSNUaD31I6LWKfg
	x3l+TRlOOZ9yUSMMhBxV6haBBZF/1V7z20bKF5ydppaMKfgza/3WFGklj0wwEp8KR58RIDG2WOD
	W/Ul98cLoRzFvGo3ADJPd5pDvit+D7Db9q7uxTWYN1eFaVwZyj0lXdSEle0H0N
X-Received: by 2002:a05:6000:400c:b0:44a:b0a3:7c1a with SMTP id ffacd0b85a97d-45c79f296e8mr3018293f8f.24.1778661537960;
        Wed, 13 May 2026 01:38:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491e94c0fsm41033677f8f.32.2026.05.13.01.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:38:57 -0700 (PDT)
Date: Wed, 13 May 2026 09:38:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Jeffrey Altman <jaltman@auristor.com>, netdev@vger.kernel.org, Hyunwoo
 Kim <imv4bel@gmail.com>, Marc Dionne <marc.dionne@auristor.com>, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying
 data to buffer in recvmsg
Message-ID: <20260513093856.29fc0ca5@pumpkin>
In-Reply-To: <1354628.1778659274@warthog.procyon.org.uk>
References: <437CCB8A-5333-4349-B120-A103B1F0E617@auristor.com>
	<20260511160753.607296-1-dhowells@redhat.com>
	<20260511160753.607296-3-dhowells@redhat.com>
	<1354628.1778659274@warthog.procyon.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 51D3F52FC78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246787-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[auristor.com,vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,auristor.com:email]
X-Rspamd-Action: no action

On Wed, 13 May 2026 09:01:14 +0100
David Howells <dhowells@redhat.com> wrote:

> Jeffrey Altman <jaltman@auristor.com> wrote:
> 
> > > + void *rx_dec_buffer; /* Decryption buffer */
> > > + unsigned short rx_dec_bsize; /* rx_dec_buffer size */
> > > + unsigned short rx_dec_offset; /* Decrypted packet data offset */
> > > + unsigned short rx_dec_len; /* Decrypted packet data len */
> > > + rxrpc_seq_t rx_dec_seq; /* Packet in decryption buffer */
> > > 
> > > rxrpc_seq_t rx_highest_seq; /* Higest sequence number received */
> > > rxrpc_seq_t rx_consumed; /* Highest packet consumed */  
> > 
> > 
> > Instead of allocating the storage within struct rxrpc_call perhaps
> > It would be better to add them to struct rxrpc_channel.  Doing so 
> > would reduce the allocation/deallocation churn.  The majority of
> > calls are short lived (perhaps a single packet in each direction)
> > but there will be many calls in rapid succession.  
> 
> I'm trying to keep the I/O side separate from the application side.  I don't
> particularly want recvmsg (on the app side) reaching into the rxrpc_connection
> struct (on the I/O side).
> 
> Further, by only looking at the rxrpc_call struct, I don't have to deal with
> locking required for the possibility that the next call on that channel will
> start before I've finished with this one (say an incoming call is aborted and
> immediately followed up by the first packet of the next call).

There are also loads of other allocates and frees (eg the skb itself).
One more isn't really going to be significant.
Especially for sub-page sizes that just come of a per-cpu list.

> 
> > > + size_t size = umin(round_up(sp->len, 32), 2048);  
> > 
> > I think you meant to use max() here so that a minimum of 2048 bytes
> > is allocated.    
> 
> Yeah.
> 
> > I think applying a cap on the allocation size would also be 
> > beneficial.  IBM/Transarc derived Rx implementations have a hard
> > upper-bound of 21180 (15 x 1412) bytes plus one 28 byte rx header.
> > Applying a cap of 32KiB seems prudent.  
> 
> This would need checking earlier in the input path.  A DATA packet that's too
> large would need to be rejected as it comes off of the UDP socket if we're not
> going to be able to unpack it later.
> 
> > It is also worth noting that there are no current implementations
> > of Rx RPC which will send individual Rx DATA packets larger than 
> > 1444 bytes including the Rx header.  Rx RESPONSE packets can be sent
> > as large as 16384 bytes (including the Rx header).  However, it is
> > extremely unlikely that this buffer once allocated would ever need 
> > to be grown.    
> 
> For Rx RESPONSE packets, I'm fine with allocating a buffer on the spur of the
> moment and freeing it immediately.  Ideally, there would only be one RESPONSE
> per connection anyway.  I could do a static buffer with a lock, I suppose, to
> make sure I can process the things under memory pressure-based writeback.

A 16K block of static data is rather a waste.
Under that much memory pressure something has to give.
Dropping a packet and forcing the remote to resend on timeout
may actually be the best thing to do.

-- David L

> 
> > > + kfree(call->rx_dec_buffer);  
> > 
> > It might be better to avoid deallocating the buffer on the error
> > path and permit it to be freed during normal call (or call channel)
> > deallocation.  
> 
> Hmmm.  But I then need some other way to note that the buffer is no longer
> occupied by valid data.  I suppose I could set ->rx_dec_offset to USHRT_MAX.
> 
> David
> 
> 


