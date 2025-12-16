Return-Path: <stable+bounces-202216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E223CC2D46
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D6D316191F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90528365A01;
	Tue, 16 Dec 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="A644u/Tu"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438C3659F7;
	Tue, 16 Dec 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887192; cv=none; b=tDi1QTpqyO2mz3GMFpjylNlw05TSWKi17Yk+vtDf84u6CAUROBc5jtLyeIQp0FoyTsSvkMzPKi9kRz04TZBnGfG42yX1k7xN8nF/E6RNz5ZCk87KTyxzXvTzLBdTbURVTy39ZwuI4g2Xm+ETtAzSzgO3p4wD5eIaWWRndIVvvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887192; c=relaxed/simple;
	bh=eRtrAkWDDzyg9MX2RQbjh1UPinq9/Qs3DdeMz9Ux/1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHYmtDlnU19aUrWbY8ckZsAlgOFEk/PLcQ8J4VIO6qyJkfxt0Iu8NNt1mLOiKNTSAE9XBcKh6HXXP6M6wNW+wpru/xvfHVEyEsY/swcw+dGAnIVNaUW3DDUAnvHL+/+eh3TvQundsoi/yAH+v0qM6m6rmEcKXxP74O5TNyTO8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=A644u/Tu; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=AoHSZ1W8XNV5k5WWj7uw0/zG01vzUDAKJRs+epp2RNY=; t=1765887190;
	x=1766319190; b=A644u/TuaRwtET0XKm/jntOPCPoyPo9nPMvxw9MuDbBDZ06AG8ESdeJhFSJOM
	r9eT4c48BiDA2FCRauMYZCmAGXh19RjUO315vSwIhdsufKCLch/iszlZ149wF0WOPE0WHiUznAfBf
	QrM9HM1ImOAhaHkvESDAXdBdS1GAq/oD1/7xHkAivDISH2Aq3r7jw2aPiSsstF9SzYdDqKUXZmzls
	RYEdjBvOOo41my9Lg+nKBuUafcC+txIjVsiCW3+eGwp1yZzuH6WeevfFY5V7MHzFuTE0MmZQiIKzN
	I2KPHv7PT874aLQDqf/qP+8d6cT+WbTFrJPTev9ni5oHv782hQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vVTvQ-00CD2R-0N;
	Tue, 16 Dec 2025 13:13:08 +0100
Message-ID: <f50ce449-e3ae-40eb-a99f-3e8704ebae12@leemhuis.info>
Date: Tue, 16 Dec 2025 13:13:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.17.9 / 6.18 AMDGPU DMCUB Error
To: Neil Gammie <mkpyc9@a1.net>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>
References: <CAFNokafrb+OaqZcPjCdzkLiR7rFoZXjhY9ifdqTNoLhDRmooFA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAFNokafrb+OaqZcPjCdzkLiR7rFoZXjhY9ifdqTNoLhDRmooFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1765887190;c0d33935;
X-HE-SMSGID: 1vVTvQ-00CD2R-0N

On 12/5/25 08:53, Neil Gammie wrote:
> 
> please forgive me if this issue is already known, but I couldn't find
> any reference to it with regard to the 6.17.9 kernel. Anyway, when
> updating from 6.17.8 to 6.17.9, the following error is raised on every
> boot:

Not my area of expertise, but the error is not yet known afaics. As
everything seems to work, it might be something you can just ignore.
Alex might know, but I guess in the end you likely want to report it
here to get feedback: https://gitlab.freedesktop.org/drm/amd/-/issues

HTH, Ciao, Thorsten

