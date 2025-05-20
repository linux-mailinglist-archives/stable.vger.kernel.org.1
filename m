Return-Path: <stable+bounces-145005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F04ABCF0D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD861B65FFB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 06:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F425C717;
	Tue, 20 May 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRNQ/fYc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A941C6BE;
	Tue, 20 May 2025 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721700; cv=none; b=R9j7wfBV7xw1LaCq8SBPjBaqbD9TCNEvgVWTVyRwqbHJkoabToyRPO8wnCK7O7nSQ3ZBy4dvcGVyUpFVj2HGZc/HzuFP7BZala2WbPX1HaPpKG0wYidN4rL408O1pizTj/g0bKI01hgVhsTaCeGLetXmXT8R7XFOE6NIe4Nr+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721700; c=relaxed/simple;
	bh=aO5SXqTECBYALqAHY/HrzOgmXG6QtUf86s50KzNWxWw=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:
	 In-Reply-To:Content-Type; b=t5BkGQ9o3mRrsN1MRzm0HdHBknBdg+jJznNIDUeumt1y7kRoZPHJR3Q6IN84E7EluELC4w3zYmTR2pA03C6WrSazf8fVZ5cVH/0MNVl+5Ravxw1RHR4Ejs/xyFEF/XS3mTj9esbcbtwnTELrkDP786mpK0A1nFAevlU/zsR6txY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRNQ/fYc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441c0d8eb3bso5475235e9.1;
        Mon, 19 May 2025 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747721694; x=1748326494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cd5NgWlfHqJO2r3AKeYK4TYQW3MvPSmsjCdlqh7PBNA=;
        b=kRNQ/fYcPhWr12yQ4KBm8Gd4QKwj/VAd0AR8DgbesGgVtGaQDFqba+SOSfL757GtqB
         OufET42lLTqBHDdIwjffANuIr31eh9n3ow10eJEsUVudOD6OPiV1HWwXcOBtTxXGAzpv
         P1TBm5I+1fjSadgT+yhbaROur887p5pAYhVaCZrVdrYnV19xCQWd/HP8smJefuQ765kp
         CtfNLej6SPn5iMr4l2+uJUV9ONt5jWj0vukbimLLiUFtb6VbDjngrZV875e6YjNQQwbj
         Njq12IxpReIwE7rDDpOH27vwWjLaEYxZ66df4wV5y62yIYWT7s2Yyl58EuzlBBO/6CWO
         NObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747721694; x=1748326494;
        h=content-transfer-encoding:in-reply-to:autocrypt:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd5NgWlfHqJO2r3AKeYK4TYQW3MvPSmsjCdlqh7PBNA=;
        b=MY/xLTGpZY1TwYCRBeIPLJBAF8DjdZ87SksloqD8I8IS8XrB/F1UkwZOOBdpJ/VVw9
         Tsfc6diAouDkECq6+r43SfUiYB2s3xjMR8am9VOh5I86BUeOObE7GU+ElQqKECvRad+m
         AghtwFljIfNra4lsXIs97teQ/ZXjq+t0B5I6JYA6QjmSDxXoN8uQ7fr5fLAv/JKrOhm1
         3GJVDxXaV0ZrLzsAP1evQVte38c+q6wi7w0639EAJ8S5bMafr00jVpYjAeofYda3vPL3
         bQYdCav3UZazBs0O6WTvDD7WAedUhd68JGZ0ofr0I2E/quiRtlUOCVaP0/iKHQezJvit
         z2yA==
X-Forwarded-Encrypted: i=1; AJvYcCWzCxljNq+7oOU4qyA/578vx4pKj95e3D3WA4fALV3dwvGOA8aP2G9FphIoUxpoHtRr9h0WMU5gv1tM8G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAaHvPxKrgwv3n/VTqZUHs5qbcm9jH8S09E5q/dc0oRLrIKJT
	jjKKE1n8eFUfFUN9Sd0OX8rdSgUgIj3gxyRU5V/udc7BfX4JMQlx3cKGLg3xEq20JD4=
X-Gm-Gg: ASbGncvcCuUj3ZvkZyV53VcbDhIvb1EvysMNGUqbgrBg4SCjXgtbYY0TxgHHMwf3lL1
	OitPAhMeOauJBE80Uc/4PzgR+X4DL+8JcXuMvgZbgCPHDe3q03/GOmOpyO1kOg/8J9b0Cj7r1KH
	XO03aWYm1MNM1anxHncren9xhKZFdO+PSdWWSL1C9HaoHzw4AgbNhqISENF9xSR6Qw5AeTo84kw
	wbOb4LpMvZ2QkuEwuSPFJzVilty6NEbFTCXw069bSo1sxmLHww0sTrP8oUetwCadgg8MOe0c8XX
	XkCidoj1ovYkVr13YC7TYqBKCPwl7L1kTUv2CgvE6DnzT67NPTxn26WxY0WJIg==
