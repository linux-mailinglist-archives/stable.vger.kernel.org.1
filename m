Return-Path: <stable+bounces-244374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPV4G4wu+2k4XQMAu9opvQ
	(envelope-from <stable+bounces-244374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 14:05:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D771D4D9F64
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 14:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DAB43011598
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74043E487;
	Wed,  6 May 2026 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJoy8kS6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5921401A35
	for <stable@vger.kernel.org>; Wed,  6 May 2026 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069124; cv=pass; b=EwIK7xbYQdaGAk4UGrDaI1Jnmmrjlb/n47ZOwkKYDtk/jQooyTplUBZVyhg02ul5qcTbPHk7pmQw1eK09P3zBkYQ4ti8V+maZthQ0W0PYrY9GGHjR8Gf360hBWpiXF6S0xT+/EUVwzG1mf0WmOELzskVL9nmHrj9Zr/zPp00YFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069124; c=relaxed/simple;
	bh=2zMx+FaWfwnhe6lXrswOUXzCVpQRjKQ7ump7lWG1tV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIBMKnDMqP6f1Ajy5bljeiJHiMDEpV2qIb++swLzJTMaBNQulHcoOHBDm3gJvh2jGMqk4wo/D6qg1AgdRX2iXOysQ77mPWCOUH+p+UMlyBTTmRmVr5H17mqbNV5nuCWW5szzL6Wckkyt5rqjLwNankuJmb58UFxuNPtTliwD0zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJoy8kS6; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso8247a12.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 05:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778069121; cv=none;
        d=google.com; s=arc-20240605;
        b=UjnMZSuDv2tV5Ryr+8DEDsO9ChlY+L40lHk2wjKY0PX43sNJgBRfacm0SPbIvKrzic
         IR/DmeU7pYDOGYSYIdRFjQxspZWZC/FpGEhoPPffohPQWMFPYVjPeFjbZGYvRzmjmxZp
         rGXTYmSTd0L3PaIExI87B9BBJ8EozQn8cdP1LkGRkdCCl164imtAq2Gj7nPP3BQLticW
         /sjvbCZnb+wZvhLcnaunUvg56ANV98AmqDHbbNx5UV70CA9YJYp9jsA/nyaPJQWwMuMg
         wrCbPMalW0o1N1S1zjF4h4bEAi9y8iO9VTsOehdHFJCPs0amhTT4iIGFx2MCxaY5WNZv
         akuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7SkiCwpoGGSR+VOguP46PNj7/26BOC/RtwhpETWAfik=;
        fh=hmDUnYhh5pYyl+KwDeYPT7VIzKrQrvG/drHipufe3Vw=;
        b=Ub8SJTw+p41uI52pHZEeUcpx1QAe9X57wQKquCRFWkgoXvedd4SWWQNaUKbu+hDg2R
         nS754lnmjFUZUN8g0pITB00FSVrYmGG07lOWcFXdrRErv/9XkB60ITm9hUtm5CuHz+2v
         bpP0U775SXVi7uKMl4eEue1MBjjvbpOQ2F3YricANEBvf9+gEAPk6MM+56d2SCjtC1ij
         NwNQ3hZ5gsE6w/T2/gO5bBtajRt4lQ4f2vsfFzV7jM/+4/4pblDwgXhRLyumM2aH1Qdj
         gcULPCdCd0QQcj8N2I31cwoM2jXo7zhblOFMY81pibC6ZbQhh0uqZCPMb5LZjwRl3Ggt
         5yiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778069121; x=1778673921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SkiCwpoGGSR+VOguP46PNj7/26BOC/RtwhpETWAfik=;
        b=SJoy8kS6T6BdmZLP8VhA9T5JeIwqr+R/w1dpbCKU9jv9p39bY0IWC1ex4Secnng9hI
         38RqbpwDr87OdQjcRw+le4i4lfAv+z6oOSCy26qOL+IGHTvv8oPASD4k5+8svd/iXIxc
         j9YuBreomd9hxDMhGY2BrEzjsI9HhAAsruj5FVHn+u3UlteL2xGgBpeMmLW5bnX9LQ/x
         wk0rsSxfOcy+7Ng71iMVsHz+XjnZn8Io26Z/KPLwoZbEv6s3rzmbZ+Vbm+2s4al8y0DU
         qpqlQ4n0VumMedLWTnC9NisjqOby5ECqlQM+RajnkU2mNmdwczAeIxvlg6TxfEdAg25x
         oAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778069121; x=1778673921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SkiCwpoGGSR+VOguP46PNj7/26BOC/RtwhpETWAfik=;
        b=qQxtiQ6qnCbXD9N43Gts8JrCxCAbrKs76ZCROFizXk8eG5JqXQrnu01ofNtQpPQo3i
         KqTdOncw3A9eFPKxDYL3mntk6hX8Q06W2nQVvd519VGA+oaFhGvNQV5fw2EydHGMnnyL
         QCElfldi+Sd81YN7Lno5p0cD5zjEMDR+qoNs3RGt1bCPFmcZiJ0BGY/tLrwrl8vriLCa
         aqbnUz07LR5JZTtVupgB5hh45r9oxvioxbKcu9XXQGrHkKhW0YRXIHwIgrC+XcJ0ZGVl
         z23LO+HF302M1I3AVEODkr19cDkRLdLs6X7Hle1B6Ly5FOQs5nWNeutTmWyZbPf6alfy
         +16w==
X-Forwarded-Encrypted: i=1; AFNElJ9l9T1nmZLtDa+q+H6P8XDNHFg37sZAANnSsjf27ZGKc3W8PbLO84BqiSvWiSiMmwCEze4bsiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWfy3qhra/raDdlyKYr/zAXizjJankpsBzrq0cwgknStxe35u
	4ap0wa/nlCpSxqGyE3kSlz56VU3vjy6kjWTUV64lnmVNEaGXlRKzWAGd8EUMyeaT+2RZ5KRZjxT
	ELFrl7lTvV4T9b5Fk2Yg7OiaN6JhMApr3LJH0XnX7
X-Gm-Gg: AeBDieslhG/k0skIUMutVcuE+iIUcbnbSEDzdaYWtD/ZU0e/meeUpK4yea3wgTMIhNn
	+uigsRq/vot+f424cO/E6rLV6m5RR1iFuu4zWE5BKzFFvEBecewg7VdgcoVH1O7/BPdpihNr2Ob
	XoL+ffmtbwo6TeAvPjM7aAFgP/+2m6rFHbYhHCr0hNy44JA2j4k7J39pPzegug4200TUFAP9A2v
	VsL+vTMWLKFWAyPzi4viIYU5FViG3cv/eZzEmamaub7jylKdTk4Hbn62C4yYBQWOrzn6QRuqhoT
	Hga77JBfi8xEE6vRrm3I73cVBM8WxT0ZHWo1SPK0al5BsCfopFqmUq0tpl4=
X-Received: by 2002:aa7:c903:0:b0:670:d5f0:2595 with SMTP id
 4fb4d7f45d1cf-67d63d9276amr44273a12.11.1778069120699; Wed, 06 May 2026
 05:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com> <CABBYNZLzyh7a7sZ+0U4DAq8TB6e6=WdNrfKrxGXMqnYAMT0KnA@mail.gmail.com>
In-Reply-To: <CABBYNZLzyh7a7sZ+0U4DAq8TB6e6=WdNrfKrxGXMqnYAMT0KnA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 6 May 2026 14:04:43 +0200
X-Gm-Features: AVHnY4K5YkADVGWfu3nzBfhgYwm-1qpAh1RKBgX_mKXaVR2EX0ROB4TwY8iXUu4
Message-ID: <CAG48ez3HWBb0X1q-owvK40OC5ecx=A7CWTAGBoWSppJYSKYLRQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix UAF read of ->accept_q in bt_accept_poll()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D771D4D9F64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244374-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[sashiko.dev:server fail];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[sashiko.dev:server fail];
	NEURAL_HAM(-0.00)[-1.000];
	RBL_SEM_FAIL(0.00)[172.234.253.10:server fail];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 5:06=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> On Mon, May 4, 2026 at 11:11=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Use lock_sock() to guard against bt_accept_poll() racing with concurren=
t
> > close(accept()), which can lead to UAF:
> >
> > task 1           task 2
> > =3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D=3D
> >                  __x64_sys_poll
> >                    __se_sys_poll
> >                      __do_sys_poll
> >                        do_sys_poll
> >                          do_poll
> >                            do_pollfd
> >                              vfs_poll
> >                                sock_poll
> >                                  bt_sock_poll
> >                                    bt_accept_poll
> >                                      [read ->accept_q next pointer]
> > __x64_sys_accept
> >   __se_sys_accept
> >     __do_sys_accept
> >       __sys_accept4
> >         __sys_accept4_file
> >           do_accept
> >             l2cap_sock_accept
> >               bt_accept_dequeue
> >                 bt_accept_unlink
> >                   [removes new socket from ->accept_q]
> > __x64_sys_close
> >   __se_sys_close
> >     __do_sys_close
> >       fput_close_sync
> >         __fput
> >           sock_close
> >             __sock_release
> >               l2cap_sock_release
> >                 l2cap_sock_kill
> >                   sock_put
> >                     sk_free
> >                       __sk_free
> >                         sk_destruct
> >                           __sk_destruct
> >                             [frees new socket]
> >                                      [UAF read of ->sk_state]
> >
> > This UAF only leads to incorrect reads, it does not corrupt memory; it =
is a
> > fairly tight race window; I believe every race attempt requires an
> > incoming bluetooth connection; and the leaked data is limited.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  net/bluetooth/af_bluetooth.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 33d053d63407..d24897167838 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -521,13 +521,17 @@ static inline __poll_t bt_accept_poll(struct sock=
 *parent)
> >         struct bt_sock *s, *n;
> >         struct sock *sk;
> >
> > +       lock_sock(parent);
> >         list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept=
_q) {
> >                 sk =3D (struct sock *)s;
> >                 if (sk->sk_state =3D=3D BT_CONNECTED ||
> >                     (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags)=
 &&
> > -                    sk->sk_state =3D=3D BT_CONNECT2))
> > +                    sk->sk_state =3D=3D BT_CONNECT2)) {
> > +                       release_sock(parent);
> >                         return EPOLLIN | EPOLLRDNORM;
> > +               }
> >         }
> > +       release_sock(parent);
>
> There is the following comments though:
>
> https://sashiko.dev/#/patchset/20260504-bluetooth-accept-uaf-fix-v1-1-1ca=
63c0efadd%40google.com

