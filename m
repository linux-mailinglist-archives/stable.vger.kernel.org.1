Return-Path: <stable+bounces-233546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J5JJtbb1GnzyAcAu9opvQ
	(envelope-from <stable+bounces-233546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:26:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E01123ACD08
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A162300B8D7
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677303A872C;
	Tue,  7 Apr 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyExcLBd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40BC3976B8
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557583; cv=pass; b=Kc8VQYlyTHA7u2sorWqat3hZ5sMERPRgvLQOwobtLqUev2LbolCQjU5aM4vpsThg5mMKphIzsCSJ2SiK6TQcxuBtCkJDcGR08GMBi1JRRpdMxjpcbxU49HxI2Noa4hOLVWH6priHAKcZRQLAwsqNLSY3iJlHEEZRxhO2RWhrofE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557583; c=relaxed/simple;
	bh=FN1DQCn2XQYPtRQlpk34tuyMeniJyJsR2bcp0raiNjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fK2wOw6X5hzjJFApKTFsKUykFG4VASM9RKdb0DKj0PWjuH+j1n6yAIOmd/MdTuhld0XmPZvs4YMtVTLjVzdQGLeqkIkoPAJAynHvZepHSoy5jCEfb9j/ebTHZc1/RaXsk6cxE10RnBFbK0+SKrmXqF5Go5KwsxFbmTS5hu1Hbws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyExcLBd; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d8da3e656so22117951cf.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 03:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775557581; cv=none;
        d=google.com; s=arc-20240605;
        b=JXUgIKyq2sqbmmjguphPETB504rgVRxZE91EqlU0XxGTNhRbjumyfQ95GiVxOhUPs1
         Zqfh4ffrfIaWIaFVy5ahH5rsmPyih7nHB+ojfUyXxt34hmBMEsCxVagqyWL0RQ8Ncvmf
         YR7TbYvzBVBccAWJkTU7wIw9rRlF6/IET4j2ouZjIzJa1R5rrju48FEtH4MmLU6CpFFQ
         +xgxhWMS02ShqsigZxTKJaq3qrLZTQVBFjbtBcyLC7Cpf3R2qliQZvQWQltxlq3cN1wR
         yGXIAawHpiq0ugSv2wXZEjsTwPDC7TlNR1wNi4hEuj7JALtFZyYrgoUKy/0QmrwUkdSS
         +Ymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LArOe3ArIGUaW/5j3verGc1ir4Jk+MM5L6djQwE4ySc=;
        fh=X8uLa/2Yq2EEtUPRjmvOGBl+ek6mFGauP7rCN3AAG0k=;
        b=eTarZCsib6LPCe2YzOVboacCv1YhOjZAQ8v6el8TwvtNIBs3yZT4pYXE/Mo47CWo9F
         rlRrkAf4qtsS2ZFEsIimDF6JmCDSc+CMC4T3BgOrQOkIZ12KnwHZhufRiBV1/WZ91YAP
         +gcs6euJoENrjZRwTDoZoWEqgFvNV1rmp/9Ufg2Lt+pIS5ryZdjoi3l37HgiYS8kOVBq
         VgREcxkoiB2u3Ij/FTimGXQKDTWoeuubffrNaN11zVeet6cFEub19SgFUIIGVAzef/yr
         /qrdJSJhZT2AVIwQFH8RjoOE4M1quM3zPC/XuZDskyviCPn8Y1A71v91kjg6tJ70NosQ
         GfZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775557581; x=1776162381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LArOe3ArIGUaW/5j3verGc1ir4Jk+MM5L6djQwE4ySc=;
        b=jyExcLBdpBG/e6CAmMv7GQvigZQQB9A0tnuKmIQD62aVDMdAq+UHgL2HkgqBrRu8D+
         d6/M5nyAfyymdaDHo2nWC7TOXejqeJr4e2A+VTQA7o7wPm2fm2oSYLzYZfSZ8GXhsa08
         a4Z7oxSYaWWKC1iSI7EA3pGfBX/n+raAChlPkgXP62cQuPNj4DlJ0Qj1qzX9zprmILrV
         dTIEEf+fESCU2Xq4DNvYj0HD9x5J5Q3fqEFGtmGJPFsKKpABbgALAfHlarQO5w3tyyQc
         o1xMrasNU6nSowsHfKewwca1qpjKQ84eYE5gV6DlD3x8eSKerAVSnGoR9GYb4tx9VgKN
         N/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557581; x=1776162381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LArOe3ArIGUaW/5j3verGc1ir4Jk+MM5L6djQwE4ySc=;
        b=L2HI9MSeQZ7ANQvcQsGbxnPwpTcExEReTD930crDHMDZUIRk89O5y7SWIuZetrAmvm
         Kw8/7qpxlI5KSn3PFeypcz7k/LCsezJZuXrKRt7MKa9E2nqW42XWBBEBVY1lxU8Z7dld
         TpMse8mERtc0H8c1MEQ8veYsPPQgUpOsJyt2ahRsvwCCHVPG5zTq/GWcj3Bif74JN66B
         W+Ee95cp/XPeqattMIdBpXBAwJOR834zin53hclhDlV7Qb96xgs8XUSsHCnOct3AZmy0
         AR5G8iVXOmLAGFrqoU8QI6r871bkhLlPL5BWKNT2qN7Qp0leWdSLnINyYRtNi7xrR9L/
         EK6A==
X-Forwarded-Encrypted: i=1; AJvYcCUv4+jqz7IxlpwY7bK0I85+nAq/zbzjABRLhB+vwKh8dqfT2Zf4p45X+dUAO9YIhoNg2XY3GPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6z1Xr/ctsmbm+N28JZk7UvEqPwvENx/zMZnmtt8Vgrh9IJsjn
	o2pma7mLv9EJgcI98MPGaSJvd7hr1PQWauPCiaBuFlBa6CSO3hSHcyoNcamIAM4Ul7dJjNcO6Qy
	ypYmG8HEITdVNNSei3uWNAYQHcIz3Get+o7h7YXHV
X-Gm-Gg: AeBDieuUeaijZbz562vSEzTawmIPiHsIkh3pTRLRVD97ZQd7prJ6z7ECCM7y3qoKqJu
	oDIZjrWCZ6f6F64gYI0km+oSexJdnHiCVyWd78FzyPvPwfzUIOmItzDYKdDz3eSYDzTnjvnUQo5
	WRSqF/Qu7evISaEcN+FP64E6pqufBGlcIZqprihNqHfdnWMjY/aKXV9ILET0hJkHrhMoYWTvpo0
	mJJkInZacKoRczztUt3AThQ0FOyrfEas6CgQrT7tEjicLl9sp/QbT6iUtVpbmLUIWqYwOekNqbx
	oORn
X-Received: by 2002:a05:622a:1249:b0:50d:8d63:3899 with SMTP id
 d75a77b69052e-50d8d633997mr136929461cf.14.1775557580205; Tue, 07 Apr 2026
 03:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALynFi7k1Z7Vgr4p2=KH2-uWVntBRE5R+8uP=cds9_ihGqzOdQ@mail.gmail.com>
In-Reply-To: <CALynFi7k1Z7Vgr4p2=KH2-uWVntBRE5R+8uP=cds9_ihGqzOdQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 03:26:07 -0700
X-Gm-Features: AQROBzBvseGXPkhLNOfBdhgZCT4vkc3IixRgnkzZF_KK-emNhgc1oy5s8O1gXuY
Message-ID: <CANn89iK4qxTrdTi_F9_kHDjxZ4F-7eyRcBTHimaugZOQP8bGeA@mail.gmail.com>
Subject: Re: [PATCH net] net: rtnetlink: zero ifla_vf_broadcast to avoid stack
 infoleak in rtnl_fill_vfinfo
To: Kai Zen <kai.aizen.dev@gmail.com>
Cc: netdev@vger.kernel.org, edwin.peer@broadcom.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233546-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E01123ACD08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 3:22=E2=80=AFAM Kai Zen <kai.aizen.dev@gmail.com> wr=
ote:
>
> rtnl_fill_vfinfo() declares struct ifla_vf_broadcast on the stack
> without initialisation:
>
>     struct ifla_vf_broadcast vf_broadcast;
>
> The struct contains a single fixed 32-byte field:
>
>     /* include/uapi/linux/if_link.h */
>     struct ifla_vf_broadcast {
>             __u8 broadcast[32];
>     };
>
> The function then copies dev->broadcast into it using dev->addr_len
> as the length:
>
>     memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
>
> On Ethernet devices (the overwhelming majority of SR-IOV NICs)
> dev->addr_len is 6, so only the first 6 bytes of broadcast[] are
> written. The remaining 26 bytes retain whatever was previously on
> the kernel stack. The full struct is then handed to userspace via:
>
>     nla_put(skb, IFLA_VF_BROADCAST,
>             sizeof(vf_broadcast), &vf_broadcast)
>
> leaking up to 26 bytes of uninitialised kernel stack per VF per
> RTM_GETLINK request, repeatable.
>
> The other vf_* structs in the same function are explicitly zeroed
> for exactly this reason - see the memset() calls for ivi,
> vf_vlan_info, node_guid and port_guid a few lines above.
> vf_broadcast was simply missed when it was added.
>
> The pattern used elsewhere in this file for the regular IFLA_BROADCAST
> attribute also avoids the issue by sending only dev->addr_len bytes
> rather than a fixed-size struct, but for IFLA_VF_BROADCAST the wire
> format is the fixed 32-byte struct, so the right fix is to zero the
> struct before the partial memcpy.
>
> Reachability and impact
> -----------------------
>
> The leak is reachable by any unprivileged local process. AF_NETLINK
> with NETLINK_ROUTE requires no capabilities. The only environmental
> requirement is that the host has at least one SR-IOV-capable
> interface present (a parent device with VFs), which is the common
> case for cloud, datacenter and HPC hosts.
>
> Trigger: send RTM_GETLINK with an IFLA_EXT_MASK attribute whose
> value has the RTEXT_FILTER_VF bit set. The kernel will then walk
> each VF and emit IFLA_VFINFO_LIST, including IFLA_VF_BROADCAST,
> which carries the 26 bytes of uninitialised stack per VF.
>
> Stack residue at this call site can include return addresses
> (useful as a KASLR / function-pointer disclosure primitive) and
> transient sensitive data left over by whatever ran on the same
> kernel stack just prior. KASAN with stack instrumentation, or
> KMSAN, will flag the nla_put() when reproduced.
>
> Reproducer (unprivileged):
>
>     import socket, struct
>     IFLA_EXT_MASK   =3D 29
>     RTEXT_FILTER_VF =3D 1
>     s =3D socket.socket(socket.AF_NETLINK, socket.SOCK_RAW,
>                       socket.NETLINK_ROUTE)
>     s.bind((0, 0))
>     hdr  =3D struct.pack('=3DIHHII', 0, 18, 0x301, 0, 0)
>     ifi  =3D struct.pack('=3DBxHiII', 0, 0, 0, 0, 0)
>     attr =3D (struct.pack('=3DHH', 8, IFLA_EXT_MASK) +
>             struct.pack('=3DI', RTEXT_FILTER_VF))
>     msg  =3D hdr + ifi + attr
>     msg  =3D struct.pack('=3DI', len(msg)) + msg[4:]
>     s.send(msg)
>     data =3D s.recv(65536)
>     # Parse IFLA_VF_BROADCAST from the response. Bytes 7..32 of the
>     # broadcast[] field are uninitialised kernel stack on Ethernet.
>
> Fix
> ---
>
> Zero the on-stack struct before the partial memcpy, matching the
> existing pattern used for the other vf_* structs in the same
> function.
>
> Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
> ---
>
> Note for reviewers: this is v1. I have not yet identified the
> exact introducing commit for the Fixes: tag and would appreciate
> a pointer, or I will resend as v2 once I have run git blame on a
> local checkout. The bug is present at least as far back as the
> introduction of struct ifla_vf_broadcast in net-next.

Fixes: 75345f888f70 ("ipoib: show VF broadcast address")
>
>  net/core/rtnetlink.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1572,6 +1572,7 @@ static noinline_for_stack int
> rtnl_fill_vfinfo(struct sk_buff *skb,
>                 port_guid.vf =3D ivi.vf;
>
>         memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
> +       memset(&vf_broadcast, 0, sizeof(vf_broadcast));
>         memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
>         vf_vlan.vlan =3D ivi.vlan;
>         vf_vlan.qos =3D ivi.qos;
> --
> 2.43.0

