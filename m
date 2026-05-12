Return-Path: <stable+bounces-246682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AT/KmCdA2rm8AEAu9opvQ
	(envelope-from <stable+bounces-246682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:36:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8D52A615
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5198D308C9B1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C86386C3C;
	Tue, 12 May 2026 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Man6gt3H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D708386566
	for <stable@vger.kernel.org>; Tue, 12 May 2026 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621775; cv=none; b=lwZ6xebd6bpeyLjmJVovMPU8dRtqIFbKFVQwXPnR1P92zdBQAkwVLuFC/fMqb/YHmPAMBqJwF0MO/fOlEAqVRVMnb4mh8oqIOv35QDJTz5L0ZEZLc9CaZA0OOgH3gL2dNH28XlKbnT5qPNRmzLG2Ir0JStkjhKN3Sn+hNSdHYQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621775; c=relaxed/simple;
	bh=2CAQv7WlIuAn9ZzlbSWxK35EKEEcUTbGAVGhewVtMtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQHeKYoS8Q+LCUwUdcwm/+KYtb+ou04dgCxY3tBMI2YOtxIZK/oT4jedf5eRfvsD9ixpwLeeK9xVlt4rBf6C4GGXWPomP1FAjUkb412SYpnnvNDyav3DeIStHMWgiqryuaxjVkuaeNdAosO0q7dimvbkCzbZfvQG2Xo4mg/JQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Man6gt3H; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bcc1459daddso557304066b.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621772; x=1779226572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AjtpQdf3BmRecSAJyeyKfM2fj5WACdiXZCkmVYfRjk=;
        b=Man6gt3HqG6GzEP1vSuEzftvOuWnSv16zXSzP6qL11GKFd3TdlLJNaShwgFMqswMKg
         D0omN2+Owj3Emb0iUoEl5E1kDgRVS5p2LqJQaoZSipbppgpw2HBV7tbx6FLO8xoTk5iQ
         H0980Js9f9AE79xQ3aflnZmkUHMZvvx7VjsPhwS+Qfm2HGII7k3ohC5O+GVrHh0plJZj
         JshrsjIkJ6mVts+YXQIpBifTVayW8ub4hE7W50ut0Zio4BnS4OI5JCBzGACH6mh8o4xR
         wByQ4/tiiPbf2TtofEsLljXmgO7DeDqNnAkNpQpNNZplV+hLn/FyMht1i453aCvnBnM1
         8MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621772; x=1779226572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7AjtpQdf3BmRecSAJyeyKfM2fj5WACdiXZCkmVYfRjk=;
        b=aiAZaZ6iMTgsfGytg9bOhGC47VnQLkVO/nFqq8xMq31B399AtCIQ8hfkmTGEZsHrpY
         LTs5iKt+XaosS4dQ8wYxUDtXuCgFRnMvLSOlU4uJCK7AAGcBf8uhOe8SPLB5Gd39Vadr
         uBxp2Xn2+3P/GAYnuv8zDVOID8MK+9Sq+Ki+XosDpVUD7XZay3JrglfUm2jWgCrGDP+L
         BkLxCPeu0wY3mSIJsI+i1tr/Kydv3GYL2p5OrcasCSdRDB3Mktzs4rBoyWfyW3VJHshw
         K45WY2WNllE7mt7GBP6sRCx0IYFEyris5i+0mdCkO7kKeHt09U3mA6J0EL/2d3OZ18eM
         a9Qw==
X-Forwarded-Encrypted: i=1; AFNElJ9HHFI5/xB5Te1h8yTN2T12UYjtJ74+UalfP22xbv3+qVhQxKwSxPBaA0SXxc7kxjIoT0oEl3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVjwz3X+Wk6edcMSKqOxkU9rMqmBFVDUYzbW7AJijEIkFJ8avV
	5g67SbFpzIDkI+lObLD+p6fMzLgp45vkc6DW/JOnzopNJdcqr3fOG1PA
X-Gm-Gg: Acq92OHxw1PvGT5nNHGr+2m0aM+N8ERvDeOtupstyj3JMtbOi2hEQCQLfHx76+NutZg
	tWiqiktWBlMEwNyBiDSRdaEMzNVoBovHMox/r2J7SBJYo6RaL+rYjlvOAA9lDFcTJwAAyAh2/uv
	/h/2AZSkksv+dz8CurUiu3Ef/QuV8i7dwWvbdqicdqXm1WUMdNzuARTldbLFcpx8WeV+1n2PaIL
	CHMhjEhffuobUzAJZHugfuFKveeMKiznJVW6iMxWVu3nUVrqSnf/Ci9dTARjonkkn4i+D1R35MJ
	4GUeWJu7tCbv7p2PSSxi3RzT9r+zB+e6M1GIzmNNx1D1vH7Dg92m/JANbbULafAm1HuDhi0pU8/
	Elr57lISZsLf0tjC8D4zcoV8xtyAVlEmv8bcVWupAy2qKyUOUNaTnIj9IafUHibHI4Hi4VrDPB4
	ETi5BcMz2n0QECG9DSqHrd+I9tdWx6AUUwK+trkcutnMLLxowqzDAgwk46Ws43
X-Received: by 2002:a17:907:801:b0:bc2:9733:9ecc with SMTP id a640c23a62f3a-bd3e27ef0famr8796166b.32.1778621772132;
        Tue, 12 May 2026 14:36:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcd9decf173sm507580066b.43.2026.05.12.14.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:36:11 -0700 (PDT)
Date: Tue, 12 May 2026 22:36:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, Marc Dionne
 <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, Jeffrey Altman
 <jaltman@auristor.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying
 data to buffer in recvmsg
Message-ID: <20260512223609.57150707@pumpkin>
In-Reply-To: <1072349.1778604723@warthog.procyon.org.uk>
References: <20260512143835.13af8bc4@pumpkin>
	<20260511160753.607296-1-dhowells@redhat.com>
	<20260511160753.607296-3-dhowells@redhat.com>
	<1072349.1778604723@warthog.procyon.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 65E8D52A615
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246682-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 17:52:03 +0100
David Howells <dhowells@redhat.com> wrote:

> David Laight <david.laight.linux@gmail.com> wrote:
...
> > > +		size_t size = umin(round_up(sp->len, 32), 2048);  
> > 
> > Doesn't min() work?  
> 
> Actually, it should be umax() as I want the largest of the values (as Jeff
> pointed out).  I prefer using umin/umax for values that are known to be
> unsigned as you don't get casting errors (see the number of places we end up
> using min/max_t(<unsigned-type>, ...) when we should use umin/umax() instead)
> and the compiler may generate better code as we've told it that it doesn't
> have to worry about negatives.

