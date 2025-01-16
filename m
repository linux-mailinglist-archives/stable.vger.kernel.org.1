Return-Path: <stable+bounces-109260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA786A139CA
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 13:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F37E3A4D29
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB571DE3D9;
	Thu, 16 Jan 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f6f2ixGi"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC101DE2CA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029821; cv=none; b=BF3KButpeyOAkyhvn82qrFrKW786ngAXkawUf6HkL7E/SCz1eR4iKSvrw1wZi2mqREK3SLr3Yd0KPUl2NPQrUwnzHPPOaDJ6Xx0wErw32hzAcTWy+VtyGK0iGWjLLYVlfLoJlphw0CRtMiboSYUm0brHjyixvdBXWLRDa32i5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029821; c=relaxed/simple;
	bh=euoQa3KZyVqNePae6UQAw3rSSTMb9rovghnJmjRpmOs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aorboovLfqfLHxrn2VTdpGV2sbXFDPGztx7RnMIMvJQ0DUp/gDkF1fBEVEfvkEkWyympithJIajonewdg+YEyu9W5+QuBxsfFqnHrtFqn/aOiZjmz//SX6tvcyks/HJdKoHuGDesr+L/Zg1l0wAK1L12Gbava3Hm/WDuVao6IHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f6f2ixGi; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737029809; bh=UHxuv1t4BOfs+IWO2Yg2FYYCGG1mgiodfFw8rEypJsk=;
	h=From:To:Cc:Subject:Date;
	b=f6f2ixGitPN4Tc4i4R+DuDACeZl7mK0QFEVmF4G4qW9/ydm7ObkpYCNo5RIHoqzvx
	 +Zcbt/HLRP3Mp/Y/DvacRkFkFJsps93LOqF2DDxFYCK4ykjVxxC42qQx/T7d3qVXVW
	 17xjnTQ+HVEsxll7xBoPMBE5sfp49qsoZqcGZCNo=
Received: from my-pc.corp.ad.wrs.com ([120.244.194.130])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 20E204B7; Thu, 16 Jan 2025 20:08:14 +0800
X-QQ-mid: xmsmtpt1737029294t3zo7p8um
Message-ID: <tencent_A6264C7FC305AD420DEF47932496B5150E06@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCt7fCwrIruHEMhL8utDGPZy2NXRLq6OOzXDvB9t2E0H+7jmSQSsZ
	 fow6SKrm6XKaOESL1y2ayAns8dmdiVhoHwqXhf7mfwEy5IxrwBsdXkfHBZsHILvjPJ8jXHvSdItn
	 4fJDOqWUrjfbed2FNb4EwVSV6/FzGQJYCt0LNe+H4s2N7Zi4WbLES7XlKv2m686Z2/CUyAqX8lGC
	 aLt05s9Netfk5Tl5S6Yj08SsmeOiqrJ7PSe5Hq2/HInAtzK0CnVXLA26LpUC9t0nUe1TWGff6O5L
	 IoneS0Kg7DaibXwYPY+aeI52Hvf7lIJ7sZ4w8kRdZErI/QMvObOryn+D30DTtlRqRWSW0JSJQIPs
	 dRXET6hoxyrkl9YtEhcayDQqpzPScWTimmMB2UCyIyFNxizBTcJv/N8GF3FoHi3rREmPBa9bpAzY
	 p/MnSxAf+hxszOjy7GqK/pabdApdh0MyTZuoiHdYWA9t9lKXgGgNnwGdXkj952ByLFPEyA8d6pb9
	 AQSUhs3d3Q5vBEwHw10zTd42GOnzVU/8j+vMTVA/HVJpEX+YJORs/PW/zGJ3hjM9qYJLKhb4Zl5B
	 kmXmN0NSxXAgiwMbWHKUUzevqWNF1wj9vsN1+/OtHWM34jEVbpaCXHn1aHNzUoi6UBztEp9W9KSv
	 YapRGPG5ddopv/UQhjA7WjA6xFqBhRlPyFw5yRtGtF9k9b4zxbSBai+k/VsHsw4aXuFqy01Y6YFW
	 LZ//DsBojXFWeLc1LjgYDObtp5WOrTgF6Z/K3UAfDwdCYfEWK/JqzqXm0fmhQLGx4fE5RTy5UBCM
	 SrCb1F0Y99OWlDwfQiSca3UDGHjLiVADPwDdMB6vWdpcaaX/mjP6dY9ujpzKGXY6IC3cmV2tGLbU
	 qPU6OPtxmja5wTLd2AByBBUR7Yj0GwImmjcqv6pQmgQfd9XwgLAocmj706mWbuagZVTCKVa963Q6
	 pk1kBoPupWUhwF0j6EYAXmHfHn+DYx773VwoEgLOcb0zednqOEZ6QZN6ma/UJoZHkus/3FLvVehI
	 T+5hDgBLiQwP0uSMT9OD5AeA7ZxtA=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 6.1.y] drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
