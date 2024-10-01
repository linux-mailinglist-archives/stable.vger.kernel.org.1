Return-Path: <stable+bounces-78313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4198B2E4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 06:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF6EB22A42
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 04:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D431A1B1505;
	Tue,  1 Oct 2024 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="li+WvMYY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E07A5F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727755380; cv=none; b=FnIBSLv9hB450E725DOrsgfuVE87lO30pRVz1wTHEbVydE4WDqCgZ/fQtuHk78aa9ODER86m+NgtYY2e9zpIz7dEjGPlGGCEgel9ryrUEvmj/AQ1YaQaMCLN9oFXEjiNE6e8MIna4W/vDEI/xb4KNqwYdCpStLF0M3B0Tf6QYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727755380; c=relaxed/simple;
	bh=800dj50hiqiv4VKa/htAmtbzQb6fvCF7Hp4RcYx0hx4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a+kZ37VwtG+kvkxLzk24697y2+pu4oBCL+6BQgcO87KASoz+PDtf/DW9KxAgUqYKK5MXZtpaSubzc3v3Etybb209caS1JJ1TC1/UrTyKX26wLSwWs5/jR0SNppbhef8NH4N4mxLj2vE1hJwvT8p5ghatSjCtsznx3KOki8J213w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=li+WvMYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B567C4CEC6
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 04:03:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="li+WvMYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727755377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=800dj50hiqiv4VKa/htAmtbzQb6fvCF7Hp4RcYx0hx4=;
	b=li+WvMYYG7hhoHXde+IOvRtktoEYnVaUd6FWa1TfR0wwfedL6XZ6L4wbS/WwyhuWfpQ/4e
	2iWVVC4Umd8+JgLrPSuIyr/nsb4JVd0vY7ISDb5fhWG6R17ZFHRZA6oYLPHft9/TnHGEj6
	KFDmu79R0BVI0LwmrFZkUKQkk2w+4hg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 44023b80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Tue, 1 Oct 2024 04:02:57 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5dc93fa5639so2522116eaf.1
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 21:02:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgeNBl1ZckHUdZC+5lFA7b665OQxbyLW+qJbGtbGl4iQYlE6kusK62rpfQG4E0iea8RL6KAyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZX/Gc9qx40tyhkIqedqmOfhhS6bncJ6dRMQMom+qOajPQoIlU
	rlfs1kMrucp2D80ss5pNozmdTSzYWsZq1sbZjDQa0QmMDqe4+wIUQGxvOvQfD8Yu1dy1yWF1lFY
	8vPm3lccOV+DnaAr1yK9MKo4bN44=
X-Google-Smtp-Source: AGHT+IFjD+jV05s+DrmD5oivHPnc8dyJbra9r0XANOCX6eeANO71dLKbf5KGOiYhQpoKQlhFDf/m5RfwesEznqDLlAM=
X-Received: by 2002:a05:6870:2251:b0:270:130f:cee8 with SMTP id
 586e51a60fabf-287109f5bf1mr7583711fac.6.1727755376656; Mon, 30 Sep 2024
 21:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 1 Oct 2024 06:02:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9rtJ1YZGjYkWR10Wc24bVoJ4yZ-uQn0eTWjpfKxngBvvA@mail.gmail.com>
Message-ID: <CAHmME9rtJ1YZGjYkWR10Wc24bVoJ4yZ-uQn0eTWjpfKxngBvvA@mail.gmail.com>
Subject: patches sent up to 6.13-rc1 that shouldn't be backported
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

I've been getting emails from your bots...

I sent two pulls to Linus for 6.13-rc1:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a39ac5b7d62679c07a3e3d12b0f6982377d8a7d
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e1a5d43c5deec563b94f3330b690dde9d1de53

In these, I'm not sure there's actually much valid stable material. I
didn't mark anything as Cc: stable@vger.kernel.org, I don't think.

As such, can you make sure none of those get backported?

Alternatively, if you do have reason to want to pick some of these,
can you be clear with what and why, and actually carefully decide
which ones and which dependencies are required as such in a
non-automated way?

Thanks,
Jason

