Return-Path: <stable+bounces-185472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C5BBD531D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B118A5915
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B327A10F;
	Mon, 13 Oct 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="p1SWyS1t"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C16264A8D;
	Mon, 13 Oct 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374086; cv=pass; b=kaBn8lzRxOOqM6KhQq5RPncV+yQKR2aaZg2d1OtMmLXDSpYbM3hsC8XyUGHiGysqq90nJeeQsb1o30iMgFWMos7WDAJqDrn56Kiq4Qv8Ml/iyqM2BzwohSsoowQqsSBUDsBGMSfi3roU+mD4Cyg3rB17+GbCimSzSrqSAfbMyzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374086; c=relaxed/simple;
	bh=Gjs+gzlQ8DSTcNMtgawxzJ+dyKA291xol+oPw+VwlqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+Seh5PVWKanEQQM1Sh/ZNUPE1ZNDmjcUTfqxF462T2TCRuS9k0pR3haSJHnZ9l7UXLJoq7sgFBvq4ICrpFkTEshYDDyZqnm1/TGLA+NyQGmnUNWpHfUGelB8S2xqnRF7FzNhebHv+4ofbZftnly0SHyUSRwRFIlZPGnFTto0qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=p1SWyS1t; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760374071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CcSvilBHdOmvFLGUeUyw2QLYn3G0RaJrwCaFRfp6vPZZ938nNva1t/ta87MWRrbO4fqeut2EkrmrrJyuE+++TNc/PN3cO5RcBSf0V6jbmJTkagKq735iYz/zPZnMnWhSJSCXmy3+5U71RFZC7BUD65ns59imFr0kE8BwoHROVHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760374071; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TOda1Z7snsIxBjSh27hmk/EzkMek96gsqlQJrQUA3Xs=; 
	b=ehDNHq7pBuHZIkhUALDvXwG0l5irSAbnnNwqzDyxdQID6wN2eSd7xIuupYwMAq58xmecd/YNKqgP5L/pDfn9L5EPSERe3qYGl8yonbAkeb0XhmLQVdZwEvMw2NGaXSTcR/XqevmVmyehDQbEPXGg+PAo4BdG5gs1pHO5XSookQU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760374071;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TOda1Z7snsIxBjSh27hmk/EzkMek96gsqlQJrQUA3Xs=;
	b=p1SWyS1t745pjsHRmNZ+K8zyrrD+RrFLlUn4nfcl2WdPT7OPlXa5lO5auXA7/NDR
	TxeRxk6H2Yb9weORUekS3xrrgk3uohDRld5sgU0PR7H06kX+GDQNZEWprPG0SBx4uKp
	+Z9WIS8bL+GXHW5+pb9j5XNXbLwnoqdv3TCT0GWc=
Received: by mx.zohomail.com with SMTPS id 1760374068043429.87704175723024;
	Mon, 13 Oct 2025 09:47:48 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Rong Zhang <i@rong.moe>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix NULL deref in debugfs odm_combine_segments
