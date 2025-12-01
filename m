Return-Path: <stable+bounces-197690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAACC959D4
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 03:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ED53A1E2F
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1471A23A4;
	Mon,  1 Dec 2025 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G08+8BpI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EB1885A5
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764557395; cv=none; b=LwyMsk/jcsWj3gZkGm1ODco6H0mw8zVjhSe0rOzz7kd87ZUqgWa2QKMZssjJRO1e0vVfETAW0F//z2MZz4qF0gskqEp2t/qtfLvr31IC7QFIYgKq0+XO6uKNVPjIN0P0BHEBUnysQKb5Fu6HFU+JZ9rLHjdqTwItDBY+VNnPDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764557395; c=relaxed/simple;
	bh=hYkEJxVrr6gPeedbWPWdpq0mOw+kd5SNTJlObMvF+hY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=G9N6XgSrKGPVdmTc4cUr83U7CnWp1I2uT2bMkjIW/gfY2lU1SGFulYXPuXOStqu/3w36F+lAuFE8FT31cewgdNRL4CjOEB+2WLmGFhqQ7UbiOwtoGZWXi+bCpmdtOuBkN+hJTf6rsKF1Kirtl1kejM0ScVz79wUSgt81NEzzsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G08+8BpI; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee257e56aaso32260211cf.0
        for <stable@vger.kernel.org>; Sun, 30 Nov 2025 18:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764557393; x=1765162193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYkEJxVrr6gPeedbWPWdpq0mOw+kd5SNTJlObMvF+hY=;
        b=G08+8BpIOkay6R4TxeEfs1UO1bT6utSL8C/9ybmBuwSc9qgF0MKy8TVvy12viWb/Rk
         1dMc6/gB4LfOW5Hdf7kDhT0K7CKvjBjnCO+Yqm74TOCZeg7xAthQmycKDPne5G1VlZHU
         VaDPavtUBa2iDBwdE09ZMoskebHH0k3JJ3WNsRsqu28zQZYQaoUrUN5B3hU8YqamOTRH
         Ozo7pS+LHkdPb+g1BxOPgPSM+WNhjs2fkvBekGP4LhLkjh/8SGz++3GWhcOIA5g4/fA9
         3NCbkRPLzhLylzGrQXj+AQ7Cuc+4rh76DS6JEM5BZMo/qN+XxHBorPjdBP6uMuwbnkNM
         22Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764557393; x=1765162193;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYkEJxVrr6gPeedbWPWdpq0mOw+kd5SNTJlObMvF+hY=;
        b=JotUWiUt/knMZ47QepvdDdcr9Yi6gYmpXv6Fbhr6InWYwr54e3RuGlbM7MK6PpIR33
         uY8B2PWZcGvaFO9BYk7/dtKSeqpQJyPyzX1QQL/XTjtHBF8uM8dfikB6+LgjyTyo4u5g
         fbrmkAor/ocV7bqfYMhGe0pAv1EajtmgwDNNwUNtCfdx0NmnwTQeMvt4DrZxbBAQIsGv
         2vPl+YwzFc7jF1LS9JVvskpCXWK73mbWmSbM0AeSPQx7VjxA7RO26J2M++UAeLHn2VgR
         PBGNTTbkVJgbyIzJH4W8q/PgV47IxIDAjA5jWUuVE+lQ6DoAascqLmnS4SVhEPKe6/GX
         rBMg==
X-Forwarded-Encrypted: i=1; AJvYcCUAP4p6AmOzlFEj2LzOZLNJgCuSl3IhSDjDBgM52cqGZebKeegABAGdvTrvpYQv41ekk7q2v3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY94kz9Js7Ivh8sYvR0pK0cYWeleH+g37jT0aMY4SvwDhbz3ua
	+hA3PTcWmiY6LXhDHdRhL0b2vGntiaTt/LrkYb8iRCPnfCKZHGBTdVkcXxV9XTvnQffD7Flh6xy
	irscxy0jJZLMIdHzb9m/AJaGkUzmVPjk=
X-Gm-Gg: ASbGnctgSL14cHgm3L7wLER8YJSZWs63yPg3z51gVmDvjylotebx/KYTPlMXpBqjenN
	NxX4Wmu4zV8ivV61FMIk+KsVfP6zKbCsO2mD/8UDSrKRGpWx/2WGHB0kk0Cvz+rMA7oq9p/Vcmm
	AIWKcMOFRArs+dKEUmZuDkQyCyxhRiDMtVq/3hbdapV5UYE9hcacFPFZSg0ycw2TqbDJe64yGc2
	AQq/h0KCdwCpV24Wrg/iVYOSNkfpOKLyJUS+X9QDh5Vj2aXqNZAYX/MHuhqqcQ4Dc8O1XU=
X-Google-Smtp-Source: AGHT+IHMHWZUpIKd+U2gvM8f3QvXs4CC0pyopjWK9dMI7GD9DZxVsJO8lLrq5dpoyZwFws+kCu6JW4osX+zGhT5svzg=
X-Received: by 2002:a05:622a:1a9e:b0:4ed:806c:69e2 with SMTP id
 d75a77b69052e-4ee4b418e8amr556087811cf.7.1764557392655; Sun, 30 Nov 2025
 18:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 1 Dec 2025 10:49:15 +0800
X-Gm-Features: AWmQ_bmP5hMjMgqU5H0KVWtv-n5YkyzDiO8iqPzfWNNMOQJznUvcruZT5FUNQRE
Message-ID: <CANubcdUGqYsaxsd-cUtjhtCSL4G1kQGevei1m25qKm0ip0-i9g@mail.gmail.com>
Subject: Re: [PATCH] bcache: call bio_endio() to replace directly calling bio->bi_end_io()
To: Coly Li <colyli@fnnas.com>
Cc: baijiaju1990@gmail.com, Christoph Hellwig <hch@infradead.org>, linux-bcache@vger.kernel.org, 
	linux-block@vger.kernel.org, stable@vger.kernel.org, 
	zhangshida <zhangshida@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

Hi Coly,

For this issue, I've previously sent a fix here:
https://lore.kernel.org/all/20251129090122.2457896-2-zhangshida@kylinos.cn/
Would you be able to take a look and see if that one is suitable to pick up?

Thanks,
Shida

