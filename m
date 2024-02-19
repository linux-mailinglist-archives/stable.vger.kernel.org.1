Return-Path: <stable+bounces-20622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5DE85A9D3
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E58E2883C8
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D24C44C8C;
	Mon, 19 Feb 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sL45fs6s"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A6446A5
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363328; cv=none; b=OHwn1/SgkZmRnDRcCGXKrp8lYBbNy4BobBKdwLUfIC4xp+3Z83p2Of3sl8u22OEYm3Bk89NvEMXRjeSQLppY57l/xaIrXuajbB/aKriwrY6P1w+QtcFelWJ1xQ5gcWdwDsVsyQ+Gl5F2Qdg6E0myaMDRuG5nulIYx39m2uhFKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363328; c=relaxed/simple;
	bh=D4hbJX7uGV8vohd/O7pYTtYq3FdJW6tASIcFVTSogHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGYzngy6JhxlfvY8bE+2xJ5dY44aJhfIZ7ZMDQy5f56k67qnxGO4NIARmzb1yXRDNQCPXhwLBh1xyAiABTJyN5XbAmwrmoLnJB4zGLI7n+p3sxJ37TM7x2eAkswPjzX9JGGNQXpU/+mHhNzvTAGXI1/rNdG30G5aKcGJWeqpudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sL45fs6s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso108575e9.1
        for <stable@vger.kernel.org>; Mon, 19 Feb 2024 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708363324; x=1708968124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzE2ImKo71OrGpPwUdYL/4pHbPBLfbVgHi0cr9m3U8k=;
        b=sL45fs6sLPjwI75d4uFu8XxABRB/V521bZaKwne7qpuU6wrVTEUIA4UD0hzj9EP1O8
         B1KKCZt+3VgGoF7Eo2IK+Ni47YoRntvhkFlPY+A30st5Hr1LZsE870leOriwliLFM4QA
         31E+8KBHTjFLEA+KJaLBmftERuQMO0lMH4rO1dbFlAFgXkw+cHn0FrNw8SCEU0nZGulC
         SwhH+okvFFFS5sgOktS/IHc3YZD6XDQ/hCp7YNUskEC815Xaf5V69Ae0BrsidNm/K/am
         V2+XY8s87cXVXfMS1wl6/JChlHQIJQT+srZdiZQmJw+uP/TycvNIHtGv37Skm41h4kit
         Ly3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363324; x=1708968124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzE2ImKo71OrGpPwUdYL/4pHbPBLfbVgHi0cr9m3U8k=;
        b=AGtW7cfL4qSg/bVf9PYk645UmwkIeLZMh/j9HCbThaolGwtP6NHx2Biwg1Sk6VL08s
         gJJFIM05H2EqSqsTZM2BQ4JX5mZ09Danls7v6HT0ssN7CEmpT749311Z4odJUp+t2fBq
         0XDF6hUMBjjYKkMFUJCAIOgGJFsPPd8bvvLE2EUZ+c51VMWQyjfQrsdNW4FELemmrrFh
         YIFUQFTI6Ea0aLf6Jtm2vRaJZL+aiOghJIjFU88b9UhGtiv4Dl4aaV9ISCo2hZJ2+Nwr
         H3s0kxNMuVrpXXieXRmc9VLRz6VhvagsY2MQTfFAh5AuweF0KSJv9nFRj5/i2DxcS4q6
         CMsA==
X-Forwarded-Encrypted: i=1; AJvYcCUrC7jQssRVuP4JtzTqVUU3+9UW4ZbY2jDygZ07dxYFDALlWy80Up1OKRsVDZOgo6p0TR3f+cKvMKCAap5Mvqb/cy+HXXz4
X-Gm-Message-State: AOJu0Yxb2hf6PMCb6F12Hwxia6OueD2mMdvEV4vW4Vq4k3/M7avLXf86
	BEGHpni+Zy9p0x6vZhFuex7ww40uYKBtXMnpFoyuO1Xsr8U3tbArFozbGFy0QpJW1HNAwf5mUz6
	+ciKdsMUFttcPgO9Go/BR0QEwSa0/OU7JdxxO
X-Google-Smtp-Source: AGHT+IFtUO3gJmAv9pg3NVlt8jW79fOGFR/YkJjU3AyGWJK7/hjLBpWxiTYoMfGOwmlNssRqFlRN3PKW2DohJYoHKeM=
X-Received: by 2002:a05:600c:c08:b0:412:68a7:913a with SMTP id
 fm8-20020a05600c0c0800b0041268a7913amr116160wmb.4.1708363323800; Mon, 19 Feb
 2024 09:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 18:21:52 +0100
Message-ID: <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:25=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> Since the introduction of the subflow ULP diag interface, the
> dump callback accessed all the subflow data with lockless.
>
> We need either to annotate all the read and write operation accordingly,
> or acquire the subflow socket lock. Let's do latter, even if slower, to
> avoid a diffstat havoc.
>
> Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - This patch modifies the existing ULP API. No better solutions have
>     been found for -net, and there is some similar prior art, see
>     commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info").
>
>     Please also note that TLS ULP Diag has likely the same issue.
> To: Boris Pismenny <borisp@nvidia.com>
> To: John Fastabend <john.fastabend@gmail.com>
> ---
>  include/net/tcp.h  | 2 +-
>  net/mptcp/diag.c   | 6 +++++-
>  net/tls/tls_main.c | 2 +-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index dd78a1181031..f6eba9652d01 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2506,7 +2506,7 @@ struct tcp_ulp_ops {
>         /* cleanup ulp */
>         void (*release)(struct sock *sk);
>         /* diagnostic */
> -       int (*get_info)(const struct sock *sk, struct sk_buff *skb);
> +       int (*get_info)(struct sock *sk, struct sk_buff *skb);
>         size_t (*get_info_size)(const struct sock *sk);
>         /* clone ulp */
>         void (*clone)(const struct request_sock *req, struct sock *newsk,
> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> index a536586742f2..e57c5f47f035 100644
> --- a/net/mptcp/diag.c
> +++ b/net/mptcp/diag.c
> @@ -13,17 +13,19 @@
>  #include <uapi/linux/mptcp.h>
>  #include "protocol.h"
>
> -static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
> +static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
>  {
>         struct mptcp_subflow_context *sf;
>         struct nlattr *start;
>         u32 flags =3D 0;
> +       bool slow;
>         int err;
>
>         start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
>         if (!start)
>                 return -EMSGSIZE;
>
> +       slow =3D lock_sock_fast(sk);
>         rcu_read_lock();

I am afraid lockdep is not happy with this change.

Paolo, we probably need the READ_ONCE() annotations after all.

