Return-Path: <stable+bounces-19781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E8D8536FA
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6206286E13
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32E5FDBA;
	Tue, 13 Feb 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kgm4XOi6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1D5FDA8
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844494; cv=none; b=YdDOPoMCP5OEV7fp7XzGyr5gMl08FSI4+Uuu8Bg6sPl1P2MvfsUQ4RubPYRTyVCxUckUDoN1/yjUyiBIow0wVjLOLEefrizItELcqcCRGlYVxycASOCMZs2oWaCaF2SwDBTPRqH+Eu30iUflYg8tk4YzXmpDvSrkZe3PH8HabcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844494; c=relaxed/simple;
	bh=CMX1H0ZqodWgM5ABFYTHuKqzJAXD48ZCW2YnSyH/wHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2ANigxgErcB41ncBPGNWM4KzR8bMpEveqUt5gc9iBuSBcRm9i/wwLzOI5OQQLj6gUP5JVkaXFaLhUUbvKti1duGdaahNPPuUJqSMf8KrGBAp2Prt259D3roQPaagY0d1ICtEmSb82uNIXac16flGWEmG/LFtE+Ucvxl7Z1ZdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kgm4XOi6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so7279878a12.3
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 09:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707844491; x=1708449291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMX1H0ZqodWgM5ABFYTHuKqzJAXD48ZCW2YnSyH/wHs=;
        b=Kgm4XOi6+uAodFie+Ml3KQLQYg5xyqtjbCT4STflmNjAlYYnwrk1axsx0UhKa11lCB
         Gq1gzPq0FPjZitN+5+bq9bsYuoxjRrAZ4QGZczO6EFXXkJtbaTBWk23yKRv9w5TtSMI4
         bbyhXI4ZsquGkZALTBUFwi1bVeXt1Pw8KyAcCImu6vGQ5UkPs+1tLICxsJ+R4U4Z8b09
         sPvY3SdEUgAoCt5Kx5RrpnnmGzrGeMo7PtMYXRHmaa2j0c5e5QzNeFZFNSk4t/apVPmw
         qBRgZMzSIbs5lsNvfqAdaaq3N7IrovSylCah2ZyrX0Ci98OycvBocDdhEygWNZrJyXw9
         wjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844491; x=1708449291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMX1H0ZqodWgM5ABFYTHuKqzJAXD48ZCW2YnSyH/wHs=;
        b=B1yuP3+7Oa5P2lz9VBz/3SGUaQi9kOzZCTUAPXyiY4kR9HRz2VcNOzZI1n6ETS9eEt
         OKM3US3Rv+gCTZXO7L7wdOl2qg0KbThBqotnNqyx/zc4EgvBv1yDPOBZKH2EmmIEe6Ga
         298WRU/7UPbZn52EWt6TKX0GHvRkZqIXL8bkjaIHLkzXzQUux95Fi0kP+FmLercaL6Ff
         CO++Bsmn3FajwCaIjtY8YH3FpgVNJroyzhIAWiXX1v4CmFGWOBaRrqEBgmk6Go3ImNyn
         m4gc3TFKuJ2auGh65AzG6pm0UO3CLEYkTg3ndUyfTm9N/LSMEM8XKaFxYgvk5PTGEYwq
         zLuQ==
X-Gm-Message-State: AOJu0YzNHRjQXnHWtn0z7LaBhbSUiCPwSyyoeI4GBvV4LqvqOa4WqyQk
	UkXNVJApFO1FUVmnTSc9sIH+NCjfO/f+ASDKkfPscRiKqL7KayUehX3iYKo7CG8ip3tOFfWcS49
	8iBiIuuFoQ0WbULP/RkH0iPQj2RTsAW4FqIZq
X-Google-Smtp-Source: AGHT+IGqPPDAXaXRIb9VKY097fLKeOJiALCYHDB5uKAlVhZ85hlEM7wsGwDf1M4RGItANASh8sBUPG6Kb+1Kq4T9s1o=
X-Received: by 2002:a17:906:d961:b0:a3d:2367:499a with SMTP id
 rp1-20020a170906d96100b00a3d2367499amr629806ejb.43.1707844491315; Tue, 13 Feb
 2024 09:14:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209162658.70763-2-jrife@google.com> <ZcZ0Tb13ZG9knz_P@sashalap>
 <CADKFtnROEHN4w8pRz7u1Udjg+Jm3kVb5meJSjGXZQ_=zQp-=qw@mail.gmail.com>
 <Zcj17ysVY9kU8xVs@sashalap> <CADKFtnRk9HG0=SPhqCG-72eG8Hb4dMoWjUCV6Wur_uQgGKEWPQ@mail.gmail.com>
 <ZctedYIYhNlX_HAz@sashalap>
In-Reply-To: <ZctedYIYhNlX_HAz@sashalap>
From: Jordan Rife <jrife@google.com>
Date: Tue, 13 Feb 2024 09:14:37 -0800
Message-ID: <CADKFtnTRCaCbvPpNva017ctvoFQavqzwQJJWvpStwRBb9DXAOw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] dlm: Treat dlm_local_addr[0] as sockaddr_storage *
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ccaulfie@redhat.com, teigland@redhat.com, 
	cluster-devel@redhat.com, valentin@vrvis.at, aahringo@redhat.com, 
	carnil@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack. Thanks.

-Jordan

On Tue, Feb 13, 2024 at 4:20=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Sun, Feb 11, 2024 at 09:30:02AM -0800, Jordan Rife wrote:
> >Sasha,
> >
> >OK, fair enough. I will send out another patch to backport c51c9cd ("fs:
> >>> >dlm: don't put dlm_local_addrs on heap") to 6.1.
>
> Already queued up, thanks :)
>
> --
> Thanks,
> Sasha

