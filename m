Return-Path: <stable+bounces-181853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D82BA7DA5
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 05:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBA017AA7C
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F841FAC42;
	Mon, 29 Sep 2025 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTDH6ML5"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C8A34CDD
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759115441; cv=none; b=khau53p+hwh9pjHLBLL6hG40GHAKnS34XAySL5ginBVzCsrz94fQGk3CDXmFD3xI2RC/cU4YHMGFuph89snwXvy88g7Nu3HODowirfJ7iXXpd0Rp3uYd/yicML8yQnqa0thqS8FvMPyx+o76xMPeTnO4/p9jZgaAowL0E+VI1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759115441; c=relaxed/simple;
	bh=EgL93t+v/b5VUaY/UjRndyYq6w6fh1EJzoEH0ivDmjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAdvze80HvNlIeSwRRbHiA4zBdLOjugfqpIgq7aDHbLYS5zZdVwww06FT3IYskzG1ExT8QeTRBEJkwsNtVQpaXE1Bjby9oEeLUmvOPgYY1rrxxrS4Pqo9lU7ugG0UXw6mQQG1RjZMkq29AAiiI6yW9hebzfqI3DCGKYx+YrRBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTDH6ML5; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-9032edd72c1so383221039f.3
        for <stable@vger.kernel.org>; Sun, 28 Sep 2025 20:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759115439; x=1759720239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v92R9QHOHQCKwC3hoPp/stGf+4i5H2dlnzvul9kH3tQ=;
        b=NTDH6ML5PqSvTeGoMDsWgG7DsMTOMCf1RZY21kbwpyH4RS7mvQlJFCIxHoA6lZAJP9
         zXDkhJAg14J20nxJSyV2kD/bYjRb6NK8Kf7aIHiBKpHheX82gxMUARoSNom/4AN39ucF
         TbAE1fMJqrH9VW55Vb0LaMHBr6Fyf8BTiQjBkT2GCcynNvQ9iFAUWLqaF4Bfjw/CtnhF
         z/pLnjEckwNdRDe77j4vQOz5ux3UNJm1OKqfhXBv6+BOjkUUoMeLGODa+/lyLTxs73ZZ
         BSACE9/a7K5WD+SuuFVzFruVjGgYWh+Mq2IHfMhbS+bM5cHhl1RjUGK8pXFs6eWmQKuD
         bDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759115439; x=1759720239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v92R9QHOHQCKwC3hoPp/stGf+4i5H2dlnzvul9kH3tQ=;
        b=W921Tla6O2gG7Z2N5ilmHppeA+f5ocObSm96JxUByhxjlTa7UiY0woqlOKtvDtuZvs
         M/AOF5EcJSMA5RUGNAsNWYCRA6S9UmLCHM6xzUg8k37PxFtbpA7kH/uDtqq4xwnQY/g7
         ImzJ7Gs2v6a1FcjWa0VOpkfreGFFRqOo7oi2AkWxxNF/2RFO0+gQB69+iT8dqWO1iiZU
         zMAszBHXSUUEVkK8Z7NTD5cR47GDODsFWSAN925o8zziwlFkySMEQk8Xl3Dv3EdYk13F
         XLGMEgxPYT/77eSv8IPfIa3NhEqTGBiab9/FrNoEaI21jTFTv/wPHIaU9GXdsapVO0SM
         DDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxj64P+zFq8qnt6z66dMXKBNtAYKTL7oIs3U6ir5KzVdStH6kCvZhLCP2+No2ZzNCISkWk3lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPx8gdO7b2ipKO9aO+pXo9Ifxc0+lNfZ3kDLNiUCuERQrJPyjT
	JlGxr8YsgvEtn0Ypbj5alrSW+yFhvO1fMfMkdJHNxA9ZeGOtZTojxAlNEIyGgNqDi4QebHLxHZl
	8+ZHffOQEhoK/H8Q0eioQdw0kTCACTcX7QCn7Bw4zcA==
X-Gm-Gg: ASbGncvT+gKYew92UgUznvuyVrSYuG1vWzYPik2PSe1lAKvf4VmLUj4QZ3zdlmU5uWQ
	7GrWtARGdmX+MKfj96k31Ozm3qp6uTdXTCQeKf9df7TdUWSIH9ckzNt34erj0avUqrGXI+ulHEU
	3EwQkfnq/MIOhGlO7VcPVu5wFs6AhJO4zM9noAt9aYBDeFQOTdiJp/91niYe0jjXgpDyjDmQIL7
	+Aky2M=
X-Google-Smtp-Source: AGHT+IGjpj1wj47EeAJSU82CB46qp7vf388c3LWmyAchrsJCcP1YHQYxD0lyz5Yqba0r5JLLATT2eqAzLlMBJdjhikw=
X-Received: by 2002:a05:6e02:1fee:b0:424:7bb:775c with SMTP id
 e9e14a558f8ab-42c64fd0457mr8888345ab.31.1759115438927; Sun, 28 Sep 2025
 20:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929023419.3751973-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20250929023419.3751973-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 29 Sep 2025 11:10:02 +0800
X-Gm-Features: AS18NWCNQJ-UoXGm9Al3G8KPqzBXUoBbO39blAcPdgYhuvRNo3eQWxcctGzVVIc
Message-ID: <CAL+tcoCJf8gHNW9O6B5qX+kM7W6zeVPYqbqji2kMqnDNuGWZww@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] net/dccp: validate Reset/Close/CloseReq in DCCP_REQUESTING
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yizhou,

