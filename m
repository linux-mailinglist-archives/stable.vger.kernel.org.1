Return-Path: <stable+bounces-204393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A9CEC9C6
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BAED3009818
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 21:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E230E84B;
	Wed, 31 Dec 2025 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVx2DbjQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B41131E49
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767217941; cv=none; b=a2nFOAGtPyTn4/QcF6o3wPZ0nSyUYLEobN3GY3fo/5QtkysPkSOScqrIP7p83TsyYXCrfDSpK6J8h8x59LhyI96RFkcGEMVvUPg12rV+Y4Bo911JsmBEIrZL50muXlkrj8iIleJ1qkcPx8au3bBD4WX5oHBdmBDCnuHSSfYhP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767217941; c=relaxed/simple;
	bh=0lsq6d/gQPYj9SLz0dIsrDfSjoJsKz4tuuXS1LTbTBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/iIfTvs0juhStkV3GSbezAcZ+oktZ+J/vY+HCAzA5k70X/3T9g9esvN9OLLRoVT86b8ipB5NQGwrADZinqBBnVQo6uoHokatE0kfyi9QwaWRJ+yFTNDRQaiOZ1A1a1CzvSjKxhojR7ws+cnECcF5VSAXFibwsadKxZSKvzb56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVx2DbjQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5959105629bso10985660e87.2
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 13:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767217938; x=1767822738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cjfn9DqBsPvK0Mj5U5qRNWPlKde8DxcL2uQXb+ouwsc=;
        b=MVx2DbjQcqd0N8jt8hJgS+3395Pd5tLBF9wGYWY9/+TwZwY4IkVGWM+81Yxdi2PTSn
         2ydKsJ0jCJ7NWqlti8G1BWAP6Y0y7q9pg8irrRZqjehIgC/ILQ5xLVj/xcQNym7fUECD
         hajM5B21i2vYpTgFeGsamKYygVUDWh1nCGgJaGXuuhBCYzUNQpmfSZGuMez+bUYudfCp
         K0nV98ouH+2utVNAFqzo3bOQAl4VXG9WHm8OuRhB6zBtnhxlJCqu/6qGPcuTqCizdnWp
         YuC9QJWwGyybyLBWKhGgSZB1UtWtxYzjGpB/IV8XcllIvoEU5pMDbslg2REAG8lr9+nC
         VI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767217938; x=1767822738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjfn9DqBsPvK0Mj5U5qRNWPlKde8DxcL2uQXb+ouwsc=;
        b=ZfN17mJGEusNck6h+qKJeMPjEaHLsrkHWtRGIq4QZniZqHnqARd6FeEv/jEKPSv39J
         kT4rqrQqw9JCwjEDvdyFDWio+uANoVK8cgMCRJJBjenDPrnjnOOB+aWY6aMZdFvTOc9n
         rVUntgbx0Os7aQ2jHH0KITR4E+7aNWDQ/WBunm7dmphF7hfsLUMC/ocuIfdUXO0MaCLu
         uAp3QcoR/OcekQLbbcUcUcPPWklrOkB3hpopLrK2LjF5LIhwPQUQ/nLvIYh+QF2fSdOh
         R6OPL7p1lA+ZV2rdgGavD2uRG8skVl8eA9jq44XaeXWixZ1ObHGhF+Q3Uu6NxyRjEfpR
         T5cg==
X-Gm-Message-State: AOJu0Yz75xvlNTqZ6EryhOSTZ1prH/1C4hUxiHfZjMEVze51MLwsUY/d
	2sOn7FXf4S1gbKLTrO/+elp3z5VYL8G6s/P/cB3NwTciC9JLszlxijOA4pJPe81G
X-Gm-Gg: AY/fxX6/lZ9TGGc2ucWVD7PgGLQfCCdoEiaUHBTH2vUknrTeERtH3HfTUnfQAeNRL9m
	bcCSt1X0Vs82jEkkmPxGPxp4bn1pDLGNl9k8VP1K66ovSZN9W3Y1NMQNG8ORaJSy3l1kinXt8Lx
	be1oWU8OTb/bAqJlqnvj4dr9M2ajEm9LWxnmO3VasP0UpTRUWLXfOVBUndjifdIh3+MioqyZ3yl
	afenaPDUp4Q1R3Fty2pCkL+W3RNaBSD/ZOG4sQOQdRK05aiX+ai99sRml0rxpyYYZ6A9lE43MQ9
	RGHELKxkmh5IeGq2LlCPMN6IsUuN9IaCVzCbjafxbA/wHQuwhAkC6sZiG6qdC5EG0S2dWXhXlIY
	y5hdx6b6CHffjAFhPDtxF9egWzdBFnii/2GE6t8wpRkpgzWXGLzXjo7tDcngV1m27NJL7Bmo8tH
	aGiTex9uIj7Z0ZWp5diYquS0Lz6OT3+Qf93fzo9GLnlMh0
