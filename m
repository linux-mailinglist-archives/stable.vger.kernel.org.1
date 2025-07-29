Return-Path: <stable+bounces-165116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC7B152B8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 20:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3003A545E3C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E823A9AD;
	Tue, 29 Jul 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRcDOqHW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF122DA0C
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813541; cv=none; b=PugKL9XTynSReP2Psq8ZNzCQwfu+nP/RzW9eLOBL0qc8kow/Up5u4FC8iP4nYFt4gvK0Ouopi1YEDUR3n4P0UolLhCJoXTL4+yeb8A6bFzhhCohKLV+oYKFLUZaMTR+nr7iXgo+tiME0rjjCbTsfnCT8ecSqnCj2Txaba5ygFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813541; c=relaxed/simple;
	bh=pU5m8XauPeIGonyrz8iQaU14w2wIaXbVmp8i5Z32iRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8Po6EPmicqXuZZ1MfAtex9lQrLQpj17rlXIElqRM+jFAhxyKLaCC/gX5ZUsJfxvsfPcA6eKN9NmVhrEih5Trp6MoA/S+4PYbQ9gnR1EoBJ9abquXO1I7IhF4zwNje7AU1xqVAJ4/EiGVQw/mZBCrTTQyrEmki0aJ/iNSRGj/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRcDOqHW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753813538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVnLO+95W3S+CT+o6yfww28RP2GVImIeXQyYVL/+F8U=;
	b=QRcDOqHWAc2Aus2T6GK36ruvOrZYHSjjfV/6owjjHYIvx1jJ7P9csjc6OCoY+LLe0KwLfo
	cRrmVu+MAK4LhVnCd7uZtiRNYUuEDyUCJHl4twA4B3eod1cLQpxmTFLsL8oUdKDdNUP/l5
	R0TuuEW+Kl8Dvw48nz7JuyPn3DPiyUs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-RnlzTvDoPgus7yBBMZpmzw-1; Tue, 29 Jul 2025 14:25:37 -0400
X-MC-Unique: RnlzTvDoPgus7yBBMZpmzw-1
X-Mimecast-MFC-AGG-ID: RnlzTvDoPgus7yBBMZpmzw_1753813536
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad56a52edc5so585555066b.0
        for <Stable@vger.kernel.org>; Tue, 29 Jul 2025 11:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813535; x=1754418335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVnLO+95W3S+CT+o6yfww28RP2GVImIeXQyYVL/+F8U=;
        b=rEXeL98fqMWjpOv/jpc7CCE62gi73XlhSsB7y/3AFfvLJmiu0jqMFE6/j5+3sWn2H4
         48JJF8zg3u1i/1RrLFcsmprjMqcEhFlu9ngoJ16VMEblw99h8jeadLDYgFcyegGa74U4
         VseOAD858+oh2KBlrzJVr1ApXqDbLZnHpFdahGxghbLEMCs9HcBAknYrR6uEPDpuV77U
         dsez7+A8IslRclFDrzxvBxp/3V/RwqndeBKcNVWYWBOPGik+SMEBeKHkrd4zw7d/aYhX
         IYZSv+ENowzTLZZBpZNGgPkOiLbBbL/EBrlL5gTwbrMENIWUuzz2IXKsL4c5/noJnp2a
         EiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs3hAjBaAnPnOhm06GVmJZAfNJ4ZTlSRPX1TxhROduBHgREwx4VEtkgiIVNFMWPYF3c0YWIMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUkCRdSos7qs0ypiaf+6QHWUCj5WgYXbXXbIg3uZm1YcbyiGf
	ldQRwlt3W09cP7NsXufZ1iecUP1o2wToEGMRKQk59hb/0+uoPgBwgqh3OHB2EhKZdY2bymXYuNk
	sQh37Y1ZP43cv9QvJcZ/ZA78NeKpRaUBBkR50+S0Txp3FnzFFlBOiWB5xWj48jrdQ7DDyquAisw
	PjbxPKyaCYGLAQ0iQnSHp6sIHYlLZ+VEem
X-Gm-Gg: ASbGnctS18ID5UZD9+MG/tKdnWC3u7xcnnyd/2gB6mnp1opxEz4iyHOe4sctUYvjGLC
	4cLGrt6ZbJXW8KxOHEw3piGPfuNOiNsYXwl2rAcaRM4CCTGJhyi3AV59eZkniRm6t3dSbo+ah+b
	6zMO//H4odjffngUsOzFLSZEDmAHx7I3cthz6Dg3FaXMdo3pNBqhLqlD0=
