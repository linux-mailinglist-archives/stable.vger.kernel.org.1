Return-Path: <stable+bounces-151937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2615AD1316
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BCB18890A3
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080018BBAE;
	Sun,  8 Jun 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qFBaxcwr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5A186284
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749397791; cv=none; b=RTjarpBmfCm7jIEyH4dT5saryR5qZmd4EVRV4jRO5H5q7dSrbpLQVLsfbzdCwOPr1iLRaB3a9yckte++DhTgHNGICBotuvPA3sRiWzSPPa6aab1OUxLxbY3d8Nvu2LPZZNvIvceIMYnt5PcKNq9OruA0JIg4FkpKmube7RdGaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749397791; c=relaxed/simple;
	bh=MKsTM1+C9QeCGD0Pjs9eZErUYlC1Pyuc2805DCEa5Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3woXKY4Ymxrhq2C/s1PcC2RRjm9DteaSeoCvXiBDc0Dz1A51bifBLXadcuYBjRkhcGumG5cDW7u0XlGoIqX79ihvqSZa0Ok/zmbi3LJKZ6d5vFe8xWEiT2x6pKCdbjZ3Fyg2+W0sWW0w530p0qUNxV4woHdG6HZYlVpkFmeLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qFBaxcwr; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d09b0a5050so208965585a.3
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749397789; x=1750002589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15SfyzB2KZkvwixg00o+49m0a1+RaFWhfwNSGqXDKgg=;
        b=qFBaxcwrGwx3aC4keLcL1yxTx9LInLVOMMYK5CmMizK9qjXY9C3o221FK2DC9cBFJa
         i0FJjBgYkCxNKBw4qQbWmAchJ61jl1pcxmPUUsX8+OTonLcqH7Ks1JbO1WhqS+rMjngn
         1Qhk0GRZP7Q6iIuPhV5yJjrDsGr4YqymemcP3H4k29FfwbPeOBXb3yt/TODOB3AOg8yN
         I8SROv+PIBKd1ereY3L7onL+lQTPsdITHJO1U83Xh03NzOm60f4o0wzJB48vj8QjCQee
         9gUeBu3fZTO9qNY7T0nZVgpdu6LlRskPWtMDKEfRk4YhzG3rSgakJSMbRDf6BlG+UJlk
         0S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749397789; x=1750002589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15SfyzB2KZkvwixg00o+49m0a1+RaFWhfwNSGqXDKgg=;
        b=Dl2CL0y2eL8nmMqGRRAQXqhJnmgS0DBo8UnNPgeV6W7T9RXPopQqky72ibSqlEyYld
         upGnzob0H9U9VAYwH8hC8LYfbyGxfP9TiruGeUD0OJ6f/wDtBRTTqRAfjdhbQWtVyd5D
         9GNAHkDrjXHSZ5dOYjr7JENT9e9zWsshqJlpFe6K8/nw4le+OwJoEnNUxGGSu280Dvn0
         hGCMJC1/vfiymcn4hGpRvGQjxttzo7YoJIjybHxP/QlLwuv4DS+OpWXZGD7JB1/N9KAN
         StQi23zGVJ30rG/B+xXxyI6agZ1CdlV90WOqxxg8jDsUtFPHzAsMtlRl+yrhSaT3pbxQ
         Tg8A==
X-Forwarded-Encrypted: i=1; AJvYcCUnjf5129R285W6Y0ItR6UPRew8I01m77l+klddQO0tT/ViJIMMY41QhfmFer6N0FeLIpCJibE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vjULnYLCKKv8X6WaovOeLgNW6bsSwJ+vP6fsSga1t768OUAt
	mCl2VR3tejo4JaUvXjUqp5X3JqHzRAgdokyje36Ecz5zLtUqNyWJpWaW21Ltv99N6jM=
X-Gm-Gg: ASbGncv4BBNix6DDy3wy3uKhK+7grkHf4qnax7JLM1wlGVBWCy4ZydIEtCR6JpsHPy1
	L519k7zs7jNgPLZP3GnUF74JtiD9XJN3tH50Mbh2o3Z/1Pfr2TyqLbfst0VRHSal0bgi5qMZ70I
	E4CFluQHAzKqvjhNkUOx6+wmU51mhdXDXAIAwg6fgszHP4fBZ3OV7oGWaNYr1xC1OfvyXiN5DVy
	v+9lbBHpaJKjOl8GrQBUhBr04sGQvotmsA3Z+g+uj9N0ozGrQ3M/fPxhFaJlZT7LLgYLfRlr7It
	UJ1eqTqL4xQT4Iq19UcM//UMfellW6J27C0IleAQc6Pz2L6TrqUUvwd42qBmIBPuRlMY69Uianq
	F/q1W97q8e4tIZRBaVJo1CEM7Jn8hcQbR66fb2as=
