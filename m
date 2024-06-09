Return-Path: <stable+bounces-50055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E54A9016FE
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 18:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA555B20FD4
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C123847A60;
	Sun,  9 Jun 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI3XBIbW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112342230F;
	Sun,  9 Jun 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717950608; cv=none; b=FxobSX/nIcJlYNLE53d3KYyoZT8MIoRL4fZ8OPeUgTk16ptbGY7NQgJHkug5iCHdxFq2gs/XzhKG9wr6tsS1+9ogpItBxAm62iXEuVJCfODZHqQJvYEr9JYMas1U2B92lwZg5/+esF3etuf706vSKTqP44m7EsVeH7RPyB3TMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717950608; c=relaxed/simple;
	bh=N66cO1s+WqUulUht0vyqX3t/6zdqQj9W39CF0jOCJkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtsAhcR8qAYqxmWyzeyWH3HvBiJaP1VOni5rFxVD0kjTXZo8lENM6Oo4UfNhNFEGstKqUmHV+nldhZay0t6nCeJ2Sk6440lFN5BABXSUzcpar+g6efo8UOm1R4ftHK2NHuCsRfTvcXj/Udl/nOvqL71iP2fP/XpyQMC5Nc0uG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI3XBIbW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7955186e796so4560985a.3;
        Sun, 09 Jun 2024 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717950606; x=1718555406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TF7YavKalGLEiJlQ7xFhH0uBmMREnW8y1VUFULiv4I4=;
        b=WI3XBIbWjCrt/32V+V3v8qUpntDJRT2J9jVmVuNiScLm9BWdcv83gVXLTlGcdjcwbp
         jTEH7UNOdUw/JBdfmCvjelKrvfFuIIfn4OUeqbsWyZ9/B6xZ3lyNAUPAvZGxyh++nmEH
         shyO8SXJWfOeu9NVLR49ba2lWcm5K4ttX98+IOfOmZDtMQyMFBgLvnWZu7IcrTuHzaI9
         urVu/8q+47bVUBzuahCZ1LK69ogEvFE1HWwLXd40W1jzZLSkGqgO9Xz/innH4a9beMWr
         VYc8mKfThyQBZX9Tg9WLYQrQJ0DKLLX5hoDySCYWPKY/7/SH0qOAcdwyG5yqrzptXY6A
         mi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717950606; x=1718555406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TF7YavKalGLEiJlQ7xFhH0uBmMREnW8y1VUFULiv4I4=;
        b=QZ3ZYpRqD8PqJzTZhYIlj8XiSvvpQt0ytcGDc/m193MTjR/Kzor2Gf922hEFw1Q1PO
         9XzD6xu+7ToHwcvnjQA00MujadNnEM89aGk18ow8UBRWt1Mq9enD2KaIiKIvA/a+7DHh
         v/beeegIqxWhSytlHGMgo72q7nR++nFujsaBa4Z17m+wlUYGtybAwxFdS5a7UxlmQrzX
         RMKDRAU3X+3bjmbH/pTnV/G9n7xQTbqAqlIk5vtYBvHtLWvqkUQARl+IBdL9xlCUBEh8
         Eh18mBgYHagvG/PdOFLcsZdNC1W59/iS1ybvbu2pX/eaM12rMI0e6LzcGuJOCwb+b/A8
         /S8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv554tiTSndz2gQVZLtjVISuC5yIHx8D+wDPlexyLQpQIiOrGhtFVdbcHXhSjD/yuyf41xIVATrXsm7EA+hkK10gAK420T
X-Gm-Message-State: AOJu0YxCdxb2MAI+PjrTeRtn6gGKHXPoGW4Df9mMziQ9Q8F/Kz1sYTh3
	DxHCw9TCgHtV59JMXG6JOay3KKjJ/9sVr8tMA9c3PmUqVGDfJpUkzbyu7bYMVlC44jabKuQWGzA
	fnwTu1BGm2u2meuDanVQdn1ButVo=
X-Google-Smtp-Source: AGHT+IG6BkY7CqMlCxmzceKgSHInDK6S4FTmtCyPQmGZpUdtneJNd79jnGzDxCtGBlO4b+mR8u2gnc0L/XA3QT45UJk=
X-Received: by 2002:a05:620a:2681:b0:793:325:d05d with SMTP id
 af79cd13be357-7953c182583mr810402785a.0.1717950605734; Sun, 09 Jun 2024
 09:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
 <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
In-Reply-To: <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
From: =?UTF-8?Q?Timo_Schr=C3=B6der?= <der.timosch@gmail.com>
Date: Sun, 9 Jun 2024 18:29:54 +0200
Message-ID: <CAGew7BvnxmmeoZqzETgCrSsVKU96tV+pe1DKn5r+QEsXguc1kw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix connection setup in l2cap_connect
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com, 
	regressions@leemhuis.info, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Pauli,

well done! This patch fixes the issue. Thank you.

Best regards,
Timo


Am So., 9. Juni 2024 um 17:06 Uhr schrieb Pauli Virtanen <pav@iki.fi>:
>
> The amp_id argument of l2cap_connect() was removed in
> commit 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
>
> It was always called with amp_id == 0, i.e. AMP_ID_BREDR == 0x00 (ie.
> non-AMP controller).  In the above commit, the code path for amp_id != 0
> was preserved, although it should have used the amp_id == 0 one.
>
> Restore the previous behavior of the non-AMP code path, to fix problems
> with L2CAP connections.
>
> Fixes: 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     v2: do the change in the actually right if branch
>
>     Tried proofreading the commit, and this part seemed suspicious.
>     Can you try if this fixes the problem?
>
>  net/bluetooth/l2cap_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c49e0d4b3c0d..aed025734d04 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4011,8 +4011,8 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>                                 status = L2CAP_CS_AUTHOR_PEND;
>                                 chan->ops->defer(chan);
>                         } else {
> -                               l2cap_state_change(chan, BT_CONNECT2);
> -                               result = L2CAP_CR_PEND;
> +                               l2cap_state_change(chan, BT_CONFIG);
> +                               result = L2CAP_CR_SUCCESS;
>                                 status = L2CAP_CS_NO_INFO;
>                         }
>                 } else {
> --
> 2.45.2
>

