Return-Path: <stable+bounces-63469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B409E941913
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63E81C231A7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB501A6198;
	Tue, 30 Jul 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HT0hz34A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B941A6196
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356931; cv=none; b=nkUfraARPw5nuTMbEoQP5h1jEwo+B5hYVw0Tei3LjUjjawl3930PnFKCrb7xvt5ImUYd7pb4Ds6UeJIl9BcaCR8L44CAg9ndv+3Z75vhW+n5aFKU+qjja58WhHtwX44uUHqJxAiHro8aShGUo2tKNTQKKxGEWkBtaWEXiSbcHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356931; c=relaxed/simple;
	bh=/WrqX39V/EGZlU7gkM+jA9j7Jyn0OjEJ1Mehdy12oxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUw9lEXt3DjadspNYD9GtdHaBaQlasr+FpTjyZk/zvwBPirsExteCaaNclGyptIbrr0Juw8DQZOH0sww/K1HnoLioj6bKhGB3ATSG1sKMtXRYyeeJs0Fzu29UQ34nA3TUg+SH7F+cVA+ammA44pkxZeDMERStEuwKo/W+artd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HT0hz34A; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so531566066b.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722356928; x=1722961728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfuNs9RJBxSHtgXaAG8xtdh6dR8/ZJRWqaxb2ZGOGQw=;
        b=HT0hz34AV6AQOhCDOqRoWZOg8kSqMBzmx3P6JlVSEUBoBqcFqHofONDiRu4Te+WWVq
         p6Y9EKYcyc457hg/5hRi9b9iZ6xBfdo5bQRyEEIpwQ4XnSNZAaCzf7TltKeESxQMHeLe
         mtVXoJQ+ti3kIitz3bRxYaMul+afdcJDVDujtjjkvBj08on3jxBFcipcMnjJ7H14hGg8
         Y8le95YOsIFhqGJ4oaFJPfQpa8G+12t+p1KcxSwncNJeNzUv0YowLBg+rbE/srCOuhup
         3wRKfhcWAskV8UVaHV+vaminX6hgYEY2F08gIfQIvJs4F2V8k/q6TGL7qR66XHH0RAQv
         wwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356928; x=1722961728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfuNs9RJBxSHtgXaAG8xtdh6dR8/ZJRWqaxb2ZGOGQw=;
        b=jh9KlJYERBhlSXP0qMdu89RBUhLE8aynNWRx5nmDS+jhVBwjM+k4qJ44ivzWAY7Q7/
         WHJapDEPO0dwbO4fdxRyyvjSv5pNk8hFULSa2DfdxwvuonQA/XQa1Zdbf1WUhB7ycuCo
         aDhLnVObXYiNNA9eRdyOPWm9NN+3VpqZdOgEssPOn9kuYVTxsK4Jf6nrFFVEVPkztLRf
         4wAR5dSoafQP7ErD+8uFPwrzl9oxRyE4JbnLC8MjfNdEuczMiRMV3fAvjTjcgWYUVFYK
         Y+2IIuGOPJ1lBjLow88CF1tYA151zo8LkKRPbYsTp6M4HRpjPgy9Xx9LsC/JoO2WvvQm
         pe6w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+YoQcYa0oDUj44WAZ7rSVJDd+hig8zvxMxGd6TPhPl06o184rHh/yj9g+wBLkb1mM/+qMLErU09MQ/KZCa5uI0YLYt0e
X-Gm-Message-State: AOJu0YySK2T1xPHGVYFQeVZJC6Q3vl0aX4i484hYm6ulSMWY6FEO9uV9
	4tCHuum7z9MOGIS1F0fRqV3U6563CjzxHhH8WOZQvWn7qMjdxkhMtkLf3TdoivamBUWY7ntwjG2
	qppEYql2nF3hpSGt9qKHOxq7rxsHendiMaXH5JA==
X-Google-Smtp-Source: AGHT+IG1VcMHenRJE4OMv8Wdwm4JETBLEpAvJgISa1/m5vlwH5K/nlA4PdfCRxYRpOU0UfdTVOnSQCZN39wxbmaGSUY=
X-Received: by 2002:a17:907:96a0:b0:a72:7da4:267c with SMTP id
 a640c23a62f3a-a7d3ffa612bmr940477966b.12.1722356927933; Tue, 30 Jul 2024
 09:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <3575457.1722355300@warthog.procyon.org.uk>
In-Reply-To: <3575457.1722355300@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 30 Jul 2024 18:28:36 +0200
Message-ID: <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of
 PG_private_2 as a second writeback flag"
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, willy@infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:01=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Can you try this patch instead of either of yours?

I booted it on one of the servers, and no problem so far. All tests
complete successfully, even the one with copy_file_range that crashed
with my patch. I'll let you know when problems occur later, but until
then, I agree with merging your revert instead of my patches.

If I understand this correctly, my other problem (the
folio_attach_private conflict between netfs and ceph) I posted in
https://lore.kernel.org/ceph-devel/CAKPOu+8q_1rCnQndOj3KAitNY2scPQFuSS-AxeG=
ru02nP9ZO0w@mail.gmail.com/
was caused by my (bad) patch after all, wasn't it?

> For the moment, ceph has to continue using PG_private_2.  It doesn't use
> netfs_writepages().  I have mostly complete patches to fix that, but they=
 got
> popped onto the back burner for a bit.

When you're done with those patches, Cc me on those if you want me to
help test them.

Max

