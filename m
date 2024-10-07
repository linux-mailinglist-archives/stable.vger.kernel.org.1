Return-Path: <stable+bounces-81240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244B9928C9
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B943F1F24DC7
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453B1C1AB0;
	Mon,  7 Oct 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BusjZvhn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410551AD9FF
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295523; cv=none; b=k2sM//BYAwarXUdFkmrrIJkR6lg1Er0qz/QiAZ8vqJhTlb0b2+GX57cddUgh1J4CULKJVLEEbvgd7U1BkD07KnhhUCKSksTa8Atf4jn98Sii1N2caul4trjMCrj1sovDn3SfQZIingwK6BDuIusueqUul/iXkSdqb+0vhWkhVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295523; c=relaxed/simple;
	bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IT0jQt9h3kJnw98UYr1R6NhSIwFbdkArRvocXTvatgdwVQbJyYFjvcn1RI1KU4dMkVKVT8YwarOSq4BiVFWchy3SM3c/Oo/T8F9ReifO4z5E1c7gYeI3VSbo4IQXG/1QnjCWWvbP3HMthBdIfgPZdSplBjIy8/M1JrWA1T6BZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BusjZvhn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso4108834e87.0
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728295518; x=1728900318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
        b=BusjZvhnpQ+pE6LCNNDzU8CKH67hwvr3bhWzgM3pc3NZW9sxcvyHp2mejs4G/6urkr
         jPbbJsRcpvOFX7OZGbh4OlWuqmHObw1K9G70klCADV/Aiatn49VBwBirqb4BcwwLPDfH
         8FWVjXibpnIa/fsZUnFrHh7fgtvgvUmcWC/Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295518; x=1728900318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
        b=NWPyhNGIUWEf8H7+I5RYVHh5YkIeMZNghzxNB5yJ4yMZdFHSx6kFbaJ4Fn7fwFeMyS
         U5Lrk/8q1AZlc7eYBpgVla2/QU3Sei4ZLyErZhJhgzXP0c0i6sPoG5j9t/vlF0tUqNGV
         iwLUnI+pWVU+1xIzKU1mwaUVRN2paZwLgfFttFVySkKyj8OZQRu/ZH1rW9plbTrxMNnq
         ZvxJ32l5hB6WrC2YvOPuhSdttHnOYyXUzdX8iXM/yjPrGIRk202d7xJEmBl0abdwpGD6
         Jhu9vQZp149PiciJFHtgUQky96RG9dZEG8N077fCggba028XeqI3whdMfuk1oteDvNSa
         Tflg==
X-Forwarded-Encrypted: i=1; AJvYcCWUCOgrCxwMLVdBVdBM7bH8KjUJ+VvQVww8kH6JPVgPKnFn4GJb1PCkbMzYizRgM1ovl7Hv9WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjFNwIba9xs2wvrhaIRTEsmhJN0wsrK/CyXfLDItq1YYAkA8B
	KewahHGv/bdOnrihWDZkB5Kr6YnDAyKe1vOt5dC8OP3L866w7o9IXRKkSYVc6O8fp1GXKhgnik2
	TsPKdDtoQoVtSxcMGfcUwsH/cwPNPWkxTfsNraw==
X-Google-Smtp-Source: AGHT+IEMCR/7S6+NB65Ewgm85Y27kXieWu5X6dcSByOH//2ik5TJFm6oU52jizX6aN9ixkQGjMbaeNJrse8KTg0/+zE=
X-Received: by 2002:a05:6512:b9c:b0:530:aeea:27e1 with SMTP id
 2adb3069b0e04-539ab9e6cfcmr5778643e87.50.1728295518265; Mon, 07 Oct 2024
 03:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004182200.3670903-1-sashal@kernel.org> <20241004182200.3670903-45-sashal@kernel.org>
In-Reply-To: <20241004182200.3670903-45-sashal@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 12:05:06 +0200
Message-ID: <CAJfpegumr4qf7MmKshr0BuQ3-KBKoujfgwtfDww4nYbyUpdzng@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.10 45/70] fuse: handle idmappings properly in ->write_iter()
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 20:23, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>
> [ Upstream commit 5b8ca5a54cb89ab07b0389f50e038e533cdfdd86 ]
>
> This is needed to properly clear suid/sgid.
>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

AFAICS, this commit shouldn't be backported to any kernel.

Hopefully it would do nothing, since idmapped fuse mounts are not
enabled before v6.12, but still...

Thanks,
Miklos

