Return-Path: <stable+bounces-246798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAiDMRxJBGrNGgIAu9opvQ
	(envelope-from <stable+bounces-246798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:49:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F2530EE4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FEC53006788
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088F73E9C1C;
	Wed, 13 May 2026 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="gy37sHbM"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC553E9C1E
	for <stable@vger.kernel.org>; Wed, 13 May 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665745; cv=none; b=nJl/qu8vfgKU7AQ5Z62FfrkLxVC1oD03GjE6qJsjPVxhXOEKm0Mt+WUR3Jt6GZAspMBHRYsz/GCrua4aKLEeZI+r/xV8eDu8EMqHB+NlZRnxm4Jlf1sx+wfe8jAauah3dqJqABAB6yuLKBRqzG0zZXBKeME9NhJK4RNOe9wck1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665745; c=relaxed/simple;
	bh=oBhZ4x5a7o3epmQFqTccZxZ+TbQdfZDHaW4QGS8Ao54=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=piP1F+4pZrXuv5rZpZwlorpBaY9hud8BUzCQ8RIoXvlAS0/DPV74HruFZM6D+zjbFkSQ9OkkMlco8/sq5YU2wYb9zcwTvr71ZBGY7HnWTVUD8zUhRvSU51oukNAPX+33vsGiYq4gW/d6g0KfWNnBn0FerQqIwjaJpDOWZfUjQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=gy37sHbM; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=10673; t=1778665692;
	x=1779270492; i=jaltman@auristor.com; q=dns/txt; h=Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; z=Received:=
	20from=20smtpclient.apple=20([143.244.47.72])=20by=20auristor.co
	m=20(208.125.0.237)=20(MDaemon=20PRO=20v26.0.2)=20=0D=0A=09with=
	20ESMTPSA=20id=20md5001005270902.msg=3B=20Wed,=2013=20May=202026
	=2005=3A48=3A12=20-0400|Content-Type:=20multipart/signed=3B=0D=0
	A=09boundary=3D"Apple-Mail=3D_625BD158-258B-4AAE-9AD3-EB3800D12D
	C1"=3B=0D=0A=09protocol=3D"application/pkcs7-signature"=3B=0D=0A
	=09micalg=3Dsha-256|Mime-Version:=201.0=20(Mac=20OS=20X=20Mail=2
	016.0=20\(3826.700.81.1.8\))|Subject:=20Re=3A=20[PATCH=20net=202
	/3]=20rxrpc=3A=20Fix=20DATA=20decrypt=20vs=20splice()=20by=20cop
	ying=0D=0A=20data=20to=20buffer=20in=20recvmsg|From:=20Jeffrey=2
	0Altman=20<jaltman@auristor.com>|In-Reply-To:=20<1354628.1778659
	274@warthog.procyon.org.uk>|Date:=20Wed,=2013=20May=202026=2005=
	3A48=3A39=20-0400|Cc:=20netdev@vger.kernel.org,=0D=0A=20Hyunwoo=
	20Kim=20<imv4bel@gmail.com>,=0D=0A=20Marc=20Dionne=20<marc.dionn
	e@auristor.com>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel.org>,=0
	D=0A=20"David=20S.=20Miller"=20<davem@davemloft.net>,=0D=0A=20Er
	ic=20Dumazet=20<edumazet@google.com>,=0D=0A=20Paolo=20Abeni=20<p
	abeni@redhat.com>,=0D=0A=20Simon=20Horman=20<horms@kernel.org>,=
	0D=0A=20linux-afs@lists.infradead.org,=0D=0A=20linux-kernel@vger
	.kernel.org,=0D=0A=20Jiayuan=20Chen=20<jiayuan.chen@linux.dev>,=
	0D=0A=20stable@vger.kernel.org|Content-Transfer-Encoding:=20quot
	ed-printable|Message-Id:=20<E1EC6457-E634-4C8B-B7F1-C03E440BA973
	@auristor.com>|References:=20<437CCB8A-5333-4349-B120-A103B1F0E6
	17@auristor.com>=0D=0A=20<20260511160753.607296-1-dhowells@redha
	t.com>=0D=0A=20<20260511160753.607296-3-dhowells@redhat.com>=0D=
	0A=20<1354628.1778659274@warthog.procyon.org.uk>|To:=20David=20H
	owells=20<dhowells@redhat.com>; bh=9TwnbfnKTC2dwrRxqU537J9e1cSR+
	mPjVMpsjvjcHVM=; b=gy37sHbMSvKQ4Dg2yJk+CW1UEbzsPzw58ANnbRrgwPOlu
	RgVFdzZqEs2pyxzhhfNI/o6KVWw+obbzY6arYD1jfkwhOy1Bs3grjjBjRRIQpkGC
	+d5FZWwWZ6wvrSGlNITh07T8LK20XnZ3TBBrQ9g+mBesbi6Mmm/RR9uw+9J+ZE=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Wed, 13 May 2026 05:48:12 -0400
Received: from smtpclient.apple ([143.244.47.72]) by auristor.com (208.125.0.237) (MDaemon PRO v26.0.2) 
	with ESMTPSA id md5001005270902.msg; Wed, 13 May 2026 05:48:12 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Wed, 13 May 2026 05:48:12 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 143.244.47.72
X-MDHelo: smtpclient.apple
X-MDArrival-Date: Wed, 13 May 2026 05:48:12 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1593db9306=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Content-Type: multipart/signed;
	boundary="Apple-Mail=_625BD158-258B-4AAE-9AD3-EB3800D12DC1";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying
 data to buffer in recvmsg
From: Jeffrey Altman <jaltman@auristor.com>
In-Reply-To: <1354628.1778659274@warthog.procyon.org.uk>
Date: Wed, 13 May 2026 05:48:39 -0400
Cc: netdev@vger.kernel.org,
 Hyunwoo Kim <imv4bel@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Jiayuan Chen <jiayuan.chen@linux.dev>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1EC6457-E634-4C8B-B7F1-C03E440BA973@auristor.com>
References: <437CCB8A-5333-4349-B120-A103B1F0E617@auristor.com>
 <20260511160753.607296-1-dhowells@redhat.com>
 <20260511160753.607296-3-dhowells@redhat.com>
 <1354628.1778659274@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: B02F2530EE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246798-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_X_AS(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[auristor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,linux.dev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--Apple-Mail=_625BD158-258B-4AAE-9AD3-EB3800D12DC1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 13, 2026, at 4:01=E2=80=AFAM, David Howells =
<dhowells@redhat.com> wrote:
>=20
> Jeffrey Altman <jaltman@auristor.com> wrote:
>=20
>>> + void *rx_dec_buffer; /* Decryption buffer */
>>> + unsigned short rx_dec_bsize; /* rx_dec_buffer size */
>>> + unsigned short rx_dec_offset; /* Decrypted packet data offset */
>>> + unsigned short rx_dec_len; /* Decrypted packet data len */
>>> + rxrpc_seq_t rx_dec_seq; /* Packet in decryption buffer */
>>>=20
>>> rxrpc_seq_t rx_highest_seq; /* Higest sequence number received */
>>> rxrpc_seq_t rx_consumed; /* Highest packet consumed */
>>=20
>>=20
>> Instead of allocating the storage within struct rxrpc_call perhaps
>> It would be better to add them to struct rxrpc_channel.  Doing so=20
>> would reduce the allocation/deallocation churn.  The majority of
>> calls are short lived (perhaps a single packet in each direction)
>> but there will be many calls in rapid succession.
>=20
> I'm trying to keep the I/O side separate from the application side.  I =
don't
> particularly want recvmsg (on the app side) reaching into the =
rxrpc_connection
> struct (on the I/O side).
>=20
> Further, by only looking at the rxrpc_call struct, I don't have to =
deal with
> locking required for the possibility that the next call on that =
channel will
> start before I've finished with this one (say an incoming call is =
aborted and
> immediately followed up by the first packet of the next call).

There could only be one rxrpc_call structure at a time referring to the=20=

rxrpc_channel.  If rxrpc_input_packet_on_conn() receives a DATA packet =
for a
later call number and there is a prior rxrpc_call assigned to =
rxrpc_channel.call
then an RX_PACKET_TYPE_BUSY should be sent to the peer if the rx_call =
cannot be
terminated without blocking the processing of incoming packets.  The Rx =
BUSY
informs the initiating peer that the DATA packet has been dropped and =
that it
should be retransmitted (which will occur anyway due to the lack of an =
Rx ACK
packet.

The busy call channel logic is out of scope for this change and avoiding
per-call allocation churn is an optimization that can be implemented =
another
day if desired.

>=20
>>> + size_t size =3D umin(round_up(sp->len, 32), 2048);
>>=20
>> I think you meant to use max() here so that a minimum of 2048 bytes
>> is allocated. =20
>=20
> Yeah.
>=20
>> I think applying a cap on the allocation size would also be=20
>> beneficial.  IBM/Transarc derived Rx implementations have a hard
>> upper-bound of 21180 (15 x 1412) bytes plus one 28 byte rx header.
>> Applying a cap of 32KiB seems prudent.
>=20
> This would need checking earlier in the input path.  A DATA packet =
that's too
> large would need to be rejected as it comes off of the UDP socket if =
we're not
> going to be able to unpack it later.

ok.

>=20
>> It is also worth noting that there are no current implementations
>> of Rx RPC which will send individual Rx DATA packets larger than=20
>> 1444 bytes including the Rx header.  Rx RESPONSE packets can be sent
>> as large as 16384 bytes (including the Rx header).  However, it is
>> extremely unlikely that this buffer once allocated would ever need=20
>> to be grown. =20
>=20
> For Rx RESPONSE packets, I'm fine with allocating a buffer on the spur =
of the
> moment and freeing it immediately.  Ideally, there would only be one =
RESPONSE
> per connection anyway.  I could do a static buffer with a lock, I =
suppose, to
> make sure I can process the things under memory pressure-based =
writeback.

I agree.  The Rx RESPONSE packets belong to the rxrpc_connection and not =
to=20
any particular call.  It is possible for there to be more than one Rx =
RESPONSE
packet received due to Rx CHALLENGE retransmission or because this peer =
decided
it can no longer trust the prior authentication and sends a new Rx =
CHALLENGE.
However, RESPONSE packets are few and far between.  There is no benefit =
to
adding another 16KB to the rxrpc_connection allocation.

>=20
>>> + kfree(call->rx_dec_buffer);
>>=20
>> It might be better to avoid deallocating the buffer on the error
>> path and permit it to be freed during normal call (or call channel)
>> deallocation.
>=20
> Hmmm.  But I then need some other way to note that the buffer is no =
longer
> occupied by valid data.  I suppose I could set ->rx_dec_offset to =
USHRT_MAX.

That meaning was unclear and could warrant a code comment indicating =
that
is why the allocation is being freed.


> David
>=20

Thanks.

Jeffrey Altman=

--Apple-Mail=_625BD158-258B-4AAE-9AD3-EB3800D12DC1
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDTAw
ggY0MIIEHKADAgECAhBAAZimBAJ19t4m6OTgn3OxMA0GCSqGSIb3DQEBCwUAMDoxCzAJBgNVBAYT
AlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTE0MB4XDTI1MDgx
NDAwMzg1N1oXDTI3MTEwMTAwMzc1N1owgcwxKDAmBgNVBAUTH0EwMTQxMEMwMDAwMDE5OEE2MDQw
MjY3MDAxMEYyNjIxGTAXBgNVBGETEE5UUlVTK05ZLTM1ODIyMzcxFTATBgNVBAoTDEF1cmlTdG9y
IEluYzEZMBcGA1UEAxMQSmVmZnJleSBFIEFsdG1hbjEPMA0GA1UEBBMGQWx0bWFuMRAwDgYDVQQq
EwdKZWZmcmV5MSMwIQYJKoZIhvcNAQkBFhRqYWx0bWFuQGF1cmlzdG9yLmNvbTELMAkGA1UEBhMC
VVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKtXD1tqgXxlJvgI10FM0ZvyWukq2I
eXgVhbgOk4k4PbRk1TvrGB04QatXac9soW7yHv6RhoovQ+URaXBEpBYxOE8Tsx+XfKZNkGbWj9bE
dWgi8HPb33rf8eKFuhjx1QEv/YtD7lGIp7RhKWC5kBfvyut8o3XJmJF0hCR1m663wsttrn89dwZc
zLU4JUjbTF0ukM0DbDk55ItDB4dXnW/uRfhrVuemMvbDily+etLCWsuJjtrjRBCQ805eYRHq5Lon
X3oNLdXituSHXLKvq+uChgFN/veDHKpeBnBWmoNtOQnV8fsq5NCz/WswIACeZj+xGmZsWx7fyuze
e78ZePfBAgMBAAGjggGhMIIBnTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIE8DCBhAYIKwYB
BQUHAQEEeDB2MDAGCCsGAQUFBzABhiRodHRwOi8vY29tbWVyY2lhbC5vY3NwLmlkZW50cnVzdC5j
b20wQgYIKwYBBQUHMAKGNmh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY2VydHMvdHJ1
c3RpZGNhYTE0LnA3YzAfBgNVHSMEGDAWgBTC1ESZoHHPSFa+DI5oOFynt/dFvDAjBgNVHSAEHDAa
MAkGB2eBDAEFAwIwDQYLYIZIAYb5LwAGAgEwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL3ZhbGlk
YXRpb24uaWRlbnRydXN0LmNvbS9jcmwvdHJ1c3RpZGNhYTE0LmNybDAfBgNVHREEGDAWgRRqYWx0
bWFuQGF1cmlzdG9yLmNvbTAdBgNVHQ4EFgQUY4JHedU4owyskKPvw4gOjSyBJZUwKQYDVR0lBCIw
IAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMMMA0GCSqGSIb3DQEBCwUAA4ICAQCeOjCs
cMFctL6UG8WBsFMIOHc7MpbrX7EIvO34SGVKhrbqS1RTIBQiVVWnQ4VI6qVw/n9dadUv4o1/F23s
0uXE8/lGJAGn51kkw1xHU+0PGODOTWvAQOiPhSmaXG5xM4BgleroGggumd8fHRSKFK7DIdWcMMNb
S6LpMAOUfXYzNBvcHbAcjJMHQ7N8pNXdEQDB9c6yIw4paVD6XDE5VFhLdf6749jGqSWXpyTMjXzr
PMaDyxKiNOtsUrdT/fh8+Xx84nGpwiV9PA9/cGSAPcAc/qMBgPb4Qj9met/RUvCHPWr68Zlirgx4
8W/7TTZFhXKZg3U+zCj4ASOfLJ6WT4PPoM+eLHbB402WNMFkQDmWBH4bMqUcbQWxarMxdQ/jHKTs
JIkvg+rTCbWbDm7hgJbnPEZrJEghy69Opa9+F1HB90AQmb41N1PLZytu8pCGBJufyqjzNU0eyWkH
JCwHDLFhoCENk/vujFCmsJUSh7a6ZMPSXf3PR4TPKkcgs9JBT0dyPGHEfC/Lp9ZHTGSO6zswK1Bd
dBufYi3xqHNBO/s7ft6gpNvht7oKUhVcjM7EmQCA6t2ok44PNfeG8rJZxiDv04IruCbzLFwkPczW
S5uCIuP3PWCfVtMnUPDamMVWAr4Ui/s6fy3TZbPUAPDjFRi7zpkFIKHlCS/HIHNR6Gr1lzCCBvQw
ggTcoAMCAQICEEABif/SaQvad8Lp1U2SCE0wDQYJKoZIhvcNAQELBQAwSjELMAkGA1UEBhMCVVMx
EjAQBgNVBAoTCUlkZW5UcnVzdDEnMCUGA1UEAxMeSWRlblRydXN0IENvbW1lcmNpYWwgUm9vdCBD
QSAxMB4XDTIzMDgxNjE5Mjg0NloXDTMzMDgxMjE5Mjg0NVowOjELMAkGA1UEBhMCVVMxEjAQBgNV
BAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTQwggIiMA0GCSqGSIb3DQEBAQUA
A4ICDwAwggIKAoICAQDoqfW8senk2X/L7Viky0ZgZYnwlxqsE/vDQWARa1i7gZ0wRJ7ZOWIbjYDc
csGFBhCb8VLx1dershozyPcOizZ1LxAhstZhpz8KvKc4bHhu1+6ZJftmrDyAELLRu1gkPS0Bvong
GBinxoTNo0XwafmS67jFRtYHe2VQSLvy0t9xRUsgdEeYgCUAnKO5eRVQMmBBNhnsTFtO5FzNmNKn
uw/TDcBbOpGrQ1FSCuOZTHw3njDtZGqiRXSruX3MCpV190CefwryeGLXCsawSz2wMQZkqtjYV9Au
73Zrqg1yDVj9KGKoRnJ8cUcg1Inxs/+Bo3xcM43y2h10yDrSWFTfvPSQhUJwYKHCYJSVQLFbeH9v
xFJeLlewivaKQMGEg8PpnjevzDu8PVVzr9gkWcLubhztussqdAPF+dvyXIYJb/7l6idZkS4NeHAs
rAtcv+UF+SGzSS5F28s376Kx35LUaJeOW4hQOjSj/118F9cyYAd2WlgGdBdaK2PSvH7aANZQfyEh
NNMzk2GP83pHXXeXy+09LkTcIlgXr2rrXepxP+WBp+Ihu4Jh5uZWQkpGUUNqKSjxIpUJ6sDIIgGI
qSY/uBFSp2ff+4OLLS3Z+XQ9gBu1Szd3kQ8PrGXAI5DXayXjM9YppsHld3OojXhoOsLdCji+be0m
AgvbNa6AaSJcT7RF3QIDAQABo4IB5DCCAeAwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8E
BAMCAYYwgYkGCCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2Nz
cC5pZGVudHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3Qu
Y29tL3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djBfBgNVHSAEWDBWMFQGBFUdIAAwTDBKBggrBgEFBQcCARY+aHR0cHM6Ly9zZWN1cmUu
aWRlbnRydXN0LmNvbS9jZXJ0aWZpY2F0ZXMvcG9saWN5L3RzL2luZGV4Lmh0bWwwSgYDVR0fBEMw
QTA/oD2gO4Y5aHR0cDovL3ZhbGlkYXRpb24uaWRlbnRydXN0LmNvbS9jcmwvY29tbWVyY2lhbHJv
b3RjYTEuY3JsMB0GA1UdDgQWBBTC1ESZoHHPSFa+DI5oOFynt/dFvDBBBgNVHSUEOjA4BggrBgEF
BQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwwGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQwDQYJKoZI
hvcNAQELBQADggIBAJXyFF1baV3jUq5o3Q5FIysADRg5knGSFzcliSyYTBd5YZ4FYFZSDxrQ25J8
7EFzq8q9a1lQxNwcj2R3IFNfx5QWU6EApuGwiOgX9igx3EAJuOa8JnSoLUI5zKflmNqTVHSz3b94
UQy/MF+s8+OwbM8+FscUY0CxXRlOEETsW6MFXfliOSIEnQFmm5NraqzYHecXC8DJF6yTxbu1+101
T66oqkp9+EAvU+SXgSIcHDpNxAmbm6XcSQFwEZLOLSctCVeZzLsvCE1Ozr5hvEAstYh07Qm/FtuZ
+M540l2qSydFaI4yD7uH6/SsjQAARQXYzezBauwR8YOTS7PUDWejFUpHzPy4q2JdYdU2jYTst4G7
gW0+y6EQyXIiSEEaKePUrnIiRImK6ySZXDTB7A+td6giMATY61GcJUS9kdCHZ4brFJiLBg9az11c
15e5SbS2bCNAMOIK6NwakjsWmh2jX+C6LJX37ehqQT0GVekYT4nGMBH89MiQ1kFnIQcIWTagA/Qq
FHMhHFlUH5mWyby/6alKXu0ZeODdBRR/Tn39K6awTCVSbQH8P+KbF5kMky9b7IFzJI/fwxr/ZVoE
KCj0aoicm2TTsXgqRUI7MgiLU6hE5ersxFh5yM2IBc8za+kvkB7SeXPhzloFqmayuM2QfrqjsX1F
0CopS11iOE4QVaJmMYICpjCCAqICAQEwTjA6MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRlblRy
dXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExNAIQQAGYpgQCdfbeJujk4J9zsTANBglghkgBZQME
AgEFAKCCASkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNTEz
MDk0ODM5WjAvBgkqhkiG9w0BCQQxIgQgbDzkLkA4VkKpAjpsUkduHg+DROAo6ICHKVTBkP3n38ww
XQYJKwYBBAGCNxAEMVAwTjA6MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRlblRydXN0MRcwFQYD
VQQDEw5UcnVzdElEIENBIEExNAIQQAGYpgQCdfbeJujk4J9zsTBfBgsqhkiG9w0BCRACCzFQoE4w
OjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBB
MTQCEEABmKYEAnX23ibo5OCfc7EwDQYJKoZIhvcNAQELBQAEggEAMUDR9xbmyNm6cYXAAi3W8w2z
Ylt1e040GByjzDNg+aPpIoTqyqr1WjMhNYvWieXj/uwnzWJQsDHT1Qb+w+gwbaUs3Kz+jz+EYTkV
kFiMp7Ri8wHZdaDz2zaU+JSFHr/vMzpRspOfBsLJkauYTkCzQK98psFzXF4XL1qMX7JfNEk3JIxw
kNlKopO48J6OKrKH0D48mwusw+27ONT24BwB686IbfTmFv9hmirnEo8HHB+iKtF+aQjfrZ/2q1y4
s65ex7ucwYh6d2BC3SGmX/ilrVswT9Rb05juCspS84fn+Cv92SPdKU0JnQ0Ua935G+t1iiefLDO3
7G9iTzBHFUQUFwAAAAAAAA==
--Apple-Mail=_625BD158-258B-4AAE-9AD3-EB3800D12DC1--


