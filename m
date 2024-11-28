Return-Path: <stable+bounces-95706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1C9DB78E
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5A7163776
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4419D89D;
	Thu, 28 Nov 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UR9H+rPB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35279156661
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796910; cv=none; b=KmapMTIrIHt/mxDCgaeqKQX0U60Qqsbt2yjzGRimApEoAd4o0DVx3bTUAm45CqYtZQQVLGK5zKgaiDtnjP+FAokeJjiwv5/YahiLW6cCX79l5n94NtapM9mInCsTVFn5J9uWm9DW+PgLndwNuTvl5qHior9fJmRMDGwfYb0vbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796910; c=relaxed/simple;
	bh=MOT2fR8awT9bMTqFJViZ1GmaBnBHbdhxmtDeJixFVwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srMQFXcp1oRSXabGlNM668T7x3TCth1tyjaT/UbGxPmekCMAnRWGCwimFmMq1DkrEZP8Ve0+ztb9nZiMBnZFPlsZYCWxlp9Isjsoc1mLAGPiAqDjPsmgJVk82F0w0u2lYyVEXHfiKHFQOetJ8S0c5VL5qDjaCs4AsgYiHFl+1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UR9H+rPB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df80eeeedso428682e87.2
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 04:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732796906; x=1733401706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOT2fR8awT9bMTqFJViZ1GmaBnBHbdhxmtDeJixFVwA=;
        b=UR9H+rPBh6ko11f0iuF0UYGbvVhOnxCUEDXWk6AbUJdZygdVCMzWHMn/cCKFy2vCiv
         P+p6qdsSBN9QQ49bS5mR1ERfrPqSNkCSYFGRY3V9EtK9/07cLo0v4W3FIxgt10SK5H5m
         fctJndO6IuOscqbXJs73egxSYMl0AtribQPg7/+pS23ZNKwhh/b6bo+dv61lnw20AbFQ
         TF2R6IsQ9AFxuf+wNUwdMafcJwC2wSI9+5zgkHQ9mAn2mA0ScKNAeOjiLCdhmVitNijl
         Q0KlwH9VKP9m4WJ4GJoL/RmT9bMiKeVTdbJOg/pMpVzeVxPeGSYwT+UzxhWkZTK32NYU
         Kk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796906; x=1733401706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOT2fR8awT9bMTqFJViZ1GmaBnBHbdhxmtDeJixFVwA=;
        b=PY1O439EL6mTBZyelObbOQGUXfaVhjzZR45tsZ97TEaEVqWv5pXpaSxPH7B/l8DjuP
         q6AMLJ3gaLlIRrbfHvVzqgKzvOXYAcLbnOBiOnBy2lpt5kiuEsDpDOZPPW9sb2j4gXyI
         Uy4JqLIb0IIOA6gkbR2kwRG+oYIdRQpLGtwwC/y77U1gExXuJAkhtzdPlEufUE6AMyOh
         UcnxVyYgjJK+At7/+4QHRwck//6RLUHlopr9Pl5WIvldiee7f+z9CRTziIp0WOO1trCT
         fXOlann6RIxFcPdr0KoERmjUDzo0qVi3U+2qhvKtH4aViE7YtEpw7twdfMFI4F8Bdwvg
         KMdw==
X-Forwarded-Encrypted: i=1; AJvYcCUdHpCHzWZXGONPlAa7T8AXBvISiiabjA4DyJ/krHr2OxygsRPc09ypxRaK2Q1/WsHc7aMMJIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwrym9OdLTJ04Q5f/sJsViFeEC+6yhmwf7kHoJXe9t6fDTGBc
	91vm6uRrc9uMTuCqlSMAoQqlpnOe/Tm2Q/Lgc+AI5CwavZmVH78/c5tUkLogLVIDv3Op7zh2ixU
	BmptFAXACpMwnQ2bK8IG0jBL37Pv+zoRhVlds5A==
X-Gm-Gg: ASbGncv8tRNGMuwK8nD+81gwNy1idPtKmvcAzYKIIEWVDTyo4K5yXReOgNX+QFD+47g
	cmLYZI6ETCeQWYD/uw7hakpo8v/uaSZgk0iaK/7EIIpm5zcPzphzSyvoH6BTk
X-Google-Smtp-Source: AGHT+IEdrLtj9NaXXUfCeQxVjlSafuVoPdRfD2yexlIaCJux0eAYLUG/36jd9cMhQ1bPlx07fZHGswpMMleKK6+/fH0=
X-Received: by 2002:a05:6512:3119:b0:53d:f1cb:6266 with SMTP id
 2adb3069b0e04-53df1cb62e3mr2782497e87.28.1732796906369; Thu, 28 Nov 2024
 04:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com> <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
In-Reply-To: <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Nov 2024 13:28:15 +0100
Message-ID: <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> Pages are freed in `ceph_osdc_put_request`, trying to release them
> this way will end badly.

I don't get it. If this ends badly, why does the other
ceph_release_page_vector() call after ceph_osdc_put_request() in that
function not end badly?

