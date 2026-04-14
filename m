Return-Path: <stable+bounces-237865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB+PC1473mkxpgkAu9opvQ
	(envelope-from <stable+bounces-237865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:04:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C664A3FA468
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA503019749
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B03E63AA;
	Tue, 14 Apr 2026 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aT/HMg98"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A02DF134
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171857; cv=none; b=ANCoEBQ+VcCAph9tSeD2BQL4qbAKSXD66MZR0oDkg8ZBpm9Z5Kc3Im2Tbo2drv5cR5EMHTTIPHW6UiA1Rqqas3EjuaJkV8c8OuQXhy1w09x01A4ygxOW/TTpkOWgQGLap5GGkYpQ8W5GwOuppiEnXp9zEFCCUKqDTQkZ0yfNJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171857; c=relaxed/simple;
	bh=X3iqHUAl7s6H3AK9rg2+ysVxYgx8gWfHDnOTiRX3bjY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=PGIpVXsdBwOkteFkz2sf6udNRAYCfhd/cXXx+YWcS9K5lvMv3pMISXRX5NcI8oJ8XcfKegP3/C0aC5s0C99bpDm3xeUc8fjJ71i63snOCQZFF7z+2rg9ETffP0bEKKXedUMyvfvP8ZYFMQ17h0MqLBI2OnW1+ZCQV3Is0FHFDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aT/HMg98; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso67886095e9.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776171854; x=1776776654; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MzAlvnLghgPp6pdhRG09xMlxABGupst/LverorwJwA=;
        b=aT/HMg98ZGLgw0H0E6o0QHhnCrmwu6AlF+OOpRvxeICqFvPErx3kwDA9rfnCZx0DBy
         U8tyDELd1/4KUfOfsZYyO/XW2h2wKsb/aFSYK5iEzFGpn3SXbU/X7cDtpZh1FFUT3i2F
         dk8ix/4x2QVUI02CIt3uAp3rzp+Ai8GqI0Q2XddAA6FZf8IrBWWKQbS2iFN+Ie0csmMb
         KURzBa1sDPofKxxeTxbAYPweWaGFwYJRIOqj+crhVlNHKV9XuL5FTNkh/Yn+8k/WUkTH
         PcoSLyrpfGw3nOArJTyYkS17V8Obu1Ja4yYvDZY6s4MLBKT45FlkvWktQ+4CgCm/DiD9
         K1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171854; x=1776776654;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MzAlvnLghgPp6pdhRG09xMlxABGupst/LverorwJwA=;
        b=JzZ0Hr/In4TI1LfT4gzccQq4qqFzKeVsLpMl9t2yz+wJraaq0aYTJXdoNh1uI/w2CX
         Dlvmn+qG76JvntdgDruFraFKB/U8/PxWzss26vQsVenziWDTx7OELnA1ebVMavTZSW1d
         XNnGrZL4Y+Q3EsiUxNlcju65yKfcPaD7VSX0ZWyWDQFjutf2fHmKpdBc7Ozzl7ZpHqwS
         pWlNAPpkoA8T3qEYhn3YaSNnE61veS4Q8TxWS68HELooldnoNwl/ROwKXz0Xhe13Hdbd
         4O9wP1I+gAphuUcctumykroVm8UToW7amW3VThlGUh1FsPrwpto2L91us+CcQujBUsIS
         FJxw==
X-Forwarded-Encrypted: i=1; AFNElJ9HhG3IdoRf7kkBVyKGm1eJwV/Vm/sQ1Gv7duVL/kHEg1lvNzixudpULcYIJerHCPifCcgdxqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQojYnUjp5vszHCXHDEAZ8bTmpOs32NPt6CejHzTFMFYdGaHPj
	zvxe4GuhmTd4nvKPotYIRAbPIMcSKKm9uv33D+AIFkaxYWHDtuMguteWXs+FK44Mjls=
X-Gm-Gg: AeBDiesFGQnuoeYjHK2QzY1OoK9KQ5g5hLgWhgM73A1tTr0H1XTk1kDCNHiusSZZahC
	ysnuzG5kumYGCwqvTc+N6gga1JwzE0aNYbNeFVNpLID2FphT0HbvbfSrrdnceMZhATSY5AZH6EV
	2qsllz1yvFNoV1fybY2CMemgJZUAM2pmsXRGoTzwljdepJJraSKSwrfDIJJoe038qTQF/mpMFY/
	XaLGoGosgXbDft/T8Z3Gp432z5u2MXt02GKbM7OW3WeDplkFEcvmF1LX51hSi7arfyqwfpqyK2E
	e8saAbVLvd2sARX1bASHSCsmN8uZ5zV10pRouA8AFhMV8/3Y+O2wvkvqUofN9CY5Jjjpi+Gzlr4
	/eTP5c57/R0NN6pySYtHHrZCKgcv0Dq9NS6wXhu/8uthH2vHl6bHWT4uBmysg6mzirxio6NzKN0
	Qe91UEm/ajEJklpi1xJNdtGlhB/vxa0MSmvlF1p2zCMw==
X-Received: by 2002:a05:600d:d:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-488d684b88amr180000235e9.20.1776171853516;
        Tue, 14 Apr 2026 06:04:13 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee042e47sm49438735e9.13.2026.04.14.06.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:04:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Ph6fdNNznB04kJsUkIc4SQC3"
Message-ID: <e38cd400-573d-400c-9647-b918d9af7f98@linaro.org>
Date: Tue, 14 Apr 2026 16:04:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, jyescas@google.com,
 kernel-team@android.com, stable@vger.kernel.org
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
 <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
 <20260323173138.GB8437@ziepe.ca>
 <9892a17b-022e-41df-af1c-a2d684aa8db1@linaro.org>
 <20260402115958.GA2551565@ziepe.ca>
 <39d07d46-fee3-48a3-a991-b293e9d498db@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <39d07d46-fee3-48a3-a991-b293e9d498db@arm.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237865-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C664A3FA468
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------Ph6fdNNznB04kJsUkIc4SQC3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Robin,

Thanks for the educative answers.

On 4/2/26 5:20 PM, Robin Murphy wrote:
> On 2026-04-02 12:59 pm, Jason Gunthorpe wrote:
>> On Thu, Apr 02, 2026 at 02:25:54PM +0300, Tudor Ambarus wrote:
>>
>>> I can probably track whether all instances are ready, and defer if any
>>> is not ready, but then I'll force the iommu clients to use the sketchy
>>> replay path, which seems like a bad idea, according to Robin's feedback.
>>
>> I didn't think that was sketchy, it is part of the boot ordering
>> system to ensure that the iommu driver(s) is probed before the client
>> devices.
>>
>> Half operating a device is definately going to get things into trouble
>> with broken/incomplete domain attachments at least.
> 
> The Exynos driver itself is actually fine, and doing everything right. We'll never have a "half-configured" client device in IOMMU API terms currently - only once both instances are registered such that both of_xlate calls can succeed (one for each specifier in the client device's "iommus" property) will we proceed to calling probe_device, which will then work as normal.

