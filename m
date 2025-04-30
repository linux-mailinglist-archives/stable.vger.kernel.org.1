Return-Path: <stable+bounces-139106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E83AA44F1
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F964A6784
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D1205AD7;
	Wed, 30 Apr 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-sg.20230601.gappssmtp.com header.i=@starlabs-sg.20230601.gappssmtp.com header.b="G4uMPdQw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065E213E94
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000774; cv=none; b=liqSwPxLClDurBF+f1yy2mLu3KunQXGl8/NGuv8vsWtj9aqivlLq+UFTMNeAmXdI2dpnZjBJodjagy6J6tZ52Xub98l5AzVsBBS02ubDU8B2NvNObVQRLKbR1/5aUxZqJo0OA9aOxzXv/T1A42UCALYdk0F1OI16YTz++Y4CBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000774; c=relaxed/simple;
	bh=PVtnVO7GXratpyuATMxm8/jjsqq5vOvJJL/vhUNPcBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jChtvYuDtyAo8KYlj7sWApXN5Rep6t9jPIeK+f1hOiMSvWPd9OtPNDIEb6G432VeIJVViC85SSrrxA1mTJRXFsJ9BxN2WYhVQ8JK40MB+iHOsq9YAMqOpzbxb24/3JnOW9Ov98uQ1TdgfYH0HjtcYKgQ2wZUWjjojx//eCCTd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20230601.gappssmtp.com header.i=@starlabs-sg.20230601.gappssmtp.com header.b=G4uMPdQw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.sg
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1122693366b.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20230601.gappssmtp.com; s=20230601; t=1746000771; x=1746605571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PVtnVO7GXratpyuATMxm8/jjsqq5vOvJJL/vhUNPcBI=;
        b=G4uMPdQwBHvvdF8GKzd+DMmbEQER+KC02EnYEPQC4hgTPflIDHUMasJb7ZDzh64W/f
         DMCzSG4sieOHLsuo0grfmHtZ4z/WeMaZNKg5mkUUUaSaXXN2//msyKqlvjIICqACXacQ
         U85zTwgeo53E8NOPat5UyCmHB+JO97ilVJUy+LT9PkxCRYMPLp6zSdklkf9+y/Q4VUc9
         ygUuuvu0EdtZpYflMdxr7VpVqHCEmvuuX91poxtmG83dje0mjF5SiMUsZhlTAxbd/2rx
         sDimsVS9T0yw8PlZPkl8c8L0HDsc6bo3PSyzs5r8Ji7AAjwSOEgarL2y2pmiMR59J3gV
         mv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000771; x=1746605571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVtnVO7GXratpyuATMxm8/jjsqq5vOvJJL/vhUNPcBI=;
        b=BmpvzgCI3pj+Ksui9gZc1fnsI2cf/Ijl6kPJvMOGL3lp952O2TVSVfqTUqOYDsAZhD
         Ds9kbGQb/HeCu4+XryKrF3CzkliDtUM/pf8yQl+C8t1cZ2Jp74iW9fg/6gXGmAgoM4EN
         zOuniWggLODJPyDd4/P/uy2D/yuPZFBThkjhNitSfMuYNj8SXt1VqLbTjnxsycGzFENP
         jvCN0b/7zOaHk0Q0YTCi6gTeXfb3Tm7M4Gf39QiMiJP1JEkFV74yr4Z88Fr18ubpy05W
         l3CeRQb8RgRlj7nQlucJwjK9LoFkftLXI2QrRDARYmA9ET3+s7sTzN84oWuvDbLdvq/F
         2YAw==
X-Gm-Message-State: AOJu0YxPS0t7SjXj1Tzhu6b6qB3rkF5z8x224MEQOi0zZlNqrQm3pGxU
	BWLS+AyV6iZN/RGt/RUnZvAYKCsDJ4D4ZK3f0Y+abQlZQot9j4BxixFdwvGu0ySeR2XceP/N1uV
	37AG1kA2uh9o0ZgRhI9LDxy2OW5G60ux+N0M38w==
X-Gm-Gg: ASbGncvDWrY596ASH3KuhcPP1Mtt99nD8aQFTTrsn4DOItp3a9eUHC9xLumXTUPF7wP
	iw8PdT57RjLL63SbfNMt50RIrwyKE7a2EKx+qQRYCn9dTUGS5IVpZps8FWe2uArpEm/yK2CXDqN
	Fd8tx9arizzZmp0cVUVhVEJBd9TuSsp5JrVVk=
X-Google-Smtp-Source: AGHT+IFNWjxWL7Dh5ql/e4L69Pv2wTSo/Ar8t+DCb6Y3X8ZxuWGrWjZMPBC9p7z9Uy0oMjX3PneNQaawvUn1sMJ6Z/w=
X-Received: by 2002:a17:907:7fa5:b0:ac7:7e3e:6d3c with SMTP id
 a640c23a62f3a-acee2605d08mr158531066b.55.1746000770815; Wed, 30 Apr 2025
 01:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429161123.119104857@linuxfoundation.org> <20250429161123.269149769@linuxfoundation.org>
In-Reply-To: <20250429161123.269149769@linuxfoundation.org>
From: "Tai, Gerrard" <gerrard.tai@starlabs.sg>
Date: Wed, 30 Apr 2025 16:12:39 +0800
X-Gm-Features: ATxdqUFjPnSe0IzqLH6r7t0V1qG1afdCoVRaQ9M8lCRx5zfrVreULKjiixuLTMw
Message-ID: <CAHcdcOnHVSAF9DOjGqSWrZYiS-5LyXHimdVou6zf-6zZyvZhPg@mail.gmail.com>
Subject: Re: [PATCH 5.15 003/373] codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Cong Wang <xiyou.wangcong@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a question regarding the patchset this patch belongs to.

I saw the recent netdev thread
https://lore.kernel.org/stable/6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com/
and noticed that for the patchset
https://lore.kernel.org/all/174410343500.1831514.15019771038334698036.git-patchwork-notify@kernel.org/
only patch 06/11 "codel: remove sch->q.qlen check before
qdisc_tree_reduce_backlog()" was pulled into 6.6, 6.1, 6.12, 6.13, 6.14
stable. This was to fix a UAF vulnerability.

In this case for the 5.15 release (and 5.10 and 5.4), the rest of the set
is once again excluded. I'm not familiar with the process of pulling kernel
patches so I may be missing something - is excluding the rest of the
patchset intentional?

From my understanding, this patch depends on the previous patches to work.
Without patches 01-05 which make various classful qdiscs' qlen_notify()
idempotent, if an fq_codel's dequeue() routine empties the fq_codel qdisc,
it will be doubly deactivated - first in the parent qlen_notify and then
again in the parent dequeue. For instance, in the case of parent drr,
the double deactivation will either cause a fault on an invalid address,
or trigger a splat if list checks are compiled into the kernel. This is
also why the original unpatched code included the qlen check in the first
place.

I think that the rest of the patchset should be pulled as well, for all
releases.

Cheers,
Gerrard

