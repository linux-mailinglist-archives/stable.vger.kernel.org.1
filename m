Return-Path: <stable+bounces-146140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C1DAC17FF
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 01:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539FE3A9DB7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7328EC17;
	Thu, 22 May 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOLM68jo"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841328EBFD;
	Thu, 22 May 2025 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956392; cv=none; b=aezn/GR+AguVSRCk9YemMW8nHfh7U0gpYWNXQXf8feFsEbBbU5ZIokJ+5PE4kbsoZ/sUwnOU1Rw3tHI8oQIXDhhqsKHuqFy+w00DOZdHU456piNg1Y4uq8rV/ANamGpxhaEG7GylvpSgz4BmXuof3wZyp7QtkeE+xfFoCGYZAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956392; c=relaxed/simple;
	bh=HtJZ+i85YfOJD3byjWuHXG0i0Ijcj1yDYtpRFBah4QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqYZK/q4h/0p/V3o7SDe2Wymk1ul0P4IuZFgcCl3NWFXMBVVuB6G3YJ5QAQljhituJtEUPshdUxhFqCpDSI80kd/zbEpX6Lr+bftMVUHiufjHpJkeraA2plCaCpt+jNg6NwS+dc/pZ4esQcTIvNpJ51MgsUxwylj+godpJJHvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOLM68jo; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3dc83a8a4afso1371445ab.1;
        Thu, 22 May 2025 16:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747956389; x=1748561189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj4YiSobE0xmWBeu+7XdEF1aKl0NUS0ABAO2S6UMgqw=;
        b=lOLM68joeXbfkaQfko2EjdB/+5QSgBNbYQ7vmssQAbvhWiKZ1GlIpKXfOe54Y5lOYu
         la8k2HyaA73JZ4je2FyoDbjeKI3hTLqIDMDZCPQz+2zGf6CxTDELnWTnnFQLHWAz0M/u
         wGJO4Atwhj96ccFbNLzeOK4XVYdyR1Ip/MXz3+Zkv4pTECGPlXwm57X/3atr3YmT45wy
         KGdppnFJNsMdWPCFLuDW2EUcD78b6Hk+1mFNLMkdtQaMEZa0kJSaxJWTfaDEnO77W+e9
         VriaiDsew94MxtMSZZd8C1Uy81ukgafTAQHzGKKErwNEXesLax+v5ZqnzvxGRU7IxXrM
         QAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956389; x=1748561189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj4YiSobE0xmWBeu+7XdEF1aKl0NUS0ABAO2S6UMgqw=;
        b=DC8Zb82vJW4ECp5sxb/8+NPJxtJd3EMv+FAxtujLw5IJL4fghUTEylPXD9WzCvJgAT
         KV+1av+fhH+0iE9FBm1DRy36F49iqB3Sy2mF0M8TdViDmLUQQ/0JRgFwrs75mRkvjXRW
         CuQ02gH0LB/utM/xDH367jz33qPTrYnCSL9aKR/3+cQd8wnOOE++OhUHRDV/guiYaKjj
         noEXZUlNtMM3TKABr7bXPThGNpc3lf1wZJTCKqMB0J+CdcXonQaUcdkyXH93Ati153Yz
         bol528sW4ufJJgOYJISK2oga/kXzCB30/obmwPMTp16LqkZ2vN+3nixZRzYd3VT9+6gx
         NLzQ==
X-Gm-Message-State: AOJu0YxgEcpRgtR6HJkJCzoJN5e4Ah3gE4LdvzNDvtiNonON0XxLfgiI
	TtOdd03VumqP5em8rVts0uIGos3DiB1sdLCWxELd8Q3iXwE/00B0Vuug3bOoZWBdBZpabDUJrH2
	N1AIxGaaB6tc8Iz3wsTlH4VsRwkkWDFa92DHk
