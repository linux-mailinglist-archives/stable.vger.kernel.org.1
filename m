Return-Path: <stable+bounces-165794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03622B18DE1
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 12:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4ED1AA41B6
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F91E8836;
	Sat,  2 Aug 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kMF4lsM+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9018D;
	Sat,  2 Aug 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754128939; cv=none; b=iNrDxxPV0kOFV+ot71B/dR3+e+12cgVPz91l3UlS63FEektqQ7MJEXwuFa3UnCFyyTaUV45wainsVxf1XZjMwt3E1K4MUt9nyciGGUGRQecXADStnskOtvSDkJLJlvElDGJtymxGQj5PWw0xLZcn9vtbhNryy0ZyS547LNoQLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754128939; c=relaxed/simple;
	bh=l85/MQ61VxNEbDkg0SYEIgrzuUJ3jO290jyf8eXl9lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf3uz5R5sNjSNpZyz3BmPhfxW2+D6J+3v3l5tlJP2dtDy6qN8SR9w3lxgpEpNr61JSDyU9bSrljg1e+/TBwTZrpacJdRJqYTuhWbC2es9+upYJH1WS4QX2CFyOS+Xq5x3LwDs2RcCvwZHJDHloYMX6Zw6p/m1DfRLU3/Fp2mkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kMF4lsM+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2406fe901c4so18078215ad.1;
        Sat, 02 Aug 2025 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1754128937; x=1754733737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SunfwaMKGIuht1NXta7qE72eMa+DmpHbef3GOE9+HT0=;
        b=kMF4lsM+duP48qQC+AOINO3/ti+0yQKk1WaOJ/WbcwcojAM7Gdikb3R9IS9PUq2riz
         eg7aRJ9xKtcaBIw3/2sy0Nlx42q+FUex4xMTNwxmwMeEWSrncZmpDfFAoSO+FrRda3vf
         OTOZ1By5Ef3CwiPVI5De8m7KJed/zjkFZzG9//JpbmjPpP0BMbY6ns/sRoEztU4Jwos6
         fz7MgVZ+Fm6Fr9EzzwZuuwfN4DaPV5miyW66aWsRG99Ru4dFSNnMasUfRFom9o/zvn5x
         U2HNmuqPXund33HxGkwm537gaxGEqZmQClWYJRzF8ejalX8v9NMLXwPA4nLeXhbTNUB3
         1y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754128937; x=1754733737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SunfwaMKGIuht1NXta7qE72eMa+DmpHbef3GOE9+HT0=;
        b=mAy1RaE5/ESyXBuwNOJTsuW87qO3QvZUHwXr9UCBXh6HLUfb5SqUVFJ1j26CIXVjcQ
         9LbqnnfMuTIWVf/xg1YTXQudCqix2l9LIbzjren5VG0vFFiPFGwHu1MvtjYB1cORcsMM
         w1g/4E39SD6m+u417++5rHveQyFQsjIwdZsz7Mhkitk1MGp9o/I/cHCcp/yTTBstVKEd
         +OWpZecSOnO6C8BPqhvXtM/J7ViRQUGytgWFilFk34xMGQvMgyXkZPCrRmhpERzOfFkQ
         pv+BhV+LvIF9p/u+xYlE8RW0lsZUudA1dIVjAKDk9oJGPnGO0jlf5q17M3fNycU75qwl
         CJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbPeTpOkbxbsyGRg7krkSqpIxUxR8N/injZwfuAtMuFm0+7u7QZEs2RdrNDm11sUOTUJWjrU9mlKH7H5w=@vger.kernel.org, AJvYcCVk8oqqjD1Rp63AgElyJoW7JS2TGou/kA3+KMtoNEeA3Bn5Wrs8fNpBT7ELsHUoVK8wHzlWTip/@vger.kernel.org
X-Gm-Message-State: AOJu0YzixT8ndQJRPNMIYLyWeln0I2DU4F0gHSLEbST44T7AYx2mrK6Z
	1TGmWKXGQaBraW/XpyNAIgDgDc3m3P3+nHKScASnCvBbi1M+cBzyyFEHgAP4TT02z5duULc0muS
	wmmicc0QNVZ3WyaM5tyVy0EcnfqhI2/M=
X-Gm-Gg: ASbGncsfmncBX9v3Y/HyofT5lsmxgLDdT2Ag23hbn7b3I4mz1G1io0PE//MYcTKi48B
	bj7x5IDrHTg9HJr+NsmVlmsHYQGrYQ+rtjM4CYu4W3e8jfeFpx1tGhgSKAc268xJLp4e883t+LN
	McRoM+AjtOQ1MwcvwCcDqy6zU/lSiq38eaJZ8Z4PRiTkqD94NueGWVAz2AncgugnEbhUReGQrtZ
	pDzZpsqqNsNAC+iVY8CZxjYWUY/TAN4yZNXPbYhJkHGZgWCED4=
X-Google-Smtp-Source: AGHT+IGOt/4l4J9IhYkjHTK2Oetd+MLMwWR2adcwj8NjCk/EXB2Sr+1dYWJ3QAEsHw4NizPwdZrM+iGTE7dwlj2oHms=
X-Received: by 2002:a17:902:e810:b0:240:11be:4dd3 with SMTP id
 d9443c01a7336-24246f46073mr31260365ad.3.1754128937389; Sat, 02 Aug 2025
 03:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725074019.8765-1-johan@kernel.org>
In-Reply-To: <20250725074019.8765-1-johan@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 2 Aug 2025 12:02:05 +0200
X-Gm-Features: Ac12FXwURosII2dlcOALSUn1if13dVdtjG5hnIKv2HjEhOB0uY5AXgIZbdV4pwY
Message-ID: <CAFBinCALsUdn3fGh2e9qys4KKKT=mDnx5vtkyEz-ZGRmgvNs0A@mail.gmail.com>
Subject: Re: [PATCH] firmware: meson_sm: fix device leak at probe
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 9:41=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Make sure to drop the reference to the secure monitor device taken by
> of_find_device_by_node() when looking up its driver data on behalf of
> other drivers (e.g. during probe).
>
> Note that holding a reference to the platform device does not prevent
> its driver data from going away so there is no point in keeping the
> reference after the helper returns.
>
> Fixes: 8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platf=
orm driver")
> Cc: stable@vger.kernel.org      # 5.5
> Cc: Carlo Caione <ccaione@baylibre.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

