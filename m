Return-Path: <stable+bounces-244481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB+kIWLw+2kBJAAAu9opvQ
	(envelope-from <stable+bounces-244481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 03:52:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB54E21C9
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 03:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D14830095C5
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AE274B23;
	Thu,  7 May 2026 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8uHZJJw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25891EB5F8
	for <stable@vger.kernel.org>; Thu,  7 May 2026 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118748; cv=none; b=Y9D4QpEzmi3dPPRKyOmKPnpj77KxQTWM6J9ozwgQFQXlj9qOAPFhHh/h1v4EABaBAdJVHozzfR+T9tU9JW3ZdTFIvQEKyjRm3bvESAhqvnZpis3tWLs6FzU9xSMaSJvIEVeTndYVb2b/Dirv6j3wRe18TNEO557EARqYzLVPZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118748; c=relaxed/simple;
	bh=ePWiApIJ0xPFVA21a7oJMCwj2irEXUXmdj9qz1PdA+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6MQhJHVDWiFYTQo/rsiOEZ/5G8dfMAcfCzp/j3HJWKjoIEXIqljIlAiSAN61xenZUqZQ0tSuJgxJV3kSeuzuPAMmYklSjuve3UnJBiAjLi/TrnwulrH1gqZ++YtDDwnX/Se8i8AudDIihDGmCQXgdRJvQDj+3MHqKpAurDbOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8uHZJJw; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-130c653cce4so995883c88.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 18:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778118746; x=1778723546; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4F3nOKDhtsVQU+TyXOA0ATidLJ3/iA9/H+PV8rH5dc=;
        b=d8uHZJJwq071ZtoYd9nF3EW7FnSJUdB4cBCuMKV5ys/RMYR1ayJ9XEVtTowqSNuumx
         aU0D6rRUxCwkjgyH5oNaTMB3B+yBDMkIIQZsti5nV0ASTGDj3JVWm3Fv9L2NjhtR07Al
         qOxIbpagOAmfBwtuJ7xagnXIoEULGbYdVf8PBGjdbBYLHEn5/2i8B906ZiZuBw+akcfI
         +VIY1nSWFnVwAQExxsSGm52lwQed/ccHXucsiGR911h7LnBESUvRJC8X6tvtdk5KjttN
         KaW/GdB+q/QMnKiDkC2emCIIzr8dVeVYjnR8eHLSrgZfcVkJx+Qsg7wBkEhP7DPjx6NX
         7n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778118746; x=1778723546;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4F3nOKDhtsVQU+TyXOA0ATidLJ3/iA9/H+PV8rH5dc=;
        b=emxmRCt+3GcazXQLDtDaBjqeDC81QwviGjQOLWmL8LfQSt+ImKfhjgPyXy10p1dZG/
         XCgFPZYJbuJ49t5l/UBQg/yGb4uieTDazRBz96TMJVPgSTsWwbghyzySoj8zsbjvrwqk
         3/dToz1UtNXNrYXTqJWZal+U4PhLuzDLkH46IbcPw5cbzR5vec3CCU/VkVAWODUnupEt
         Bo8qa3qwNhAVLjedihviEnovONth7ebNw4RCNsHsKdJ0DLtCTSSFt+kIBgc+jVw2tcZK
         muWzxMZhn6zehJ4DbYoBdfNnYtloNNHixlKLwIebEOO97IQhMVHRvSjn3TIEJkuX24Vu
         hh4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+xyxTuO+NXn/Uk6AVIReXomKfDve+SdZn2JnTuEi8AIvX2RSaoW0bS9NEZ8AvT/y5CCgA6HXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxAAoxveB2S8DNsFY75WH7h8+bdsmTlLYD7wlwR2jb8AxdM0B
	nwluWO6WDHRUMvPgqOLueyLl4YhznxhIcELZQJYruShwtHddxLA6bQy8
X-Gm-Gg: AeBDievEqxgQ0ybgubE9SqUZ+4jEtTDHhct8DEL3m17MZe3CaC8eZrWdhGv3nen2JwO
	7b8H8MPNBC5KQ53H9m9qW9Fh0K50KAS1z45edidXp7mfcO4AofdXODqnDDHovF3jpVxQzE6WjnZ
	S8bYedcAtUxyT0I0nnCdN+MIK3tJGbNSdXXE2uFTgLle0ye6zaXTCAeQXJ+Dj+Y/tWUUqOebfZj
	tmCFssTkYxx81oREmg5JCRtmwsFwviZHQi07hyHdcoFS7R36eh59+rJOQgdiDDswSEu/OrS5UOG
	RCjwtnzA6ZBijmJWyQMyneeIZYrLPJ8NwOXDSse87HVCLM/Ys9XkIsf3b1ObcX4M56ZwfUpnS7t
	G3J439SNmTPZaRH5MkdwoerVS9YzuNCZTomBL8lNH6qdTIkNU7EcuT6Akw6SU00c9KhBtbJ8eWS
	QaAApB7PfjNPg00HCMoreO7sG0ZgibqO/WkDUTzifHsr69a4hs6QJKW5a/OmgqLMcrjJRs7BP3e
	NQ4nFt81DgE
X-Received: by 2002:a05:7022:4392:b0:11d:c86c:652e with SMTP id a92af1059eb24-131964baab9mr3690267c88.5.1778118745547;
        Wed, 06 May 2026 18:52:25 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f968cad4sm5597146c88.6.2026.05.06.18.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 18:52:24 -0700 (PDT)
Message-ID: <dfd8fb00-29de-4151-86a7-307a7c721f7d@gmail.com>
Date: Wed, 6 May 2026 22:52:18 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: avoid sending zero-length stream messages
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com"
 <syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com>,
 Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260506-tipc-zero-length-stream-stall-v1-1-5d75f202227b@gmail.com>
 <GV1P189MB1988FEBC4D7BA3F00E210774C63F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <GV1P189MB1988FEBC4D7BA3F00E210774C63F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qfmLxCCe833TR8Z2e3bOQoDx"
X-Rspamd-Queue-Id: 89CB54E21C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244481-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:+,5:+,6:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,aa7d098bd6fa788fae8e];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qfmLxCCe833TR8Z2e3bOQoDx
Content-Type: multipart/mixed; boundary="------------bY2qRkxssXquW0YwpYsfN4R1";
 protected-headers="v1"
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com"
 <syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com>,
 Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Message-ID: <dfd8fb00-29de-4151-86a7-307a7c721f7d@gmail.com>
