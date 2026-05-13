Return-Path: <stable+bounces-246782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOoaIRIxBGo/FAIAu9opvQ
	(envelope-from <stable+bounces-246782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:06:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDA252F52D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5233100504
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C4379C24;
	Wed, 13 May 2026 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIZ/kG1k"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9225368D77
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659288; cv=none; b=Nx7urKz6nOgawVvtai9wuob7yRGfi0X/DkzFclZ9fRFcxsQgQyCdjKWzI3S1EpUfGYdkhMsJc/uzi2/scNhNfvjQZnqS3cmzPaMTv4NqozrOLpfH1l68ZQ/b2joMAwKsrHAVkSpcvtUOlISESVbE6IK8hVLaQiyrHZ8c94K2Zd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659288; c=relaxed/simple;
	bh=n+tMx83Lpq2nnSneROrhedTv8YfST8C7unrL5fa+cjs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=VSIMLHpfyGjNUNscsZHeLkDXRq8fuQDIuI5o6wWn8ivVbyYw6Nj1MhnGSjU7eeE8iDNBETva4CcSlNu1fhMqjEjk5bYFW9Waa4t+f1e1bFlt2a1bNIKhSd6Ok8nXIPy5BFJqXMZNXbyhB8hO3/wQm5erbiIyPCrccCmtZEaQZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIZ/kG1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778659286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s7tCsL/6PtC0ECoYeAcS4UPmxSgLubEwTSxD3rcZdAg=;
	b=jIZ/kG1kncxt8fWbYtVZ7j6T5JSOiJ7d+tRPpmsu9/LYjlXYSLauYUfQBoNoqBB9jUh924
	XZTwtVGvy/RXG4svJ1kC00o3QlJ1Xytw5ilbnII/G5aCcw8V2pybF6JS8rCh5532EIxk1l
	c5i1Z6BCw12f3TfXzl1bOm4ffuI32Uk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-aJmxrpDfNM-aHK3i_nrFZw-1; Wed,
 13 May 2026 04:01:22 -0400
X-MC-Unique: aJmxrpDfNM-aHK3i_nrFZw-1
X-Mimecast-MFC-AGG-ID: aJmxrpDfNM-aHK3i_nrFZw_1778659280
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45DB919560B7;
	Wed, 13 May 2026 08:01:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E0B43002D2D;
	Wed, 13 May 2026 08:01:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <437CCB8A-5333-4349-B120-A103B1F0E617@auristor.com>
References: <437CCB8A-5333-4349-B120-A103B1F0E617@auristor.com> <20260511160753.607296-1-dhowells@redhat.com> <20260511160753.607296-3-dhowells@redhat.com>
To: Jeffrey Altman <jaltman@auristor.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Hyunwoo Kim <imv4bel@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>,
    stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1354627.1778659274.1@warthog.procyon.org.uk>
Date: Wed, 13 May 2026 09:01:14 +0100
Message-ID: <1354628.1778659274@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 1DDA252F52D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246782-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[auristor.com:query timed out];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,warthog.procyon.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Jeffrey Altman <jaltman@auristor.com> wrote:

> > + void *rx_dec_buffer; /* Decryption buffer */
> > + unsigned short rx_dec_bsize; /* rx_dec_buffer size */
> > + unsigned short rx_dec_offset; /* Decrypted packet data offset */
> > + unsigned short rx_dec_len; /* Decrypted packet data len */
> > + rxrpc_seq_t rx_dec_seq; /* Packet in decryption buffer */
> > 
> > rxrpc_seq_t rx_highest_seq; /* Higest sequence number received */
> > rxrpc_seq_t rx_consumed; /* Highest packet consumed */
> 
> 
> Instead of allocating the storage within struct rxrpc_call perhaps
> It would be better to add them to struct rxrpc_channel.  Doing so 
> would reduce the allocation/deallocation churn.  The majority of
> calls are short lived (perhaps a single packet in each direction)
> but there will be many calls in rapid succession.

I'm trying to keep the I/O side separate from the application side.  I don't
particularly want recvmsg (on the app side) reaching into the rxrpc_connection
struct (on the I/O side).

Further, by only looking at the rxrpc_call struct, I don't have to deal with
locking required for the possibility that the next call on that channel will
start before I've finished with this one (say an incoming call is aborted and
immediately followed up by the first packet of the next call).

> > + size_t size = umin(round_up(sp->len, 32), 2048);
> 
> I think you meant to use max() here so that a minimum of 2048 bytes
> is allocated.  

Yeah.

> I think applying a cap on the allocation size would also be 
> beneficial.  IBM/Transarc derived Rx implementations have a hard
> upper-bound of 21180 (15 x 1412) bytes plus one 28 byte rx header.
> Applying a cap of 32KiB seems prudent.

This would need checking earlier in the input path.  A DATA packet that's too
large would need to be rejected as it comes off of the UDP socket if we're not
going to be able to unpack it later.

> It is also worth noting that there are no current implementations
> of Rx RPC which will send individual Rx DATA packets larger than 
> 1444 bytes including the Rx header.  Rx RESPONSE packets can be sent
> as large as 16384 bytes (including the Rx header).  However, it is
> extremely unlikely that this buffer once allocated would ever need 
> to be grown.  

For Rx RESPONSE packets, I'm fine with allocating a buffer on the spur of the
moment and freeing it immediately.  Ideally, there would only be one RESPONSE
per connection anyway.  I could do a static buffer with a lock, I suppose, to
make sure I can process the things under memory pressure-based writeback.

> > + kfree(call->rx_dec_buffer);
> 
> It might be better to avoid deallocating the buffer on the error
> path and permit it to be freed during normal call (or call channel)
> deallocation.

Hmmm.  But I then need some other way to note that the buffer is no longer
occupied by valid data.  I suppose I could set ->rx_dec_offset to USHRT_MAX.

David


