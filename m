Return-Path: <stable+bounces-92810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBE49C5D0A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CF81F24827
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE1F205138;
	Tue, 12 Nov 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRSS2qq7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063BA1B81B8;
	Tue, 12 Nov 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428505; cv=none; b=JXbWcLOkDu+P2wn89FEOzkUpF9qPNgwvzUjC9fxV7DYsqxwRs4Nc/HgsIBSZK3m5Go6o2iRSrswH4bTWnus/lhODeTtjKNqEBX9kOyoUHWiWDDkTX5FzxtZqh4cyGkWa+Mv1ug7UqzmMP/g/g7IF8BcW+M9yRnkiCKMfQizY1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428505; c=relaxed/simple;
	bh=ajqV03LKV5EIlYjezWekxnYg3jJypFIl/kPLDmx54Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLR7/m2zhvMXpdRAbHz1PvATBRGX3VOS318xzattgyHSnSFJzXoaPJaNQP33F4s8LmE3uZuB+ac0fqdkS5sXRF+hwn1MPrK0DGPu9zbAHxRi7Om4y4wLp2RhNwkAi6aMj6t6Nm7c6eCoRFenu7M1WXLkQop1kcma9iT/Wxr5M7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRSS2qq7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so4766112a91.2;
        Tue, 12 Nov 2024 08:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731428502; x=1732033302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyuOOLYmnNIRoXa3x3t+xsFiaf9w68hQKgBjjiBJHTQ=;
        b=aRSS2qq7UD/Q5t/CRRzZy8dvSPk03mInH+3kP3mOAjEcV8nWMIs5prPy9WhwSIQWII
         9TaXseNxKfp/RtnAsB/veRblxgcT4dOIVAUWrW8sYKE6CoXvaEliTfTTFoTaf1e3IveR
         tjktYWOVYgJyEwlmhph2AGmHoPWDihDZua/3an7Qmx4wwN8ug8f6+marsqzDB4Lgdzl8
         0yeOkw4hFJ4DWV4NoeRnRIQcCsY5eOiVZqfRukr06vy0hs706h6Iokre6MXdWHBd+c/L
         LvsNqqUe7+GM4+fShC4/QtLr0jVUNSoape9L7LAfs4g+IE8N1HvFtBSsURmDoTNUG+EZ
         cgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428502; x=1732033302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyuOOLYmnNIRoXa3x3t+xsFiaf9w68hQKgBjjiBJHTQ=;
        b=UXdE/kf3YLcqUUc/AS0GHpwIGBjZqxnTp0GdOBp4ZLI5/HLWMGhnyz1xXNCd+HdkIi
         mSWYKAkw4pcCqh/aXSydWWVpMZf1L/TX9SvjC2srHErrWRGvALvzhg+SWfG9QV9uw6p4
         tG1S6AxCiZr+2Y6ZSMtDmmb4imQMx4ppehwe2dDW/ghfLobqBRBoHMSeUeujKFAXVupM
         nvqxE6I99mJBTC4VjhyP7iBCw0iZWJc12Y070yKpaJ/VJDWzNA5zdDXlVWcBIFD2Cg0+
         DdcyMhvH9BggPolx8NkKrGq9F93DaC4kZR4ARYDH3NoRMEjoiboZLSEu0gzkCZBp78mL
         r0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe9xPSXMqEythNC0lXCq3a9K6JTnHiaQlKCe3VZX7oWE0eTbxEuBKhrdi8xhIfHVSDZdjOvzrf6hDVmr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvNhHKHD5Jt2ZsGhePaSuqA5JemOeEdtM+a0uqsFv/cWNFvwk
	ne4/5esMPtMAaRGuNtii1ajkEMXoALGn8GFKO7/XA66HeTBY/VrNWjnE5gjhJigREXiF3CcEZzx
	+Ug4+qnHI2X9QXYjrUjES2J6A1Fc=