X-Google-Smtp-Source: AGHT+IHid0Vwou13jAYw+90m8rZaMWJ/iPwOUATtSlFQor2Cm5pCVyRHF9dvuerOeRa+ds+XbflU8Q==
X-Received: by 2002:a05:6000:40dc:b0:432:8667:51c7 with SMTP id ffacd0b85a97d-43286675205mr19637524f8f.44.1767212040335;
        Wed, 31 Dec 2025 12:14:00 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm75936755f8f.7.2025.12.31.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 12:13:59 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8B3B7BE2DE0; Wed, 31 Dec 2025 21:13:58 +0100 (CET)
Date: Wed, 31 Dec 2025 21:13:58 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: "Dylan E." <dylan.eskew@candelatech.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org, jjohnson@kernel.org
Subject: Re: [BUG 6.18.2] Null Pointer Exception in Fair Scheduler
Message-ID: <aVWEBthpdfNX_Mst@eldamar.lan>
References: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>

Hi Dylan,

On Wed, Dec 31, 2025 at 12:00:07PM -0800, Dylan E. wrote:
> Hello,
> 
> When booting into the v6.18.2 tagged kernel from linux-stable, I get the
> following
> stack trace while booting into the system every 1 in 5 boots or so, usually
> during
> fsck or early systemd service initialization:
> 
> ---
> BUG: kernel NULL pointer dereference, address: 0000000000000051
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 0 UID: 0 PID: 15 Comm: rcu_preempt Not tainted 6.18.2 #2 PREEMPT(full)
> Hardware name:  /SKYBAY, BIOS 5.12 06/27/2017
> RIP: 0010:pick_task_fair+0x57/0x160
> Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 74
> ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 00 48 89
> c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
> RSP: 0000:ffffc900000d3cf8 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000800
> RDX: fffffc02295d3c00 RSI: 0000000000000800 RDI: 0000000002edc4f2
> RBP: ffff888108f13000 R08: 0000000000000400 R09: 0000000000000002
> R10: 0000000000000260 R11: ffff888108b74200 R12: ffff888265c2cd00
> R13: 0000000000000000 R14: ffff888265c2cd80 R15: ffffffff827c6fa0
> FS:  0000000000000000(0000) GS:ffff8882e2724000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000051 CR3: 00000001110a5003 CR4: 00000000003706f0
> Call Trace:
>  <TASK>
>  pick_next_task_fair+0x1d/0x3d0
>  __schedule+0x1ee/0x10c0
>  ? lock_timer_base+0x6d/0x90
>  ? rcu_gp_cleanup+0x560/0x560
>  schedule+0x23/0xc0
>  schedule_timeout+0x6e/0xe0
>  ? hrtimers_cpu_dying+0x1b0/0x1b0
>  rcu_gp_fqs_loop+0xfb/0x510
>  rcu_gp_kthread+0xcd/0x160
>  kthread+0xf5/0x1e0
>  ? kthreads_online_cpu+0x100/0x100
>  ? kthreads_online_cpu+0x100/0x100
>  ret_from_fork+0x114/0x140
>  ? kthreads_online_cpu+0x100/0x100
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
> Modules linked in: i915 drm_buddy intel_gtt drm_client_lib
> drm_display_helper drm_kms_helper igb cec dca rc_core i2c_algo_bit ttm
> agpgart e1000e serio_raw hwmon drm mei_wdt i2c_core intel_oc_wdt video wmi
> CR2: 0000000000000051
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:pick_task_fair+0x57/0x160
> Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 74
> ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 00 48 89
> c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
> RSP: 0000:ffffc900000d3cf8 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000800
> RDX: fffffc02295d3c00 RSI: 0000000000000800 RDI: 0000000002edc4f2
> RBP: ffff888108f13000 R08: 0000000000000400 R09: 0000000000000002
> R10: 0000000000000260 R11: ffff888108b74200 R12: ffff888265c2cd00
> R13: 0000000000000000 R14: ffff888265c2cd80 R15: ffffffff827c6fa0
> FS:  0000000000000000(0000) GS:ffff8882e2724000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000051 CR3: 00000001110a5003 CR4: 00000000003706f0
> Kernel panic - not syncing: Fatal exception
> Shutting down cpus with NMI
> Kernel Offset: disabled
> Rebooting in 30 seconds..
> ---
> 
> I can't seem to reproduce this issue with the v6.18.1 tagged linux-stable
> build, and
> after bisecting between v6.18.1 and v6.18.2, I land on this commit (which is
> clearly
> not the problem):
> 
> d911fa97dab3ba026a8b96bb7f833d007b7fc4e1 | wifi: ath12k: fix VHT MCS
> assignment
> 
> I don't have any ath12k radios in my system, but I do have 1 ath9k and 2
> ath10k
> radios. A little up the tree I see this patch which *could* be related, but
> I lack
> the knowledge to know:
> 
> b1497ea246396962156b63d5c568a16d6e32de0b | wifi: ath10k: move recovery check
> logic into a new work
> 
> Let me know if there's any more info that's needed or additional steps I can
> take to
> further diagnose the bug.

This should be the same issue as reported in
https://lore.kernel.org/oe-lkp/202510211205.1e0f5223-lkp@intel.com/
and then fixed in mainline with 127b90315ca0 ("sched/proxy: Yield the
donor task") .

Can you confirm picking this commit fixes the issue?

Regards,
Salvatore

