Return-Path: <stable+bounces-95707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31D29DB7AF
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C33286D7E
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9043219CC11;
	Thu, 28 Nov 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="F1Nr1CLl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90119D087
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797104; cv=none; b=IwoSb0hIaaXwjZI2AuEg/4sngD1WgRgA4kebtkw2zuGBjyqpRnkNho3g+W4NUCYvacYXCejyVenFoipDquMw4DVKrMBUU/YMjguLwnVJ2GRctP+x1YyNw5EWNbK5NPnn5jO5IlwmUU6q9mxqvFKkKH3xofU/QoMNELZ/fJo20bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797104; c=relaxed/simple;
	bh=iYQoZNHZYvu4ako70Ag18jWmbu6070AIJp0pvQOIGuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gib4q/WG6LbjkwNiLwTbZ5EW4nrMFn5s4ga01mCNP9797+N9x+4B7gl4phHkNpT7nzXjf52JCNQRi1THpOhaO4VV07aBJyjPNlzWgOWgWxqzPgZyKBTsnIXZvNmcvVr0upAdTrBCA4W2U1vzSG6uUxXHcZnBJCHHw2hllumBNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=F1Nr1CLl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso3253997a12.0
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 04:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732797100; x=1733401900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpoemVatfaaeXNkbkmZa/3Of/FndPg8UClILORZPzNY=;
        b=F1Nr1CLl53aoSWZqsV26xaDbbU5himcZALRsxy3NxAmkm3pKG2p8TukdsWwOYiycRq
         Lq9zF+ZglEgTspRdq7llTbYmw5eBSByXUOjes0bzyk8P03OlhR9xbs4eFj5e0BjygNJq
         YBiXtXKjkxQz7VCoQSx1UXxooHu3rs098NiC+Az5HF80PCgVEk5b2Apw3Sf3JMtNprBF
         HeaRo9m945AM38ZdoaBKUy9WSs/wQ2q+BNbBRY7d/UJDN7/fBDjKhVxHYnii5tH+aOKk
         tZqptQfycCmECVTXDKLJvK4TJ0M03FTXyrp1KYyBRdQ0n/WW+Kfg/rZ3HazZmFGfc6dF
         WKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732797100; x=1733401900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpoemVatfaaeXNkbkmZa/3Of/FndPg8UClILORZPzNY=;
        b=OvR/funwxyaCH747bb1T86erB5IJVgcsW7egTmR2b7vT1pmKfn4pdnyzimPeuAaT6l
         wV6dNaXu7CY80FZmL0zTpOvX5qWWcsZ1rZAItz9krxCa548eg42vjQu4LkREbPGPyGTC
         J2K5IdK4yyXF1vBrylzI2eGeCWlsQI1uFmVvEx/+C5ECQGfGmyPU9YhedElHKF23S0ec
         HxGLXX2Ov5LzwNtH0TXDCgxlrspFUjz0yyQoJ82l22OCwCOQpul3pySs01MQcSBhM8r3
         lNrIwLKO/RGD0awz6YJo3ceb8CY+7gbx3phn0k6J6EbCQ/4lCPjupiUwGONYQXo2W0tc
         mtSg==
X-Forwarded-Encrypted: i=1; AJvYcCWcO+VZzKSAoZ0RsU9OhRvfNfp7BvwGRCRWf4QQH4mKDJ8VNR5NvFdLHJg7SgINN42La3bvs/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJWrwQIBmpwqjR6l2TdqVppQfppzrborGcqUEC/+aAslnGsk3
	28cTslphtJQ8dU1bFsXoZ1jjdjeU2FGfozVOVOAyHBkffVeZmV8AabqJwRx4KnzrNNaP8alUL76
	U9xipqeoTLj7tKDS72vg2S4qN5XgZ4fcMF1igSagv02ToWo3e8vvZZw==
X-Gm-Gg: ASbGnct9NS9rfW78gUIl+B0PMDMngjxgRqRvOAs/IGbzVEbRMsyIbuOAc29sNVnlxdc
	V3dq5KSRakIYho1F87Abl7FmfjdCGgL8K0QHeC5ToEYXd881ReqXTs6q1wW+I
X-Google-Smtp-Source: AGHT+IG/PJy6jtkMD93q3vrdJc5oVLajZQBh1b3v2P+6oDKVmYlQzPR4JSl6ULCxWrxgGCHo6jToM+TuxfktaXdeQ6s=
X-Received: by 2002:a17:907:7615:b0:aa5:358c:73af with SMTP id
 a640c23a62f3a-aa5945075fdmr348570766b.6.1732797095349; Thu, 28 Nov 2024
 04:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com> <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com>
In-Reply-To: <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Nov 2024 13:31:24 +0100
Message-ID: <CAKPOu+9H+NGa44_p4DDw3H=kWfi-zANN_wb3OtsQScjDGmecyQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:28=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > Pages are freed in `ceph_osdc_put_request`, trying to release them
> > this way will end badly.
>
> I don't get it. If this ends badly, why does the other
> ceph_release_page_vector() call after ceph_osdc_put_request() in that
> function not end badly?

Look at this piece:

        osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
                         offset_in_page(read_off),
                         false, false);

The last parameter is "own_pages". Ownership of these pages is NOT
transferred to the osdc request, therefore ceph_osdc_put_request()
will NOT free them, and this is really a leak bug and my patch fixes
it.

I just saw this piece of code for the first time, I have no idea. What
am I missing?