X-Google-Smtp-Source: AGHT+IEcwKuGDyvAdsCInNT81+VJosaBRuXPPbCYmp5GjzfPbrZ01d6A+lDECHKkERgD4zC9RA9TX7ftrq5/y2XC0Qc=
X-Received: by 2002:a17:90b:1f8f:b0:2e2:b02a:1229 with SMTP id
 98e67ed59e1d1-2e9b178fe37mr19526861a91.35.1731428501923; Tue, 12 Nov 2024
 08:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101900.865487674@linuxfoundation.org>
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 12 Nov 2024 17:21:28 +0100
Message-ID: <CADo9pHjkzC2HuJrX53-oJ9oKc6_+DfUvwd8TzuGrJVxV-PbpVQ@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den tis 12 nov. 2024 kl 12:07 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.11.8 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.11.8-rc1
>
> Hyunwoo Kim <v4bel@theori.io>
>     vsock/virtio: Initialization of the dangling pointer occurring in vsk=
->trans
>
> Hyunwoo Kim <v4bel@theori.io>
>     hv_sock: Initializing vsk->trans to NULL to prevent a dangling pointe=
r
>
> Paul E. McKenney <paulmck@kernel.org>
>     xtensa: Emulate one-byte cmpxchg
>
> Mingcong Bai <jeffbai@aosc.io>
>     ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022
>
> Nirmoy Das <nirmoy.das@intel.com>
>     drm/xe/guc/tlb: Flush g2h worker in case of tlb timeout
>
> Nirmoy Das <nirmoy.das@intel.com>
>     drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
>
> Nirmoy Das <nirmoy.das@intel.com>
>     drm/xe: Move LNL scheduling WA to xe_device.h
>
> Badal Nilawar <badal.nilawar@intel.com>
>     drm/xe/guc/ct: Flush g2h worker in case of g2h response timeout
>
> Christoph Hellwig <hch@lst.de>
>     block: fix queue limits checks in blk_rq_map_user_bvec for real
>
> Christoph Hellwig <hch@lst.de>
>     block: rework bio splitting
>
> Johan Hovold <johan+linaro@kernel.org>
>     firmware: qcom: scm: suppress download mode error
>
> Mukesh Ojha <quic_mojha@quicinc.com>
>     firmware: qcom: scm: Refactor code to support multiple dload mode
>
> Muhammad Usama Anjum <usama.anjum@collabora.com>
>     selftests: hugetlb_dio: check for initial conditions to skip in the s=
tart
>
> Andrei Vagin <avagin@google.com>
>     ucounts: fix counter leak in inc_rlimit_get_ucounts()
>
> Andrew Kanner <andrew.kanner@gmail.com>
>     ocfs2: remove entry once instead of null-ptr-dereference in ocfs2_xa_=
remove()
>
> Marc Zyngier <maz@kernel.org>
>     irqchip/gic-v3: Force propagation of the active state with a read-bac=
k
>
> Umang Jain <umang.jain@ideasonboard.com>
>     staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state allocation
>
> Umang Jain <umang.jain@ideasonboard.com>
>     staging: vchiq_arm: Use devm_kzalloc() for drv_mgmt allocation
>
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     thunderbolt: Fix connection issue with Pluggable UD-4VPD dock
>
> Qiang Yu <quic_qianyu@quicinc.com>
>     clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
>
> Johan Hovold <johan+linaro@kernel.org>
>     clk: qcom: videocc-sm8350: use HW_CTRL_TRIGGER for vcodec GDSCs
>
> Beno=C3=AEt Monin <benoit.monin@gmx.fr>
>     USB: serial: option: add Quectel RG650V
>
> Reinhard Speyerer <rspmn@arcor.de>
>     USB: serial: option: add Fibocom FG132 0x0112 composition
>
> Jack Wu <wojackbb@gmail.com>
>     USB: serial: qcserial: add support for Sierra Wireless EM86xx
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     USB: serial: io_edgeport: fix use after free in debug printk
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     usb: typec: fix potential out of bounds in ucsi_ccg_update_set_new_ca=
m_cmd()
>
> Rex Nie <rex.nie@jaguarmicro.com>
>     usb: typec: qcom-pmic: init value of hdr_len/txbuf_len earlier
>
> Roger Quadros <rogerq@kernel.org>
>     usb: dwc3: fix fault at system suspend if device was already runtime =
suspended
>
> Zijun Hu <quic_zijuhu@quicinc.com>
>     usb: musb: sunxi: Fix accessing an released usb phy
>
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     thunderbolt: Add only on-board retimers when !CONFIG_USB4_DEBUGFS_MAR=
GINING
>
> Hugh Dickins <hughd@google.com>
>     mm/thp: fix deferred split unqueue naming and locking
>
> Wei Yang <richard.weiyang@gmail.com>
>     mm/mlock: set the correct prev on failure
>
> SeongJae Park <sj@kernel.org>
>     mm/damon/core: handle zero schemes apply interval
>
> SeongJae Park <sj@kernel.org>
>     mm/damon/core: handle zero {aggregation,ops_update} intervals
>
> SeongJae Park <sj@kernel.org>
>     mm/damon/core: avoid overflow in damon_feed_loop_next_input()
>
> Roman Gushchin <roman.gushchin@linux.dev>
>     signal: restore the override_rlimit logic
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     objpool: fix to make percpu slot allocation more robust
>
> Qi Xi <xiqi2@huawei.com>
>     fs/proc: fix compile warning about variable 'vmcore_mmap_ops'
>
> Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org>
>     clk: qcom: clk-alpha-pll: Fix pll post div mask when width is not set
>
> Abel Vesa <abel.vesa@linaro.org>
>     clk: qcom: gcc-x1e80100: Fix USB MP SS1 PHY GDSC pwrsts flags
>
> Liu Peibao <loven.liu@jaguarmicro.com>
>     i2c: designware: do not hold SCL low when I2C_DYNAMIC_TAR_UPDATE is n=
ot set
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     filemap: Fix bounds checking in filemap_read()
>
> Benoit Sevens <bsevens@google.com>
>     media: uvcvideo: Skip parsing frames of type UVC_VS_UNDEFINED in uvc_=
parse_format
>
> Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>     platform/x86/amd/pmf: Add SMU metrics table support for 1Ah family 60=
h model
>
> Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>     platform/x86/amd/pmf: Update SMU metrics table for 1AH family series
>
> Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>     platform/x86/amd/pmf: Relocate CPU ID macros to the PMF header
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: reinitialize delayed ref list after deleting it from the list
>
> Qu Wenruo <wqu@suse.com>
>     btrfs: fix per-subvolume RO/RW flags with new mount API
>
> Haisu Wang <haisuwang@tencent.com>
>     btrfs: fix the length of reserved qgroup to free
>
> Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>     idpf: fix idpf_vc_core_init error path
>
> Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>     idpf: avoid vport access in idpf_get_link_ksettings
>
> Gautam Menghani <gautam@linux.ibm.com>
>     KVM: PPC: Book3S HV: Mask off LPCR_MER for a vCPU before running it t=
o avoid spurious interrupts
>
> Koichiro Den <koichiro.den@gmail.com>
>     mm/slab: fix warning caused by duplicate kmem_cache creation in kmem_=
buckets_create
>
> Mark Rutland <mark.rutland@arm.com>
>     arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
>
> Mark Rutland <mark.rutland@arm.com>
>     arm64: Kconfig: Make SME depend on BROKEN for now
>
> Mark Brown <broonie@kernel.org>
>     arm64/sve: Discard stale CPU state when handling SVE traps
>
> Geliang Tang <geliang@kernel.org>
>     mptcp: use sock_kfree_s instead of kfree
>
> Stefan Wahren <wahrenst@gmx.net>
>     net: vertexcom: mse102x: Fix possible double free of TX skb
>
> Jinjie Ruan <ruanjinjie@huawei.com>
>     net: wwan: t7xx: Fix off-by-one error in t7xx_dpmaif_rx_buf_alloc()
>
> Kalesh Singh <kaleshsingh@google.com>
>     tracing: Fix tracefs mount options
>
> Roberto Sassu <roberto.sassu@huawei.com>
>     nfs: Fix KMSAN warning in decode_getfattr_attrs()
>
> Bart Van Assche <bvanassche@acm.org>
>     scsi: ufs: core: Start the RTC update work later
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: usb-audio: Add quirk for HP 320 FHD Webcam
>
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     mptcp: no admin perm to list endpoints
>
> Mikulas Patocka <mpatocka@redhat.com>
>     dm: fix a crash if blk_alloc_disk fails
>
> Zichen Xie <zichenxie0106@gmail.com>
>     dm-unstriped: cast an operand to sector_t to prevent potential uint32=
_t overflow
>
> Ming-Hung Tsai <mtsai@redhat.com>
>     dm cache: fix potential out-of-bounds access on the first resume
>
> Ming-Hung Tsai <mtsai@redhat.com>
>     dm cache: optimize dirty bit checking with find_next_bit when resizin=
g
>
> Ming-Hung Tsai <mtsai@redhat.com>
>     dm cache: fix out-of-bounds access to the dirty bitset when resizing
>
> Ming-Hung Tsai <mtsai@redhat.com>
>     dm cache: fix flushing uninitialized delayed_work on cache_ctr error
>
> Ming-Hung Tsai <mtsai@redhat.com>
>     dm cache: correct the number of origin blocks to match the target len=
gth
>
> David Gstir <david@sigma-star.at>
>     KEYS: trusted: dcp: fix NULL dereference in AEAD crypto operation
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     thermal/drivers/qcom/lmh: Remove false lockdep backtrace
>
> Antonio Quartulli <antonio@mandelbit.com>
>     drm/amdgpu: prevent NULL pointer dereference if ATIF is not supported
>
> Lijo Lazar <lijo.lazar@amd.com>
>     drm/amdgpu: Fix DPX valid mode check on GC 9.4.3
>
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu: Adjust debugfs register access permissions
>
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()
>
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu: Adjust debugfs eviction and IB access permissions
>
> Jann Horn <jannh@google.com>
>     drm/panthor: Be stricter about IO mapping flags
>
> Liviu Dudau <liviu.dudau@arm.com>
>     drm/panthor: Lock XArray when getting entries for the VM
>
> Aurabindo Pillai <aurabindo.pillai@amd.com>
>     drm/amd/display: parse umc_info or vram_info based on ASIC
>
> Kenneth Feng <kenneth.feng@amd.com>
>     drm/amd/pm: correct the workload setting
>
> Brendan King <brendan.king@imgtec.com>
>     drm/imagination: Break an object reference loop
>
> Brendan King <brendan.king@imgtec.com>
>     drm/imagination: Add a per-file PVR context list
>
> Tom Chung <chiahsuan.chung@amd.com>
>     drm/amd/display: Fix brightness level not retained over reboot
>
> Kenneth Feng <kenneth.feng@amd.com>
>     drm/amd/pm: always pick the pptable from IFWI
>
> Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>     rpmsg: glink: Handle rejected intent request better
>
> Jarkko Sakkinen <jarkko@kernel.org>
>     tpm: Lock TPM chip in tpm_pm_suspend() first
>
> Erik Schumacher <erik.schumacher@iris-sensing.com>
>     pwm: imx-tpm: Use correct MODULO value for EPWM mode
>
> Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
>     drm/xe: Set mask bits for CCS_MODE register
>
> Matthew Brost <matthew.brost@intel.com>
>     drm/xe: Drop VM dma-resv lock on xe_sync_in_fence_get failure in exec=
 IOCTL