Regarding the LLM output on whether lock_sock(parent) is enough: The
locking I'm adding here is the same as what bt_accept_dequeue() uses
for protection; if event handling can also remove accept_q elements
without holding appropriate locks, I think that is a separate (and
bigger) bug.

I see I've just been CC'ed on
<https://lore.kernel.org/all/20260506114338.2873496-1-n05ec@lzu.edu.cn/>,
which seems to be a broader fix; if you want to go with that patch,
this one is superfluous.

> I'm not really sure if likes for the poll are supposed to be done
> lockless, if they are, we cannot use lock_sock here and will likely
> need to rework accept_q so it doesn't contain deferred sks, as those
> shouldn't be considered ready for acceptance.

I don't see why that would be a problem;
Documentation/filesystems/vfs.rst says nothing about wanting lockless
operation, and if you look around at other poll handlers, you'll see
several ->poll() handlers that take sleeping locks:

 - dma_buf_poll() calls dma_resv_lock(), which locks a W/W mutex
 - vb2_fop_poll() sometimes calls mutex_lock_interruptible()
 - virtio_rpmsg_poll() calls mutex_lock()

My understanding is that is is preferable, but not required, for
->poll() handlers to be fast if they're used by high-performance
userspace code, since event loops might hit ->poll() handlers fairly
often (especially if userspace uses an API like poll() or select(); I
think with epoll you only get one or two ->poll() callbacks once the
file descriptor actually becomes ready); I think this probably isn't
really an issue for bluetooth listening sockets.