> Dec 04 14:44:20 P14s kernel: amdgpu: Topology: Add dGPU node [0x1638:0x1002]
> Dec 04 14:44:20 P14s kernel: kfd kfd: amdgpu: added device 1002:1638
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: SE 1, SH per
> SE 1, CU per SH 8, active_cu_number 8
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring gfx
> uses VM inv eng 0 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.0.0 uses VM inv eng 1 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.1.0 uses VM inv eng 4 on hub 0
> 
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.2.0 uses VM inv eng 5 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.3.0 uses VM inv eng 6 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.0.1 uses VM inv eng 7 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.1.1 uses VM inv eng 8 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.2.1 uses VM inv eng 9 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.3.1 uses VM inv eng 10 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> kiq_0.2.1.0 uses VM inv eng 11 on hub 0
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring sdma0
> uses VM inv eng 0 on hub 8
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring vcn_dec
> uses VM inv eng 1 on hub 8
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> vcn_enc0 uses VM inv eng 4 on hub 8
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> vcn_enc1 uses VM inv eng 5 on hub 8
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
> jpeg_dec uses VM inv eng 6 on hub 8
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: Runtime PM
> not available
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: [drm] Using
> custom brightness curve
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: [drm] Registered 4
> planes with drm panic
> Dec 04 14:44:20 P14s kernel: [drm] Initialized amdgpu 3.64.0 for
> 0000:07:00.0 on minor 1
> Dec 04 14:44:20 P14s kernel: fbcon: amdgpudrmfb (fb0) is primary device
> Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: [drm] *ERROR*
> dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic
> data
> Dec 04 14:44:21 P14s kernel: amdgpu 0000:07:00.0: [drm] fb0:
> amdgpudrmfb frame buffer device
> 
> Setup is as follows:
> 
> Hardware: ThinkPad P14s Gen 2 AMD
> Processor: AMD Ryzen™ 7 PRO 5850U
> OS: Arch Linux
> AMD Firmware: linux-firmware-amdgpu 20251125
> 
> Running a bisection gives the following:
> 
> git bisect start
> # status: waiting for both good and bad commits
> # good: [8ac42a63c561a8b4cccfe84ed8b97bb057e6ffae] Linux 6.17.8
> git bisect good 8ac42a63c561a8b4cccfe84ed8b97bb057e6ffae
> # status: waiting for bad commit, 1 good commit known
> # bad: [1bfd0faa78d09eb41b81b002e0292db0f3e75de0] Linux 6.17.9
> git bisect bad 1bfd0faa78d09eb41b81b002e0292db0f3e75de0
> # bad: [92ef36a75fbb56a02a16b141fe684f64fb2b1cb9] lib/crypto:
> arm/curve25519: Disable on CPU_BIG_ENDIAN
> git bisect bad 92ef36a75fbb56a02a16b141fe684f64fb2b1cb9
> # bad: [aaba523dd7b6106526c24b1fd9b5fc35e5aaa88d] sctp: prevent
> possible shift-out-of-bounds in sctp_transport_update_rto
> git bisect bad aaba523dd7b6106526c24b1fd9b5fc35e5aaa88d
> # bad: [b3b288206a1ea7e21472f8d1c7834ebface9bb33] drm/amdkfd: fix
> suspend/resume all calls in mes based eviction path
> git bisect bad b3b288206a1ea7e21472f8d1c7834ebface9bb33
> # good: [ac486718d6cc96e07bc67094221e682ba5ea6f76] drm/amd/pm: Use
> pm_display_cfg in legacy DPM (v2)
> git bisect good ac486718d6cc96e07bc67094221e682ba5ea6f76
> # bad: [1009f007b3afba93082599e263b3807d05177d53] RISC-V: clear
> hot-unplugged cores from all task mm_cpumasks to avoid rfence errors
> git bisect bad 1009f007b3afba93082599e263b3807d05177d53
> # bad: [ccd8af579101ca68f1fba8c9e055554202381cab] drm/amd: Disable ASPM on SI
> git bisect bad ccd8af579101ca68f1fba8c9e055554202381cab
> # bad: [e95425b6df29cc88fac7d0d77aa38a5a131dbf45] drm/amd/pm: Disable
> MCLK switching on SI at high pixel clocks
> git bisect bad e95425b6df29cc88fac7d0d77aa38a5a131dbf45
> # bad: [5ee434b55134c24df7ad426d40fe28c6542fab4d] drm/amd/display:
> Disable fastboot on DCE 6 too
> git bisect bad 5ee434b55134c24df7ad426d40fe28c6542fab4d
> # first bad commit: [5ee434b55134c24df7ad426d40fe28c6542fab4d]
> drm/amd/display: Disable fastboot on DCE 6 too
> 
> The error still occurs in 6.18, but reverting the above bad commit removes it.
> 
> Although an error is reported, the system still boots to the graphical
> interface and appears to function normally, although I have neither
> benchmarked graphics performance or used the system for an extended
> period after the error has been flagged.
> 
> Yours faithfully,
> 
> Neil Gammie
> 
> 


