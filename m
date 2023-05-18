Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3486707D80
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 12:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjERKCv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 18 May 2023 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjERKCt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 18 May 2023 06:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9F1716
        for <stable@vger.kernel.org>; Thu, 18 May 2023 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684404119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xz4Yzk1FbN4lslQ/05ZU71kF3vRpTJyBu6xKqFUISCQ=;
        b=csLqAO0YmwvtdEUP3xhKZFPit+DxTxnoZzVfaE+gPrgOegRmqPaUnt9dAgSPWHfpAk5o9r
        pP2QUeCHbBPyyJoYa4zN3/QMnSTG6lRe1S2m12p0FopVG2GI53pfrSj3MLArJXXTi4JiVt
        X8KNQrUEG+I1S1Jt+9L1JiteEPweyDs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-GVCPk_59M6ebSFLN6H8QLA-1; Thu, 18 May 2023 06:01:57 -0400
X-MC-Unique: GVCPk_59M6ebSFLN6H8QLA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f393bf5546so3709091cf.1
        for <stable@vger.kernel.org>; Thu, 18 May 2023 03:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684404116; x=1686996116;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz4Yzk1FbN4lslQ/05ZU71kF3vRpTJyBu6xKqFUISCQ=;
        b=bcEsa5LRnCKbitfRvXZFo1YONtklr3K1DZAD+if3RdiwSGK4K6x0GRKd4NpB+V+iJk
         UaH2e95ACZ1s6ThaKXEKAJx9J6BLiVdpyurwpCBnwZtsCoKt+wj9A2X9mVIHJUK1KsJl
         JMlUtKfMMVn6KknZspoPJA+/ZRl8tP047k1aGQmO86lPPs1gFnUYBb0bQg/vHKH8Ozjj
         8BBvpFzlRKRmUgUo+rFSvuTrxw5bRiDjrnjj+xRVcKdDwy5PxcUs3MuWm16lhzjHP204
         VJV84cNgwf+Ai7YwznCEd510MlqeBi2VRYEQ/XON5bVSVPAr0YM+dN+pZFPafs9Ulezo
         5trA==
X-Gm-Message-State: AC+VfDzqixplDB1BkaZT8nJlJPZP868Hzbsya+/RLOni2pNR36Ty7p4b
        fRygiLGJac3AUYGe+2s54WoMbsfcFnCvQH8xV4KQ2Gy2XXu7YPML2qm0Lfdu+VTN0Lt8QFsMTCH
        anaMS28sdXynPgFMwjJXeI4ds
X-Received: by 2002:a05:622a:189e:b0:3f5:99e:d7d4 with SMTP id v30-20020a05622a189e00b003f5099ed7d4mr9400525qtc.1.1684404116575;
        Thu, 18 May 2023 03:01:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/bpXzMPMDK+f3opJ5CCYN/HiKqJEukqR71H+bovs37wm592r0+VAIa6EG/igPOZa2glSuZA==
X-Received: by 2002:a05:622a:189e:b0:3f5:99e:d7d4 with SMTP id v30-20020a05622a189e00b003f5099ed7d4mr9400499qtc.1.1684404116281;
        Thu, 18 May 2023 03:01:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-175.dyn.eolo.it. [146.241.239.175])
        by smtp.gmail.com with ESMTPSA id u5-20020ae9c005000000b0074df51a90b6sm291106qkk.60.2023.05.18.03.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:01:55 -0700 (PDT)
Message-ID: <0d282eb6626010afa117ca2f4162d2c147746dc1.camel@redhat.com>
Subject: Re: [PATCH RESEND net] ipv{4,6}/raw: fix output xfrm lookup wrt
 protocol
From:   Paolo Abeni <pabeni@redhat.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Steffen Klassert <klassert@kernel.org>, netdev@vger.kernel.org,
        stable@vger.kernel.org
