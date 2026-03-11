Return-Path: <stable+bounces-224771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHfoJW8AsmkvHwAAu9opvQ
	(envelope-from <stable+bounces-224771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:53:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F014A26B785
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1693050A11
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 23:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C5286D57;
	Wed, 11 Mar 2026 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOX1nlE7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3141376BE1
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273127; cv=pass; b=OySv/r8BMXRC7ptmNITzuVuvwoqm2yC7j4DwX6fklwDTnvfxSLH1zodrukJUazyKah4OE7k89uPJ0QV7BQwnpOJwJ86NJm2NY9LpTQsm7WmS6jEVmIwKABsZJJBVMAL4mcgL4UNK69DZyh9JpYMTm8Nbut730Lb8jcRzbRtHQ5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273127; c=relaxed/simple;
	bh=aIkffOjGqTfw8EYv0ooqwQA2XrSIDdmpDM/eDv2AoHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn0bAcu9dKMHGEZau+fRZlJJlbVwsPc+hCU45Oa41/f94CKIDsIJcu8nRZMMAiCw+IusLVXkgFjUb0dpakIfDSlwHLMS0FSpGBuHPJK8VMh1a3kTdEtIntpp2dDsdXcsF1Ftle1jCg5Vz7JmSrGv6den/34fFkK9AcnQdK7NVug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOX1nlE7; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a018cbbf8so20441846d6.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773273125; cv=none;
        d=google.com; s=arc-20240605;
        b=g69Z3F7dm2uCmFDcxrdXgeaxQ9d4LFd9jde6Pk5aAuPifBo2kpJ28PfpdAcCiJFb0e
         k1qo/3CNIsjZw6JVV24X8FqGLZ0T/fuAynxUlMvcrm5Bz1uQzTt+W0tSzda34olQsJaj
         1thoJLkWKvUQ+pBXTvhhwqT8abEEyEeBFeK8RINpxZoN6vTz0cuUpzGCdOYVVRtQe4sD
         O8eZ/mSdQbCft2FugTuv86b1EOOYJTT34B71ftTG4j5/o9N2r5fdcMA1IojGs7VCgYPh
         ZgSFd9RWYGt7dnA2FOk8OPd9tOppGUfJU9JOMjzSkNYSmvVQOiPfqBi0lzShBPFkfJ8R
         5ZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aak02bl+tOxupaPAiu+YapXXnDf1p18gRXzhDpE7U48=;
        fh=Lp1KAiNa9F0deXZnP+oidkIpv5qqIQaIO9R1YuIIy8Y=;
        b=JBTCb8KbwO57DUrdpGkUnfepTDFZqeidij/Nf24+Twy+hzerahM3JxWXlg11YTwfOK
         pfkJWbt+LjHUur6DGCKZAlKcGN3pomTk4DoPyBcjCZhcdnaLz4qcHnDW6OA6dDXllPvB
         aeTPxm86pidluj2uU5EuOUDbtpIvQid8UucXUqfEI463+mYHwtv68ddEka44uw4LiXsb
         CVzwf4I2CQvzDJ5zl0txRZ3qeSjtj/fzkYhlTlDdmFqownEBjkp44Q3cMTASRXPyldcy
         bdipU7x4pq2mB6c2XQiVQJu/hcrsNTrWvKfbNbP4R2y2v31owZQvXKzUmR78/kfTNZJ2
         8RDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773273125; x=1773877925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aak02bl+tOxupaPAiu+YapXXnDf1p18gRXzhDpE7U48=;
        b=SOX1nlE7kL75LYKij7m7KC2G7WWBxuG6wUIQrhxHEk9+9iVB+VE9jjsVBJDGlB6PYn
         X5NHPQ+DIjUQ1WJ2rhS2u1AxkqDO8riy/mXjafSo8hibc6gEUQlvXxqm5Msvf0H4zyMg
         b1e0fBKDEEwFHOcxSTNjVF1KeDwOpBdgtRbMFv9E6CKFAJE1TmkCOkKp/zryEr7Gu1OH
         KQZ1vGpARLOlHl4An7/sMKZlNzInIWDVv79r9QxgJNEINAie/gWTJ1/wlvFRrGpin80o
         uWM/HFvYdXuUmxWwT2bGTS+QSqwQhqsfoSFxOBCzGxqfVolrAi8CFneDXWBDGYqm/hEF
         t1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773273125; x=1773877925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aak02bl+tOxupaPAiu+YapXXnDf1p18gRXzhDpE7U48=;
        b=CijzxIKWkeYWmHqMgH/p6kGyOA0IGywLNiYeUbriMVOuy00jgmI4GDR3iaSmYYKVwU
         rzJyVEFA0z30o0YW/cvpzwoSIO5YLXcTUBl0KmXCbQgDdnmJKjDEdX1ET7/0Jw7LQ3LA
         NWdo/SfArFi9KS/5Dh7HelxMi/yUw/N5S8PrRj8OaEjhwWZOHC8ksW44X8sMUhrWzOEu
         FPZn8YKLj7fAmNZZR0f+1D2Z1Es7IYf/OS8wffsn3VCdnz8/LSqhv0Q6YCnLV5SEu2k+
         WvECB7D2srpNwt+/VUPFsU/XpLnrXJWmLEAJYpnZzOXq3pavGnHZt6F7G/kLa/Rk+Yii
         pdzw==
X-Forwarded-Encrypted: i=1; AJvYcCXQAJ33X1d/RiO8MR01vejMyck+zPIRaIyltinO8JingcrYq48yv1koafWtWsN1+acExUv0oUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMgG1GdCoLGB/U65Muj0yuzBH8ClTKeuMJPs1gm2bLNiw0V27
	1MLqs38N0Trj0ExZrCU4Kc/9K/MFwUIcbHr9Qod3YxfnANj3alNHWozqDyD7Xjt6malNW4ejfzT
	CLW6H5hkOXJpbdk7Mmki3tixdSiLog/Y=
X-Gm-Gg: ATEYQzwoZMbQqudJVNiOPtDg8JIozxl+spjT05Oo503LYFUCG+N4kwMzeuf456xffTF
	UJuChCM6us7EoJafI03yKSHLT9iQIKMFH2kFDZMeeY8LkT0Su8A8a42rEYMrlQrxDjDCGNLFsHa
	8uAvdeXCv20TnH2KX3ObV/dCoOSdFI//Qd/cUaFcWMwXx6STP/VIpzEf2LYUEbmS5QH2zioH7NX
	h/AEuM0E5abyMjOsnG59L0EUVXg8xrUr2YsLi5in29rSr2F7pjRJr1wpoynH/QpcHJf90edfcRh
	zDCCIoBDbG2FOJMNiy0my48j5pcUSlr8vpjXdaqyq7nt/xbqs0/aVSGmJlZv53v8aYyGI2qpvEG
	89XTL27s2BSzexeA2kUMDTvFEltXMrxqZSTHsUabW3abiJ2xHJSKfenoUIFYlQwhXlpfLq5eVRa
	eO4RnwtGG4a28rf/Zr3c9z
X-Received: by 2002:a05:6214:19c9:b0:89a:77b:837e with SMTP id
 6a1803df08f44-89a729d8f3emr26275396d6.6.1773273125385; Wed, 11 Mar 2026
 16:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311231723.751558-1-henrique.carvalho@suse.com>
In-Reply-To: <20260311231723.751558-1-henrique.carvalho@suse.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 11 Mar 2026 18:51:53 -0500
X-Gm-Features: AaiRm52w23mPBC3G4ypnbWAzbkKeH8taEUOrvVOe6GbIGt5Bj-pX_iL9f9xwLwU
Message-ID: <CAH2r5mtsdSJBZ=b5ABm=Gq4sfakb7ZXrx0N7AF0_1TTkVqn6Zg@mail.gmail.com>
Subject: Re: [PATCH v3] smb: client: fix iface port assignment in parse_server_interfaces
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	ematsumiya@suse.de, linux-cifs@vger.kernel.org, stable@vger.kernel.org, 
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224771-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org,uni-hamburg.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,uni-hamburg.de:email,suse.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F014A26B785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

updated in cifs-2.6.git for-next

On Wed, Mar 11, 2026 at 6:17=E2=80=AFPM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> parse_server_interfaces() initializes interface socket addresses with
> CIFS_PORT. When the mount uses a non-default port this overwrites the
> configured destination port.
>
> Later, cifs_chan_update_iface() copies this sockaddr into server->dstaddr=
,
> causing reconnect attempts to use the wrong port after server interface
> updates.
>
> Use the existing port from server->dstaddr instead.
>
> Cc: stable@vger.kernel.org
> Fixes: fe856be475f7 ("CIFS: parse and store info on iface queries")
> Tested-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
> Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
> Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
> ---
> v2 -> v3:
> - add spin_lock around server->dstaddr access
> v1 -> v2:
> - read the port once from server->dstaddr before parsing iface entries
>   and considering *server* ss_family
> - update the commit message to describe the fix more clearly
> - adjust the Fixes tag to fe856be475f7 ("CIFS: parse and store info on if=
ace queries"),
>   as the later commit only exposed the bug rather than introducing it
>
>
>  fs/smb/client/smb2ops.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 7f2d3459cbf9..612057318de2 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -628,6 +628,7 @@ parse_server_interfaces(struct network_interface_info=
_ioctl_rsp *buf,
>         struct smb_sockaddr_in6 *p6;
>         struct cifs_server_iface *info =3D NULL, *iface =3D NULL, *niface=
 =3D NULL;
>         struct cifs_server_iface tmp_iface;
> +       __be16 port;
>         ssize_t bytes_left;
>         size_t next =3D 0;
>         int nb_iface =3D 0;
> @@ -662,6 +663,15 @@ parse_server_interfaces(struct network_interface_inf=
o_ioctl_rsp *buf,
>                 goto out;
>         }
>
> +       spin_lock(&ses->server->srv_lock);
> +       if (ses->server->dstaddr.ss_family =3D=3D AF_INET)
> +               port =3D ((struct sockaddr_in *)&ses->server->dstaddr)->s=
in_port;
> +       else if (ses->server->dstaddr.ss_family =3D=3D AF_INET6)
> +               port =3D ((struct sockaddr_in6 *)&ses->server->dstaddr)->=
sin6_port;
> +       else
> +               port =3D cpu_to_be16(CIFS_PORT);
> +       spin_unlock(&ses->server->srv_lock);
> +
>         while (bytes_left >=3D (ssize_t)sizeof(*p)) {
>                 memset(&tmp_iface, 0, sizeof(tmp_iface));
>                 /* default to 1Gbps when link speed is unset */
> @@ -682,7 +692,7 @@ parse_server_interfaces(struct network_interface_info=
_ioctl_rsp *buf,
>                         memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
>
>                         /* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore the=
se */
> -                       addr4->sin_port =3D cpu_to_be16(CIFS_PORT);
> +                       addr4->sin_port =3D port;
>
>                         cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
>                                  &addr4->sin_addr);
> @@ -696,7 +706,7 @@ parse_server_interfaces(struct network_interface_info=
_ioctl_rsp *buf,
>                         /* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore the=
se */
>                         addr6->sin6_flowinfo =3D 0;
>                         addr6->sin6_scope_id =3D 0;
> -                       addr6->sin6_port =3D cpu_to_be16(CIFS_PORT);
> +                       addr6->sin6_port =3D port;
>
>                         cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
>                                  &addr6->sin6_addr);
> --
> 2.53.0
>
>


--=20
Thanks,

Steve

