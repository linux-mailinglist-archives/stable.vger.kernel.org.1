Return-Path: <stable+bounces-67532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A8950BC5
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8D4B21ACC
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C051A2C3E;
	Tue, 13 Aug 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RtjXOGN5"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3922F11
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571762; cv=none; b=ROmLwDKnXs2NqeX7HerrZ+LNkq1nQilZlMjkmTNIz2n/YdOiR14YAphrSobjHuQL/wmkt/CBrg+7J/iVx3VtxQHYnMNcyyUZ5ZbOXBmz5twf1mVfRxUKy+YXIR6+ddOQE5GAg+OVdPL869nn0ZU0NgICzy4uVGP/YhfOKWm+VIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571762; c=relaxed/simple;
	bh=0pMTC13umCQde5/8BsElILG59mfNSD3ETOHB+YLFOX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/eELEiHuH5yhxc6QgDmpVHwNH2Saj5ln6j7WT82ILi5STAonAxxiqzFcB5fEnWoEx6o7+Ihi81Zf43Am27AhrXslbtW5hLgjzdaB2ugT2v2P5VsLenasgBSM8FjrUk8dJ03DYc81Yv6BqRWyU9rTQ7+YwTYvbQ9nOl+F4pZy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RtjXOGN5; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e087641d2a2so5644280276.0
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723571760; x=1724176560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pMTC13umCQde5/8BsElILG59mfNSD3ETOHB+YLFOX0=;
        b=RtjXOGN5ZHzeUurD3C602mSxniuUjBUzJd8nXIYtmegY0w7YpgWiW4A/oPuHMadUQ3
         ceKiUPjYchMVyr1UQTBcSyXwR2diat/UTKVZ7DX4aBoW9ZZ5D8l9i68x24gJUop0eQCm
         ITAjH+PvrYXZ8tPkEF5p43nmcV/+EwZd7jqoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571760; x=1724176560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pMTC13umCQde5/8BsElILG59mfNSD3ETOHB+YLFOX0=;
        b=foJjlVeMjUCVu3pxJGEpQcMHUN0KlD5SVOL9j2yilpvKPCIoUH3ERLdt7/D+Y06Dqz
         rZYRe6EwQ1AwUl0CJEpZbrpthqWs9lUjMQkxGUtBKp3orOAGq/gxuI4EYBesSP/yEhqK
         /PaWCT/555Vc2UkfkaJ6UOOD89JY0YaBbeJBdOBAQzYuh2NDsYmU6jeGAZ5f7nt2cuw1
         rNiqa0Bft+B77QImxyxsYdVkxTc1F0BcoXIT1sAJX6Smay/0xSH7AwTgnTwMtLIOJ2CD
         b2QuDkiaEJJ4KKNpwIF9PLaEFZjqRDzs9wWhMDp4Xg17bS5XVm3XyRX0bQebxC3YjoY8
         lyLA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wU64pX1KqdYFToLEF8oAyuRrU2kwzJLghCvXZ46Q8czRnz2zc20I4OmMHJhuFMq5z/jx56U+wjHw94/t3CN/vMn06hFT
X-Gm-Message-State: AOJu0YwM2+tZnejVSWxzWukMLDmAyFLYFXEHppRpr0poNgqPkE0qS3Tw
	zI+nTUfrwWeXVv48Tcopl6i6EkaaXipQJvVCaQffh7fNd0WoNiZ/yiCh47nNZU3WIU/C5ij8FVo
	NHuP5gtOruKdzMCpApxSoTqIPXu0RNQRGMC6v
X-Google-Smtp-Source: AGHT+IFVctapDgQvFIPIC5lpDGBtMq09KW3nfv7r62tQ7bEpP825JQ5/54fY0AsGtMDXVLNDZU3VTLEzdiToTOIsj+k=
X-Received: by 2002:a05:6902:2305:b0:e0b:2fd0:6d34 with SMTP id
 3f1490d57ef6-e1155a46d13mr326697276.6.1723571759712; Tue, 13 Aug 2024
 10:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801175548.17185-1-zack.rusin@broadcom.com>
 <CAO6MGtg7MJ8fujgkA5vEk5gU9vdxV3pzO9X2jrraqHcAnOJOZA@mail.gmail.com> <CABQX2QOeWoVcJJxyQOhgO5XrsLRiUMko+Q6yUMhQbCYHY44LYQ@mail.gmail.com>
In-Reply-To: <CABQX2QOeWoVcJJxyQOhgO5XrsLRiUMko+Q6yUMhQbCYHY44LYQ@mail.gmail.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Tue, 13 Aug 2024 12:55:50 -0500
Message-ID: <CAO6MGtjVd4M_93QUuZrLXoSz9_6ZYswiH7ApUTo-mRybs1UJFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vmwgfx: Prevent unmapping active read buffers
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, martin.krastev@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In that case move `map_count` above `map` which should move it to a
separate cache line and update the doc strings as needed.

Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>

On Tue, Aug 13, 2024 at 12:40=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> On Tue, Aug 13, 2024 at 1:29=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.c=
om> wrote:
> >
> > Remove `busy_places` now that it's unused. There's also probably a
> > better place to put `map_count` in the struct layout to avoid false
> > sharing with `cpu_writers`. I'd repack the whole struct if we're going
> > to be adding and removing fields.
>
> Those are not related to this change. They'd be two seperate changes.
> One to remove other unused members and third to relayout the struct.
>
> z

