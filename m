Return-Path: <stable+bounces-59203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48C92FEAC
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BA71F22B77
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2B176AB0;
	Fri, 12 Jul 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yDEJKAva"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7FA174EC3
	for <stable@vger.kernel.org>; Fri, 12 Jul 2024 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802196; cv=none; b=M+mqjXHJwJDyw5cqbpEO504mV6l0PH5ck5HnuJQ3HCe2LhbrKtPbNi2pi53ewWNFHXmsEdZJ6OLyMNWzErV4gWNV6KRInztS2Ew4DCybqDAXZrlqlIrLHp8XCfxPQmLUA9gs7cijh2Wp4qrFZPCanS6ll3gNlJSDktEh4aaqbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802196; c=relaxed/simple;
	bh=Q+eUgasNNrBRtBGArjWHhYi7BKk7Sg0Hctyi1MeRtTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwbGFgNqKgGB2hQpXfQovA+CEMZsfWvX7IetLRxxstmVhgkrQF4tfJxrVS+QTjob4StPHWvI4teFTZQn/EciFZQZqFJoEofM93EZwEzN8ePza2II8pqp1OAb/UEmB4DN4HUViNzMj7vShS12ekoJGOtXPznWZ+DWwBrOxR+CmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yDEJKAva; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so13857a12.1
        for <stable@vger.kernel.org>; Fri, 12 Jul 2024 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720802191; x=1721406991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+eUgasNNrBRtBGArjWHhYi7BKk7Sg0Hctyi1MeRtTo=;
        b=yDEJKAvazgd+p2sA30d6k7afqEUidx5tAbaHciU98rvMxB6HZVXaSpd+sYGoV5sqGc
         72JQwKD7TpOaDVfX8xjiB9BC/3oi9fVRIpJJ+/vWGqFsbd1e4Mt4oBYnimW0wtE6hA9Z
         BRDTuWrn/C+0tOMW0I15HOma9968kRIAgtAIxQmxekKZFJuVPl+Jxo7Tif5KKvoQGTg5
         SrV8LGfBJXhulFKIEazNNcF+ObBsArIKdvnp+nnaEzvwq0CjXmY0TJdOyB4YQHMOvn8p
         BsXS7XQqnU+0S+gyNFBAab98h3/Z//e0/1mmtNTxbKHT0prryv3fsbqpra6YvudmKT29
         TyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802191; x=1721406991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+eUgasNNrBRtBGArjWHhYi7BKk7Sg0Hctyi1MeRtTo=;
        b=PvD0m/F3R1J1gK91VYyfLRtm1H8i87ynzDUcEtsy405xYWwRo8sbRewvN71w05SAFj
         W7vtVSaWR2wh8pJydNu/tWsFzJd+MSmPDm2Xnab4uq/8b8prz/Pgfi0t32TDglJ7kY0S
         ZcZhZUYkUUr67jeJPJSYtoKcsQfCYJXePFp+2us79zMTLEVWJmdN+v8YXjUEnx+NTtwC
         Bz4004NvqrDv2sKDJBNakFALgtlfVrV/4MBiHiz9jH+0VvbEJWI7C+axiJTR940qWGae
         q3rNavT0MLBiQ4IVw0agAXV+pzg/55nGVpdlMrdqyTTA3Og/8+lixlHOoZfU9kL1ruZL
         /+kw==
X-Forwarded-Encrypted: i=1; AJvYcCUfSmYE12AaguXYtLj9E5eSpMR8jzaf3Sk24aa9pmqGxArFmbbX42p59vscFDY470vyvxwFLK4+GPcG/SDOMnWPr2FDfyPQ
X-Gm-Message-State: AOJu0YxeCXoDRhiF+itw25ZI+xTRvHZbYiJezCFzMDExXJ8S9hHErM6t
	GCTgYS7HlQIS8SJEB4z0sarVxUdAY0jODsWHtLDHw9OOm3TB/5z4tiUQW2wOqzX2TmNSGBYoRXa
	STRKdkVjrfCKK79SvsdC2/rDzBm/SiuUwqWIQ
X-Google-Smtp-Source: AGHT+IEiidXKcJS+6y/kit+jVK4ZbCZPpMuXc9Ks0S13qwD9jaG7oeORoJWBxB+XKUhbeC/jYAXC6G90hqboJG2Vfjc=
X-Received: by 2002:a05:6402:358c:b0:58b:5725:dedc with SMTP id
 4fb4d7f45d1cf-5997a4d6499mr289915a12.4.1720802191090; Fri, 12 Jul 2024
 09:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712143415.1141039-1-leitao@debian.org>
In-Reply-To: <20240712143415.1141039-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jul 2024 09:36:17 -0700
Message-ID: <CANn89iLxq_PGZLRkkOMSMZkZRnM5NveFvOiJfQqywpqZS6fDwA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: netconsole: Disable target before netpoll cleanup
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Matt Mackall <mpm@selenic.com>, thepacketgeek@gmail.com, riel@surriel.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:34=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Currently, netconsole cleans up the netpoll structure before disabling
> the target. This approach can lead to race conditions, as message
> senders (write_ext_msg() and write_msg()) check if the target is
> enabled before using netpoll. The sender can validate that the target is
> enabled, but, the netpoll might be de-allocated already, causing
> undesired behaviours.
>
> This patch reverses the order of operations:
> 1. Disable the target
> 2. Clean up the netpoll structure
>
> This change eliminates the potential race condition, ensuring that
> no messages are sent through a partially cleaned-up netpoll structure.
>
> Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Goof catch, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

