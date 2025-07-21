Return-Path: <stable+bounces-163541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665BB0C0CE
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 12:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FB33B8599
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12928D840;
	Mon, 21 Jul 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b="RoSenc0B"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2609487A5;
	Mon, 21 Jul 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091998; cv=none; b=LukdUJ8dgUXLZFePkiGdQgP9PzurZnVBkkRM8GANp5nZyy33xJ2/jP+Tvfk+2mlOpRM0bJeWTNg4jHiNcRAWak9kuG/BkMjme7K3Ypz3zsTrotgQql65hqbiH39jRB32bkEEybY9v+ZvpV4/PLLi2Z2UjRG26ucRyhmUirU0q0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091998; c=relaxed/simple;
	bh=AWdp7nL5gbbsvaAu8dLPLs4FkTffzI9ICtmdEZNa+4g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NscATdAndwNZv/kWn9nVsPMKid0EnYN2ZFf0bV/hzF3FfvMjYYhW8vILPYbji7x9TZPxvpFje6WrNO+kwnzMzdfqR5ZQDpTMgQcQMkGvNHTDqbZvrEHAkBYsuaKw6JV8RrKYJkrMfOubyZoLcjJ2riF9O8cKcUum/jIKb4lXtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun; spf=none smtp.mailfrom=bbaa.fun; dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b=RoSenc0B; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bbaa.fun
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bbaa.fun;
	s=goar2402; t=1753091967;
	bh=AWdp7nL5gbbsvaAu8dLPLs4FkTffzI9ICtmdEZNa+4g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=RoSenc0By8N5tHQPaJDYHzBYmWG3flVJqK7/hO7KvrOH49qGvjdYtp1vCsbs2IQXD
	 mMEwX/8otW89MwcxbpFNOjMmlRuE4iH+lLtyjVE9D97gttI11MZs/39iJ6GVfEtzqg
	 euqYQGCYQYIUkYHcTrrdj8+e0BZbMTQwANaw+dKA=
