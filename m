Return-Path: <stable+bounces-245420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCl6HEjeAmoMyQEAu9opvQ
	(envelope-from <stable+bounces-245420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:01:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435451C523
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 458DE3014BD3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A2481661;
	Tue, 12 May 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="R9u0GZ9p"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878130E0FD
	for <stable@vger.kernel.org>; Tue, 12 May 2026 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572733; cv=none; b=MSaNV7eLRz3ZhVEiAxBJNE8KzvlihdYLFS0dLjHTaNjzjmccPgUI76YV5zysZOFt4ceuBv8HBXhdvePDRgas03LgQZnt3XJzI0/p7TTmfcaWszVwJcJDCy/gx4pa3dX9yRSyFJZCBokpYsjKNxQ5YLD3bxz7X2u9PKnSDuwxurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572733; c=relaxed/simple;
	bh=QLjk/49IIs5BR3MtYB96L/hVnY8xLSZXt553tV1hPUM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LplC3yXTyUjY1BRehhcufFaNWUO4MumVKKGV6cFTOoGrygmQT6uIvxcTxeDoPrfXsIIwtpF83Ce93Tak7ao1z/a3dP4UjXCgM/Mg2z0t4bGzMACEJDOOnuMtb2u36GkDGP85otxKAhe1CyzqXH4geMpDDd/PGZu4bbEbHz9huRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=R9u0GZ9p; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=30314; t=1778572680;
	x=1779177480; i=jaltman@auristor.com; q=dns/txt; h=Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; z=Received:=
	20from=20smtpclient.apple=20([146.70.171.97])=20by=20auristor.co
	m=20(208.125.0.237)=20(MDaemon=20PRO=20v26.0.2b)=20=0D=0A=09with
	=20ESMTPSA=20id=20md5001005266489.msg=3B=20Tue,=2012=20May=20202
	6=2003=3A57=3A59=20-0400|Content-Type:=20multipart/signed=3B=0D=
	0A=09boundary=3D"Apple-Mail=3D_4B604AF3-E2C0-4551-975F-87EE074AB
	152"=3B=0D=0A=09protocol=3D"application/pkcs7-signature"=3B=0D=0
	A=09micalg=3Dsha-256|Mime-Version:=201.0=20(Mac=20OS=20X=20Mail=
	2016.0=20\(3826.700.81.1.8\))|Subject:=20Re=3A=20[PATCH=20net=20
	2/3]=20rxrpc=3A=20Fix=20DATA=20decrypt=20vs=20splice()=20by=20co
	pying=0D=0A=20data=20to=20buffer=20in=20recvmsg|From:=20Jeffrey=
	20Altman=20<jaltman@auristor.com>|In-Reply-To:=20<20260511160753
	.607296-3-dhowells@redhat.com>|Date:=20Tue,=2012=20May=202026=20
	03=3A58=3A21=20-0400|Cc:=20netdev@vger.kernel.org,=0D=0A=20Hyunw
	oo=20Kim=20<imv4bel@gmail.com>,=0D=0A=20Marc=20Dionne=20<marc.di
	onne@auristor.com>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel.org>
	,=0D=0A=20"David=20S.=20Miller"=20<davem@davemloft.net>,=0D=0A=2
	0Eric=20Dumazet=20<edumazet@google.com>,=0D=0A=20Paolo=20Abeni=2
	0<pabeni@redhat.com>,=0D=0A=20Simon=20Horman=20<horms@kernel.org
	>,=0D=0A=20linux-afs@lists.infradead.org,=0D=0A=20linux-kernel@v
	ger.kernel.org,=0D=0A=20Jiayuan=20Chen=20<jiayuan.chen@linux.dev
	>,=0D=0A=20stable@vger.kernel.org|Content-Transfer-Encoding:=20q
	uoted-printable|Message-Id:=20<437CCB8A-5333-4349-B120-A103B1F0E
	617@auristor.com>|References:=20<20260511160753.607296-1-dhowell
	s@redhat.com>=0D=0A=20<20260511160753.607296-3-dhowells@redhat.c
	om>|To:=20David=20Howells=20<dhowells@redhat.com>; bh=Lv6hbH1jbi
	zjDvelkjgs+5GNcraLOGKWqfpWcRQ82+M=; b=R9u0GZ9pjRsMcevKvKdfZFUwBr
	bSibsHO22R6c2otC12kaPK9ERaAl+9waRI+LFTFo4vS66aehX7PcTDU2D+wTEhrK
	UegDu7I9KdfCpyI6fcdcN0MK5uCKolIG3arnaPGl5qYjktV2RgyLZckw8cCGV4T1
	XP9ToVgvYHlkU8D9E=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Tue, 12 May 2026 03:58:00 -0400
Received: from smtpclient.apple ([146.70.171.97]) by auristor.com (208.125.0.237) (MDaemon PRO v26.0.2b) 
	with ESMTPSA id md5001005266489.msg; Tue, 12 May 2026 03:57:59 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Tue, 12 May 2026 03:57:59 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 146.70.171.97
X-MDHelo: smtpclient.apple
X-MDArrival-Date: Tue, 12 May 2026 03:57:59 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=159257c7c2=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Content-Type: multipart/signed;
	boundary="Apple-Mail=_4B604AF3-E2C0-4551-975F-87EE074AB152";
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
In-Reply-To: <20260511160753.607296-3-dhowells@redhat.com>
Date: Tue, 12 May 2026 03:58:21 -0400
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
Message-Id: <437CCB8A-5333-4349-B120-A103B1F0E617@auristor.com>
References: <20260511160753.607296-1-dhowells@redhat.com>
 <20260511160753.607296-3-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: 0435451C523
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[infradead.org:query timed out,auristor.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245420-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[auristor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,linux.dev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,auristor.com:mid,auristor.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,infradead.org:email,davemloft.net:email]
X-Rspamd-Action: no action

--Apple-Mail=_4B604AF3-E2C0-4551-975F-87EE074AB152
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 11, 2026, at 12:07=E2=80=AFPM, David Howells =
<dhowells@redhat.com> wrote:
>=20
> This improves the fix for CVE-2026-43500.
>=20
> Fix the pagecache corruption from in-place decryption of a DATA packet
> transmitted locally by splice() by getting rid of the packet sharing =
in the
> I/O thread and unconditionally extracting the packet content into a =
bounce
> buffer in which the buffer is decrypted.  recvmsg() (or the kernel
> equivalent) then copies the data from the bounce buffer to the =
destination
> buffer.  The sk_buff then remains unmodified.
>=20
> This has an additional advantage in that the packet is then arranged =
in the
> buffer with the correct alignment required for the crypto algorithms =
to
> process directly.  The performance of the crypto does seem to be a =
little
> faster and, surprisingly, the unencrypted performance doesn't seem to
> change much - possibly due to removing complexity from the I/O thread.
>=20
> Yet another advantage is that the I/O thread doesn't have to copy =
packets
> which would slow down packet distribution, ACK generation, etc..
>=20
> The buffer belongs to the call and is allocated initially at 2K,
> sufficiently large to hold a whole jumbo subpacket, but the buffer =
will be
> increased in size if needed.  There is one downside here, and that's =
if a
> MSG_PEEK of more than one byte occurs, it may move on to the next =
packet,
> replacing the content of the buffer.  In such a case, it has to go =
back and
> re-decrypt the current packet.
>=20
> Note that rx_pkt_offset may legitimately see 0 as a valid offset now, =
so
> switch to using USHRT_MAX to indicate an invalid offset.
>=20
> Note also that I would generally prefer to replace the buffers of the
> current sk_buff with a new kmalloc'd buffer of the right size, =
ditching the
> old data and frags as this makes the handling of MSG_PEEK easier and
> removes the double-decryption issue, but this looks like quite a
> complicated thing to achieve.  skb_morph() looks half way to what I =
want,
> but I don't want to have to allocate a new sk_buff.

It might be useful to add a back-porting note indication that the rxgk
changes can be safely dropped if the kernel version does not contain
rxgk support.

>=20
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than =
skb_cow_data()")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Closes: https://lore.kernel.org/r/afKV2zGR6rrelPC7@v4bel/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> cc: netdev@vger.kernel.org
> cc: linux-afs@lists.infradead.org
> cc: stable@vger.kernel.org
> ---
> net/rxrpc/ar-internal.h |  7 +++-
> net/rxrpc/call_event.c  | 22 +----------
> net/rxrpc/call_object.c |  2 +
> net/rxrpc/insecure.c    |  3 --
> net/rxrpc/recvmsg.c     | 72 +++++++++++++++++++++++++++-------
> net/rxrpc/rxgk.c        | 49 +++++++++++------------
> net/rxrpc/rxgk_common.h | 79 +++++++++++++++++++++++++++++++++++++
> net/rxrpc/rxkad.c       | 86 +++++++++++++++--------------------------
> 8 files changed, 200 insertions(+), 120 deletions(-)
>=20
> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index 27c2aa2dd023..783367eea798 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -213,8 +213,6 @@ struct rxrpc_skb_priv {
> struct {
> u16 offset; /* Offset of data */
> u16 len; /* Length of data */
> - u8 flags;
> -#define RXRPC_RX_VERIFIED 0x01
> };
> struct {
> rxrpc_seq_t first_ack; /* First packet in acks table */
> @@ -774,6 +772,11 @@ struct rxrpc_call {
> struct sk_buff_head recvmsg_queue; /* Queue of packets ready for =
recvmsg() */
> struct sk_buff_head rx_queue; /* Queue of packets for this call to =
receive */
> struct sk_buff_head rx_oos_queue; /* Queue of out of sequence packets =
*/
> + void *rx_dec_buffer; /* Decryption buffer */
> + unsigned short rx_dec_bsize; /* rx_dec_buffer size */
> + unsigned short rx_dec_offset; /* Decrypted packet data offset */
> + unsigned short rx_dec_len; /* Decrypted packet data len */
> + rxrpc_seq_t rx_dec_seq; /* Packet in decryption buffer */
>=20
> rxrpc_seq_t rx_highest_seq; /* Higest sequence number received */
> rxrpc_seq_t rx_consumed; /* Highest packet consumed */


Instead of allocating the storage within struct rxrpc_call perhaps
It would be better to add them to struct rxrpc_channel.  Doing so=20
would reduce the allocation/deallocation churn.  The majority of
calls are short lived (perhaps a single packet in each direction)
but there will be many calls in rapid succession.

> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index 2b19b252225e..fec59d9338b9 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -332,27 +332,7 @@ bool rxrpc_input_call_event(struct rxrpc_call =
*call)
>=20
> saw_ack |=3D sp->hdr.type =3D=3D RXRPC_PACKET_TYPE_ACK;
>=20
> - if (sp->hdr.type =3D=3D RXRPC_PACKET_TYPE_DATA &&
> -    sp->hdr.securityIndex !=3D 0 &&
> -    (skb_cloned(skb) ||
> -     skb_has_frag_list(skb) ||
> -     skb_has_shared_frag(skb))) {
> - /* Unshare the packet so that it can be
> - * modified by in-place decryption.
> - */
> - struct sk_buff *nskb =3D skb_copy(skb, GFP_ATOMIC);
> -
> - if (nskb) {
> - rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
> - rxrpc_input_call_packet(call, nskb);
> - rxrpc_free_skb(nskb, rxrpc_skb_put_call_rx);
> - } else {
> - /* OOM - Drop the packet. */
> - rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
> - }
> - } else {
> - rxrpc_input_call_packet(call, skb);
> - }
> + rxrpc_input_call_packet(call, skb);
> rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
> did_receive =3D true;
> }

> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
> index f035f486c139..fcb9d38bb521 100644
> --- a/net/rxrpc/call_object.c
> +++ b/net/rxrpc/call_object.c
> @@ -152,6 +152,7 @@ struct rxrpc_call *rxrpc_alloc_call(struct =
rxrpc_sock *rx, gfp_t gfp,
> spin_lock_init(&call->notify_lock);
> refcount_set(&call->ref, 1);
> call->debug_id =3D debug_id;
> + call->rx_pkt_offset =3D USHRT_MAX;
> call->tx_total_len =3D -1;
> call->tx_jumbo_max =3D 1;
> call->next_rx_timo =3D 20 * HZ;
> @@ -553,6 +554,7 @@ static void rxrpc_cleanup_rx_buffers(struct =
rxrpc_call *call)
> rxrpc_purge_queue(&call->recvmsg_queue);
> rxrpc_purge_queue(&call->rx_queue);
> rxrpc_purge_queue(&call->rx_oos_queue);
> + kfree(call->rx_dec_buffer);
> }
>=20
> /*
> diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
> index 0a260df45d25..7a26c6097d03 100644
> --- a/net/rxrpc/insecure.c
> +++ b/net/rxrpc/insecure.c
> @@ -32,9 +32,6 @@ static int none_secure_packet(struct rxrpc_call =
*call, struct rxrpc_txbuf *txb)
>=20
> static int none_verify_packet(struct rxrpc_call *call, struct sk_buff =
*skb)
> {
> - struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> -
> - sp->flags |=3D RXRPC_RX_VERIFIED;
> return 0;
> }
>=20
> diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
> index e1f7513a46db..865e368381d5 100644
> --- a/net/rxrpc/recvmsg.c
> +++ b/net/rxrpc/recvmsg.c
> @@ -147,15 +147,55 @@ static void rxrpc_rotate_rx_window(struct =
rxrpc_call *call)
> }
>=20
> /*
> - * Decrypt and verify a DATA packet.
> + * Decrypt and verify a DATA packet.  The content of the packet is =
pulled out
> + * into a flat buffer rather than decrypting in place in the skbuff.  =
This also
> + * has the advantage of aligning the buffer correctly for the crypto =
routines.
> + *
> + * We keep track of the sequence number of the packet currently =
decrypted into
> + * the buffer in ->rx_dec_seq.  Unfortunately, this means that a =
MSG_PEEK of
> + * more than one byte may cause a later packet to be decrypted into =
the buffer,
> + * requiring the original to be re-decrypted when recvmsg() is called =
again.
>  */
> static int rxrpc_verify_data(struct rxrpc_call *call, struct sk_buff =
*skb)
> {
> struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> + int ret;
>=20
> - if (sp->flags & RXRPC_RX_VERIFIED)
> + if (call->rx_dec_seq =3D=3D sp->hdr.seq && call->rx_dec_buffer)
> return 0;
> - return call->security->verify_packet(call, skb);
> +
> + if (call->rx_dec_bsize < sp->len) {
> + /* Make sure we can hold a 1412-byte jumbo subpacket and make
> + * sure that the buffer size is aligned to a crypto blocksize.
> + */
> + size_t size =3D umin(round_up(sp->len, 32), 2048);

I think you meant to use max() here so that a minimum of 2048 bytes
is allocated. =20

I think applying a cap on the allocation size would also be=20
beneficial.  IBM/Transarc derived Rx implementations have a hard
upper-bound of 21180 (15 x 1412) bytes plus one 28 byte rx header.
Applying a cap of 32KiB seems prudent.

It is also worth noting that there are no current implementations
of Rx RPC which will send individual Rx DATA packets larger than=20
1444 bytes including the Rx header.  Rx RESPONSE packets can be sent
as large as 16384 bytes (including the Rx header).  However, it is
extremely unlikely that this buffer once allocated would ever need=20
to be grown. =20

> + void *buffer =3D krealloc(call->rx_dec_buffer, size, GFP_NOFS);
> +
> + if (!buffer)
> + return -ENOMEM;
> + call->rx_dec_buffer =3D buffer;
> + call->rx_dec_bsize =3D size;
> + }
> +
> + ret =3D -EFAULT;
> + if (skb_copy_bits(skb, sp->offset, call->rx_dec_buffer, sp->len) < =
0)
> + goto err;
> +
> + call->rx_dec_offset =3D 0;
> + call->rx_dec_len =3D sp->len;
> + call->rx_dec_seq =3D sp->hdr.seq;
> + ret =3D call->security->verify_packet(call, skb);
> + if (ret < 0)
> + goto err;
> + return 0;
> +
> +err:
> + kfree(call->rx_dec_buffer);

It might be better to avoid deallocating the buffer on the error
path and permit it to be freed during normal call (or call channel)
deallocation.

> + call->rx_dec_buffer =3D NULL;
> + call->rx_dec_bsize =3D 0;
> + call->rx_dec_offset =3D 0;
> + call->rx_dec_len =3D 0;
> + return ret;
> }
>=20
> /*
> @@ -283,16 +323,19 @@ static int rxrpc_recvmsg_data(struct socket =
*sock, struct rxrpc_call *call,
> if (msg)
> sock_recv_timestamp(msg, sock->sk, skb);
>=20
> - if (rx_pkt_offset =3D=3D 0) {
> + if (rx_pkt_offset =3D=3D USHRT_MAX) {
> ret2 =3D rxrpc_verify_data(call, skb);
> trace_rxrpc_recvdata(call, rxrpc_recvmsg_next, seq,
> -     sp->offset, sp->len, ret2);
> +     call->rx_dec_offset,
> +     call->rx_dec_len, ret2);
> if (ret2 < 0) {
> ret =3D ret2;
> goto out;
> }
> - rx_pkt_offset =3D sp->offset;
> - rx_pkt_len =3D sp->len;
> + sp =3D rxrpc_skb(skb);
> + seq =3D sp->hdr.seq;
> + rx_pkt_offset =3D call->rx_dec_offset;
> + rx_pkt_len =3D call->rx_dec_len;
> } else {
> trace_rxrpc_recvdata(call, rxrpc_recvmsg_cont, seq,
>     rx_pkt_offset, rx_pkt_len, 0);
> @@ -304,10 +347,10 @@ static int rxrpc_recvmsg_data(struct socket =
*sock, struct rxrpc_call *call,
> if (copy > remain)
> copy =3D remain;
> if (copy > 0) {
> - ret2 =3D skb_copy_datagram_iter(skb, rx_pkt_offset, iter,
> -      copy);
> - if (ret2 < 0) {
> - ret =3D ret2;
> + ret2 =3D copy_to_iter(call->rx_dec_buffer + rx_pkt_offset,
> +    copy, iter);
> + if (ret2 !=3D copy) {
> + ret =3D -EFAULT;
> goto out;
> }
>=20
> @@ -328,13 +371,14 @@ static int rxrpc_recvmsg_data(struct socket =
*sock, struct rxrpc_call *call,
> /* The whole packet has been transferred. */
> if (sp->hdr.flags & RXRPC_LAST_PACKET)
> ret =3D 1;
> - rx_pkt_offset =3D 0;
> + rx_pkt_offset =3D USHRT_MAX;
> rx_pkt_len =3D 0;
> + if (unlikely(flags & MSG_PEEK))
> + break;
>=20
> skb =3D skb_peek_next(skb, &call->recvmsg_queue);
>=20
> - if (!(flags & MSG_PEEK))
> - rxrpc_rotate_rx_window(call);
> + rxrpc_rotate_rx_window(call);
>=20
> if (!rx->app_ops &&
>    !skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
> diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
> index 0d5e654da918..88e651dd0e90 100644
> --- a/net/rxrpc/rxgk.c
> +++ b/net/rxrpc/rxgk.c
> @@ -473,8 +473,9 @@ static int rxgk_verify_packet_integrity(struct =
rxrpc_call *call,
> struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> struct rxgk_header *hdr;
> struct krb5_buffer metadata;
> - unsigned int offset =3D sp->offset, len =3D sp->len;
> + unsigned int offset =3D 0, len =3D call->rx_dec_len;
> size_t data_offset =3D 0, data_len =3D len;
> + void *data =3D call->rx_dec_buffer;
> u32 ac =3D 0;
> int ret =3D -ENOMEM;
>=20
> @@ -496,16 +497,16 @@ static int rxgk_verify_packet_integrity(struct =
rxrpc_call *call,
>=20
> metadata.len =3D sizeof(*hdr);
> metadata.data =3D hdr;
> - ret =3D rxgk_verify_mic_skb(gk->krb5, gk->rx_Kc, &metadata,
> -  skb, &offset, &len, &ac);
> + ret =3D rxgk_verify_mic(gk->krb5, gk->rx_Kc, &metadata,
> +      data, &offset, &len, &ac);
> kfree(hdr);
> if (ret < 0) {
> if (ret !=3D -ENOMEM)
> rxrpc_abort_eproto(call, skb, ac,
>   rxgk_abort_1_verify_mic_eproto);
> } else {
> - sp->offset =3D offset;
> - sp->len =3D len;
> + call->rx_dec_offset =3D offset;
> + call->rx_dec_len =3D len;
> }
>=20
> put_gk:
> @@ -522,49 +523,45 @@ static int rxgk_verify_packet_encrypted(struct =
rxrpc_call *call,
> struct sk_buff *skb)
> {
> struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> - struct rxgk_header hdr;
> - unsigned int offset =3D sp->offset, len =3D sp->len;
> + struct rxgk_header *hdr;
> + unsigned int offset =3D 0, len =3D call->rx_dec_len;
> + void *data =3D call->rx_dec_buffer;
> int ret;
> u32 ac =3D 0;
>=20
> _enter("");
>=20
> - ret =3D rxgk_decrypt_skb(gk->krb5, gk->rx_enc, skb, &offset, &len, =
&ac);
> + ret =3D rxgk_decrypt(gk->krb5, gk->rx_enc, data, &offset, &len, =
&ac);
> if (ret < 0) {
> if (ret !=3D -ENOMEM)
> rxrpc_abort_eproto(call, skb, ac, rxgk_abort_2_decrypt_eproto);
> goto error;
> }
>=20
> - if (len < sizeof(hdr)) {
> + if (len < sizeof(*hdr)) {
> ret =3D rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
> rxgk_abort_2_short_header);
> goto error;
> }
>=20
> /* Extract the header from the skb */
> - ret =3D skb_copy_bits(skb, offset, &hdr, sizeof(hdr));
> - if (ret < 0) {
> - ret =3D rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
> - rxgk_abort_2_short_encdata);
> - goto error;
> - }
> - offset +=3D sizeof(hdr);
> - len -=3D sizeof(hdr);
> -
> - if (ntohl(hdr.epoch) !=3D call->conn->proto.epoch ||
> -    ntohl(hdr.cid) !=3D call->cid ||
> -    ntohl(hdr.call_number) !=3D call->call_id ||
> -    ntohl(hdr.seq) !=3D sp->hdr.seq ||
> -    ntohl(hdr.sec_index) !=3D call->security_ix ||
> -    ntohl(hdr.data_len) > len) {
> + hdr =3D data + offset;
> + offset +=3D sizeof(*hdr);
> + len -=3D sizeof(*hdr);
> +
> + if (ntohl(hdr->epoch) !=3D call->conn->proto.epoch ||
> +    ntohl(hdr->cid) !=3D call->cid ||
> +    ntohl(hdr->call_number) !=3D call->call_id ||
> +    ntohl(hdr->seq) !=3D sp->hdr.seq ||
> +    ntohl(hdr->sec_index) !=3D call->security_ix ||
> +    ntohl(hdr->data_len) > len) {
> ret =3D rxrpc_abort_eproto(call, skb, RXGK_SEALEDINCON,
> rxgk_abort_2_short_data);
> goto error;
> }
>=20
> - sp->offset =3D offset;
> - sp->len =3D ntohl(hdr.data_len);
> + call->rx_dec_offset =3D offset;
> + call->rx_dec_len =3D ntohl(hdr->data_len);
> ret =3D 0;
> error:
> rxgk_put(gk);
> diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
> index 1e257d7ab8ec..dc8b0f106104 100644
> --- a/net/rxrpc/rxgk_common.h
> +++ b/net/rxrpc/rxgk_common.h
> @@ -105,6 +105,45 @@ int rxgk_decrypt_skb(const struct krb5_enctype =
*krb5,
> return ret;
> }
>=20
> +/*
> + * Apply decryption and checksumming functions a flat data buffer.  =
The offset
> + * and length are updated to reflect the actual content of the =
encrypted
> + * region.
> + */
> +static inline int rxgk_decrypt(const struct krb5_enctype *krb5,
> +       struct crypto_aead *aead,
> +       void *data,
> +       unsigned int *_offset, unsigned int *_len,
> +       int *_error_code)
> +{
> + struct scatterlist sg[1];
> + size_t offset =3D 0, len =3D *_len;
> + int ret;
> +
> + sg_init_one(sg, data, len);
> +
> + ret =3D crypto_krb5_decrypt(krb5, aead, sg, 1, &offset, &len);
> + switch (ret) {
> + case 0:
> + *_offset +=3D offset;
> + *_len =3D len;
> + break;
> + case -EBADMSG: /* Checksum mismatch. */
> + case -EPROTO:
> + *_error_code =3D RXGK_SEALEDINCON;
> + break;
> + case -EMSGSIZE:
> + *_error_code =3D RXGK_PACKETSHORT;
> + break;
> + case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for =
YFS. */
> + default:
> + *_error_code =3D RXGK_INCONSISTENCY;
> + break;
> + }
> +
> + return ret;
> +}
> +
> /*
>  * Check the MIC on a region of an skbuff.  The offset and length are =
updated
>  * to reflect the actual content of the secure region.
> @@ -148,3 +187,43 @@ int rxgk_verify_mic_skb(const struct krb5_enctype =
*krb5,
>=20
> return ret;
> }
> +
> +/*
> + * Check the MIC on a flat buffer.  The offset and length are updated =
to
> + * reflect the actual content of the secure region.
> + */
> +static inline
> +int rxgk_verify_mic(const struct krb5_enctype *krb5,
> +    struct crypto_shash *shash,
> +    const struct krb5_buffer *metadata,
> +    void *data,
> +    unsigned int *_offset, unsigned int *_len,
> +    u32 *_error_code)
> +{
> + struct scatterlist sg[1];
> + size_t offset =3D 0, len =3D *_len;
> + int ret;
> +
> + sg_init_one(sg, data, len);
> +
> + ret =3D crypto_krb5_verify_mic(krb5, shash, metadata, sg, 1, =
&offset, &len);
> + switch (ret) {
> + case 0:
> + *_offset +=3D offset;
> + *_len =3D len;
> + break;
> + case -EBADMSG: /* Checksum mismatch */
> + case -EPROTO:
> + *_error_code =3D RXGK_SEALEDINCON;
> + break;
> + case -EMSGSIZE:
> + *_error_code =3D RXGK_PACKETSHORT;
> + break;
> + case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for =
YFS. */
> + default:
> + *_error_code =3D RXGK_INCONSISTENCY;
> + break;
> + }
> +
> + return ret;
> +}
> diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
> index cba7935977f0..075936337836 100644
> --- a/net/rxrpc/rxkad.c
> +++ b/net/rxrpc/rxkad.c
> @@ -430,27 +430,25 @@ static int rxkad_verify_packet_1(struct =
rxrpc_call *call, struct sk_buff *skb,
> rxrpc_seq_t seq,
> struct skcipher_request *req)
> {
> - struct rxkad_level1_hdr sechdr;
> + struct rxkad_level1_hdr *sechdr;
> struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> struct rxrpc_crypt iv;
> - struct scatterlist sg[16];
> - u32 data_size, buf;
> + struct scatterlist sg[1];
> + void *data =3D call->rx_dec_buffer;
> + u32 len =3D sp->len, data_size, buf;
> u16 check;
> int ret;
>=20
> _enter("");
>=20
> - if (sp->len < 8)
> + if (len < 8)
> return rxrpc_abort_eproto(call, skb, RXKADSEALEDINCON,
>  rxkad_abort_1_short_header);
>=20
> /* Decrypt the skbuff in-place.  TODO: We really want to decrypt
> * directly into the target buffer.
> */
> - sg_init_table(sg, ARRAY_SIZE(sg));
> - ret =3D skb_to_sgvec(skb, sg, sp->offset, 8);
> - if (unlikely(ret < 0))
> - return ret;
> + sg_init_one(sg, data, len);
>=20
> /* start the decryption afresh */
> memset(&iv, 0, sizeof(iv));
> @@ -464,13 +462,11 @@ static int rxkad_verify_packet_1(struct =
rxrpc_call *call, struct sk_buff *skb,
> return ret;
>=20
> /* Extract the decrypted packet length */
> - if (skb_copy_bits(skb, sp->offset, &sechdr, sizeof(sechdr)) < 0)
> - return rxrpc_abort_eproto(call, skb, RXKADDATALEN,
> -  rxkad_abort_1_short_encdata);
> - sp->offset +=3D sizeof(sechdr);
> - sp->len    -=3D sizeof(sechdr);
> + sechdr =3D data;
> + call->rx_dec_offset =3D sizeof(*sechdr);
> + len -=3D sizeof(*sechdr);
>=20
> - buf =3D ntohl(sechdr.data_size);
> + buf =3D ntohl(sechdr->data_size);
> data_size =3D buf & 0xffff;
>=20
> check =3D buf >> 16;
> @@ -479,10 +475,10 @@ static int rxkad_verify_packet_1(struct =
rxrpc_call *call, struct sk_buff *skb,
> if (check !=3D 0)
> return rxrpc_abort_eproto(call, skb, RXKADSEALEDINCON,
>  rxkad_abort_1_short_check);
> - if (data_size > sp->len)
> + if (data_size > len)
> return rxrpc_abort_eproto(call, skb, RXKADDATALEN,
>  rxkad_abort_1_short_data);
> - sp->len =3D data_size;
> + call->rx_dec_len =3D data_size;
>=20
> _leave(" =3D 0 [dlen=3D%x]", data_size);
> return 0;
> @@ -496,43 +492,28 @@ static int rxkad_verify_packet_2(struct =
rxrpc_call *call, struct sk_buff *skb,
> struct skcipher_request *req)
> {
> const struct rxrpc_key_token *token;
> - struct rxkad_level2_hdr sechdr;
> + struct rxkad_level2_hdr *sechdr;
> struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> struct rxrpc_crypt iv;
> - struct scatterlist _sg[4], *sg;
> - u32 data_size, buf;
> + struct scatterlist sg[1];
> + void *data =3D call->rx_dec_buffer;
> + u32 len =3D sp->len, data_size, buf;
> u16 check;
> - int nsg, ret;
> + int ret;
>=20
> - _enter(",{%d}", sp->len);
> + _enter(",{%d}", len);
>=20
> - if (sp->len < 8)
> + if (len < 8)
> return rxrpc_abort_eproto(call, skb, RXKADSEALEDINCON,
>  rxkad_abort_2_short_header);
>=20
> /* Don't let the crypto algo see a misaligned length. */
> - sp->len =3D round_down(sp->len, 8);
> + len =3D round_down(len, 8);
>=20
> - /* Decrypt the skbuff in-place.  TODO: We really want to decrypt
> - * directly into the target buffer.
> + /* Decrypt in place in the call's decryption buffer.  TODO: We =
really
> + * want to decrypt directly into the target buffer.
> */
> - sg =3D _sg;
> - nsg =3D skb_shinfo(skb)->nr_frags + 1;
> - if (nsg <=3D 4) {
> - nsg =3D 4;
> - } else {
> - sg =3D kmalloc_objs(*sg, nsg, GFP_NOIO);
> - if (!sg)
> - return -ENOMEM;
> - }
> -
> - sg_init_table(sg, nsg);
> - ret =3D skb_to_sgvec(skb, sg, sp->offset, sp->len);
> - if (unlikely(ret < 0)) {
> - if (sg !=3D _sg)
> - kfree(sg);
> - return ret;
> - }
> + sg_init_one(sg, data, len);
>=20
> /* decrypt from the session key */
> token =3D call->conn->key->payload.data[0];
> @@ -540,11 +521,9 @@ static int rxkad_verify_packet_2(struct =
rxrpc_call *call, struct sk_buff *skb,
>=20
> skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
> skcipher_request_set_callback(req, 0, NULL, NULL);
> - skcipher_request_set_crypt(req, sg, sg, sp->len, iv.x);
> + skcipher_request_set_crypt(req, sg, sg, len, iv.x);
> ret =3D crypto_skcipher_decrypt(req);
> skcipher_request_zero(req);
> - if (sg !=3D _sg)
> - kfree(sg);
> if (ret < 0) {
> if (ret =3D=3D -ENOMEM)
> return ret;
> @@ -553,13 +532,11 @@ static int rxkad_verify_packet_2(struct =
rxrpc_call *call, struct sk_buff *skb,
> }
>=20
> /* Extract the decrypted packet length */
> - if (skb_copy_bits(skb, sp->offset, &sechdr, sizeof(sechdr)) < 0)
> - return rxrpc_abort_eproto(call, skb, RXKADDATALEN,
> -  rxkad_abort_2_short_len);
> - sp->offset +=3D sizeof(sechdr);
> - sp->len    -=3D sizeof(sechdr);
> + sechdr =3D data;
> + call->rx_dec_offset =3D sizeof(*sechdr);
> + len -=3D sizeof(*sechdr);
>=20
> - buf =3D ntohl(sechdr.data_size);
> + buf =3D ntohl(sechdr->data_size);
> data_size =3D buf & 0xffff;
>=20
> check =3D buf >> 16;
> @@ -569,17 +546,18 @@ static int rxkad_verify_packet_2(struct =
rxrpc_call *call, struct sk_buff *skb,
> return rxrpc_abort_eproto(call, skb, RXKADSEALEDINCON,
>  rxkad_abort_2_short_check);
>=20
> - if (data_size > sp->len)
> + if (data_size > len)
> return rxrpc_abort_eproto(call, skb, RXKADDATALEN,
>  rxkad_abort_2_short_data);
>=20
> - sp->len =3D data_size;
> + call->rx_dec_len =3D data_size;
> _leave(" =3D 0 [dlen=3D%x]", data_size);
> return 0;
> }
>=20
> /*
> - * Verify the security on a received packet and the subpackets =
therein.
> + * Verify the security on a received (sub)packet.  If the packet =
needs
> + * modifying (e.g. decrypting), it must be copied.
>  */
> static int rxkad_verify_packet(struct rxrpc_call *call, struct sk_buff =
*skb)
> {
>=20

With the exception of the provided feedback this change looks good.

Thank you.

Jeffrey Altman



--Apple-Mail=_4B604AF3-E2C0-4551-975F-87EE074AB152
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
AgEFAKCCASkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNTEy
MDc1ODIyWjAvBgkqhkiG9w0BCQQxIgQg9P0ykBKOcEA8GGcTE8lnEzf6baJKgbJLMOiFZr5JnHow
XQYJKwYBBAGCNxAEMVAwTjA6MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRlblRydXN0MRcwFQYD
VQQDEw5UcnVzdElEIENBIEExNAIQQAGYpgQCdfbeJujk4J9zsTBfBgsqhkiG9w0BCRACCzFQoE4w
OjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBB
MTQCEEABmKYEAnX23ibo5OCfc7EwDQYJKoZIhvcNAQELBQAEggEAD/anPRefqQ7A57PLhYxF9h+4
/efKp1wtn2hEdV5V2qHzaBFWrCaKYTrbLFI2Vm+0XD8kcON1e4zj4VSdWAYpFfKPBD5plUUxuXhN
k2imzCUhG2Y3aDJVgoc1udEf6iSAIAlSvY8Nv5w1mACKl5g2jFDovvDAB6EUmYtaMsB69y9TjDze
Q5k6gl9xeFuuD/AKmvtNthf1QX2GeVCvDzFSrwRRubkrtF1z2qYHIb9ChBbWYcRvVRCmidCUWHz8
yDoNv+5gmdqkrPykEGfR6ZXGzrVTj8FyArH+mpehli1b9qhR01WteivXwe2rI6llXCfgMk2FniZc
RYMdjdxQawZcIwAAAAAAAA==
--Apple-Mail=_4B604AF3-E2C0-4551-975F-87EE074AB152--


