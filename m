Return-Path: <stable+bounces-203344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165EECDA703
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 21:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09713012CF5
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 20:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BE2D060E;
	Tue, 23 Dec 2025 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MLMwxp/o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C6288C2B
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766520229; cv=none; b=PglTq3NpSWb3AjMfXTIu9jzqdmzW52UNhkp0DZxtGmzvrkuJx1XH8/vJWpLGpeSEmB0FmSn8frmMDyt5BZ0i3nwuZuoa47tWzcS5QHe0Omic8BOMAnJF5b3eZ21GZLxHYqFhQ4STV8u4LtGLp9jDuMuJyDFoohkolUBhCxdyPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766520229; c=relaxed/simple;
	bh=EXQmZ+ozp92HfDFtU0evQ90fcQtPfdOWiSV8UAQt5MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5xWOB1LL715Ys0uFsxgpedErB8rzJOt5mmmUe+4rKbaEc4nlxIfzHpcNLLkJEibcsmgbz8F9ehErw4H2gZ2aJPT6OmM7rVy44Q60TNODkTEMqqtBqEhqW01lXIGBerHYq5oBPWvLWWAI4QSowekgdxCVvMNtnG6+kQGpM8hQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MLMwxp/o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a07fb1527cso12353955ad.3
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766520227; x=1767125027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXQmZ+ozp92HfDFtU0evQ90fcQtPfdOWiSV8UAQt5MI=;
        b=MLMwxp/osmLovVn0YNNEHO3LMWMGDo0dtwQr52ZvP3Jp/TwraAtvUVn1+WNm33dwBD
         ypvlTtmVLPck4I7Wsm6dAg1l7AudN1AgODexfoVQhAeG5vVoD74pbuQFt0KQvY95rbwR
         uWIMiCSrBkNJvUXttsnHoYGwzlzCknC462jOTHCCfu7EIYjGeyiOR22Ozs3LDjqfVNeO
         3pnCGHDElWx1OD8N3VkAs0ehWsh77ausLN/+M/bc22evdgqyalgcIhMIBT7OetVecYTx
         QOg8vhMi/S1dSyJxpsxruDgks7oWJa5sY0L1WgYVXOc8i1g19jDActBIUgurTd//ScrZ
         1Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766520227; x=1767125027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXQmZ+ozp92HfDFtU0evQ90fcQtPfdOWiSV8UAQt5MI=;
        b=pf08Yi4u92BzLL2nH1YfFDukTdz1B+UM0xh6nlyVTT7rNYpTaPDOIdIFr/JXe/L79J
         1ABSz4RtRt9U627Eqxg+uXD9TIRZ5q6Ld/9Ucqn0wZ4tiWil/ZlbWtOJLdi3tGb2PfM8
         kw13bOQIMnXUBSFtg/2c03KWYQ7bkChMT7fVi31JTx7J7TrQtaq2oCVehuGCXqBjt5ry
         +p27ObHqVRfNdgbIpYeQ9RQCrLYoa5HOTDfsUY/0uHV+dQM4dQluJQj6kpKVdBq9s1uR
         RB/+kXDy4yHoSqIf3GWbIsjN+zqR+HPG6TbUahjucx2nvTs731CCBwcj3U8nFYTZqSFY
         zvVg==
X-Forwarded-Encrypted: i=1; AJvYcCUb1o72nXKw8H++y1ntrh3fxfA9kBp6arRUQRgP5PiYOEGPWHU4R9PUcQiEKEQzpaOoOWAxnlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWs18ZszSYknPR0LUwfRwRQ338tgfuWiHYRoxgXog2QMO5Cma
	SX7UGssTkNoMDB+YJ3ow8XRkp57i+At+2XSfxB0UQ5442lFFxvVIvb5hKCTm3/LHlLRc/ExTfqS
	3V+zj5JU8ZHZ8fEyp6pZFKyQNBPlnhrb7wVmjcTxB3Q==
X-Gm-Gg: AY/fxX6PX73TvkL69zHES63rDAAhsAE2Vk68AGC2c6++ds60gaBhLs5gBeerBn4uB5N
	zClewEaj5RORej93CQXlach4NmSugFVU9SLzruQuZiHnqBuFjCcDZiiVIHUYuuw6dO8zQzoGVwk
	jB/mOo9n0ncbtzHqXi7afIsTz5pdIKAeTKKNQUNpaGtfXa/QTmBul32Em6qMfYQuPkvVwu2TAhI
	bKl8zq2cerH+MIdgP1nBlKtn9FOnKJOeFn1Y7RQdFODqpzMHIie1LZzzjAdwgmvTGEdh+s=
X-Google-Smtp-Source: AGHT+IGEI2UFmVAB4gllSBCn35IWH7aIKwKwDq37q/Gg/8+joJI9uLy9sV66UHOMqlihr3VacCQHuLlnSQLFMc7ZjsI=
X-Received: by 2002:a05:7022:698a:b0:11e:3e9:3ea4 with SMTP id
 a92af1059eb24-121722ec1bbmr10272339c88.6.1766520226788; Tue, 23 Dec 2025
 12:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220095322.1527664-1-ming.lei@redhat.com> <20251220095322.1527664-2-ming.lei@redhat.com>
 <CADUfDZprek_M_vkru277HK+h7BuNNv1N+2tFX7zqvGj8chN36g@mail.gmail.com> <aUn_PVBQ7dtcV_-l@fedora>
In-Reply-To: <aUn_PVBQ7dtcV_-l@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 23 Dec 2025 15:03:34 -0500
X-Gm-Features: AQt7F2r9LaRDNvbGZXYzIITBheOEsP1_Fp83pg5yHWOiPm7yaPAaLXCI_g3bweo
Message-ID: <CADUfDZogz4ZdVQw5O5stBuheyX-D4CfdZ8XoGqiXBqdp1oQHQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Yoav Cohen <yoav@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:32=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Dec 22, 2025 at 12:11:03PM -0500, Caleb Sander Mateos wrote:
> > On Sat, Dec 20, 2025 at 4:53=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to sup=
press
> > > automatic partition scanning when starting a ublk device.
> >
> > Is this approach superseded by your patch series "ublk: scan partition
> > in async way", or are you expecting both to coexist?
>
> This one probably is useful too, but it should belong to v6.20 because
> "ublk: scan partition in async way" can fix the issue now, and backport
> to stable isn't needed any more.

Sure, I think it could be useful for other ublk servers too that know
the block devices they expose won't be partitioned or want to more
finely control when/whether the partition scan happens.

Best,
Caleb