I assume this is true because of core_initcall(exynos_iommu_init);

Or is it something else that guarantees that both the IOMMU instances
are registered at exynos_iommu_of_xlate() time? The instance's drvdata
is set before the instance registers, and the rest of the code in
exynos_iommu_of_xlate constructs the client's list of iommu instances.

> 
> The issue here is purely in the race-avoidance scheme within of_iommu_configure() itself, which hasn't accounted for the fact that when it's looping over multiple specifiers, they don't necessarily all target the same IOMMU node. And it's only during a window where the instance targeted by the first specifier happens to be registered already, and the second is currently in the middle of registering.

Allow me to give an example. I added some extra prints to catch things.
I attached a diff if you want to see exactly where. I stripped a bit
the log so that it's easier to follow. I added comments.

19471000.drmdecon describe 19840000.sysmmu and 19c40000.sysmmu in its
"iommus" dt property.

[    2.308076][    T1] samsung-sysmmu-v9 19840000.sysmmu: tudor: samsung_sysmmu_device_probe: after iommu_device_register
	^ first instance registered

[    2.310095][   T86] platform 19471000.drmdecon: tudor: really_probe: enter for driver exynos-decon
	^ client in really_probe()

[    2.311634][    T1] samsung-sysmmu-v9 19c40000.sysmmu: tudor: samsung_sysmmu_device_probe: before iommu_device_register
	^ second instance right before calling iommu_device_register()

[    2.312358][   T86] exynos-decon 19471000.drmdecon: tudor: really_probe: after setting dev->driver exynos-decon
	^ client set dev->driver!

