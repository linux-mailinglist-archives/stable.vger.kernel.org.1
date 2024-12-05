Return-Path: <stable+bounces-98797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F69E558F
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E261018829E1
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C510121885A;
	Thu,  5 Dec 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="F+hnxEN/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668001DF96E
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401975; cv=none; b=jA8t+vazlu/vp7AlEiX5S5mdpFtrXoIcfehxvwviRo6bW2uwWPvWHbKNxMp2LpjnvgzXCMMH7N/UXl8E74H7sorHQ+7XSfrpE+pS9WNXx/QvWWH4lDxuFNEmm12ms8CLWa/cEMADjjNtaLaUn8awlD8zwmbikylMt22mcL0FjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401975; c=relaxed/simple;
	bh=SICq+z4FvKUb2+AsoJsYpc3oHluBTbU20hPC//BJVrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N08RoYztPCjH2enMfH8VgZ6YdkJThL9n4VrVxfQeSzFfmh16ECMxALaE+ALwl5AJfqx/AUr0vDpmjVfBDKVt4VGMk1cKbUhDuzs5zzQjRvHSwOyLz0Ca0YXfZLiARS3rprrI8BbDnzEls0s/HEJ6Kd+RuuROvYCj43DCLVJNgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=F+hnxEN/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a45f05feso9348575e9.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 04:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733401972; x=1734006772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SICq+z4FvKUb2+AsoJsYpc3oHluBTbU20hPC//BJVrw=;
        b=F+hnxEN/qLkKroIT8JQLr4+k/g9FNGJajepfIrnBgBde8zZ5vPEICXk7ZTG9qDMgXv
         sVDHvQVFqT3QBZICxLjYve/juv3p3ESLpexLX82ocBxV6C/fP3DtzevaFnXy6dtjM0dH
         a842tlWPsuaRaVZ/RoeMKI1rhnr6pmhOmRbISknZSkxBkkurvA8qPnPiTQKcFtGg8Wae
         adOcqh2CJRpHLnasye4txY2qdrFXtDx03ubf5hdOo5GBgJSuhf+ujn/li/aWxrGY6i8Z
         X53D8/1TWeO/C+BMveyd2WuJ1irVHgnyHVRsf9Qt1nulWiRV2uLo9WUpOIAXPt3XMWdN
         1+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401972; x=1734006772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SICq+z4FvKUb2+AsoJsYpc3oHluBTbU20hPC//BJVrw=;
        b=KcLcbYYzqzTcGD2vamwia61n7X0LJkoCZue7+Y2oZAbrWS5/i2DUB0U+0Hyfja4hjn
         wDnMc5FL03qGMkpSxJ3CjdBQEzG4myv9s3Pl1IiH+HdXNCSHFETKmh2t8pXwxQDI7FTu
         IUQDWvXbzkG/0pU78xG3KtO6pGQ7rRsxUKt0SFFOQgWeLKTLof61U7oPlwsO6Vrte+RM
         mNM5/kXzBEnd3cve6YOnFGfHfRHXDf6IavByRJICkeWBbns8eqU3B3yRJ0928V37jhDc
         SIEnJjNn/rb3ic9q76uH/hetZCI++ks4QySQRNf74BlnsBQDuXEvCzBhSAg55KcGF+F2
         ItYw==
X-Forwarded-Encrypted: i=1; AJvYcCXMN+UNt4f5h1C01eyd0C9wA3F2ueWitLCFEQj2ehHN2mUjOrIuteWM56XhpA01UM/nmAN7DdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vAHWT+uZXPJ28yRls4Ic/HwBF+eJC66FYatNe+FDP66BTvbw
	/sxuLNKYsAFZEKnIpgxkFBibDNPm/nRM6XBNp8gRimkFDgUyLQSdtPC9d9lwRAPa8mgzqXrWG9E
	yMfkjv9oPErcAZFGHTdJHQaWDsUUjZN61kkkZqQ==
X-Gm-Gg: ASbGncuaKnxUDyfkVoorrEs2LQtUkzh7gpGIRYbdjj/ISBEXlUW7La/HnnG2+pcXUV5
	IorKuBFQy/bUPwIjzgDfNz8mqLLQJlDjb8FQvp0TXySYrNfrmywEE42Mq+/dd
X-Google-Smtp-Source: AGHT+IGBUMPYkDHhpZtgXkNGZC5MuZ6zkQdIJVzzw0g4SwoSv7vgu3hK9RNRvwJ1OBmrpl6dqNbtn9oqap/F09Uuwpo=
X-Received: by 2002:a05:6000:1acd:b0:385:fb40:e549 with SMTP id
 ffacd0b85a97d-385fd43c259mr8451126f8f.55.1733401971756; Thu, 05 Dec 2024
 04:32:51 -0800 (PST)
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
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
 <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com> <CAO8a2Sio-30s=x-By8QuxA7xoMQekPVrQbGHZ92qgresCDM+HA@mail.gmail.com>
In-Reply-To: <CAO8a2Sio-30s=x-By8QuxA7xoMQekPVrQbGHZ92qgresCDM+HA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 13:32:40 +0100
Message-ID: <CAKPOu+__w0yphmYyCX32_RkSqt1dMB-w0iz45q+B+Z6Ve-p0Qw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:17=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> w=
rote:
>
> The full fix is now in the testing branch.

Alex, yet again, you did not reply to any of my questions! This is tiring.

The full fix may be a "full" fix for something else, and just happens
to mix in several other unrelated things, e.g. a fix for the memory
leak bug I found. That is what I call "bad".

My patch is not a "partial" fix. It is a full fix for the memory leak
bug. It just doesn't fix anything else, but that's how it's supposed
to be (and certainly not "bad"): a tiny patch that can be reviewed
easily that addresses just one issue. That's the opposite of
"complications".

> Max, please follow the mailing list, I posted the patch last week on
> the initial thread regarding this issue. Please, comment on the
> correct thread, having two threads regarding the same issue introduces
> unnecessary confusion.

But... THIS is the initial thread regarding this issue (=3D memory leak).
It is you who creates unnecessary confusion: with your emails and with
your code.

