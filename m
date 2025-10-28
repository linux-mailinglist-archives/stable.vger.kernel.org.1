Return-Path: <stable+bounces-191545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964EC16B36
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F813AE0C3
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243434DCFC;
	Tue, 28 Oct 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klhNUQeX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F133491D4
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681493; cv=none; b=qZWkU0UC5rgqS9eVAeZVx772dZXh+c46Uxa5wBiF7pKX//GH/GXqopVy439/NyEUB/cS1g/kewFffFPmrIM1kvgGy1ZKIjIpFusTJdANcQREacPptO+gsk2oDv7S473tOJZMW5JAd868lb9w8LMDtxKoAFgVLCzkOckKKh4Zwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681493; c=relaxed/simple;
	bh=81YyA1R5iz4fTfXKoVxn0FrqZs3ZkgPsIoR8QbKYtlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coSLFzFdf4bM41ux5osjhilbFr7GCfb7O1j+UOp5h/PGeTK/P96hrlrI3taeDVn8a45MUF87xENPNxGUfxayYU9Cif0mVDZNJRb7qVOHANVio/i22X81hPuFUE9HONmSg7RgNvd/ZyYqesKbU/PjBPljRfUg8uYO2PJr8cEt2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klhNUQeX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ecee8ce926so28467621cf.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681490; x=1762286290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81YyA1R5iz4fTfXKoVxn0FrqZs3ZkgPsIoR8QbKYtlE=;
        b=klhNUQeXcc9P3Rds0AJN+5uFxN3wTx84ylKIs9V9/UJPDqyy0bzwnIHef4aITX1ZC3
         czDNWpRDSQ3j5jma2KsD/xoPC6+uXu7lgqhPF1ByfIyMBADOvht2kHUqpAjRG7uCNWvl
         LdoqHRTu119vRpbkmNy/0H1DhxcEevg2FU78WjCeV8z1fSGZy1VFV6w9RoimB0OQLCLv
         8HM5KN3tHUuGc+FPDX7jLHVoSphuYslb/nF6i6/dMmigERrwkCoaqtILfOAsImTDPIHb
         9Nu/xThmav3SbtN2GX7d2Lt2RdF/YaUGahTeblpr7TJIgcW2Xpza78yIxbye9VSgPY3E
         vcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681490; x=1762286290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81YyA1R5iz4fTfXKoVxn0FrqZs3ZkgPsIoR8QbKYtlE=;
        b=uqmF22Kum1iPgcp6wmZ5A2cqfMStqm3fbc+kG0DzwQupPu/1NRKrHVKHAOssV6SAAR
         f3PHXlbzfwkQ8T0Lrxxl3DiLyNu+PJlnjmk3DsRm2ry1WrMNHcRcs7LNYVz9PtAP8ryg
         Fp5wEVkaOfyQSHvx6lokOO5QzhesuOGI8CMnv84Q+Xu6ASoZ2bI5pd4B3fOBtD3WLJv6
         sg3wew+oslD32wvAF3imXkkAteDo4mqSLnqdaQ5VKii9gGc2/1XPS9rQWanhY2gn1oXq
         tyNb/f5AgLrVoDwuz0gyxJAgofm8Z+5Fg5b/tdoZrd/YJGdTEUenYhEmkshz7kA063J5
         yWWg==
X-Forwarded-Encrypted: i=1; AJvYcCXjo+wjkLJFPOHYJuFJlzoP5DR4HVmowbhWwldAhT1reUPRlWm3lxeXWRefvAvn/4M56DT6c+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjl3pvrtcr1dK7sfLmeh1MX4JRzgy6DuIk0DPfAWmFSl2Mml5
	BoJLlaG2CuP+onGoqnePipsT0Tp2fjmgD8UrRwQacbfkdQBkNb5dvEtybguxoYKT6iGCZG4rRFN
	FycN3oSefTZ1WjvoEeh8cyFfYeYTEXxo=
X-Gm-Gg: ASbGncvQ3ZLmFLzV9vbCSP93LW2Qjhkq0wgqqrxaF3vpVeQywN7BoBIdCQQ61aQnLCE
	cgwNwHrQYteqLq8uiKz2FsOekfxCrg21s2y8grZWqrWhQJutO63MKF7EC+zqKA2bN6B0rUx0mR3
	QA3T5irFbsqSY7A7xCzU9CIVk7x4PUAgnYjVTzr0iVw7grF58K4exmwQ3XV/sdKr9X8uarXOBKM
	lpK5WtA4/w4bJvRS0LhN7zBrBCpaR+eLxcWork6o8j8uKBkSqKUggA8ulbpbQNfNcx1fCDunKow
	k2Kr5lDzYTFVc5CF
X-Google-Smtp-Source: AGHT+IHcPz7GLTlfScG+sYUJ1uTqk6yOB/+ttx87jCRzATu8J8QMSJqa0UraxFmcF3Kh1FSYEqsvJBW0hVJ7aPr7Kyk=
X-Received: by 2002:a05:622a:5a09:b0:4e8:846e:2d8b with SMTP id
 d75a77b69052e-4ed15b757eamr8256071cf.28.1761681490164; Tue, 28 Oct 2025
 12:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028120900.2265511-1-xiaqinxin@huawei.com> <20251028120900.2265511-2-xiaqinxin@huawei.com>
In-Reply-To: <20251028120900.2265511-2-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 29 Oct 2025 03:57:59 +0800
X-Gm-Features: AWmQ_bkDIOr0dScQdWXK4F4cmyPRafg2Akhiis5ZNZevLrtuXc0fPXf9BJv5y_4
Message-ID: <CAGsJ_4wy2B7=KwLfODySky+FADkLZYowWCNm28FBmri_Opv7ZQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dma-mapping: benchmark: Restore padding to ensure
 uABI remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:09=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> The padding field in the structure was previously reserved to
> maintain a stable interface for potential new fields, ensuring
> compatibility with user-space shared data structures.
> However,it was accidentally removed by tiantao in a prior commit,
> which may lead to incompatibility between user space and the kernel.
>
> This patch reinstates the padding to restore the original structure
> layout and preserve compatibility.
>
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header fil=
e for map_benchmark definition")

It would be preferable to include the following as well:

Reported-by: Barry Song <baohua@kernel.org>
Closes: https://lore.kernel.org/lkml/CAGsJ_4waiZ2+NBJG+SCnbNk+nQ_ZF13_Q5FHJ=
qZyxyJTcEop2A@mail.gmail.com/

> Cc: stable@vger.kernel.org
> Acked-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

Thank you. We also need to include Jonathan=E2=80=99s tag[1]:

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

[1] https://lore.kernel.org/lkml/20250616105318.00001132@huawei.com/

I assume Marek can assist with adding those tags when you apply the patch?

Thanks
Barry