[    2.348787][   T86] exynos-decon 19471000.drmdecon: tudor: of_iommu_configure: of_iommu_configure_device err = 0, dev_iommu_present = 0
	^ of_xlate succeeded for both instances
	We're in the client's really_probe() path. Shall of_xlate fail if the iommu instance is not registered yet?

[    2.349277][   T86] exynos-decon 19471000.drmdecon: tudor: of_iommu_configure: call iommu_probe_device new dev_iommu_present = 1, dev->iommu = 000000007deaca98
	^ initial dev->iommu was not set, we prepare to call iommu_probe_device() even if dev->iommu was set in the of_iommu_configure_device() call
	  The thread is going to sleep now, it can't acquire iommu_probe_device_lock

[    2.358261][    T1] exynos-decon 19471000.drmdecon: tudor: iommu_init_device: bus->dma_configure not called dev->iommu = 000000007deaca98, dev->iommu_group = 0000000000000000, dev->iommu->fwspec = 00000000896797d4 dev->driver = 000000008821e7b2
	^ inside iommu_init_device(),  dev->bus->dma_configure(dev) is NOT called. Then it calls ops->probe_device() and ops->device_group(), succeeding.

[    2.360561][    T1] ------------[ cut here ]------------
[    2.360729][    T1] exynos-decon 19471000.drmdecon: late IOMMU probe at driver bind, something fishy here!
[    2.361153][    T1] WARNING: drivers/iommu/iommu.c:650 at __iommu_probe_device+0x3a0/0x608, CPU#7: init/1
[    2.369032][    T1] CPU: 7 UID: 0 PID: 1 Comm: init Tainted: G S         O        6.19.0-mainline-g2887d9327e73-dirty #1 PREEMPT  12ccb00dc0e1a023f9ae52bf43dc85a3c6f0cd0b
[    2.369592][    T1] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
[    2.369848][    T1] Hardware name: ZUMA PRO KOMODO EVT 1.0 Broadcom GNSS board based on ZUMA PRO (DT)
[    2.370205][    T1] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    2.370499][    T1] pc : __iommu_probe_device+0x3a0/0x608
[    2.370681][    T1] lr : __iommu_probe_device+0x3a0/0x608
[    2.370915][    T1] sp : ffffc0008005b4c0
[    2.371043][    T1] x29: ffffc0008005b4c0 x28: ffff80001d791290 x27: 0000000000000000
[    2.371372][    T1] x26: 000000000000001d x25: ffffc0008005b598 x24: ffffe42571f2dd08
[    2.371674][    T1] x23: ffff80001e00e490 x22: ffff800005744e00 x21: ffffe4256fd687e0
[    2.371976][    T1] x20: ffffc0008005b598 x19: ffff800005b79810 x18: ffffe425731e13c0
[    2.372277][    T1] x17: 000000008c623181 x16: 000000008c623181 x15: 0000000000000000
[    2.372553][    T1] x14: 0000000000000003 x13: ffff800a7eef8000 x12: 0000000000000003
[    2.372881][    T1] x11: 0000000000000003 x10: 00000000ffff7fff x9 : 90cf001dbb0ee800
[    2.373184][    T1] x8 : 90cf001dbb0ee800 x7 : ffffe42571d610b4 x6 : 0000000000000000
[    2.373486][    T1] x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffffc0008005b210
[    2.373788][    T1] x2 : 0000000000000dba x1 : 0000000000000000 x0 : 0000000000000056
[    2.374089][    T1] Call trace:
[    2.374185][    T1]  __iommu_probe_device+0x3a0/0x608 (P)
[    2.374419][    T1]  probe_iommu_group+0x3c/0x68
[    2.374570][    T1]  bus_for_each_dev+0x104/0x160
[    2.374752][    T1]  iommu_device_register+0xe0/0x274
[    2.374947][    T1]  samsung_sysmmu_device_probe+0x720/0x938 [samsung_iommu_v9 756cd85ee7308d7c98df18fc7d1a25a4db1266e9]
[    2.375392][    T1]  platform_probe+0x74/0xb8
[    2.375533][    T1]  really_probe+0x1a4/0x50c
[    2.375702][    T1]  __driver_probe_device+0x98/0xd4
[    2.375892][    T1]  driver_probe_device+0x3c/0x220
[    2.376080][    T1]  __driver_attach+0x118/0x1f8
[    2.376258][    T1]  bus_for_each_dev+0x104/0x160
[    2.376440][    T1]  driver_attach+0x24/0x34
[    2.376603][    T1]  bus_add_driver+0x140/0x2ac
[    2.376779][    T1]  driver_register+0x68/0x104
[    2.376953][    T1]  __platform_driver_register+0x20/0x30
[    2.377186][    T1]  init_module+0x20/0x3fd8 [samsung_iommu_v9 756cd85ee7308d7c98df18fc7d1a25a4db1266e9]
[    2.377524][    T1]  do_one_initcall+0x100/0x3ac
[    2.377702][    T1]  do_init_module+0x58/0x264
[    2.377872][    T1]  load_module+0x1244/0x1290
[    2.378047][    T1]  __arm64_sys_finit_module+0x248/0x334
[    2.378280][    T1]  invoke_syscall+0x58/0xe4
[    2.378423][    T1]  el0_svc_common+0x8c/0xd8
[    2.378590][    T1]  do_el0_svc+0x1c/0x28
[    2.378745][    T1]  el0_svc+0x54/0x1c4
[    2.378892][    T1]  el0t_64_sync_handler+0x84/0x12c
[    2.379084][    T1]  el0t_64_sync+0x1c4/0x1c8
[    2.379252][    T1] irq event stamp: 822284
[    2.379413][    T1] hardirqs last  enabled at (822283): [<ffffe42570bc7dc0>] __console_unlock+0x64/0xbc
[    2.379800][    T1] hardirqs last disabled at (822284): [<ffffe42571d52748>] el1_brk64+0x20/0x54
[    2.380139][    T1] softirqs last  enabled at (822092): [<ffffe42570b02efc>] handle_softirqs+0x484/0x504
[    2.380505][    T1] softirqs last disabled at (822085): [<ffffe42570a10518>] __do_softirq+0x14/0x20
[    2.380854][    T1] ---[ end trace 0000000000000000 ]---
[    2.381058][    T1] exynos-decon 19471000.drmdecon: Adding to iommu group 1
[    2.382126][   T86] exynos-decon 19471000.drmdecon: tudor: __iommu_probe_device: enter
[    2.382420][   T86] exynos-decon 19471000.drmdecon: tudor: of_iommu_configure: after iommu_probe_device err = 0
[    2.382734][   T86] exynos-decon 19471000.drmdecon: tudor: iommu_device_use_default_domain: we hit !group->default_domain
	^ returns -EPROBE_DEFER