X-QQ-mid: zesmtpgz3t1753091965t9f6241e2
X-QQ-Originating-IP: ME2/Jf+vQlz/5WTcXfw9GWKe0WH74XrBrUihVBZW/HQ=
Received: from [198.18.0.1] ( [171.38.232.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 17:59:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9778762447196126760
Message-ID: <721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun>
Date: Mon, 21 Jul 2025 17:59:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: baolu.lu@linux.intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, bbaa@bbaa.moe
From: Ban ZuoXiang <bbaa@bbaa.fun>
Subject: =?UTF-8?Q?=5BREGRESSION=5D=5BBISECTED=5D_PCI_Passthrough_/_SR-IOV_F?=
 =?UTF-8?Q?ailure_on_Stable_Kernel_=E2=89=A5_v6=2E12=2E35?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bbaa.fun:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nw9C1WBu09hPBXrJP7TauklUbKBrDueW4+84TSrFw/IlOifseBX1DgWa
	FjzHi4GkwqydxrdfXzyrnfNMkasF94NpHmdLtH3+f/rcAcbWsJBW8vsVQ1xuIKPaqmbnNlv
	inMliQ0kTJHiA559Lg2S0IJhtpM6uCgrIEqVTro+lcB2Bxc/wl/0m9VecndJqFeFWnv5La0
	UO19h+xLZl7YbUVSsweU3d9ReRKnPcxjcEGluQe8YbNLqr3TqyHTqcvocHv8OCK7b1h6Jyg
	SxJZXOID1KRhWbem9lmcpGZLB+67hpe/BIK7p6f2o8GAu0PjuIdyO4kqHxOYNt+06EcfG8u
	vOIHVFEeQvKorEoU8hfxKfnphczInVf7Csp35CJYcQkUAgOn+EzbKNnN3ctOtZ4Q5bx7peD
	auEZX1HMwjOxD+QPQyuvXJjQvAd67AwqXDngvgejMkgqKuVJpugGEbxuH2sAH1cuMuQ33qE
	e1EK09ULdD2QTdegpFrLuVwIicFxhU9mWaKr3q1xTFSi6xWcvnRPfZoGPi0kBKSYeGqTsXT
	phXvyXLIRcs+JHHm9TvSLpfKuKOSgbpZDH98bqxpduJjXj5F+Cmh5JAwKbDGEJenGe36iN5
	/m7Po2dQ3Mdw4DiFLSFS1fwXa6uUt9+EoDhCpa3j+FbadNo0Qn/dBvXEgTMSZzwacT+pppu
	hkaYeqM7/VhCRNItMw7gtbWJYR8+o7EsZEdqfCIA953Y3yLhayZRLE5WVq82tdM+aje92gw
	Zxy5o+jAySp8LDLWJXVNrZhWdtFZXBA1xXfM8J+7i5xxdXy8MNWF5JjHop9JY5kVeNtlrld
	bYjgGCvA+AjHhpSJfcniNElDplJyaX+EP9yf7oGKjX+L2a0P8W8O/kh/HNOHCxL0uMIbNQp
	sX3Aw98VifFvV4tqxgW38bs350RR6F+kdn8UU7QXggP78KMuLFQuInido7smW+hfzTbho0u
	KdV6WeREHLS7/3Y9eng013cc2xMTmgL1rnKS5DtMawz+Yeg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi all,

We've identified a regression affecting PCI passthrough / SR-IOV virtualization starting from Linux v6.12.35.

A user reported that [1], beginning with this version, SR-IOV virtual functions fail to initialize properly inside the guest. The issue appears to some MMIO operations not completing correctly in the guest.

> [    2.152320] i915 0000:07:00.0: [drm] *ERROR* GT0: GUC: mmio request 0x4509: failure 306/0  
> [    2.152327] i915 0000:07:00.0: [drm] *ERROR* GuC initialization failed (-ENXIO)  
> [    2.152330] i915 0000:07:00.0: [drm] *ERROR* GT0: Failed to initialize GPU, declaring it wedged!  

Here is the |git bisect| log:

> # bad: [fbad404f04d758c52bae79ca20d0e7fe5fef91d3] Linux 6.12.37
> # good: [e03ced99c437f4a7992b8fa3d97d598f55453fd0] Linux 6.12.33
> git bisect start 'HEAD' 'v6.12.33'
> # bad: [b01a29a80cca28f0c7d0864e2d62fb9616051bfc] ACPI: bus: Bail out if acpi_kobj registration fails
> git bisect bad b01a29a80cca28f0c7d0864e2d62fb9616051bfc
> # bad: [b01a29a80cca28f0c7d0864e2d62fb9616051bfc] ACPI: bus: Bail out if acpi_kobj registration fails
> git bisect bad b01a29a80cca28f0c7d0864e2d62fb9616051bfc
> # good: [35f116a4658f787bea7e82fdd23e2e9789254f5e] drm/xe: Make xe_gt_freq part of the Documentation
> git bisect good 35f116a4658f787bea7e82fdd23e2e9789254f5e
> # good: [261f2a655b709e59a8d759ce9fa478778d9e84f4] crypto: qat - add shutdown handler to qat_c3xxx
> git bisect good 261f2a655b709e59a8d759ce9fa478778d9e84f4
> # good: [4d0686b53cc9342be3f8ce06336fd5ab0d206355] ata: ahci: Disallow LPM for Asus B550-F motherboard
> git bisect good 4d0686b53cc9342be3f8ce06336fd5ab0d206355
> # bad: [ce4ef0274cb66a4750000f33f2d316c0dbaf4515] KVM: s390: rename PROT_NONE to PROT_TYPE_DUMMY
> git bisect bad ce4ef0274cb66a4750000f33f2d316c0dbaf4515
> # bad: [8d0645b59b19d97a3b7c5a3fb8dae0c89e98cde9] parisc/unaligned: Fix hex output to show 8 hex chars
> git bisect bad 8d0645b59b19d97a3b7c5a3fb8dae0c89e98cde9
> # good: [fed611bd8c7b76b070aa407d0c7558e20d9e1f68] f2fs: fix to do sanity check on ino and xnid
> git bisect good fed611bd8c7b76b070aa407d0c7558e20d9e1f68
> # good: [8a008c89e5e5c5332e4c0a33d707db9ddd529f8a] net/sched: fix use-after-free in taprio_dev_notifier
> git bisect good 8a008c89e5e5c5332e4c0a33d707db9ddd529f8a
> # bad: [3f2098f4fba7718eb2501207ca6e99d22427f25a] fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var
> git bisect bad 3f2098f4fba7718eb2501207ca6e99d22427f25a
> # bad: [fb5873b779dd5858123c19bbd6959566771e2e83] iommu/vt-d: Restore context entry setup order for aliased devices
> git bisect bad fb5873b779dd5858123c19bbd6959566771e2e83
> # good: [81c64c2f84ab581d1c45dbbbca941c13128faee6] net: ftgmac100: select FIXED_PHY
> git bisect good 81c64c2f84ab581d1c45dbbbca941c13128faee6
> # first bad commit: [fb5873b779dd5858123c19bbd6959566771e2e83] iommu/vt-d: Restore context entry setup order for aliased devices
>
> commit fb5873b779dd5858123c19bbd6959566771e2e83
> Author: Lu Baolu <baolu.lu@linux.intel.com>
> Date:   Tue May 20 15:58:49 2025 +0800
>
>     iommu/vt-d: Restore context entry setup order for aliased devices
>     
>     commit 320302baed05c6456164652541f23d2a96522c06 upstream.
This commit was introduced in [2], and the issue only affects stable kernels prior to v6.15. Besides, the Ubuntu v6.14-series kernel used by Proxmox also appears to be affected [3].


Best regards,

Ban ZuoXiang

[1]: https://github.com/strongtz/i915-sriov-dkms/issues/320

[2]: https://lore.kernel.org/r/20250514060523.2862195-1-baolu.lu@linux.intel.com

[3]: https://github.com/strongtz/i915-sriov-dkms/issues/312 

 