umin() and umax() are better than min_t() and max_t() (which is why I added
them); but you lose the compile-time check in min() and max() that rejects
comparisons where one side is unsigned and the compiler doesn't know that the 
other is always non-negative.

Basically if you compare a signed 32bit value and an unsigned 64bit one
with umin() the 32bit one is zero-extended to 64 bits.
OTOH min_t(u64) will sign-extend the 32bit value and then treat it as unsigned.
In both cases the onus is on the programmer to ensure the 32bit value isn't
negative.
For valid non-negative values the result is the same.
Zero-extending is usually free, sign-extending is particularly horrid on 32bit.

But it is better to use min() or max().
The compile-time tests will reject any cases where the integer promotion
rules could convert a negative value to a large positive one.
Note that the types no longer have to match.
Code like this is (usually) ok:
	unsigned int blk_len = ...;
	int rval = fun(...);
	while (rval > 0) {
		u32 len = min(rval, blk_len);
		// process len bytes;
		rval -= len;
	}
even though the types passed to min() differ in signedness the compiler's
value tracking means it knows that rval can never become a large unsigned
value - and min() uses that to allow it all through.
	
-- David

> 
> > That doesn't look right.
> > If sp->len is bigger than 2048 the you keep allocating a new buffer
> > and the call below overruns the allocated buffer.  
> 
> Yep - see the aforementioned umax comment.
> 
> David
> 


