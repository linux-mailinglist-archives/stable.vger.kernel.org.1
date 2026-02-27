Return-Path: <stable+bounces-219983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOsSKlbEoWkVwQQAu9opvQ
	(envelope-from <stable+bounces-219983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:20:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBFB1BABB7
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7749306C467
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245C844B666;
	Fri, 27 Feb 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=p2p.industries header.i=@p2p.industries header.b="cSXygthZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E226560A
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208854; cv=pass; b=AshlQRwEII3LWxiG8wzJ4FQsHuJf4JhJBAevD6jq914vhuoaPrucEPBdCuQ/tfwRnOvXPyqUyD7yojGV/jhyG0SvwadYUQU4dknBlXi4Ztpb4++E4Nhgtec7D40ZHVX2UvyvHpq7GPW4Shzq6IfPBDoydfWprHduxP71VF8dGk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208854; c=relaxed/simple;
	bh=RDVHrsvD/nMrKcdQC6Qlssi8nAT29GJ82+AUHrahiC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZxMa+99oFz9Kn9NcyDh7yNE6q60mHs5OvZZdR8s3ibJlOWK5y38QV/q8vOSgXvUGsCGFBbGnwwWg47aKlLF3J3pTTbdk3gjFQzGWriudCeD/aF/V3rqZYa/erGvxPCOeMJsB2e/P8Hu47k4RjctQXNK7VTEfGAONJOjbQ0yi9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=p2p.industries; spf=pass smtp.mailfrom=p2p.industries; dkim=pass (2048-bit key) header.d=p2p.industries header.i=@p2p.industries header.b=cSXygthZ; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=p2p.industries
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=p2p.industries
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7eeso3289338a12.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 08:14:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772208852; cv=none;
        d=google.com; s=arc-20240605;
        b=gUKP6calkOjNqaKKQYfFfo4tcxoFfCDgBK8X3scP2AV3Z4wT6pDzCE0SAQnRXkeaW+
         dgxK9qb05FMjrOxsHuF+mL94YZ58u1ZNoK5jk0XKRKiLT83ZHMJtFWsfxYDz9q30OtqQ
         qyxLabyxhol4CrHXxATJSDawhzJF0XAoMknBdVHZf5BmTVwZAPJs4j7EGVPAk3pIatNc
         vYTSBFDLwL8IY/xx6TPAokHxxbduQRlNa5O+kMYEdv/S/bzXzoCnC7k7IFIkOn58GuOk
         wTaenR6cw8LiqPNK3dX92kVdMmG3YPrY7/9l7NiEg/ehB8+F3nqN5/ZnvxkeSsUazVuo
         QueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EuhUnQIPvmsvPWxX1LkP6je2ZMIaRFoju8evpbHyzk0=;
        fh=P8S91i0uaM3OirWxiP+CjkPxE4KpdHAyVr62I0sFdos=;
        b=bUb6hyoIFVWyRbmJzx6xm5IxJZjGiAeHTSdahR0kguzkQLDw8HzfDSxLS3ePf+o94a
         gyCX3Tg82FCBidKRrSvdA/IcVNRGRfXmeYhNkuixECf7d2jwTq4VHpTQInD5KavvqADJ
         kUsbZrN/hPlFZG/U2PqwDNGS64blsW4BJ4G6dfwldLs6ZmyMCMcnUriqGcJUOBFIvP+V
         68Mc0UVIMCUDaRWn9p5+SWM5734oB0lsoiJU1H7y8jTjGQT/sf0nFmMZCu1KROsNFz5g
         JHbkXLRi7GxCCGzKyfNxk/gLw6dxWlFjXE7ikj9Mb6YCjdwjqwj0f1r2rTJQMm+UJLGw
         wjrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p2p.industries; s=google; t=1772208852; x=1772813652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuhUnQIPvmsvPWxX1LkP6je2ZMIaRFoju8evpbHyzk0=;
        b=cSXygthZDMukqUYqbW1epkvNM9ur24HFL8HHvJUhlvpZvrUAe/xGWt60YYgg0kHTNf
         HwGZ4wI0i5bZDgahi4fAO5Qk+Or/b3G7RTt4y43J9d8NZjAXS9Na7S+qKVyGVUMswgup
         xV9AZiqcWJih8jwavc83ZjTmeGpXAv4PmrHhOWE+6GQEfGMmYozqT063kZ6EeaVAzjCO
         2xaSDpEf5BsKejLB1jmXQZ7lrKqKMEeVYcauyh0c+Q/QbQfNhck6P0rh29TuhLB/8Llf
         xFb2M2nCA5BV/2+UOw8CftqSaTUVp4KYefln+Qf0s4kIQqfH4jtS0udEvNwhMFc3O4RW
         uqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208852; x=1772813652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EuhUnQIPvmsvPWxX1LkP6je2ZMIaRFoju8evpbHyzk0=;
        b=SuYLj0luJwQN/ZZYEC0uo7ljBGGdpxS094NR5lSJU6iwhi0mndFlye9Y8HpbZu3FdT
         Tb3LeLgRBmoRq61Bp0ifFcHMKaNu+gYYQfkMYI0+yUGLa9BSHbGMoGI4eJf+3saFqlVO
         lAEg2NH8IJ7q0e9bL5SHK3ZILSf01ytQx/oe5kf2GEC46UV1JqfPCBgBokUax/H0TuN0
         SHuTSqdrDJZsvZb/XYzXYnDXbBZjKUm7K2NGMx8xaQkg9seYYgW5JYB2FBA9UY6IpPeB
         RhsIboaqxGsao4hCBjd4Upa0zqJdGRd/dk5x+iT7pJSj9K9y3r1jFJKsojkwT2t9GFi2
         QoUA==
X-Forwarded-Encrypted: i=1; AJvYcCW3JjMMdI8JRPBDSRJowZP1nk1LGwtxkua9LvCSO2PPC89NwUC7Djxapf4c3keihM2l+Llj+vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkHdyErpLcCwko6vT/2HX2jZmLbsSik89C+a2ZtVFSct3yZXO
	fzAMOcpLoE3AWnklOVJdv3QbK5/jFNZBEtV2PB2ArsuhLyhJL46jAh8bpr/FQUpsVfgr901XQxB
	OQFi+ijKpY7dlG8BDzFaV9VO0jnO8TDRz4c/5DBy65A==
X-Gm-Gg: ATEYQzzS91eW0L28IhkKvBpQwfa6S++Sn9xxxetJhZGmkg1+TQVtpUyc70riXPpgJyr
	1pb7bTQETxwnajVgiH8pLQs3nX7wyITKfqf+06mCbtljk2whpH/B2fs05hMXSN1HT3crIko/SlZ
	z92sop7BorFmItmmfalKZXVOFzL8mm/s6P5s3TvX7hlubR0TTOcWn6dEpt/6iGAeIccsXmdl848
	ArSC6P78kkEgDtWrCWa4F1GWkIA+YXQRkcnWv/ku5HgF8IzPIT8dVWumo3PvuAll6wQJbt4BEWS
	z7nkj6hvtZn6uzL3UM/pIPZPixejKLIDmnPY
X-Received: by 2002:a05:6402:26c9:b0:658:cb40:66ea with SMTP id
 4fb4d7f45d1cf-65fdd6bdd03mr2113947a12.2.1772208851546; Fri, 27 Feb 2026
 08:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226220310.758404-1-hannes@stillwind.ai> <ad61f286-5a4b-4ec7-9586-6fbf58e961bd@samba.org>
In-Reply-To: <ad61f286-5a4b-4ec7-9586-6fbf58e961bd@samba.org>
From: Hannes Furmans <hannes@p2p.industries>
Date: Fri, 27 Feb 2026 17:14:00 +0100
X-Gm-Features: AaiRm53mUzGZzviw5KPZ9ftr4jP7IUQSB3MDLETsRCnSmLZSaaOkBXW71eeMBHo
Message-ID: <CAKKrEi2Fv07qR3hTDtfQLQuYNhPqUj=FmMks=OP2bQpRnF=BMw@mail.gmail.com>
Subject: Re: [PATCH] io_uring/net: don't fail linked ops when done_io > 0
To: Stefan Metzmacher <metze@samba.org>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Hannes Furmans <hannes@stillwind.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[p2p.industries,none];
	R_DKIM_ALLOW(-0.20)[p2p.industries:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219983-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@p2p.industries,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[p2p.industries:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,p2p.industries:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1EBFB1BABB7
X-Rspamd-Action: no action

Hi Stefan,

Am 27.02.26 um 14:59 schrieb Stefan Metzmacher:
> That's by design, if a MSG_WAITALL calls fails it means
> not call data the caller expected arrived or were sent.
> When there's a LINK after that the linked operation likely
> relies on all expected data being processed! Otherwise
> the message stream can get out of sync and causes corruption.

You're right =E2=80=94 a short MSG_WAITALL read should sever the IO_LINK
chain. The v1 patch was wrong to guard req_set_fail() on done_io > 0.

> Let's assume I want to send a message header with
> IO_SEND linked with a IO_SPLICE to send the payload.
>
> If IO_SEND returns short the situation needs to be
> recovered by the caller instead of letting the
> IO_SPLICE give more data to the socket.

Agreed, the linked operation expects the complete data.

> So the current behavior is exactly what MSG_WAITALL
> gives you. If you don't want that why are you using it
> at all?

The actual bug is narrower. I traced the root cause with kTLS.

When IORING_OP_RECV is used with MSG_WAITALL on a kTLS socket,
the recv completes successfully (ret >=3D min_ret, full requested
amount received). But kTLS calls put_cmsg(SOL_TLS,
TLS_GET_RECORD_TYPE) for every first record of a recvmsg call
(tls_sw.c:1843). Since io_recv sets up the msghdr with
msg_control=3DNULL and msg_controllen=3D0, put_cmsg sets MSG_CTRUNC.

Then io_recv hits the else-if branch:

    } else if ((flags & MSG_WAITALL) &&
               (msg_flags & (MSG_TRUNC | MSG_CTRUNC))) {
        req_set_fail(req);
    }

This sets REQ_F_FAIL on a fully successful recv. The CQE shows
the full byte count, but the linked write gets -ECANCELED.

I confirmed this with ftrace =E2=80=94 the recv completes with
result=3D67108864 (exactly 64MB requested), then
io_uring_fail_link fires immediately after from an io-wq worker.
I also confirmed with a plain recvmsg debug tool that kTLS
returns msg_flags=3D0x88 (MSG_EOR | MSG_CTRUNC) on every call.

Your commit 0031275d119e says "For IORING_OP_RECVMSG we also
check for the MSG_TRUNC and MSG_CTRUNC flags" but the code
applies the check to IORING_OP_RECV as well. MSG_CTRUNC is
meaningful for IORING_OP_RECVMSG (user provides a cmsg buffer).
It's meaningless for IORING_OP_RECV which never has a cmsg
buffer.

I'll send a v2 that only removes MSG_CTRUNC from the io_recv
check.

Thanks,
Hannes

