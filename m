Return-Path: <stable+bounces-95324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE889D77DC
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 20:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F66B337A1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65813A244;
	Sun, 24 Nov 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/YNqgmp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBE84039
	for <stable@vger.kernel.org>; Sun, 24 Nov 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470514; cv=none; b=GDn4043+M6Xo7kKb+kXnD6LCfA241vGepLIheFmhCdY2E5qvX+QMTJt4f2gPeRhs6VgXtWm2Lm2PBnX6aK5NwlTPxXgpJJOSdhbfbGBf+ufYSUTheyOHKlNzE32ZJMjxft95JELVN32axDz8eYKBIayR23yzbNRQuRH8l4QjiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470514; c=relaxed/simple;
	bh=KAc+dxrgpbfHlVdExuNbNzAS8bmSU5jj7rjkS12Fa48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rsf6n/DeBG8xJaAMy//+dTytOQCV7BolUU1+xOob268Vd7EqF3K94enu1E9c71kyTgfW6Rj+rM5JgWWcwW0ko1ayW5KGZhoCG0PfWE2Bx3kX4wMub1aXl+O9g0c0Wskg/G++Nh/WBDLqXVVcRdPy/+/FR/VydRNXgIsUw6VU93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/YNqgmp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so4373571a12.2
        for <stable@vger.kernel.org>; Sun, 24 Nov 2024 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732470510; x=1733075310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGO/u8jkL1cPeJfFI/uj7V1Q/Nu6nCu/n1Un400nmR4=;
        b=F/YNqgmp7+DNPp11b2tiDm7D8Mn9hCMEonDz1RR9IDB3RiYcre1Ehh/2C51d6DVwpe
         3LKort7VMiynZ8ILSAMuWr2otwcAmn+X1GKSb0dOqnVgO/9c4xDiZML4iSNnSigRuiO+
         EEFNoorruDGZYGDQ/wmmyFAv3iGMkH8VZ5xNYTftjxKT6Mxyc0TzMA7pGj54DbnWGHPo
         fyX+v0QG8vBi1OMXxLTwo6BMAc11MhupzV+688t/rN93zIaWgNfsTjhMOd9kfbn7XMNV
         y+8TX2MnHWwnDIZ9ofS/fUOcQvRofpJGhJNpdGGBWLgQaEhii88BtpcUssArOdekrJ+H
         AsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732470510; x=1733075310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGO/u8jkL1cPeJfFI/uj7V1Q/Nu6nCu/n1Un400nmR4=;
        b=mKxe/UqBP4Jdl0FjUqxhda35lT0pqjvL4ja5LlQy9uycib2uCfToODqIwoSFSTXg2g
         rdmyuKO2vxH8jO7S94aIidXFWMMTWU5MU0KQmuWulUM7IzqS0e89onMPHMoorbgBSS2Y
         W65hcMX+oMTaqbdj2tEzkJFpPk1YOPyxxAdPQQEN4LEiY+ecShaXcjbKtbNH9qBfsnw5
         X9piPzbO9Ip2tyNXOcL/zbKoWCYE7BmmSQpncJabud8FZXRCMIcDTikwSyR/LBjOHBL0
         h05JaNECwNWr05h5zezIVOrKBOegMl8NNUodXMB3Zo38jrzBeQHmiEy+AQndMjSFuuHm
         Y5oA==
X-Forwarded-Encrypted: i=1; AJvYcCVxq3gJEeXg4VTqp9mNK9VukkoGkym8UMjax2hKB2JgZZfQ+9jBUitr6I5da78CwhfiEmlHIVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pKR/Ivv55taEe7e7aEHQRITR4lGwcs9dzCnYU0g32UVb+dWH
	tGNrVtwxO6Bw3PbmG6RG7kjvCkqtgDeX0zDTkkelvg+ICOeRqxYWpezWjPiAEGznLMvE7n5Zogt
	E2WVnGqSupp9+Cdgam0eKZjvD1gzCcSCy+NVCy3vFeHn5kbCU2UuA
X-Gm-Gg: ASbGncv+iqpfREV0jNBFkxK1VupTDrflIEloJTtNX4bKqpils5Qcu+rPmR4K5XbE1Du
	CLV05mQdQ93Mk/f0OZzxXM/imts6PxQ==
X-Google-Smtp-Source: AGHT+IGR78Yp3E74KyUdMeZXImBCNnCQHFfKf3xLMrONhL4PNULfNvPd5JfgYvuW5T+rOTZfTB9T/fjwf64Ysz6MR8M=
X-Received: by 2002:a17:906:3101:b0:a9a:dc3:c86e with SMTP id
 a640c23a62f3a-aa50990b1aamr890279866b.11.1732470510131; Sun, 24 Nov 2024
 09:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124022148.3126719-1-kuba@kernel.org>
In-Reply-To: <20241124022148.3126719-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 24 Nov 2024 18:48:18 +0100
Message-ID: <CANn89iKCzrZgW1jKLDmkRKpMnK3upw0whRAcqdtF5f07D2i7HQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net_sched: sch_fq: don't follow the fast path if
 Tx is behind now
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	stable@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 3:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Recent kernels cause a lot of TCP retransmissions
>
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  2.24 GBytes  19.2 Gbits/sec  2767    442 KBytes
> [  5]   1.00-2.00   sec  2.23 GBytes  19.1 Gbits/sec  2312    350 KBytes
>                                                       ^^^^
>
> Replacing the qdisc with pfifo makes retransmissions go away.
>
> It appears that a flow may have a delayed packet with a very near
> Tx time. Later, we may get busy processing Rx and the target Tx time
> will pass, but we won't service Tx since the CPU is busy with Rx.
> If Rx sees an ACK and we try to push more data for the delayed flow
> we may fastpath the skb, not realizing that there are already "ready
> to send" packets for this flow sitting in the qdisc.
>
> Don't trust the fastpath if we are "behind" according to the projected
> Tx time for next flow waiting in the Qdisc. Because we consider anything
> within the offload window to be okay for fastpath we must consider
> the entire offload window as "now".
>
> Qdisc config:
>
> qdisc fq 8001: dev eth0 parent 1234:1 limit 10000p flow_limit 100p \
>   buckets 32768 orphan_mask 1023 bands 3 \
>   priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 \
>   weights 589824 196608 65536 quantum 3028b initial_quantum 15140b \
>   low_rate_threshold 550Kbit \
>   refill_delay 40ms timer_slack 10us horizon 10s horizon_drop
>
> For iperf this change seems to do fine, the reordering is gone.
> The fastpath still gets used most of the time:
>
>   gc 0 highprio 0 fastpath 142614 throttled 418309 latency 19.1us
>    xx_behind 2731
>
> where "xx_behind" counts how many times we hit the new "return false".
>
> CC: stable@vger.kernel.org
> Fixes: 076433bd78d7 ("net_sched: sch_fq: add fast path for mostly idle qd=
isc")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

