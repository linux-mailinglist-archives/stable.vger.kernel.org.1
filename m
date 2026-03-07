Return-Path: <stable+bounces-223409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOVkEfWbq2kJewEAu9opvQ
	(envelope-from <stable+bounces-223409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:31:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA82229EDB
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0478307D619
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3982288D5;
	Sat,  7 Mar 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEXcuYIj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A230EF9B
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854207; cv=pass; b=dgJvF+nN/X5y7IKyHU3/VNN+W3Bh9oEWwOKJQicPbyH7m5BE4ksC7nttuEWpy9hPhLKvDRKERCb94ijrr2WO/du8o13E1jNEHXxMki84r563ULSFtrwpeOlSltVtoTZQma5lVPFKcrEvLOWfYAc6Ys0yhwIAwWyJPFZ75x8N//0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854207; c=relaxed/simple;
	bh=dvoJq25OvpD/Xk60DBZSv4vLrYpQuuw6VA1VafjxT34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHpUg8Un0mUIR2aykAf7wM+HTQ4/Pcgs6AsURDFn81XkquSr7hbipqQEYkC9PjRi4LwAPQF5WJdl3hK40jx12DGiBzbC4FKEThWIJDqY05pzqP2vKM0zD3u70pSAbdrPR0WGkwhRPhaFU4zGZQskfiN2/MqgXnZYcyOev+NdSUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEXcuYIj; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506c00df428so82554351cf.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 19:30:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772854204; cv=none;
        d=google.com; s=arc-20240605;
        b=XQLoZvhmw9CTVS+w92rFVxpTRlOlrlZEpjW4j9lh+8tollOPSWug1d0NcEGxgIOsn6
         zQ6TmgiIpz7dqTJBSv1INDbLrdU9VROhSWRzwHe0xE7TEJSALb3TVJIwzV7n7LY2PtuK
         8qqbznTO/NjOCR+Dyicvj7fR4Gi9vWFnCRgZthtgYWptiOiam02P5DM4Th3EzvVlakuO
         eKnobKOPzmUK9zvpM0c0DREWhyLrjxxdIXKJADQ+0QloA4VFOlpC+i4mX5MtItqpl7VV
         96RVUGnXsHfz1TsQ/Hae3aVDCwYhhjoYOeoTy2oJkr7NgYfhizhcVEXwqwswAfU1D2+J
         5X0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xpDD14e4dbjVApZRVlBhM6AVpHA7sjMepTKpcHbSpv8=;
        fh=CtWBWCQ9SBJbCou68U3+UQCKC9Jg/KKQCUGulMa3eD0=;
        b=kPEHcUBlu3xkIege44tScnotQNcRuu3gPTisMSIR1s0eOmkCickVbf4IuSumbdWK+E
         x3GIlJSBVdJK803JB1TiCXUdQmf2ZpWxsnj5wZcrHIDrgje5yeb+HIoofwUXXz4WLWEp
         PxCJMyK2/y0C0xMC05/SkHYl1E8juTR6nejZFuTyPjuIcWyXxrXdIEcDIwYhx9fitGFE
         oldeNuRfHQM2Cv4XF2lP7eZI57cbc2qFc8CCKIHkaYUa9/NFvWkj0WnONr8x7T1ojxcJ
         PUchzURZVGpygcA8uZtNuhsWP6lytOB5YTlAdjj8TO41h0HD5W3e8CFtbb7qDLfBWMLx
         FxEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772854204; x=1773459004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpDD14e4dbjVApZRVlBhM6AVpHA7sjMepTKpcHbSpv8=;
        b=oEXcuYIjPsQRRMvWi0u8aQ4DPSWQihS70VnJ8w0N+fSyOUNZuI/Rq0KOZ6qagTkTrl
         RBiQWuKAmNze1si9XO/f0wZxhyNjf5cQr6db+h3ECma8xDJp3Zp0cHDxhRNRBARO3FyV
         rq4mys1SlHSHGM6pI+AYdSpUcuAJZS+6jYOhaXiKbjf7HLOfWVlSactBBcYw0Z4CSfqA
         48cx+r9PZTKXMnF0G6AjCC8taRmEGthIVFolQZkaqOzPNShzoiH2s5OTmqKxu3KrEiXT
         iwX4s9y7UXSgD9RQx7OP+Q9BPs/p09dZJkOorPTn0pFibYv4hBwSdrD4qjixe5AgQWuc
         nddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772854204; x=1773459004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpDD14e4dbjVApZRVlBhM6AVpHA7sjMepTKpcHbSpv8=;
        b=Mv2OIcuIhhy5KRcY8FpNykskHsVUcDXJ5HZEZNu5Xfg5drwsefHb5wtDRxJD5ftq39
         VdhpEJSFGX4f0xxIc4zt0+e4L106Kd3GzjdKB7iaHQCBIohkEM0ydjLLgEUX0eSHjgrQ
         8hlerRy2iO+LFPGh5E089qNOnKgN1FNVLNgeU7YP381GSjK6+ck4aKMLGIHYPjov7FQK
         3OaQAzVV6UcmUctOqftKUnyutzOvOar0TQNFsdsRsb2eWUr//zPP1mQc4EKCJ1Dog4E3
         +EkCuNi8fYTQNPi3zP2erOOaAi/uJtD3zzqtIrgjt97e5DQxvjuzGjRWTbMagYcDjIAp
         PHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzVVrk+QtgQ7yg+NgYVDPJsqvq/j3TTe6sEEv8XNJ4TySuM0QTNb3cvF9Gpy9JeyKvLqxLqJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp2J+XCWvsMwIodGNwcpU9qIXBG17U0Y0DlRuv783W247c7Uti
	e+fz+NID0OqQRuvCbPwE+Sw5/ClQvCPsSazev+bYXHw6CQs4oVP7UQWQQIZjlPisfm4bEF+7bMs
	Jiv+CBZGhqQNI0v1CLaab3CSIoWkdSKcec674ABcK
X-Gm-Gg: ATEYQzwiTv6Rz3TS5NuA9UmuEjAqxPh0dpvrX9eS8xfVon1GhzPiHrs5TfSpA+MKjWa
	C/zPk8LHgjgh3CgAHbJsobZr4t9UYyepc5/sql2IaQv1L5wL+W2OF61QZhi7MUkr2/7bm4fAFha
	8EBKcsnSOybp0kbWVEBuDad6mbZlXYC75dtkek0moBykqpbnH6vAflk+rCxuMgQT3Eq+R/q8bDW
	yete2OliAwREwImO2OXQmC/vLV7y9NUuQRbYIAj4DbZKqZ3uYMVhBbmYly08wau8nyWx0TILSQS
	VbTw3rC5KJEJQsNwnpg=
X-Received: by 2002:ac8:7f47:0:b0:506:a43d:778f with SMTP id
 d75a77b69052e-508f4908ed0mr56284151cf.34.1772854203826; Fri, 06 Mar 2026
 19:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306185005.22120-1-mehulrao@gmail.com>
In-Reply-To: <20260306185005.22120-1-mehulrao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 04:29:52 +0100
X-Gm-Features: AaiRm52j54ex_mqVI2RoTx84B4nBaTH85pbob3IqxXcFMgge_tbsq8gKtlrBBik
Message-ID: <CANn89iJA_rchh5mhRpLVgt8hN1q1NKA4WZ9OaixLngJZSCmOjg@mail.gmail.com>
Subject: Re: [PATCH net v2] tipc: fix divide-by-zero in tipc_sk_filter_connect()
To: Mehul Rao <mehulrao@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ying.xue@windriver.com, tung.q.nguyen@dektech.com.au, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BDA82229EDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223409-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 7:50=E2=80=AFPM Mehul Rao <mehulrao@gmail.com> wrote=
:
>
> A user can set conn_timeout to any value via
> setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a
> SYN is rejected with TIPC_ERR_OVERLOAD and the retry path in
> tipc_sk_filter_connect() executes:
>
>     delay %=3D (tsk->conn_timeout / 4);
>
> If conn_timeout is in the range [0, 3], the integer division yields 0,
> and the modulo operation triggers a divide-by-zero exception, causing a
> kernel oops/panic.
>
> Fix this by clamping conn_timeout to a minimum of 4 at the point of use
> in tipc_sk_filter_connect().
>

Could you please add symbols to the following trace, using
scripts/decode_stacktrace.sh ?

Thanks.

> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
> RIP: 0010:tipc_sk_filter_rcv+0x1b99/0x3040
> Call Trace:
>  tipc_sk_backlog_rcv+0xe4/0x1d0
>  __release_sock+0x1ef/0x2a0
>  release_sock+0x55/0x190
>  tipc_connect+0x140/0x510
>  __sys_connect+0x1bb/0x2e0
>
> Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>
> ---
> Changes in v2:
> - Clamp conn_timeout at the point of use in tipc_sk_filter_connect()
>   instead of rejecting small values in tipc_setsockopt()
> - Link to v1: https://lore.kernel.org/netdev/20260305215336.645186-1-mehu=
lrao@gmail.com/
> ---
>  net/tipc/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index 4c618c2b871d..9329919fb07f 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -2233,6 +2233,8 @@ static bool tipc_sk_filter_connect(struct tipc_sock=
 *tsk, struct sk_buff *skb,
>                 if (skb_queue_empty(&sk->sk_write_queue))
>                         break;
>                 get_random_bytes(&delay, 2);
> +               if (tsk->conn_timeout < 4)
> +                       tsk->conn_timeout =3D 4;
>                 delay %=3D (tsk->conn_timeout / 4);
>                 delay =3D msecs_to_jiffies(delay + 100);
>                 sk_reset_timer(sk, &sk->sk_timer, jiffies + delay);
> --
> 2.53.0
>