X-Google-Smtp-Source: AGHT+IFMItTRkpFBvAJi4PVEEUt3/gJfRAjUZYN3c1UYEfhEKFgqVle4xRdj02wbVxFz+gkYB1ZUlw==
X-Received: by 2002:a05:620a:9163:b0:7d3:8df7:af6e with SMTP id af79cd13be357-7d38df7ba37mr494433985a.32.1749397788793;
        Sun, 08 Jun 2025 08:49:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61b5fesm425460185a.93.2025.06.08.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 08:49:48 -0700 (PDT)
Date: Sun, 8 Jun 2025 08:49:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: moyuanhao3676@163.com
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: core: fix UNIX-STREAM alignment in
 /proc/net/protocols
Message-ID: <20250608084945.0342a4f1@hermes.local>
In-Reply-To: <20250608144652.27079-1-moyuanhao3676@163.com>
References: <20250608144652.27079-1-moyuanhao3676@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  8 Jun 2025 22:46:52 +0800
moyuanhao3676@163.com wrote:

> From: MoYuanhao <moyuanhao3676@163.com>
>=20
> Widen protocol name column from %-9s to %-11s to properly display
> UNIX-STREAM and keep table alignment.
>=20
> before modification=EF=BC=9A
> console:/ # cat /proc/net/protocols
> protocol  size sockets  memory press maxhdr  slab module     cl co di ac =
io in de sh ss gs se re sp bi br ha uh gp em
> PPPOL2TP   920      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> HIDP       808      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> BNEP       808      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> RFCOMM     840      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> KEY        864      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PACKET    1536      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PINGv6    1184      0      -1   NI       0   yes  kernel      y  y  y  n =
 n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
> RAWv6     1184      0      -1   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
> UDPLITEv6 1344      0       0   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
> UDPv6     1344      0       0   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
> TCPv6     2352      0       0   no     320   yes  kernel      y  y  y  y =
 y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
> PPTP       920      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PPPOE      920      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> UNIX-STREAM 1024     29      -1   NI       0   yes  kernel      y  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  y  n  n
> UNIX      1024    193      -1   NI       0   yes  kernel      y  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> UDP-Lite  1152      0       0   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> PING       976      0      -1   NI       0   yes  kernel      y  y  y  n =
 n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
> RAW        984      0      -1   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
> UDP       1152      0       0   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> TCP       2192      0       0   no     320   yes  kernel      y  y  y  y =
 y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
> SCO        848      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> L2CAP      824      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> HCI        888      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> NETLINK   1104     18      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
>=20
> after modification:
> console:/ # cat /proc/net/protocols
> protocol    size sockets  memory press maxhdr  slab module     cl co di a=
c io in de sh ss gs se re sp bi br ha uh gp em
> PPPOL2TP     920      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> HIDP         808      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> BNEP         808      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> RFCOMM       840      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> KEY          864      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PACKET      1536      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PINGv6      1184      0      -1   NI       0   yes  kernel      y  y  y  =
n  n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
> RAWv6       1184      0      -1   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
> UDPLITEv6   1344      0       0   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
> UDPv6       1344      0       0   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
> TCPv6       2352      0       0   no     320   yes  kernel      y  y  y  =
y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
> PPTP         920      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PPPOE        920      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> UNIX-STREAM 1024     29      -1   NI       0   yes  kernel      y  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  y  n  n
> UNIX        1024    193      -1   NI       0   yes  kernel      y  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> UDP-Lite    1152      0       0   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> PING         976      0      -1   NI       0   yes  kernel      y  y  y  =
n  n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
> RAW          984      0      -1   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
> UDP         1152      0       0   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> TCP         2192      0       0   no     320   yes  kernel      y  y  y  =
y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
> SCO          848      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> L2CAP        824      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> HCI          888      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> NETLINK     1104     18      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
> ---

This could break existing applications. Changing the format of /proc output
is an ABI change.

