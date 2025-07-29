Return-Path: <stable+bounces-165112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B62B15269
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4DF17D34C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE312989A5;
	Tue, 29 Jul 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKBLAuDA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F88296141
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811918; cv=none; b=nQPyta5U300qLYaTjFVSNPobwCKRVE1mZ6oJD7qEYxRY38xVPq3a64OvTJQZMxGg4ma5KN1KjPkEetMld+mU6of15cUlnAz31BXblrEHGTYF1I2Sc1Tr+HE2Pz4r+iBvNPP1jDQzwquC1tMoMauthE64S26LC+Mtu8TPHrAcuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811918; c=relaxed/simple;
	bh=t9n4WQM53aYx8Jx8zEzZhp1nbx5TbvMSLjfB9MtqNPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEWeP9W0dX39iNbk3MvWdLPLJH8mJLd4aZgXfc39tr1Z7ZonRBUKxvZeLizKQUnwnTK3Uoxzkq03WOMNT0ehiqFAj39MJQYzKs9XH6JoLXzz0fiNZJ2wUapcMa7zl4vbgppmC2OhxD7Lkp0sjY/jmfWqTU8H0s0I4lZrxkyYSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKBLAuDA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753811915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMyoDoLMpq1MTZc0EW9L7Edq/lDSWyEaGQOO1HXk7Us=;
	b=NKBLAuDA5PcVDiOZeyzX7KHafnS1o53RNTdjQTo7ybDib0MF8hKy0nxMs0wwNUOE4zioOO
	kxCmuALhfnaArv7S3vIVvT0qJUKtaBdpugx/qYF2WSLDr/0bApQVjNh1o0smdT+Gos0rFJ
	u1SuvHoiQUdEq91llB17NuEu1NIKHOI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-oYHmBkYUORyjlLUwTnYfaA-1; Tue, 29 Jul 2025 13:58:34 -0400
X-MC-Unique: oYHmBkYUORyjlLUwTnYfaA-1
X-Mimecast-MFC-AGG-ID: oYHmBkYUORyjlLUwTnYfaA_1753811913
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ade5b98537dso634856566b.2
        for <Stable@vger.kernel.org>; Tue, 29 Jul 2025 10:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753811913; x=1754416713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMyoDoLMpq1MTZc0EW9L7Edq/lDSWyEaGQOO1HXk7Us=;
        b=AlM5uy1b06k9s408Wndc5e638ezSmPzpO9UXIkeQq3h3at7PmonlGeQr1OHViBoVJL
         0tL3uUFdDlMbqIbCQ6s9OAso/cIaNZmr2rxc/Cc9+S/aLtJXfpndGFf93R47dbYCH2zK
         7M8/ae7Wo3y42CyFjOHHOmKX2Ao2Qy3boJ17sxBwPL1dO4oEOjkmsOZkaT6OHyfE8q4+
         BS+eg/zD+lGrsOIdChUEsQFI4R2F7E6PtKV6eRZwLYT2JWB089n37dh9uQPGmyUCrYL2
         XimvQcr1wqfe6kH4ViCZ67DyCc9NAmYEBfV0abEM0Y4P0R7wqFhJn1iZ3J3d88h8Yfa8
         wAaA==
X-Forwarded-Encrypted: i=1; AJvYcCUvIp/r05NNOPnpn5D6w0EUXfINxb9lqIhAD0J7aI85Iw6Ihrt3de/kVsJ9c9lNyL3NgGen7WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGX0XUan/Gb3jRy39E0RHAqPxBPPu+8IWStadw322JlBB/GJgk
	JwXJk+UEnpdM9NzUyJ6ZEVHCo0RYJguTfoqDT5+jeWi1+Gde/VZ+75KEL4Xd1JI7a+wgUVECNwm
	2HDpo+KA2Dzcy2xgzE6uNl1gWcz+mgjs1u4/UPXa5iaY3ZECwWTJy5RLyFDLP45XpPta6V+Qc9d
	0i0irkc6Xk1MFFADd2a4Q+l6wv7Vu6X1su
X-Gm-Gg: ASbGnct0nFMl5r09yKbm1ZMAYk9zPvGK+mtiLlY0oZN7ZQS7gs0vJifbQp93sR48fLo
	1xEaJBL9O+xpy4Zp+gX50R86ERwi0iy3CQC96GUnQHPHckWkt3JgnOM0OuSI5GZ451MGtvcATES
	msAo3PF5GPrdnm92pnIqBftuO0kG+S7OrNRLbEyqmzIDOXlTx2HR7ukpI=
X-Received: by 2002:a17:907:c29:b0:af8:f7be:ab8d with SMTP id a640c23a62f3a-af8fd96f4d5mr41611466b.36.1753811912847;
        Tue, 29 Jul 2025 10:58:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTvLcfp3KIIOf9Tif+upSxDhjh23ERbfEgxqdWLHNtBLjTv9sjFsrNrUFhxwy/WaDBy/DUzP5mAcLAIOnELDY=
X-Received: by 2002:a17:907:c29:b0:af8:f7be:ab8d with SMTP id
 a640c23a62f3a-af8fd96f4d5mr41610166b.36.1753811912434; Tue, 29 Jul 2025
 10:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729164023.46643-1-okorniev@redhat.com> <20250729164023.46643-2-okorniev@redhat.com>
 <bdc6b98c-1441-4fb0-9ac5-96ae7ce732c3@oracle.com>