[    2.383125][   T86] exynos-decon 19471000.drmdecon: tudor: really_probe: after dma_configure exynos-decon ret = -517
[    2.383445][   T86] exynos-decon 19471000.drmdecon: tudor: really_probe: clear dev->driver exynos-decon
[

--------------Ph6fdNNznB04kJsUkIc4SQC3
Content-Type: text/plain; charset=UTF-8; name="diff"
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9kZC5jIGIvZHJpdmVycy9iYXNlL2RkLmMKaW5k
ZXggYmVhOGRhNWY4YTNhLi5lZmExNjM0MjE0ZTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmFz
ZS9kZC5jCisrKyBiL2RyaXZlcnMvYmFzZS9kZC5jCkBAIC02MDksNiArNjA5LDkgQEAgc3Rh
dGljIGludCByZWFsbHlfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBzdHJ1Y3Qg
ZGV2aWNlX2RyaXZlciAqZHJ2KQogCWJvb2wgdGVzdF9yZW1vdmUgPSBJU19FTkFCTEVEKENP
TkZJR19ERUJVR19URVNUX0RSSVZFUl9SRU1PVkUpICYmCiAJCQkgICAhZHJ2LT5zdXBwcmVz
c19iaW5kX2F0dHJzOwogCWludCByZXQsIGxpbmtfcmV0OworCWJvb2wgaXNfZGVjb24gPSAo
ZGV2X25hbWUoZGV2KSAmJiBzdHJzdHIoZGV2X25hbWUoZGV2KSwgImRybWRlY29uIikpOwor
CisJZGV2X2VycihkZXYsICJ0dWRvcjogJXMgZW50ZXIgZm9yIGRyaXZlciAlc1xuIiwgX19m
dW5jX18sIGRydi0+bmFtZSk7CiAKIAlpZiAoZGVmZXJfYWxsX3Byb2JlcykgewogCQkvKgpA
QCAtNjE2LDExICs2MTksMTQgQEAgc3RhdGljIGludCByZWFsbHlfcHJvYmUoc3RydWN0IGRl
dmljZSAqZGV2LCBjb25zdCBzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJ2KQogCQkgKiBkZXZp
Y2VfYmxvY2tfcHJvYmluZygpIHdoaWNoLCBpbiB0dXJuLCB3aWxsIGNhbGwKIAkJICogd2Fp
dF9mb3JfZGV2aWNlX3Byb2JlKCkgcmlnaHQgYWZ0ZXIgdGhhdCB0byBhdm9pZCBhbnkgcmFj
ZXMuCiAJCSAqLwotCQlkZXZfZGJnKGRldiwgIkRyaXZlciAlcyBmb3JjZSBwcm9iZSBkZWZl
cnJhbFxuIiwgZHJ2LT5uYW1lKTsKKwkJZGV2X2VycihkZXYsICJEcml2ZXIgJXMgZm9yY2Ug
cHJvYmUgZGVmZXJyYWxcbiIsIGRydi0+bmFtZSk7CiAJCXJldHVybiAtRVBST0JFX0RFRkVS
OwogCX0KIAogCWxpbmtfcmV0ID0gZGV2aWNlX2xpbmtzX2NoZWNrX3N1cHBsaWVycyhkZXYp
OworCWlmIChpc19kZWNvbikKKwkJZGV2X2VycihkZXYsICJ0dWRvcjogJXMgZGV2aWNlX2xp
bmtzX2NoZWNrX3N1cHBsaWVycygpIHJldCAlZFxuIiwKKwkJCV9fZnVuY19fLCBsaW5rX3Jl
dCk7CiAJaWYgKGxpbmtfcmV0ID09IC1FUFJPQkVfREVGRVIpCiAJCXJldHVybiBsaW5rX3Jl
dDsKIApAQCAtNjMzLDcgKzYzOSwxMyBAQCBzdGF0aWMgaW50IHJlYWxseV9wcm9iZShzdHJ1
Y3QgZGV2aWNlICpkZXYsIGNvbnN0IHN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcnYpCiAJfQog
CiByZV9wcm9iZToKKwlpZiAoaXNfZGVjb24pCisJCWRldl9lcnIoZGV2LCAidHVkb3I6ICVz
IGJlZm9yZSBzZXR0aW5nIGRldi0+ZHJpdmVyICVzXG4iLAorCQkJX19mdW5jX18sIGRydi0+
bmFtZSk7CiAJZGV2aWNlX3NldF9kcml2ZXIoZGV2LCBkcnYpOworCWlmIChpc19kZWNvbikK
KwkJZGV2X2VycihkZXYsICJ0dWRvcjogJXMgYWZ0ZXIgc2V0dGluZyBkZXYtPmRyaXZlciAl
c1xuIiwKKwkJCV9fZnVuY19fLCBkcnYtPm5hbWUpOwogCiAJLyogSWYgdXNpbmcgcGluY3Ry
bCwgYmluZCBwaW5zIG5vdyBiZWZvcmUgcHJvYmluZyAqLwogCXJldCA9IHBpbmN0cmxfYmlu
ZF9waW5zKGRldik7CkBAIC02NDEsNyArNjUzLDEzIEBAIHN0YXRpYyBpbnQgcmVhbGx5X3By
b2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qgc3RydWN0IGRldmljZV9kcml2ZXIgKmRy
dikKIAkJZ290byBwaW5jdHJsX2JpbmRfZmFpbGVkOwogCiAJaWYgKGRldi0+YnVzLT5kbWFf
Y29uZmlndXJlKSB7CisJCWlmIChpc19kZWNvbikKKwkJCWRldl9lcnIoZGV2LCAidHVkb3I6
ICVzIGJlZm9yZSBkbWFfY29uZmlndXJlICVzXG4iLAorCQkJCV9fZnVuY19fLCBkcnYtPm5h
bWUpOwogCQlyZXQgPSBkZXYtPmJ1cy0+ZG1hX2NvbmZpZ3VyZShkZXYpOworCQlpZiAoaXNf
ZGVjb24pCisJCQlkZXZfZXJyKGRldiwgInR1ZG9yOiAlcyBhZnRlciBkbWFfY29uZmlndXJl
ICVzIHJldCA9ICVkXG4iLAorCQkJCV9fZnVuY19fLCBkcnYtPm5hbWUsIHJldCk7CiAJCWlm
IChyZXQpCiAJCQlnb3RvIHBpbmN0cmxfYmluZF9mYWlsZWQ7CiAJfQpAQCAtNzIzLDYgKzc0
MSwxMCBAQCBzdGF0aWMgaW50IHJlYWxseV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGNv
bnN0IHN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcnYpCiAJaWYgKGRldi0+YnVzICYmIGRldi0+
YnVzLT5kbWFfY2xlYW51cCkKIAkJZGV2LT5idXMtPmRtYV9jbGVhbnVwKGRldik7CiBwaW5j
dHJsX2JpbmRfZmFpbGVkOgorCisJaWYgKGlzX2RlY29uKQorCQlkZXZfZXJyKGRldiwgInR1
ZG9yOiAlcyBjbGVhciBkZXYtPmRyaXZlciAlc1xuIiwKKwkJCV9fZnVuY19fLCBkcnYtPm5h
bWUpOwogCWRldmljZV9saW5rc19ub19kcml2ZXIoZGV2KTsKIAlkZXZpY2VfdW5iaW5kX2Ns
ZWFudXAoZGV2KTsKIGRvbmU6CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L2lvbW11LmMKaW5kZXggNDkyNmE0MzExOGU2Li4zNTA0Mjk2NWIw
ZjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYworKysgYi9kcml2ZXJzL2lv
bW11L2lvbW11LmMKQEAgLTQ1MCw2ICs0NTAsMTEgQEAgc3RhdGljIGludCBpb21tdV9pbml0
X2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJc3RydWN0IGlvbW11X2RldmljZSAqaW9t
bXVfZGV2OwogCXN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXA7CiAJaW50IHJldDsKKwlib29s
IGlzX2RlY29uID0gKGRldl9uYW1lKGRldikgJiYgc3Ryc3RyKGRldl9uYW1lKGRldiksICJk
cm1kZWNvbiIpKTsKKworCWlmIChpc19kZWNvbikKKwkJZGV2X2VycihkZXYsICJ0dWRvcjog
JXMsIGRldi0+aW9tbXUgPSAlcCwgZGV2LT5pb21tdV9ncm91cCA9ICVwXG4iLAorCQkJX19m
dW5jX18sIGRldi0+aW9tbXUsIGRldi0+aW9tbXVfZ3JvdXApOwogCiAJaWYgKCFkZXZfaW9t
bXVfZ2V0KGRldikpCiAJCXJldHVybiAtRU5PTUVNOwpAQCAtNDY0LDEwICs0NjksMTkgQEAg
c3RhdGljIGludCBpb21tdV9pbml0X2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCW11
dGV4X3VubG9jaygmaW9tbXVfcHJvYmVfZGV2aWNlX2xvY2spOwogCQlkZXYtPmJ1cy0+ZG1h
X2NvbmZpZ3VyZShkZXYpOwogCQltdXRleF9sb2NrKCZpb21tdV9wcm9iZV9kZXZpY2VfbG9j
ayk7CisJCWlmIChpc19kZWNvbikKKwkJCWRldl9lcnIoZGV2LCAidHVkb3I6ICVzLCBhZnRl
ciBidXMtPmRtYV9jb25maWd1cmUoKTogZGV2LT5pb21tdSA9ICVwLCBkZXYtPmlvbW11X2dy
b3VwID0gJXBcbiIsCisJCQkJX19mdW5jX18sIGRldi0+aW9tbXUsIGRldi0+aW9tbXVfZ3Jv
dXApOwogCQkvKiBJZiBhbm90aGVyIGluc3RhbmNlIGZpbmlzaGVkIHRoZSBqb2IgZm9yIHVz
LCBza2lwIGl0ICovCiAJCWlmICghZGV2LT5pb21tdSB8fCBkZXYtPmlvbW11X2dyb3VwKQog
CQkJcmV0dXJuIC1FTk9ERVY7CisJfSBlbHNlIHsKKwkJaWYgKGlzX2RlY29uKQorCQkJZGV2
X2VycihkZXYsICJ0dWRvcjogJXMsIGJ1cy0+ZG1hX2NvbmZpZ3VyZSBub3QgY2FsbGVkIGRl
di0+aW9tbXUgPSAlcCwgZGV2LT5pb21tdV9ncm91cCA9ICVwLCBkZXYtPmlvbW11LT5md3Nw
ZWMgPSAlcCBkZXYtPmRyaXZlciA9ICVwXG4iLAorCQkJCV9fZnVuY19fLCBkZXYtPmlvbW11
LCBkZXYtPmlvbW11X2dyb3VwLCBkZXYtPmlvbW11LT5md3NwZWMsIGRldi0+ZHJpdmVyKTsK
IAl9CisKKwogCS8qCiAJICogQXQgdGhpcyBwb2ludCwgcmVsZXZhbnQgZGV2aWNlcyBlaXRo
ZXIgbm93IGhhdmUgYSBmd3NwZWMgd2hpY2ggd2lsbAogCSAqIG1hdGNoIG9wcyByZWdpc3Rl
cmVkIHdpdGggYSBub24tTlVMTCBmd25vZGUsIG9yIHdlIGNhbiByZWFzb25hYmx5CkBAIC02
MDgsNyArNjIyLDEwIEBAIHN0YXRpYyBpbnQgX19pb21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpncm91cF9saXN0CiAJc3RydWN0IGlv
bW11X2dyb3VwICpncm91cDsKIAlzdHJ1Y3QgZ3JvdXBfZGV2aWNlICpnZGV2OwogCWludCBy
ZXQ7CisJYm9vbCBpc19kZWNvbiA9IChkZXZfbmFtZShkZXYpICYmIHN0cnN0cihkZXZfbmFt
ZShkZXYpLCAiZHJtZGVjb24iKSk7CiAKKwlpZiAoaXNfZGVjb24pCisJCWRldl9lcnIoZGV2
LCAidHVkb3I6ICVzIGVudGVyXG4iLCBfX2Z1bmNfXyk7CiAJLyoKIAkgKiBTZXJpYWxpc2Ug
dG8gYXZvaWQgcmFjZXMgYmV0d2VlbiBJT01NVSBkcml2ZXJzIHJlZ2lzdGVyaW5nIGluCiAJ
ICogcGFyYWxsZWwgYW5kL29yIHRoZSAicmVwbGF5IiBjYWxscyBmcm9tIEFDUEkvT0YgY29k
ZSB2aWEgY2xpZW50CkBAIC0zMjQxLDYgKzMyNTgsNyBAQCBpbnQgaW9tbXVfZGV2aWNlX3Vz
ZV9kZWZhdWx0X2RvbWFpbihzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJLyogQ2FsbGVyIGlzIHRo
ZSBkcml2ZXIgY29yZSBkdXJpbmcgdGhlIHByZS1wcm9iZSBwYXRoICovCiAJc3RydWN0IGlv
bW11X2dyb3VwICpncm91cCA9IGRldi0+aW9tbXVfZ3JvdXA7CiAJaW50IHJldCA9IDA7CisJ
Ym9vbCBpc19kZWNvbiA9IChkZXZfbmFtZShkZXYpICYmIHN0cnN0cihkZXZfbmFtZShkZXYp
LCAiZHJtZGVjb24iKSk7CiAKIAlpZiAoIWdyb3VwKQogCQlyZXR1cm4gMDsKQEAgLTMyNDgs
NiArMzI2Niw5IEBAIGludCBpb21tdV9kZXZpY2VfdXNlX2RlZmF1bHRfZG9tYWluKHN0cnVj
dCBkZXZpY2UgKmRldikKIAltdXRleF9sb2NrKCZncm91cC0+bXV0ZXgpOwogCS8qIFdlIG1h
eSByYWNlIGFnYWluc3QgYnVzX2lvbW11X3Byb2JlKCkgZmluYWxpc2luZyBncm91cHMgaGVy
ZSAqLwogCWlmICghZ3JvdXAtPmRlZmF1bHRfZG9tYWluKSB7CisJCWlmIChpc19kZWNvbikK
KwkJCWRldl9lcnIoZGV2LCAidHVkb3I6ICVzLCB3ZSBoaXQgIWdyb3VwLT5kZWZhdWx0X2Rv
bWFpblxuIiwKKwkJCQlfX2Z1bmNfXyk7CiAJCXJldCA9IC1FUFJPQkVfREVGRVI7CiAJCWdv
dG8gdW5sb2NrX291dDsKIAl9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L29mX2lvbW11
LmMgYi9kcml2ZXJzL2lvbW11L29mX2lvbW11LmMKaW5kZXggNmI5ODlhNjJkZWYyLi5hZjg5
ZjFjODc0ZGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvb2ZfaW9tbXUuYworKysgYi9k
cml2ZXJzL2lvbW11L29mX2lvbW11LmMKQEAgLTExOCw2ICsxMTgsNyBAQCBpbnQgb2ZfaW9t
bXVfY29uZmlndXJlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9ub2RlICpt
YXN0ZXJfbnAsCiB7CiAJYm9vbCBkZXZfaW9tbXVfcHJlc2VudDsKIAlpbnQgZXJyOworCWJv
b2wgaXNfZGVjb24gPSAoZGV2X25hbWUoZGV2KSAmJiBzdHJzdHIoZGV2X25hbWUoZGV2KSwg
ImRybWRlY29uIikpOwogCiAJaWYgKCFtYXN0ZXJfbnApCiAJCXJldHVybiAtRU5PREVWOwpA
QCAtMTU1LDEzICsxNTYsMjUgQEAgaW50IG9mX2lvbW11X2NvbmZpZ3VyZShzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbWFzdGVyX25wLAogCQlkZXZfaW9tbXVf
ZnJlZShkZXYpOwogCW11dGV4X3VubG9jaygmaW9tbXVfcHJvYmVfZGV2aWNlX2xvY2spOwog
CisJaWYgKGlzX2RlY29uKQorCQlkZXZfZXJyKGRldiwgInR1ZG9yOiAlczogb2ZfaW9tbXVf
Y29uZmlndXJlX2RldmljZSBlcnIgPSAlZCwgZGV2X2lvbW11X3ByZXNlbnQgPSAlZFxuIiwK
KwkJCV9fZnVuY19fLCBlcnIsIGRldl9pb21tdV9wcmVzZW50KTsKIAkvKgogCSAqIElmIHdl
J3JlIG5vdCBvbiB0aGUgaW9tbXVfcHJvYmVfZGV2aWNlKCkgcGF0aCAoYXMgaW5kaWNhdGVk
IGJ5IHRoZQogCSAqIGluaXRpYWwgZGV2LT5pb21tdSkgdGhlbiB0cnkgdG8gc2ltdWxhdGUg
aXQuIFRoaXMgc2hvdWxkIG5vIGxvbmdlcgogCSAqIGhhcHBlbiB1bmxlc3Mgb2ZfZG1hX2Nv
bmZpZ3VyZSgpIGlzIGJlaW5nIG1pc3VzZWQgb3V0c2lkZSBidXMgY29kZS4KIAkgKi8KLQlp
ZiAoIWVyciAmJiBkZXYtPmJ1cyAmJiAhZGV2X2lvbW11X3ByZXNlbnQpCisJaWYgKCFlcnIg
JiYgZGV2LT5idXMgJiYgIWRldl9pb21tdV9wcmVzZW50KSB7CisJCWlmIChpc19kZWNvbikg
eworCQkJZGV2X2lvbW11X3ByZXNlbnQgPSBkZXYtPmlvbW11OworCQkJZGV2X2VycihkZXYs
ICJ0dWRvcjogJXMgY2FsbCBpb21tdV9wcm9iZV9kZXZpY2UgbmV3IGRldl9pb21tdV9wcmVz
ZW50ID0gJWQsIGRldi0+aW9tbXUgPSAlcFxuIiwKKwkJCQlfX2Z1bmNfXywgZGV2X2lvbW11
X3ByZXNlbnQsIGRldi0+aW9tbXUpOworCQl9CiAJCWVyciA9IGlvbW11X3Byb2JlX2Rldmlj
ZShkZXYpOworCQlpZiAoaXNfZGVjb24pCisJCQlkZXZfZXJyKGRldiwgInR1ZG9yOiAlcyBh
ZnRlciBpb21tdV9wcm9iZV9kZXZpY2UgZXJyID0gJWRcbiIsCisJCQkJX19mdW5jX18sIGVy
cik7CisJfQogCiAJaWYgKGVyciAmJiBlcnIgIT0gLUVQUk9CRV9ERUZFUikKIAkJZGV2X2Ri
ZyhkZXYsICJBZGRpbmcgdG8gSU9NTVUgZmFpbGVkOiAlZFxuIiwgZXJyKTsK

--------------Ph6fdNNznB04kJsUkIc4SQC3--

