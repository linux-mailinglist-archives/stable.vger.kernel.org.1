Return-Path: <stable+bounces-163327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38DB09C9C
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 09:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373AC1628C1
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065C213E74;
	Fri, 18 Jul 2025 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="a7+PYmKf";
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="tknHJYvL"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090A2192FA
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823798; cv=none; b=jCBlflc8hIKHFH7Ij9a/vMPncLzo1rJC8lmLCQdD2nHQSvuV/vrSz6tEmGJniiXbcrMDEbI/k32b/L2ow75mLC6KScL/PRv+CvqWl0IjKOL4FHTSeA0th3JhNVR2ury2thLlScVFirRC+8uRAki/DCTUh42ttywPb5XlLDpRC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823798; c=relaxed/simple;
	bh=73mtiu+STtAofJ48KZx5LpXK+i6ebmLNIL3vWgzqJLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L9Mr8R1zEMzqHqIArG45zyTphQtUN7ihKmXWK8yKMTQVA+AtcnyltGJlMyhHJ3Po5xykUqJgzSubfIoys+iSeqvf2I/zy4chMiDbUPT+Wsl9v+qSppqs+Y7FyiFkgxq7ldaRDlQvs9wuiKG7RsXMZOKfjp9eKUSQD/gkC5JAFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi; spf=pass smtp.mailfrom=hacktheplanet.fi; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=a7+PYmKf; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=tknHJYvL; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktheplanet.fi
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=73mtiu+STtAof
	J48KZx5LpXK+i6ebmLNIL3vWgzqJLY=; h=subject:cc:to:from:date;
	d=hacktheplanet.fi; b=a7+PYmKf8EKl1hzrXSVa4Rv2HljxSXmckUz2WnfEvJbnaQu5
	amJNJ4Q1qjlbYAxR1OFYuJj8AWncxLr6na28JiGbl6bC3Zgog/Z6ywhB0/v3hsJ/qbP8dg
	iTec99VduSJytEbt4lclDhXSQ4AvbLZSVMHSPbjoupYF8xEGOuIG2F50o4UXt+FYN2Lb3U
	9iJdsZJ77Bay9nKFbgUl9fD8x1XaUYQe/KLhTaV3uRx2Di/ZODs4k2DF8+q7njod/Ai24p
	u86sVJMRaS3F3ooq8/SSBf8XyXkK1ZlgVvG015L3OFgf77UMyxlggkQp5XoBVMUfaQLOuN
	c9oXjW3aRKty5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
	s=key1; t=1752823782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=naR/zISxdFD2IfX/9yHd+kaNh8ZX3NCQpAGgz3lCALA=;
	b=tknHJYvLZXqQ0IL6jKStI7SHa6OsP3K6O9VMjw64cde4D24l5zbLP5hXaeTIEY164KJz62
	+VftPSvMFZBEQZZb5Po9izwkraz9sliNePOfN1z5AwPApmu8jVnUoL0Nd2hxsOLhx8mu4H
	dJXX0WQZtWTH2IotCPFYp3Ka1idrykSYLkIVWjeq7VAWHQhve+nqqiuhIYhs2PiS8T0El9
	kLCy8bwCWqmwf3lbnx1BAjyRej5rnHUsbEx2sBwxn340HbD5ebPqZNF78NQWeZekNfjDKt
	Yo69ay6XOMbwHhToP6YFxF/msP/qFq2ZC50TNNPna1+6rp6VhrtFsAoRSTddsw==
Date: Fri, 18 Jul 2025 16:29:34 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
Message-ID: <aHn33vgj8bM4s073@hacktheplanet.fi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi,

I hit this regression on the stable kernel on Alpine with a Lenovo Yoga
Slim 7 Pro 17ACH5. During early boot, when the amdgpu module gets
loaded, backlight brightness is set to zero, resulting in a black
screen (and nothing in userspace is running yet to handle brightness
keys; I need to use an external monitor or type in my rootfs passphrase
blind).

#regzbot introduced: 6c56c8ec6f9762c33bd22f31d43af4194d12da53

bisect log:

