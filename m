Return-Path: <stable+bounces-144759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED55ABB9AC
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C005A1B600C0
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF0726FA5F;
	Mon, 19 May 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrSSE7Fw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6D1C700D;
	Mon, 19 May 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646781; cv=none; b=qH5PZEZTqhBvpzPHJBvgMA14Y6TngQzFwJLAk+sFepPF9f5lbguVwp4eMhG7ipK0gXAv9ghgfKc7qbvIv5CTUDnHLXNEjGWgbHgdTSkXLJMfXktj/6V+jDuyJ0+Gm4coSP2y7T2Xq11Ndl5R75/Hf2qM2yMOGCriNFY0rpmb7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646781; c=relaxed/simple;
	bh=qC08lU7xZHju3fiXKtcFgwzB0nAIU8FpltPGEFX7uXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbsEnlvjHH4WORa+7O4L7MOFw6tE4dsmpxnHnRFo6BreHxNgGwtBgmE3agsxz4SmjjRPhMzM1BL2MHR08i27AXnagDZCotaOtkYZrCQVhiWzeMKZpq+WdLjoingPQZmo3McnlPkWYzQqQ1JRHY54nOK0aiFGY4U7mWo8htzBkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrSSE7Fw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af5085f7861so2672910a12.3;
        Mon, 19 May 2025 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747646778; x=1748251578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Asy1WUWIQLYQEaitmMDflq2qUpTALFO8TCo/y+sY1lo=;
        b=VrSSE7Fw0PzWtgnMi83PJ0tekLq15MlpxSIWrpoLBCekMppRftADjWXl6XjidlI+IR
         ay8AbY9RvJhdny4dGVUQa2k77/lUWMuGPjjjnOWjLntKL/gCxhmiyeq+6xrUb4t+EwNz
         amlGmulBBJ4QZxIUo+LQNADdomASecz7r1l+i8R4sBMuvovny1YBYRGUjug6taNq9R6W
         oZ7+DVPTJmDpPCAdPyKV/PI1JwQfxPeuY6CbexSB79BxxQLH7l4jCMuOwryL/oxmdn6c
         u6yYZgaV7bKl52f1NfY89qVd3W0ot8c+x6X5+9Jr2R1YP9/RpkrfaRh5B0Khj62MR4Jy
         Mfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747646778; x=1748251578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Asy1WUWIQLYQEaitmMDflq2qUpTALFO8TCo/y+sY1lo=;
        b=DwvP0ubF5ckLevCwxi8iBAV0r34iu5OpAcRPK/wb+r+KNtId5WyzkklU1T2i3lRhhx
         PZQRi3aVYWzny8Be9/zXy/98HXtWdn5oN3QtgwhY+3nhdbzaGxp2NEkhu/LR6SdUBnXZ
         ijOLHWlUgUxUrHd+08Ai0RZ+4wWoBffZweD91V06foIVIYXODd6TExxLcx4SFG3M9Qri
         M61vehDCwyigSsr/B3fXoXGend47ZrGZHJus5knm3g5QT6k6UHE3jHwQ/gy6u6nZ3zvk
         9bEMeFoYpDqbv4U0vZGkSt3bh9HMlZ2wPcCRlmAc46KMKhEdlVT1Wve+eo1vhE0OjU7A
         0FcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSqAV1sjFDzNQwV+92mBEYHNIK50d4pwUMmTpPUvLj1cOOJVUBt94kGBMt4wpLtT80cSbChbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JSDvAoP6gq84yOfZTpN0Cj4KYKPv7jsvdd0MuXRhYCCXcrsU
	qvDKzkZggZmxfcyh9vcFVJkrv6KXR5sG1RvWW3cbbobPP0fFQpKsoN2h
X-Gm-Gg: ASbGncsX9vTd65hsSlE1Gn/3SroxjFS/UV18ILvc+onhAhjwpcuD+OjFy1VbCxvMtzx
	N7VF8I3/Gdxt4BbQI63y8VoTTGoZt/UfRNZsLF1o+ziH6TbGjp5W8I9NsUDuP3VvSleJPqF4QZT
	TVmwN1q7x1rNP+wyXvYKBj7HmB0qYo3DRj/H4E/qnfEZmj52QwaOSoE1OnrLzWDp1VMvtDWufgR
	PRrGq1LCkCa9aHNknacFf3nn4nkXhjJZNBjTx0mtQcEoVIjB7gBt48XOSeF/JZRBFdCqnTIU8lc
	RIo7+/wp9YtJOOakCA5fkrcBeuhUhu63gHL27toF3F8plyrHHJTM2nh11IT5G8qmAcJX6o4ScZp
	xN/o=
X-Google-Smtp-Source: AGHT+IGIDhMQe6eQf6jjqtfEsQKpB13xxHIOF3DYrNUhHik/vum5ZWdTsFTghx7xgKgAl6fYYemdtw==
X-Received: by 2002:a17:902:ecd2:b0:224:2384:5b40 with SMTP id d9443c01a7336-231de31b3dbmr187668735ad.24.1747646777725;
        Mon, 19 May 2025 02:26:17 -0700 (PDT)