X-Google-Smtp-Source: AGHT+IEjSDBz6V0DAyjloCesOarfAmUWDJSmuhcuI6gkkBuDWfBaNv07Oi8goEbc4ZTY2Oy5tQhwfw==
X-Received: by 2002:a05:600c:3584:b0:439:90f5:3919 with SMTP id 5b1f17b1804b1-442feebf43fmr50989005e9.4.1747721693424;
        Mon, 19 May 2025 23:14:53 -0700 (PDT)
Received: from [192.168.1.2] ([91.86.120.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebdc362fsm180716595e9.1.2025.05.19.23.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 23:14:52 -0700 (PDT)
Message-ID: <1bac715e-8779-4120-ac94-066f2f80fe81@gmail.com>
Date: Tue, 20 May 2025 08:14:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
Subject: Re: Linux 6.14.7
References: <2025051800-extended-bullfrog-ae21@gregkh>
Content-Language: fr-FR
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <2025051800-extended-bullfrog-ae21@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Good morning,

I now get plenty of such errors when I want to install an rpm package 
compiled with make binrpm-pkg under opensuse tumbleweed:

ksym(6.14.7:shash_free_singlespawn_instance) = 97902343 est nécessaire 
pour kernel-6.14.7-1.x86_64
         ksym(6.14.7:shash_no_setkey) = 6392a6d9 est nécessaire pour 
kernel-6.14.7-1.x86_64
         ksym(6.14.7:shash_register_instance) = 5867280f est nécessaire 
pour kernel-6.14.7-1.x86_64

This also occurs with 6.12.29, but did not occur with 6.12.28. Of course 
it work if I install with rpm -ivh --nodeps ...

Best regards,

François Valenduc


Le 18/05/25 à 08:41, Greg Kroah-Hartman a écrit :
> I'm announcing the release of the 6.14.7 kernel.
> 
> All users of the 6.14 kernel series must upgrade.
> 
> The updated 6.14.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.14.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------
> 
>   .clippy.toml                                                    |    2
>   Documentation/ABI/testing/sysfs-devices-system-cpu              |    1
>   Documentation/admin-guide/hw-vuln/index.rst                     |    1
>   Documentation/admin-guide/hw-vuln/indirect-target-selection.rst |  168 ++++++++
>   Documentation/admin-guide/kernel-parameters.txt                 |   18
>   Makefile                                                        |    2
>   arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi                |   25 -
>   arch/arm64/include/asm/cputype.h                                |    2
>   arch/arm64/include/asm/insn.h                                   |    1
>   arch/arm64/include/asm/spectre.h                                |    3
>   arch/arm64/kernel/cpufeature.c                                  |    9
>   arch/arm64/kernel/proton-pack.c                                 |   13
>   arch/arm64/kvm/mmu.c                                            |   13
>   arch/arm64/lib/insn.c                                           |   60 +-
>   arch/arm64/net/bpf_jit_comp.c                                   |   57 ++
>   arch/mips/include/asm/ptrace.h                                  |    3
>   arch/riscv/kernel/process.c                                     |    6
>   arch/riscv/kernel/traps.c                                       |   64 +--
>   arch/riscv/kernel/traps_misaligned.c                            |   17
>   arch/s390/kernel/entry.S                                        |    3
>   arch/s390/pci/pci_clp.c                                         |    2
>   arch/x86/Kconfig                                                |   12
>   arch/x86/entry/entry_64.S                                       |   20
>   arch/x86/include/asm/alternative.h                              |   32 +
>   arch/x86/include/asm/cpufeatures.h                              |    3
>   arch/x86/include/asm/microcode.h                                |    2
>   arch/x86/include/asm/msr-index.h                                |    8
>   arch/x86/include/asm/nospec-branch.h                            |   10
>   arch/x86/kernel/alternative.c                                   |  208 +++++++++-
>   arch/x86/kernel/cpu/bugs.c                                      |  176 ++++++++
>   arch/x86/kernel/cpu/common.c                                    |   72 ++-
>   arch/x86/kernel/cpu/microcode/amd.c                             |    6
>   arch/x86/kernel/cpu/microcode/core.c                            |   58 +-
>   arch/x86/kernel/cpu/microcode/intel.c                           |    2
>   arch/x86/kernel/cpu/microcode/internal.h                        |    1
>   arch/x86/kernel/ftrace.c                                        |    2
>   arch/x86/kernel/head32.c                                        |    4
>   arch/x86/kernel/module.c                                        |    6
>   arch/x86/kernel/static_call.c                                   |    4
>   arch/x86/kernel/vmlinux.lds.S                                   |   10
>   arch/x86/kvm/mmu/mmu.c                                          |   69 ++-
>   arch/x86/kvm/smm.c                                              |    1
>   arch/x86/kvm/svm/svm.c                                          |    4
>   arch/x86/kvm/x86.c                                              |    4
>   arch/x86/lib/retpoline.S                                        |   39 +
>   arch/x86/mm/tlb.c                                               |   23 +
>   arch/x86/net/bpf_jit_comp.c                                     |   58 ++
>   drivers/accel/ivpu/ivpu_hw.c                                    |    2
>   drivers/accel/ivpu/ivpu_job.c                                   |   90 +++-
>   drivers/base/cpu.c                                              |    3
>   drivers/block/loop.c                                            |   43 +-
>   drivers/bluetooth/btmtk.c                                       |   10
>   drivers/clocksource/i8253.c                                     |    4
>   drivers/firmware/arm_scmi/driver.c                              |   13
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                             |    2
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                        |   18
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |   29 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                         |   10
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h                         |    1
>   drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c                           |    7
>   drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c                           |    7
>   drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c                           |   12
>   drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c                           |    7
>   drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c                           |    7
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                           |    1
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                           |    1
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                           |    1
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                           |    4
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                         |    1
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                         |    1
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                         |    3
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c               |   36 -
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c     |   28 +
>   drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c   |   14
>   drivers/gpu/drm/panel/panel-simple.c                            |   25 -
>   drivers/gpu/drm/v3d/v3d_sched.c                                 |   28 +
>   drivers/gpu/drm/xe/tests/xe_mocs.c                              |    7
>   drivers/gpu/drm/xe/xe_gt_debugfs.c                              |    9
>   drivers/gpu/drm/xe/xe_gt_pagefault.c                            |   11
>   drivers/hv/hyperv_vmbus.h                                       |    6
>   drivers/hv/vmbus_drv.c                                          |  100 ++++
>   drivers/iio/accel/adis16201.c                                   |    4
>   drivers/iio/accel/adxl355_core.c                                |    2
>   drivers/iio/accel/adxl367.c                                     |   10
>   drivers/iio/adc/ad7266.c                                        |    2
>   drivers/iio/adc/ad7606_spi.c                                    |    2
>   drivers/iio/adc/ad7768-1.c                                      |    2
>   drivers/iio/adc/dln2-adc.c                                      |    2
>   drivers/iio/adc/rockchip_saradc.c                               |   17
>   drivers/iio/chemical/pms7003.c                                  |    5
>   drivers/iio/chemical/sps30.c                                    |    2
>   drivers/iio/common/hid-sensors/hid-sensor-attributes.c          |    4
>   drivers/iio/imu/bmi270/bmi270_core.c                            |    6
>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c                      |    2
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                  |    6
>   drivers/iio/light/hid-sensor-prox.c                             |   22 -
>   drivers/iio/light/opt3001.c                                     |    5
>   drivers/iio/pressure/mprls0025pa.h                              |   17
>   drivers/iio/temperature/maxim_thermocouple.c                    |    2
>   drivers/input/joystick/xpad.c                                   |   40 +
>   drivers/input/keyboard/mtk-pmic-keys.c                          |    4
>   drivers/input/mouse/synaptics.c                                 |    5
>   drivers/input/touchscreen/cyttsp5.c                             |    7
>   drivers/md/dm-table.c                                           |    3
>   drivers/net/can/m_can/m_can.c                                   |    3
>   drivers/net/can/rockchip/rockchip_canfd-core.c                  |    2
>   drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c                  |   42 +-
>   drivers/net/dsa/b53/b53_common.c                                |  207 +++++++--
>   drivers/net/dsa/b53/b53_priv.h                                  |    3
>   drivers/net/dsa/bcm_sf2.c                                       |    1
>   drivers/net/ethernet/intel/ice/ice_adapter.c                    |   47 --
>   drivers/net/ethernet/intel/ice/ice_adapter.h                    |    6
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c                     |   19
>   drivers/net/ethernet/meta/fbnic/fbnic_csr.h                     |    2
>   drivers/net/ethernet/meta/fbnic/fbnic_fw.c                      |  197 +++++----
>   drivers/net/ethernet/meta/fbnic/fbnic_mac.c                     |    6
>   drivers/net/virtio_net.c                                        |   23 -
>   drivers/nvme/host/core.c                                        |    3
>   drivers/pci/hotplug/s390_pci_hpc.c                              |    1
>   drivers/staging/axis-fifo/axis-fifo.c                           |   14
>   drivers/staging/iio/adc/ad7816.c                                |    2
>   drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c   |    1
>   drivers/uio/uio_hv_generic.c                                    |   39 -
>   drivers/usb/cdns3/cdnsp-gadget.c                                |   31 +
>   drivers/usb/cdns3/cdnsp-gadget.h                                |    6
>   drivers/usb/cdns3/cdnsp-pci.c                                   |   12
>   drivers/usb/cdns3/cdnsp-ring.c                                  |    3
>   drivers/usb/cdns3/core.h                                        |    3
>   drivers/usb/class/usbtmc.c                                      |   59 +-
>   drivers/usb/dwc3/core.h                                         |    4
>   drivers/usb/dwc3/gadget.c                                       |   60 +-
>   drivers/usb/gadget/composite.c                                  |   12
>   drivers/usb/gadget/function/f_ecm.c                             |    7
>   drivers/usb/gadget/udc/tegra-xudc.c                             |    4
>   drivers/usb/host/uhci-platform.c                                |    2
>   drivers/usb/host/xhci-dbgcap.c                                  |   19
>   drivers/usb/host/xhci-dbgcap.h                                  |    3
>   drivers/usb/host/xhci-tegra.c                                   |    3
>   drivers/usb/misc/onboard_usb_dev.c                              |   10
>   drivers/usb/typec/tcpm/tcpm.c                                   |    2
>   drivers/usb/typec/ucsi/displayport.c                            |   21 -
>   drivers/usb/typec/ucsi/ucsi.c                                   |   34 +
>   drivers/usb/typec/ucsi/ucsi.h                                   |    2
>   drivers/vfio/pci/vfio_pci_core.c                                |   12
>   drivers/xen/swiotlb-xen.c                                       |    1
>   drivers/xen/xenbus/xenbus.h                                     |    2
>   drivers/xen/xenbus/xenbus_comms.c                               |    9
>   drivers/xen/xenbus/xenbus_dev_frontend.c                        |    2
>   drivers/xen/xenbus/xenbus_xs.c                                  |   18
>   fs/btrfs/volumes.c                                              |   91 ----
>   fs/erofs/fileio.c                                               |    4
>   fs/erofs/zdata.c                                                |   31 -
>   fs/namespace.c                                                  |    3
>   fs/ocfs2/alloc.c                                                |    1
>   fs/ocfs2/journal.c                                              |   80 ++-
>   fs/ocfs2/journal.h                                              |    1
>   fs/ocfs2/ocfs2.h                                                |   17
>   fs/ocfs2/quota_local.c                                          |    9
>   fs/ocfs2/suballoc.c                                             |   38 +
>   fs/ocfs2/suballoc.h                                             |    1
>   fs/ocfs2/super.c                                                |    3
>   fs/smb/client/cached_dir.c                                      |   10
>   fs/smb/server/oplock.c                                          |    7
>   fs/smb/server/smb2pdu.c                                         |    5
>   fs/smb/server/vfs.c                                             |    7
>   fs/smb/server/vfs_cache.c                                       |   33 +
>   fs/userfaultfd.c                                                |   28 +
>   include/linux/cpu.h                                             |    2
>   include/linux/execmem.h                                         |    3
>   include/linux/hyperv.h                                          |    6
>   include/linux/ieee80211.h                                       |    2
>   include/linux/module.h                                          |    5
>   include/linux/timekeeper_internal.h                             |    8
>   include/linux/vmalloc.h                                         |    1
>   include/net/netdev_queues.h                                     |    6
>   init/Kconfig                                                    |    3
>   io_uring/io_uring.c                                             |   58 +-
>   io_uring/sqpoll.c                                               |    2
>   kernel/params.c                                                 |    4
>   kernel/time/timekeeping.c                                       |   50 ++
>   kernel/time/vsyscall.c                                          |    4
>   mm/huge_memory.c                                                |   11
>   mm/internal.h                                                   |   27 -
>   mm/memblock.c                                                   |    9
>   mm/page_alloc.c                                                 |  161 ++++---
>   mm/vmalloc.c                                                    |   31 +
>   net/can/gw.c                                                    |  149 ++++---
>   net/core/filter.c                                               |    1
>   net/core/netdev-genl.c                                          |   69 ++-
>   net/ipv6/addrconf.c                                             |   15
>   net/mac80211/mlme.c                                             |   12
>   net/netfilter/ipset/ip_set_hash_gen.h                           |    2
>   net/netfilter/ipvs/ip_vs_xmit.c                                 |   27 -
>   net/openvswitch/actions.c                                       |    3
>   net/sched/sch_htb.c                                             |   15
>   net/wireless/scan.c                                             |    2
>   rust/bindings/lib.rs                                            |    1
>   rust/kernel/alloc/kvec.rs                                       |    3
>   rust/kernel/list.rs                                             |    3
>   rust/kernel/str.rs                                              |   46 +-
>   rust/macros/module.rs                                           |   19
>   rust/macros/paste.rs                                            |    2
>   rust/macros/pinned_drop.rs                                      |    3
>   rust/uapi/lib.rs                                                |    1
>   tools/objtool/check.c                                           |    1
>   tools/testing/selftests/Makefile                                |    1
>   tools/testing/selftests/mm/compaction_test.c                    |   19
>   tools/testing/selftests/mm/pkey-powerpc.h                       |   14
>   tools/testing/selftests/mm/pkey_util.c                          |    1
>   tools/testing/selftests/x86/bugs/Makefile                       |    3
>   tools/testing/selftests/x86/bugs/common.py                      |  164 +++++++
>   tools/testing/selftests/x86/bugs/its_indirect_alignment.py      |  150 +++++++
>   tools/testing/selftests/x86/bugs/its_permutations.py            |  109 +++++
>   tools/testing/selftests/x86/bugs/its_ret_alignment.py           |  139 ++++++
>   tools/testing/selftests/x86/bugs/its_sysfs.py                   |   65 +++
>   215 files changed, 3564 insertions(+), 1212 deletions(-)
> 
> Aditya Garg (3):
>        Input: synaptics - enable InterTouch on Dynabook Portege X30L-G
>        Input: synaptics - enable InterTouch on Dell Precision M3800
>        Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5
> 
> Al Viro (1):
>        do_umount(): add missing barrier before refcount checks in sync case
> 
> Alex Deucher (7):
>        Revert "drm/amd: Stop evicting resources on APUs in suspend"
>        drm/amdgpu: fix pm notifier handling
>        drm/amdgpu/hdp4: use memcfg register to post the write for HDP flush
>        drm/amdgpu/hdp5.2: use memcfg register to post the write for HDP flush
>        drm/amdgpu/hdp5: use memcfg register to post the write for HDP flush
>        drm/amdgpu/hdp6: use memcfg register to post the write for HDP flush
>        drm/amdgpu/hdp7: use memcfg register to post the write for HDP flush
> 
> Alex Williamson (1):
>        vfio/pci: Align huge faults to order
> 
> Alexander Duyck (7):
>        fbnic: Fix initialization of mailbox descriptor rings
>        fbnic: Gate AXI read/write enabling on FW mailbox
>        fbnic: Actually flush_tx instead of stalling out
>        fbnic: Cleanup handling of completions
>        fbnic: Improve responsiveness of fbnic_mbx_poll_tx_ready
>        fbnic: Pull fbnic_fw_xmit_cap_msg use out of interrupt context
>        fbnic: Do not allow mailbox to toggle to ready outside fbnic_mbx_poll_tx_ready
> 
> Alexey Charkov (1):
>        usb: uhci-platform: Make the clock really optional
> 
> Andrei Kuchynski (2):
>        usb: typec: ucsi: displayport: Fix deadlock
>        usb: typec: ucsi: displayport: Fix NULL pointer access
> 
> Angelo Dureghello (1):
>        iio: adc: ad7606: fix serial register access
> 
> Antonios Salios (1):
>        can: m_can: m_can_class_allocate_dev(): initialize spin lock on device probe
> 
> Aurabindo Pillai (1):
>        drm/amd/display: more liberal vmin/vmax update for freesync
> 
> Borislav Petkov (AMD) (1):
>        x86/microcode: Consolidate the loader enablement checking
> 
> Christoph Hellwig (1):
>        loop: factor out a loop_assign_backing_file helper
> 
> Clément Léger (2):
>        riscv: misaligned: factorize trap handling
>        riscv: misaligned: enable IRQs while handling misaligned accesses
> 
> Cong Wang (1):
>        sch_htb: make htb_deactivate() idempotent
> 
> Cristian Marussi (1):
>        firmware: arm_scmi: Fix timeout checks on polling path
> 
> Dan Carpenter (1):
>        dm: add missing unlock on in dm_keyslot_evict()
> 
> Daniel Golle (1):
>        net: ethernet: mtk_eth_soc: reset all TX queues on DMA free
> 
> Daniel Sneddon (2):
>        x86/bpf: Call branch history clearing sequence on exit
>        x86/bpf: Add IBHF call at end of classic BPF
> 
> Daniel Wagner (1):
>        nvme: unblock ctrl state transition for firmware update
> 
> Dave Hansen (1):
>        x86/mm: Eliminate window where TLB flushes may be inadvertently skipped
> 
> Dave Penkler (3):
>        usb: usbtmc: Fix erroneous get_stb ioctl error returns
>        usb: usbtmc: Fix erroneous wait_srq ioctl return
>        usb: usbtmc: Fix erroneous generic_read ioctl return
> 
> Dave Stevenson (1):
>        staging: bcm2835-camera: Initialise dev in v4l2_dev
> 
> David Lechner (4):
>        iio: chemical: sps30: use aligned_s64 for timestamp
>        iio: chemical: pms7003: use aligned_s64 for timestamp
>        iio: imu: inv_mpu6050: align buffer for timestamp
>        iio: pressure: mprls0025pa: use aligned_s64 for timestamp
> 
> Dmitry Antipov (1):
>        module: ensure that kobject_put() is safe for module type kobjects
> 
> Dmitry Torokhov (1):
>        Input: synaptics - enable SMBus for HP Elitebook 850 G1
> 
> Eelco Chaudron (1):
>        openvswitch: Fix unsafe attribute parsing in output_userspace()
> 
> Eric Biggers (1):
>        x86/its: Fix build errors when CONFIG_MODULES=n
> 
> Feng Tang (1):
>        selftests/mm: compaction_test: support platform with huge mount of memory
> 
> Frank Wunderlich (1):
>        net: ethernet: mtk_eth_soc: do not reset PSE when setting FE
> 
> Gabriel Krisman Bertazi (1):
>        io_uring/sqpoll: Increase task_work submission batch size
> 
> Gabriel Shahrouzi (4):
>        staging: iio: adc: ad7816: Correct conditional logic for store mode
>        staging: axis-fifo: Remove hardware resets for user errors
>        staging: axis-fifo: Correct handling of tx_fifo_depth for size validation
>        iio: adis16201: Correct inclinometer channel resolution
> 
> Gao Xiang (1):
>        erofs: ensure the extra temporary copy is valid for shortened bvecs
> 
> Gary Bisson (1):
>        Input: mtk-pmic-keys - fix possible null pointer dereference
> 
> Gavin Guo (1):
>        mm/huge_memory: fix dereferencing invalid pmd migration entry
> 
> Greg Kroah-Hartman (1):
>        Linux 6.14.7
> 
> Guillaume Nault (1):
>        gre: Fix again IPv6 link-local address generation.
> 
> Gustavo Silva (1):
>        iio: imu: bmi270: fix initial sampling frequency configuration
> 
> Hao Qin (1):
>        Bluetooth: btmtk: Remove the resetting step before downloading the fw
> 
> Heiko Carstens (1):
>        s390/entry: Fix last breaking event handling in case of stack corruption
> 
> Heming Zhao (1):
>        ocfs2: fix the issue with discontiguous allocation in the global_bitmap
> 
> Hugo Villeneuve (1):
>        Input: cyttsp5 - ensure minimum reset pulse width
> 
> Jacek Lawrynowicz (1):
>        accel/ivpu: Increase state dump msg timeout
> 
> Jakub Kicinski (4):
>        virtio-net: don't re-enable refill work too early when NAPI is disabled
>        virtio-net: free xsk_buffs on error in virtnet_xsk_pool_enable()
>        net: export a helper for adding up queue stats
>        virtio-net: fix total qstat values
> 
> James Morse (6):
>        arm64: insn: Add support for encoding DSB
>        arm64: proton-pack: Expose whether the platform is mitigated by firmware
>        arm64: proton-pack: Expose whether the branchy loop k value
>        arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
>        arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
>        arm64: proton-pack: Add new CPUs 'k' values for branch mitigation
> 
> Jan Kara (3):
>        ocfs2: switch osb->disable_recovery to enum
>        ocfs2: implement handshaking with ocfs2 recovery thread
>        ocfs2: stop quota recovery before disabling quotas
> 
> Jason Andryuk (1):
>        xenbus: Use kref to track req lifetime
> 
> Jens Axboe (2):
>        io_uring: ensure deferred completions are flushed for multishot
>        io_uring: always arm linked timeouts prior to issue
> 
> Jim Lin (1):
>        usb: host: tegra: Prevent host controller crash when OTG port is used
> 
> Johannes Weiner (2):
>        mm: page_alloc: don't steal single pages from biggest buddy
>        mm: page_alloc: speed up fallbacks in rmqueue_bulk()
> 
> John Ernberg (1):
>        xen: swiotlb: Use swiotlb bouncing if kmalloc allocation demands it
> 
> Jonas Gorski (11):
>        net: dsa: b53: allow leaky reserved multicast
>        net: dsa: b53: keep CPU port always tagged again
>        net: dsa: b53: fix clearing PVID of a port
>        net: dsa: b53: fix flushing old pvid VLAN on pvid change
>        net: dsa: b53: fix VLAN ID for untagged vlan on bridge leave
>        net: dsa: b53: always rejoin default untagged VLAN on bridge leave
>        net: dsa: b53: do not allow to configure VLAN 0
>        net: dsa: b53: do not program vlans when vlan filtering is off
>        net: dsa: b53: fix toggling vlan_filtering
>        net: dsa: b53: fix learning on VLAN unaware bridges
>        net: dsa: b53: do not set learning and unicast/multicast on up
> 
> Jonathan Cameron (5):
>        iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
>        iio: adc: ad7266: Fix potential timestamp alignment issue.
>        iio: temp: maxim-thermocouple: Fix potential lack of DMA safe buffer.
>        iio: accel: adxl355: Make timestamp 64-bit aligned using aligned_s64
>        iio: adc: dln2: Use aligned_s64 for timestamp
> 
> Jozsef Kadlecsik (1):
>        netfilter: ipset: fix region locking in hash types
> 
> Julian Anastasov (1):
>        ipvs: fix uninit-value for saddr in do_output_route4
> 
> Karol Wachowski (2):
>        accel/ivpu: Separate DB ID and CMDQ ID allocations from CMDQ allocation
>        accel/ivpu: Correct mutex unlock order in job submission
> 
> Kees Cook (1):
>        mm: vmalloc: support more granular vrealloc() sizing
> 
> Kelsey Maes (1):
>        can: mcp251xfd: fix TDC setting for low data bit rates
> 
> Kevin Baker (1):
>        drm/panel: simple: Update timings for AUO G101EVN010
> 
> Lizhi Xu (1):
>        loop: Add sanity check for read/write_iter
> 
> Lode Willems (1):
>        Input: xpad - add support for 8BitDo Ultimate 2 Wireless Controller
> 
> Lothar Rubusch (1):
>        iio: accel: adxl367: fix setting odr for activity time update
> 
> Luca Ceresoli (1):
>        iio: light: opt3001: fix deadlock due to concurrent flag access
> 
> Lukasz Czechowski (1):
>        usb: misc: onboard_usb_dev: fix support for Cypress HX3 hubs
> 
> Madhavan Srinivasan (1):
>        selftests/mm: fix build break when compiling pkey_util.c
> 
> Manuel Fombuena (1):
>        Input: synaptics - enable InterTouch on Dynabook Portege X30-D
> 
> Marc Kleine-Budde (3):
>        can: mcan: m_can_class_unregister(): fix order of unregistration calls
>        can: mcp251xfd: mcp251xfd_remove(): fix order of unregistration calls
>        can: rockchip_canfd: rkcanfd_remove(): fix order of unregistration calls
> 
> Mark Tinguely (1):
>        ocfs2: fix panic in failed foilio allocation
> 
> Mathias Nyman (1):
>        xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
> 
> Matthew Brost (1):
>        drm/xe: Add page queue multiplier
> 
> Max Kellermann (1):
>        fs/erofs/fileio: call erofs_onlinefolio_split() after bio_add_folio()
> 
> Maíra Canal (1):
>        drm/v3d: Add job to pending list if the reset was skipped
> 
> Michael-CY Lee (1):
>        wifi: mac80211: fix the type of status_code for negotiated TID to Link Mapping
> 
> Miguel Ojeda (5):
>        rust: clean Rust 1.88.0's `unnecessary_transmutes` lint
>        objtool/rust: add one more `noreturn` Rust function for Rust 1.87.0
>        rust: clean Rust 1.88.0's warning about `clippy::disallowed_macros` configuration
>        rust: allow Rust 1.87.0's `clippy::ptr_eq` lint
>        rust: clean Rust 1.88.0's `clippy::uninlined_format_args` lint
> 
> Mikael Gonella-Bolduc (1):
>        Input: cyttsp5 - fix power control issue on wakeup
> 
> Mikhail Lobanov (1):
>        KVM: SVM: Forcibly leave SMM mode on SHUTDOWN interception
> 
> Nam Cao (1):
>        riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
> 
> Naman Jain (1):
>        uio_hv_generic: Fix sysfs creation path for ring buffer
> 
> Namjae Jeon (1):
>        ksmbd: prevent rename with empty string
> 
> Niklas Schnelle (2):
>        s390/pci: Fix missing check for zpci_create_device() error return
>        s390/pci: Fix duplicate pci_dev_put() in disable_slot() when PF has child VFs
> 
> Norbert Szetei (1):
>        ksmbd: prevent out-of-bounds stream writes by validating *pos
> 
> Nylon Chen (1):
>        riscv: misaligned: Add handling for ZCB instructions
> 
> Nysal Jan K.A. (1):
>        selftests/mm: fix a build failure on powerpc
> 
> Oliver Hartkopp (1):
>        can: gw: fix RCU/BH usage in cgw_create_job()
> 
> Oliver Neukum (1):
>        USB: usbtmc: use interruptible sleep in usbtmc_read
> 
> Paul Aurich (1):
>        smb: client: Avoid race in open_cached_dir with lease breaks
> 
> Paul Chaignon (1):
>        bpf: Scrub packet on bpf_redirect_peer
> 
> Pawan Gupta (11):
>        x86/bhi: Do not set BHI_DIS_S in 32-bit mode
>        Documentation: x86/bugs/its: Add ITS documentation
>        x86/its: Enumerate Indirect Target Selection (ITS) bug
>        x86/its: Add support for ITS-safe indirect thunk
>        x86/its: Add support for ITS-safe return thunk
>        x86/its: Enable Indirect Target Selection mitigation
>        x86/its: Add "vmexit" option to skip mitigation on some CPUs
>        x86/its: Add support for RSB stuffing mitigation
>        x86/its: Align RETs in BHB clear sequence to avoid thunking
>        x86/ibt: Keep IBT disabled during alternative patching
>        selftest/x86/bugs: Add selftests for ITS
> 
> Pawel Laszczak (2):
>        usb: cdnsp: Fix issue with resuming from L1
>        usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM version
> 
> Peter Xu (1):
>        mm/userfaultfd: fix uninitialized output field for -EAGAIN race
> 
> Peter Zijlstra (2):
>        x86/its: Use dynamic thunks for indirect branches
>        x86/its: FineIBT-paranoid vs ITS
> 
> Petr Vaněk (1):
>        mm: fix folio_pte_batch() on XEN PV
> 
> Prashanth K (3):
>        usb: dwc3: gadget: Make gadget_wakeup asynchronous
>        usb: gadget: f_ecm: Add get_status callback
>        usb: gadget: Use get_status callback to set remote wakeup capability
> 
> Przemek Kitszel (1):
>        ice: use DSN instead of PCI BDF for ice_adapter index
> 
> Qu Wenruo (1):
>        Revert "btrfs: canonicalize the device path before adding it"
> 
> RD Babiera (1):
>        usb: typec: tcpm: delay SNK_TRY_WAIT_DEBOUNCE to SRC_TRYWAIT transition
> 
> Roman Li (1):
>        drm/amd/display: Fix invalid context error in dml helper
> 
> Ruijing Dong (1):
>        drm/amdgpu/vcn: using separate VCN1_AON_SOC offset
> 
> Samuel Holland (1):
>        riscv: Disallow PR_GET_TAGGED_ADDR_CTRL without Supm
> 
> Sean Christopherson (1):
>        KVM: x86/mmu: Prevent installing hugepages when mem attributes are changing
> 
> Sean Heelan (1):
>        ksmbd: Fix UAF in __close_file_table_ids
> 
> Sebastian Andrzej Siewior (1):
>        clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
> 
> Sebastian Ott (1):
>        KVM: arm64: Fix uninitialized memcache pointer in user_mem_abort()
> 
> Shuicheng Lin (1):
>        drm/xe: Release force wake first then runtime power
> 
> Silvano Seva (2):
>        iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
>        iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_tagged_fifo
> 
> Simon Xue (1):
>        iio: adc: rockchip: Fix clock initialization sequence
> 
> Tejas Upadhyay (1):
>        drm/xe/tests/mocs: Hold XE_FORCEWAKE_ALL for LNCF regs
> 
> Thomas Gleixner (1):
>        timekeeping: Prevent coarse clocks going backwards
> 
> Thorsten Blum (1):
>        MIPS: Fix MAX_REG_OFFSET
> 
> Tom Lendacky (1):
>        memblock: Accept allocated memory before use in memblock_double_array()
> 
> Veerendranath Jakkam (1):
>        wifi: cfg80211: fix out-of-bounds access during multi-link element defragmentation
> 
> Vicki Pfau (2):
>        Input: xpad - fix Share button on Xbox One controllers
>        Input: xpad - fix two controller table values
> 
> Wang Zhaolong (1):
>        ksmbd: fix memory leak in parse_lease_state()
> 
> Wayne Chang (1):
>        usb: gadget: tegra-xudc: ACK ST_RC after clearing CTRL_RUN
> 
> Wayne Lin (5):
>        drm/amd/display: Shift DMUB AUX reply command if necessary
>        drm/amd/display: Fix the checking condition in dmub aux handling
>        drm/amd/display: Remove incorrect checking in dmub aux handler
>        drm/amd/display: Fix wrong handling for AUX_DEFER case
>        drm/amd/display: Copy AUX read reply data whenever length > 0
> 
> Wojciech Dubowik (1):
>        arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to usdhc2
> 
> Yeoreum Yun (1):
>        arm64: cpufeature: Move arm64_use_ng_mappings to the .data section to prevent wrong idmap generation
> 
> Zhang Lixu (3):
>        iio: hid-sensor-prox: Restore lost scale assignments
>        iio: hid-sensor-prox: support multi-channel SCALE calculation
>        iio: hid-sensor-prox: Fix incorrect OFFSET calculation
> 


