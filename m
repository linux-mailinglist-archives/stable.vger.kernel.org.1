Return-Path: <stable+bounces-98859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F059E6043
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 22:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571E6169D08
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 21:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3A1C07C8;
	Thu,  5 Dec 2024 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qan6aY59"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9A19DF66
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733435623; cv=none; b=vDx8OkrDopDZuJxoESjGaahm4U/yuj4gk/rmOkuzs6VyQ0Sz8LDIqHjGgEJN5QATv2isp+SohLgwsY04AHqtGGzhQNqEO1kVZ5hqRwfTwSJAiRFHJ5puynESzD58uEMjoZrgnuuDZsg4Ce1MLiIpixK097oNwz5r101jMNz7B0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733435623; c=relaxed/simple;
	bh=olezBj5hU++GVc9fyVkBN0k/RRkEKEgHJnYEPg7J3HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/NcPiSXG+4qUXwfolc/632NWxRiHBsY09+KklecsORv8FXSF6a5TSN3omEr8IN5dpgsLeH2zKXmwc/F6gxTlwHsXvkQ67uaRUBfx/xkjNwJWWmfpGLooUZJ5+QIPkAv9gkTyNQEPhA6EbIhLMHeLLsn09iXfsPx8XmKo2k/yxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qan6aY59; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-515d0e09f2fso384494e0c.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733435620; x=1734040420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gDQjPlS1AG51euFwytbFdQZXGvmJG/Xvn5DXHovM5Y=;
        b=Qan6aY59UbaqzMmt7eFilPacsHT8JMRLqyeqRIYHBBmLhBSQkRR5a3zB53PMqr5ttN
         3krLKdCXe/8UhOS0f7LjTZw0uO4l9RpeaVjPl/WbFOjqvyzsa2CHwsl2MmQJFPFakXl7
         TcWUbkNr5EX8t34utdw89gUMWzIp0ubXmYcC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733435620; x=1734040420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gDQjPlS1AG51euFwytbFdQZXGvmJG/Xvn5DXHovM5Y=;
        b=gKGEhzEKUM55OWv7/aI+UTmUg/cxSKs65XFwWWqC8/01GlEs9mjq6GkDRrtDgHj8oz
         lUew2IUW4rETYkDEPPEz8W5q5Q+rs5XIIO3pOZs4K2MCAhEjdZ50fozBNR3W9URVi0Vv
         e0a41og6InWxfqgAiLWWhccXUJKbLyBwfUgWWCQmoKHxljRJncW2aAVbjqhZgmJ1Bs2T
         oOpqoW89VdFJ0UHPXOgz/BLx2Hf/jffmvj2RzWtUK4uxCG8hyTgVLb2kt/xq+3+oUTe3
         BL0zMMRkEQu9LDke+MfKYvzn08oCpVocltOfspCIKN5S6R6KbVj+Yz29YyS8mb0QpXuj
         D8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUA56zhjs05sa4bxPczs4wSoy3px58j2snR2WVVuOpuQLK+UCI7a6ELF91Rps3u88Ds5aFwoGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfSaogthqSRjBX1SfgZCCp/kRENzGhO2HZ7EqXF+/SRIh/Wd7
	V21CZLIfzjdhpXV9U7Ix6wfhB/fd0NNOAf5BVMgBl3b3vWjr351b0tyTrOAmz+CH6EHI449EO+y
	RiEoXb34e0YONQdR3C1mlZZPN61Sv3wDDlDuO
X-Gm-Gg: ASbGncs5WEqYqC5z/nK0W1Z7UbO2hau4x8DD/dH/TOTE2K9qS0U4nVGbedr7k5ZG0r0
	y5pnQsIjMpAM5uzzC7iO6xL61uRFxzn6F/0nJIfGYHltO4p8HEvuvuo2Vu0SC/VVI
X-Google-Smtp-Source: AGHT+IEmvn/lxMBSMBB+tVk5gZMlBqGiKWv8YmxOzM55UzTq1Wc4l5ml/qgygEWL2gTiL1+Ri/LEoggjMxoAIwf7NBI=
X-Received: by 2002:a05:6122:1b01:b0:515:c854:d3c6 with SMTP id
 71dfb90a1353d-515fca0bd92mr1183134e0c.4.1733435620699; Thu, 05 Dec 2024
 13:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org> <20241029074117.GB22316@lst.de>
 <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com> <192d9b75f76.106d874861279652.1491635971113271140@collabora.com>
In-Reply-To: <192d9b75f76.106d874861279652.1491635971113271140@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Thu, 5 Dec 2024 13:53:29 -0800
Message-ID: <CAPUE2utp0qOiMRNPwtn_gF45f2awa9UyNJ91zmpRbtu6zR5p9w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
To: Robert Beckett <bob.beckett@collabora.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch <kbusch@kernel.org>, kbusch <kbusch@meta.com>, 
	linux-nvme <linux-nvme@lists.infradead.org>, sagi <sagi@grimberg.me>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:19=E2=80=AFPM Robert Beckett
<bob.beckett@collabora.com> wrote:
>
>
>
>
>
>
>  ---- On Tue, 29 Oct 2024 18:58:40 +0000  Gwendal Grignou  wrote ---
>  > On Tue, Oct 29, 2024 at 12:41=E2=80=AFAM Christoph Hellwig hch@lst.de>=
 wrote:
>  > >
>  > > On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
>  > > > PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
>  > > > is a NMVe to eMMC bridge, that can be used with different eMMC
>  > > > memory devices.
>  > >
>  > > Holy f**k, what an awful idea..
>  > >
>  > > > The NVMe device name contains the eMMC device name, for instance:
>  > > > `BAYHUB SanDisk-DA4128-91904055-128GB`
>  > > >
>  > > > The bridge is known to work with many eMMC devices, we need to lim=
it
>  > > > the queue depth once we know which eMMC device is behind the bridg=
e.
>  > >
>  > > Please work with Tobert to quirk based on the identify data for "his=
"
>  > > device to keep it quirked instead of regressing it.
>  >
>  > The issue is we would need to base the quirk on the model name
>  > (subsys->model) that is not available in `nvme_id_table`. Beside,
>  > `q_depth` is set in `nvme_pci_enable`, called at probe time before
>  > calling `nvme_init_ctrl_finish` that will indirectly populate
>  > `subsys`.
>  >
>  > Bob, to address the data corruption problem from user space, adding a
>  > udev rule to set `queue/nr_requests` to 1 when `device/model` matches
>  > the device used in the Steam Deck would most likely be too late in the
>  > boot process, wouldn't it?
>
> I've never seen the corruption outside of severe stress testing.
> In the field, people reported it during and after os image updates (more =
stress testing).
> However, as this concerns data integrity, it seems risky to me to rely on=
 a fix
> after bootup.

Since limiting the queue depth to 2 is only needed for a small subset
of eMMC memory modules that can be connected behind the bridge, would
it make sense to apply this patch, but add the kernel module parameter
mentioned earlier for impacted devices?

Gwendal.
>
>  >
>  > Gwendal.
>  >
>

