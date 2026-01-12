Return-Path: <stable+bounces-208088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C9D11F32
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00A0B301D338
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EEF30F547;
	Mon, 12 Jan 2026 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=student.kit.edu header.i=@student.kit.edu header.b="Iz7RqGyN"
X-Original-To: stable@vger.kernel.org
Received: from scc-mailout-kit-01.scc.kit.edu (scc-mailout-kit-01.scc.kit.edu [141.52.71.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB92C21C2;
	Mon, 12 Jan 2026 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.52.71.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214331; cv=none; b=lMKhhrS7WHh1jyFxxgv8vioagRYhXizl1pCC5Sg1ndFULvRNdlxdveOinZ/afY0V4sMk5z8LMkgfpMMbMnAVlR6RTFu+mO3s3Mdtsad7T5fw9LcUDjCKWM+z5CRMp1C2E6a/qcWBcUzxtt6dlrmAp5gmL6PBL5pzningbkiNfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214331; c=relaxed/simple;
	bh=LW8g3a8khAUgIiVlrGOXWNJIAOkMK+4NQeZzgg6qGIE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:CC:Content-Type; b=i2x64ZSL/2ItEI/tWhp0tUp7X5JdPiUFI/dJlexOywCa79VaiCD1MS+5x6bc4Ji/Tc6T9zXXqUdrjUZDqGjr06d2W0ivnjVkuvwF7hDOJy/q1cStCfqhZaJZl1vXIc99f/5Gq1SEGXG8n+DWySEO3mCt/3NN8YPTXkVXuYHr29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=student.kit.edu; spf=pass smtp.mailfrom=student.kit.edu; dkim=pass (2048-bit key) header.d=student.kit.edu header.i=@student.kit.edu header.b=Iz7RqGyN; arc=none smtp.client-ip=141.52.71.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=student.kit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.kit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=student.kit.edu; s=kit2; h=Content-Transfer-Encoding:Content-Type:CC:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f0EUDs3DtL5lMByYvcfbnW/FPCjMzkUyFYsnayHEmgM=; b=Iz7RqGyNWljjvnehQbgh0xqKsU
	FiOZs/72c/KSKqbXXv8ZjJHTQqxLKzeB2BhUU7WBTkdPgOgVh0hqRWVopcd8htzyKlSPlrGVbDTmw
	Hzfl6q/wWiTqOhAqFb+MfhXZszsv3xkNm2XPX569F1BXzOA5sB8Q+2nhi87UEYzyiYJ9GjspxpbLL
	uQxbAfJpNjRVLHVLNm/qaaGnZILLhc606SJUN0JQtaNtFfgmOTvLWy4uutKGuGPhVnwO7obxBAEKl
	sQ1DiPHsvDvV7GmACbBBFcX6B80a5YW69wMYSUdykoqjKEJ+KdkLhPyLamQwz0KbAwh0bpeFEw8q5
	Jxws2pJg==;
Received: from kit-msx-50.kit.edu ([2a00:1398:9:f612::150])
	by scc-mailout-kit-01.scc.kit.edu with esmtps (TLS1.2:ECDHE_SECP384R1__RSA_SHA256__AES_256_GCM:256)
	(envelope-from <peter.bohner@student.kit.edu>)
	id 1vfF1T-00000003UMA-0T2W;
	Mon, 12 Jan 2026 11:19:43 +0100
Received: from [IPV6:2a00:1398:9:fb03:8ac:b9ee:dcd8:35a5]
 (2a00:1398:9:fb03:8ac:b9ee:dcd8:35a5) by smtp.kit.edu (2a00:1398:9:f612::106)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 12 Jan
 2026 11:19:37 +0100
Message-ID: <c5c597ac-ed9c-4062-9393-b28bd69ac116@student.kit.edu>
Date: Mon, 12 Jan 2026 11:19:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: <amd-gfx@lists.freedesktop.org>, <stable@vger.kernel.org>,
	<regressions@lists.linux.dev>, <bugs@lists.linux.dev>
From: =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>
Subject: [6.12.64 lts] [amdgpu]: regression: broken multi-monitor USB4 dock
 after suspend on Ryzen 7840U & random panics
Autocrypt: addr=peter.bohner@student.kit.edu; keydata=
 xjMEZlcqPBYJKwYBBAHaRw8BAQdAujEt8nGiqXlRzKWzklo/PFVaTiUdA6z4ptXk8gUpZZPN
 LFDDqXRlciBCb2huZXIgPHBldGVyLmJvaG5lckBzdHVkZW50LmtpdC5lZHU+wokEExYIADEW
 IQR4QiuKMuzoE9FfVrf+973rw/xgRwUCZlcqPAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEP73
 vevD/GBH4k4A/jn/XvRQH5Od/m9FpAc3xIwzOjOjFRogJqjNN8h7WGIpAP90BCUs7idkZS/U
 9ASZrK6ubOZV+pEHq9C0mSoVTjwkDc44BGZXKjwSCisGAQQBl1UBBQEBB0AyMulJt5lkL/5E
 hrwAaZiEOSigauCQR7o58Pnzh5hwGAMBCAfCeAQYFggAIBYhBHhCK4oy7OgT0V9Wt/73vevD
 /GBHBQJmVyo8AhsMAAoJEP73vevD/GBHRjYA/0Z40p2r7jZGqQeJB5Exh3sBjLNnuuMw5DXr
 KxFIdY8/AQDj6Xn+3dAOMHJfo17HT8zHn61PvclzVJZCriEmBcSsDQ==
CC: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	<ivan.lipski@amd.com>, <Jerry.Zuo@amd.com>, <aurabindo.pillai@amd.com>,
	<daniel.wheeler@amd.com>, <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

After my previous issue 
(https://lore.kernel.org/all/9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu/T/) 
was fixed in 6.12.64 (Revert "drm/amd/display: Fix pbn to kbps 
Conversion"), I upgraded to find my displays broken again, this time 
only after suspend.

hardware (same as previous regression):
Framework 13 AMD (7840U / 780M) & Dynabook Thunderbolt 4 Dock with two 
monitors attached (4k over DP, 1200p over HDMI)

The system was stable with <=6.12.59 and with 6.12.61+the revert above, 
now getting the monitors to light up at all
takes many more tries of plugging them in and out, and after resuming 
from suspend, the monitors never light up, and two `WARNING`s can be 
seen in the dmesg below.

[ 3426.190935] WARNING: CPU: 14 PID: 3018 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/link/hwss/link_hwss_dpia.c:49 
update_dpia_stream_allocation_table+0xf2/0x100 [amdgpu]
[34340.602938] WARNING: CPU: 15 PID: 3018 at 
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:197 
fill_dc_mst_payload_table_from_drm+0x92/0x130 [amdgpu]

this line used to be spammed way fewer times in the past: [drm] DMUB HPD 
RX IRQ callback: link_index=5
and this spammed line is new as well: [drm] DPIA AUX failed on 0x0(1), 
error 7
(see dmesg in previous thread)

I have also experienced 2 kernel panics with 6.12.64 (can't recall that 
ever happening) upon plugging in the thunderbolt dock, for which no 
dmesg could be found in the journal.

I've created a drm/amd issue as well 
https://gitlab.freedesktop.org/drm/amd/-/issues/4870, but I am not sure 
if this is only amdgpu related.

I don't think I'll have time to bisect this, as I am quite busy at the 
moment.

kind regards, thanks in advance and a happy new year,

Peter

Full dmesg:
[   35.937471] pci 0000:04:00.0: PCI bridge to [bus 05]
[   35.937476] pci 0000:04:00.0:   bridge window [mem 0x78000000-0x780fffff]
[   35.937481] pci 0000:04:00.0:   bridge window [mem 
0x7800000000-0x78000fffff 64bit pref]
[   35.937488] pci 0000:04:01.0: PCI bridge to [bus 06-24]
[   35.937493] pci 0000:04:01.0:   bridge window [mem 0x78100000-0x7fffffff]
[   35.937497] pci 0000:04:01.0:   bridge window [mem 
0x7800100000-0x7d554fffff 64bit pref]
[   35.937504] pci 0000:04:02.0: PCI bridge to [bus 25-43]
[   35.937509] pci 0000:04:02.0:   bridge window [mem 0x80000000-0x87efffff]
[   35.937513] pci 0000:04:02.0:   bridge window [mem 
0x7d55500000-0x82aa8fffff 64bit pref]
[   35.937520] pci 0000:04:03.0: PCI bridge to [bus 44-60]
[   35.937525] pci 0000:04:03.0:   bridge window [mem 0x87f00000-0x8fdfffff]
[   35.937529] pci 0000:04:03.0:   bridge window [mem 
0x82aa900000-0x87ffcfffff 64bit pref]
[   35.937536] pci 0000:04:04.0: PCI bridge to [bus 61]
[   35.937542] pci 0000:04:04.0:   bridge window [mem 0x8fe00000-0x8fefffff]
[   35.937546] pci 0000:04:04.0:   bridge window [mem 
0x87ffd00000-0x87ffdfffff 64bit pref]
[   35.937552] pci 0000:03:00.0: PCI bridge to [bus 04-61]
[   35.937558] pci 0000:03:00.0:   bridge window [mem 0x78000000-0x8fffffff]
[   35.937561] pci 0000:03:00.0:   bridge window [mem 
0x7800000000-0x87ffffffff 64bit pref]
[   35.937568] pcieport 0000:00:03.1: PCI bridge to [bus 03-61]
[   35.937570] pcieport 0000:00:03.1:   bridge window [io 0x6000-0x9fff]
[   35.937574] pcieport 0000:00:03.1:   bridge window [mem 
0x78000000-0x8fffffff]
[   35.937576] pcieport 0000:00:03.1:   bridge window [mem 
0x7800000000-0x87ffffffff 64bit pref]
[   35.937588] PCI: No. 2 try to assign unassigned res
[   35.937590] pcieport 0000:00:03.1: resource 13 [io 0x6000-0x9fff] 
released
[   35.937592] pcieport 0000:00:03.1: PCI bridge to [bus 03-61]
[   35.937607] pcieport 0000:00:03.1: bridge window [io 0x6000-0xafff]: 
assigned
[   35.937608] pci 0000:03:00.0: bridge window [io 0x6000-0xafff]: assigned
[   35.937610] pci 0000:04:00.0: bridge window [io 0x6000-0x6fff]: assigned
[   35.937611] pci 0000:04:01.0: bridge window [io 0x7000-0x7fff]: assigned
[   35.937613] pci 0000:04:02.0: bridge window [io 0x8000-0x8fff]: assigned
[   35.937614] pci 0000:04:03.0: bridge window [io 0x9000-0x9fff]: assigned
[   35.937615] pci 0000:04:04.0: bridge window [io 0xa000-0xafff]: assigned
[   35.937617] pci 0000:04:00.0: PCI bridge to [bus 05]
[   35.937619] pci 0000:04:00.0:   bridge window [io 0x6000-0x6fff]
[   35.937625] pci 0000:04:00.0:   bridge window [mem 0x78000000-0x780fffff]
[   35.937629] pci 0000:04:00.0:   bridge window [mem 
0x7800000000-0x78000fffff 64bit pref]
[   35.937636] pci 0000:04:01.0: PCI bridge to [bus 06-24]
[   35.937638] pci 0000:04:01.0:   bridge window [io 0x7000-0x7fff]
[   35.937644] pci 0000:04:01.0:   bridge window [mem 0x78100000-0x7fffffff]
[   35.937648] pci 0000:04:01.0:   bridge window [mem 
0x7800100000-0x7d554fffff 64bit pref]
[   35.937654] pci 0000:04:02.0: PCI bridge to [bus 25-43]
[   35.937657] pci 0000:04:02.0:   bridge window [io 0x8000-0x8fff]
[   35.937662] pci 0000:04:02.0:   bridge window [mem 0x80000000-0x87efffff]
[   35.937666] pci 0000:04:02.0:   bridge window [mem 
0x7d55500000-0x82aa8fffff 64bit pref]
[   35.937673] pci 0000:04:03.0: PCI bridge to [bus 44-60]
[   35.937676] pci 0000:04:03.0:   bridge window [io 0x9000-0x9fff]
[   35.937681] pci 0000:04:03.0:   bridge window [mem 0x87f00000-0x8fdfffff]
[   35.937685] pci 0000:04:03.0:   bridge window [mem 
0x82aa900000-0x87ffcfffff 64bit pref]
[   35.937692] pci 0000:04:04.0: PCI bridge to [bus 61]
[   35.937694] pci 0000:04:04.0:   bridge window [io 0xa000-0xafff]
[   35.937700] pci 0000:04:04.0:   bridge window [mem 0x8fe00000-0x8fefffff]
[   35.937704] pci 0000:04:04.0:   bridge window [mem 
0x87ffd00000-0x87ffdfffff 64bit pref]
[   35.937710] pci 0000:03:00.0: PCI bridge to [bus 04-61]
[   35.937713] pci 0000:03:00.0:   bridge window [io 0x6000-0xafff]
[   35.937718] pci 0000:03:00.0:   bridge window [mem 0x78000000-0x8fffffff]
[   35.937722] pci 0000:03:00.0:   bridge window [mem 
0x7800000000-0x87ffffffff 64bit pref]
[   35.937729] pcieport 0000:00:03.1: PCI bridge to [bus 03-61]
[   35.937730] pcieport 0000:00:03.1:   bridge window [io 0x6000-0xafff]
[   35.937733] pcieport 0000:00:03.1:   bridge window [mem 
0x78000000-0x8fffffff]
[   35.937736] pcieport 0000:00:03.1:   bridge window [mem 
0x7800000000-0x87ffffffff 64bit pref]
[   35.938042] pcieport 0000:03:00.0: enabling device (0000 -> 0003)
[   35.938287] pcieport 0000:04:00.0: enabling device (0000 -> 0003)
[   35.938588] pcieport 0000:04:01.0: enabling device (0000 -> 0003)
[   35.938871] pcieport 0000:04:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- 
LLActRep+
[   35.939114] pcieport 0000:04:02.0: enabling device (0000 -> 0003)
[   35.939417] pcieport 0000:04:02.0: pciehp: Slot #2 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- 
LLActRep+
[   35.939615] pcieport 0000:04:03.0: enabling device (0000 -> 0003)
[   35.939783] pcieport 0000:04:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- 
LLActRep+
[   35.939974] pcieport 0000:04:04.0: enabling device (0000 -> 0003)
[   35.945571] [drm] DMUB HPD RX IRQ callback: link_index=5
[   35.951291] [drm] DMUB HPD RX IRQ callback: link_index=5
[   35.962557] [drm] DMUB HPD RX IRQ callback: link_index=5
[   35.968763] [drm] DMUB HPD RX IRQ callback: link_index=5
[   35.974783] [drm] DMUB HPD RX IRQ callback: link_index=5
[   35.986444] [drm] DMUB HPD RX IRQ callback: link_index=5
[   35.998435] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.004389] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.010314] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.021392] [drm] Downstream port present 1, type 0
[   36.033300] [drm] pre_validate_dsc:1701 MST_DSC crtc[1] needs mode_change
[   36.049064] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.059864] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.082927] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.089571] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.095715] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.101657] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.107602] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.113471] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.116072] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.122313] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.128572] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.137374] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.143599] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.152910] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.153901] usb 6-1: new SuperSpeed Plus Gen 2x1 USB device number 2 
using xhci_hcd
[   36.159168] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.161617] [drm] pre_validate_dsc:1706 MST_DSC no mode changed for 
stream 0x0000000021394bb3
[   36.165182] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.170771] usb 6-1: New USB device found, idVendor=8087, 
idProduct=0b40, bcdDevice=12.34
[   36.170775] usb 6-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[   36.170778] usb 6-1: Product: USB3.0 Hub
[   36.170780] usb 6-1: Manufacturer: Intel Corporation.
[   36.171289] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.188444] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.195259] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.201406] hub 6-1:1.0: USB hub found
[   36.201450] hub 6-1:1.0: 4 ports detected
[   36.201510] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.210398] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.216610] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.225921] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.231263] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.234115] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.234117] [drm] DMUB notification skipped due to no handler: 
type=NO_DATA
[   36.236873] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.243031] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.258736] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.265736] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.272052] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.280669] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.286805] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.296180] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.302499] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.308865] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.314110] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.316937] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.330741] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.341800] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.347961] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.356706] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.362023] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.364834] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.399894] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.406359] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.412356] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.418488] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.437135] usb 5-1.1: new low-speed USB device number 3 using xhci_hcd
[   36.442213] [drm] DMUB notification skipped due to no handler: 
type=NO_DATA
[   36.442232] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.449854] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.455989] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.464694] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.470931] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.480285] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.486535] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.492089] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.507440] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.532978] [drm] DMUB notification skipped due to no handler: 
type=NO_DATA
[   36.533001] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.539204] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.544853] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.551025] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.557046] usb 5-1.1: New USB device found, idVendor=0451, 
idProduct=ace1, bcdDevice= 1.50
[   36.557053] usb 5-1.1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[   36.557055] usb 5-1.1: Product: TPS DMC Family
[   36.557057] usb 5-1.1: Manufacturer: Texas Instruments Inc
[   36.557059] usb 5-1.1: SerialNumber: 6F03401608BA75BD0440D2CEDE55E56
[   36.562666] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.568916] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.575223] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.581553] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.588670] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.594380] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.605972] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.611996] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.617925] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.625151] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.637117] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.642757] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.647131] usb 5-1.2: new high-speed USB device number 4 using xhci_hcd
[   36.666351] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.672434] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.677094] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.682994] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.688521] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.699238] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.722277] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.742134] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.748154] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.748622] usb 5-1.2: New USB device found, idVendor=2109, 
idProduct=2822, bcdDevice= 7.d3
[   36.748628] usb 5-1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[   36.748631] usb 5-1.2: Product: USB2.0 Hub
[   36.748634] usb 5-1.2: Manufacturer: VIA Labs, Inc.
[   36.748636] usb 5-1.2: SerialNumber: 000000001
[   36.754234] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.754235] [drm] DMUB notification skipped due to no handler: 
type=NO_DATA
[   36.762144] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.809155] hub 5-1.2:1.0: USB hub found
[   36.809621] hub 5-1.2:1.0: 4 ports detected
[   36.820347] [drm] DMUB HPD RX IRQ callback: link_index=5
[   36.821269] amdgpu 0000:c1:00.0: [drm] *ERROR* dpia_query_hpd_status: 
for link(5) dpia(0) failed with status(1), current_hpd_status(1) 
new_hpd_status(0)
[   36.840728] usb 6-1.4: new SuperSpeed Plus Gen 2x1 USB device number 
3 using xhci_hcd
[   36.915604] [drm] DMUB notification skipped due to no handler: 
type=SET_CONFIGC_REPLY
[   37.007044] usb 6-1.4: New USB device found, idVendor=2109, 
idProduct=0822, bcdDevice= 7.d3
[   37.007051] usb 6-1.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[   37.007054] usb 6-1.4: Product: USB3.1 Hub
[   37.007056] usb 6-1.4: Manufacturer: VIA Labs, Inc.
[   37.007058] usb 6-1.4: SerialNumber: 000000001
[   37.032945] hub 6-1.4:1.0: USB hub found
[   37.033205] hub 6-1.4:1.0: 4 ports detected
[   37.594494] usb 5-1.2.4: new high-speed USB device number 5 using 
xhci_hcd
[   37.742275] usb 5-1.2.4: New USB device found, idVendor=2109, 
idProduct=2822, bcdDevice= 7.e4
[   37.742282] usb 5-1.2.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[   37.742285] usb 5-1.2.4: Product: USB2.0 Hub
[   37.742287] usb 5-1.2.4: Manufacturer: VIA Labs, Inc.
[   37.742289] usb 5-1.2.4: SerialNumber: 000000001
[   37.800861] hub 5-1.2.4:1.0: USB hub found
[   37.801254] hub 5-1.2.4:1.0: 4 ports detected
[   37.832877] usb 6-1.4.1: new SuperSpeed USB device number 4 using 
xhci_hcd
[   37.851246] usb 6-1.4.1: New USB device found, idVendor=05e3, 
idProduct=0764, bcdDevice= 0.01
[   37.851252] usb 6-1.4.1: New USB device strings: Mfr=3, Product=4, 
SerialNumber=2
[   37.851254] usb 6-1.4.1: Product: USB Storage
[   37.851255] usb 6-1.4.1: Manufacturer: Generic
[   37.851256] usb 6-1.4.1: SerialNumber: 000000002959
[   37.957251] usb 6-1.4.4: new SuperSpeed Plus Gen 2x1 USB device 
number 5 using xhci_hcd
[   38.016318] usb 6-1.4.4: New USB device found, idVendor=2109, 
idProduct=0822, bcdDevice= 7.e4
[   38.016323] usb 6-1.4.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[   38.016325] usb 6-1.4.4: Product: USB3.1 Hub
[   38.016327] usb 6-1.4.4: Manufacturer: VIA Labs, Inc.
[   38.016328] usb 6-1.4.4: SerialNumber: 000000001
[   38.040992] hub 6-1.4.4:1.0: USB hub found
[   38.041246] hub 6-1.4.4:1.0: 4 ports detected
[   38.165394] usb-storage 6-1.4.1:1.0: USB Mass Storage device detected
[   38.165578] scsi host0: usb-storage 6-1.4.1:1.0
[   38.165658] usbcore: registered new interface driver usb-storage
[   38.168254] usbcore: registered new interface driver uas
[   38.577144] usb 5-1.2.4.2: new high-speed USB device number 6 using 
xhci_hcd
[   38.712256] usb 5-1.2.4.2: New USB device found, idVendor=2109, 
idProduct=2822, bcdDevice= 7.d3
[   38.712265] usb 5-1.2.4.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[   38.712268] usb 5-1.2.4.2: Product: USB2.0 Hub
[   38.712270] usb 5-1.2.4.2: Manufacturer: VIA Labs, Inc.
[   38.712272] usb 5-1.2.4.2: SerialNumber: 000000001
[   38.760873] hub 5-1.2.4.2:1.0: USB hub found
[   38.761276] hub 5-1.2.4.2:1.0: 4 ports detected
[   38.792894] usb 6-1.4.4.2: new SuperSpeed Plus Gen 2x1 USB device 
number 6 using xhci_hcd
[   38.956002] usb 6-1.4.4.2: New USB device found, idVendor=2109, 
idProduct=0822, bcdDevice= 7.d3
[   38.956010] usb 6-1.4.4.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[   38.956012] usb 6-1.4.4.2: Product: USB3.1 Hub
[   38.956015] usb 6-1.4.4.2: Manufacturer: VIA Labs, Inc.
[   38.956016] usb 6-1.4.4.2: SerialNumber: 000000001
[   38.986265] hub 6-1.4.4.2:1.0: USB hub found
[   38.986539] hub 6-1.4.4.2:1.0: 4 ports detected
[   39.158585] usb 6-1.4.4.4: new SuperSpeed USB device number 7 using 
xhci_hcd
[   39.175286] usb 6-1.4.4.4: New USB device found, idVendor=30f3, 
idProduct=0419, bcdDevice=31.01
[   39.175293] usb 6-1.4.4.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=6
[   39.175296] usb 6-1.4.4.4: Product: USB 10/100/1000 LAN
[   39.175298] usb 6-1.4.4.4: Manufacturer: Realtek
[   39.175300] usb 6-1.4.4.4: SerialNumber: 1014E0A6A
[   39.176503] scsi 0:0:0:0: Direct-Access     Generic MassStorageClass 
0001 PQ: 0 ANSI: 6
[   39.178458] scsi 0:0:0:1: Direct-Access     Generic MassStorageClass 
0001 PQ: 0 ANSI: 6
[   39.193018] sd 0:0:0:0: [sda] Media removed, stopped polling
[   39.193262] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   39.194001] sd 0:0:0:1: [sdb] Media removed, stopped polling
[   39.194317] sd 0:0:0:1: [sdb] Attached SCSI removable disk
[   39.223218] cdc_ether 6-1.4.4.4:2.0 eth0: register 'cdc_ether' at 
usb-0000:c3:00.3-1.4.4.4, CDC Ethernet Device, 80:6d:97:4e:0a:6a
[   39.223246] usbcore: registered new interface driver cdc_ether
[   39.567885] usb 5-1.2.4.2.2: new high-speed USB device number 7 using 
xhci_hcd
[   39.723779] usb 5-1.2.4.2.2: New USB device found, idVendor=1397, 
idProduct=00d4, bcdDevice= 1.01
[   39.723786] usb 5-1.2.4.2.2: New USB device strings: Mfr=12, 
Product=7, SerialNumber=13
[   39.723789] usb 5-1.2.4.2.2: Product: X18/XR18
[   39.723792] usb 5-1.2.4.2.2: Manufacturer: BEHRINGER
[   39.723794] usb 5-1.2.4.2.2: SerialNumber: 592C3096
[   39.790812] usb 6-1.4.4.2.3: new SuperSpeed USB device number 8 using 
xhci_hcd
[   40.044191] usb 6-1.4.4.2.3: New USB device found, idVendor=2109, 
idProduct=0812, bcdDevice= d.a1
[   40.044199] usb 6-1.4.4.2.3: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
[   40.044202] usb 6-1.4.4.2.3: Product: USB3.0 Hub
[   40.044204] usb 6-1.4.4.2.3: Manufacturer: VIA Labs, Inc.
[   40.073704] hub 6-1.4.4.2.3:1.0: USB hub found
[   40.074068] hub 6-1.4.4.2.3:1.0: 4 ports detected
[   40.161093] usb 5-1.2.4.2.3: new high-speed USB device number 8 using 
xhci_hcd
[   40.312459] usb 5-1.2.4.2.3: New USB device found, idVendor=2109, 
idProduct=2812, bcdDevice= d.a0
[   40.312467] usb 5-1.2.4.2.3: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
[   40.312470] usb 5-1.2.4.2.3: Product: USB2.0 Hub
[   40.312472] usb 5-1.2.4.2.3: Manufacturer: VIA Labs, Inc.
[   40.361608] hub 5-1.2.4.2.3:1.0: USB hub found
[   40.362688] hub 5-1.2.4.2.3:1.0: 4 ports detected
[   40.511291] usb 5-1.2.4.2.4: new high-speed USB device number 9 using 
xhci_hcd
[   40.663047] usb 5-1.2.4.2.4: New USB device found, idVendor=046d, 
idProduct=08e5, bcdDevice= 0.0c
[   40.663056] usb 5-1.2.4.2.4: New USB device strings: Mfr=0, 
Product=2, SerialNumber=0
[   40.663060] usb 5-1.2.4.2.4: Product: HD Pro Webcam C920
[   40.730481] usb 5-1.2.4.2.3.2: new full-speed USB device number 10 
using xhci_hcd
[   40.732907] mc: Linux media interface: v0.10
[   40.743793] videodev: Linux video capture interface: v2.00
[   40.763419] usb 5-1.2.4.2.4: Found UVC 1.00 device HD Pro Webcam C920 
(046d:08e5)
[   40.808657] uvcvideo 5-1.2.4.2.4:1.1: Failed to set UVC probe control 
: -32 (exp. 26).
[   40.809783] usbcore: registered new interface driver uvcvideo
[   40.873366] usb 5-1.2.4.2.2: Quirk or no altset; falling back to MIDI 1.0
[   40.920823] usb 5-1.2.4.2.3.2: New USB device found, idVendor=046d, 
idProduct=c52b, bcdDevice=12.11
[   40.920829] usb 5-1.2.4.2.3.2: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
[   40.920832] usb 5-1.2.4.2.3.2: Product: USB Receiver
[   40.920834] usb 5-1.2.4.2.3.2: Manufacturer: Logitech
[   41.293274] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.2/5-1.2.4.2.3.2:1.0/0003:046D:C52B.0006/input/input19
[   41.326960] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 24000
[   41.523895] hid-generic 0003:046D:C52B.0006: input,hidraw5: USB HID 
v1.11 Keyboard [Logitech USB Receiver] on 
usb-0000:c3:00.3-1.2.4.2.3.2/input0
[   41.527898] input: Logitech USB Receiver Mouse as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.2/5-1.2.4.2.3.2:1.1/0003:046D:C52B.0007/input/input20
[   41.528012] input: Logitech USB Receiver Consumer Control as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.2/5-1.2.4.2.3.2:1.1/0003:046D:C52B.0007/input/input21
[   41.542538] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 32000
[   41.580564] input: Logitech USB Receiver System Control as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.2/5-1.2.4.2.3.2:1.1/0003:046D:C52B.0007/input/input22
[   41.580684] hid-generic 0003:046D:C52B.0007: input,hiddev97,hidraw6: 
USB HID v1.11 Mouse [Logitech USB Receiver] on 
usb-0000:c3:00.3-1.2.4.2.3.2/input1
[   41.583883] hid-generic 0003:046D:C52B.0008: hiddev98,hidraw7: USB 
HID v1.11 Device [Logitech USB Receiver] on 
usb-0000:c3:00.3-1.2.4.2.3.2/input2
[   41.670590] usb 5-1.2.4.2.3.4: new full-speed USB device number 11 
using xhci_hcd
[   41.679175] usbcore: registered new interface driver snd-usb-audio
[   41.790648] usb 5-1.2.4.2.3.4: New USB device found, idVendor=24f0, 
idProduct=0140, bcdDevice= 1.00
[   41.790655] usb 5-1.2.4.2.3.4: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
[   41.790658] usb 5-1.2.4.2.3.4: Product: Das Keyboard
[   41.790660] usb 5-1.2.4.2.3.4: Manufacturer: Metadot - Das Keyboard
[   41.894922] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 32000
[   42.095856] input: Metadot - Das Keyboard Das Keyboard as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.4/5-1.2.4.2.3.4:1.0/0003:24F0:0140.0009/input/input24
[   42.277137] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 32000
[   42.290558] hid-generic 0003:24F0:0140.0009: input,hidraw8: USB HID 
v1.10 Keyboard [Metadot - Das Keyboard Das Keyboard] on 
usb-0000:c3:00.3-1.2.4.2.3.4/input0
[   42.297775] input: Metadot - Das Keyboard Das Keyboard System Control 
as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.4/5-1.2.4.2.3.4:1.1/0003:24F0:0140.000A/input/input25
[   42.350535] input: Metadot - Das Keyboard Das Keyboard Consumer 
Control as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.4/5-1.2.4.2.3.4:1.1/0003:24F0:0140.000A/input/input26
[   42.350604] hid-generic 0003:24F0:0140.000A: input,hidraw9: USB HID 
v1.10 Device [Metadot - Das Keyboard Das Keyboard] on 
usb-0000:c3:00.3-1.2.4.2.3.4/input1
[   42.597134] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 32000
[   42.927966] logitech-djreceiver 0003:046D:C52B.0008: 
hiddev97,hidraw5: USB HID v1.11 Device [Logitech USB Receiver] on 
usb-0000:c3:00.3-1.2.4.2.3.2/input2
[   43.052295] input: Logitech MX Master 3 as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.2/5-1.2.4.2.3.2:1.2/0003:046D:C52B.0008/0003:046D:4082.000B/input/input27
[   43.187630] logitech-hidpp-device 0003:046D:4082.000B: input,hidraw6: 
USB HID v1.11 Keyboard [Logitech MX Master 3] on 
usb-0000:c3:00.3-1.2.4.2.3.2/input2:1
[   47.090468] [drm:amdgpu_dm_process_dmub_set_config_sync [amdgpu]] 
*ERROR* wait_for_completion_timeout timeout!
[   47.140597] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.167285] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.202266] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.350775] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.363337] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.419310] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.479056] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.535449] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.581029] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.607858] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.646297] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.704704] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.766976] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.844158] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.864374] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.903447] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.939946] [drm] DMUB HPD RX IRQ callback: link_index=5
[   47.995489] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.052259] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.117484] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.140524] usb 5-1.2.4.2.4: reset high-speed USB device number 9 
using xhci_hcd
[   48.182679] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.218882] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.279094] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.338889] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.404150] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.462619] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.536005] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.593145] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.665845] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.723287] [drm] DMUB HPD RX IRQ callback: link_index=5
[   48.796354] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.094078] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.155019] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.207140] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.265807] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.330924] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.402801] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.442953] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.499180] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.555627] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.688323] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.743861] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.785681] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.842658] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.900312] [drm] DMUB HPD RX IRQ callback: link_index=5
[   49.957162] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.017820] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.069263] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.127309] [drm] DMUB notification skipped due to no handler: 
type=NO_DATA
[   50.127344] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.187862] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.247055] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.330046] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.413716] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.495578] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.576778] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.660155] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.741442] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.833674] [drm] DMUB HPD RX IRQ callback: link_index=5
[   50.923444] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.034409] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.140831] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.248669] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.356783] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.464485] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.572726] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.681358] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.788525] [drm] DMUB HPD RX IRQ callback: link_index=5
[   51.895990] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.001203] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.108528] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.214885] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.322209] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.428644] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.534846] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.644310] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.753118] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.859692] [drm] DMUB HPD RX IRQ callback: link_index=5
[   52.985899] [drm] DMUB HPD RX IRQ callback: link_index=5
[   53.105505] [drm] DMUB HPD RX IRQ callback: link_index=5
[   53.242689] [drm] DMUB HPD RX IRQ callback: link_index=5
[   53.378255] [drm] DMUB HPD RX IRQ callback: link_index=5
[   53.535188] [drm] DMUB HPD RX IRQ callback: link_index=5
[   53.694345] [drm] DMUB HPD RX IRQ callback: link_index=5
[   53.857687] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.014497] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.124527] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.237726] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.346103] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.452601] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.562687] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.683673] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.794595] [drm] DMUB HPD RX IRQ callback: link_index=5
[   54.903307] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.007988] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.123117] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.229195] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.336032] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.444690] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.553090] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.657956] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.771046] [drm] DMUB HPD RX IRQ callback: link_index=5
[   55.934817] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.341615] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.401744] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.453209] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.510623] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.576042] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.650572] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.688200] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.710627] cros-ec-dev cros-ec-dev.1.auto: Some logs may have been 
dropped...
[   56.748366] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.808212] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.867805] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.937455] [drm] DMUB HPD RX IRQ callback: link_index=5
[   56.981333] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.038037] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.094300] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.154718] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.214995] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.289752] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.337655] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.377670] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.424301] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.473390] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.534579] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.611466] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.655970] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.788723] [drm] DMUB HPD RX IRQ callback: link_index=5
[   57.947896] [drm] DMUB HPD RX IRQ callback: link_index=5
[   58.105381] [drm] DMUB HPD RX IRQ callback: link_index=5
[   58.261483] [drm] DMUB HPD RX IRQ callback: link_index=5
[   58.424472] [drm] DMUB HPD RX IRQ callback: link_index=5
[   58.589655] [drm] DMUB HPD RX IRQ callback: link_index=5
[   58.746601] [drm] DMUB HPD RX IRQ callback: link_index=5
[   58.909598] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.072685] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.150659] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.496012] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.558360] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.611800] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.669335] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.735450] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.803628] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.843088] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.902291] [drm] DMUB HPD RX IRQ callback: link_index=5
[   59.963606] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.028288] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.097909] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.137242] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.201584] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.259312] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.264850] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.325732] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.400669] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.448017] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.483226] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.533683] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.585148] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.641612] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.662997] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.718583] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.767254] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.792181] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.858394] [drm] DMUB HPD RX IRQ callback: link_index=5
[   60.979155] [drm] DMUB HPD RX IRQ callback: link_index=5
[   61.103814] [drm] DMUB HPD RX IRQ callback: link_index=5
[   61.211380] [drm] DMUB HPD RX IRQ callback: link_index=5
[   61.318962] [drm] DMUB HPD RX IRQ callback: link_index=5
[   61.409940] [drm] DMUB HPD RX IRQ callback: link_index=5
[   61.502988] [drm] DMUB HPD RX IRQ callback: link_index=5
[   61.587226] [drm] DMUB HPD RX IRQ callback: link_index=5
[   61.672934] [drm] DMUB HPD RX IRQ callback: link_index=5
[   61.750780] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3255.218916] perf: interrupt took too long (2505 > 2500), lowering 
kernel.perf_event_max_sample_rate to 79800
[ 3425.996642] [drm] DMUB HPD IRQ callback: link_index=5
[ 3425.996683] [drm] DM_MST: stopping TM on aconnector: 0000000059a6282d 
[id: 122]
[ 3426.190930] ------------[ cut here ]------------
[ 3426.190935] WARNING: CPU: 14 PID: 3018 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/link/hwss/link_hwss_dpia.c:49 
update_dpia_stream_allocation_table+0xf2/0x100 [amdgpu]
[ 3426.191246] Modules linked in: hid_logitech_dj snd_seq_midi 
snd_seq_midi_event uvcvideo videobuf2_vmalloc uvc videobuf2_memops 
snd_usb_audio videobuf2_v4l2 videobuf2_common snd_usbmidi_lib snd_ump 
videodev snd_rawmidi mc cdc_ether usbnet mii uas usb_storage 
hid_logitech_hidpp ccm rfcomm snd_seq_dummy snd_hrtimer snd_seq 
snd_seq_device tun ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 
xt_multiport xt_cgroup xt_mark xt_owner xt_tcpudp ip6table_raw 
iptable_raw ip6table_mangle iptable_mangle ip6table_nat iptable_nat 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c 
crc32c_generic ip6table_filter ip6_tables iptable_filter ip_tables 
x_tables uhid cmac algif_hash algif_skcipher af_alg bnep vfat fat 
amd_atl intel_rapl_msr intel_rapl_common snd_sof_amd_acp70 
snd_sof_amd_acp63 snd_soc_acpi_amd_match snd_sof_amd_vangogh 
snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci 
snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_amd_sdw_acpi 
mt7921e soundwire_amd kvm_amd mt7921_common
[ 3426.191318]  snd_hda_codec_realtek soundwire_generic_allocation 
hid_sensor_als snd_hda_codec_generic soundwire_bus mt792x_lib 
hid_sensor_trigger snd_hda_scodec_component kvm mt76_connac_lib 
snd_hda_codec_hdmi industrialio_triggered_buffer mousedev kfifo_buf 
snd_soc_core mt76 irqbypass hid_sensor_iio_common leds_cros_ec 
snd_hda_intel snd_compress crct10dif_pclmul industrialio cros_ec_sysfs 
cros_ec_hwmon led_class_multicolor mac80211 cros_ec_chardev 
cros_kbd_led_backlight ac97_bus snd_intel_dspcfg gpio_cros_ec 
cros_charge_control cros_ec_debugfs crc32_pclmul snd_intel_sdw_acpi 
crc32c_intel snd_pcm_dmaengine polyval_clmulni snd_hda_codec libarc4 
snd_rpl_pci_acp6x polyval_generic ghash_clmulni_intel snd_hda_core 
snd_acp_pci spd5118 snd_acp_legacy_common joydev sha512_ssse3 
hid_multitouch hid_sensor_hub cros_ec_dev sha256_ssse3 btusb 
snd_pci_acp6x snd_hwdep sha1_ssse3 cfg80211 btrtl snd_pcm aesni_intel 
snd_pci_acp5x btintel snd_rn_pci_acp3x sp5100_tco gf128mul snd_timer 
btbcm amd_pmf snd_acp_config ucsi_acpi crypto_simd
[ 3426.191380]  snd snd_soc_acpi btmtk amdtee cryptd i2c_piix4 
typec_ucsi bluetooth rapl wmi_bmof pcspkr typec thunderbolt rfkill 
soundcore snd_pci_acp3x ccp k10temp i2c_smbus roles amd_sfh cros_ec_lpcs 
platform_profile i2c_hid_acpi tee amd_pmc i2c_hid cros_ec mac_hid 
i2c_dev crypto_user nfnetlink bpf_preload hid_generic usbhid amdgpu 
zfs(POE) crc16 spl(OE) amdxcp i2c_algo_bit drm_ttm_helper serio_raw ttm 
drm_exec atkbd gpu_sched libps2 vivaldi_fmap drm_suballoc_helper nvme 
drm_buddy i8042 drm_display_helper nvme_core video serio cec nvme_auth wmi
[ 3426.191434] CPU: 14 UID: 1000 PID: 3018 Comm: kwin_wayland Tainted: 
P           OE      6.12.64-1-lts #1 
8c2629090c0c373070c59d027e89ff0b1ee80aa2
[ 3426.191439] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, 
[E]=UNSIGNED_MODULE
[ 3426.191440] Hardware name: Framework Laptop 13 (AMD Ryzen 
7040Series)/FRANMDCP07, BIOS 03.16 07/25/2025
[ 3426.191442] RIP: 0010:update_dpia_stream_allocation_table+0xf2/0x100 
[amdgpu]
[ 3426.191709] Code: d0 0f 1f 00 48 8b 44 24 08 65 48 2b 04 25 28 00 00 
00 75 1a 48 83 c4 10 5b 5d 41 5c 41 5d e9 10 68 89 d7 31 db e9 6f ff ff 
ff <0f> 0b eb 8a e8 b5 85 68 d7 0f 1f 44 00 00 90 90 90 90 90 90 90 90
[ 3426.191711] RSP: 0018:ffffcbb8a436b3a0 EFLAGS: 00010206
[ 3426.191714] RAX: 0000000000000018 RBX: 0000000000000026 RCX: 
0000000000000e80
[ 3426.191716] RDX: 0000000000000018 RSI: ffffcbb8a436b348 RDI: 
ffff8b768dba9a08
[ 3426.191717] RBP: ffff8b7691272388 R08: 0000000000000018 R09: 
0000000000000e80
[ 3426.191718] R10: ffffcbb8c0ef9900 R11: ffff8b768dba9800 R12: 
ffff8b768d8a2e00
[ 3426.191720] R13: ffff8b7691272000 R14: ffff8b77cd5e0000 R15: 
ffff8b76916185f0
[ 3426.191722] FS:  00007529ee520b80(0000) GS:ffff8b841e100000(0000) 
knlGS:0000000000000000
[ 3426.191723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3426.191725] CR2: 0000055c0557f080 CR3: 0000000125364000 CR4: 
0000000000f50ef0
[ 3426.191727] PKRU: 55555554
[ 3426.191728] Call Trace:
[ 3426.191732]  <TASK>
[ 3426.191735]  link_set_dpms_off+0x61f/0x790 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[ 3426.191989]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.191995]  dcn31_reset_hw_ctx_wrap+0x232/0x450 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[ 3426.192231]  dce110_apply_ctx_to_hw+0x63/0x2e0 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[ 3426.192467]  ? dcn10_setup_stereo+0xe0/0x170 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[ 3426.192692]  dc_commit_state_no_check+0x63d/0xeb0 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[ 3426.192935]  dc_commit_streams+0x296/0x490 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[ 3426.193176]  amdgpu_dm_atomic_commit_tail+0x6a1/0x3a10 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[ 3426.193429]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193435]  ? psi_task_switch+0x113/0x2a0
[ 3426.193439]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193445]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193449]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193452]  ? schedule+0x27/0xf0
[ 3426.193456]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193459]  ? schedule_timeout+0x133/0x170
[ 3426.193461]  ? drm_gem_plane_helper_prepare_fb+0x90/0x1f0
[ 3426.193467]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193469]  ? dma_fence_default_wait+0x8b/0x230
[ 3426.193472]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193475]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193478]  ? wait_for_completion_timeout+0x12e/0x180
[ 3426.193481]  ? __pfx_dma_fence_default_wait_cb+0x10/0x10
[ 3426.193483]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193486]  ? kvfree_call_rcu+0x21a/0x370
[ 3426.193493]  commit_tail+0xae/0x140
[ 3426.193498]  drm_atomic_helper_commit+0x13c/0x180
[ 3426.193502]  drm_atomic_commit+0xa6/0xe0
[ 3426.193507]  ? __pfx___drm_printfn_info+0x10/0x10
[ 3426.193512]  drm_mode_atomic_ioctl+0xa60/0xcd0
[ 3426.193518]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[ 3426.193522]  drm_ioctl_kernel+0xad/0x100
[ 3426.193528]  drm_ioctl+0x286/0x500
[ 3426.193531]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[ 3426.193538]  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[ 3426.193749]  __x64_sys_ioctl+0x91/0xd0
[ 3426.193755]  do_syscall_64+0x7b/0x190
[ 3426.193759]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193764]  ? drain_obj_stock+0xb9/0x250
[ 3426.193772]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193775]  ? filp_flush+0x4e/0x80
[ 3426.193779]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193782]  ? syscall_exit_to_user_mode+0x37/0x1c0
[ 3426.193785]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193788]  ? do_syscall_64+0x87/0x190
[ 3426.193791]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193794]  ? syscall_exit_to_user_mode+0x37/0x1c0
[ 3426.193797]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193800]  ? do_syscall_64+0x87/0x190
[ 3426.193803]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193806]  ? do_syscall_64+0x87/0x190
[ 3426.193809]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193812]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193815]  ? syscall_exit_to_user_mode+0x37/0x1c0
[ 3426.193818]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193821]  ? do_syscall_64+0x87/0x190
[ 3426.193823]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193826]  ? syscall_exit_to_user_mode+0x37/0x1c0
[ 3426.193829]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193831]  ? do_syscall_64+0x87/0x190
[ 3426.193834]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3426.193837]  ? irqentry_exit_to_user_mode+0x2c/0x1b0
[ 3426.193840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 3426.193844] RIP: 0033:0x7529f528f70d
[ 3426.193879] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 
45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 
05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[ 3426.193881] RSP: 002b:00007ffdbc86a0b0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[ 3426.193885] RAX: ffffffffffffffda RBX: 00005dd5cdd87100 RCX: 
00007529f528f70d
[ 3426.193887] RDX: 00007ffdbc86a1a0 RSI: 00000000c03864bc RDI: 
0000000000000013
[ 3426.193889] RBP: 00007ffdbc86a100 R08: 00005dd5ce7a35d8 R09: 
00005dd5cd4d00a0
[ 3426.193891] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007ffdbc86a1a0
[ 3426.193893] R13: 00000000c03864bc R14: 0000000000000013 R15: 
00005dd5ce7a34c0
[ 3426.193898]  </TASK>
[ 3426.193899] ---[ end trace 0000000000000000 ]---
[ 3427.691139] [drm] DMUB HPD IRQ callback: link_index=5
[ 3427.747625] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[ 3427.751278] [drm] DM_MST: DP14, 4-lane link detected
[ 3427.753948] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3427.808834] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3427.867176] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3427.924571] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3427.988102] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.032590] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.094804] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.161771] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.217907] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.289909] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.326514] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.383695] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.439627] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.496123] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.549989] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.613821] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.669738] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.729882] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.787109] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.843481] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.900151] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3428.956631] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.017344] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.087370] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.143215] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.199921] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.257150] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.316626] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.373864] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.430415] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.486712] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.543612] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.615052] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.669412] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.726628] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.786545] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.843696] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.900318] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3429.956967] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.016866] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.077386] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.147734] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.202425] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.260011] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.316899] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.373747] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.430421] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.486628] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.546384] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.606752] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.673289] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.730256] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.786604] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.843403] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.908143] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3430.963128] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3431.019824] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3431.076967] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3431.136780] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3431.192942] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3431.570611] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.492359] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.604878] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.646368] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.702614] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.762979] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.824563] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.893581] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.933989] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3432.992743] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.049536] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.110889] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.166171] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.283109] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.380647] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.493026] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.590848] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.703374] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.808868] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3433.926605] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3435.070461] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3435.183183] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3546.444159] [drm] DMUB HPD IRQ callback: link_index=5
[ 3546.444207] [drm] DM_MST: stopping TM on aconnector: 0000000059a6282d 
[id: 122]
[ 3548.207700] [drm] DMUB HPD IRQ callback: link_index=5
[ 3548.263351] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[ 3548.267032] [drm] DM_MST: DP14, 4-lane link detected
[ 3548.269689] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.327811] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.382135] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.443822] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.501327] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.559195] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.627372] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.675334] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.687885] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.735908] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.741478] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.798314] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.853927] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.901945] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3548.958608] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.021207] [drm] Downstream port present 1, type 0
[ 3549.050981] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.107128] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.175641] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.211985] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.268948] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.325594] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.381961] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.439072] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.500075] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.556106] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.614988] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.669454] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.729236] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.785927] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.841979] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.898907] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3549.977605] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.031028] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.089007] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.151605] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.205259] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.264863] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.319059] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.376318] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.432438] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.502480] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.554672] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.609410] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.668494] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.725599] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.785549] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.842436] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.898984] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3550.956091] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.028846] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.085027] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.143220] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.202563] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.259160] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.322675] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.378931] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.438892] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.495815] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.566442] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.622561] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.682376] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.744754] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.802263] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.865385] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.925850] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3551.982196] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.042257] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.114914] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.169190] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.229199] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.285987] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.346265] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.401856] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.461045] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.515573] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.575096] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.628708] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.685292] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.742169] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.812505] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.869060] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.925072] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3552.978676] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3553.070594] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3553.125320] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3553.188492] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3553.242556] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3553.634409] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3553.927002] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.384430] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.444033] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.491840] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.548160] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.606651] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.667829] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.735476] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.770617] [drm] DMUB notification skipped due to no handler: 
type=NO_DATA
[ 3554.772114] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.828001] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.884847] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3554.949426] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.015317] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.055136] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.114974] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.196999] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.236709] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.286190] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.349289] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.421730] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.468051] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.505163] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.555730] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.600099] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.661244] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.804077] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.817770] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3555.973831] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3556.132934] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3556.290313] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3556.446552] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3556.600235] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3556.756354] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3556.912183] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3557.070185] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3557.227033] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3557.387836] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3557.546841] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3557.702996] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3557.856795] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3558.017167] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3558.174135] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3558.333204] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3558.491026] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3558.646342] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3558.800023] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3558.956605] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3559.119577] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3559.192554] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3560.384313] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 3560.459054] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 4588.960757] Bluetooth: hci0: Opcode 0x0401 failed: -16
[ 6197.065936] wlp1s0: deauthenticating from ac:8b:a9:48:29:8b by local 
choice (Reason: 3=DEAUTH_LEAVING)
[ 6197.258285] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 6197.317463] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 6197.374431] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 6197.435157] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 6197.928056] PM: suspend entry (s2idle)
[ 6202.155137] Filesystems sync: 4.227 seconds
[ 6202.158478] Freezing user space processes
[ 6202.159332] Freezing user space processes aborted after 0.000 seconds 
(70 tasks refusing to freeze, wq_busy=0):
[ 6202.159397] OOM killer enabled.
[ 6202.159399] Restarting tasks ... done.
[ 6202.160126] random: crng reseeded on system resumption
[ 6202.162298] PM: suspend exit
[ 6202.162338] PM: suspend entry (s2idle)
[ 6202.164247] Filesystems sync: 0.001 seconds
[ 6202.165839] Freezing user space processes
[ 6202.167824] Freezing user space processes completed (elapsed 0.001 
seconds)
[ 6202.167827] OOM killer disabled.
[ 6202.167827] Freezing remaining freezable tasks
[ 6202.196136] Freezing remaining freezable tasks completed (elapsed 
0.028 seconds)
[ 6202.196145] printk: Suspending console(s) (use no_console_suspend to 
debug)
[ 6202.550932] queueing ieee80211 work while going to suspend
[ 6202.713747] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 6202.802342] [drm] DMUB HPD RX IRQ callback: link_index=5
[ 6202.885671] pcieport 0000:00:08.3: quirk: disabling D3cold for suspend
[ 6202.886638] ACPI: EC: interrupt blocked
[34333.654256] ACPI: EC: interrupt unblocked
[34334.451512] nvme nvme0: 16/0/0 default/read/poll queues
[34334.452253] [drm] PCIE GART of 512M enabled (table at 
0x00000081FFD00000).
[34334.452431] amdgpu 0000:c1:00.0: amdgpu: SMU is resuming...
[34334.456828] amdgpu 0000:c1:00.0: amdgpu: SMU is resumed successfully!
[34334.461596] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.461597] [drm] Skip DMUB HPD IRQ callback in suspend/resume
[34334.461600] [drm] Skip DMUB HPD IRQ callback in suspend/resume
[34334.461601] [drm] Skip DMUB HPD IRQ callback in suspend/resume
[34334.462262] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.462915] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.463559] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.464224] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.464871] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.465536] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.466190] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.466850] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.467583] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.468238] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.468928] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.469583] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.470233] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.470894] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.471550] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.472211] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.472868] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.473608] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.474272] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.474930] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.475586] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.476242] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.476892] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.477559] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.478283] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.478932] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.479599] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.480271] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.480839] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.481490] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.482161] [drm] DPIA AUX failed on 0x0(1), error 7
[34334.571446] [drm] DM_MST: stopping TM on aconnector: 0000000059a6282d 
[id: 122]
[34334.936504] usb 6-1: reset SuperSpeed Plus Gen 2x1 USB device number 
2 using xhci_hcd
[34335.066573] usb 5-1: reset high-speed USB device number 2 using xhci_hcd
[34335.239619] amdgpu 0000:c1:00.0: [drm] enabling link 5 failed: 15
[34335.536557] usb 6-1.4: reset SuperSpeed Plus Gen 2x1 USB device 
number 3 using xhci_hcd
[34335.889607] amdgpu 0000:c1:00.0: [drm] enabling link 5 failed: 15
[34335.946363] amdgpu 0000:c1:00.0: amdgpu: ring gfx_0.0.0 uses VM inv 
eng 0 on hub 0
[34335.946367] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
eng 1 on hub 0
[34335.946370] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
eng 4 on hub 0
[34335.946372] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
eng 6 on hub 0
[34335.946374] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
eng 7 on hub 0
[34335.946376] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
eng 8 on hub 0
[34335.946378] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
eng 9 on hub 0
[34335.946379] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
eng 10 on hub 0
[34335.946381] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
eng 11 on hub 0
[34335.946383] amdgpu 0000:c1:00.0: amdgpu: ring sdma0 uses VM inv eng 
12 on hub 0
[34335.946385] amdgpu 0000:c1:00.0: amdgpu: ring vcn_unified_0 uses VM 
inv eng 0 on hub 8
[34335.946387] amdgpu 0000:c1:00.0: amdgpu: ring jpeg_dec uses VM inv 
eng 1 on hub 8
[34335.946389] amdgpu 0000:c1:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM 
inv eng 13 on hub 0
[34335.956107] [drm] ring gfx_32814.1.1 was added
[34335.956848] [drm] ring compute_32814.2.2 was added
[34335.957575] [drm] ring sdma_32814.3.3 was added
[34335.957605] [drm] ring gfx_32814.1.1 ib test pass
[34335.957638] [drm] ring compute_32814.2.2 ib test pass
[34335.957752] [drm] ring sdma_32814.3.3 ib test pass
[34335.989632] usb 5-1.1: reset low-speed USB device number 3 using xhci_hcd
[34335.991883] [drm] DMUB HPD IRQ callback: link_index=5
[34336.032709] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.033543] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.034234] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.034995] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.035676] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.036328] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.037020] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.037704] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.038544] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.039241] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.039938] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.040742] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.041440] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.042188] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.042885] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.043583] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.044447] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.045120] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.045793] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.046454] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.047113] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.047842] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.048502] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.049238] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.049898] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.050578] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.051237] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.051897] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.052604] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.053266] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.053967] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.054628] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.054658] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.055367] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.056028] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.056689] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.057404] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.058065] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.058769] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.059430] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.060168] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.060829] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.061491] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.062207] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.062868] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.063571] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.064232] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.064969] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.065630] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.066294] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.067010] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.067653] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.068371] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.069034] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.069675] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.070338] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.071009] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.071671] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.072333] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.073046] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.073710] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.074450] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.075112] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.075792] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.075825] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.076489] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.077154] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.077875] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.078539] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.079275] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.079941] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.080613] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.081278] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.081943] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.082676] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.083343] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.083998] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.084652] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.085378] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.086025] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.086673] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.087320] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.087987] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.088681] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.089342] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.090005] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.090672] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.091320] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.091988] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.092637] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.093306] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.093964] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.094682] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.095352] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.096082] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.096743] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.096781] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.097430] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.098098] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.098750] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.099419] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.100080] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.100805] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.101474] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.102123] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.102791] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.103462] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.104112] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.104781] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.105488] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.106153] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.106824] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.107482] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.108183] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.108848] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.109500] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.110227] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.110896] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.111547] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.112219] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.112946] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.113609] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.114265] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.114936] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.115587] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.116262] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.116926] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.117664] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.117778] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.118443] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.119099] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.119831] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.120509] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.121162] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.121835] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.122571] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.123235] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.123905] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.124569] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.125228] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.125982] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.126655] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.127311] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.127984] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.128637] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.129295] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.129937] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.130595] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.131236] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.131972] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.132631] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.133273] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.133930] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.134591] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.135254] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.135894] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.136552] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.137198] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.137900] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.138541] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.138570] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.139230] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.139882] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.140585] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.141245] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.141887] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.142603] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.143261] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.143904] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.144566] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.145277] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.145939] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.146601] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.147244] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.147905] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.148547] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.149208] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.149905] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.150564] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.151293] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.151946] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.152604] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.153268] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.153914] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.154645] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.155303] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.156008] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.156667] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.157326] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.157971] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.158625] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.159283] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.159314] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.159978] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.160709] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.161358] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.162025] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.162680] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.163381] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.164046] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.164696] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.165413] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.166077] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.166723] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.167389] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.168112] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.168759] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.169426] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.170084] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.170746] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.171412] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.172059] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.172803] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.173470] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.174117] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.174784] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.175433] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.176100] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.176759] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.177490] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.178153] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.178861] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.179510] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.180175] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.180213] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.180881] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.181540] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.182257] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.182925] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.183594] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.184245] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.184914] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.185562] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.186231] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.186892] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.187557] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.188221] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.188872] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.189621] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.190288] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.190985] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.191653] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.192314] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.193023] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.193694] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.194354] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.195007] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.195724] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.196304] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.196975] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.197629] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.198295] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.198957] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.199624] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.200327] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.200983] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.201026] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.201679] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.202352] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.202988] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.203661] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.204316] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.205029] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.205702] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.206305] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.206975] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.207703] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.208371] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.209036] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.209645] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.210310] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.211031] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.211689] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.212329] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.212961] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.213670] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.214329] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.214987] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.215648] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.216281] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.216941] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.217587] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.218248] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.218899] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.219634] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.220294] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.220982] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.221640] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.221669] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.222330] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.223035] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.223691] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.224343] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.224999] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.225727] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.226293] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.226951] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.227596] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.228249] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.228905] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.229570] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.230277] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.230934] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.231599] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.232241] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.232940] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.233593] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.234250] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.234903] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.235561] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.236223] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.236868] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.237588] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.238242] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.238970] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.239632] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.240276] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.241026] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.241690] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.242340] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.242390] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242424] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242459] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242494] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242526] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242558] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242590] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242622] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242654] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242687] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242720] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242753] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242787] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242820] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242854] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242887] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242920] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242953] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.242988] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243023] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243058] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243092] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243126] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243160] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243195] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243231] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243267] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243302] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243338] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243374] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243410] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243450] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243485] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243520] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243554] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243591] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243628] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243664] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243699] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243734] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243771] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243806] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243843] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243879] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243915] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243952] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.243988] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244024] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244060] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244098] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244136] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244172] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244209] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244247] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244283] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244321] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244359] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244398] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244434] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244470] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244508] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244546] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244583] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244621] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244659] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244697] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244736] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244774] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244815] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244853] [drm] DPIA AUX failed on 0x50(0), error 7
[34336.244854] amdgpu 0000:c1:00.0: [drm] *ERROR* No EDID read.
[34336.244895] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.245560] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.246220] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.246876] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.247550] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.248267] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.248922] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.249595] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.250264] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.250904] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.251563] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.252212] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.252868] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.253511] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.254168] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.254813] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.255549] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.256201] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.256844] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.257502] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.258184] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.258844] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.259486] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.260223] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.260884] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.261534] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.262195] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.262930] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.263581] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.264237] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.264880] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.265522] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.265552] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.266212] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.266861] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.267518] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.268178] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.268824] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.269488] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.270184] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.270831] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.271474] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.272182] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.272939] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.273656] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.274308] [drm] DPIA AUX failed on 0x0(1), error 7
[34336.276303] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[34336.282952] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.283599] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.284247] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.284894] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.285599] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.286253] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.286964] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.287612] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.288261] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.288915] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.289564] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.290217] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.290868] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.291522] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.292185] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.292901] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.293550] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.294208] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.294872] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.295535] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.296264] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.296927] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.297585] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.298246] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.298966] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.299626] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.300288] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.300998] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.301646] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.302370] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.302954] [drm] DPIA AUX failed on 0x111(1), error 7
[34336.302956] [drm:dm_helpers_dp_mst_start_top_mgr.cold [amdgpu]] 
*ERROR* DM_MST: Failed to set the device into MST mode!
[34336.303331] [drm] DMUB HPD IRQ callback: link_index=5
[34336.303391] [drm] DMUB HPD IRQ callback: link_index=5
[34336.303428] [drm] DMUB HPD IRQ callback: link_index=5
[34336.303429] [drm] DMUB reported hpd status unchanged. link_index=5
[34336.349639] usb 5-1.2: reset high-speed USB device number 4 using 
xhci_hcd
[34336.373659] [drm] DMUB HPD IRQ callback: link_index=5
[34336.432814] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[34336.432818] [drm] DM_MST: DP13, 4-lane link detected
[34336.517199] usb 6-1.4.1: reset SuperSpeed USB device number 4 using 
xhci_hcd
[34336.673842] usb 6-1.4.4: reset SuperSpeed Plus Gen 2x1 USB device 
number 5 using xhci_hcd
[34337.206884] usb 5-1.2.4: reset high-speed USB device number 5 using 
xhci_hcd
[34337.420459] usb 6-1.4.4.4: reset SuperSpeed USB device number 7 using 
xhci_hcd
[34337.570612] usb 6-1.4.4.2: reset SuperSpeed Plus Gen 2x1 USB device 
number 6 using xhci_hcd
[34338.130207] usb 5-1.2.4.2: reset high-speed USB device number 6 using 
xhci_hcd
[34338.346687] usb 6-1.4.4.2.3: reset SuperSpeed USB device number 8 
using xhci_hcd
[34339.053561] usb 5-1.2.4.2.3: reset high-speed USB device number 8 
using xhci_hcd
[34339.316859] usb 5-1.2.4.2.4: reset high-speed USB device number 9 
using xhci_hcd
[34339.590158] usb 5-1.2.4.2.2: reset high-speed USB device number 7 
using xhci_hcd
[34339.817034] usb 5-1.2.4.2.3.2: reset full-speed USB device number 10 
using xhci_hcd
[34340.016112] usb 5-1.2.4.2.3.4: reset full-speed USB device number 11 
using xhci_hcd
[34340.227471] OOM killer enabled.
[34340.227472] Restarting tasks ... done.
[34340.228605] random: crng reseeded on system resumption
[34340.370606] PM: suspend exit
[34340.602933] ------------[ cut here ]------------
[34340.602938] WARNING: CPU: 15 PID: 3018 at 
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:197 
fill_dc_mst_payload_table_from_drm+0x92/0x130 [amdgpu]
[34340.603241] Modules linked in: hid_logitech_dj snd_seq_midi 
snd_seq_midi_event uvcvideo videobuf2_vmalloc uvc videobuf2_memops 
snd_usb_audio videobuf2_v4l2 videobuf2_common snd_usbmidi_lib snd_ump 
videodev snd_rawmidi mc cdc_ether usbnet mii uas usb_storage 
hid_logitech_hidpp ccm rfcomm snd_seq_dummy snd_hrtimer snd_seq 
snd_seq_device tun ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 
xt_multiport xt_cgroup xt_mark xt_owner xt_tcpudp ip6table_raw 
iptable_raw ip6table_mangle iptable_mangle ip6table_nat iptable_nat 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c 
crc32c_generic ip6table_filter ip6_tables iptable_filter ip_tables 
x_tables uhid cmac algif_hash algif_skcipher af_alg bnep vfat fat 
amd_atl intel_rapl_msr intel_rapl_common snd_sof_amd_acp70 
snd_sof_amd_acp63 snd_soc_acpi_amd_match snd_sof_amd_vangogh 
snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci 
snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_amd_sdw_acpi 
mt7921e soundwire_amd kvm_amd mt7921_common
[34340.603311]  snd_hda_codec_realtek soundwire_generic_allocation 
hid_sensor_als snd_hda_codec_generic soundwire_bus mt792x_lib 
hid_sensor_trigger snd_hda_scodec_component kvm mt76_connac_lib 
snd_hda_codec_hdmi industrialio_triggered_buffer mousedev kfifo_buf 
snd_soc_core mt76 irqbypass hid_sensor_iio_common leds_cros_ec 
snd_hda_intel snd_compress crct10dif_pclmul industrialio cros_ec_sysfs 
cros_ec_hwmon led_class_multicolor mac80211 cros_ec_chardev 
cros_kbd_led_backlight ac97_bus snd_intel_dspcfg gpio_cros_ec 
cros_charge_control cros_ec_debugfs crc32_pclmul snd_intel_sdw_acpi 
crc32c_intel snd_pcm_dmaengine polyval_clmulni snd_hda_codec libarc4 
snd_rpl_pci_acp6x polyval_generic ghash_clmulni_intel snd_hda_core 
snd_acp_pci spd5118 snd_acp_legacy_common joydev sha512_ssse3 
hid_multitouch hid_sensor_hub cros_ec_dev sha256_ssse3 btusb 
snd_pci_acp6x snd_hwdep sha1_ssse3 cfg80211 btrtl snd_pcm aesni_intel 
snd_pci_acp5x btintel snd_rn_pci_acp3x sp5100_tco gf128mul snd_timer 
btbcm amd_pmf snd_acp_config ucsi_acpi crypto_simd
[34340.603372]  snd snd_soc_acpi btmtk amdtee cryptd i2c_piix4 
typec_ucsi bluetooth rapl wmi_bmof pcspkr typec thunderbolt rfkill 
soundcore snd_pci_acp3x ccp k10temp i2c_smbus roles amd_sfh cros_ec_lpcs 
platform_profile i2c_hid_acpi tee amd_pmc i2c_hid cros_ec mac_hid 
i2c_dev crypto_user nfnetlink bpf_preload hid_generic usbhid amdgpu 
zfs(POE) crc16 spl(OE) amdxcp i2c_algo_bit drm_ttm_helper serio_raw ttm 
drm_exec atkbd gpu_sched libps2 vivaldi_fmap drm_suballoc_helper nvme 
drm_buddy i8042 drm_display_helper nvme_core video serio cec nvme_auth wmi
[34340.603425] CPU: 15 UID: 1000 PID: 3018 Comm: kwin_wayland Tainted: 
P        W  OE      6.12.64-1-lts #1 
8c2629090c0c373070c59d027e89ff0b1ee80aa2
[34340.603430] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, 
[O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[34340.603432] Hardware name: Framework Laptop 13 (AMD Ryzen 
7040Series)/FRANMDCP07, BIOS 03.16 07/25/2025
[34340.603433] RIP: 0010:fill_dc_mst_payload_table_from_drm+0x92/0x130 
[amdgpu]
[34340.603677] Code: 31 d2 48 89 c1 eb 0c 90 83 c2 01 48 83 c1 18 39 d6 
74 17 40 38 39 75 f0 48 63 ca 31 ff 48 8d 0c 49 66 89 7c cc 28 39 d6 75 
1c <0f> 0b eb 18 0f b6 4a 09 8b 52 0c 48 8d 04 76 88 4c c4 28 88 54 c4
[34340.603679] RSP: 0018:ffffcbb8a436b290 EFLAGS: 00010246
[34340.603682] RAX: ffffcbb8a436b2b8 RBX: 0000000000000000 RCX: 
0000000000000000
[34340.603684] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffffcbb8a436b338
[34340.603685] RBP: ffff8b7aca2a8000 R08: ffffcbb8a436b414 R09: 
0000000000000000
[34340.603687] R10: 0000000000000001 R11: 0000000000000000 R12: 
ffff8b768e800000
[34340.603688] R13: ffff8b7aca2a8000 R14: ffff8b768f1ba8b8 R15: 
ffffcbb8a436b414
[34340.603690] FS:  00007529ee520b80(0000) GS:ffff8b841e180000(0000) 
knlGS:0000000000000000
[34340.603692] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[34340.603693] CR2: 00001e94027b3300 CR3: 0000000125364000 CR4: 
0000000000f50ef0
[34340.603695] PKRU: 55555554
[34340.603696] Call Trace:
[34340.603700]  <TASK>
[34340.603706] 
dm_helpers_dp_mst_write_payload_allocation_table+0x181/0x1c0 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.603931]  link_set_dpms_off+0x693/0x790 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.604187]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.604193]  ? optc31_set_drr+0x12b/0x1e0 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.604441]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.604445]  dcn31_reset_hw_ctx_wrap+0x232/0x450 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.604688]  dce110_apply_ctx_to_hw+0x63/0x2e0 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.604925]  ? dcn10_setup_stereo+0xe0/0x170 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.605147]  dc_commit_state_no_check+0x63d/0xeb0 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.605378]  dc_commit_streams+0x296/0x490 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.605610]  amdgpu_dm_atomic_commit_tail+0x6a1/0x3a10 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.605856]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605859]  ? psi_task_switch+0x113/0x2a0
[34340.605863]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605868]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605872]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605874]  ? schedule+0x27/0xf0
[34340.605878]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605880]  ? schedule_timeout+0x133/0x170
[34340.605883]  ? drm_gem_plane_helper_prepare_fb+0x90/0x1f0
[34340.605888]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605890]  ? dma_fence_default_wait+0x8b/0x230
[34340.605893]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605896]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605898]  ? wait_for_completion_timeout+0x12e/0x180
[34340.605901]  ? __pfx_dma_fence_default_wait_cb+0x10/0x10
[34340.605903]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.605905]  ? kvfree_call_rcu+0x21a/0x370
[34340.605912]  commit_tail+0xae/0x140
[34340.605917]  drm_atomic_helper_commit+0x13c/0x180
[34340.605920]  drm_atomic_commit+0xa6/0xe0
[34340.605925]  ? __pfx___drm_printfn_info+0x10/0x10
[34340.605929]  drm_mode_atomic_ioctl+0xa60/0xcd0
[34340.605935]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[34340.605938]  drm_ioctl_kernel+0xad/0x100
[34340.605942]  drm_ioctl+0x286/0x500
[34340.605945]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[34340.605951]  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.606146]  __x64_sys_ioctl+0x91/0xd0
[34340.606152]  do_syscall_64+0x7b/0x190
[34340.606157]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606159]  ? syscall_exit_to_user_mode+0x37/0x1c0
[34340.606162]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606165]  ? do_syscall_64+0x87/0x190
[34340.606175]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606178]  ? do_syscall_64+0x87/0x190
[34340.606181]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606183]  ? __x64_sys_poll+0xc6/0x190
[34340.606187]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606189]  ? syscall_exit_to_user_mode+0x37/0x1c0
[34340.606192]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606194]  ? do_syscall_64+0x87/0x190
[34340.606197]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606199]  ? syscall_exit_to_user_mode+0x37/0x1c0
[34340.606202]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606204]  ? do_syscall_64+0x87/0x190
[34340.606206]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606208]  ? syscall_exit_to_user_mode+0x37/0x1c0
[34340.606211]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606213]  ? do_syscall_64+0x87/0x190
[34340.606215]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606218]  ? amdgpu_drm_ioctl+0x6c/0x80 [amdgpu 
1db18b2c20c34172e0247ae61f7924a8e693e3f2]
[34340.606411]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606414]  ? __x64_sys_ioctl+0xac/0xd0
[34340.606416]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606418]  ? syscall_exit_to_user_mode+0x37/0x1c0
[34340.606421]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606423]  ? do_syscall_64+0x87/0x190
[34340.606426]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606428]  ? srso_alias_return_thunk+0x5/0xfbef5
[34340.606431]  ? irqentry_exit_to_user_mode+0x2c/0x1b0
[34340.606434]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[34340.606437] RIP: 0033:0x7529f528f70d
[34340.606470] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 
45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 
05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[34340.606472] RSP: 002b:00007ffdbc86a0b0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[34340.606475] RAX: ffffffffffffffda RBX: 00005dd5ce7effd0 RCX: 
00007529f528f70d
[34340.606477] RDX: 00007ffdbc86a1a0 RSI: 00000000c03864bc RDI: 
0000000000000013
[34340.606478] RBP: 00007ffdbc86a100 R08: 00005dd5cdd72ce8 R09: 
0000000000000064
[34340.606480] R10: 00005dd5cbf3b010 R11: 0000000000000246 R12: 
00007ffdbc86a1a0
[34340.606481] R13: 00000000c03864bc R14: 0000000000000013 R15: 
00005dd5cdd72bd0
[34340.606485]  </TASK>
[34340.606487] ---[ end trace 0000000000000000 ]---
[34343.349940] wlp1s0: authenticate with ac:8b:a9:28:2a:9a (local 
address=a8:3b:76:72:df:d5)
[34343.498901] wlp1s0: send auth to ac:8b:a9:28:2a:9a (try 1/3)
[34343.612136] wlp1s0: authenticated
[34343.612833] wlp1s0: associate with ac:8b:a9:28:2a:9a (try 1/3)
[34343.643951] wlp1s0: RX AssocResp from ac:8b:a9:28:2a:9a (capab=0x1431 
status=0 aid=2)
[34343.675780] wlp1s0: associated
[34343.751182] wlp1s0: Limiting TX power to 20 (20 - 0) dBm as 
advertised by ac:8b:a9:28:2a:9a
[34379.924613] usb 5-1: USB disconnect, device number 2
[34379.924619] usb 5-1.1: USB disconnect, device number 3
[34379.924843] usb 5-1.2: USB disconnect, device number 4
[34379.924846] usb 5-1.2.4: USB disconnect, device number 5
[34379.924848] usb 5-1.2.4.2: USB disconnect, device number 6
[34379.924850] usb 5-1.2.4.2.2: USB disconnect, device number 7
[34379.924860] thunderbolt 0-0:2.1: retimer disconnected
[34379.924871] pcieport 0000:00:03.1: pciehp: Slot(0): Link Down
[34379.924873] pcieport 0000:00:03.1: pciehp: Slot(0): Card not present
[34379.925114] pcieport 0000:00:03.1: PME: Spurious native interrupt!
[34379.925133] pcieport 0000:00:03.1: PME: Spurious native interrupt!
[34379.925773] usb 5-1.2.4.2.3: USB disconnect, device number 8
[34379.925775] usb 5-1.2.4.2.3.2: USB disconnect, device number 10
[34379.925944] pci_bus 0000:05: busn_res: [bus 05] is released
[34379.926005] pci_bus 0000:06: busn_res: [bus 06-24] is released
[34379.926101] pci_bus 0000:25: busn_res: [bus 25-43] is released
[34379.926263] pci_bus 0000:44: busn_res: [bus 44-60] is released
[34379.926371] pci_bus 0000:61: busn_res: [bus 61] is released
[34379.926420] pci_bus 0000:04: busn_res: [bus 04-61] is released
[34379.927019] [drm] DMUB HPD IRQ callback: link_index=5
[34379.927058] [drm] DM_MST: stopping TM on aconnector: 0000000059a6282d 
[id: 122]
[34379.929752] thunderbolt 0-2: device disconnected
[34379.949653] usb 6-1: USB disconnect, device number 2
[34379.949659] usb 6-1.4: USB disconnect, device number 3
[34379.949661] usb 6-1.4.1: USB disconnect, device number 4
[34380.236752] usb 6-1.4.4: USB disconnect, device number 5
[34380.236766] usb 6-1.4.4.2: USB disconnect, device number 6
[34380.236773] usb 6-1.4.4.2.3: USB disconnect, device number 8
[34380.256263] usb 6-1.4.4.4: USB disconnect, device number 7
[34380.256320] cdc_ether 6-1.4.4.4:2.0 eth0: unregister 'cdc_ether' 
usb-0000:c3:00.3-1.4.4.4, CDC Ethernet Device
[34380.351517] usb 5-1.2.4.2.3.4: USB disconnect, device number 11
[34380.913343] usb 5-1.2.4.2.4: USB disconnect, device number 9
[34383.110242] ucsi_acpi USBC000:00: unknown error 0
[34383.110260] ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-5)
[34385.197651] thunderbolt 0-2: new device found, vendor=0x236 device=0x22
[34385.197659] thunderbolt 0-2: Dynabook Thunderbolt 4 Dock
[34385.434885] thunderbolt 0-0:2.1: new retimer found, vendor=0x7fea 
device=0x1032
[34385.695483] usb 5-1: new high-speed USB device number 12 using xhci_hcd
[34385.828491] usb 5-1: New USB device found, idVendor=1d5c, 
idProduct=5801, bcdDevice= 1.01
[34385.828497] usb 5-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[34385.828500] usb 5-1: Product: USB2.0 Hub
[34385.828502] usb 5-1: Manufacturer: Fresco Logic, Inc.
[34385.892268] hub 5-1:1.0: USB hub found
[34385.892472] hub 5-1:1.0: 6 ports detected
[34385.910023] pcieport 0000:00:03.1: pciehp: Slot(0): Card present
[34385.910026] pcieport 0000:00:03.1: pciehp: Slot(0): Link Up
[34385.929388] [drm] DMUB HPD IRQ callback: link_index=5
[34385.986770] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[34385.990623] [drm] DM_MST: DP14, 4-lane link detected
[34385.993317] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.035582] pci 0000:03:00.0: [8086:0b26] type 01 class 0x060400 PCIe 
Switch Upstream Port
[34386.035628] pci 0000:03:00.0: PCI bridge to [bus 00]
[34386.035643] pci 0000:03:00.0:   bridge window [io 0x0000-0x0fff]
[34386.035649] pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff]
[34386.035665] pci 0000:03:00.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[34386.035684] pci 0000:03:00.0: enabling Extended Tags
[34386.035874] pci 0000:03:00.0: supports D1 D2
[34386.035876] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[34386.036056] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth, 
limited by 2.5 GT/s PCIe x1 link at 0000:00:03.1 (capable of 8.000 Gb/s 
with 2.5 GT/s PCIe x4 link)
[34386.036371] pci 0000:03:00.0: Adding to iommu group 4
[34386.036449] pcieport 0000:00:03.1: ASPM: current common clock 
configuration is inconsistent, reconfiguring
[34386.042219] pci 0000:03:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[34386.042433] pci 0000:04:00.0: [8086:0b26] type 01 class 0x060400 PCIe 
Switch Downstream Port
[34386.042470] pci 0000:04:00.0: PCI bridge to [bus 00]
[34386.042482] pci 0000:04:00.0:   bridge window [io 0x0000-0x0fff]
[34386.042488] pci 0000:04:00.0:   bridge window [mem 0x00000000-0x000fffff]
[34386.042503] pci 0000:04:00.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[34386.042523] pci 0000:04:00.0: enabling Extended Tags
[34386.042694] pci 0000:04:00.0: supports D1 D2
[34386.042696] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[34386.043015] pci 0000:04:00.0: Adding to iommu group 4
[34386.043102] pci 0000:04:01.0: [8086:0b26] type 01 class 0x060400 PCIe 
Switch Downstream Port
[34386.043137] pci 0000:04:01.0: PCI bridge to [bus 00]
[34386.043147] pci 0000:04:01.0:   bridge window [io 0x0000-0x0fff]
[34386.043152] pci 0000:04:01.0:   bridge window [mem 0x00000000-0x000fffff]
[34386.043167] pci 0000:04:01.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[34386.043193] pci 0000:04:01.0: enabling Extended Tags
[34386.043346] pci 0000:04:01.0: supports D1 D2
[34386.043348] pci 0000:04:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[34386.043786] pci 0000:04:01.0: Adding to iommu group 4
[34386.043866] pci 0000:04:02.0: [8086:0b26] type 01 class 0x060400 PCIe 
Switch Downstream Port
[34386.043902] pci 0000:04:02.0: PCI bridge to [bus 00]
[34386.043912] pci 0000:04:02.0:   bridge window [io 0x0000-0x0fff]
[34386.043916] pci 0000:04:02.0:   bridge window [mem 0x00000000-0x000fffff]
[34386.043931] pci 0000:04:02.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[34386.043951] pci 0000:04:02.0: enabling Extended Tags
[34386.044109] pci 0000:04:02.0: supports D1 D2
[34386.044111] pci 0000:04:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[34386.044455] pci 0000:04:02.0: Adding to iommu group 4
[34386.044535] pci 0000:04:03.0: [8086:0b26] type 01 class 0x060400 PCIe 
Switch Downstream Port
[34386.044573] pci 0000:04:03.0: PCI bridge to [bus 00]
[34386.044583] pci 0000:04:03.0:   bridge window [io 0x0000-0x0fff]
[34386.044588] pci 0000:04:03.0:   bridge window [mem 0x00000000-0x000fffff]
[34386.044604] pci 0000:04:03.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[34386.044625] pci 0000:04:03.0: enabling Extended Tags
[34386.044797] pci 0000:04:03.0: supports D1 D2
[34386.044799] pci 0000:04:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[34386.045127] pci 0000:04:03.0: Adding to iommu group 4
[34386.045205] pci 0000:04:04.0: [8086:0b26] type 01 class 0x060400 PCIe 
Switch Downstream Port
[34386.045241] pci 0000:04:04.0: PCI bridge to [bus 00]
[34386.045251] pci 0000:04:04.0:   bridge window [io 0x0000-0x0fff]
[34386.045256] pci 0000:04:04.0:   bridge window [mem 0x00000000-0x000fffff]
[34386.045272] pci 0000:04:04.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[34386.045293] pci 0000:04:04.0: enabling Extended Tags
[34386.045463] pci 0000:04:04.0: supports D1 D2
[34386.045465] pci 0000:04:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[34386.045845] pci 0000:04:04.0: Adding to iommu group 4
[34386.045931] pci 0000:03:00.0: PCI bridge to [bus 04-61]
[34386.045956] pci 0000:04:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[34386.045966] pci 0000:04:01.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[34386.045977] pci 0000:04:02.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[34386.045987] pci 0000:04:03.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[34386.045998] pci 0000:04:04.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[34386.046077] pci 0000:04:00.0: PCI bridge to [bus 05-61]
[34386.046094] pci_bus 0000:05: busn_res: [bus 05-61] end is updated to 05
[34386.046171] pci 0000:04:01.0: PCI bridge to [bus 06-61]
[34386.046189] pci_bus 0000:06: busn_res: [bus 06-61] end is updated to 24
[34386.046358] pci 0000:04:02.0: PCI bridge to [bus 25-61]
[34386.046376] pci_bus 0000:25: busn_res: [bus 25-61] end is updated to 43
[34386.046494] pci 0000:04:03.0: PCI bridge to [bus 44-61]
[34386.046512] pci_bus 0000:44: busn_res: [bus 44-61] end is updated to 60
[34386.046591] pci 0000:04:04.0: PCI bridge to [bus 61]
[34386.046609] pci_bus 0000:61: busn_res: [bus 61] end is updated to 61
[34386.046616] pci_bus 0000:04: busn_res: [bus 04-61] end is updated to 61
[34386.046626] pci 0000:04:01.0: bridge window [mem 
0x00100000-0x001fffff 64bit pref] to [bus 06-24] add_size 100000 
add_align 100000
[34386.046631] pci 0000:04:01.0: bridge window [mem 
0x00100000-0x001fffff] to [bus 06-24] add_size 100000 add_align 100000
[34386.046634] pci 0000:04:02.0: bridge window [mem 
0x00100000-0x001fffff 64bit pref] to [bus 25-43] add_size 100000 
add_align 100000
[34386.046637] pci 0000:04:02.0: bridge window [mem 
0x00100000-0x001fffff] to [bus 25-43] add_size 100000 add_align 100000
[34386.046640] pci 0000:04:03.0: bridge window [mem 
0x00100000-0x001fffff 64bit pref] to [bus 44-60] add_size 100000 
add_align 100000
[34386.046643] pci 0000:04:03.0: bridge window [mem 
0x00100000-0x001fffff] to [bus 44-60] add_size 100000 add_align 100000
[34386.046648] pci 0000:03:00.0: bridge window [mem 
0x00100000-0x005fffff 64bit pref] to [bus 04-61] add_size 300000 
add_align 100000
[34386.046652] pci 0000:03:00.0: bridge window [mem 
0x00100000-0x005fffff] to [bus 04-61] add_size 300000 add_align 100000
[34386.046661] pci 0000:03:00.0: bridge window [mem 
0x78000000-0x8fffffff]: assigned
[34386.046664] pci 0000:03:00.0: bridge window [mem 
0x7800000000-0x87ffffffff 64bit pref]: assigned
[34386.046666] pci 0000:03:00.0: bridge window [io 0x6000-0xafff]: assigned
[34386.046671] pci 0000:04:00.0: bridge window [mem 
0x78000000-0x780fffff]: assigned
[34386.046673] pci 0000:04:00.0: bridge window [mem 
0x7800000000-0x78000fffff 64bit pref]: assigned
[34386.046676] pci 0000:04:01.0: bridge window [mem 
0x78100000-0x7fffffff]: assigned
[34386.046678] pci 0000:04:01.0: bridge window [mem 
0x7800100000-0x7d554fffff 64bit pref]: assigned
[34386.046681] pci 0000:04:02.0: bridge window [mem 
0x80000000-0x87efffff]: assigned
[34386.046683] pci 0000:04:02.0: bridge window [mem 
0x7d55500000-0x82aa8fffff 64bit pref]: assigned
[34386.046685] pci 0000:04:03.0: bridge window [mem 
0x87f00000-0x8fdfffff]: assigned
[34386.046688] pci 0000:04:03.0: bridge window [mem 
0x82aa900000-0x87ffcfffff 64bit pref]: assigned
[34386.046690] pci 0000:04:04.0: bridge window [mem 
0x8fe00000-0x8fefffff]: assigned
[34386.046692] pci 0000:04:04.0: bridge window [mem 
0x87ffd00000-0x87ffdfffff 64bit pref]: assigned
[34386.046695] pci 0000:04:00.0: bridge window [io 0x6000-0x6fff]: assigned
[34386.046697] pci 0000:04:01.0: bridge window [io 0x7000-0x7fff]: assigned
[34386.046699] pci 0000:04:02.0: bridge window [io 0x8000-0x8fff]: assigned
[34386.046701] pci 0000:04:03.0: bridge window [io 0x9000-0x9fff]: assigned
[34386.046703] pci 0000:04:04.0: bridge window [io 0xa000-0xafff]: assigned
[34386.046706] pci 0000:04:00.0: PCI bridge to [bus 05]
[34386.046715] pci 0000:04:00.0:   bridge window [io 0x6000-0x6fff]
[34386.046722] pci 0000:04:00.0:   bridge window [mem 0x78000000-0x780fffff]
[34386.046727] pci 0000:04:00.0:   bridge window [mem 
0x7800000000-0x78000fffff 64bit pref]
[34386.046735] pci 0000:04:01.0: PCI bridge to [bus 06-24]
[34386.046739] pci 0000:04:01.0:   bridge window [io 0x7000-0x7fff]
[34386.046745] pci 0000:04:01.0:   bridge window [mem 0x78100000-0x7fffffff]
[34386.046750] pci 0000:04:01.0:   bridge window [mem 
0x7800100000-0x7d554fffff 64bit pref]
[34386.046759] pci 0000:04:02.0: PCI bridge to [bus 25-43]
[34386.046762] pci 0000:04:02.0:   bridge window [io 0x8000-0x8fff]
[34386.046769] pci 0000:04:02.0:   bridge window [mem 0x80000000-0x87efffff]
[34386.046774] pci 0000:04:02.0:   bridge window [mem 
0x7d55500000-0x82aa8fffff 64bit pref]
[34386.046783] pci 0000:04:03.0: PCI bridge to [bus 44-60]
[34386.046786] pci 0000:04:03.0:   bridge window [io 0x9000-0x9fff]
[34386.046793] pci 0000:04:03.0:   bridge window [mem 0x87f00000-0x8fdfffff]
[34386.046798] pci 0000:04:03.0:   bridge window [mem 
0x82aa900000-0x87ffcfffff 64bit pref]
[34386.046807] pci 0000:04:04.0: PCI bridge to [bus 61]
[34386.046810] pci 0000:04:04.0:   bridge window [io 0xa000-0xafff]
[34386.046817] pci 0000:04:04.0:   bridge window [mem 0x8fe00000-0x8fefffff]
[34386.046822] pci 0000:04:04.0:   bridge window [mem 
0x87ffd00000-0x87ffdfffff 64bit pref]
[34386.046831] pci 0000:03:00.0: PCI bridge to [bus 04-61]
[34386.046835] pci 0000:03:00.0:   bridge window [io 0x6000-0xafff]
[34386.046841] pci 0000:03:00.0:   bridge window [mem 0x78000000-0x8fffffff]
[34386.046847] pci 0000:03:00.0:   bridge window [mem 
0x7800000000-0x87ffffffff 64bit pref]
[34386.046855] pcieport 0000:00:03.1: PCI bridge to [bus 03-61]
[34386.046858] pcieport 0000:00:03.1:   bridge window [io 0x6000-0xafff]
[34386.046862] pcieport 0000:00:03.1:   bridge window [mem 
0x78000000-0x8fffffff]
[34386.046866] pcieport 0000:00:03.1:   bridge window [mem 
0x7800000000-0x87ffffffff 64bit pref]
[34386.047375] pcieport 0000:03:00.0: enabling device (0000 -> 0003)
[34386.047659] pcieport 0000:04:00.0: enabling device (0000 -> 0003)
[34386.047876] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.047943] pcieport 0000:04:01.0: enabling device (0000 -> 0003)
[34386.048087] pcieport 0000:04:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- 
LLActRep+
[34386.048364] pcieport 0000:04:02.0: enabling device (0000 -> 0003)
[34386.048514] pcieport 0000:04:02.0: pciehp: Slot #2 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- 
LLActRep+
[34386.048893] pcieport 0000:04:03.0: enabling device (0000 -> 0003)
[34386.049048] pcieport 0000:04:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- 
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- 
LLActRep+
[34386.049256] pcieport 0000:04:04.0: enabling device (0000 -> 0003)
[34386.104216] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.163230] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.215601] usb 6-1: new SuperSpeed Plus Gen 2x1 USB device number 9 
using xhci_hcd
[34386.217286] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.232470] usb 6-1: New USB device found, idVendor=8087, 
idProduct=0b40, bcdDevice=12.34
[34386.232476] usb 6-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[34386.232479] usb 6-1: Product: USB3.0 Hub
[34386.232482] usb 6-1: Manufacturer: Intel Corporation.
[34386.260862] hub 6-1:1.0: USB hub found
[34386.260921] hub 6-1:1.0: 4 ports detected
[34386.274306] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.292653] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.331244] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.344481] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.394401] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.399318] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.407674] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.460879] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.468066] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.513089] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.518788] usb 5-1.1: new low-speed USB device number 13 using xhci_hcd
[34386.523747] [drm] DMUB HPD RX IRQ callback: link_index=5
[34386.523758] [drm] Downstream port present 1, type 0
[34386.614181] [drm] DMUB HPD IRQ callback: link_index=5
[34386.614222] [drm] DPIA AUX failed on 0x0(1), error 7
[34386.638661] usb 5-1.1: New USB device found, idVendor=0451, 
idProduct=ace1, bcdDevice= 1.50
[34386.638666] usb 5-1.1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[34386.638669] usb 5-1.1: Product: TPS DMC Family
[34386.638672] usb 5-1.1: Manufacturer: Texas Instruments Inc
[34386.638674] usb 5-1.1: SerialNumber: 6F03401608BA75BD0440D2CEDE55E56
[34386.728796] usb 5-1.2: new high-speed USB device number 14 using xhci_hcd
[34386.826968] usb 5-1.2: New USB device found, idVendor=2109, 
idProduct=2822, bcdDevice= 7.d3
[34386.826973] usb 5-1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[34386.826976] usb 5-1.2: Product: USB2.0 Hub
[34386.826979] usb 5-1.2: Manufacturer: VIA Labs, Inc.
[34386.826981] usb 5-1.2: SerialNumber: 000000001
[34386.883791] hub 5-1.2:1.0: USB hub found
[34386.884241] hub 5-1.2:1.0: 4 ports detected
[34386.908812] amdgpu 0000:c1:00.0: [drm] enabling link 5 failed: 15
[34386.915861] usb 6-1.4: new SuperSpeed Plus Gen 2x1 USB device number 
10 using xhci_hcd
[34387.014579] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.015232] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.015962] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.016607] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.017253] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.017904] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.018566] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.019219] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.019882] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.020708] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.021356] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.022032] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.022688] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.023345] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.024005] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.024667] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.025367] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.026024] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.026680] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.027347] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.028009] [drm] DPIA AUX failed on 0x80(16), error 7
[34387.044584] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[34387.044587] [drm] DM_MST: DP14, 4-lane link detected
[34387.044591] [drm] DMUB HPD IRQ callback: link_index=5
[34387.044592] [drm] DMUB reported hpd status unchanged. link_index=5
[34387.078623] usb 6-1.4: New USB device found, idVendor=2109, 
idProduct=0822, bcdDevice= 7.d3
[34387.078629] usb 6-1.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[34387.078632] usb 6-1.4: Product: USB3.1 Hub
[34387.078634] usb 6-1.4: Manufacturer: VIA Labs, Inc.
[34387.078636] usb 6-1.4: SerialNumber: 000000001
[34387.105779] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[34387.105785] [drm] DM_MST: DP14, 4-lane link detected
[34387.105791] [drm] DMUB HPD IRQ callback: link_index=5
[34387.107897] hub 6-1.4:1.0: USB hub found
[34387.108135] hub 6-1.4:1.0: 4 ports detected
[34387.163951] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[34387.163961] [drm] DM_MST: DP14, 4-lane link detected
[34387.163970] [drm] DMUB HPD IRQ callback: link_index=5
[34387.163971] [drm] DMUB reported hpd status unchanged. link_index=5
[34387.220431] [drm] DM_MST: starting TM on aconnector: 0000000059a6282d 
[id: 122]
[34387.220440] [drm] DM_MST: DP14, 4-lane link detected
[34387.679335] usb 5-1.2.4: new high-speed USB device number 15 using 
xhci_hcd
[34387.814952] usb 5-1.2.4: New USB device found, idVendor=2109, 
idProduct=2822, bcdDevice= 7.e4
[34387.814960] usb 5-1.2.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[34387.814963] usb 5-1.2.4: Product: USB2.0 Hub
[34387.814965] usb 5-1.2.4: Manufacturer: VIA Labs, Inc.
[34387.814967] usb 5-1.2.4: SerialNumber: 000000001
[34387.875991] hub 5-1.2.4:1.0: USB hub found
[34387.876416] hub 5-1.2.4:1.0: 4 ports detected
[34387.907850] usb 6-1.4.1: new SuperSpeed USB device number 11 using 
xhci_hcd
[34387.926018] usb 6-1.4.1: New USB device found, idVendor=05e3, 
idProduct=0764, bcdDevice= 0.01
[34387.926026] usb 6-1.4.1: New USB device strings: Mfr=3, Product=4, 
SerialNumber=2
[34387.926029] usb 6-1.4.1: Product: USB Storage
[34387.926031] usb 6-1.4.1: Manufacturer: Generic
[34387.926033] usb 6-1.4.1: SerialNumber: 000000002959
[34387.940975] usb-storage 6-1.4.1:1.0: USB Mass Storage device detected
[34387.941359] scsi host0: usb-storage 6-1.4.1:1.0
[34388.034268] usb 6-1.4.4: new SuperSpeed Plus Gen 2x1 USB device 
number 12 using xhci_hcd
[34388.094278] usb 6-1.4.4: New USB device found, idVendor=2109, 
idProduct=0822, bcdDevice= 7.e4
[34388.094284] usb 6-1.4.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[34388.094286] usb 6-1.4.4: Product: USB3.1 Hub
[34388.094288] usb 6-1.4.4: Manufacturer: VIA Labs, Inc.
[34388.094289] usb 6-1.4.4: SerialNumber: 000000001
[34388.116580] hub 6-1.4.4:1.0: USB hub found
[34388.117021] hub 6-1.4.4:1.0: 4 ports detected
[34388.682353] usb 5-1.2.4.2: new high-speed USB device number 16 using 
xhci_hcd
[34388.830452] usb 5-1.2.4.2: New USB device found, idVendor=2109, 
idProduct=2822, bcdDevice= 7.d3
[34388.830460] usb 5-1.2.4.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[34388.830463] usb 5-1.2.4.2: Product: USB2.0 Hub
[34388.830466] usb 5-1.2.4.2: Manufacturer: VIA Labs, Inc.
[34388.830467] usb 5-1.2.4.2: SerialNumber: 000000001
[34388.867828] hub 5-1.2.4.2:1.0: USB hub found
[34388.868091] hub 5-1.2.4.2:1.0: 4 ports detected
[34388.899862] usb 6-1.4.4.2: new SuperSpeed Plus Gen 2x1 USB device 
number 13 using xhci_hcd
[34388.947946] scsi 0:0:0:0: Direct-Access     Generic MassStorageClass 
0001 PQ: 0 ANSI: 6
[34388.949927] scsi 0:0:0:1: Direct-Access     Generic MassStorageClass 
0001 PQ: 0 ANSI: 6
[34388.951151] sd 0:0:0:0: [sda] Media removed, stopped polling
[34388.951525] sd 0:0:0:0: [sda] Attached SCSI removable disk
[34388.952094] sd 0:0:0:1: [sdb] Media removed, stopped polling
[34388.952494] sd 0:0:0:1: [sdb] Attached SCSI removable disk
[34389.062870] usb 6-1.4.4.2: New USB device found, idVendor=2109, 
idProduct=0822, bcdDevice= 7.d3
[34389.062877] usb 6-1.4.4.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[34389.062879] usb 6-1.4.4.2: Product: USB3.1 Hub
[34389.062881] usb 6-1.4.4.2: Manufacturer: VIA Labs, Inc.
[34389.062882] usb 6-1.4.4.2: SerialNumber: 000000001
[34389.091963] hub 6-1.4.4.2:1.0: USB hub found
[34389.092300] hub 6-1.4.4.2:1.0: 4 ports detected
[34389.266290] usb 6-1.4.4.4: new SuperSpeed USB device number 14 using 
xhci_hcd
[34389.281550] usb 6-1.4.4.4: New USB device found, idVendor=30f3, 
idProduct=0419, bcdDevice=31.01
[34389.281562] usb 6-1.4.4.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=6
[34389.281564] usb 6-1.4.4.4: Product: USB 10/100/1000 LAN
[34389.281566] usb 6-1.4.4.4: Manufacturer: Realtek
[34389.281567] usb 6-1.4.4.4: SerialNumber: 1014E0A6A
[34389.300692] cdc_ether 6-1.4.4.4:2.0 eth0: register 'cdc_ether' at 
usb-0000:c3:00.3-1.4.4.4, CDC Ethernet Device, 80:6d:97:4e:0a:6a
[34389.662101] usb 5-1.2.4.2.2: new high-speed USB device number 17 
using xhci_hcd
[34389.795718] usb 5-1.2.4.2.2: New USB device found, idVendor=1397, 
idProduct=00d4, bcdDevice= 1.01
[34389.795730] usb 5-1.2.4.2.2: New USB device strings: Mfr=12, 
Product=7, SerialNumber=13
[34389.795735] usb 5-1.2.4.2.2: Product: X18/XR18
[34389.795737] usb 5-1.2.4.2.2: Manufacturer: BEHRINGER
[34389.795740] usb 5-1.2.4.2.2: SerialNumber: 592C3096
[34389.859793] usb 6-1.4.4.2.3: new SuperSpeed USB device number 15 
using xhci_hcd
[34389.925895] usb 5-1.2.4.2.2: Quirk or no altset; falling back to MIDI 1.0
[34390.109788] usb 6-1.4.4.2.3: New USB device found, idVendor=2109, 
idProduct=0812, bcdDevice= d.a1
[34390.109797] usb 6-1.4.4.2.3: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
[34390.109800] usb 6-1.4.4.2.3: Product: USB3.0 Hub
[34390.109803] usb 6-1.4.4.2.3: Manufacturer: VIA Labs, Inc.
[34390.131928] hub 6-1.4.4.2.3:1.0: USB hub found
[34390.132081] hub 6-1.4.4.2.3:1.0: 4 ports detected
[34390.228738] usb 5-1.2.4.2.3: new high-speed USB device number 18 
using xhci_hcd
[34390.372848] usb 5-1.2.4.2.3: New USB device found, idVendor=2109, 
idProduct=2812, bcdDevice= d.a0
[34390.372857] usb 5-1.2.4.2.3: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
[34390.372859] usb 5-1.2.4.2.3: Product: USB2.0 Hub
[34390.372862] usb 5-1.2.4.2.3: Manufacturer: VIA Labs, Inc.
[34390.436084] hub 5-1.2.4.2.3:1.0: USB hub found
[34390.437569] hub 5-1.2.4.2.3:1.0: 4 ports detected
[34390.572152] usb 5-1.2.4.2.4: new high-speed USB device number 19 
using xhci_hcd
[34390.741857] usb 5-1.2.4.2.4: New USB device found, idVendor=046d, 
idProduct=08e5, bcdDevice= 0.0c
[34390.741866] usb 5-1.2.4.2.4: New USB device strings: Mfr=0, 
Product=2, SerialNumber=0
[34390.741869] usb 5-1.2.4.2.4: Product: HD Pro Webcam C920
[34390.791412] usb 5-1.2.4.2.4: Found UVC 1.00 device HD Pro Webcam C920 
(046d:08e5)
[34390.806020] uvcvideo 5-1.2.4.2.4:1.1: Failed to set UVC probe control 
: -32 (exp. 26).
[34390.808739] usb 5-1.2.4.2.3.2: new full-speed USB device number 20 
using xhci_hcd
[34390.941583] usb 5-1.2.4.2.3.2: New USB device found, idVendor=046d, 
idProduct=c52b, bcdDevice=12.11
[34390.941592] usb 5-1.2.4.2.3.2: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
[34390.941595] usb 5-1.2.4.2.3.2: Product: USB Receiver
[34390.941598] usb 5-1.2.4.2.3.2: Manufacturer: Logitech
[34391.242059] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 24000
[34391.302093] logitech-djreceiver 0003:046D:C52B.000E: 
hiddev97,hidraw4: USB HID v1.11 Device [Logitech USB Receiver] on 
usb-0000:c3:00.3-1.2.4.2.3.2/input2
[34391.423939] input: Logitech MX Master 3 as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.2/5-1.2.4.2.3.2:1.2/0003:046D:C52B.000E/0003:046D:4082.000F/input/input28
[34391.456499] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 32000
[34391.498993] usb 5-1.2.4.2.3.4: new full-speed USB device number 21 
using xhci_hcd
[34391.598872] logitech-hidpp-device 0003:046D:4082.000F: input,hidraw5: 
USB HID v1.11 Keyboard [Logitech MX Master 3] on 
usb-0000:c3:00.3-1.2.4.2.3.2/input2:1
[34391.615590] usb 5-1.2.4.2.3.4: New USB device found, idVendor=24f0, 
idProduct=0140, bcdDevice= 1.00
[34391.615598] usb 5-1.2.4.2.3.4: New USB device strings: Mfr=1, 
Product=2, SerialNumber=0
[34391.615600] usb 5-1.2.4.2.3.4: Product: Das Keyboard
[34391.615602] usb 5-1.2.4.2.3.4: Manufacturer: Metadot - Das Keyboard
[34391.905327] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 32000
[34391.907921] input: Metadot - Das Keyboard Das Keyboard as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.4/5-1.2.4.2.3.4:1.0/0003:24F0:0140.0010/input/input29
[34391.978646] [drm] DMUB HPD RX IRQ callback: link_index=5
[34392.004686] [drm] DMUB HPD RX IRQ callback: link_index=5
[34392.132370] hid-generic 0003:24F0:0140.0010: input,hidraw6: USB HID 
v1.10 Keyboard [Metadot - Das Keyboard Das Keyboard] on 
usb-0000:c3:00.3-1.2.4.2.3.4/input0
[34392.139815] input: Metadot - Das Keyboard Das Keyboard System Control 
as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.4/5-1.2.4.2.3.4:1.1/0003:24F0:0140.0011/input/input30
[34392.192233] input: Metadot - Das Keyboard Das Keyboard Consumer 
Control as 
/devices/pci0000:00/0000:00:08.3/0000:c3:00.3/usb5/5-1/5-1.2/5-1.2.4/5-1.2.4.2/5-1.2.4.2.3/5-1.2.4.2.3.4/5-1.2.4.2.3.4:1.1/0003:24F0:0140.0011/input/input31
[34392.192325] hid-generic 0003:24F0:0140.0011: input,hidraw7: USB HID 
v1.10 Device [Metadot - Das Keyboard Das Keyboard] on 
usb-0000:c3:00.3-1.2.4.2.3.4/input1
[34392.225353] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 32000
[34392.513340] usb 5-1.2.4.2.4: current rate 16000 is different from the 
runtime rate 32000
[34393.024581] [drm] DMUB HPD RX IRQ callback: link_index=5
[34393.058723] [drm] DMUB HPD RX IRQ callback: link_index=5
[34393.107042] [drm] DMUB HPD RX IRQ callback: link_index=5
[34393.111600] [drm] DMUB HPD RX IRQ callback: link_index=5
[34397.103664] [drm] DMUB HPD RX IRQ callback: link_index=5
[34401.087234] [drm] DMUB HPD RX IRQ callback: link_index=5
[34401.104809] amdgpu 0000:c1:00.0: [drm] *ERROR* failed to lookup MSTB 
with lct 2, rad 00
[34401.106950] [drm] DMUB HPD RX IRQ callback: link_index=5
[34401.109590] amdgpu 0000:c1:00.0: [drm] *ERROR* failed to lookup MSTB 
with lct 2, rad 00
[34405.099183] [drm] DMUB HPD RX IRQ callback: link_index=5
[34409.059932] [drm] DMUB HPD RX IRQ callback: link_index=5
[34409.115495] EDID block 0 is all zeroes
[34409.115500] [drm:link_add_remote_sink [amdgpu]] *ERROR* Bad EDID, 
status3!
[34412.052608] [drm] DMUB HPD RX IRQ callback: link_index=5
[34412.069851] [drm] DMUB HPD RX IRQ callback: link_index=5
[34416.058980] [drm] DMUB HPD RX IRQ callback: link_index=5
[34416.071695] [drm] DMUB HPD RX IRQ callback: link_index=5
[34418.121897] [drm] DMUB HPD RX IRQ callback: link_index=5
[34418.143828] [drm] DMUB HPD RX IRQ callback: link_index=5
[34422.132221] [drm] DMUB HPD RX IRQ callback: link_index=5
[34422.144947] [drm] DMUB HPD RX IRQ callback: link_index=5
[34424.193145] [drm] DMUB HPD RX IRQ callback: link_index=5
[34424.213118] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.205473] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.250823] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.308784] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.311542] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.333216] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.391887] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.440701] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.445765] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.498174] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.553433] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.613225] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.667162] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.725137] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.771768] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.787186] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.847450] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.904678] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.926341] [drm] DMUB HPD RX IRQ callback: link_index=5
[34428.962714] [drm] DMUB HPD RX IRQ callback: link_index=5
[34429.016435] [drm] DMUB HPD RX IRQ callback: link_index=5
[34429.074925] [drm] DMUB HPD RX IRQ callback: link_index=5
[34431.082613] [drm] DMUB HPD RX IRQ callback: link_index=5
[34431.100957] [drm] DMUB HPD RX IRQ callback: link_index=5
[34435.068096] [drm] DMUB HPD RX IRQ callback: link_index=5
[34435.096107] [drm] DMUB HPD RX IRQ callback: link_index=5
[34437.105940] [drm] DMUB HPD RX IRQ callback: link_index=5
[34437.150271] [drm] DMUB HPD RX IRQ callback: link_index=5
[34441.145175] [drm] DMUB HPD RX IRQ callback: link_index=5
[34441.147139] amdgpu 0000:c1:00.0: [drm] *ERROR* failed to lookup MSTB 
with lct 2, rad 00
[34441.149235] [drm] DMUB HPD RX IRQ callback: link_index=5
[34441.188643] [drm] DMUB HPD RX IRQ callback: link_index=5
[34441.202840] amdgpu 0000:c1:00.0: [drm] *ERROR* failed to lookup MSTB 
with lct 2, rad 00
[34441.205145] [drm] DMUB HPD RX IRQ callback: link_index=5
[34443.741859] usb 5-1: USB disconnect, device number 12
[34443.741886] usb 5-1.1: USB disconnect, device number 13
[34443.742197] usb 5-1.2: USB disconnect, device number 14
[34443.742200] usb 5-1.2.4: USB disconnect, device number 15
[34443.742202] usb 5-1.2.4.2: USB disconnect, device number 16
[34443.742204] usb 5-1.2.4.2.2: USB disconnect, device number 17
[34443.743820] usb 5-1.2.4.2.3: USB disconnect, device number 18
[34443.743823] usb 5-1.2.4.2.3.2: USB disconnect, device number 20
[34443.749894] thunderbolt 0-0:2.1: retimer disconnected
[34443.752247] [drm] DMUB HPD IRQ callback: link_index=5
[34443.752373] [drm] DM_MST: stopping TM on aconnector: 0000000059a6282d 
[id: 122]
[34443.755273] thunderbolt 0-2: device disconnected
[34443.778961] usb 6-1: USB disconnect, device number 9
[34443.778966] usb 6-1.4: USB disconnect, device number 10
[34443.778969] usb 6-1.4.1: USB disconnect, device number 11
[34443.844632] pcieport 0000:00:03.1: pciehp: Slot(0): Card not present
[34443.846724] pci_bus 0000:05: busn_res: [bus 05] is released
[34443.846837] pci_bus 0000:06: busn_res: [bus 06-24] is released
[34443.846923] pci_bus 0000:25: busn_res: [bus 25-43] is released
[34443.846986] pci_bus 0000:44: busn_res: [bus 44-60] is released
[34443.847033] pci_bus 0000:61: busn_res: [bus 61] is released
[34443.847094] pci_bus 0000:04: busn_res: [bus 04-61] is released
[34444.045660] usb 6-1.4.4: USB disconnect, device number 12
[34444.045671] usb 6-1.4.4.2: USB disconnect, device number 13
[34444.045678] usb 6-1.4.4.2.3: USB disconnect, device number 15
[34444.068284] usb 6-1.4.4.4: USB disconnect, device number 14
[34444.069389] cdc_ether 6-1.4.4.4:2.0 eth0: unregister 'cdc_ether' 
usb-0000:c3:00.3-1.4.4.4, CDC Ethernet Device
[34444.196121] usb 5-1.2.4.2.3.4: USB disconnect, device number 21
[34444.772936] usb 5-1.2.4.2.4: USB disconnect, device number 19
[34446.141641] usb 1-4: reset full-speed USB device number 3 using xhci_hcd
[34446.444981] usb 1-4: reset full-speed USB device number 3 using xhci_hcd
[34450.798642] wlp1s0: disconnect from AP ac:8b:a9:28:2a:9a for new auth 
to ac:8b:a9:48:29:8b
[34451.082073] wlp1s0: authenticate with ac:8b:a9:48:29:8b (local 
address=a8:3b:76:72:df:d5)
[34451.098747] wlp1s0: send auth to ac:8b:a9:48:29:8b (try 1/3)
[34451.106261] wlp1s0: authenticated
[34451.127830] wlp1s0: associate with ac:8b:a9:48:29:8b (try 1/3)
[34451.192119] wlp1s0: RX ReassocResp from ac:8b:a9:48:29:8b 
(capab=0x1111 status=0 aid=3)
[34451.230509] wlp1s0: associated
[34451.230601] wlp1s0: Limiting TX power to 23 (23 - 0) dBm as 
advertised by ac:8b:a9:48:29:8b

PS: I've cc'd the folks who worked on the previous issue, as it's the 
same harware and software. Sorry, if I bothered you
PPS: I hope me writing here does not have to become a regular thing xD


