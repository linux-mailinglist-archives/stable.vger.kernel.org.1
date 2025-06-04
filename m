Return-Path: <stable+bounces-151468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA47ACE5C0
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 22:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA166178A86
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD01F4703;
	Wed,  4 Jun 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="TYDy0fo0"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B21EB5C2
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749068954; cv=none; b=iaBppAQoUPRHses9wUGC9AcFiA8cz1dBZAdVnAPgISz7jZU4kjUGahBehfNG/mL0KyJjyn3nIyDvIAuApy2yU53dCnDLLiZhVi1t4964QUMqJMhQD1WvrspPMZZIcuerfWZYERSpFrMgNA6RGNGEnxqf9276Oirbx7yNsf6Slxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749068954; c=relaxed/simple;
	bh=7Vka/a7srNrY341gvWXRamDvv2uHEGS89KEna72dgGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebhOW3ITVuiMEgewGWY+tAMPYnFvZV5Z0goIx2QOnN/QuKP/FOf243Te39+Zp3EVaxnyuSH+PXTGd+ia5viR8nlEQSPzOQkzLu2z1jkcKijmVWgdQ0Hqrk2e1UgyqguBhyqxpcbNF7BPNYcGyaMC0pLxdzFZZPL1L2BbQX1gw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=TYDy0fo0; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 4AECE1C2ABC
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 23:29:05 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:to:subject:subject
	:user-agent:mime-version:date:date:message-id; s=dkim; t=
	1749068945; x=1749932946; bh=7Vka/a7srNrY341gvWXRamDvv2uHEGS89KE
	na72dgGQ=; b=TYDy0fo068EA8KmxYo2f9PT5f5a/s6ClXcHkPQ4GI2mWpvDt7Ub
	rAphoQbZmU7A1eM/3kUdeLDclqucIFZLT8CVNbQ1DswfNkGlUAsbp6tZfe3hxaCo
	t98+tmt0gnmlJMIdVPzwM9B4ORav/mMoDIzW2c4D67rhSLFMQTbWXc9M=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XSAJ4nowjGM8 for <stable@vger.kernel.org>;
	Wed,  4 Jun 2025 23:29:05 +0300 (MSK)
Received: from [192.168.1.67] (unknown [46.72.98.152])
	by mail.nppct.ru (Postfix) with ESMTPSA id 236421C08AD;
	Wed,  4 Jun 2025 23:28:55 +0300 (MSK)
Message-ID: <f4d1268f-bbf3-49c1-be27-6199ec685329@nppct.ru>
Date: Wed, 4 Jun 2025 23:28:54 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL dereference in gfx_v9_0_kcq() and
 kiq_init_queue()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sunil Khatri <sunil.khatri@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
References: <20250524055546.1001268-1-sdl@nppct.ru>
 <CADnq5_MyV_C-XJCQEiXKLQhhEGErq7SnvhqFE1AauQPJvt5aYw@mail.gmail.com>
 <bee381b3-305b-46e5-ae59-d816c491fce5@nppct.ru>
 <CADnq5_P-1xGEjJpe--HFFQUaz9A=AO7mQwTXNCZJ693UgdaW0w@mail.gmail.com>
Content-Language: ru
From: SDL <sdl@nppct.ru>
In-Reply-To: <CADnq5_P-1xGEjJpe--HFFQUaz9A=AO7mQwTXNCZJ693UgdaW0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


04.06.2025 22:34, Alex Deucher пишет:
> On Wed, Jun 4, 2025 at 3:30 PM SDL <sdl@nppct.ru> wrote:
>>
>>> On Sat, May 24, 2025 at 2:14 AM Alexey Nepomnyashih <sdl@nppct.ru> wrote:
>>>> A potential NULL pointer dereference may occur when accessing
>>>> tmp_mqd->cp_hqd_pq_control without verifying that tmp_mqd is non-NULL.
>>>> This may happen if mqd_backup[mqd_idx] is unexpectedly NULL.
>>>>
>>>> Although a NULL check for mqd_backup[mqd_idx] existed previously, it was
>>>> moved to a position after the dereference in a recent commit, which
>>>> renders it ineffective.
>>> I don't think it's possible for mqd_backup to be NULL at this point.
>>> We would have failed earlier in init if the mqd backup allocation
>>> failed.
>>>
>>> Alex
>> In scenarios such as GPU reset or power management resume, there is no
>> strict
>> guarantee that amdgpu_gfx_mqd_sw_init() (via ->sw_init()) is invoked before
>> gfx_v9_0_kiq_init_queue(). As a result, mqd_backup[] may remain
>> uninitialized,
>> and dereferencing it without a NULL check can lead to a crash.
>>
>> Most other uses of mqd_backup[] in the driver explicitly check for NULL,
>> indicating that uninitialized entries are an expected condition and
>> should be handled
>> accordingly.
> sw_init() is only called once at driver load time.  everything is
> allocated at that point.  If that fails, the driver would not have
> loaded in the first place.  I don't think it's possible for it to be
> NULL.
>
> Alex
Thanks for the review! I agree with your point.

Alexey

