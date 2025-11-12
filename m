Return-Path: <stable+bounces-194577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBDBC51492
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BFA42162E
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811C2FE568;
	Wed, 12 Nov 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAAe2lRk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D57267B02
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938024; cv=none; b=fEdiRTusKXrPqo5oDBDfv19de3hsFc/dvJYE6Ut4F7cY50B5qxwsvzYkObgjMmfsjlhaOOwbky13JrdxO5Mk0KVwERzCvC6CPwj8aVFjxmUg9S1/mI1fJE+7XU455bpE3wNbfg8L3ULSrMy2G+5vjyW3qbOqUMDM9iw66WYuaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938024; c=relaxed/simple;
	bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOVhP0ChAECMOUIxkrc0ToQnWqnZ1LVW2Lxq7Rv6szmkO0YjyXaEYFlhU4yo+To4S+DeF3oA3BLU0neP/+jX/r0GEa13cPz3UfFdfZMYjiJRFfSGVYgcxh+q1C63ylsERr66D+fBYmGa1KUjtmA1HzIx5BX+N+2M6lYhJwNUzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAAe2lRk; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed75832448so8270751cf.2
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762938020; x=1763542820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
        b=AAAe2lRkFqxOg2bTtykVWUzUmNzwc7iUqQq62/g3bpVBJE2xcTNhFzoyethPS4vLO3
         fC5X0Eo/h2+cmwYmdCtpBiQPcxHX7ByNwGfCKKaV5o3VgLGRPVJARtNoTwLPynLHk9Ol
         CAjx00vQyqu5cLkvx3C3nRYJjh1/4TFysAj0xm3l0qffTlqfpo66EMvKUwUSTW5KAEFS
         HOMxGyae3ZvwNoxdfEokjDVWsII2Dhukf79z7Ix8uiEvFiMu0evg/iwngrj5jD/6LbF7
         n4oLYEuSSeImF3scQI/EUs2G9j4HBptgKyTl92+rwbXvNKGqTTAuzH0Gmmjs/Xb+kTln
         nC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938020; x=1763542820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
        b=QOKIFZF/s0wCjMofXqKkeUnYUfil44yGrDPYJuAuRPzTXolI5vBgN4D5NM8UbgEZWw
         iq22+MXfh5Qj1sCQkzKmoCWTvAZXZdHBsIRqRlA5fZwtuPxZYkrTDEmxPvrK4jIBgtz+
         F4nUNYa/PVm/gx4hbuNoVCBIw8S59kVqVZLjQSK47W+AP5gSyXYbGyOgcBrea7oOz5ZC
         Hh09Ni6AR9UlERcnb0/WnBpzl1MDPfw5TD0fDthuJpmhLLUscPrpX5uAL4xznZEYywBD
         8bIp4pASDPcVU94UGfh4XPUHQbUNGEGgVz0gLpeO3SmNkVux5DXIfc+UlW7GDznDCMQb
         af3g==
X-Forwarded-Encrypted: i=1; AJvYcCV4H7g7oeqeigOe+YYXPheL4BiT8jx4NftZHA5Wyh692xYJ506ncAzAet/H8GB9UIwnMg6ozhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCzdk9WRX6hFVwmv5eixHCwoEgrYwZ1SJKBGReAfK8ien4bof
	zr3FFm0x1nkFN/eDVTglMX97FGw0zZPe8zFLoVuWfmBHoEn08mR46m38q8BacV4YTboH/IrJSeZ
	v/LL9YfB68CWutfYcrbCezHK4lyMwKbPDlqbw5YyS
X-Gm-Gg: ASbGncuT21byLsVF3JbTVPDDo1TK6VtI6dztq+CyV1PSGl7hM/2Abf/CSGgOv4r5LDf
	UXH4Kgo3Vtkt6uEzwvC+2RnMHlS3ri1MJXwqH6iceZ0zv4UNewUGnRXeEFNtN3swsDq5UFCgEZ9
	28cX+BVxjjD40Cv7IIZnYwyHoo/1oyaNof9FbZYAiUthaMRSC1FzWM/eT7G3fCpzHbgNfTfasS4
	AnYID5TDEr8aEVU3KF00BhhgoBpdyZg61x+gUw+EjwMTg/v33cortYKYhOukOtIYLd/5WygfNTi
	FeZINb8=
X-Google-Smtp-Source: AGHT+IEzCQ3YNHW4UtVKvqkX2yjhSogviPzmTzb9PXWyqz3RlNdC+8kFSE+KOjdjnU93CyVP7UU5sqx6RahkBBvzCq0=
X-Received: by 2002:a05:622a:d0:b0:4ed:b8d6:e0e8 with SMTP id
 d75a77b69052e-4eddbc9aab1mr30299041cf.22.1762938018726; Wed, 12 Nov 2025
 01:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111064328.24440-1-nashuiliang@gmail.com> <aRQ3NYERGcHJ4rZP@shredder>
In-Reply-To: <aRQ3NYERGcHJ4rZP@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Nov 2025 01:00:07 -0800
X-Gm-Features: AWmQ_blEvxDrUtRwU9ZZmEwZxbCjv9hVvyWPhviWRL9cCYxauIr8WxQDUJlUNqg
Message-ID: <CANn89iKjuRZjeLbZ9v0TcCUEqah3pQbq0-tBPJveavwK=G1ziw@mail.gmail.com>
Subject: Re: [PATCH net v1] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: Ido Schimmel <idosch@idosch.org>
Cc: Chuang Wang <nashuiliang@gmail.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:28=E2=80=AFPM Ido Schimmel <idosch@idosch.org> w=
rote:
>
> On Tue, Nov 11, 2025 at 02:43:24PM +0800, Chuang Wang wrote:
> > The sit driver's packet transmission path calls: sit_tunnel_xmit() ->
> > update_or_create_fnhe(), which lead to fnhe_remove_oldest() being calle=
d
> > to delete entries exceeding FNHE_RECLAIM_DEPTH+random.
...
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

