Return-Path: <stable+bounces-87580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA49A6D30
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3181F2220F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C331F9ED0;
	Mon, 21 Oct 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQWXs5E3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD871D517D
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522414; cv=none; b=hjHreC1NgMSz8EZw0vnCnJ+N/5FGCR9ZEi6unyWWzvAHRougornEXZ6CkbLwDaqEddNv9/lvj7KjsJSkeRvO3ozqP+Q7rsRKj3sqWqnwJ+AKp1KR6KP1CtUu9GPqlotSfFNYKUX3/gb7SUgcILdvl32eAe++88zyRbP62Y+YkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522414; c=relaxed/simple;
	bh=XIAbw4mxYc8pAF/lqCTTYZZ/MSMJKjfurf0D1Q6b47Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpF3fvqVxxLjmrTXmF020dAuzapY8OwLSWaWsh0707teudH3ruUDBXtjC7DpHczPG67FjrAlKyR2FgigC9WF2LLTdYQHVkcUSwtq0lJAbWGT0Uo/sUNhb/F8WdtTQWR6Jvu40GiMIcDvQPGk16I9B8Bz/RVcCaQUYd+G4X4apQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQWXs5E3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca4877690so212035ad.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729522411; x=1730127211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gG9duuhy1290ypGByuvBv1xo4Px7j5a02oLYF4PH1s=;
        b=mQWXs5E3+XMqqOe2b426v1nalxbcnACtqEm7doLKZ/Ut7OafeitcUjkkKzrpmdt274
         PSy/s8w+NLtXMnAJe2jWqYRZq+MeXy7K9H10ymnDrMgjKOhLiDx+4rF9qoFSf1RKsyeN
         kIPu+Fyxm7MwDoRA4pVAypBXykMsy3dYGKVB33TnonZwycQOz/diIhmSFHZBywrRT/SB
         EU+ibaQD42euJMbp4BtbRmeO93HTV0EUjK22ayWpAwpL+8TKzlaekFUoBBQGRzqcR1/S
         Ui+P6/bj0pbavxVKOkbbhws+na9mLg0eRZ5XImFtNY6JeMBnQIE/UIEFscqyNwHbd7dj
         7s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522411; x=1730127211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gG9duuhy1290ypGByuvBv1xo4Px7j5a02oLYF4PH1s=;
        b=ln3TjartPKT8h44lz5hceuurT296uuvV0oxZtdstSqAJTOxxzS2801SY+veHtwog42
         nHnzOrDMm6E1ZLXLo1wgtBq/mt7N7qkHAzyE86exoRCheyx0GFgBaKGdc/l6QbkS6QZw
         z2m7yzsFlCAu+TG2dyuRec4ROzMLZnoLEJn2RC30g+Rhw81Wq2ge4YWyC9bj8WOla9Yw
         EwXl/DWY1ufK/hJ7K98AyyRERxVXX6Cw1S3fIz4UityFlqcRpZVeoVF+Q5Wba40n7a/0
         sQKDVw2YDo1DrcBEyXYCVlAKjPA9B+ILVIgte3BYr9fRCYDi5jFmiCfs56RA8Iq3gdQa
         iHNg==
X-Forwarded-Encrypted: i=1; AJvYcCUjcbalH5ajuqi2ENi0yvS0p/Jo9xywO537/tt/yVceVNuH/CIXjrTXTWHKrBMing590OtSWSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Jm4cyZjeubquJUDL0MeOvEV4gV5n3avA9BUFCOceHOHDRQ9G
	voaCBonIoo8slTB0mqOH0gBACs+gzxddfraxnCDQLxUjICs7ju+RrdsJOf/xRJKBsF1syzRZD3j
	oZq8gcDdfJUdf9XhjLX58psNQnFLZ0mj0YsuU
X-Google-Smtp-Source: AGHT+IFk4I+l7PDx5NC4E4xF4MG0P4sMRuFqD3K2dFP68wegQRv3ETdMCuzSeOSaEIZrU5k5SKymwi+s+gYa0GYI2H0=
X-Received: by 2002:a17:902:da8d:b0:20c:5cb1:de07 with SMTP id
 d9443c01a7336-20e74264c95mr2671365ad.11.1729522411055; Mon, 21 Oct 2024
 07:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015123157.2337026-1-alexander.usyskin@intel.com> <2024101509-refined-posh-c50d@gregkh>
In-Reply-To: <2024101509-refined-posh-c50d@gregkh>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 21 Oct 2024 10:52:53 -0400
Message-ID: <CADyq12xj8VckfYO7W5XNf4MSssBTsCSi8gcE5_RmeD+dO5Cg8g@mail.gmail.com>
Subject: Re: [char-misc-next v3] mei: use kvmalloc for read buffer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>, Oren Weil <oren.jer.weil@intel.com>, 
	Tomas Winkler <tomasw@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rohit Agarwal <rohiagar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:48=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 15, 2024 at 03:31:57PM +0300, Alexander Usyskin wrote:
> > Read buffer is allocated according to max message size, reported by
> > the firmware and may reach 64K in systems with pxp client.
> > Contiguous 64k allocation may fail under memory pressure.
> > Read buffer is used as in-driver message storage and not required
> > to be contiguous.
> > Use kvmalloc to allow kernel to allocate non-contiguous memory.
> >
> > Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
> > Reported-by: Rohit Agarwal <rohiagar@chromium.org>
> > Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@c=
hromium.org/
> > Tested-by: Brian Geffon <bgeffon@google.com>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: stable@vger.kernel.org

> > ---
>
> Why is this on the -next branch?  You want this merged now, right?
>
> Again, I asked "why hasn't this been reviewed by others at Intel", and
> so I'm just going to delete this series until it has followed the
> correct Intel-internal review process.

This is a significant crash for us, any chance we can get another
reviewer from Intel?

>
> greg k-h

Thanks
Brian