X-Received: by 2002:a17:907:9609:b0:af6:34ee:8a79 with SMTP id a640c23a62f3a-af8fd985cb9mr48576466b.36.1753813535120;
        Tue, 29 Jul 2025 11:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0IpKwPHxR5Qx8sDGPYdWiu7+OfJGZXr7ud1dwiny9ylnwwgsb0wmZP9KesBh/HUf6/R2KzYOoARLvyiONHvE=
X-Received: by 2002:a17:907:9609:b0:af6:34ee:8a79 with SMTP id
 a640c23a62f3a-af8fd985cb9mr48573766b.36.1753813534571; Tue, 29 Jul 2025
 11:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729164023.46643-1-okorniev@redhat.com> <20250729164023.46643-4-okorniev@redhat.com>
 <c2d3a4b6-6b1c-4f9c-982b-4adbc558e1b7@suse.de>
In-Reply-To: <c2d3a4b6-6b1c-4f9c-982b-4adbc558e1b7@suse.de>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Tue, 29 Jul 2025 14:25:23 -0400
X-Gm-Features: Ac12FXwoML0n_k_5zpU8i0AiiBBwhbNVYSOP0TLubeIRRgUGAnKVVH2acYulv9o
Message-ID: <CACSpFtDo+Bo0Dre-c9yxf7OEJNUUDesk-Lf+6sCdmMBQH=_JvQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] nvme: fix handling of tls alerts
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@hammerspace.com, 
	anna.schumaker@oracle.com, Stable@vger.kernel.org, 
	Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@stable@vger.kernel.org  I apologize that git send-mail went to stable
email. Please ignore this email as this is an internal discussion for
now. But will be public soon.