Date: Thu, 16 Jan 2025 20:08:14 +0800
X-OQ-MSGID: <20250116120814.2815-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

commit 63de35a8fcfca59ae8750d469a7eb220c7557baf upstream.

An issue was identified in the dcn21_link_encoder_create function where
an out-of-bounds access could occur when the hpd_source index was used
to reference the link_enc_hpd_regs array. This array has a fixed size
and the index was not being checked against the array's bounds before
accessing it.

This fix adds a conditional check to ensure that the hpd_source index is
within the valid range of the link_enc_hpd_regs array. If the index is
out of bounds, the function now returns NULL to prevent undefined
behavior.

References:

[   65.920507] ------------[ cut here ]------------
[   65.920510] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn21/dcn21_resource.c:1312:29
[   65.920519] index 7 is out of range for type 'dcn10_link_enc_hpd_registers [5]'
[   65.920523] CPU: 3 PID: 1178 Comm: modprobe Tainted: G           OE      6.8.0-cleanershaderfeatureresetasdntipmi200nv2132 #13
[   65.920525] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS WMJ0429N_Weekly_20_04_2 04/29/2020
[   65.920527] Call Trace:
[   65.920529]  <TASK>
[   65.920532]  dump_stack_lvl+0x48/0x70
[   65.920541]  dump_stack+0x10/0x20
[   65.920543]  __ubsan_handle_out_of_bounds+0xa2/0xe0
[   65.920549]  dcn21_link_encoder_create+0xd9/0x140 [amdgpu]
[   65.921009]  link_create+0x6d3/0xed0 [amdgpu]
[   65.921355]  create_links+0x18a/0x4e0 [amdgpu]
[   65.921679]  dc_create+0x360/0x720 [amdgpu]
[   65.921999]  ? dmi_matches+0xa0/0x220
[   65.922004]  amdgpu_dm_init+0x2b6/0x2c90 [amdgpu]
[   65.922342]  ? console_unlock+0x77/0x120
[   65.922348]  ? dev_printk_emit+0x86/0xb0
[   65.922354]  dm_hw_init+0x15/0x40 [amdgpu]
[   65.922686]  amdgpu_device_init+0x26a8/0x33a0 [amdgpu]
[   65.922921]  amdgpu_driver_load_kms+0x1b/0xa0 [amdgpu]
[   65.923087]  amdgpu_pci_probe+0x1b7/0x630 [amdgpu]
[   65.923087]  local_pci_probe+0x4b/0xb0
[   65.923087]  pci_device_probe+0xc8/0x280
[   65.923087]  really_probe+0x187/0x300
[   65.923087]  __driver_probe_device+0x85/0x130
[   65.923087]  driver_probe_device+0x24/0x110
[   65.923087]  __driver_attach+0xac/0x1d0
[   65.923087]  ? __pfx___driver_attach+0x10/0x10
[   65.923087]  bus_for_each_dev+0x7d/0xd0
[   65.923087]  driver_attach+0x1e/0x30
[   65.923087]  bus_add_driver+0xf2/0x200
[   65.923087]  driver_register+0x64/0x130
[   65.923087]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   65.923087]  __pci_register_driver+0x61/0x70
[   65.923087]  amdgpu_init+0x7d/0xff0 [amdgpu]
[   65.923087]  do_one_initcall+0x49/0x310
[   65.923087]  ? kmalloc_trace+0x136/0x360
[   65.923087]  do_init_module+0x6a/0x270
[   65.923087]  load_module+0x1fce/0x23a0
[   65.923087]  init_module_from_file+0x9c/0xe0
[   65.923087]  ? init_module_from_file+0x9c/0xe0
[   65.923087]  idempotent_init_module+0x179/0x230
[   65.923087]  __x64_sys_finit_module+0x5d/0xa0
[   65.923087]  do_syscall_64+0x76/0x120
[   65.923087]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   65.923087] RIP: 0033:0x7f2d80f1e88d
[   65.923087] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
[   65.923087] RSP: 002b:00007ffc7bc1aa78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   65.923087] RAX: ffffffffffffffda RBX: 0000564c9c1db130 RCX: 00007f2d80f1e88d
[   65.923087] RDX: 0000000000000000 RSI: 0000564c9c1e5480 RDI: 000000000000000f
[   65.923087] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000002
[   65.923087] R10: 000000000000000f R11: 0000000000000246 R12: 0000564c9c1e5480
[   65.923087] R13: 0000564c9c1db260 R14: 0000000000000000 R15: 0000564c9c1e54b0
[   65.923087]  </TASK>
[   65.923927] ---[ end trace ]---

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
Backport to fix CVE-2024-56608
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-56608
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index ce6c70e25703..dd71ea2568e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1340,7 +1340,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.43.0


