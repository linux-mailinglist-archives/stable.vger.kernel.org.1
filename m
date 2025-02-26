Return-Path: <stable+bounces-119584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295FBA45281
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 02:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A957E7A3096
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 01:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB519D081;
	Wed, 26 Feb 2025 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="T07tFiD8"
X-Original-To: stable@vger.kernel.org
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE51A5BAE;
	Wed, 26 Feb 2025 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.113.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535077; cv=none; b=iXf5ZmKopwnbgENwjmS4LGEiatkOYILCAbH/8i3i36d2nIRRcS0iW4g9Cw4/xhD7kOzfNK7aaM0BLumgkmm0wzuKuqW5N3vla144NMw6+6oZaHFDe7fwVllS6MP0zixxwMgVESs+nkkvkcXxrPxcSzKweAF9WVe50fHmEPwV6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535077; c=relaxed/simple;
	bh=A9ejl1O+HrZTCsb9J1JPq9c6GX36Sh+YgeDcLZTKdjY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tedtHhiK45hTw/ZRKm5QrrWFNVtAUZcXIogQswr380JNUwhcfslyRMQm8a26MBFti+FPGqTnGOUcC+WHdsLPO1CnsDsHT4orrmcngYYoaX+b8HJxfQOXNhIAkuVFBYzXmq6YxncdoPfFbHWCNk7MRJLNnGk5xcgVANFKf6VByGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=T07tFiD8; arc=none smtp.client-ip=217.182.113.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 7101B3E8A5;
	Wed, 26 Feb 2025 01:57:53 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 9E3634023E;
	Wed, 26 Feb 2025 01:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740535072; bh=A9ejl1O+HrZTCsb9J1JPq9c6GX36Sh+YgeDcLZTKdjY=;
	h=From:Subject:Date:To:Cc:From;
	b=T07tFiD8k3l+F1ihE5Y+v9JsjZTKcsFlbU0Jt61MrK7i4nAcoTug0UrTZCcly7mnK
	 zeIcc6jZR0Eu0Tc/fZWSIhjZMNhWUCOcxPKd64BKDicM44nJubx22MEMV2j5Ak3KDP
	 nzdbYJt5BzXhy+FaPBgf0GyWFzEIi57WYVPclEZo=
Received: from [172.29.0.32] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 90274404F6;
	Wed, 26 Feb 2025 01:57:42 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
Subject: [PATCH 0/5] drm/xe: enable driver usage on non-4KiB kernels
Date: Wed, 26 Feb 2025 09:57:31 +0800
Message-Id: <20250226-xe-non-4k-fix-v1-0-e61660b93cc3@aosc.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAt1vmcC/x2MQQqAIBAAvyJ7bsEW9dBXooPlVkugoRCC9Pek4
 wzMNCichQtMqkHmR4qk2GEcFGynjwejhM5AmqwmclgZY4poLtyloluJAwftrTPQmztz1/9vXt7
 3A+VGO45fAAAA
X-Change-ID: 20250226-xe-non-4k-fix-6b2eded0a564
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>, 
 Francois Dugast <francois.dugast@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Alan Previn <alan.previn.teres.alexis@intel.com>, 
 Zhanjun Dong <zhanjun.dong@intel.com>, 
 Matt Roper <matthew.d.roper@intel.com>, 
 Mateusz Naklicki <mateusz.naklicki@intel.com>
Cc: Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>, 
 =?utf-8?q?Zbigniew_Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Shang Yatsen <429839446@qq.com>, Mingcong Bai <jeffbai@aosc.io>, 
 stable@vger.kernel.org, Haien Liang <27873200@qq.com>, 
 Shirong Liu <lsr1024@qq.com>, Haofeng Wu <s2600cw2@126.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740535062; l=4506;
 i=jeffbai@aosc.io; s=20250225; h=from:subject:message-id;
 bh=A9ejl1O+HrZTCsb9J1JPq9c6GX36Sh+YgeDcLZTKdjY=;
 b=h1P5B1NsPwC752Eq4QwdLC/ar+9y08WwQAliWRHpeTAe2zGDgTLcx28irCVGWb4zz+NP3K1Vw
 UOoshffMQFlCNBgYA+DmqFPwV+PEJNnG+gn3zo/6ogCJXs4fFsl6D2A
