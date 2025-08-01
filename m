Return-Path: <stable+bounces-165778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5BCB18896
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 23:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5391695C8
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 21:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CEC28ECDF;
	Fri,  1 Aug 2025 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F8D4sym4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841928D8F5
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082930; cv=none; b=XDq/qv1T2m0GMJGOPLXwGQrrRdWH3NNNGGF5dcM0+92a7g8S4eRoX+mvPMr4rVjCymvz7MkmfP1IA35IuDpBH2R5G4h4pcOJ2SiC5aH4iGQyxD6kiFL7QeG8E5IOcKsh51FkcbvBiORi+AZxZa91nG8Erdd9nocUgRFFdDAo7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082930; c=relaxed/simple;
	bh=8Kri1HoPuh6lwB0F7qiPiOrJzYKY+av4+R1JiwsLGGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYsRbobghEahlqJlstuqmdyk9fXsPT3z9lug8SXoSyMqV/ubNEWvpCm93VDExXj+JAOKZF49jakpogrJsXkSt7Q3TjnkyLc25VMLIzCTMvY8HgVXhJd92itVt+F8V19z54KZCkWZ8Iskxkl2tTHwnDpfbH6teX3uda2uxPr5bE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F8D4sym4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so3625230a12.1
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754082927; x=1754687727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOAZkZ18mJY5AP4pAaTQp2Y2a24YFEEDzHLPHw5UlIc=;
        b=F8D4sym4KjxnlovCVcaOF/R9+QjF4+PMkLPJbhdYlNMCesEgeA9yvB3J3UcKXDm0lI
         wMiZf9Jw5985q7ihW/MG0xVWteHx9rVHT7HChppgwKaXfzisT/WI8rLgS/YKANXdB+RN
         SUFD4WK6FozFkbK5zGbbt+FSyssGgjDQ9h4Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082927; x=1754687727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOAZkZ18mJY5AP4pAaTQp2Y2a24YFEEDzHLPHw5UlIc=;
        b=CN8hikO4xRo1Sf1kJ1XYQ4bCgKEO3FpVDfOs+L7sYqUi8oqFonZlhRr8Nciav87eBt
         PNq/jerVhIZbYS9CFVpOVEUw0Lgw0gVCM64G1qarqFK7QdYs0JskPoi8x6/8ahZozu+X
         +7YcyWduOyc1+Q5g0BlxMsajbeODdxrhRwahaTfSo0TCYI6UUcwKnR8OQg7KqFgjTr2V
         3Svvdvb8p2dpcmHpfZaNzaFtW7mwMSuCbg1YVhKBQ4e4i+uQ9EUxdui8VY0Eoe1ECAqk
         Wj2z++ta33AuDWzYG4G0tF58ECQP3tg55QFDGgvIguvUNNXdJpBHChBq00yTJKGxFlOS
         CGPg==
X-Forwarded-Encrypted: i=1; AJvYcCVFMrSSUF7zLGDd/KKfTTCzzM/VWMvcLqq4hxRm6Kt16q6dItV0LH2As6SNy10aNzHAn/TYltE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYuTjThroJlamP2C8DFcNLwrauQOMyabzxdnGHpYwSFPwpBOzP
	dmGP13LmNNGD8laRh2fgA7wcnfNctwZM4oQU1DKUHRjPn4P+YKB6JXJxLwlFgDXUYFp2Xe8t86d
	zMD81y4E=
X-Gm-Gg: ASbGnctUQFagJu1YNj4cI41df+xp4hYmwLa+eOTmpzUDYWUXxkIPJOmKrHfw6PEfoVj
	xzsrndFamv1HLmdNfdC2VK6eFE97gA9/9OqHMAa5w59hiMUw2md9+d1wpwsbrRWSFFIqt5Pcho1
	G1J/Bg8ofgOv7UlU+toBkRmpOebDw0fwp4AQCDKtdNHfU0Ztamr9KNawFoIcjawdEHq3/533kdM
	iG7FqerWI2bSm4p2CkBO+6918oP6cLBKUDqjQ2PbcvUoFKkOdVW9rGpX93HAXOfUvnJUevNK5qk
	y7pz+1yt/BC+NDl/WK1xbrqkd3ZKOlSitI9Djn7n7tqo/q+GUReVC+dwYbXzOf5N4dgkp/tcmrQ
	RbtmifD5WEKJ0QxWtxku2alrfkk3ngvrmqyRlncv21zU5qgexkEPmaeTpz0ATioxOGxzj4K+BeQ
	hWuakMeBc=
X-Google-Smtp-Source: AGHT+IECKCd88A/ijHmzI7hHzDh/JJYiLkYlahnoIYd4V+jMdmUrdfc5rakVcQTC6UwlhXgqGkP6YA==
X-Received: by 2002:a05:6402:2808:b0:615:e8f0:7035 with SMTP id 4fb4d7f45d1cf-615e8f08924mr372592a12.30.1754082926713;
        Fri, 01 Aug 2025 14:15:26 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa17csm3168491a12.49.2025.08.01.14.15.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:15:25 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so395994366b.2
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 14:15:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6pkLL8bKhsyWPthct9whwGMnAAi5Rgb0qsd0B8czluOYtj6mqGcoij7qzOcy3dLbQobSHZeo=@vger.kernel.org
X-Received: by 2002:a17:907:3f99:b0:ae3:6657:9e73 with SMTP id
 a640c23a62f3a-af9400844fbmr144333466b.20.1754082923387; Fri, 01 Aug 2025
 14:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com> <aI0rDljG8XYyiSvv@gallifrey>
In-Reply-To: <aI0rDljG8XYyiSvv@gallifrey>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 14:15:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
X-Gm-Features: Ac12FXxTQNyMa37gD218OICz8yv-5X8AXqC2OjqDUUC5iyMABu84wbERpHpCWcY
Message-ID: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, 
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, 
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, 
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com, 
	michael.christie@oracle.com, parav@nvidia.com, si-wei.liu@oracle.com, 
	stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, 
	will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 14:01, Dr. David Alan Gilbert <linux@treblig.org> wrote:
>
> My notes say that I saw my two vhost: vringh  deadcode patches in -next
> on 2025-07-17.

Oh. My bad.

My linux-next head was not up-to-date: I had fetched the new state,
but the branch was still pointing to the previous one.

My apologies - they are indeed there, and I was simply looking at stale state.

So while it's recently rebased, the commits have been in linux-next
and I was just wrong.

                Linus

