Return-Path: <stable+bounces-152342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A10AD4374
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 22:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1904F7A3135
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 20:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013DE264A9C;
	Tue, 10 Jun 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbq8FjTC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E15244682
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749585980; cv=none; b=i1FX1o3g1z33CF1JbuoXZM/6DOpTHypSlnOuuzz3a0fXjWsWK22p3Ro4uiMPqxC/4LIFcKi2G8KO3zd3amDPNC75E+34Jnt6+ZhxeUC9znvtGzYzxAfoV+WCh0J/IDCPW/uWmdqSWhuoMUNjPBUYuc1t5KWrcypJHYEaI0AcxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749585980; c=relaxed/simple;
	bh=ON8srizFJvrITOgRhCX/T2a7DGcRIe8fDB9gj/wLbe0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jGTiBs0WFw8wfLnwgcruCN8YZffLFq4zcKLUbIZMKglvhR6KGPbSwEXEKUFKNLJovSBKI7IxELyQCMsCrekU1Xreu+iN44KoxMdP7WcCbiFbVuXX1BIQCMbwy57H7f6KVRzgNsjH5vRL2AUFGeVqmVZQt60EyQj/5PbljiCjT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbq8FjTC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453066fad06so23532525e9.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749585977; x=1750190777; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQPUyXsw7sbqxosFoh+8vRiZ07V5q5KEHfZL15WhaVQ=;
        b=gbq8FjTCRabN1/r6/XxpebfvoKVaSQ3rTzRFFMyI2WtSCzTH+bhhtdQR4W0+D86Qqy
         5q4fT32+v3DSj7y1NkD79kgA8DpGYsmYzQ+HNcKax1GL+8HeljtjV4p+F5YvhCQHZrFP
         NSY4mNY3TO2sQSl74dZkFhxVf73A1IpKwbxAAqQNt21A+lWTEWRZ67oqpULsugRKSPns
         JY+tu6qa6RdVcpI6ZVEsnRC+zelL7KmI12C519mepoPiQFkQXf2LJ9azFQ2ZzIpBa1yd
         c8n0RM9wacrl30gm1XctwBSGPdAB096YiHvQ+2gpU/TVuXSqXvK3s4i1nx2oxy/gs2qC
         K0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749585977; x=1750190777;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wQPUyXsw7sbqxosFoh+8vRiZ07V5q5KEHfZL15WhaVQ=;
        b=Pa7lhfcOVqQJmUJU6tyRoNZ45bUl2g1Y6DpXHab1p0Pn5XQpvYdO7ZgsgY/YXsn5jK
         NUB5REYMwdHX6WZk3La21JRYwNxykeKaChA+YheMZY8R3ctGS9wYPJq6vU5lQ0tXH0yI
         nGAtWDKRpHI9noEvhIwo1ilk2wydpYzXTpz2xMPTGDzq9DtBu0gA97x+gozrCsWXvJ8J
         XentNKafe1DqHafgJcwOQJNOp63mwvcnNDj6Et8njdWiA1IRu/ACo1JDXZ5s0Ec5WBDv
         ZE1icE0YuwrkBNi2baTBBLdfXWWL1ojbTsEJ4E2shZ/sJE+EtHYdWPKc1t6ktHzljeX+
         RcwA==
X-Gm-Message-State: AOJu0YyMEvuttuOKHuqZNqda6FX5XCePzbwqRb5lyHYPMT7ZpoRl4qD+
	hLZGo8LdhxAEdUXA0svFSSzoLPjQgOTupH6ID9Fgkm6m9PG5Yvy1hc/DknNBMg==
X-Gm-Gg: ASbGncuG8cTb1nEVuP6/eLOYzi+Fl1nrm1Gx6qt1IPFuVQ6KGrlVlV1/n8zgn3koVtt
	PLosBmn7HAy3iCnPNzlucHPfHnBoBVNNdZRG4mtl8GSmcpOYOhMpDLlkIgD03abn36jTXTGndpf
	UUHQ0XcFWMYjnTd0idKBivHo01UbQATL73TuubRIUebIrjd6Cr34Hg6PlOI0WdW0ZKxAkZLP3M2
	Q3y77a0/eExF0s+H2XypBq5l3l/+R0oC5alJQSe4Fd2vuYpGRz6jSlduwjGONH9RhsMpS8c/4MA
	YoPIMpBxw1s8DcK8+qdhjR5ucP83sz6m2NDNxFrCyspAbHjCguVXPCg0s2lwrdVs+fkL42JRLcd
	ubXs2jzEO
