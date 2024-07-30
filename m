Return-Path: <stable+bounces-62807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20694136E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10A11C235C5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9DE1A01DB;
	Tue, 30 Jul 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy24zIJP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656419FA9D;
	Tue, 30 Jul 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347029; cv=none; b=RpkXPqdl/mYoqAgrFbBeQQ6NeVxtVRnNU+4S/gO8U1FKvu8Nzf3SnU8QV4Gq+Sw6wvgNeAtSe2oqC4Y9M+L8cgiKVbUOB48eWORW3dcvcLa8eyxglrz9BJ2io++sOzhva8AOqg/3Csw+nsddr40/vR0G5JCICpIWlV25CJR9FtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347029; c=relaxed/simple;
	bh=luHvXeKnY/PrZwEP44sNc3lYYJs11kxHZzy1zyXTx/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBEGfFkA4AvY8YzFM6jeiowtfMbzduxh1IxDT2b5nLGbBuFD9bRWWiIs5YARnRRKJRq8QWNYr+5j+33x1TR/UjHXzlsm0S5axH85ggXFxZ8jqiwwHe8j94Y30JbUQskmTrN+ZLNXzVbCuXrM21pz4TSUWjWt1/GsBh9zAcbMw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy24zIJP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3687fb526b9so2108356f8f.0;
        Tue, 30 Jul 2024 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722347026; x=1722951826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtgxA2PssDFaogYfTQNLJ3b/Lh3FbXzi+L0/39/oBQ0=;
        b=gy24zIJPfSuk99gtX1KUqOJLJCWsycC3VFFC5T9wsgUbI4+uoMVX/v8Qyf505FJYY+
         ZKDGv58ZMy20J5E5QdKJ3l5Iuy9QN0eyxhLnt5HvrWNdIRVuHoRqBNEkpIiZQToPoKSl
         NJyooZfPyPwP0hwSEU6joZedI7F2R/kqmFM0Iw3ytcvSBpOnR4EzGrzBrAl9ZjHPGz63
         +BEUaD5/ltMqxgY+VEBedbkj2Doq0wlg4fVL3U35cI+wCy/rvTujCcH/Nwe1FIyT+reu
         q505cgE5kc9BVlF+GNQeBdL09F1wI0uCigocYXlvw1bwNuWysjOKTWQkBWdQHln+hDZM
         mliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722347026; x=1722951826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtgxA2PssDFaogYfTQNLJ3b/Lh3FbXzi+L0/39/oBQ0=;
        b=su8ANDVOHq8tD70Dz1G/MH0xFoI6KFOC/5j6MDi4H0S8RFewIjIE6mGUVhs/1jt9VW
         RGgCDcaM+1c4vxnzJtcmY/OWNMeOu/N+Z2r9E1oJzST/t0frmJp/2QcrtqRFXv1M4VAS
         g6atCQ28mduh7ZbBELIZ2E0RJBGTLmRiXeoChOzKp+Q1Jtt6hT4t6nNiXw7yZy8yKste
         SS6r/iPouFGTBzR2RfzVlzWExbnJdrYtsCCGRdC7mNz9nTGYVXJR2wgZYqBPlmFaIsxg
         q1rIRFheWx/8AXWehUtE7xNSvTM7rf3R+n7oVTB1JvpCpCV2nTjyhnMnr6Rd4uIn4Azc
         A3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqozKYPKYkjUxUmNEC76ZESihLTxUOjCIlisMlItXnPPSYt14Nqh2XK7izTf4ThZ7CVM+7TwPi5NOLQiGYSNNn3rN8dMJK67Gg+xHlGu9pPHL+CyFAixqzvsQOa+t4BaG27vOzQEww+2RM71E6Fjs2yVzCfGw2TktFD0gMjbUv
X-Gm-Message-State: AOJu0YyzWtVaISwKc4FZkJi0L47Ve8FfcOJKhYu8dYeogkooz6XNd0dI
	jOs8L7SyAXwGZNGcOs3o4ocuoPRu6s41JnSKnPryjSU8rVfI/Mw8knr57L8n5exIsJL1PoN5WQV
	8+oFopXpflBjo5AM1L+AZHKS2YKA=
X-Google-Smtp-Source: AGHT+IF/IGsg58iKG3GnfQw+6W1bKQo6nzfvGP/3nOOGv8qkaWDadLz8++6LC/scQFwOoZMV4Hgy5eSjT7gI5UTPQr0=
X-Received: by 2002:a5d:59a8:0:b0:368:747c:5a05 with SMTP id
 ffacd0b85a97d-36b5cf2534emr8775942f8f.36.1722347025779; Tue, 30 Jul 2024
 06:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729022316.92219-1-andrey.konovalov@linux.dev>
 <baae33f5602d8bcd38b48cd6ea4617c8e17d8650.camel@sylv.io> <CA+fCnZcWvtnTrST3PrORdPwmo0m2rrE+S-hWD74ZU_4RD6mSPA@mail.gmail.com>
 <d4ed3fb2-0d59-4376-af12-de4cd2167b18@rowland.harvard.edu>
In-Reply-To: <d4ed3fb2-0d59-4376-af12-de4cd2167b18@rowland.harvard.edu>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 30 Jul 2024 15:43:34 +0200
Message-ID: <CA+fCnZebutAq7dfzutMhp-KO0vwM67PC7r4FRHPUcY1eg5rW3Q@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: dummy_hcd: execute hrtimer callback in
 softirq context
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Marcello Sylvester Bauer <sylv@sylv.io>, andrey.konovalov@linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com, 
	syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:01=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> > And I also found one more:
> >
> > Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dedd9fe0d3a65b14588d5
>
> You need to be careful about claiming that this patch will fix those bug
> reports.  At least one of them (the last one above) still fails with the
> patch applied.  See:
>
> https://lore.kernel.org/linux-usb/ade15714-6aa3-4988-8b45-719fc9d74727@ro=
wland.harvard.edu/
>
> and the following response.

Ah, right, that one is something else, so let's not add those last
Reported-by/Closes.

However, that crash was bisected to the same guilty patch, so the
issue is somehow related. Even if we were to mark it as to be fixed
with the patch I sent, this wouldn't be critical: syzbot would just
rereport it, and with fresher stack traces.

Thank you!

