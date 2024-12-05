Return-Path: <stable+bounces-98795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E3F9E553A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4C816368A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8912185A1;
	Thu,  5 Dec 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4SMMPZT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED4217721
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401050; cv=none; b=D78SGQ1HXgQU7lvnZrhzR0OQ4nIHKFjdWerD8h6tHEAgXOMw8AHLNM7wALo8RZtjEd3wvXRgxT9Ce8KkvJmTLPvqPoDndDkDxO53CStKXa+7lVlfuJ8r9iMb8Me/O0+bq6xsR354+iWvLV771a1y4u63Sv9Davc5Jk+Szf7G8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401050; c=relaxed/simple;
	bh=78ORj5MT7/pCML0JdAvmPGsZjpcS39rBDcRK9aTcAp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/wMtCUO6XyD80Ss7EeEpvYD6IATIF3LMbTbJJoBVpGt0aKpRz2J6M1raS7u8u4LIp/7IbOfJpo6ZrsoavXjMz8siojSt/l3b8s1EXIBxoWmwsRlDgbsj2nbG5QwgkMv8F6ZdpglDQuAQ9R9xiQLuEDQvtPAR0OHF9f+QAUNb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4SMMPZT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733401045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78ORj5MT7/pCML0JdAvmPGsZjpcS39rBDcRK9aTcAp0=;
	b=g4SMMPZTF/KcHbtuf9/3ZRKc6YHr0e36efijYzsGXjErKiWRxyHe+bRF7gOFa4jF6sfVG9
	Z/Q3RoTzmdH6FiJV5oSnk52NwmdiZmxjSnsjRJOqMXSRn78Wc9GoXr7t2Rtn2LpApZfVZi
	gLJ/3pnPz+Q1ry8Ka9g1+YekSfA84SU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-eJuywxgSO9WY34XEx_qLDg-1; Thu, 05 Dec 2024 07:17:24 -0500
X-MC-Unique: eJuywxgSO9WY34XEx_qLDg-1
X-Mimecast-MFC-AGG-ID: eJuywxgSO9WY34XEx_qLDg
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d0ca174864so507452a12.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 04:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401042; x=1734005842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78ORj5MT7/pCML0JdAvmPGsZjpcS39rBDcRK9aTcAp0=;
        b=FX8yQccM0fbHmmlZ0M7Nyea4ugxXJFhxNrtYqdAz8Xr5JOLT5pG8jNQTDa3JYRFka4
         XjtZh8Bz21TZNYUCw/xGJ4WXfo4yZEh49gI8Z5qzORo0ikyZMtNqPYxrhhP6rIfG57jW
         vCzA0mBbzFNZm5FaoPzLANE/qHDabWDu+i3ylVrG2VXo/Kfz5lq/zHGB3I5mfNN5QB/A
         SmuTonxEVU956pgKedBvCwP7sr8fPZP3BGlK8F87po33nDmU2tVvYW/8mdy/HhoKdAsZ
         O1PtPEPKzL1xyWiVcwzP6pq4Z//QiHmkM5ZVGq3SfmIsaQLmcxUZLoyfNg44Pnp36mFr
         4Gew==
X-Forwarded-Encrypted: i=1; AJvYcCVu3nLL+1/drvsaX+7AkRDPXeFNC9jOX4ehH2HUMwPKKrPzl8wBDvtJEjhCFrRfBdnhr+7nlpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0dh1ipypBslk6OErwbRj68URsAVUYdBMjFXI4mlVFX9DOIba
	v/9Jx7Zm8ERNRQXzwBoU2JqzQi9vSdziMdE0CAAc5tUmSsGm9DIQVOf617mT4RCvJSLWtm0/fsl
	ye/886gnMIlohfN+DRa0OIRhVsMo/g9RFCuPFrp9ZDGsYOw9WjMkyGPsohDpVrgNcHe6X0iUM2j
	QoWrApva7+7EanPrFPZLTqYoK20DN7yB4ALPwgAqcygIGu
X-Gm-Gg: ASbGnctoizT6ti6hhLO5UYefZewFpU2hZCuXj28Xy5vhVH1DNtGp4DsHM/wPSQTvKnP
	L1J3LXksPXqu2MBM47SKLPDCbQ2IbrUscuL65S5ICOnuX6BIqkQ==
X-Received: by 2002:a05:6402:1e91:b0:5d0:a80d:bce9 with SMTP id 4fb4d7f45d1cf-5d10cb5bf71mr6852853a12.20.1733401042224;
        Thu, 05 Dec 2024 04:17:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3iXCeT32h33RCPB/Nuod7nzqqUOSinEmle6v0DZwf71ur+JzfVPYQboWjeRhNIDMCipSgjS8it6mvXG5oPag=
X-Received: by 2002:a05:6402:1e91:b0:5d0:a80d:bce9 with SMTP id
 4fb4d7f45d1cf-5d10cb5bf71mr6852840a12.20.1733401041869; Thu, 05 Dec 2024
 04:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com> <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
In-Reply-To: <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 5 Dec 2024 14:17:10 +0200
Message-ID: <CAO8a2Sio-30s=x-By8QuxA7xoMQekPVrQbGHZ92qgresCDM+HA@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The full fix is now in the testing branch.

Max, please follow the mailing list, I posted the patch last week on
the initial thread regarding this issue. Please, comment on the
correct thread, having two threads regarding the same issue introduces
unnecessary confusion.

The fix resolves the following tracker.

https://tracker.ceph.com/issues/67524

Additionally, these issues are no longer recreated after the fix.
https://tracker.ceph.com/issues/68981
https://tracker.ceph.com/issues/68980

I will make a couple runs with KASAN and its peers, as it's not
immediately clear why these two issues are affected.

On Thu, Dec 5, 2024 at 2:02=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Thu, Dec 5, 2024 at 12:31=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > This is a bad patch, I don't appreciate partial fixes that introduce
> > unnecessary complications to the code, and it conflicts with the
> > complete fix in the other thread.
>
> Alex, and I don't appreciate the unnecessary complications you
> introduce to the Ceph contribution process!
>
> The mistake you made in your first review ("will end badly") is not a
> big deal; happens to everybody - but you still don't admit the mistake
> and you ghosted me for a week. But then saying you don't appreciate
> the work of somebody who found a bug and posted a simple fix is not
> good communication. You can say you prefer a different patch and
> explain the technical reasons; but saying you don't appreciate it is
> quite condescending.
>
> Now back to the technical facts:
>
> - What exactly about my patch is "bad"?
> - Do you believe my patch is not strictly an improvement?
> - Why do you believe my fix is only "partial"?
> - What unnecessary complications are introduced by my two-line patch
> in your opinion?
> - What "other thread"? I can't find anything on LKML and ceph-devel.
>
> Max
>