X-Google-Smtp-Source: AGHT+IHblrKsaJXF4yFRDSf5OL26QlI0+5aa+zj26k3P4ayD8PmEgDMCuSSe2U2ctlLAl6swMPr+8g==
X-Received: by 2002:a05:600c:3b98:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4532481f2c5mr4605395e9.0.1749585976525;
        Tue, 10 Jun 2025 13:06:16 -0700 (PDT)
Received: from [192.168.1.100] (host-2-98-9-99.as13285.net. [2.98.9.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464575sm13228095f8f.97.2025.06.10.13.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 13:06:16 -0700 (PDT)
Message-ID: <086ba44f-c4a9-45ec-a571-7fa217daf006@gmail.com>
Date: Tue, 10 Jun 2025 21:06:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl-PL
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, drm-amdgpu@lists.freedesktop.org,
 alexander.deucher@amd.com
From: msk <mskpl78@gmail.com>
Subject: =?UTF-8?Q?=5BREGRESSION=5D=5Bstable_v6=2E14=5D_AMD_GPU_init_failure?=
 =?UTF-8?Q?_in_v6=2E14=2E10_=E2=80=93_revert_needed_for_commit_c53f23f7075c9?=
 =?UTF-8?Q?f63f14d7ec8f2cc3e33e118d986?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

#regzbot introduced: c53f23f7075c9f63f14d7ec8f2cc3e33e118d986

**Summary**
A regression introduced in **v6.14.10** breaks AMD GPU initialization on 
RX 9070 XT system due to commit c53f23f7… (“drm/amd/display: check 
stream id dml21 wrapper…”). Reverting this commit restores proper 
graphical startup.

dmesg output before revert

[    2.699091] ACPI: bus type drm_connector registered
[    2.699734] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    2.699740] xhci_hcd 0000:02:00.0: new USB bus registered, assigned 
bus number 1
[    2.755165] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version 
0x110 quirks 0x0000000000000010
[    2.755445] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    2.755448] xhci_hcd 0000:02:00.0: new USB bus registered, assigned 
bus number 2
[    2.755450] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced 
SuperSpeed
[    2.755511] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.14
[    2.755512] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    2.755514] usb usb1: Product: xHCI Host Controller
[    2.755515] usb usb1: Manufacturer: Linux 6.14.10-x64v3-xanmod1 xhci-hcd
[    2.755517] usb usb1: SerialNumber: 0000:02:00.0
[    2.755613] hub 1-0:1.0: USB hub found
[    2.755629] hub 1-0:1.0: 10 ports detected
[    2.755952] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    2.755973] usb usb2: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.14
[    2.755975] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    2.755976] usb usb2: Product: xHCI Host Controller
[    2.755978] usb usb2: Manufacturer: Linux 6.14.10-x64v3-xanmod1 xhci-hcd
[    2.755979] usb usb2: SerialNumber: 0000:02:00.0
[    2.756056] hub 2-0:1.0: USB hub found
[    2.756065] hub 2-0:1.0: 4 ports detected
[    2.756274] xhci_hcd 0000:0a:00.3: xHCI Host Controller
[    2.756278] xhci_hcd 0000:0a:00.3: new USB bus registered, assigned 
bus number 3
[    2.756384] xhci_hcd 0000:0a:00.3: hcc params 0x0278ffe5 hci version 
0x110 quirks 0x0000000000000010
[    2.756622] xhci_hcd 0000:0a:00.3: xHCI Host Controller
[    2.756624] xhci_hcd 0000:0a:00.3: new USB bus registered, assigned 
bus number 4
[    2.756626] xhci_hcd 0000:0a:00.3: Host supports USB 3.1 Enhanced 
SuperSpeed
[    2.756657] usb usb3: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.14
[    2.756659] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    2.756660] usb usb3: Product: xHCI Host Controller
[    2.756661] usb usb3: Manufacturer: Linux 6.14.10-x64v3-xanmod1 xhci-hcd
[    2.756663] usb usb3: SerialNumber: 0000:0a:00.3
[    2.756748] hub 3-0:1.0: USB hub found
[    2.756756] hub 3-0:1.0: 4 ports detected
[    2.756903] usb usb4: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    2.756924] usb usb4: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.14
[    2.756926] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    2.756927] usb usb4: Product: xHCI Host Controller
[    2.756928] usb usb4: Manufacturer: Linux 6.14.10-x64v3-xanmod1 xhci-hcd
[    2.756929] usb usb4: SerialNumber: 0000:0a:00.3
[    2.757008] hub 4-0:1.0: USB hub found
[    2.757015] hub 4-0:1.0: 4 ports detected
[    2.757180] usbcore: registered new interface driver usbserial_generic
[    2.757184] usbserial: USB Serial support registered for generic
[    2.757253] rtc_cmos 00:02: RTC can wake from S4
[    2.757465] rtc_cmos 00:02: registered as rtc0
[    2.757494] rtc_cmos 00:02: setting system clock to 
2025-06-10T13:46:18 UTC (1749563178)
[    2.757517] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    2.793080] simple-framebuffer simple-framebuffer.0: [drm] Registered 
1 planes with drm panic
[    2.793082] [drm] Initialized simpledrm 1.0.0 for 
simple-framebuffer.0 on minor 0
[    2.796240] fbcon: Deferring console take-over
[    2.796241] simple-framebuffer simple-framebuffer.0: [drm] fb0: 
simpledrmdrmfb frame buffer device