X-Gm-Gg: ASbGncvy4hZIdFjK99SoZlB77jZbw8Q0cXSDKC6DJvaML0sIoaTgTVDSoQAWRMYvLlC
	OFogjOdwL7SbvRe7l1SJawHCNx7CZvC5L7md16bHN3Ag1uSSnpwjy/h8lgvNAAhM8/uRY4kNjAB
	i1m7d4KIGEnHBI1oQhpGAI2G6On2gNQZE=
X-Google-Smtp-Source: AGHT+IFJlnizU9Nf+pPapKvm/jTQTkPK3blqmLOg2D/1oCo8blRpguaa9Mk3gQ7xofkTu0j+Rff86Kc1QOWmBbqoH9I=
X-Received: by 2002:a05:6e02:1c21:b0:3dc:7b12:b344 with SMTP id
 e9e14a558f8ab-3dc92bba844mr18583595ab.2.1747956389143; Thu, 22 May 2025
 16:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522231656.3254864-1-sashal@kernel.org>
In-Reply-To: <20250522231656.3254864-1-sashal@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 May 2025 07:25:53 +0800
X-Gm-Features: AX0GCFuSQMQk3wH-vDgRBZhwEdz0PfHRk3NV-7Ie2fJw9dCS_lQhFR9x0GukHns
Message-ID: <CAL+tcoBEGozJ1Zs2c0L-kG=ZTVfPGXdshQxs7nCxwr-NhZoUPw@mail.gmail.com>
Subject: Re: Patch "bpf: Prevent unsafe access to the sock fields in the BPF
 timestamping callback" has been added to the 6.1-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 7:17=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     bpf: Prevent unsafe access to the sock fields in the BPF timestamping=
 callback
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      bpf-prevent-unsafe-access-to-the-sock-fields-in-the-.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi,

I'm notified that this patch has been added into many branches, which
is against my expectations. The BPF timestaping feature was
implemented in 6.14 and the patch you are handling is just one of them.

The function of this patch prevents unexpected bpf programs using this
feature from triggering
fatal problems. So, IMHO, we don't need this patch in all the
older/stable branches:)

Thanks,
Jason


>
>
>
> commit 00b709040e0fdf5949dfbf02f38521e0b10943ac
> Author: Jason Xing <kerneljasonxing@gmail.com>
> Date:   Thu Feb 20 15:29:31 2025 +0800
>
>     bpf: Prevent unsafe access to the sock fields in the BPF timestamping=
 callback
