Return-Path: <stable+bounces-50060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74F890181D
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F691C20C06
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 20:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A374AEEF;
	Sun,  9 Jun 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/ubQ1Fi"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD338DD3;
	Sun,  9 Jun 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717964487; cv=none; b=eNRlUqvsm3V06fOaPAOAb7rNaQFGLrRoi2vBHD5ggLWHc9dH82hBlaOVMoa4qeazRwtEbOV/8JZp9+WbXpfAXy6t8QitodDVJsn/4da5AODqgLMNJBQuvg1B0E9o1PqAWT0ODgiXRh+KY8Kpww38hXjhSEfDpgCHFcjL/KkpAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717964487; c=relaxed/simple;
	bh=+bzKM9EUcFNyUvWXeH4KuSku+qNeTDWylsL42zL5iDo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Sj2mSF632XubCEYWcuzv+yCiBJIgRRT9OeCII4Kky+lUSC5fN3HqAdeS6QECw2s8P2PihD4Tmc9X8W+/iKOkPxKPtx1jwpI1LpKZ53YEU6zyuRRk46dOUe08wOqgr1qTJ6x8YEpX2DvUFI9thb297KDbh42fb47jLtraJIJGfCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/ubQ1Fi; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfb0538e227so1957494276.2;
        Sun, 09 Jun 2024 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717964485; x=1718569285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSVhib7jKO8Jl77YAATJbfVUvW2x6LHh0YQnorGkKq8=;
        b=N/ubQ1FiqBDlzhEJyMTETr6UcqT47azjc6pm1MieZg4ckYd3i1Q9TVXQpH6Kp0D9Iv
         ghnlq70loyEVS7xPiKEzgMc1I7PZ3GA/TqyeYIWQQozVyL7cV+mFrUDrhm6NN/U7Nm3q
         sAF3wHApmuzOIvi/4dmQTqlR2rRZWbAJaVw94Plkd7J8mv1Ya9Uzvf68/W/MOAty5j3+
         dbS+aojWIqknAipQcqR1cejqAPHGNDi4uuQQ26xbZS+zr+UJmMcpLyfXg/+QfyCj21jF
         +5sk0mHA7yVxo3IZU7mkxEGevz5esLVviY0tlcjSRZflc+SWT72FqIUMLqLIZOFLSMLI
         PzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717964485; x=1718569285;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rSVhib7jKO8Jl77YAATJbfVUvW2x6LHh0YQnorGkKq8=;
        b=Ozc8i//XnmNn7CnCCh8Y5itZIKFQPIqsE1T3DzpbM5U+jKjkOWTuIkgyYCQtHzhQQY
         kAnHl+woR3mJGileZu5CScmQ2JZwwxjBOv1CNJ6X5d7XgH1lHc8S5JmSx1z47D9W4Mzl
         HCaYmWpz0KR8DQgGTwUXwkKQW7P0BDtaXX4Czm0bjZorPyyw9T8oxXe+gT0oJ3MzkNKt
         x/D+kzYAkDG9JY89ScUzpMfH2WzYSZfDkcur3d2C1P6epOLqiEau5wOVMMNKowpbxBVR
         HoIEBeYlJ3cvoGinAe7tG0PiTz0x+zj+akrj1ZM/FOeBU6dJwF0y3PU1HdAMWXi80nMt
         VcPA==
X-Forwarded-Encrypted: i=1; AJvYcCVF1atCh2VxwzzXU0YLLX59gF8DLaAT2JPzrpPY7sM0vkl5nf1OjOjfjQ9pMKmcT88/q9f70zbRG3v9CmOBN0Ker4fA2zrhAYur2RcCDiXGFjNVyc/bd5MMLEP/POb+qNlqrwH40ajh+KVaea9y9s5rm/5/PZAueVrUyR54
X-Gm-Message-State: AOJu0YxWCzI4GBs9ElJro0RuOwvuh4KUMQX54lKEmkELtG33B/kH2h80
	zldYIIpxNryHHqG10LVOGl2eNrbtvQvATd5i2/rYqfV4q03w3UB4