X-Developer-Key: i=jeffbai@aosc.io; a=ed25519;
 pk=PShXLX1m130BHsde1t/EjBugyyOjSVdzV0dYuYejXYU=
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 9E3634023E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.14 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.04)[59.07%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MID_RHS_MATCH_FROM(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,429839446.qq.com:server fail,kexybiscuit.aosc.io:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_ENVRCPT(0.00)[126.com,gmail.com,qq.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,lists.freedesktop.org,vger.kernel.org,aosc.io,qq.com,126.com];
	TO_DN_SOME(0.00)[]

This patch series attempts to enable the use of xe DRM driver on non-4KiB
kernel page platforms. This involves fixing the ttm/bo interface, as well
as parts of the userspace API to make use of kernel `PAGE_SIZE' for
alignment instead of the assumed `SZ_4K', it also fixes incorrect usage of
`PAGE_SIZE' in the GuC and ring buffer interface code to make sure all
instructions/commands were aligned to 4KiB barriers (per the Programmer's
Manual for the GPUs covered by this DRM driver).

This issue was first discovered and reported by members of the LoongArch
user communities, whose hardware commonly ran on 16KiB-page kernels. The
patch series began on an unassuming branch of a downstream kernel tree
maintained by Shang Yatsen.[^1]

It worked well but remained sparsely documented, a lot of the work done
here relied on Shang Yatsen's original patch.

AOSC OS then picked it up[^2] to provide Intel Xe/Arc support for users of
its LoongArch port, for which I worked extensively on. After months of
positive user feedback and from encouragement from Kexy Biscuit, my
colleague at the community, I decided to examine its potential for
upstreaming, cross-reference kernel and Intel documentation to better
document and revise this patch.

Now that this series has been tested good (for boot up, OpenGL, and
playback of a standardised set of video samples[^3]... with the exception
of the Intel Arc B580, which seems to segfault at intel-media-driver -
iHD_drv_video.so, but strangely, hardware accelerated video playback works
well with Firefox?) on the following platforms (motherboard + GPU model):

- x86-64, 4KiB kernel page:
    - MS-7D42 + Intel Arc A580
- LoongArch, 16KiB kernel page:
    - XA61200 + GUNNIR DG1 Blue Halberd (Intel DG1)
    - XA61200 + ASRock Arc A380 Challenger ITX OC (Intel Arc 380)
    - XA61200 + Intel Arc 580
    - XA61200 + GUNNIR Intel Arc A750 Photon 8G OC (Intel Arc A750)
    - ASUS XC-LS3A6M + GUNNIR Intel Arc B580 INDEX 12G (Intel Arc B580)

On these platforms, basic functionalities tested good but the driver was
unstable with occasional resets (I do suspect however, that this platform
suffers from PCIe coherence issues, as instability only occurs under heavy
VRAM I/O load):

- AArch64, 4KiB/64KiB kernel pages:
    - ERUN-FD3000 (Phytium D3000) + GUNNIR Intel Arc A750 Photon 8G OC
      (Intel Arc A750)

I think that this patch series is now ready for your comment and review.
Please forgive me if I made any simple mistake or used wrong terminologies,
but I have never worked on a patch for the DRM subsystem and my experience
is still quite thin.

But anyway, just letting you all know that Intel Xe/Arc works on non-4KiB
kernel page platforms (and honestly, it's great to use, especially for
games and media playback)!

[^1]: https://github.com/FanFansfan/loongson-linux/tree/loongarch-xe
[^2]: We maintained Shang Yatsen's patch until our v6.13.3 tree, until
      we decided to test and send this series upstream,
      https://github.com/AOSC-Tracking/linux/tree/aosc/v6.13.3
[^3]: Delicious hot pot!
      https://repo.aosc.io/ahvl/sample-videos-20250223.tar.zst

Suggested-by: Kexy Biscuit <kexybiscuit@aosc.io>
Co-developed-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
Mingcong Bai (5):
      drm/xe/bo: fix alignment with non-4K kernel page sizes
      drm/xe/guc: use SZ_4K for alignment
      drm/xe/regs: fix RING_CTL_SIZE(size) calculation
      drm/xe: use 4K alignment for cursor jumps
      drm/xe/query: use PAGE_SIZE as the minimum page alignment

 drivers/gpu/drm/xe/regs/xe_engine_regs.h |  3 +--
 drivers/gpu/drm/xe/xe_bo.c               |  8 ++++----
 drivers/gpu/drm/xe/xe_guc.c              |  4 ++--
 drivers/gpu/drm/xe/xe_guc_ads.c          | 32 ++++++++++++++++----------------
 drivers/gpu/drm/xe/xe_guc_capture.c      |  8 ++++----
 drivers/gpu/drm/xe/xe_guc_ct.c           |  2 +-
 drivers/gpu/drm/xe/xe_guc_log.c          |  4 ++--
 drivers/gpu/drm/xe/xe_guc_pc.c           |  4 ++--
 drivers/gpu/drm/xe/xe_migrate.c          |  4 ++--
 drivers/gpu/drm/xe/xe_query.c            |  2 +-
 include/uapi/drm/xe_drm.h                |  2 +-
 11 files changed, 36 insertions(+), 37 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250226-xe-non-4k-fix-6b2eded0a564

Best regards,
-- 
Mingcong Bai <jeffbai@aosc.io>


