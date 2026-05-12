Return-Path: <stable+bounces-245846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNP1IxFcA2qE5QEAu9opvQ
	(envelope-from <stable+bounces-245846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:57:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90A525448
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18EE6306F065
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F43D5C3C;
	Tue, 12 May 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkHDBJKm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DB3D45FA
	for <stable@vger.kernel.org>; Tue, 12 May 2026 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604738; cv=none; b=iTkp2N3TnCGYu+P5FNvtXibsn6sFR7uOl23S1jHUY0QW9YH8Xog3fCI3uSfT9JPPMeu7YirkJxn1OactGYOFdqwNzvrxnbYAJrufjZ35LZ+EUqTmYDZsWnTM51cvQtkoJrxjqJ+c3QNWNoWqlBixo01yst5vIBB4FT3zz4h6E1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604738; c=relaxed/simple;
	bh=mreFfcrWDOuj5XwItoV3PyFMdhHPi9qxScc5tKzcWe4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hI2AEoCvtyrM2fQFhrE5+oSnTgzbJd1kCFXe9O3+dlrAXlAzyGjR3UWTW26/MwdSZxKwuJS2cZBxVblnld+sC41YvXtXDfd7JHE52rWmJyfoF3prpHeXc5qKezqOglaY8DCKgVtXGRn3ZeZmXeJm3+es+XM93MZ22Mwte0Tizmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkHDBJKm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778604736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSkn0U6lptu9azs6ifq+vMKSs54jCFl5ojJEkWp+IUs=;
	b=UkHDBJKm8iq173MNz2f6OY9QaGiAa7oBhuNIYQksdGaRXL9+m8RbyCfT+G0WmLBUScY2Q1
	4pN1SClIMQ5VzOZnuhJYuLI/Ej74eRlnnhhVxN5WGGQoDlGb1i0ftKfFMOK0X2LodlaiM0
	83n25wBMOkwBV1jwC2+i+9NnmPMBKBw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-RFZHH02wNCa-xyhjA4X8qw-1; Tue,
 12 May 2026 12:52:12 -0400
X-MC-Unique: RFZHH02wNCa-xyhjA4X8qw-1
X-Mimecast-MFC-AGG-ID: RFZHH02wNCa-xyhjA4X8qw_1778604729
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57FC7180061A;
	Tue, 12 May 2026 16:52:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 967C619560A7;
	Tue, 12 May 2026 16:52:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260512143835.13af8bc4@pumpkin>
References: <20260512143835.13af8bc4@pumpkin> <20260511160753.607296-1-dhowells@redhat.com> <20260511160753.607296-3-dhowells@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Hyunwoo Kim <imv4bel@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
    Jiayuan Chen <jiayuan.chen@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1072348.1778604723.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 17:52:03 +0100
Message-ID: <1072349.1778604723@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 3E90A525448
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-245846-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

David Laight <david.laight.linux@gmail.com> wrote:

> > Note also that I would generally prefer to replace the buffers of the
> > current sk_buff with a new kmalloc'd buffer of the right size, ditchin=
g the
> > old data and frags as this makes the handling of MSG_PEEK easier and
> > removes the double-decryption issue, but this looks like quite a
> > complicated thing to achieve.  skb_morph() looks half way to what I wa=
nt,
> > but I don't want to have to allocate a new sk_buff.
> =

> Wouldn't you need to do that anyway when the kkb is shared - or can't
> that happen?

Hmmm...  That may well be the case - but if it's shared, do I own the
->next/prev pointers and the ->cb area?

> > +	unsigned short		rx_dec_bsize;	/* rx_dec_buffer size */
> > +	unsigned short		rx_dec_offset;	/* Decrypted packet data offset */
> > +	unsigned short		rx_dec_len;	/* Decrypted packet data len */
> =

> Is it actually worth making those short rather than int?
> I doubt the extra 4 bytes will matter and the generated code might be be=
tter.
> (IIRC 32bit arm has a limited offset from 16 bit load/store, dunno about=
 64bit)

Well, the capacity of a UDP packet less the rxrpc header can't reach 65535=
, so
on that basis this should be fine.  I'm a little worried about the rxrpc_c=
all
struct's size - it's already ~1.3K.  It's already got a lot of 8- and 16-b=
it
fields in it.  Of course, it's nowhere near as bit-for-bit optimised as
sk_buff, but I guess there are a lot more of those in a system.

> > +	if (call->rx_dec_bsize < sp->len) {
> =

> IMHO That test is backwards; the 'more constant' value should be on the =
right.

Actually, the thing you're testing should be on the left and the thing you=
're
testing against on the right - but, yes, I should switch them around.

> > +		size_t size =3D umin(round_up(sp->len, 32), 2048);
> =

> Doesn't min() work?

Actually, it should be umax() as I want the largest of the values (as Jeff
pointed out).  I prefer using umin/umax for values that are known to be
unsigned as you don't get casting errors (see the number of places we end =
up
using min/max_t(<unsigned-type>, ...) when we should use umin/umax() inste=
ad)
and the compiler may generate better code as we've told it that it doesn't
have to worry about negatives.

> That doesn't look right.
> If sp->len is bigger than 2048 the you keep allocating a new buffer
> and the call below overruns the allocated buffer.

Yep - see the aforementioned umax comment.

David