Subject: Re: [PATCH net] tipc: avoid sending zero-length stream messages
References: <20260506-tipc-zero-length-stream-stall-v1-1-5d75f202227b@gmail.com>
 <GV1P189MB1988FEBC4D7BA3F00E210774C63F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988FEBC4D7BA3F00E210774C63F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>

--------------bY2qRkxssXquW0YwpYsfN4R1
Content-Type: multipart/mixed; boundary="------------d6PCoNGxfH9UhgBdD0GaQD4M"

--------------d6PCoNGxfH9UhgBdD0GaQD4M
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

On 5/6/26 03:41, Tung Quang Nguyen wrote:
>> Subject: [PATCH net] tipc: avoid sending zero-length stream messages
>>
>> TIPC stream send currently enters the transmit loop even when the user=

>> payload length is zero. This can build and transmit a header-only conn=
ection
>> message.
>>
>> For local TIPC sockets, such messages are delivered synchronously thro=
ugh the
>> loopback receive path. When this happens while socket backlog processi=
ng is
>> being flushed, reply transmission can re-enter TIPC receive processing=

>> repeatedly and trigger an RCU stall.
>>
> Can you demonstrate this scenario using code ? It is better to point ou=
t what current code is faulty.

The minimized user-visible trigger is essentially:

      int fd[2];
      struct msghdr msg =3D {};

      socketpair(AF_TIPC, SOCK_STREAM, 0, fd);

      /* In parallel, this makes release_sock() flush backlog. */
      setsockopt(fd[0], SOL_SOCKET, SO_ATTACH_BPF, &bad_fd,
                 sizeof(bad_fd));

      /* Repeated zero-length MSG_PROBE send on the connected peer. */
      for (i =3D 0; i < 64; i++)
              sendmsg(fd[1], &msg, MSG_PROBE | MSG_MORE);