Received: from pc-lmm.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97dcesm55540675ad.121.2025.05.19.02.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:26:17 -0700 (PDT)
From: limingming3 <limingming890315@gmail.com>
X-Google-Original-From: limingming3 <limingming3@lixiang.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	limingming3@lixiang.com
Subject: [PATCH] sched/eevdf: avoid pick_eevdf() returns NULL
Date: Mon, 19 May 2025 17:25:39 +0800
Message-ID: <20250519092540.3932826-1-limingming3@lixiang.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pick_eevdf() may return NULL, which would triggers NULL pointer
dereference and crash when best and curr are both NULL.

There are two cases when curr would be NULL:
	1) curr is NULL when enter pick_eevdf
	2) we set it to NUll when curr is not on_rq or eligible.

And when we went to the best = curr flow, the se should never be NULL,
So when best and curr are both NULL, we'd better set best = se to avoid
return NULL.

Below crash is what I encounter very low probability on our server and
I have not reproduce it, and I also found other people feedback some
similar crash on lore. So believe the issue is really exit.

<1>[    8.607396] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000a0
<1>[    8.607399] Mem abort info:
<1>[    8.607400]   ESR = 0x0000000096000004
<1>[    8.607401]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[    8.607402]   SET = 0, FnV = 0
<1>[    8.607403]   EA = 0, S1PTW = 0
<1>[    8.607403]   FSC = 0x04: level 0 translation fault
<1>[    8.607404] Data abort info:
<1>[    8.607404]   ISV = 0, ISS = 0x00000004
<1>[    8.607404]   CM = 0, WnR = 0
<1>[    8.607405] user pgtable: 4k pages, 48-bit VAs, pgdp=000000011efef000
<1>[    8.607406] [00000000000000a0] pgd=0000000000000000, p4d=0000000000000000
<0>[    8.607409] Internal error: Oops: 0000000096000004 [#1] PREEMPT_RT SMP
<4>[    8.607412] Modules linked in: tegradisp(O) sch_ingress xt_tcpudp iptable_filter 8021q garp mrp um_heap(O) nvhost_isp5(O) spidev nvhost_vi5(O) bridge nvhost_nvcsi_t194(O) tegra_capture_isp(O) tegra210_adma stp llc nvhost_capture(O) tegra_aconnect watchdog_tegra_t18x(O) spi_tegra114 tegra_camera(O) v4l2_dv_timings v4l2_fwnode v4l2_async videobuf2_dma_contig tegra_drm(O) cpuidle_tegra_auto(O) nvhost_nvcsi(O) nvhost_nvdla(O) tegra_camera_platform(O) drm_dp_aux_bus camchar(O) capture_ivc(O) cec videobuf2_v4l2 camera_diagnostics(O) snd_soc_tegra_virt_t210ref_pcm(O) drm_display_helper videobuf2_memops rtcpu_debug(O) snd_soc_tegra210_virt_alt_adsp(O) videobuf2_common drm_kms_helper videodev nvadsp(O) cdi_mgr(O) nvhost_pva(O) cdi_pwm(O) isc_mgr(O) sha3_ce isc_pwm(O) sha3_generic cdi_dev(O) sha512_ce lm90 snd_soc_tegra210_virt_alt_admaif(O) tegra_bpmp_thermal sha512_arm64 tegra_hv_vcpu_yield(O) tegra_hv_pm_ctl(O) cam_fsync(O) cdi_gpio(O) ukl(O) isc_dev(O) mc tegra_camera_rtcpu(O)
<4>[    8.607458]  board_id_driver(O) tegra_fsicom(O) isc_gpio(O) ivc_bus(O) hsp_mailbox_client(O) nvhwpm(O) host1x_nvhost(O) nvgpu(O) mc_utils(O) nvmap(O) hvc_sysfs(O) tegra_nvvse_cryptodev(O) tegra_hv_vse_safety(O) host1x_fence(O) host1x(O) nvsciipc(O) userspace_ivc_mempool(O) ivc_cdev(O) logger(O) drm fuse ip_tables x_tables nvme nvme_core hashed_ecid(O) oak_pci(O) nvethernet(O) nvpps(O) tegra_bpmp(O) tegra_vblk(O) li_osdump(O) tegra_hv_vblk_oops(O)
<4>[    8.607479] CPU: 9 PID: 1300 Comm: R000000007400 Tainted: G        W  O       6.1.119-rt45-prod-rt-tegra #1
<4>[    8.607481] Hardware name: p3960-0010 (DT)
<4>[    8.607482] pstate: 224000c5 (nzCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
<4>[    8.607483] pc : pick_next_task_fair+0x98/0x490
<4>[    8.607490] lr : pick_next_task_fair+0x98/0x490
<4>[    8.607490] sp : ffff800021bdb1b0
<4>[    8.607491] x29: ffff800021bdb1b0 x28: ffff0000836205c0 x27: 0000000000001000
<4>[    8.607492] x26: d8e0d16df7b8e848 x25: ffff000e881b6dc0 x24: ffff000e881b6dc0
<4>[    8.607494] x23: ffff800021bdb268 x22: ffff000e881b6d40 x21: ffff000083620000
<4>[    8.607495] x20: ffff000e881b6dc0 x19: ffff000e881b6d40 x18: 00000000000005c8
<4>[    8.607496] x17: 0000000000000000 x16: ffffd16df7896b40 x15: 0000000000000000
<4>[    8.607497] x14: 0000000000000014 x13: ffff800021bdba90 x12: ffff0000b052f300
<4>[    8.607498] x11: 00000000c425686b x10: 00000002010a4ab3 x9 : ffffd16df6ca7778
<4>[    8.607499] x8 : ffff800021bdb390 x7 : 0000000000000000 x6 : 0000000000000002
<4>[    8.607500] x5 : 0000000000000003 x4 : 0000000000000003 x3 : 0ab3e2bc8934c987
<4>[    8.607501] x2 : ffff000085241ec0 x1 : 0abe8499696457cc x0 : 0000000000000000
<4>[    8.607503] Call trace:
<4>[    8.607503]  pick_next_task_fair+0x98/0x490
<4>[    8.607505]  __schedule+0x16c/0x870
<4>[    8.607511]  schedule_rtlock+0x28/0x60
<4>[    8.607513]  rtlock_slowlock_locked+0x3a0/0xcf0
<4>[    8.607515]  rt_spin_lock+0xb0/0xe0
<4>[    8.607516]  __wake_up_common_lock+0x68/0xe0
<4>[    8.607519]  __wake_up_sync_key+0x28/0x50
<4>[    8.607520]  sock_def_readable+0x48/0xa0
<4>[    8.607523]  __udp_enqueue_schedule_skb+0x158/0x2e0
<4>[    8.607527]  udp_queue_rcv_one_skb+0x1f8/0x6f0
<4>[    8.607529]  udp_queue_rcv_skb+0x64/0x290
<4>[    8.607531]  __udp4_lib_rcv+0x654/0x980
<4>[    8.607532]  udp_rcv+0x28/0x40
<4>[    8.607533]  ip_protocol_deliver_rcu+0x40/0x1d0
<4>[    8.607538]  ip_local_deliver_finish+0x84/0xe0
<4>[    8.607540]  ip_local_deliver+0x84/0x130
<4>[    8.607542]  ip_rcv+0x78/0x150
<4>[    8.607544]  __netif_receive_skb_one_core+0x60/0xb0
<4>[    8.607548]  __netif_receive_skb+0x20/0x80
<4>[    8.607549]  process_backlog+0xcc/0x1a0
<4>[    8.607551]  __napi_poll.constprop.0+0x40/0x230
<4>[    8.607552]  net_rx_action+0x13c/0x310
<4>[    8.607553]  handle_softirqs.isra.0+0x118/0x3a0
<4>[    8.607556]  __local_bh_enable_ip+0x8c/0x110
<4>[    8.607556]  netif_rx+0xf4/0x1d0
<4>[    8.607558]  dev_loopback_xmit+0x88/0x170
<4>[    8.607559]  ip_mc_finish_output+0x7c/0x180
<4>[    8.607561]  ip_mc_output+0x338/0x350
<4>[    8.607562]  ip_send_skb+0x58/0x130
<4>[    8.607563]  udp_send_skb+0x11c/0x3d0
<4>[    8.607564]  udp_sendmsg+0x794/0x9d0
<4>[    8.607566]  inet_sendmsg+0x4c/0xa0
<4>[    8.607568]  __sock_sendmsg+0x64/0x80
<4>[    8.607572]  __sys_sendto+0x114/0x170
<4>[    8.607573]  __arm64_sys_sendto+0x30/0x50
<4>[    8.607575]  invoke_syscall+0x50/0x140
<4>[    8.607579]  el0_svc_common.constprop.0+0x4c/0x110
<4>[    8.607581]  do_el0_svc+0x2c/0x90
<4>[    8.607583]  el0_svc+0x2c/0xa0
<4>[    8.607585]  el0t_64_sync_handler+0x124/0x130
<4>[    8.607586]  el0t_64_sync+0x190/0x194
<0>[    8.607589] Code: 97fff1ee 37000200 aa1403e0 97ffddc7 (f9405014)
<4>[    8.607596] ---[ end trace 0000000000000000 ]---

Signed-off-by: limingming3 <limingming3@lixiang.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0fb9bf995a47..7fd867d6b62d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -978,7 +978,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	}
 found:
 	if (!best || (curr && entity_before(curr, best)))
-		best = curr;
+		best = curr ? curr : se;
 
 	return best;
 }
-- 
2.48.1


