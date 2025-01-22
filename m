Return-Path: <stable+bounces-110108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA443A18C99
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A693A68D5
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E311A8419;
	Wed, 22 Jan 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="p4TY34E3";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="E8hfVqUB"
X-Original-To: stable@vger.kernel.org
Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18F170A30
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529933; cv=none; b=QCP6uW778CBGu3/T82XI6Ml2a1XSLWtD/R0B41e7+mt97C3P9M+fpBZ2jHeTLjD6fhMfLt4h0mailx1aQCpCupA/Rfcn0lDjo8kLdo7zeQB5RJdTsYScckp4yP4AAushq9Jl5Y+b7cCIp9sZdiPGN+M+st/Wzxkiz1Yfdl0Ddlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529933; c=relaxed/simple;
	bh=TQz2qqf5Shgqge9WozRd1qIA2G6yah0yJXzRQ8/mjDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9gW7CiaNVXMbl4pZF4ZbUfKgZGfwIuwyAY7Uy5xqGw0ARRZl1JWSyEl4rJHOtuu1DFOM6ZoY7aBX++f9k07kh5aEXJC/3ByvnPbYnmffFGy1icPMb/fQYXt2spiiWyoyKe4yc/S3uhGZoYarKHIMVYRZv6UbnKzLiKMA8ra3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=p4TY34E3; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=E8hfVqUB; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1737529932; x=1769065932;
  h=dkim-signature:x-google-dkim-signature:
   x-gm-message-state:x-gm-gg:x-google-smtp-source:
   mime-version:references:in-reply-to:from:date:
   x-gm-features:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=TQz2qqf5Shgqge9WozRd1qIA2G6yah0yJXzRQ8/mjDw=;
  b=p4TY34E3Qi0heA9hjmjjBK+i9RrIbgQQOcWOLBcsx75tewQT61v4Ynbt
   L6n7dernb6bpbCs3FsOVFIeWdEiSyZXWvphkyZoq4UIErIiRL/3npAg9c
   LKR3tmwuKUWAgjKJQ9qpXuVIfnnS6DESc8PC3Nzzw31/RIPXmKuaK9iew
   KVvk+ybcYdZ2/mBJsxueJV8dmh5YM3SSZYYQNTvmgl4v3xU7Swi89EVXh
   Y7GDuwEdRcv2jxh+R8pAkApIaiv6nHGfkgZDU+DWbYTF8U0zkumdYgQEz
   vSVfwxQv0eb0LskxdkWAlAteYRGYwaZQpEYGhtQ22f2ebb6rwFcW3ndsi
   w==;
X-CSE-ConnectionGUID: obwAXyFrQViIX1oZECeiiQ==
X-CSE-MsgGUID: xnYGM65ISiGNX0sZpEuWJA==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Jan 2025 23:12:10 -0800
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so12529067a91.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1737529928; x=1738134728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JtFTMdvg7whXWi9Q/m0jbPA+gIiwJLFdv9DoR71Kbg=;
        b=E8hfVqUBggrayY9gmbQireTwWsLUKn2LpHfNWFYGHGrAtx0RSwwdDCxDy8dOFAnO+g
         EXpPPl0lt0MFUpYcYQIoHZQeWH5u5ngwXY3reaDA5mLpBvsN9Fg56+roZuI4AXJ/7vu1
         Esjpb3s+Nn8cPuydhwaCcSaZoDMmlWQbf4mjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737529928; x=1738134728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JtFTMdvg7whXWi9Q/m0jbPA+gIiwJLFdv9DoR71Kbg=;
        b=Ufewlmfw2y1JkwR/Pn7Otpj7hT6CQDYo9IzqyBqJlFeUqGb7AcDtS5PQlimguxtWw+
         gxR8sGQ/xtmPvZ5pDdezYzeqqW7n0uHyS2VN6Iem9NM0ob2Ep4xcCCMFsrBmtbsG4KKb
         egKGwXWC3FG0gQC3dx5xV7Xek4kEjFKzbmobSwcBEf6WPwfeJJrs4TJ1ZLId7tPacy0q
         YQ1Dy2xLBKObEDZu67MU3BFvEE8yxi5mSbBZqXXVmn9fEArl5t1Pj2dRdWGusnmU41XW
         pWC4ao9r9+MePkTmp35M452Pp5/6HGWd97hXqOzRElKLoA2AtTiefzm3/w7pRebP7XQO
         3Dag==