The faulty current-code path is that TIPC stream send does not handle
MSG_PROBE before entering __tipc_sendstream(). MSG_PROBE is supposed to
probe without transmitting data, but the call reaches __tipc_sendstream()=

with dlen =3D=3D 0.

__tipc_sendstream() uses a do/while loop, so even when dlen is 0 the body=

runs once:

      send =3D min_t(size_t, dlen - sent, TIPC_MAX_USER_MSG_SIZE);

At that point send is 0, but the code can still call tipc_msg_append() or=

tipc_msg_build(), creating a TIPC connection message with only the header=
=2E
It then calls:

      tipc_node_xmit(net, txq, dnode, tsk->portid);

For a local TIPC socketpair, tipc_node_xmit() takes the in_own_node() pat=
h
and synchronously calls tipc_sk_rcv(). When this happens while
release_sock() is processing backlog, the receive path can generate
response traffic through tipc_node_distr_xmit(), which re-enters the same=

local receive path.

I should have made that explicit in the changelog and pointed at the
missing MSG_PROBE handling as the faulty part.
>>
>> diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>> 9329919fb07f..3c7838713d74 100644
>> --- a/net/tipc/socket.c
>> +++ b/net/tipc/socket.c
>> @@ -1585,6 +1585,8 @@ static int __tipc_sendstream(struct socket *sock=
,
>> struct msghdr *m, size_t dlen)
>> 					 tipc_sk_connected(sk)));
>> 		if (unlikely(rc))
>> 			break;
>> +		if (unlikely(!dlen && sk->sk_type =3D=3D SOCK_STREAM))
>> +			break;
> This change is wrong. It immediately breaks normal connection set up be=
cause the ACK  (zero in length) has no chance to be sent back from the se=
rver to the client.
> Please try to test your patch before submission.=20

I did test the patch with the syzkaller C repro under QEMU for 10 minutes=
, and
it did not trigger the reported RCU stall:

      /tmp/repro & pid=3D$!; sleep 600; kill $pid
      dmesg | grep -Ei 'rcu.*stall|rcu_preempt|soft lockup|panic|BUG|WARN=
ING' (attached)

The dmesg check did not show any repro-triggered RCU stall, soft lockup,
panic, BUG, or WARNING. But that test only covered the syzkaller trigger;=

it did not cover normal active/passive TIPC stream connection setup, whic=
h
your review points out is broken by this version.

I re-checked the TIPC connection setup path as well.

tipc_accept() intentionally sends the server-side ACK as a zero-length
stream message:

      iov_iter_kvec(&m.msg_iter, ITER_SOURCE, NULL, 0, 0);
      __tipc_sendstream(new_sock, &m, 0);

So blocking all zero-length sends inside __tipc_sendstream() prevents
that ACK from being transmitted and can break normal SOCK_STREAM
connection setup.

After re-checking the syzkaller repro, the real trigger seems to be narro=
wer
than zero-length stream send. The repro uses a user sendmsg() with
MSG_PROBE | MSG_MORE and no payload on an already connected TIPC stream
socket. MSG_PROBE is supposed to probe without sending, but TIPC stream
send currently lets that path reach __tipc_sendstream(), where the
do/while body can still run once with dlen =3D=3D 0 and build/transmit a
header-only message.

I think we should avoid suppressing the internal __tipc_sendstream() ACK =
path
and instead handle the user-originated zero-length MSG_PROBE case before =
it
reaches the internal stream send helper.

The v2 fix would look like this:

-- 8< --

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f..4783df337971 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1542,6 +1542,10 @@ static int tipc_sendstream(struct socket *sock, st=
ruct msghdr *m, size_t dsz)
        struct sock *sk =3D sock->sk;
        int ret;
