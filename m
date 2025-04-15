Return-Path: <stable+bounces-132771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C010EA8A6C1
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 20:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0493519006A7
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CD221578;
	Tue, 15 Apr 2025 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJ2ZdYrt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81421D591
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741699; cv=none; b=gXXw3cgE2d+lalWsQqCyn3yCirYeraewifFgllyBqnxh/dqH4m4/U3+U9sBD944ZikIVSQBkXzEAZ9G0WJ5M8X503JawtK5agfJzT3MKup1LIdoyrBP/ipDbeG+IV7R1uLKPXFgthYfgZ8KDc23sTdk7sSi+Ih1Y6m7TWr7VXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741699; c=relaxed/simple;
	bh=ieq+p7Txnb6dIVhw0Cqufx5bpVyypdaVTQRQ7rGADrM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc; b=urQNcsdH6kUbVByAI0VMjdtXzOQOsMuZORJuxknAtCBADqwgYHaqSmwjbZzDtItZdlcZgNUibmpQtW/kfWnzhKWKJjhr7ayp5JFWoKQfOXCi6VfW0Arlp5t4weCiPj4FzA0kMBdnW0DUhkbs0Bq4zEzTTLcpQALF2qATAze3CnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nJ2ZdYrt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso61925415e9.0
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744741695; x=1745346495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L49TGW+7xz/Nh6pz+awW7HEg66lfzot3qylqJrkV2gw=;
        b=nJ2ZdYrt8jNV9GklTYlRYHIVzzwWW7UgCLOY6jiMchkbD6xzdZKEsUpnh/6NF2KHwc
         kwWf8znoMJ3RaKmpGYyLkw3LcoQnV+YdmokcWjkRr3UivKecuq2uD4nm6BLgTAFGhO5P
         GiOYBHtAEpwxZd5t2Ux9ZI+MWB+NtG/QKTz+FaSYrglVMYGJbsIkcpzqQ0JDI8COB+OC
         vs0433LsoI83mjQ05jmcE69+cgHjg0yCdy+Pt7wLkl9FVZdWlxqmJMyZscU6MWYIzeYj
         k48IaVW3sKzBX1hvNsIGXpztXmOxZb/EP69s5cCWP4Fp3bMQTMV9W/IDk9sv3vRmenKx
         oTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744741695; x=1745346495;
        h=cc:to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L49TGW+7xz/Nh6pz+awW7HEg66lfzot3qylqJrkV2gw=;
        b=CF1Wc30XQLZ8U/ktxbvS/7U+XtT29CfCLrD0iub988yntOXsE/Mjaw4b1wq2FXZkXV
         8vzmSBdX/pJ7S9Ad3WEEQpbmwZ7DXKlkuA+CDT65lU4KW0bqtwtRH1VXe7Du/Ny5Kg7J
         lQNLDIDpNtwGa3MKOEMHefMFtMqzmVophJ6BkjuH2JVk0B+ZH13Ebd8ex4EzCG7E9FX0
         InQrYeQypEkJRwGa+xF3+eleruHvhcBqTS320haBHJybOTuPMj+2b3X5b+IXgY2PVrsn
         MDPXsdVCJ/kKN0htBrSNZTkEDgFxcrP5ygFZPHSZvgLD/dcIt3wOkSV6jHU6zqAj4k1P
         OSGw==
X-Gm-Message-State: AOJu0Yx1teK6zL6myYp9k0kjVCLBQdAh0kV/JlkQGcSg3EBf9mSs5BU+
	qyJS5EWmtFosDCSSwSSwtP/fVp7fTznXfXypHJunebCMwIU9ZK1DrsUaJNMjDl4=
X-Gm-Gg: ASbGncufkwgAjjXjgUNqqq6AsswstnOqWHU9N7fXShjcrJTnusuNgKNy7vW1CigUYrk
	FZXNVLfW3vA4KmGZD4xiUmNq6dxjtNf16T9lDeIJFgNt6UrKjcHj+n1QMxXppVJ8g1FGKIXQ6iJ
	W/sVOnvc/PeBtOm8a5aApPhgxlUBxFrHtcZsjld2Ri0+QieyfLcz8vYpOs4hA5IVV8y20+I4q9a
	BDogBn+UAQJxtCKH5VENJV5yi2kGWvuFuxqs2ii1P1BRIgTC54K7yRIlqNx064AameZDFJ1+aJy
	EU4oWO8WarCK1YtKbZhqIw3KDVrtbKwedub6gyTT
X-Google-Smtp-Source: AGHT+IH6mc9ELyei13BV0wrRCDW96LMH74+mJafLGoFBT7/zz8c7C0skMK9mvtbozXXRqxJ2TdA7Lg==
X-Received: by 2002:a05:600c:1d95:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-44059fcb970mr2110625e9.10.1744741694981;
        Tue, 15 Apr 2025 11:28:14 -0700 (PDT)
