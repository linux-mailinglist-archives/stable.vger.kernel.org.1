Return-Path: <stable+bounces-116447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B97CA36685
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 20:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DC33B1755
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E321C84C5;
	Fri, 14 Feb 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="mYrDNnCb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6A1C84AF
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562861; cv=none; b=RN0TkGU+P3kWseob/2XdiBS1FSEsnhp5yjrURFt2Y7H68GJNJO6aNxwI59mnH0QAonGAF+nDEf3+WECNkov0rBlaFZyusA2DmjiHM1gNzsqh5YM5Q4u7P/kJb+Wx7ZWI3cSyu0N1zZrISLK9SBtjGN6hyuGeecsdJjjtt599TTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562861; c=relaxed/simple;
	bh=F9JPbRGgy2KRFJMR0L9LpCN/bMbxo32cp8WwnNHfDxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n04u3UlrVhbgrvVexHP8FRtGOkbiK0EXmTt9R/anqmLOdYEn/A24FaBwTW41kCc2m6fTVtZVv2lR/qGpFUS3NfVQKh+KwFRlrUl8JqRlV7lC1zWaPqVo5dk1vsHvI2lxAiKBY6BY1jQHsGCfvZKXI9gMxDN6j5RwqFhO8wMfm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=mYrDNnCb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7f838b92eso438173166b.2
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1739562858; x=1740167658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIYB11+GgLlT+s3GNd9t99ckB9tkO/E+VJIoU1xvL3g=;
        b=mYrDNnCbC4//N0/F9aV/N2tpkii/u9FETfVPXuuMkyoHt8hHOfpEfLu0pfqjMs0YD+
         rEuyALEfkm0CrO6pwQ4Ncn05pImmFtu8omkF2D5/uazd3oki/0vKwQhe1fbQR32ayXHv
         f4Ib8OXj57NZgFvb8jp7197JxHlW/Wa0JUQYexnXvKAhf2VxENjwBsglvK4r78PoNlPM
         5aC3xy1wMF2NsEAub+4fYuwOgPbrgxzAgM5+7veWhTxLjujQ02RacvqflTE+aamv1kjN
         sqG9W6wV5C9FxpVfyjlMyZSN8qQGRJB2RuM8sPVyfxNlKZGqGMpUYQ+jcLFaU6xNy86L
         EvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562858; x=1740167658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIYB11+GgLlT+s3GNd9t99ckB9tkO/E+VJIoU1xvL3g=;
        b=KZYPHiOxG5bF76PJnpGfy+ytBkJnAzhRD1hwwJZHVMzpNOeL2C0wZJRzzCe9KAbG9J
         LkpHo+KgW5AO/odWdMxuMZDe/lDL3AuaK6LBTiBnLgY/EW7iNm0UfSlm6yv2uUuxp92A
         vrpB/jt/BMw5+jzXEpLQVlk3vXbWTiQOjjJxgfWH8MPIJhOpX9ayaBjalUXtaBC5tTnV
         MBXXAWwLhHcLw6nKjFfd9CZa6/4prc++QuNGXI0qBuN7cCO8N2mZ5cpqVEqwbY1WKb0v
         vlT4Anz6uWsDKAXuTveQc8K/ZGJJBLjdf2AlA12ge5X3E5ug5eY7LkL+EpOO62UsZMGb
         asOw==
X-Gm-Message-State: AOJu0YzkQTWdYkRwaYjq2K6yW+aM6T6PKsXR8rwPNq1PCn0D5/nlKGhy
	9YQVSXcIMZWraPc76Cm0yIX4YIc7lKF2uKvpHsQcGPO6tZjRU7l5eWtFNgAkswoxsI/JeVY5UTG
	TYcZA1VJ7JGBFVZnzc8QsdpumemIosKo4JM5oMA==
X-Gm-Gg: ASbGnct/neYZrwQ70khRXrIZt7nekUFVUnhqz18FgGo+p6ww5ccEOadwCSF4vXvLu3z
	yCmQ/M6cR+Akf/9SuLE6erbK/Q4bWxDRwZGtkjBRx6KwlrEhk5JSWT2QqGbHawo83G49kk20=
X-Google-Smtp-Source: AGHT+IGQyheLGif/JTgffbl1Tim8k/BNZyiHL4jFBQkQNGvERc0kVB0mvtU+IAjUoObD3Z+Y+98YsIXAOuyjFKM8m44=
X-Received: by 2002:a17:907:c1f:b0:ab7:d87:50f2 with SMTP id
 a640c23a62f3a-abb70d9f296mr32132166b.44.1739562858174; Fri, 14 Feb 2025
 11:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214133842.964440150@linuxfoundation.org>
In-Reply-To: <20250214133842.964440150@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Fri, 14 Feb 2025 14:54:07 -0500
X-Gm-Features: AWEUYZlX87hyFmnKvOA0Y1WpH0vZar3xq21qN9aghuiiKzi-M2gyZl0dPxatvaw
Message-ID: <CA+pv=HO4D0-d+ir1Vb9xjUcsYd1Lz8j9OAzev+CWWak6dD56+A@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 16 Feb 2025 13:37:13 +0000.
> Anything received after that time might be too late.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