>
> Matthew Brost <matthew.brost@intel.com>
>     drm/xe: Fix possible exec queue leak in exec IOCTL
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp
>
> Jinjie Ruan <ruanjinjie@huawei.com>
>     ksmbd: Fix the missing xa_store error check
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: check outstanding simultaneous SMB operations
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix slab-use-after-free in ksmbd_smb2_session_create
>
> Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
>     can: {cc770,sja1000}_isa: allow building on x86_64
>
> Marc Kleine-Budde <mkl@pengutronix.de>
>     can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing configuration =
when switching CAN modes
>
> Marc Kleine-Budde <mkl@pengutronix.de>
>     can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
>
> Marc Kleine-Budde <mkl@pengutronix.de>
>     can: m_can: m_can_close(): don't call free_irq() for IRQ-less devices
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: v4l2-ctrls-api: fix error handling for v4l2_g_ctrl()
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: v4l2-tpg: prevent the risk of a division by zero
>
> Hans Verkuil <hverkuil@xs4all.nl>
>     media: vivid: fix buffer overwrite when using > 32 buffers
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: pulse8-cec: fix data timestamp at pulse8_setup()
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: av7110: fix a spectre vulnerability
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: cx24116: prevent overflows on SNR calculus
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: s5p-jpeg: prevent buffer overflows
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: ar0521: don't overflow when checking PLL values
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: mgb4: protect driver against spectre
>
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: dvb-core: add missing buffer index check
>
> Jyri Sarha <jyri.sarha@linux.intel.com>
>     ASoC: SOF: sof-client-probes-ipc4: Set param_size extension bits
>
> Amelie Delaunay <amelie.delaunay@foss.st.com>
>     ASoC: stm32: spdifrx: fix dma channel release in stm32_spdifrx_remove
>
> Icenowy Zheng <uwu@icenowy.me>
>     thermal/of: support thermal zones w/o trips subnode
>
> Emil Dahl Juhl <emdj@bang-olufsen.dk>
>     tools/lib/thermal: Fix sampling handler context ptr
>
> Murad Masimov <m.masimov@maxima.ru>
>     ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()
>
> Johannes Thumshirn <johannes.thumshirn@wdc.com>
>     scsi: sd_zbc: Use kvzalloc() to allocate REPORT ZONES buffer
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: adv7604: prevent underflow condition when reporting colorspace
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: dvb_frontend: don't play tricks with underflow values
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: dvbdev: prevent the risk of out of memory access
>
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     media: stb0899_algo: initialize cfr before using it
>
> Jaros=C5=82aw Janik <jaroslaw.janik@gmail.com>
>     Revert "ALSA: hda/conexant: Mute speakers at suspend / shutdown"
>
> Wentao Liang <Wentao_liang_g@163.com>
>     drivers: net: ionic: add missed debugfs cleanup to ionic_probe() erro=
r path
>
> Eric Dumazet <edumazet@google.com>
>     net/smc: do not leave a dangling sk pointer in __smc_create()
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix missing locking causing hanging calls
>
> Johan Jonker <jbx6244@gmail.com>
>     net: arc: rockchip: fix emac mdio node support
>
> Johan Jonker <jbx6244@gmail.com>
>     net: arc: fix the device for dma_map_single/dma_unmap_single
>
> Philo Lu <lulie@linux.alibaba.com>
>     virtio_net: Update rss when set queue
>
> Philo Lu <lulie@linux.alibaba.com>
>     virtio_net: Sync rss config to device when virtnet_probe
>
> Philo Lu <lulie@linux.alibaba.com>
>     virtio_net: Add hash_key_length check
>
> Philo Lu <lulie@linux.alibaba.com>
>     virtio_net: Support dynamic rss indirection table size
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: wait for rcu grace period on net_device removal
>
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>     net: stmmac: Fix unbalanced IRQ wake disable warning on single irq ca=
se
>
> Diogo Silva <diogompaissilva@gmail.com>
>     net: phy: ti: add PHY_RST_AFTER_CLK_EN flag
>
> Peiyang Wang <wangpeiyang1@huawei.com>
>     net: hns3: fix kernel crash when uninstalling driver
>
> Vitaly Lifshits <vitaly.lifshits@intel.com>
>     e1000e: Remove Meteor Lake SMBUS workarounds
>
> Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>     i40e: fix race condition by adding filter's intermediate sync state
>
> Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>     ice: change q_index variable type to s16 to store -1 value
>
> Dario Binacchi <dario.binacchi@amarulasolutions.com>
>     can: c_can: fix {rx,tx}_errors statistics
>
> Suraj Gupta <suraj.gupta2@amd.com>
>     net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine star=
ts
>
> Wei Fang <wei.fang@nxp.com>
>     net: enetc: allocate vf_state during PF probes
>
> Xin Long <lucien.xin@gmail.com>
>     sctp: properly validate chunk size in sctp_sf_ootb()
>
> Suraj Gupta <suraj.gupta2@amd.com>
>     dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode property value
>
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dpaa_eth: print FD status in CPU endianness in dpaa_eth_fd trace=
point
>
> Wei Fang <wei.fang@nxp.com>
>     net: enetc: set MAC address to the VF net_device
>
> ChiYuan Huang <cy_huang@richtek.com>
>     regulator: rtq2208: Fix uninitialized use of regulator_config
>
> Chen Ridong <chenridong@huawei.com>
>     security/keys: fix slab-out-of-bounds in key_task_permission
>
> Mike Snitzer <snitzer@kernel.org>
>     nfs: avoid i_lock contention in nfs_clear_invalid_mapping
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     NFS: Further fixes to attribute delegation a/mtime changes
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     NFS: Fix attribute delegation behaviour on exclusive create
>
> NeilBrown <neilb@suse.de>
>     NFSv3: only use NFS timeout for MOUNT when protocols are compatible
>
> NeilBrown <neilb@suse.de>
>     sunrpc: handle -ENOTCONN in xs_tcp_setup_socket()
>
> Corey Hickey <bugfood-c@fatooh.org>
>     platform/x86/amd/pmc: Detect when STB is not available
>
> Jiri Kosina <jikos@kernel.org>
>     HID: core: zero-initialize the report buffer
>
> Diederik de Haas <didi.debian@cknow.org>
>     arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes
>
> Heiko Stuebner <heiko@sntech.de>
>     ARM: dts: rockchip: Fix the realtek audio codec on rk3036-kylin
>
> Heiko Stuebner <heiko@sntech.de>
>     ARM: dts: rockchip: Fix the spi controller on rk3036
>
> Heiko Stuebner <heiko@sntech.de>
>     ARM: dts: rockchip: drop grf reference from rk3036 hdmi
>
> Heiko Stuebner <heiko@sntech.de>
>     ARM: dts: rockchip: fix rk3036 acodec node
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: remove orphaned pinctrl-names from pinephone pr=
o
>
> Qingqing Zhou <quic_qqzhou@quicinc.com>
>     firmware: qcom: scm: Return -EOPNOTSUPP for unsupported SHM bridge en=
abling
>
> Xinqi Zhang <quic_xinqzhan@quicinc.com>
>     firmware: arm_scmi: Fix slab-use-after-free in scmi_bus_notifier()
>
> Marek Vasut <marex@denx.de>
>     arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1 frequency to 506.8=
 MHz