Received: from localhost ([2.216.7.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445708sm15206699f8f.96.2025.04.15.11.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 11:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Apr 2025 19:28:13 +0100
Message-Id: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
Subject: [REGRESSION] amdgpu: async system error exception from
 hdp_v5_0_flush_hdp()
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: <alexander.deucher@amd.com>, <frank.min@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Cc: <stable@vger.kernel.org>, <david.belanger@amd.com>,
 <christian.koenig@amd.com>, <peter.chen@cixtech.com>,
 <cix-kernel-upstream@cixtech.com>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.0


#regzbot introduced: v6.12..v6.13

I use RX6600 on arm64 Orion o6 board and it seems that amdgpu is broken on =
recent kernels, fails on boot:

[drm] amdgpu: 7886M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
SError Interrupt on CPU11, code 0x00000000be000011 -- SError
CPU: 11 UID: 0 PID: 255 Comm: (udev-worker) Tainted: G S                  6=
.15.0-rc2+ #1 VOLUNTARY
Tainted: [S]=3DCPU_OUT_OF_SPEC
Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Ori=
on O6, BIOS 1.0 Jan  1 1980
pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
pc : amdgpu_device_rreg+0x60/0xe4 [amdgpu]
lr : hdp_v5_0_flush_hdp+0x6c/0x80 [amdgpu]
sp : ffffffc08321b490
x29: ffffffc08321b490 x28: ffffff80b8b80000 x27: ffffff80b8bd0178
x26: ffffff80b8b8fe88 x25: 0000000000000001 x24: ffffff8081647000
x23: ffffffc079d6e000 x22: ffffff80b8bd5000 x21: 000000000007f000
x20: 000000000001fc00 x19: 00000000ffffffff x18: 00000000000015fc
x17: 00000000000015fc x16: 00000000000015cf x15: 00000000000015ce
x14: 00000000000015d0 x13: 00000000000015d1 x12: 00000000000015d2
x11: 00000000000015d3 x10: 000000000000ec00 x9 : 00000000000015fd
x8 : 00000000000015fd x7 : 0000000000001689 x6 : 0000000000555401
x5 : 0000000000000001 x4 : 0000000000100000 x3 : 0000000000100000
x2 : 0000000000000000 x1 : 000000000007f000 x0 : 0000000000000000
Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 11 UID: 0 PID: 255 Comm: (udev-worker) Tainted: G S                  6=
.15.0-rc2+ #1 VOLUNTARY
Tainted: [S]=3DCPU_OUT_OF_SPEC
Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Ori=
on O6, BIOS 1.0 Jan  1 1980
Call trace:
 show_stack+0x2c/0x84 (C)
 dump_stack_lvl+0x60/0x80
 dump_stack+0x18/0x24
 panic+0x148/0x330
 add_taint+0x0/0xbc
 arm64_serror_panic+0x64/0x7c
 do_serror+0x28/0x68
 el1h_64_error_handler+0x30/0x48
 el1h_64_error+0x6c/0x70
 amdgpu_device_rreg+0x60/0xe4 [amdgpu] (P)
 hdp_v5_0_flush_hdp+0x6c/0x80 [amdgpu]
 gmc_v10_0_hw_init+0xec/0x1fc [amdgpu]
 amdgpu_device_init+0x19f8/0x2480 [amdgpu]
 amdgpu_driver_load_kms+0x20/0xb0 [amdgpu]
 amdgpu_pci_probe+0x1b8/0x5d4 [amdgpu]
 pci_device_probe+0xbc/0x1a8
 really_probe+0xc0/0x39c
 __driver_probe_device+0x7c/0x14c
 driver_probe_device+0x3c/0x120
 __driver_attach+0xc4/0x200
 bus_for_each_dev+0x68/0xb4
 driver_attach+0x24/0x30
 bus_add_driver+0x110/0x240
 driver_register+0x68/0x124
 __pci_register_driver+0x44/0x50
 amdgpu_init+0x84/0xf94 [amdgpu]
 do_one_initcall+0x60/0x1e0
 do_init_module+0x54/0x200
 load_module+0x18f8/0x1e68
 init_module_from_file+0x74/0xa0
 __arm64_sys_finit_module+0x1e0/0x3f0
 invoke_syscall+0x64/0xe4
 el0_svc_common.constprop.0+0x40/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x34/0xd0
 el0t_64_sync_handler+0x10c/0x138
 el0t_64_sync+0x198/0x19c
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x1000,000000e0,f169a650,9b7ff667
Memory Limit: none
---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

(bios version seems to be 45 years old but that is the state of the board
when I received it)

Also saw this crash with RX6700. Old radeons like HD5450 and nvidia gt1030
work fine on that board.

A little bit of testing showed that it was introduced between 6.12 and 6.13=
.
Also it seems that changes were taken by some distro kernels already and
different iso images I tried failed to boot before I bumped into some iso
with kernel 6.8 that worked just fine.

The only change related to hdp_v5_0_flush_hdp() was
cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP

Reverting that commit ^^ did help and resolved that problem. Before sending
revert as-is I was interested to know if there supposed to be a proper fix
for this or maybe someone is interested to debug this or have any suggestio=
ns.

In theory I also need to confirm that exactly that change introduced the
regression.

Thanks,
Alexey


