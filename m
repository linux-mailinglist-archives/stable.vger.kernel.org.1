Return-Path: <stable+bounces-112008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F2A257DA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BAD166F52
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB3202C3A;
	Mon,  3 Feb 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2Bl6RE1"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AC1FECC7
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581312; cv=none; b=g7lRD+o3QFXegKJFAZE1Jwhuhic1hI4y8juHJLmtTuQnbDkqTj7dGPsEqXRYewlBTUFNJkWH8Yj7WaThS14evM/v/4kdMUqGZN/E75W90v/REwX6LUa44tRST9l8gxqQXsdPmlpwOZ44uZzEMalW/HCOgXkTfHCz1M0Z9+qq1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581312; c=relaxed/simple;
	bh=XVC1ndxrZaLe+d05VFLtvNnU3D6DLPiWOoCaBqgVZk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxnV1Ty0H+uK+4Pfj7qZ9WXR2Oqoq99fYeu/Y5p8LExLlSuAeo+QG0eT7mkwj8369w9hYIO7BSGFeS2wzKnrhmJu/ON54UZECKdodcqmSDkmf1pABB3b1cBidaHyeDGazLdyg7AuUyAEOk9fTq2cualE3W+7E7vqsEV06FXCfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z2Bl6RE1; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4aff5b3845eso1723388137.2
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738581309; x=1739186109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVC1ndxrZaLe+d05VFLtvNnU3D6DLPiWOoCaBqgVZk8=;
        b=Z2Bl6RE1KtvROhkeEGCm65oW8bOJLk4WHhBeTCCsywaLwua2cxOpq6Ec3HLkMNWutL
         QvM4LXp7pp4CBft2pT7NhreMTME8u5bc6IVdgQw/GYHhDd8e1nJlTYq2QmMx0yxo+a58
         xxpDirjX+XH6XwDNSE5HBMcCCg6nfAAMkTHkLwUuhHSBakAlAFl75Mwji3BeN/TW1/wi
         pTqcunXiF6TKs0vf83QWlU/F1LZ2HXKyTLQ/orqLuhyAsKm0KUAm4zRamPwO6IWjZ4PR
         fdAZ6Gnqo9j4wFyatqBXROFgcZri8FznPVwBDfEz947WbE+KbP62fiPnuABavm0d/ZB7
         MgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738581309; x=1739186109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVC1ndxrZaLe+d05VFLtvNnU3D6DLPiWOoCaBqgVZk8=;
        b=huFjcXVx8cRBII6w1EI8h08f8tJFt7R9NQPogLBXHaQiE4x+SkXp5VgtJD0h4s5jG6
         DY+J5Zyfapwz6zK+ZVlTPSRy6A/m8by2nw3py2I+i08Zy7mok8CBN9qNLM9W9L6BA0pM
         rxwRaZjCsVV+rs8Zli78528RLp3/cL+wEw0A/rVI1mWCBz/ZgFqnitYOz/pw/bB7nU4+
         HhEPSw2V9GT7eD9d2I/vnt2YBAtGmCnscGbV11oZDYEpD85HVGxQMfpV2vLR3rV9hz8/
         FsInb9+reDSwP5D0QHmu6SI3NZhguDm82W/d0TJSLxfjXy3h94sEW1AV6h/qWTj75mSL
         IyMA==
X-Forwarded-Encrypted: i=1; AJvYcCUl5Tt6W/j2z3yV68aEg6D7uubMY29hj6mMZG/kgyLshESp47p98LGxEwy8iyra4Qd+7o9/Swc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzzJWFc1iK/dNhuMVc/pOFhVYf8ykJY98MCGSr1VINOMOBdbA
	NCbCrYD9D9y6INr0s05Y7C4UWZVjn2ELwtAXqe/ZM5fwoA0q4jWBsE8qwqPzGH8C+uH9JQXKJAg
	ZoyCfKapR4QhgS3qbSM6jIT1qQHaO2/YEp0ZJBNXVn4W+L1pzKro=
X-Gm-Gg: ASbGncvSxzQKBHAg5ySiTkz0k7V1tEO1CsWQm6U6cd8MFDOT1lZH7UW1f0PrPckOKth
	P0q/H8VUuiqVgLBnYUrRKRKQjzNg/QaFxoS8PzWJYGb5r5n1vxcNnvmf1YhCQ4TT5So/C0/61hY
	I=
X-Google-Smtp-Source: AGHT+IEZJ4ht/4JUca00rjKHmLI0x0Tdnx3LsSJdqx/Ig8hvd7BRVwnatUEMpzWzbQ0C4BBpkq6dQgnAG6j4jIidAXE=
X-Received: by 2002:a05:6102:3706:b0:4b1:14f3:5d6d with SMTP id
 ada2fe7eead31-4b9a4f10c27mr14207280137.6.1738581309555; Mon, 03 Feb 2025
 03:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203080030.384929-1-sumit.garg@linaro.org>
 <CAHUa44FXzL-MZ5y7x6qrsn3GJR=1oR8bbRVCv6ZTvDRoQmENEg@mail.gmail.com> <65aedfdf-0a13-445d-956c-6945f1b49681@app.fastmail.com>
In-Reply-To: <65aedfdf-0a13-445d-956c-6945f1b49681@app.fastmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 3 Feb 2025 16:44:58 +0530
X-Gm-Features: AWEUYZlSri3MYlCywfp3d6_FlDHi6H482QnGSZIllNXjxdK5HOntcqkUnai1PoM
Message-ID: <CAFA6WYPt+DkOXd_0Sj5axH+kMx+NtEc+7rsrn93Mk9aDW2Sqbg@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: Fix supplicant wait loop
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, op-tee@lists.trustedfirmware.org, 
	Jerome Forissier <jerome.forissier@linaro.org>, dannenberg@ti.com, javier@javigon.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Feb 2025 at 16:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 3, 2025, at 10:31, Jens Wiklander wrote:
> > On Mon, Feb 3, 2025 at 9:00=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
>
> > Why not mutex_lock()? If we fail to acquire the mutex here, we will
> > quite likely free the req list item below at the end of this function
> > while it remains in the list.
>
> Right, I had mentioned mutex_lock_killable in an earlier reply,
> as I didn't know exactly where it hang. If we know that the
> wait_event_interruptible() was causing the hang, then the
> normal mutex_lock should be fine.
>

Yeah for my current test scenario mutex_lock() works fine too but I
added mutex_lock_killable() just in another theoretical corner case
being stuck acquiring mutex while someone is trying to kill the
process. But let's avoid over complexity for the time being with a
simpler mutex_lock() approach.

-Sumit