>
> Peng Fan <peng.fan@nxp.com>
>     arm64: dts: imx8mp: correct sdhc ipg clk
>
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     arm64: dts: qcom: sm8450 fix PIPE clock specification for pcie1
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: remove num-slots property from rk3328-nanopi-r2=
s-plus
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: Fix LED triggers on rk3308-roc-cc
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma lio=
n
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: Remove undocumented supports-emmc property
>
> Sergey Bostandzhyan <jin@mediatomb.cc>
>     arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: Fix bluetooth properties on rk3566 box demo
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: Drop regulator-init-microvolt from two boards
>
> Heiko Stuebner <heiko@sntech.de>
>     arm64: dts: rockchip: fix i2c2 pinctrl-names property on anbernic-rg3=
53p/v
>
> Diederik de Haas <didi.debian@cknow.org>
>     arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
>
> Diederik de Haas <didi.debian@cknow.org>
>     arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
>
> Diederik de Haas <didi.debian@cknow.org>
>     arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
>
> Rajendra Nayak <quic_rjendra@quicinc.com>
>     EDAC/qcom: Make irq configuration optional
>
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     firmware: qcom: scm: fix a NULL-pointer dereference
>
> Sam Edwards <cfsworks@gmail.com>
>     arm64: dts: rockchip: Designate Turing RK1's system power controller
>
> Dragan Simic <dsimic@manjaro.org>
>     arm64: dts: rockchip: Start cooling maps numbering from zero on ROCK =
5B
>
> Dragan Simic <dsimic@manjaro.org>
>     arm64: dts: rockchip: Move L3 cache outside CPUs in RK3588(S) SoC dts=
i
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-sapphire-=
excavator
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-eaidk-610
>
>
> -------------
>
> Diffstat:
>
>  .../devicetree/bindings/net/xlnx,axi-ethernet.yaml |   2 +-
>  Documentation/netlink/specs/mptcp_pm.yaml          |   1 -
>  Makefile                                           |   4 +-
>  arch/arm/boot/dts/rockchip/rk3036-kylin.dts        |   4 +-
>  arch/arm/boot/dts/rockchip/rk3036.dtsi             |  14 +-
>  arch/arm64/Kconfig                                 |   1 +
>  arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi     |   4 +-
>  .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  12 ++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   6 +-
>  arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi  |   8 ++
>  arch/arm64/boot/dts/qcom/sm8450.dtsi               |   2 +-
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi    |   1 -
>  arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |   4 +-
>  .../boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts   |  30 +++++
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   3 +-
>  arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi      |   1 -
>  arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts  |   2 +-
>  .../boot/dts/rockchip/rk3399-pinephone-pro.dts     |   2 -
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |   2 +-
>  .../dts/rockchip/rk3399-sapphire-excavator.dts     |   2 +-
>  .../boot/dts/rockchip/rk3566-anbernic-rg353p.dts   |   2 +-
>  .../boot/dts/rockchip/rk3566-anbernic-rg353v.dts   |   2 +-
>  arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts   |   6 +-
>  arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts |   1 -
>  arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  |   6 +-
>  arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi |   2 +-
>  arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts |   1 -
>  arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts     |   3 -
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  20 +--
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |   4 +-
>  .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |   1 -
>  .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   1 +
>  arch/arm64/kernel/fpsimd.c                         |   1 +
>  arch/arm64/kernel/smccc-call.S                     |  35 +----
>  arch/powerpc/kvm/book3s_hv.c                       |  12 ++
>  arch/xtensa/Kconfig                                |   1 +
>  arch/xtensa/include/asm/cmpxchg.h                  |   2 +
>  block/blk-map.c                                    |  56 +++-----
>  block/blk-merge.c                                  | 146 ++++++++-------=
------
>  block/blk-mq.c                                     |  11 +-
>  block/blk.h                                        |  69 ++++++----
>  drivers/char/tpm/tpm-chip.c                        |   4 -
>  drivers/char/tpm/tpm-interface.c                   |  32 +++--
>  drivers/clk/qcom/clk-alpha-pll.c                   |   2 +-
>  drivers/clk/qcom/gcc-x1e80100.c                    |  12 +-
>  drivers/clk/qcom/videocc-sm8350.c                  |   4 +-
>  drivers/edac/qcom_edac.c                           |   8 +-
>  drivers/firmware/arm_scmi/bus.c                    |   7 +-
>  drivers/firmware/qcom/Kconfig                      |  11 --
>  drivers/firmware/qcom/qcom_scm.c                   |  77 +++++++++--
>  drivers/firmware/smccc/smccc.c                     |   4 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  10 +-
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |   2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  15 +++
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   4 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  49 +++++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   4 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |   5 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   5 +-
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   5 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |   4 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   4 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  20 ++-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   5 +-
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  74 +----------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   8 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   2 +
>  drivers/gpu/drm/imagination/pvr_context.c          |  33 +++++
>  drivers/gpu/drm/imagination/pvr_context.h          |  21 +++
>  drivers/gpu/drm/imagination/pvr_device.h           |  10 ++
>  drivers/gpu/drm/imagination/pvr_drv.c              |   3 +
>  drivers/gpu/drm/imagination/pvr_vm.c               |  22 +++-
>  drivers/gpu/drm/imagination/pvr_vm.h               |   1 +
>  drivers/gpu/drm/panthor/panthor_device.c           |   4 +
>  drivers/gpu/drm/panthor/panthor_mmu.c              |   2 +
>  drivers/gpu/drm/xe/regs/xe_gt_regs.h               |   2 +-
>  drivers/gpu/drm/xe/xe_device.h                     |  14 ++
>  drivers/gpu/drm/xe/xe_exec.c                       |  13 +-
>  drivers/gpu/drm/xe/xe_gt_ccs_mode.c                |   6 +
>  drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c        |   2 +
>  drivers/gpu/drm/xe/xe_guc_ct.c                     |   9 ++
>  drivers/gpu/drm/xe/xe_wait_user_fence.c            |   7 +
>  drivers/hid/hid-core.c                             |   2 +-
>  drivers/i2c/busses/i2c-designware-common.c         |   6 +-
>  drivers/i2c/busses/i2c-designware-core.h           |   1 +
>  drivers/irqchip/irq-gic-v3.c                       |   7 +
>  drivers/md/dm-cache-target.c                       |  59 +++++----
>  drivers/md/dm-unstripe.c                           |   4 +-
>  drivers/md/dm.c                                    |   4 +-
>  drivers/media/cec/usb/pulse8/pulse8-cec.c          |   2 +-
>  drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |   3 +
>  drivers/media/dvb-core/dvb_frontend.c              |   4 +-
>  drivers/media/dvb-core/dvb_vb2.c                   |   8 +-
>  drivers/media/dvb-core/dvbdev.c                    |  17 ++-
>  drivers/media/dvb-frontends/cx24116.c              |   7 +-
>  drivers/media/dvb-frontends/stb0899_algo.c         |   2 +-
>  drivers/media/i2c/adv7604.c                        |  26 ++--
>  drivers/media/i2c/ar0521.c                         |   4 +-
>  drivers/media/pci/mgb4/mgb4_cmt.c                  |   2 +
>  .../media/platform/samsung/s5p-jpeg/jpeg-core.c    |  17 ++-
>  drivers/media/test-drivers/vivid/vivid-core.c      |   2 +-
>  drivers/media/test-drivers/vivid/vivid-core.h      |   4 +-
>  drivers/media/test-drivers/vivid/vivid-ctrls.c     |   2 +-
>  drivers/media/test-drivers/vivid/vivid-vid-cap.c   |   2 +-
>  drivers/media/usb/uvc/uvc_driver.c                 |   2 +-
>  drivers/media/v4l2-core/v4l2-ctrls-api.c           |  17 ++-
>  drivers/net/can/c_can/c_can_main.c                 |   7 +-
>  drivers/net/can/cc770/Kconfig                      |   2 +-
>  drivers/net/can/m_can/m_can.c                      |   3 +-
>  drivers/net/can/sja1000/Kconfig                    |   2 +-
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c     |   8 +-
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |  10 +-
>  drivers/net/ethernet/arc/emac_main.c               |  27 ++--
>  drivers/net/ethernet/arc/emac_mdio.c               |   9 +-
>  .../net/ethernet/freescale/dpaa/dpaa_eth_trace.h   |   2 +-
>  drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  18 +--
>  drivers/net/ethernet/freescale/enetc/enetc_vf.c    |   9 +-
>  drivers/net/ethernet/hisilicon/hns3/hnae3.c        |   5 +-
>  drivers/net/ethernet/intel/e1000e/ich8lan.c        |  17 +--
>  drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  12 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |   3 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.h          |   4 +-
>  drivers/net/ethernet/intel/idpf/idpf.h             |   4 +-
>  drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  11 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c         |   5 +-
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   3 +-
>  .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |   1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   1 +
>  drivers/net/ethernet/vertexcom/mse102x.c           |   5 +-
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   4 +-
>  drivers/net/phy/dp83848.c                          |   2 +
>  drivers/net/virtio_net.c                           | 119 ++++++++++++++-=
--
>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c         |   2 +-
>  drivers/platform/x86/amd/pmc/pmc.c                 |   5 +
>  drivers/platform/x86/amd/pmf/core.c                |  21 ++-
>  drivers/platform/x86/amd/pmf/pmf.h                 |  55 ++++++++
>  drivers/platform/x86/amd/pmf/spc.c                 |  52 +++++---
>  drivers/pwm/pwm-imx-tpm.c                          |   4 +-
>  drivers/regulator/rtq2208-regulator.c              |   2 +-
>  drivers/rpmsg/qcom_glink_native.c                  |  10 +-
>  drivers/scsi/sd_zbc.c                              |   3 +-
>  drivers/soc/qcom/llcc-qcom.c                       |   3 +
>  drivers/staging/media/av7110/av7110.h              |   4 +-
>  drivers/staging/media/av7110/av7110_ca.c           |  25 ++--
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   6 +-
>  drivers/thermal/qcom/lmh.c                         |   7 +
>  drivers/thermal/thermal_of.c                       |  21 ++-
>  drivers/thunderbolt/retimer.c                      |   2 +
>  drivers/thunderbolt/usb4.c                         |   2 +-
>  drivers/ufs/core/ufshcd.c                          |  10 +-
>  drivers/usb/dwc3/core.c                            |  25 ++--
>  drivers/usb/musb/sunxi.c                           |   2 -
>  drivers/usb/serial/io_edgeport.c                   |   8 +-
>  drivers/usb/serial/option.c                        |   6 +
>  drivers/usb/serial/qcserial.c                      |   2 +
>  .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    |   8 +-
>  drivers/usb/typec/ucsi/ucsi_ccg.c                  |   2 +
>  fs/btrfs/bio.c                                     |  30 +++--
>  fs/btrfs/delayed-ref.c                             |   2 +-
>  fs/btrfs/inode.c                                   |   2 +-
>  fs/btrfs/super.c                                   |  25 +---
>  fs/nfs/inode.c                                     |  70 ++++++----
>  fs/nfs/nfs4proc.c                                  |   4 +
>  fs/nfs/super.c                                     |  10 +-
>  fs/ocfs2/xattr.c                                   |   3 +-
>  fs/proc/vmcore.c                                   |   9 +-
>  fs/smb/server/connection.c                         |   1 +
>  fs/smb/server/connection.h                         |   1 +
>  fs/smb/server/mgmt/user_session.c                  |  15 ++-
>  fs/smb/server/server.c                             |  20 +--
>  fs/smb/server/smb_common.c                         |  10 +-
>  fs/smb/server/smb_common.h                         |   2 +-
>  fs/tracefs/inode.c                                 |  12 +-
>  include/linux/arm-smccc.h                          |  32 +----
>  include/linux/bio.h                                |   4 +-
>  include/linux/soc/qcom/llcc-qcom.h                 |   2 +
>  include/linux/user_namespace.h                     |   3 +-
>  include/net/netfilter/nf_tables.h                  |   4 +
>  include/trace/events/rxrpc.h                       |   1 +
>  kernel/signal.c                                    |   3 +-
>  kernel/ucount.c                                    |   9 +-
>  lib/objpool.c                                      |  18 ++-
>  mm/damon/core.c                                    |  42 ++++--
>  mm/filemap.c                                       |   2 +-
>  mm/huge_memory.c                                   |  35 +++--
>  mm/internal.h                                      |  10 +-
>  mm/memcontrol-v1.c                                 |  25 ++++
>  mm/memcontrol.c                                    |   8 +-
>  mm/migrate.c                                       |   4 +-
>  mm/mlock.c                                         |   9 +-
>  mm/page_alloc.c                                    |   1 -
>  mm/slab_common.c                                   |  31 +++--
>  mm/swap.c                                          |   4 +-
>  mm/vmscan.c                                        |   4 +-
>  net/mptcp/mptcp_pm_gen.c                           |   1 -
>  net/mptcp/pm_userspace.c                           |   3 +-
>  net/netfilter/nf_tables_api.c                      |  41 +++++-
>  net/rxrpc/conn_client.c                            |   4 +
>  net/sctp/sm_statefuns.c                            |   2 +-
>  net/smc/af_smc.c                                   |   4 +-
>  net/sunrpc/xprtsock.c                              |   1 +
>  net/vmw_vsock/hyperv_transport.c                   |   1 +
>  net/vmw_vsock/virtio_transport_common.c            |   1 +
>  security/keys/keyring.c                            |   7 +-
>  security/keys/trusted-keys/trusted_dcp.c           |   9 +-
>  sound/firewire/tascam/amdtp-tascam.c               |   2 +-
>  sound/pci/hda/patch_conexant.c                     |   2 -
>  sound/soc/amd/yc/acp6x-mach.c                      |   7 +
>  sound/soc/sof/sof-client-probes-ipc4.c             |   1 +
>  sound/soc/stm/stm32_spdifrx.c                      |   2 +-
>  sound/usb/mixer.c                                  |   1 +
>  sound/usb/quirks.c                                 |   2 +
>  tools/lib/thermal/sampling.c                       |   2 +
>  tools/testing/selftests/mm/hugetlb_dio.c           |  19 ++-
>  218 files changed, 1518 insertions(+), 865 deletions(-)
>
>
>

