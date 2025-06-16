Return-Path: <stable+bounces-152689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ABFADA7D8
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 07:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F363A3B14
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 05:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27FB1D416E;
	Mon, 16 Jun 2025 05:54:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63015DBC1;
	Mon, 16 Jun 2025 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750053243; cv=none; b=hUYZQGNCtVdv/pDateILA4BPE81CH7v3tmB2EhUxOtwW1smx5BUPARB91EKNuHkcgZFF7OACBKHB6YdUJTcTeoC10JM+Ls5bMYXD7qumlscZ2dd8i6JzGndsXauL0zAmAa6k34NI39redBo/gLFRAiORVpBceaCC94mZ3tA687A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750053243; c=relaxed/simple;
	bh=74ZjaoWNfK7FR3D5Pn6XXTTwWWlLDwZFHG6UGrARaF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZmvQ4tcXYe8/mSamiHQYFe2xBd3BonFy/Z14PF/9rg/ML0rZ67W2fcRG9HDo9zv91aXPvzmRhCastviwxvYmKpUJYdkAFKhczt8IUwUqK7iuG/QNWgkgxMPXqO9jmT93Nr5I8JPit5I7DtdX3h4yHuWj0PN6ZvXEoVnzbsFUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.43.209] (om126157192128.27.openmobile.ne.jp [126.157.192.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 8A21C3F02F;
	Mon, 16 Jun 2025 07:53:40 +0200 (CEST)
Message-ID: <4cfbde5a-5bbe-462c-a52c-fe1c65aa3815@hogyros.de>
Date: Mon, 16 Jun 2025 14:53:35 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] drm/xe: enable driver usage on non-4KiB kernels
To: jeffbai@aosc.io, Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Francois Dugast
 <francois.dugast@intel.com>,
 =?UTF-8?Q?Zbigniew_Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Zhanjun Dong <zhanjun.dong@intel.com>, Matt Roper
 <matthew.d.roper@intel.com>, Alan Previn
 <alan.previn.teres.alexis@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Mateusz Naklicki <mateusz.naklicki@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kexy Biscuit <kexybiscuit@aosc.io>, Shang Yatsen <429839446@qq.com>,
 Wenbin Fang <fangwenbin@vip.qq.com>, Haien Liang <27873200@qq.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, Shirong Liu <lsr1024@qq.com>,
 Haofeng Wu <s2600cw2@126.com>
References: <20250613-upstream-xe-non-4k-v2-v2-0-934f82249f8a@aosc.io>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20250613-upstream-xe-non-4k-v2-v2-0-934f82249f8a@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/13/25 10:11, Mingcong Bai via B4 Relay wrote:

> This patch series attempts to enable the use of xe DRM driver on non-4KiB
> kernel page platforms. This involves fixing the ttm/bo interface, as well
> as parts of the userspace API to make use of kernel `PAGE_SIZE' for
> alignment instead of the assumed `SZ_4K', it also fixes incorrect usage of
> `PAGE_SIZE' in the GuC and ring buffer interface code to make sure all
> instructions/commands were aligned to 4KiB barriers (per the Programmer's
> Manual for the GPUs covered by this DRM driver).

Tested on POWER9 (TalosII) with B580, comparing commit b8f759deb9 with 
4k pages with the same plus these patches with 64k pages. I did not test 
4k pages with these patches, I suspect that is already well covered by CI.

The Piglit test suite reports the exact same number of pass/fail/crash 
for both configurations.

https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1310#note_2959331

Are there other tests that make sense? Piglit does not include video 
playback, for example. Since I have a dGPU, I can't run SR-IOV tests, 
though.

    Simon