>
>     [ Upstream commit fd93eaffb3f977b23bc0a48d4c8616e654fcf133 ]
>
>     The subsequent patch will implement BPF TX timestamping. It will
>     call the sockops BPF program without holding the sock lock.
>
>     This breaks the current assumption that all sock ops programs will
>     hold the sock lock. The sock's fields of the uapi's bpf_sock_ops
>     requires this assumption.
>
>     To address this, a new "u8 is_locked_tcp_sock;" field is added. This
>     patch sets it in the current sock_ops callbacks. The "is_fullsock"
>     test is then replaced by the "is_locked_tcp_sock" test during
>     sock_ops_convert_ctx_access().
>
>     The new TX timestamping callbacks added in the subsequent patch will
>     not have this set. This will prevent unsafe access from the new
>     timestamping callbacks.
>
>     Potentially, we could allow read-only access. However, this would
>     require identifying which callback is read-safe-only and also require=
s
>     additional BPF instruction rewrites in the covert_ctx. Since the BPF
>     program can always read everything from a socket (e.g., by using
>     bpf_core_cast), this patch keeps it simple and disables all read
>     and write access to any socket fields through the bpf_sock_ops
>     UAPI from the new TX timestamping callback.
>
>     Moreover, note that some of the fields in bpf_sock_ops are specific
>     to tcp_sock, and sock_ops currently only supports tcp_sock. In
>     the future, UDP timestamping will be added, which will also break
>     this assumption. The same idea used in this patch will be reused.
>     Considering that the current sock_ops only supports tcp_sock, the
>     variable is named is_locked_"tcp"_sock.
>
>     Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>     Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>     Link: https://patch.msgid.link/20250220072940.99994-4-kerneljasonxing=
@gmail.com
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f3ef1a8965bb2..09cc8fb735f02 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1319,6 +1319,7 @@ struct bpf_sock_ops_kern {
>         void    *skb_data_end;
>         u8      op;
>         u8      is_fullsock;
> +       u8      is_locked_tcp_sock;
>         u8      remaining_opt_len;
>         u64     temp;                   /* temp and everything after is n=
ot
>                                          * initialized to 0 before callin=
g
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 83e0362e3b721..63caa3181dfe6 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2409,6 +2409,7 @@ static inline int tcp_call_bpf(struct sock *sk, int=
 op, u32 nargs, u32 *args)
>         memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>         if (sk_fullsock(sk)) {
>                 sock_ops.is_fullsock =3D 1;
> +               sock_ops.is_locked_tcp_sock =3D 1;
>                 sock_owned_by_me(sk);
>         }
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 497b41ac399da..5c9f3fcb957bb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10240,10 +10240,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>                 }                                                        =
     \
>                 *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(                =
       \
>                                                 struct bpf_sock_ops_kern,=
     \
> -                                               is_fullsock),            =
     \
> +                                               is_locked_tcp_sock),     =
     \
>                                       fullsock_reg, si->src_reg,         =
     \
>                                       offsetof(struct bpf_sock_ops_kern, =
     \
> -                                              is_fullsock));            =
     \
> +                                              is_locked_tcp_sock));     =
     \
>                 *insn++ =3D BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);  =
       \
>                 if (si->dst_reg =3D=3D si->src_reg)                      =
         \
>                         *insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=
       \
> @@ -10328,10 +10328,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>                                                temp));                   =
     \
>                 *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(                =
       \
>                                                 struct bpf_sock_ops_kern,=
     \
> -                                               is_fullsock),            =
     \
> +                                               is_locked_tcp_sock),     =
     \
>                                       reg, si->dst_reg,                  =
     \
>                                       offsetof(struct bpf_sock_ops_kern, =
     \
> -                                              is_fullsock));            =
     \
> +                                              is_locked_tcp_sock));     =
     \
>                 *insn++ =3D BPF_JMP_IMM(BPF_JEQ, reg, 0, 2);             =
       \
>                 *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(                =
       \
>                                                 struct bpf_sock_ops_kern,=
 sk),\
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index db1a99df29d55..16f4a41a068e4 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -168,6 +168,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, stru=
ct sk_buff *skb)
>         memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>         sock_ops.op =3D BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
>         sock_ops.is_fullsock =3D 1;
> +       sock_ops.is_locked_tcp_sock =3D 1;
>         sock_ops.sk =3D sk;
>         bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
>
> @@ -184,6 +185,7 @@ static void bpf_skops_established(struct sock *sk, in=
t bpf_op,
>         memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>         sock_ops.op =3D bpf_op;
>         sock_ops.is_fullsock =3D 1;
> +       sock_ops.is_locked_tcp_sock =3D 1;
>         sock_ops.sk =3D sk;
>         /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect =
*/
>         if (skb)
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 40568365cdb3b..2f109f1968253 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -509,6 +509,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, st=
ruct sk_buff *skb,
>                 sock_owned_by_me(sk);
>
>                 sock_ops.is_fullsock =3D 1;
> +               sock_ops.is_locked_tcp_sock =3D 1;
>                 sock_ops.sk =3D sk;
>         }
>
> @@ -554,6 +555,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, =
struct sk_buff *skb,
>                 sock_owned_by_me(sk);
>
>                 sock_ops.is_fullsock =3D 1;
> +               sock_ops.is_locked_tcp_sock =3D 1;
>                 sock_ops.sk =3D sk;
>         }
>

