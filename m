Return-Path: <stable+bounces-89240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C479B5247
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3181F23903
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB05205ADF;
	Tue, 29 Oct 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/RvTDA7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12545205142
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228335; cv=none; b=U7c5r7gxrcWeJ7kpMWuL8KcWmUisMcqyCH/7P6SfOLe8TKXoRhzfCuFdzApCazRCrji7LWJRmGVCEeSmNM/OvpPti+FaBdPvr+4buEVoAYiW6ZcV1J2DCxetLrN8VuJP/OTpk5Q6+EgmJXyLB0YwD9HCMDUGOx84nSuSy4mEvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228335; c=relaxed/simple;
	bh=aWkTZc8Y+jqPDPjDkS4QGc/InSEpbKXcGRwTvfpXufY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwrsjNXgmSW3QUZAsz8VYxY1M01xWvK7/tX371IZwwL95LrmBPRhoMCwfceVa8uIz8cn1Rnt/lFoBfltsJqbCOJkLVluGsekhNEJjNUibLasaac1Ug4uTuqJgWjJXBgGc/CVPinHdvEkqsWDgwcwTTbzM5/L7K0s99p4I471zOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E/RvTDA7; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d4797098dso1855320e0c.3
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730228332; x=1730833132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWkTZc8Y+jqPDPjDkS4QGc/InSEpbKXcGRwTvfpXufY=;
        b=E/RvTDA7e+r2g/3q72W8M+2QMcK38f62r0U4zlGN800/eZToamgcZHFSZ/hnxGLB93
         weqZUxL06Z9M+S19TV2tbvR9rgbtPegQaPmuT4e4L569yr5Gr7qmKxbxq4sU11BAdaw+
         n4PllCQcj67G+G3sD6cCc0biSad2YAqzJNyHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730228332; x=1730833132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWkTZc8Y+jqPDPjDkS4QGc/InSEpbKXcGRwTvfpXufY=;
        b=V/zAZyPxKkPM8Ft0iuTEB1JmV+9DNFeYi/SYfsCN0H0b8bXkkkclHSLJtylbXN/pNu
         KiMcFztVtuCD+7b5L7xOvrG719vmKSjewrxhx5cTIT1+SrjIt7yxTey2V9GjgsfHHZ7m
         Ol6DkeEWh0Jb/ADkXtQm5v20VE0Vyh/+xcUrRNwg6YZ99XnmSKAO4NsTNiQuaDW07vcA
         ceM/VyQp3ns/TN0iXM2FkcdtOvO3w/dONDWOErjbG598UAOLizigKZlHvL7ErskGHIHG
         T4DC4LG5eFeuKvzLmDqLpr+TnuMV0vFdshRgX6iJ6kGuE8Fe6ic/yZvsNRE3d2tL2xUI
         ER5w==
X-Forwarded-Encrypted: i=1; AJvYcCWwIH9MfXm08NqloH7EwT1L6FMtQB3xOYahzINehG3nmSPnlwrsHDLPSRDyeP3MfVV1PuXZsng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8JDWyMxCiKK31GJEmSCkJwXsLr5RmioFwWeKLYLHqAbYrza6
	xi/IchT7ULZJpa6Btqmx5FPpAy3TRVUdeI0c2XJKf4GxHAcr0c9qQJJNZt0YlLQUAQHxb6foQ1f
	ROT3eKFDvj9s5Wzd1mvEuDntLqTZ5wYLSZWnZ
X-Google-Smtp-Source: AGHT+IHNQarJDeF6ZTczXA6wAeLI1sDCSh6JY57hkDajWvrF0A7cvL2N28vNjvcVfNW7OPsHHTypPQAdAONKz15iu68=
X-Received: by 2002:a05:6122:17a9:b0:50d:57df:1522 with SMTP id
 71dfb90a1353d-5101502d48bmr9286161e0c.6.1730228331903; Tue, 29 Oct 2024
 11:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org> <20241029074117.GB22316@lst.de>
In-Reply-To: <20241029074117.GB22316@lst.de>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 29 Oct 2024 11:58:40 -0700
Message-ID: <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
To: Christoph Hellwig <hch@lst.de>
Cc: bob.beckett@collabora.com, kbusch@kernel.org, kbusch@meta.com, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
> > PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
> > is a NMVe to eMMC bridge, that can be used with different eMMC
> > memory devices.
>
> Holy f**k, what an awful idea..
>
> > The NVMe device name contains the eMMC device name, for instance:
> > `BAYHUB SanDisk-DA4128-91904055-128GB`
> >
> > The bridge is known to work with many eMMC devices, we need to limit
> > the queue depth once we know which eMMC device is behind the bridge.
>
> Please work with Tobert to quirk based on the identify data for "his"
> device to keep it quirked instead of regressing it.

The issue is we would need to base the quirk on the model name
(subsys->model) that is not available in `nvme_id_table`. Beside,
`q_depth` is set in `nvme_pci_enable`, called at probe time before
calling `nvme_init_ctrl_finish` that will indirectly populate
`subsys`.

Bob, to address the data corruption problem from user space, adding a
udev rule to set `queue/nr_requests` to 1 when `device/model` matches
the device used in the Steam Deck would most likely be too late in the
boot process, wouldn't it?

Gwendal.

