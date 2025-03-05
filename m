Return-Path: <stable+bounces-120415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA5A4FC43
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79C47A4CB3
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD82063CE;
	Wed,  5 Mar 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZvvC40iG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B22080E2
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170669; cv=none; b=hS1evcArKoSFAeaJ3q2IHLkKnBC79fvBIH/Ilp+TsOtu2IyNJSC+mP1cJ6/4lpBs2dNDT51LJqFjwTsinhxnE/v3d/ojruQ60w8e/YkMLovNVHnK837yzah5Q7x24nUgz7/DSgVCcuVaaSVJSoryvmW5PYUfzUVsM5Uv84LOZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170669; c=relaxed/simple;
	bh=124r/J29neIFkscZ3ge9hGjpuITfZ+9RlMSCGg0CH7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zc0yxMYfl52jR/8xJ146Bvsn7WC5a9Nc7xA7XAHdrJlgqreKelCjocnsB7CGXtQToieVrcmRr5/AKMCZM25EU7RfJbet7YU3qxcrhtBw/n8tklt6eukqCUyF45uDrkxAK9xOXwTNuVQvoRjaz96dJprNoT/FBdSG2b1TqlDAG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZvvC40iG; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5439a6179a7so772909e87.1
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741170665; x=1741775465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLXOQT5F9/ec4TjxZKzsxVvUclPaRVMl5DXV9J742E8=;
        b=ZvvC40iG2rqp/HQBPxtGJAO/qr5JA80hBVm2Q5O8+ZP96DaQFn1dvI71KSiY0mBozh
         Y87I7dbrALEWClNCzYB9z7b1vYTJrPL1e5UJyA2ZCF36UqplJQ3nz+xkv9tfq7/sao1c
         WSiK0KZCtduENayfiqgiFpMV4A0BJleRkoeoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170665; x=1741775465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLXOQT5F9/ec4TjxZKzsxVvUclPaRVMl5DXV9J742E8=;
        b=nrQ9hWR72jQNlP3MH7jFvhegwg0P9q1Ljz0TOR+wrZGIXyS9EGtWtSJcMtH202o83v
         ZxZn3W8L4mfaUrAYstuXOylwNyEPzHKvInr57ccZRWUEuldUTvtW7wqDJCsuxf3LZF22
         2D2rLIPLfDKoRJq/N0tySdWkwG7Z+8oV3E+ybtyXfCqHy6PkqG4AqGjlk7mQ8b89Q1nf
         ys7+U0+Xr8aYVnAQK1ql0KvTrTip594FytIWzwaXQD7aaqLA9v3WbIdJJpI5SF0R2NWa
         iyx5xcMOZMIhlit7/Zj+oqbDwSTgYbtb66fDV+s54wYM4rwpT44FTnUUuwteT9NtnaYV
         kC0A==
X-Gm-Message-State: AOJu0YyPGSSue+3dn7mM0J60wDzDPkrlcilV+EmjkrnParWunv9mj4hA
	CQ5wQh49TEoMmBIMtpBohtBiEJ0HpMdMo5lNIoi+jqeTUs9goDIYD+l49418isWJAg2Tkv3Nnkc
	=
X-Gm-Gg: ASbGnctElE+43QlULp7N/8iYzDb6S2uVo6Z8CPOiIDwGnAwGMCSET92af+8rIynKioj
	hHPJOYc2v+wdqSKcINc0y2PxCsToWERqkBTdxpt0yHBItPX0uC2VccShIn3JOVduu08kQTQUV8x
	nr3rzUe/EuZN1k7Nd4wqw7HrRssisbv+y3MQ4tMSMuNkkXACkKtpGicZDbK93FmCAO9Gzw+1CES
	EggS60mcLjiMcX6WtGQP4EeAbFgD2b4ra63EnWfPX5DNO6T0UY+WE98NgnQzzvM9l+4s3fsZ7/k
	AvKIEQFH3AML1EQb7sVLl8rEfo9OO4ASc+WBHMil0v0LEFjPL/CWxB5va3WBeRqasX/ZFFvqJ3w
	PJPrxDFI=
X-Google-Smtp-Source: AGHT+IE0UrBhl2vcRct4lffCEkZpYhJlljsuekVlQbHjX4TSBKIDvXWeFVke6qocVdNoPQgpga/dWQ==
X-Received: by 2002:a05:6512:3d19:b0:549:6309:2b9d with SMTP id 2adb3069b0e04-549756c58c6mr2370294e87.13.1741170665334;
        Wed, 05 Mar 2025 02:31:05 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549509be307sm1520538e87.242.2025.03.05.02.31.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 02:31:04 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5439a6179a7so772872e87.1
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:31:04 -0800 (PST)
X-Received: by 2002:a05:6512:3c9f:b0:549:5769:6ad6 with SMTP id
 2adb3069b0e04-5497d36bb78mr867882e87.10.1741170664091; Wed, 05 Mar 2025
 02:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228083505.2713073-1-ribalda@chromium.org> <20250228185437-e7697605e8039f73@stable.kernel.org>
In-Reply-To: <20250228185437-e7697605e8039f73@stable.kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 5 Mar 2025 11:30:49 +0100
X-Gmail-Original-Message-ID: <CANiDSCuTwzfaw5eT-rT-_9NeTNuL3=tfUPyQsKpmJkHK_C4AsA@mail.gmail.com>
X-Gm-Features: AQ5f1Jrws0DsHK7mPPuXugkH9aQgtyyGHUAMel4o_QKVb96qLr3ykhZ_9_0xaGc
Message-ID: <CANiDSCuTwzfaw5eT-rT-_9NeTNuL3=tfUPyQsKpmJkHK_C4AsA@mail.gmail.com>
Subject: Re: [PATCH 5.4.y] media: uvcvideo: Remove dangling pointers
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

This patch depends on the already committed:
 "media: uvcvideo: Only save async fh if success"

Please apply on top of it.

Thanks!

On Sat, 1 Mar 2025 at 05:21, Sasha Levin <sashal@kernel.org> wrote:
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> =E2=9D=8C Build failures detected
> =E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing pr=
oper reference to it
>
> Found matching upstream commit: 221cd51efe4565501a3dbf04cc011b537dcce7fb
>
> Status in newer kernel trees:
> 6.13.y | Present (different SHA1: 9edc7d25f7e4)
> 6.12.y | Present (different SHA1: 438bda062b2c)
> 6.6.y | Present (different SHA1: 4dbaa738c583)
> 6.1.y | Present (different SHA1: ccc601afaf47)
>
> Note: The patch differs from the upstream commit:
> ---
> Failed to apply patch cleanly.
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.4.y        |  Failed     |  N/A       |
>
> Build Errors:
> Patch failed to apply on stable/linux-5.4.y. Reject:
>
> diff a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.=
c      (rejected hunks)
> @@ -1577,7 +1612,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device=
 *dev,
>
>                 if (!rollback && handle &&
>                     ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> -                       ctrl->handle =3D handle;
> +                       uvc_ctrl_set_handle(handle, ctrl, handle);
>         }
>
>         return 0;



--=20
Ricardo Ribalda

