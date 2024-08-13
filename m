Return-Path: <stable+bounces-67533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 198DF950C09
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 20:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40F21F22060
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E235894;
	Tue, 13 Aug 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ajmh8T98"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90738A3D
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572908; cv=none; b=I8XzVEVW37PWFGj3K+a9UFpuASW6xbk1oF9zow7VjcxnuRyYPcSecI+EG02n6LWDS3BrBLfG2z6J1Yv8SK1sOr7S4oSD1KqfEtqwSTmiRgB3OyW+KcnphJhxprHeTGytrYUzHKThUN1CNSw4+2cfSIq905k8eFjEr25a93IpPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572908; c=relaxed/simple;
	bh=wykfbi1ltvhBW/eEtwy/5hntx+wznZ9QIfRsA8ImzMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGnbdWj50de/rO/dJ9DEK0DAknE4XKs42tTxY7leJaJY9pZTN8+erY3sbq3628PUhJ/JM6TdRRnfJvV4LfoPBtelCuRDSt9OAOX6fs5UhVu1MBSNNkKaSxpPPZIW7av0Dqpv1HAry9s703uEW58YJRXACKenGW5Z7FpPm9xzRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ajmh8T98; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db35ec5688so3476876b6e.3
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723572905; x=1724177705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wykfbi1ltvhBW/eEtwy/5hntx+wznZ9QIfRsA8ImzMo=;
        b=Ajmh8T98E+w3JgDtr0GxvdyxGc1bSBzkOP7yTM3LdqZ7zgEWi7u86m2wlnxIPDfj0V
         9C3pZk4od7arnBqrYrVW2Hs9Iw5JoE5wUEWGFh24QuPEa9VbLavxPwO5+DqVtJdCsZuV
         zBBZWN3FfVtyXwazR27OLigfpDh+IIFZPpzZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723572905; x=1724177705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wykfbi1ltvhBW/eEtwy/5hntx+wznZ9QIfRsA8ImzMo=;
        b=UKbd0UUpOVUN8LKCXIS4wG524VJLmJi+LEOVLYpDpMVtXxZ9J0ar0i4Gzgwr2NaTaY
         GPC2OXTSB4+hFlGvdfTL+Qmgop1VPzKAm5ishUir/rF+g0diacanuPuIPstUxiZUqB1a
         n3f7tbje5+TGmuwWSD7clfYQqId9PtSQE4WjrokctOCDReRV78mOO8lFraGzMSZJFd7n
         yh4AUF60AVQqyD8dMN47Ha8A898GXnCEE83baEJ7DVcI/P1vOCN7e9s5hosgFnDKYPUx
         scYs8oFaoTQ5jVW0mwxb5wm7WyKDviRzMzFeDiGGgaD3UTUxxzpJjmJo/wgiSyEhzFE0
         8n9g==
X-Forwarded-Encrypted: i=1; AJvYcCUQdLv186dOTSe9jH88tE1/XyTQKsx7/mS0Dqdh7ANJgWOfsHJWFXcrky8cH6FGfu6u6F0AXHBhzeSgGjdhvzid0HUft0Fi
X-Gm-Message-State: AOJu0YzugK1xzDzkSflsMNYLSN1ikdHPZ0rCAwV1Yj/3j0VPNMIM/eKs
	RP4MhY7Zlgoe2QPdtHVImdwDnM0FidKn6yEU/YQpW95aqWV18kUk2/0mjJ7S4BnztqpWzkN0zsx
	sIlUbZaehwwzM2FA0Gutj0h0rdxdBZVXK8aX/
X-Google-Smtp-Source: AGHT+IGDwBi3yLJfPm5yMWIVkcZCAPVq5mU9L6D7eXbtjrN0dgW77yYvopVhiHdkopIzfMoYb/n3poHlhtf5hwQkOcg=
X-Received: by 2002:a05:6808:1521:b0:3d9:29c1:be41 with SMTP id
 5614622812f47-3dd2991fc6amr310379b6e.10.1723572905665; Tue, 13 Aug 2024
 11:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801175548.17185-1-zack.rusin@broadcom.com>
 <CAO6MGtg7MJ8fujgkA5vEk5gU9vdxV3pzO9X2jrraqHcAnOJOZA@mail.gmail.com>
 <CABQX2QOeWoVcJJxyQOhgO5XrsLRiUMko+Q6yUMhQbCYHY44LYQ@mail.gmail.com> <CAO6MGtjVd4M_93QUuZrLXoSz9_6ZYswiH7ApUTo-mRybs1UJFQ@mail.gmail.com>
In-Reply-To: <CAO6MGtjVd4M_93QUuZrLXoSz9_6ZYswiH7ApUTo-mRybs1UJFQ@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 13 Aug 2024 14:14:54 -0400
Message-ID: <CABQX2QPsCbtigxNJ=CLJXYvygOV16CSgEUvQMwC0gfPOuVsaQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vmwgfx: Prevent unmapping active read buffers
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, martin.krastev@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:56=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.com=
> wrote:
>
> In that case move `map_count` above `map` which should move it to a
> separate cache line and update the doc strings as needed.

Sorry, I'm not sure I understand. What are you trying to fix?

z