X-Google-Smtp-Source: AGHT+IF26bX+ph1/1s1eH5JB6xP553+SdKj51RRQ1tb2iaPpfDBA5NuYBTaR8QzkBK/QyeEKQGpk4Q==
X-Received: by 2002:a05:6902:503:b0:dfb:4ae:27c with SMTP id 3f1490d57ef6-dfb04ae05b1mr5857844276.42.1717964484581;
        Sun, 09 Jun 2024 13:21:24 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44052953a0fsm19666741cf.92.2024.06.09.13.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:21:24 -0700 (PDT)
Date: Sun, 09 Jun 2024 16:21:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kaber@trash.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <66660ec3f3e22_8dbbb294ed@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qfuNhDbhV9mau9RE=cNKMwGtJcx4pmjkoHNwpfysnw5yw@mail.gmail.com>
References: <20240608025347.90680-1-chengen.du@canonical.com>
 <CAPza5qfuNhDbhV9mau9RE=cNKMwGtJcx4pmjkoHNwpfysnw5yw@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chengen Du wrote:
> Hi,
> =

> I would like to provide some additional explanations about the patch.
> =

> =

> On Sat, Jun 8, 2024 at 10:54=E2=80=AFAM Chengen Du <chengen.du@canonica=
l.com> wrote:
> >
> > The issue initially stems from libpcap. The ethertype will be overwri=
tten
> > as the VLAN TPID if the network interface lacks hardware VLAN offload=
ing.
> > In the outbound packet path, if hardware VLAN offloading is unavailab=
le,
> > the VLAN tag is inserted into the payload but then cleared from the s=
k_buff
> > struct. Consequently, this can lead to a false negative when checking=
 for
> > the presence of a VLAN tag, causing the packet sniffing outcome to la=
ck
> > VLAN tag information (i.e., TCI-TPID). As a result, the packet captur=
ing
> > tool may be unable to parse packets as expected.
> >
> > The TCI-TPID is missing because the prb_fill_vlan_info() function doe=
s not
> > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in =
the
> > payload and not in the sk_buff struct. The skb_vlan_tag_present() fun=
ction
> > only checks vlan_all in the sk_buff struct. In cooked mode, the L2 he=
ader
> > is stripped, preventing the packet capturing tool from determining th=
e
> > correct TCI-TPID value. Additionally, the protocol in SLL is incorrec=
t,
> > which means the packet capturing tool cannot parse the L3 header corr=
ectly.
> >
> > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.d=
u@canonical.com/T/#u
> > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > ---
> >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++=
--
> >  1 file changed, 55 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index ea3ebc160e25..8cffbe1f912d 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_=
sock *po,
> >         return packet_lookup_frame(po, rb, rb->head, status);
> >  }
> >
> > +static u16 vlan_get_tci(struct sk_buff *skb)
> > +{
> > +       struct vlan_hdr vhdr, *vh;
> > +       u8 *skb_orig_data =3D skb->data;
> > +       int skb_orig_len =3D skb->len;
> > +
> > +       skb_push(skb, skb->data - skb_mac_header(skb));
> > +       vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr)=
;
> > +       if (skb_orig_data !=3D skb->data) {
> > +               skb->data =3D skb_orig_data;
> > +               skb->len =3D skb_orig_len;
> > +       }
> =

> =

> The reason for not directly using skb_header_pointer(skb,
> skb_mac_header(skb) + ETH_HLEN, ...) to get the VLAN header is due to
> the check logic in skb_header_pointer. In the SOCK_DGRAM and
> PACKET_OUTGOING scenarios, the offset can be a negative number, which
> causes the check logic (i.e., likely(hlen - offset >=3D len)) in
> __skb_header_pointer() to not work as expected.

The calculation is still correct?

I think that this is not the first situation where negative offsets
can be given to skb_header_pointer.
 =

> While it is possible to modify __skb_header_pointer() to handle cases
> where the offset is negative, this change could affect a wider range
> of code.