On Tue, Jul 29, 2025 at 1:47=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 7/29/25 18:40, Olga Kornievskaia wrote:
> > Revert kvec msg iterator before trying to process a TLS alert
> > when possible.
> >
> > In nvmet_tcp_try_recv_data(), it's assumed that no msg control
> > message buffer is set prior to sock_recvmsg(). If no control
> > message structure is setup, kTLS layer will read and process
> > TLS data record types. As soon as it encounters a TLS control
> > message, it would return an error. At that point, we setup a kvec
> > backed control buffer and read in the control message such as
> > a TLS alert. Msg can advance the kvec pointer as a part of the
> > copy process thus we need to revert the iterator before calling
> > into the tls_alert_recv.
> >
> > Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >   drivers/nvme/target/tcp.c | 48 +++++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 38 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 688033b88d38..cf3336ddc9a3 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tc=
p_queue *queue)
> >       if (unlikely(len < 0))
> >               return len;
> >       if (queue->tls_pskid) {
> > +             iov_iter_revert(&msg.msg_iter, len);
> >               ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >               if (ret < 0)
> >                       return ret;
> > @@ -1218,18 +1219,47 @@ static int nvmet_tcp_try_recv_data(struct nvmet=
_tcp_queue *queue)
> >   {
> >       struct nvmet_tcp_cmd  *cmd =3D queue->cmd;
> >       int len, ret;
> > +     union {
> > +             struct cmsghdr cmsg;
> > +             u8 buf[CMSG_SPACE(sizeof(u8))];
> > +     } u;
> > +     u8 alert[2];
> > +     struct kvec alert_kvec =3D {
> > +             .iov_base =3D alert,
> > +             .iov_len =3D sizeof(alert),
> > +     };
> > +     struct msghdr msg =3D {
> > +             .msg_control =3D &u,
> > +             .msg_controllen =3D sizeof(u),
> > +     };
> >
> >       while (msg_data_left(&cmd->recv_msg)) {
> > +             /* assumed that cmg->recv_msg's control buffer is not set=
up
> > +              */
> > +             WARN_ON_ONCE(cmd->recv_msg.msg_controllen > 0);
> > +
> >               len =3D sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
> >                       cmd->recv_msg.msg_flags);
> > +             if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
>
> Hmm. Looks as if we were getting MSG_CTRUNC even if no buffer is passed.
> OK.

Correct. When no control buffer is supplied, put_cmsg() would always
set MSG_CTRUNC. What's important is that in combination with -EIO
return that signals it's a TLS control message. Just looking at CTRUNC
message would get us into trouble.

>
> > +                     cmd->recv_msg.msg_flags &=3D ~(MSG_CTRUNC | MSG_E=
OF);
>
> Not sure with this. We had _terrible_ issues with MSG_EOF not set
> correctly (basically the TLS layer would wait for more data to be
> received before the record is shipped out, causing massive delays
> and connection resets).
> Any reason for clearing MSG_EOF here?

Oh my, thank you for catching this. It should have been EOR and not
EOF.  As to why clearing MSG_EOR was based on a comment in NFS code
that TLS always sets EOF for every data record (and looking at the TLS
tls_sw_recvmsg).


>
> > +                     if (len =3D=3D 0 || len =3D=3D -EIO) {
> > +                             iov_iter_kvec(&msg.msg_iter, ITER_DEST, &=
alert_kvec,
> > +                                           1, alert_kvec.iov_len);
> > +                             len =3D sock_recvmsg(cmd->queue->sock, &m=
sg,
> > +                                                MSG_DONTWAIT);
> > +                             if (len > 0 &&
> > +                                 tls_get_record_type(cmd->queue->sock-=
>sk,
> > +                                         &u.cmsg) =3D=3D TLS_RECORD_TY=
PE_ALERT) {
> > +                                     iov_iter_revert(&msg.msg_iter, le=
n);
> > +                                     ret =3D nvmet_tcp_tls_record_ok(c=
md->queue,
> > +                                                     &msg, u.buf);
> Can't we just skip this part (ie _not_ receiving / reading the control
> message contents? It's not that we're not doing anything useful here;
> for any TLS Alert we'll be resetting the connection.

Yes we certainly can do something like what you had previously
if (len =3D=3D 0 || len =3D=3D -EIO) {
  pr_err("queue %d: unhandled control message\n", queue->idx);
  return -EAGAIN;
}

But not that in that case TLS alert bytes would still be unconsumed
staying in the socket. If what follows is a prompt closing of the
connection, then who cares. What has been worrying me (even in the
NFS) code is what happens when TLS alert (though we do consume it)
isn't followed by the connection closing.

Now let me know if you want me to re-do this patch based on what you
suggested and ignore when len=3D-EIO. And then I can redo the patch#4
based on that.

>
> > +                                     if (ret < 0)
> > +                                             return ret;
> > +                             }
> > +                     }
> > +             }
> >               if (len <=3D 0)
> >                       return len;
> > -             if (queue->tls_pskid) {
> > -                     ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
> > -                                     &cmd->recv_msg, cmd->recv_cbuf);
> > -                     if (ret < 0)
> > -                             return ret;
> > -             }
> >
> >               cmd->pdu_recv +=3D len;
> >               cmd->rbytes_done +=3D len;
> > @@ -1267,6 +1297,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_=
tcp_queue *queue)
> >       if (unlikely(len < 0))
> >               return len;
> >       if (queue->tls_pskid) {
> > +             iov_iter_revert(&msg.msg_iter, len);
> >               ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >               if (ret < 0)
> >                       return ret;
> > @@ -1453,10 +1484,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_=
queue *queue,
> >       if (!c->r2t_pdu)
> >               goto out_free_data;
> >
> > -     if (queue->state =3D=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
> > -             c->recv_msg.msg_control =3D c->recv_cbuf;
> > -             c->recv_msg.msg_controllen =3D sizeof(c->recv_cbuf);
> > -     }
> >       c->recv_msg.msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL;
> >
> >       list_add_tail(&c->entry, &queue->free_list);
> > @@ -1736,6 +1763,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tc=
p_queue *queue)
> >               return len;
> >       }
> >
> > +     iov_iter_revert(&msg.msg_iter, len);
> >       ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >       if (ret < 0)
> >               return ret;
>
> Huh? Why do we need to do that?

Why do we need an iov_iter_revert? As it's also done in the other 3 chucks.

kernel_recvmsg which ultimately calls sock_recvmsg will ultimately
call into copy_to_iter() which eventually will a function to advance a
kvec so when tls_alert_recv() tries to look into kvec inside the msg
iterator is pointing into invalid memory.

sock_recvmsg -> inet_recvmsg ->tls_sw_recvmsg ->
skb_copy_datagram_iter-> simple_copy_to_iter-> copy_to_iter
->_copy_to_iter ->iterate_and_advance ->iterate_and_advance->
->iterate_and_advance2 ->iterate_kvec

A typical usage of sock_recvmsg is to initialize the iterator's kvec
(iov_base) with some buffer but afterwards processing of that payload
is done by looking thru the pointer used in the initialization. You
don't look into the iterator's kvec.



>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