Date:   Thu, 18 May 2023 12:01:52 +0200
In-Reply-To: <20230516201542.9086-1-nicolas.dichtel@6wind.com>
References: <20230516201542.9086-1-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 2023-05-16 at 22:15 +0200, Nicolas Dichtel wrote:
> With a raw socket bound to IPPROTO_RAW (ie with hdrincl enabled), the
> protocol field of the flow structure, build by raw_sendmsg() /
> rawv6_sendmsg()),  is set to IPPROTO_RAW. This breaks the ipsec policy
> lookup when some policies are defined with a protocol in the selector.
>=20
> For ipv6, the sin6_port field from 'struct sockaddr_in6' could be used to
> specify the protocol. Just accept all values for IPPROTO_RAW socket.
>=20
> For ipv4, the sin_port field of 'struct sockaddr_in' could not be used
> without breaking backward compatibility (the value of this field was neve=
r
> checked). Let's add a new kind of control message, so that the userland
> could specify which protocol is used.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> CC: stable@vger.kernel.org
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>=20
> The first version has been marked 'Awaiting Upstream'. Steffen confirmed
> that the 'net' tree should be the target, thus I resend this patch.
> I also CC stable@vger.kernel.org.
>=20
>  include/net/ip.h        |  2 ++
>  include/uapi/linux/in.h |  1 +
>  net/ipv4/ip_sockglue.c  | 15 ++++++++++++++-
>  net/ipv4/raw.c          |  5 ++++-
>  net/ipv6/raw.c          |  3 ++-
>  5 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/net/ip.h b/include/net/ip.h
> index c3fffaa92d6e..acec504c469a 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -76,6 +76,7 @@ struct ipcm_cookie {
>  	__be32			addr;
>  	int			oif;
>  	struct ip_options_rcu	*opt;
> +	__u8			protocol;
>  	__u8			ttl;
>  	__s16			tos;
>  	char			priority;
> @@ -96,6 +97,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipc=
m,
>  	ipcm->sockc.tsflags =3D inet->sk.sk_tsflags;
>  	ipcm->oif =3D READ_ONCE(inet->sk.sk_bound_dev_if);
>  	ipcm->addr =3D inet->inet_saddr;
> +	ipcm->protocol =3D inet->inet_num;
>  }
> =20
>  #define IPCB(skb) ((struct inet_skb_parm*)((skb)->cb))
> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> index 4b7f2df66b99..e682ab628dfa 100644
> --- a/include/uapi/linux/in.h
> +++ b/include/uapi/linux/in.h
> @@ -163,6 +163,7 @@ struct in_addr {
>  #define IP_MULTICAST_ALL		49
>  #define IP_UNICAST_IF			50
>  #define IP_LOCAL_PORT_RANGE		51
> +#define IP_PROTOCOL			52
> =20
>  #define MCAST_EXCLUDE	0
>  #define MCAST_INCLUDE	1
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index b511ff0adc0a..ec0fbe874426 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -317,7 +317,17 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg=
, struct ipcm_cookie *ipc,
>  			ipc->tos =3D val;
>  			ipc->priority =3D rt_tos2priority(ipc->tos);
>  			break;
> -
> +		case IP_PROTOCOL:
> +			if (cmsg->cmsg_len =3D=3D CMSG_LEN(sizeof(int)))
> +				val =3D *(int *)CMSG_DATA(cmsg);
> +			else if (cmsg->cmsg_len =3D=3D CMSG_LEN(sizeof(u8)))
> +				val =3D *(u8 *)CMSG_DATA(cmsg);

AFAICS the 'dual' u8 support for IP_TOS has been introduce to cope with
asymmetry WRT recvmsg(). Here we don't have (yet) the recvmsg counter-
part, and if/when that will be added we can use the correct data type.

I think we are better off supporting only int, as e.g. IP_TTL does.

Side note, the above code could be factored out in an helper to be used
both for IP_PROTOCOL and IP_TTL (possibly in a net-next patch).

Thanks!

Paolo

