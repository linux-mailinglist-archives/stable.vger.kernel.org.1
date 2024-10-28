Return-Path: <stable+bounces-88972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1629B284B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 08:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CE82823D1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E018E749;
	Mon, 28 Oct 2024 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ewz72AmO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4216D9DF
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098844; cv=none; b=LVMoEoclyqiLW5Jk7vb1iPGEVy5EjqngPJmM3B0me5MTuLZ3XHP/SF+Slw2isIfJMJp4LbBaJX6nOQy7LqRm7Vz2U5OUGWKqwx0XnrZvIWx0rAH6wVN5Rv7b7/GE/pe3G613tkpR+72BdoQsOgURxktMSHKoBOD+XhoDGCHYjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098844; c=relaxed/simple;
	bh=oXeJH9+dd3cazFRcmOcTf4KQwEKjtruutzeaxtbL0pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXOnkdxzZu67BIBYzYo34DIXaJbwAQrxC14qRJbGuTAwBzvi448V/77csSYfwefshmWSUwULP4CpTKGgMFMkkNmsjZ1a3xKh+j4fCizTR0qmUVgL/r0HV6/bN+H8mTz9G/qoiScTz5FYGXbhZFPZ0SsEL26ZN46cq4tEeDS0xDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ewz72AmO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so5213109e87.1
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730098841; x=1730703641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXeJH9+dd3cazFRcmOcTf4KQwEKjtruutzeaxtbL0pk=;
        b=Ewz72AmOE7o2HKbvwGZTGFqWiR6TFCecQrEUYj/JFkxR6twAB7ULmyBz9jkTyCgPfJ
         f5PI6tkq1bOHkxGira8EwTeDOgf2ciuCm0j9K+8350AQM8EKmY9EFCNUxuRESbZmI7pM
         7jb63oW55pTP6LbqM5M0mSoIr9PNPy4FzbLy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730098841; x=1730703641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXeJH9+dd3cazFRcmOcTf4KQwEKjtruutzeaxtbL0pk=;
        b=NjXLB4h5wH4nuycGC3LFTebmw7mz0/wZYhMCIh6TXbmIEvCwEC8C4xKI2PQHX1dUqz
         Ws2rmvicSskfc2mr2rbsuaBMVZ2qUENf2ZiXZB5kKd45ho3nUijcwzfJw+x+hFGTkhVj
         JDuXDPuzIBhjR0ghjmlMnP+EXgFa3rIa2joLr8eH/hhG1Kyxjq9Xfdkcjp2QHvhT1eDo
         BF42p3sAkzmVueBI8iCf4zhKuq0mqPT3FX0y10nPGU4Ym9PCbmL9hSySDEbprqj3IZvx
         km8BuhnDL8RrxAM4hQHZUdFr/e6W/j545A8GjNZQYvmSb7EtrOnksc0x+iSbwknHDjzc
         mfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWURiVrpw/Q/SSiGQL580BOdNGGkbtlhw3+7dVCXtYR2Zn1Hf+vNF3pYELjSvobSGF32ZngxTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFIFiqYM3Gf117bWkIcEEI5PVs+vjd1K5yF/fdCgnv9e55+qt
	LdgVK76m2mcsMS26HRkWtJdxI/2wgr65pmjphE+hWB7pOFO7hq2ktT3SQIBcL1oSRXhG1OvjnFQ
	Kd7tSsfpaW0Z7FySQ3KfnrK6SPg3T8NF77+pW
X-Google-Smtp-Source: AGHT+IG0bSkKwUt4vIe/DSFsd27a0aZcM775T78oioXCX/0ert+iimxun6TtbNvBDPU5UOHkKZf2rc0Rt4hi62j6fcI=
X-Received: by 2002:a05:6512:3ba3:b0:539:eb44:7ec3 with SMTP id
 2adb3069b0e04-53b3490fabamr2408370e87.31.1730098840615; Mon, 28 Oct 2024
 00:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com> <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 28 Oct 2024 15:00:29 +0800
Message-ID: <CAGXv+5Ge_qcXaSBQ9d8QZOWe3x_9-6r9LhDGvAbUHNKYMwevUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mediatek: Fix child node refcount handling in
 early exit
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 3:22=E2=80=AFAM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Early exits (goto, break, return) from for_each_child_of_node() required
> an explicit call to of_node_put(), which was not introduced with the
> break if cnt =3D=3D MAX_CRTC.
>
> Add the missing of_node_put() before the break.
>
> Cc: stable@vger.kernel.org
> Fixes: d761b9450e31 ("drm/mediatek: Add cnt checking for coverity issue")
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