=20
+       /* MSG_PROBE asks only to probe the path, not to transmit data. *=
/
+       if (unlikely((m->msg_flags & MSG_PROBE) && !dsz))
+               return 0;
+
        lock_sock(sk);
        ret =3D __tipc_sendstream(sock, m, dsz);
        release_sock(sk);
-- >8 --

I tested the reworked patch with the syzkaller C reproducer under QEMU.
The reproducer was run for 10 minutes:

      /tmp/repro & pid=3D$!; sleep 600; kill $pid
      dmesg | grep -Ei 'rcu.*stall|rcu_preempt|soft lockup|panic|BUG|WARN=
ING' (attached)

The grep only matched boot-time command-line/debug messages; no
repro-triggered RCU stall, soft lockup, panic, BUG, or WARNING appeared.

What you think?
--------------d6PCoNGxfH9UhgBdD0GaQD4M
Content-Type: text/plain; charset=UTF-8; name="patch_v1_test_log.txt"
Content-Disposition: attachment; filename="patch_v1_test_log.txt"
Content-Transfer-Encoding: base64

IyBkbWVzZyB8IGdyZXAgLUVpICdyY3UuKnN0YWxsfHJjdV9wcmVlbXB0fHNvZnQgbG9ja3Vw
fHBhbmljfEJVR3xXQVJOSU5HJwpbICAgIDAuMDAwMDAwXVsgICAgVDBdICAgbmV0LmlmbmFt
ZXM9MCBwYW5pY19vbl93YXJuPTEKWyAgICAwLjAwMDAwMF1bICAgIFQwXSBLZXJuZWwgY29t
bWFuZCBsaW5lOiBlYXJseXByaW50az1zZXJpYWwgbmV0LmlmbmFtZXM9MCBzeXNjdGwua2Vy
bmVsLmh1bmdfdGFza19hbGxfY3B1X2JhY2t0cmFjZT0xIGltYV9wb2xpY3k9dGNiIG5mLWNv
bm50cmFjay1mdHAucG9ydHM9MjAwMDAgbmYtY29ubnRyYWNrLXRmdHAucG9ydHM9MjAwMDAg
bmYtY29ubnRyYWNrLXNpcC5wb3J0cz0yMDAwMCBuZi1jb25udHJhY2staXJjLnBvcnRzPTIw
MDAwIG5mLWNvbm50cmFjay1zYW5lLnBvcnRzPTIwMDAwIGJpbmRlci5kZWJ1Z19tYXNrPTAg
cmN1cGRhdGUucmN1X2V4cGVkaXRlZD0xIHJjdXBkYXRlLnJjdV9jcHVfc3RhbGxfY3B1dGlt
ZT0xIG5vX2hhc2hfcG9pbnRlcnMgcGFnZV9vd25lcj1vbiBzeXNjdGwudm0ubnJfaHVnZXBh
Z2VzPTQgc3lzY3RsLnZtLm5yX292ZXJjb21taXRfaHVnZXBhZ2VzPTQgc2VjcmV0bWVtLmVu
YWJsZT0xIHN5c2N0bC5tYXhfcmN1X3N0YWxsX3RvX3BhbmljPTEgbXNyLmFsbG93X3dyaXRl
cz1vZmYgY29yZWR1bXBfZmlsdGVyPTB4ZmZmZiByb290PS9kZXYvc2RhIGNvbnNvbGU9dHR5
UzAgdnN5c2NhbGw9bmF0aXZlIG51bWE9ZmFrZT0yIGt2bS1pbnRlbC5uZXN0ZWQ9MSBzcGVj
X3N0b3JlX2J5cGFzc19kaXNhYmxlPXByY3RsIG5vcGNpZCB2aXZpZC5uX2RldnM9NjQgdml2
aWQubXVsdGlwbGFuYXI9MSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwy
LDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwx
LDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiBuZXRyb20ubnJfbmRldnM9MzIg
cm9zZS5yb3NlX25kZXZzPTMyIHNtcC5jc2RfbG9ja190aW1lb3V0PTEwMDAwMCB3YXRjaGRv
Z190aHJlc2g9NTUgd29ya3F1ZXVlLndhdGNoZG9nX3RocmVzaD0xNDAgc3lzY3RsLm5ldC5j
b3JlLm5ldGRldl91bnJlZ2lzdGVyX3RpbWVvdXRfc2Vjcz0xNDAgZHVtbXlfaGNkLm51bT0z
MiBtYXhfbG9vcD0zMiBuYmRzX21heD0zMiBcClsgICAgMC4wMDAwMDBdWyAgICBUMF0gS2Vy
bmVsIGNvbW1hbmQgbGluZTogY29tZWRpLmNvbWVkaV9udW1fbGVnYWN5X21pbm9ycz00IHBh
bmljX29uX3dhcm49MSBjb25zb2xlPXR0eVMwIHJvb3Q9L2Rldi92ZGExIHJvb3Rmc3R5cGU9
ZXh0NCBydyBlYXJseXByaW50az1zZXJpYWwKWyAgICAwLjAwMDAwMF1bICAgIFQwXSAgIG5l
dC5pZm5hbWVzPTAgcGFuaWNfb25fd2Fybj0xClsgICAgMC4wMDAwMDBdWyAgICBUMF0gKiog
SWYgeW91IHNlZSB0aGlzIG1lc3NhZ2UgYW5kIHlvdSBhcmUgbm90IGRlYnVnZ2luZyAgICAq
KgpbICAgIDAuMDAwMDAwXVsgICAgVDBdIHJjdTogICAgIFJDVSBjYWxsYmFjayBkb3VibGUt
L3VzZS1hZnRlci1mcmVlIGRlYnVnIGlzIGVuYWJsZWQuClsgICAgMC4wMDAwMDBdWyAgICBU
MF0gcmN1OiAgICAgUkNVIGRlYnVnIGV4dGVuZGVkIFFTIGVudHJ5L2V4aXQuClsgICAxMC43
MDQ2MTVdWyAgICBUMV0gUENJOiBVc2luZyBob3N0IGJyaWRnZSB3aW5kb3dzIGZyb20gQUNQ
STsgaWYgbmVjZXNzYXJ5LCB1c2UgInBjaT1ub2NycyIgYW5kIHJlcG9ydCBhIGJ1ZwpbICAg
MjEuODI2ODM4XVsgICAgVDFdIG9yYW5nZWZzX2RlYnVnZnNfaW5pdDogY2FsbGVkIHdpdGgg
ZGVidWcgbWFzazogOm5vbmU6IDowOgpbICAgMjIuMDMyMjM3XVsgICAgVDFdIFNHSSBYRlMg
d2l0aCBBQ0xzLCBzZWN1cml0eSBhdHRyaWJ1dGVzLCByZWFsdGltZSwgcXVvdGEsIG5vIGRl
YnVnIGVuYWJsZWQKWyAgIDc3LjI5NjQ5N11bICAgIFQxXSB1c2Jjb3JlOiByZWdpc3RlcmVk
IG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYl9kZWJ1ZwpbICAgNzcuMzA5NjA0XVsgICAgVDFd
IHVzYnNlcmlhbDogVVNCIFNlcmlhbCBzdXBwb3J0IHJlZ2lzdGVyZWQgZm9yIGRlYnVnClsg
IDExNC4yMzgxNDldWyAgICBUMV0gcHZydXNiMjogRGVidWcgbWFzayBpcyAzMSAoMHgxZikK
WyAgMTgxLjEwMDY0MV1bICAgIFQxXSBkZWJ1Z192bV9wZ3RhYmxlOiBbZGVidWdfdm1fcGd0
YWJsZSAgICAgICAgIF06IFZhbGlkYXRpbmcgYXJjaGl0ZWN0dXJlIHBhZ2UgdGFibGUgaGVs
cGVycwpbICAyMDEuNTU2NzQxXVsgICAgVDFdIEZhaWxlZCB0byBzZXQgc3lzY3RsIHBhcmFt
ZXRlciAnbWF4X3JjdV9zdGFsbF90b19wYW5pYz0xJzogcGFyYW1ldGVyIG5vdCBmb3VuZApb
MV0rICBUZXJtaW5hdGVkICAgICAgICAgICAgICAgICAvdG1wL3JlcHJvCg==
--------------d6PCoNGxfH9UhgBdD0GaQD4M
Content-Type: text/plain; charset=UTF-8; name="patch_v2_test_log.txt"
Content-Disposition: attachment; filename="patch_v2_test_log.txt"
Content-Transfer-Encoding: base64

IyBkbWVzZyB8IGdyZXAgLUVpICdyY3UuKnN0YWxsfHJjdV9wcmVlbXB0fHNvZnQgbG9ja3Vw
fHBhbmljfEJVR3xXQVJOSU5HJwpbICAgIDAuMDAwMDAwXVsgICAgVDBdIENvbW1hbmQgbGlu
ZTogY29uc29sZT10dHlTMCByb290PS9kZXYvdmRhMSByb290ZnN0eXBlPWV4dDQgcncgZWFy
bHlwcmludGs9c2VyaWFsIG5ldC5pZm5hbWVzPTAgcGFuaWNfb25fd2Fybj0xClsgICAgMS40
NjI0MzBdWyAgICBUMF0gS2VybmVsIGNvbW1hbmQgbGluZTogZWFybHlwcmludGs9c2VyaWFs
IG5ldC5pZm5hbWVzPTAgc3lzY3RsLmtlcm5lbC5odW5nX3Rhc2tfYWxsX2NwdV9iYWNrdHJh
Y2U9MSBpbWFfcG9saWN5PXRjYiBuZi1jb25udHJhY2stZnRwLnBvcnRzPTIwMDAwIG5mLWNv
bm50cmFjay10ZnRwLnBvcnRzPTIwMDAwIG5mLWNvbm50cmFjay1zaXAucG9ydHM9MjAwMDAg
bmYtY29ubnRyYWNrLWlyYy5wb3J0cz0yMDAwMCBuZi1jb25udHJhY2stc2FuZS5wb3J0cz0y
MDAwMCBiaW5kZXIuZGVidWdfbWFzaz0wIHJjdXBkYXRlLnJjdV9leHBlZGl0ZWQ9MSByY3Vw
ZGF0ZS5yY3VfY3B1X3N0YWxsX2NwdXRpbWU9MSBub19oYXNoX3BvaW50ZXJzIHBhZ2Vfb3du
ZXI9b24gc3lzY3RsLnZtLm5yX2h1Z2VwYWdlcz00IHN5c2N0bC52bS5ucl9vdmVyY29tbWl0
X2h1Z2VwYWdlcz00IHNlY3JldG1lbS5lbmFibGU9MSBzeXNjdGwubWF4X3JjdV9zdGFsbF90
b19wYW5pYz0xIG1zci5hbGxvd193cml0ZXM9b2ZmIGNvcmVkdW1wX2ZpbHRlcj0weGZmZmYg
cm9vdD0vZGV2L3NkYSBjb25zb2xlPXR0eVMwIHZzeXNjYWxsPW5hdGl2ZSBudW1hPWZha2U9
MiBrdm0taW50ZWwubmVzdGVkPTEgc3BlY19zdG9yZV9ieXBhc3NfZGlzYWJsZT1wcmN0bCBu
b3BjaWQgdml2aWQubl9kZXZzPTY0IHZpdmlkLm11bHRpcGxhbmFyPTEsMiwxLDIsMSwyLDEs
MiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIs
MSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIsMSwyLDEs
MiwxLDIgbmV0cm9tLm5yX25kZXZzPTMyIHJvc2Uucm9zZV9uZGV2cz0zMiBzbXAuY3NkX2xv
Y2tfdGltZW91dD0xMDAwMDAgd2F0Y2hkb2dfdGhyZXNoPTU1IHdvcmtxdWV1ZS53YXRjaGRv
Z190aHJlc2g9MTQwIHN5c2N0bC5uZXQuY29yZS5uZXRkZXZfdW5yZWdpc3Rlcl90aW1lb3V0
X3NlY3M9MTQwIGR1bW15X2hjZC5udW09MzIgbWF4X2xvb3A9MzIgbmJkc19tYXg9MzIgXApb
ICAgIDEuNDcwNzYxXVsgICAgVDBdIEtlcm5lbCBjb21tYW5kIGxpbmU6IGNvbWVkaS5jb21l
ZGlfbnVtX2xlZ2FjeV9taW5vcnM9NCBwYW5pY19vbl93YXJuPTEgY29uc29sZT10dHlTMCBy
b290PS9kZXYvdmRhMSByb290ZnN0eXBlPWV4dDQgcncgZWFybHlwcmludGs9c2VyaWFsIG5l
dC5pZm5hbWVzPTAgcGFuaWNfb25fd2Fybj0xClsgICAgMy4xNTU5MTRdWyAgICBUMF0gKiog
SWYgeW91IHNlZSB0aGlzIG1lc3NhZ2UgYW5kIHlvdSBhcmUgbm90IGRlYnVnZ2luZyAgICAq
KgpbICAgIDMuODEzMjk4XVsgICAgVDBdIHJjdTogICAgIFJDVSBjYWxsYmFjayBkb3VibGUt
L3VzZS1hZnRlci1mcmVlIGRlYnVnIGlzIGVuYWJsZWQuClsgICAgMy44MTQ2NDVdWyAgICBU
MF0gcmN1OiAgICAgUkNVIGRlYnVnIGV4dGVuZGVkIFFTIGVudHJ5L2V4aXQuClsgICAxNy4w
OTYxNjNdWyAgICBUMV0gUENJOiBVc2luZyBob3N0IGJyaWRnZSB3aW5kb3dzIGZyb20gQUNQ
STsgaWYgbmVjZXNzYXJ5LCB1c2UgInBjaT1ub2NycyIgYW5kIHJlcG9ydCBhIGJ1ZwpbICAg
MjguNTY2NTIxXVsgICAgVDFdIG9yYW5nZWZzX2RlYnVnZnNfaW5pdDogY2FsbGVkIHdpdGgg
ZGVidWcgbWFzazogOm5vbmU6IDowOgpbICAgMjguNzk2MTkwXVsgICAgVDFdIFNHSSBYRlMg
d2l0aCBBQ0xzLCBzZWN1cml0eSBhdHRyaWJ1dGVzLCByZWFsdGltZSwgcXVvdGEsIG5vIGRl
YnVnIGVuYWJsZWQKWyAgIDg0LjQ4NjUyM11bICAgIFQxXSB1c2Jjb3JlOiByZWdpc3RlcmVk
IG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYl9kZWJ1ZwpbICAgODQuNTA0Mjg2XVsgICAgVDFd
IHVzYnNlcmlhbDogVVNCIFNlcmlhbCBzdXBwb3J0IHJlZ2lzdGVyZWQgZm9yIGRlYnVnClsg
IDExNC40MTkyNTFdWyAgICBUMV0gcHZydXNiMjogRGVidWcgbWFzayBpcyAzMSAoMHgxZikK
WyAgMTc5LjM5NjE4MF1bICAgIFQxXSBkZWJ1Z192bV9wZ3RhYmxlOiBbZGVidWdfdm1fcGd0
YWJsZSAgICAgICAgIF06IFZhbGlkYXRpbmcgYXJjaGl0ZWN0dXJlIHBhZ2UgdGFibGUgaGVs
cGVycwpbICAxODUuOTA3MzU5XVsgICAgVDFdIEZhaWxlZCB0byBzZXQgc3lzY3RsIHBhcmFt
ZXRlciAnbWF4X3JjdV9zdGFsbF90b19wYW5pYz0xJzogcGFyYW1ldGVyIG5vdCBmb3VuZApb
MV0rICBUZXJtaW5hdGVkICAgICAgICAgICAgICAgICAvdG1wL3JlcHJvCg==

--------------d6PCoNGxfH9UhgBdD0GaQD4M--

--------------bY2qRkxssXquW0YwpYsfN4R1--

--------------qfmLxCCe833TR8Z2e3bOQoDx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSrYqI5vIrg1X9eqEjQXT8aWv/ugwUCafvwUwUDAAAAAAAKCRDQXT8aWv/ug2Wt
AP0SdqwdtX+jKSQqLtjrn5Vd1U6DUs6ukUH1FbcOv0FtfAEAtOA9RSoFRjEg0fsTTMLhlp8fSIt8
1hj72kd4rYRDAwY=
=+/XT
-----END PGP SIGNATURE-----

--------------qfmLxCCe833TR8Z2e3bOQoDx--