Date: Tue, 14 Oct 2025 00:47:35 +0800
Message-ID: <20251013164742.24660-1-i@rong.moe>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When a connector is connected but inactive (e.g., disabled by desktop
environments), pipe_ctx->stream_res.tg will be destroyed. Then, reading
odm_combine_segments causes kernel NULL pointer dereference.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 16 UID: 0 PID: 26474 Comm: cat Not tainted 6.17.0+ #2 PREEMPT(lazy)  e6a17af9ee6db7c63e9d90dbe5b28ccab67520c6
 Hardware name: LENOVO 21Q4/LNVNB161216, BIOS PXCN25WW 03/27/2025
 RIP: 0010:odm_combine_segments_show+0x93/0xf0 [amdgpu]
 Code: 41 83 b8 b0 00 00 00 01 75 6e 48 98 ba a1 ff ff ff 48 c1 e0 0c 48 8d 8c 07 d8 02 00 00 48 85 c9 74 2d 48 8b bc 07 f0 08 00 00 <48> 8b 07 48 8b 80 08 02 00>
 RSP: 0018:ffffd1bf4b953c58 EFLAGS: 00010286
 RAX: 0000000000005000 RBX: ffff8e35976b02d0 RCX: ffff8e3aeed052d8
 RDX: 00000000ffffffa1 RSI: ffff8e35a3120800 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ffff8e3580eb0000 R09: ffff8e35976b02d0
 R10: ffffd1bf4b953c78 R11: 0000000000000000 R12: ffffd1bf4b953d08
 R13: 0000000000040000 R14: 0000000000000001 R15: 0000000000000001
 FS:  00007f44d3f9f740(0000) GS:ffff8e3caa47f000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000006485c2000 CR4: 0000000000f50ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  seq_read_iter+0x125/0x490
  ? __alloc_frozen_pages_noprof+0x18f/0x350
  seq_read+0x12c/0x170
  full_proxy_read+0x51/0x80
  vfs_read+0xbc/0x390
  ? __handle_mm_fault+0xa46/0xef0
  ? do_syscall_64+0x71/0x900
  ksys_read+0x73/0xf0
  do_syscall_64+0x71/0x900
  ? count_memcg_events+0xc2/0x190
  ? handle_mm_fault+0x1d7/0x2d0
  ? do_user_addr_fault+0x21a/0x690
  ? exc_page_fault+0x7e/0x1a0
  entry_SYSCALL_64_after_hwframe+0x6c/0x74
 RIP: 0033:0x7f44d4031687
 Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00>
 RSP: 002b:00007ffdb4b5f0b0 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 00007f44d3f9f740 RCX: 00007f44d4031687
 RDX: 0000000000040000 RSI: 00007f44d3f5e000 RDI: 0000000000000003
 RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 00007f44d3f5e000
 R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000040000
  </TASK>
 Modules linked in: tls tcp_diag inet_diag xt_mark ccm snd_hrtimer snd_seq_dummy snd_seq_midi snd_seq_oss snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device x>
  snd_hda_codec_atihdmi snd_hda_codec_realtek_lib lenovo_wmi_helpers think_lmi snd_hda_codec_generic snd_hda_codec_hdmi snd_soc_core kvm snd_compress uvcvideo sn>
  platform_profile joydev amd_pmc mousedev mac_hid sch_fq_codel uinput i2c_dev parport_pc ppdev lp parport nvme_fabrics loop nfnetlink ip_tables x_tables dm_cryp>
 CR2: 0000000000000000
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:odm_combine_segments_show+0x93/0xf0 [amdgpu]
 Code: 41 83 b8 b0 00 00 00 01 75 6e 48 98 ba a1 ff ff ff 48 c1 e0 0c 48 8d 8c 07 d8 02 00 00 48 85 c9 74 2d 48 8b bc 07 f0 08 00 00 <48> 8b 07 48 8b 80 08 02 00>
 RSP: 0018:ffffd1bf4b953c58 EFLAGS: 00010286
 RAX: 0000000000005000 RBX: ffff8e35976b02d0 RCX: ffff8e3aeed052d8
 RDX: 00000000ffffffa1 RSI: ffff8e35a3120800 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ffff8e3580eb0000 R09: ffff8e35976b02d0
 R10: ffffd1bf4b953c78 R11: 0000000000000000 R12: ffffd1bf4b953d08
 R13: 0000000000040000 R14: 0000000000000001 R15: 0000000000000001
 FS:  00007f44d3f9f740(0000) GS:ffff8e3caa47f000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000006485c2000 CR4: 0000000000f50ef0
 PKRU: 55555554

Fix this by checking pipe_ctx->stream_res.tg before dereferencing.

Fixes: 07926ba8a44f ("drm/amd/display: Add debugfs interface for ODM combine info")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index f263e1a4537e1..00dac862b665a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1302,7 +1302,8 @@ static int odm_combine_segments_show(struct seq_file *m, void *unused)
 	if (connector->status != connector_status_connected)
 		return -ENODEV;
 
-	if (pipe_ctx != NULL && pipe_ctx->stream_res.tg->funcs->get_odm_combine_segments)
+	if (pipe_ctx && pipe_ctx->stream_res.tg &&
+	    pipe_ctx->stream_res.tg->funcs->get_odm_combine_segments)
 		pipe_ctx->stream_res.tg->funcs->get_odm_combine_segments(pipe_ctx->stream_res.tg, &segments);
 
 	seq_printf(m, "%d\n", segments);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