git bisect start
# status: waiting for both good and bad commits
# good: [e60eb441596d1c70e4a264d2bac726c6cd2da067] Linux 6.15.4
git bisect good e60eb441596d1c70e4a264d2bac726c6cd2da067
# status: waiting for bad commit, 1 good commit known
# bad: [1562d948232546cfad45a1beddc70fe0c7b34950] Linux 6.15.6
git bisect bad 1562d948232546cfad45a1beddc70fe0c7b34950
# good: [5e10620cb8e76279fd86411536c3fa0f486cd634] drm/xe/vm: move rebind_work init earlier
git bisect good 5e10620cb8e76279fd86411536c3fa0f486cd634
# bad: [ece85751c3e46c0e3c4f772113f691b7aec81d5d] btrfs: record new subvolume in parent dir earlier to avoid dir logging races
git bisect bad ece85751c3e46c0e3c4f772113f691b7aec81d5d
# bad: [9f5d2487a9fad1d36bcf107d1f3b1ebc8b6796cf] iommufd/selftest: Add asserts testing global mfd
git bisect bad 9f5d2487a9fad1d36bcf107d1f3b1ebc8b6796cf
# good: [c0687ec5625b2261d48936d03c761e38657f4a4b] rust: completion: implement initial abstraction
git bisect good c0687ec5625b2261d48936d03c761e38657f4a4b
# bad: [889906e6eb5fab990c9b6b5fe8f1122b2416fc22] drm/amd/display: Export full brightness range to userspace
git bisect bad 889906e6eb5fab990c9b6b5fe8f1122b2416fc22
# good: [c7d15ba11c8561c5f325ffeb27ed8a4e82d4d322] io_uring/kbuf: flag partial buffer mappings
git bisect good c7d15ba11c8561c5f325ffeb27ed8a4e82d4d322
# good: [66089fa8c9ed162744037ab0375e38cc74c7f7ed] drm/amd/display: Add debugging message for brightness caps
git bisect good 66089fa8c9ed162744037ab0375e38cc74c7f7ed
# bad: [cd711c87c2862be5e71eee79901f94e1c943f9fc] drm/amd/display: Only read ACPI backlight caps once
git bisect bad cd711c87c2862be5e71eee79901f94e1c943f9fc
# bad: [6c56c8ec6f9762c33bd22f31d43af4194d12da53] drm/amd/display: Fix default DC and AC levels
git bisect bad 6c56c8ec6f9762c33bd22f31d43af4194d12da53
# first bad commit: [6c56c8ec6f9762c33bd22f31d43af4194d12da53] drm/amd/display: Fix default DC and AC levels

'dmesg|grep amd' on 6.15.7 on this machine:

[    0.319726] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    4.090573] [drm] amdgpu kernel modesetting enabled.
[    4.094238] amdgpu: Virtual CRAT table created for CPU
[    4.095389] amdgpu: Topology: Add CPU node
[    4.096451] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
[    4.174815] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <soc15_common>
[    4.176034] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v9_0>
[    4.176992] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <vega10_ih>
[    4.177911] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
[    4.178799] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
[    4.179704] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
[    4.180594] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v9_0>
[    4.181445] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v4_0>
[    4.182299] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v2_0>
[    4.183114] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v2_0>
[    4.183910] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    4.184800] amdgpu: ATOM BIOS: 113-CEZANNE-017
[    4.208484] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    4.208493] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
[    4.208509] amdgpu 0000:03:00.0: amdgpu: MODE2 reset
[    4.209086] amdgpu 0000:03:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[    4.209099] amdgpu 0000:03:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[    4.209376] [drm] amdgpu: 2048M of VRAM memory ready
[    4.209386] [drm] amdgpu: 6912M of GTT memory ready.
[    4.210517] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: 8 VEP: 0 Revision: 3
[    4.927350] amdgpu 0000:03:00.0: amdgpu: reserve 0x400000 from 0xf47f400000 for PSP TMR
[    5.010609] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
[    5.021347] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    5.021357] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[    5.021725] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    5.131949] amdgpu 0000:03:00.0: amdgpu: [drm] Using ACPI provided EDID for eDP-1
[    5.385266] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    5.385286] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    5.385435] amdgpu: Virtual CRAT table created for GPU
[    5.385562] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[    5.385569] kfd kfd: amdgpu: added device 1002:1638
[    5.385582] amdgpu 0000:03:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 8
[    5.385592] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[    5.385598] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    5.385605] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    5.385612] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[    5.385619] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[    5.385625] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[    5.385632] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[    5.385639] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[    5.385645] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[    5.385652] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
[    5.385659] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
[    5.385665] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 8
[    5.385672] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 8
[    5.385679] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 8
[    5.385685] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 8
[    5.454665] amdgpu 0000:03:00.0: amdgpu: Runtime PM not available
[    5.455003] amdgpu 0000:03:00.0: amdgpu: [drm] Using custom brightness curve
[    5.455339] [drm] Initialized amdgpu 3.63.0 for 0000:03:00.0 on minor 1
[    5.480731] fbcon: amdgpudrmfb (fb0) is primary device
[    6.796057] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer device

-- 
Lauri Tirkkonen | lotheac @ IRCnet