dmesg output after revert

[    2.634779] ata1: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80100 irq 40 lpm-pol 0
[    2.634782] ata2: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80180 irq 40 lpm-pol 0
[    2.634785] ata3: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80200 irq 40 lpm-pol 0
[    2.634787] ata4: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80280 irq 40 lpm-pol 0
[    2.634789] ata5: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80300 irq 40 lpm-pol 0
[    2.634791] ata6: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80380 irq 40 lpm-pol 0
[    2.634848] ACPI: bus type drm_connector registered
[    2.634869] [drm] amdgpu kernel modesetting enabled.
[    2.644006] amdgpu: Virtual CRAT table created for CPU
[    2.644017] amdgpu: Topology: Add CPU node
[    2.644089] amdgpu 0000:08:00.0: enabling device (0006 -> 0007)
[    2.644120] [drm] initializing kernel modesetting (IP DISCOVERY 
0x1002:0x7550 0x1EAE:0x8811 0xC0).
[    2.644128] [drm] register mmio base: 0xFCD00000
[    2.644129] [drm] register mmio size: 524288
[    2.648358] amdgpu 0000:08:00.0: amdgpu: detected ip block number 0 
<soc24_common>
[    2.648360] amdgpu 0000:08:00.0: amdgpu: detected ip block number 1 
<gmc_v12_0>
[    2.648362] amdgpu 0000:08:00.0: amdgpu: detected ip block number 2 
<ih_v7_0>
[    2.648364] amdgpu 0000:08:00.0: amdgpu: detected ip block number 3 <psp>
[    2.648365] amdgpu 0000:08:00.0: amdgpu: detected ip block number 4 <smu>
[    2.648366] amdgpu 0000:08:00.0: amdgpu: detected ip block number 5 <dm>
[    2.648368] amdgpu 0000:08:00.0: amdgpu: detected ip block number 6 
<gfx_v12_0>
[    2.648369] amdgpu 0000:08:00.0: amdgpu: detected ip block number 7 
<sdma_v7_0>
[    2.648370] amdgpu 0000:08:00.0: amdgpu: detected ip block number 8 
<vcn_v5_0_0>
[    2.648372] amdgpu 0000:08:00.0: amdgpu: detected ip block number 9 
<jpeg_v5_0_0>
[    2.648373] amdgpu 0000:08:00.0: amdgpu: detected ip block number 10 
<mes_v12_0>
[    2.648383] amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.648385] amdgpu: ATOM BIOS: 113-EXT108832-100
[    2.659806] amdgpu 0000:08:00.0: vgaarb: deactivate vga console
[    2.659809] amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone (TMZ) 
feature not supported
[    2.659830] amdgpu 0000:08:00.0: amdgpu: MEM ECC is not presented.
[    2.659831] amdgpu 0000:08:00.0: amdgpu: SRAM ECC is not presented.
[    2.659845] [drm] vm size is 262144 GB, 4 levels, block size is 
9-bit, fragment size is 9-bit
[    2.659850] amdgpu 0000:08:00.0: amdgpu: VRAM: 16304M 
0x0000008000000000 - 0x00000083FAFFFFFF (16304M used)
[    2.659852] amdgpu 0000:08:00.0: amdgpu: GART: 512M 
0x0000000000000000 - 0x000000001FFFFFFF
[    2.659856] [drm] Detected VRAM RAM=16304M, BAR=16384M
[    2.659858] [drm] RAM width 256bits GDDR6
[    2.659915] [drm] amdgpu: 16304M of VRAM memory ready
[    2.659916] [drm] amdgpu: 15990M of GTT memory ready.
[    2.659926] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    2.659998] amdgpu 0000:08:00.0: amdgpu: PCIE GART of 512M enabled 
(table at 0x00000083DAB00000).
[    2.660416] [drm] Loading DMUB firmware via PSP: version=0x00010300
[    2.660749] [drm] Found VCN firmware Version ENC: 1.7 DEC: 9 VEP: 0 
Revision: 19
[    2.895324] amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode 
is not available
[    2.895327] amdgpu 0000:08:00.0: amdgpu: SECUREDISPLAY: securedisplay 
ta ucode is not available
[    2.895357] amdgpu 0000:08:00.0: amdgpu: smu driver if version = 
0x0000002e, smu fw if version = 0x00000032, smu fw program = 0, smu fw 
version = 0x00684400 (104.68.0)
[    2.895360] amdgpu 0000:08:00.0: amdgpu: SMU driver if version not 
matched
[    2.934857] amdgpu 0000:08:00.0: amdgpu: SMU is initialized successfully!
[    2.935596] [drm] Display Core v3.2.316 initialized on DCN 4.0.1
[    2.935598] [drm] DP-HDMI FRL PCON supported
[    2.939115] [drm] DMUB hardware initialized: version=0x00010300
[    2.942565] ata1: SATA link down (SStatus 0 SControl 300)
[    3.233092] amdgpu 0000:08:00.0: amdgpu: program CP_MES_CNTL : 0x4000000
[    3.233097] amdgpu 0000:08:00.0: amdgpu: program CP_MES_CNTL : 0xc000000
[    3.293410] amdgpu: HMM registered 16304MB device memory
[    3.294762] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    3.294771] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    3.294806] amdgpu: Virtual CRAT table created for GPU
[    3.294972] amdgpu: Topology: Add dGPU node [0x7550:0x1002]
[    3.294974] kfd kfd: amdgpu: added device 1002:7550
[    3.294983] amdgpu 0000:08:00.0: amdgpu: SE 4, SH per SE 2, CU per SH 
8, active_cu_number 64
[    3.294986] amdgpu 0000:08:00.0: amdgpu: ring gfx_0.0.0 uses VM inv 
eng 0 on hub 0
[    3.294987] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
eng 1 on hub 0
[    3.294989] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
eng 4 on hub 0
[    3.294990] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
eng 6 on hub 0
[    3.294991] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
eng 7 on hub 0
[    3.294993] amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 8 
on hub 0
[    3.294994] amdgpu 0000:08:00.0: amdgpu: ring sdma1 uses VM inv eng 9 
on hub 0
[    3.294995] amdgpu 0000:08:00.0: amdgpu: ring vcn_unified_0 uses VM 
inv eng 0 on hub 8
[    3.294997] amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv 
eng 1 on hub 8
[    3.296713] [drm] ring gfx_32768.1.1 was added
[    3.296874] [drm] ring compute_32768.2.2 was added
[    3.297032] [drm] ring sdma_32768.3.3 was added
[    3.297075] [drm] ring gfx_32768.1.1 ib test pass
[    3.297119] [drm] ring compute_32768.2.2 ib test pass
[    3.297157] [drm] ring sdma_32768.3.3 ib test pass
[    3.299782] amdgpu 0000:08:00.0: amdgpu: Using BACO for runtime pm
[    3.300156] amdgpu 0000:08:00.0: [drm] Registered 4 planes with drm panic
[    3.300158] [drm] Initialized amdgpu 3.61.0 for 0000:08:00.0 on minor 0
[    3.328171] fbcon: amdgpudrmfb (fb0) is primary device
[    3.328173] fbcon: Deferring console take-over
[    3.328175] amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb frame buffer 
device


I am aware that this issue pertains to the XanMod kernel. However, upon 
reviewing the commits, there is no indication that it is a downstream 
issue. I attempted to confirm this regression by building the kernel 
from the Git repository, but my limited skills and knowledge proved 
insufficient.

Please review this regression and consider reverting the commit from the 
stable 6.14 and 6.15 branches - or propose an alternate patch.

Thanks & Regards,
Marcin Kryzak