X-Gm-Message-State: AOJu0YwcEJueknV/QMv+pdx662bJpqROUvH3Uf+XBu8dZqYQ2aH0lZM3
	cdFxe2IsURbFtChS7G+RB68fQ94lEO1g2b9VrMPxFZQZBBgOEJQqsV+Fn4zFqiw8RW2PB53Y0IU
	YrSfW9ezyAtKzSP/jGkZDptZpb09NKuTFQytINAYXrxCmZq2fQ8r0u8ctoRQddgRcG7qi+Y7id9
	ywe/4z6l7H7sS3bmAB14lss9cEROo2KaM4C4zZHA==
X-Gm-Gg: ASbGncsj0saIUtVO+YbeHWe4epIqcIgUydRbCQNG7Zf5KU3K9HGmIHXazncKZDQi8xU
	B5OKdDwBVlqxLc/tTgAmvWoaAkDcdyk8VLliXpH/nW0vAAba/MXGWvEEVROkMlQd/U4Stb5q3zu
	Omo/nJYkuIXw==
X-Received: by 2002:a17:90b:2e41:b0:2ee:f19b:86e5 with SMTP id 98e67ed59e1d1-2f782c71ec7mr33198725a91.14.1737529928120;
        Tue, 21 Jan 2025 23:12:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIt3sqoe33Sw1A1te78e/BC2B9bumvVRKplpPiKcucmkreg1Qp8W+Lh2q9ZsFx+B4ooJNoWyroD0jln4+VUMQ=
X-Received: by 2002:a17:90b:2e41:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2f782c71ec7mr33198704a91.14.1737529927807; Tue, 21 Jan 2025
 23:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-5WmCEvNQMkQBk+XhRFQbKCoC8XP_eMP4U7N9RTOqWmQQ@mail.gmail.com>
In-Reply-To: <CALAgD-5WmCEvNQMkQBk+XhRFQbKCoC8XP_eMP4U7N9RTOqWmQQ@mail.gmail.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Tue, 21 Jan 2025 23:11:57 -0800
X-Gm-Features: AbW1kvbWSxk3ie4B1RSwZI0DowaOiaVKMgCpzbkZ5LClLiZa5mIDpjYhmvcR6TU
Message-ID: <CALAgD-7=RP8cop-dt3mxBL3k=Kkw+Q2YniHgq+UpicbPtSBdmw@mail.gmail.com>
Subject: Re: Patch "net/sched: Fix mirred deadlock on device recursion" should
 probably be ported to 5.4, 5.10 and 5.15 LTS.
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Zheng Zhang <zzhan173@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, the title is wrong. It should be ported to 6.1 and 6.6 LTS as
mentioned in the email contents.


On Tue, Jan 21, 2025 at 11:10=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wrote:
>
> Hi,
>
> We noticed that the patch 0f022d32c3ec should be probably ported to 6.1 a=
nd 6.6
> LTS according to the bug introducing commit. Also, it can be applied
> to the latest version of these two LTS branches without conflicts. Its
> bug introducing commit is 3bcb846ca4cf. According to our
> manual analysis,  the vulnerability is a deadlock caused by recursive
> locking of the qdisc lock (`sch->q.lock`) when packets are redirected
> in a loop (e.g., mirroring or redirecting packets to the same device).
> This happens because the same qdisc lock is attempted to be acquired
> multiple times by the same CPU, leading to a deadlock. The commit
> 3bcb846ca4cf removes the `spin_trylock()` in `net_tx_action()` and
> replaces it with `spin_lock()`. By doing so, it eliminates the
> non-blocking lock attempt (`spin_trylock()`), which would fail if the
> lock was already held, preventing recursive locking.  The
> `spin_lock()` will block (wait) if the lock is already held, allowing
> for the possibility of the same CPU attempting to acquire the same
> lock recursively, leading to a deadlock. The patch adds an `owner`
> field to the `Qdisc` structure to track the CPU that currently owns
> the qdisc. Before enqueueing a packet to the qdisc, it checks if the
> current CPU is the owner. If so, it drops the packet to prevent the
> recursive locking. This effectively prevents the deadlock by ensuring
> that the same CPU doesn't attempt to acquire the lock recursively.
> --
> Yours sincerely,
> Xingyu



--
Yours sincerely,
Xingyu