On Mon, Sep 29, 2025 at 10:34=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> DCCP sockets in DCCP_REQUESTING state do not check the sequence number
> or acknowledgment number for incoming Reset, CloseReq, and Close packets.
>
> As a result, an attacker can send a spoofed Reset packet while the client
> is in the requesting state. The client will accept the packet without
> verification and immediately close the connection, causing a denial of
> service (DoS) attack.
>
> This patch moves the processing of Reset, Close, and CloseReq packets
> into dccp_rcv_request_sent_state_process() and validates the ack number
> before accepting them.
>
> This fix should apply to stable versions *only* in Linux 5.x and 6.x.
> Note that DCCP was removed in Linux 6.16, so this patch is only relevant
> for older versions. We tested it on Ubuntu 24.04 LTS (Linux 6.8) and
> it worked as expected.
>
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

I believe DCCP has been removed by the following series:
commit 8bb3212be4b45f7a6089e45dda7dfe9abcee4d65
Merge: ba5560e53dac 235bd9d21fcd
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Apr 11 18:58:13 2025 -0700

    Merge branch 'net-retire-dccp-socket'

    Kuniyuki Iwashima says:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    net: Retire DCCP socket.

So I assume you probably target an older kernel? If you want to fix an
old kernel bug, please specify its exact kernel version and then add
the "Fixes: " tag to point out what commit causes the issue you're
faced with.

Thanks,
Jason

> ---
>  net/dccp/input.c | 54 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/net/dccp/input.c b/net/dccp/input.c
> index 2cbb757a8..0b1ffb044 100644
> --- a/net/dccp/input.c
> +++ b/net/dccp/input.c
> @@ -397,21 +397,22 @@ static int dccp_rcv_request_sent_state_process(stru=
ct sock *sk,
>          *           / * Response processing continues in Step 10; Reset
>          *              processing continues in Step 9 * /
>         */
> +       struct dccp_sock *dp =3D dccp_sk(sk);
> +
> +       if (!between48(DCCP_SKB_CB(skb)->dccpd_ack_seq,
> +                               dp->dccps_awl, dp->dccps_awh)) {
> +               dccp_pr_debug("invalid ackno: S.AWL=3D%llu, "
> +                                       "P.ackno=3D%llu, S.AWH=3D%llu\n",
> +                                       (unsigned long long)dp->dccps_awl=
,
> +                       (unsigned long long)DCCP_SKB_CB(skb)->dccpd_ack_s=
eq,
> +                                       (unsigned long long)dp->dccps_awh=
);
> +               goto out_invalid_packet;
> +       }
> +
>         if (dh->dccph_type =3D=3D DCCP_PKT_RESPONSE) {
>                 const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -               struct dccp_sock *dp =3D dccp_sk(sk);
> -               long tstamp =3D dccp_timestamp();
> -
> -               if (!between48(DCCP_SKB_CB(skb)->dccpd_ack_seq,
> -                              dp->dccps_awl, dp->dccps_awh)) {
> -                       dccp_pr_debug("invalid ackno: S.AWL=3D%llu, "
> -                                     "P.ackno=3D%llu, S.AWH=3D%llu\n",
> -                                     (unsigned long long)dp->dccps_awl,
> -                          (unsigned long long)DCCP_SKB_CB(skb)->dccpd_ac=
k_seq,
> -                                     (unsigned long long)dp->dccps_awh);
> -                       goto out_invalid_packet;
> -               }
>
> +               long tstamp =3D dccp_timestamp();
>                 /*
>                  * If option processing (Step 8) failed, return 1 here so=
 that
>                  * dccp_v4_do_rcv() sends a Reset. The Reset code depends=
 on
> @@ -496,6 +497,13 @@ static int dccp_rcv_request_sent_state_process(struc=
t sock *sk,
>                 }
>                 dccp_send_ack(sk);
>                 return -1;
> +       } else if (dh->dccph_type =3D=3D DCCP_PKT_RESET) {
> +               dccp_rcv_reset(sk, skb);
> +               return 0;
> +       } else if (dh->dccph_type =3D=3D DCCP_PKT_CLOSEREQ) {
> +               return dccp_rcv_closereq(sk, skb);
> +       } else if (dh->dccph_type =3D=3D DCCP_PKT_CLOSE) {
> +               return dccp_rcv_close(sk, skb);
>         }
>
>  out_invalid_packet:
> @@ -658,17 +666,19 @@ int dccp_rcv_state_process(struct sock *sk, struct =
sk_buff *skb,
>          *              Set TIMEWAIT timer
>          *              Drop packet and return
>          */
> -       if (dh->dccph_type =3D=3D DCCP_PKT_RESET) {
> -               dccp_rcv_reset(sk, skb);
> -               return 0;
> -       } else if (dh->dccph_type =3D=3D DCCP_PKT_CLOSEREQ) {       /* St=
ep 13 */
> -               if (dccp_rcv_closereq(sk, skb))
> -                       return 0;
> -               goto discard;
> -       } else if (dh->dccph_type =3D=3D DCCP_PKT_CLOSE) {          /* St=
ep 14 */
> -               if (dccp_rcv_close(sk, skb))
> +       if (sk->sk_state !=3D DCCP_REQUESTING) {
> +               if (dh->dccph_type =3D=3D DCCP_PKT_RESET) {
> +                       dccp_rcv_reset(sk, skb);
>                         return 0;
> -               goto discard;
> +               } else if (dh->dccph_type =3D=3D DCCP_PKT_CLOSEREQ) {    =
   /* Step 13 */
> +                       if (dccp_rcv_closereq(sk, skb))
> +                               return 0;
> +                       goto discard;
> +               } else if (dh->dccph_type =3D=3D DCCP_PKT_CLOSE) {       =
   /* Step 14 */
> +                       if (dccp_rcv_close(sk, skb))
> +                               return 0;
> +                       goto discard;
> +               }
>         }
>
>         switch (sk->sk_state) {
> --
> 2.34.1
>
>

