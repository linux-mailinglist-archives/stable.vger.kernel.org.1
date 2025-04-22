Return-Path: <stable+bounces-135015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA9AA95DCD
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5E017739A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17D1EA7DB;
	Tue, 22 Apr 2025 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbtpP/OY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2547148850
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302275; cv=none; b=JpSYs9fGLJuVsPIzexlcubkmyLKq56ptbhWD3NoTrZ0W1bmM1wQ/09po6voWWKnwS+tBBpRxP+r1J8dmjB4p1cUyCftAFPlVv46mZazJ58gnikK4MKphW+MFVhf0Hvi5FSmPNrWuNNIUdK07OhWeBGMpYM/NOTMfyP7etGp9rHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302275; c=relaxed/simple;
	bh=bxhnm4bxE6XX0kCXQaWnvdpeCNgUc1ErhlnFEZZaaEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dV7v5tMoxOjMtRe6aGrEuR1y5oRIdd6fvYoLXAO18NBJgYz1hvaVbqBDFSB28CH/ooPwmQA1vdO1TB3Cy4ISDmjjHgrJFB1WHs5Mv3QtQClKXY76auBjxBTeBWAPRd6KMELfR2TFRTlfZ4M25j7kIp27ou+VQypYplEWbxgOnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbtpP/OY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e573136107bso3790625276.3
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745302273; x=1745907073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxhnm4bxE6XX0kCXQaWnvdpeCNgUc1ErhlnFEZZaaEA=;
        b=fbtpP/OYycjfX7JADINKWv+9OBkq7Bdaq+Jjwlp5B8u7L/TFJJd1K9GeVM/GqFcEol
         Q3rgD0gywHpgPuAp6OM4WqWQaXeM2psfi1wdNrpKmSdz/CUdYs8l+MqFWZ0epEN6v22k
         o4c4aRTDAiSs0XKQRZbMNsqrV1lhIvfFSwggjVblaYKbQCSOCCV828uBLTOUqBeIv9zI
         wh5r48tySleWwmAZZr90juP08WbU8mu4M4EmjGGKqshMCS4Il47CKTr69zrKb1uR/eDr
         3nzXyfD5T7S7uJuI7amy6F2+yIUPOeM3fUz5zZ38TmOVpGmg9VenMVA8muGuJb2fHRv9
         NJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745302273; x=1745907073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxhnm4bxE6XX0kCXQaWnvdpeCNgUc1ErhlnFEZZaaEA=;
        b=Dg3mtuV6kmn3obkmhyBvVY19XoqFQzCWA0p1ERgBw8sNHXue5wxV/A161rZZa8j9Zr
         LcOVcxBQEbnYg3luIJvhF4ip3lyyDtH3luw5JJM74/MLPy16FU1FYoNCG8I6T0eXLG9T
         eTCeETeTHEh6gnhoyb8Rt3W70McogRcEaKimE26NC0FFz9uh4wLwV1dBkq1RfaDxxgHU
         vW3Yb2Xl8PtGPdjXmizRoeV1v8sFKkVQqgKO0SC9B9iCZVgVoxe5zbZ0HlI06Xbnd3sq
         0anAbHz4UL4DCg6ErurSo8SbW1M2I6QDCQaIUuXoJWh95fx5AM6LYxUYrAxOpOjs/KTq
         enoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD8BV8xvmBkJyMxKIlBM8v0pn+0XvY+A/4z7LvOKG7iVWaaH/MuFYW+qU/9zTEdqDUEpZ359I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOuvWqTv26jU47ZVtUCMHvCrMczGx2S1M29I7Mj0IofbTAoP1X
	byPylXvbZLZZkZ4AzG9g4fHgTxqQjk2SelCRGhVX7GzZxz0B7GIODk3jEfl0GTe4qUgkMLT5iU4
	OnLHoUNIrQkjCsVY1hTsSWvos4TWz70XGMNE=
X-Gm-Gg: ASbGncvaWVaqrhHMAvMZFyvXZVgk9K514HAae1efyqlQ95iZCukIJKNvhz7/l4tMyWF
	IbLEVmmwa3h1UPyzB06BhhV3jh1I3cyUqowwXNnUVlxK/ihKo/L4OGW6r/Z0feYoBKnDtZ345Jn
	eYtOs2kLtwm+BSPiEG1UaTTEjGOl9kfbBRA6WznhTxnP2UdpKO
X-Google-Smtp-Source: AGHT+IFhnyR8jWPVkcWpZG4luSHgE5YTFhy3/VLmUblrGCql+RSfpvk78hD2sCC8TZupzVhPxyIs61NqTWhJl28vlo4=
X-Received: by 2002:a05:6902:2b10:b0:e6d:f048:2b59 with SMTP id
 3f1490d57ef6-e7297eaa56fmr18712035276.30.1745302272717; Mon, 21 Apr 2025
 23:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
 <2025042251-energize-preorder-31cd@gregkh>
In-Reply-To: <2025042251-energize-preorder-31cd@gregkh>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 22 Apr 2025 14:10:53 +0800
X-Gm-Features: ATxdqUFgoCtKadUJ0g6vzRSEPHpQJA4F0wf0n8o1thRl5pRY1t1wBqG7blOUduc
Message-ID: <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, linux-mm@kvack.org, 
	Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Liu Xiang <liu.xiang@zlingsmart.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 2:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> All mm patches MUST get approval from the mm maintainers/developers
> before we can apply them to stable kernels.
>
> Can you please do that here?

Sure. Added to Cc list.

>
> thanks,
>
> greg k-h

