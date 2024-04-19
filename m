Return-Path: <stable+bounces-40306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EAF8AB272
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644A9B20B1D
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFBC12FF9A;
	Fri, 19 Apr 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lmyZSrzB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9A12FB3F
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541928; cv=none; b=kcyWlO1CORTiYAzHHBh+PxRCrnPuVNsSyb4NPJa2qRJbGChzs08BGo0exufeJQ8d5KHY7gCWAf4PWxcL3/OmuMbt1YeNvfYNhNNxZ7HaCHH+BccP7XfNJ2CqyFfHb/hzcmbMHIK5IWnNVhu1WJvfrkv0sM9y8CkVibEDN7IVoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541928; c=relaxed/simple;
	bh=NLEkKpTukUvoSda6y6xafO8QZ8Y3BvTPN95Kb4vCOTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtoFaJ5sE6+zBLwRH3SkNUmWgCCLejfytEnnXhbVZrmsQZrB2VeBxoPp196Kp2GXq3EjGqtDHHGJyRzZMIchtC1YobEcX2wdzIJBrKPQtDKaJfCQQ5QKfPB/Bov8u5g/p3PzF1G1P7TIPfDN13plGExNxvoOpyVE1gJmfWqrApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lmyZSrzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6311AC3277B
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lmyZSrzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713541925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLEkKpTukUvoSda6y6xafO8QZ8Y3BvTPN95Kb4vCOTE=;
	b=lmyZSrzB3OJMWMU7jHIQ7OrtHhZSXimrjMLIiIEghfzLgYHyD1qqw1/FHeMfaEUAZ9bAnT
	iCNaIgGWVIGOCpVX4b4uea8PL/YsigvbCe9W2KBF8z2FVfPgtNlnAglon3bf1tLbfxzeYX
	1KiSVNmM0eBjHCoBoExd2PRvaDLDlX4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c0c573e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Fri, 19 Apr 2024 15:52:05 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc236729a2bso2306339276.0
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:52:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLmOUgcS9/B8Z862Sn/9W1pdlk2+WW9DSKSrrl8v0AZpMpo0cq1n4luxVPhAAR3v0Fo0sbzA0RiZeEDokRoW5X4LCs9Fca
X-Gm-Message-State: AOJu0YyYzuqDkXjdCAEhUyvSarB+bMnpXnBgGhS1VWs8LHWxqmmdrGC7
	vgyT4hWug4MvQi6vg5QcqfROyeZtLDUQW88Yb0Qp2NwIA7mKmoZftB08lDKxFo9Kyegdx8a3giy
	dmwR37tOxLwPTVejImN0tRgFF5qw=
X-Google-Smtp-Source: AGHT+IHDWOfLBTrFhvwX17u1YWKEhp7lFFYstKsnBvTgyVyOXU8nnoq5J8lzTaIJ9IyreRTjpAx0++zXo3UWzB4DYxU=
X-Received: by 2002:a25:db8e:0:b0:dc6:d7de:5b29 with SMTP id
 g136-20020a25db8e000000b00dc6d7de5b29mr2364075ybf.10.1713541924885; Fri, 19
 Apr 2024 08:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024041901-roundish-flint-1143@gregkh>
In-Reply-To: <2024041901-roundish-flint-1143@gregkh>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 19 Apr 2024 17:51:54 +0200
X-Gmail-Original-Message-ID: <CAHmME9ok+CDW+-YFS4s=kSwy4s5ruad+YBBn5m1sDyTTYcUaYA@mail.gmail.com>
Message-ID: <CAHmME9ok+CDW+-YFS4s=kSwy4s5ruad+YBBn5m1sDyTTYcUaYA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] random: handle creditable entropy from
 atomic process context" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org
Cc: guoyong.wang@mediatek.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

5.10 doesn't have f5bda35fba615ace70a656d4700423fa6c9bebee because of
6004fccaf82f71d6cd03537ef08d182487eb8d5e and so we don't need to
backport e871abcda3b67d0820b4182ebe93435624e9c6a4 to it. So nothing to
be done here.