In-Reply-To: <bdc6b98c-1441-4fb0-9ac5-96ae7ce732c3@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Tue, 29 Jul 2025 13:58:21 -0400
X-Gm-Features: Ac12FXz2GS7MYP2Qo1LLAvy4-41e1CE5HIszjM9VeHKDEW7Kw-g7lRSla1HmN4E
Message-ID: <CACSpFtBwvEjfbFuf8WEmWO7qDPy1KhLY4WNijLJmmm2DW6vyFw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sunrpc: fix handling of server side tls alerts
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com, 
	hare@suse.de, Scott Mayhew <smayhew@redhat.com>, Stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@stable@vger.kernel.org  I apologize that git send-mail went to stable
email. Please ignore this email as this is an internal discussion for
now. But will be public soon.

On Tue, Jul 29, 2025 at 1:32=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 7/29/25 12:40 PM, Olga Kornievskaia wrote:
> > Scott Mayhew discovered a security exploit in NFS over TLS in
> > tls_alert_recv() due to its assumption it can read data from
> > the msg iterator's kvec..
> >
> > kTLS implementation splits TLS non-data record payload between
> > the control message buffer (which includes the type such as TLS
> > aler or TLS cipher change) and the rest of the payload (say TLS
> > alert's level/description) which goes into the msg payload buffer.
> >
> > This patch proposes to rework how control messages are setup and
> > used by sock_recvmsg().
> >
> > If no control message structure is setup, kTLS layer will read and
> > process TLS data record types. As soon as it encounters a TLS control
> > message, it would return an error. At that point, NFS can setup a
> > kvec backed msg buffer and read in the control message such as a
> > TLS alert. Msg iterator can advance the kvec pointer as a part of
> > the copy process thus we need to revert the iterator before calling
> > into the tls_alert_recv.
> >
> > Reported-by: Scott Mayhew <smayhew@redhat.com>
> > Fixes: 5e052dda121e ("SUNRPC: Recognize control messages in server-side=
 TCP socket code")
> > Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  net/sunrpc/svcsock.c | 43 +++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index 46c156b121db..e2c5e0e626f9 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -257,20 +257,47 @@ svc_tcp_sock_process_cmsg(struct socket *sock, st=
ruct msghdr *msg,
> >  }
> >
> >  static int
> > -svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
> > +svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
> >  {
> >       union {
> >               struct cmsghdr  cmsg;
> >               u8              buf[CMSG_SPACE(sizeof(u8))];
> >       } u;
> > -     struct socket *sock =3D svsk->sk_sock;
> > +     u8 alert[2];
> > +     struct kvec alert_kvec =3D {
> > +             .iov_base =3D alert,
> > +             .iov_len =3D sizeof(alert),
> > +     };
> > +     struct msghdr msg =3D {
> > +             .msg_flags =3D *msg_flags,
> > +             .msg_control =3D &u,
> > +             .msg_controllen =3D sizeof(u),
> > +     };
> > +     int ret;
> > +
> > +     iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
> > +                   alert_kvec.iov_len);
> > +     ret =3D sock_recvmsg(sock, &msg, MSG_DONTWAIT);
> > +     if (ret > 0 &&
> > +         tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TLS_RECORD_TYPE=
_ALERT) {
> > +             iov_iter_revert(&msg.msg_iter, ret);
> > +             ret =3D svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -E=
AGAIN);
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int
> > +svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
> > +{
> >       int ret;
> > +     struct socket *sock =3D svsk->sk_sock;
> >
> > -     msg->msg_control =3D &u;
> > -     msg->msg_controllen =3D sizeof(u);
> >       ret =3D sock_recvmsg(sock, msg, MSG_DONTWAIT);
> > -     if (unlikely(msg->msg_controllen !=3D sizeof(u)))
> > -             ret =3D svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret=
);
> > +     if (msg->msg_flags & MSG_CTRUNC) {
>
> Nit: can we leave the unlikely() here?

Will do.

>
>
> > +             msg->msg_flags &=3D ~(MSG_CTRUNC | MSG_EOR);
> > +             if (ret =3D=3D 0 || ret =3D=3D -EIO)
> > +                     ret =3D svc_tcp_sock_recv_cmsg(sock, &msg->msg_fl=
ags);
> > +     }
> >       return ret;
> >  }
> >
> > @@ -321,7 +348,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rq=
stp, size_t buflen,
> >               iov_iter_advance(&msg.msg_iter, seek);
> >               buflen -=3D seek;
> >       }
> > -     len =3D svc_tcp_sock_recv_cmsg(svsk, &msg);
> > +     len =3D svc_tcp_sock_recvmsg(svsk, &msg);
> >       if (len > 0)
> >               svc_flush_bvec(bvec, len, seek);
> >
> > @@ -1018,7 +1045,7 @@ static ssize_t svc_tcp_read_marker(struct svc_soc=
k *svsk,
> >               iov.iov_base =3D ((char *)&svsk->sk_marker) + svsk->sk_tc=
plen;
> >               iov.iov_len  =3D want;
> >               iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
> > -             len =3D svc_tcp_sock_recv_cmsg(svsk, &msg);
> > +             len =3D svc_tcp_sock_recvmsg(svsk, &msg);
> >               if (len < 0)
> >                       return len;
> >               svsk->sk_tcplen +=3D len;
>
>
> --
> Chuck Lever
>


