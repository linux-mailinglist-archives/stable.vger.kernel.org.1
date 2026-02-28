Return-Path: <stable+bounces-220229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Px7OVw0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026521C5E34
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67DC230DE9C0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32F175A6E;
	Sat, 28 Feb 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5oBOAsb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB6175A64;
	Sat, 28 Feb 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300134; cv=none; b=m3UhnIlriwPLcwUJlMXgK4lbZGtHHn5dMjrGzcmIxbQWkujborMQTUxIJYsJAQ+kz+lnhbEKG1P7eztjb/Sj/4zlq1/FToW3Wout6zz46F2LzYMYBfMET8jRPpRXrO7uix3NpHx8nBOLfvNM4LhnqAjZXLJIABLI0WVKgr40Dk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300134; c=relaxed/simple;
	bh=9GRg/vEWRTZndN1XDb01T9HHR2UThmDcPOMlOFyB4SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7C8oWIPAv8XEE9pKr/bEm2xYJdIxBG7Lb5bNHOoEaaQxyUqQNGZGSSy9IRzQnq9K2OBzoz3DHXQPLnoKYP/RoJE88DjQrBdQ8PhnOhlzM0PQypefau5G87EovP9FAnfUEQr4E0FgM8EXiIlkwZG7yD94otjDzc6Mpv0xKxxRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5oBOAsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA8C116D0;
	Sat, 28 Feb 2026 17:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300134;
	bh=9GRg/vEWRTZndN1XDb01T9HHR2UThmDcPOMlOFyB4SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5oBOAsbbu8cN9k2Bsrb4acI8AQ5sXAy5HRHqeil5Mn5xwPF1/U0AsPOnV1MP4Suw
	 /btEgDLya1+KCjX1z9uF8RsLJHGFS36woYSb02mU9OnKI/V/5CU6ZuWgOjrhjyzH+0
	 7ND4CyBFnftMSwUwpD80yKJN4NvmLEwwemcYchYiOhjZrSvvXoP2ngzZBK1q7MPx6I
	 Fj4txk/wRWtTvrKk+eyEdw6CpLW0SmHKQQuOH/7lzfZc/27C69K5Re/vQkqd0BDMg3
	 lA3S7UoPQ6Hl8DyrR7ne6sOPhiPz4ubzNCb4I7vGYpIHEkOaZc6ZlTosdcAKWKGvpe
	 98lfgU5NIhlhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 151/844] drm/v3d: Set DMA segment size to avoid debug warnings
Date: Sat, 28 Feb 2026 12:21:04 -0500
Message-ID: <20260228173244.1509663-152-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220229-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 026521C5E34
X-Rspamd-Action: no action

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit 9eb018828b1b30dfba689c060735c50fc5b9f704 ]

When using V3D rendering with CONFIG_DMA_API_DEBUG enabled, the
kernel occasionally reports a segment size mismatch. This is because
'max_seg_size' is not set. The kernel defaults to 64K. setting
'max_seg_size' to the maximum will prevent 'debug_dma_map_sg()'
from complaining about the over-mapping of the V3D segment length.

DMA-API: v3d 1002000000.v3d: mapping sg segment longer than device
 claims to support [len=8290304] [max=65536]
WARNING: CPU: 0 PID: 493 at kernel/dma/debug.c:1179 debug_dma_map_sg+0x330/0x388
CPU: 0 UID: 0 PID: 493 Comm: Xorg Not tainted 6.12.53-yocto-standard #1
Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_dma_map_sg+0x330/0x388
lr : debug_dma_map_sg+0x330/0x388
sp : ffff8000829a3ac0
x29: ffff8000829a3ac0 x28: 0000000000000001 x27: ffff8000813fe000
x26: ffffc1ffc0000000 x25: ffff00010fdeb760 x24: 0000000000000000
x23: ffff8000816a9bf0 x22: 0000000000000001 x21: 0000000000000002
x20: 0000000000000002 x19: ffff00010185e810 x18: ffffffffffffffff
x17: 69766564206e6168 x16: 74207265676e6f6c x15: 20746e656d676573
x14: 20677320676e6970 x13: 5d34303334393134 x12: 0000000000000000
x11: 00000000000000c0 x10: 00000000000009c0 x9 : ffff8000800e0b7c
x8 : ffff00010a315ca0 x7 : ffff8000816a5110 x6 : 0000000000000001
x5 : 000000000000002b x4 : 0000000000000002 x3 : 0000000000000008
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00010a315280
Call trace:
 debug_dma_map_sg+0x330/0x388
 __dma_map_sg_attrs+0xc0/0x278
 dma_map_sgtable+0x30/0x58
 drm_gem_shmem_get_pages_sgt+0xb4/0x140
 v3d_bo_create_finish+0x28/0x130 [v3d]
 v3d_create_bo_ioctl+0x54/0x180 [v3d]
 drm_ioctl_kernel+0xc8/0x140
 drm_ioctl+0x2d4/0x4d8

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Link: https://patch.msgid.link/20251203130323.2247072-1-xiaolei.wang@windriver.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index e8a46c8bad8a2..f469de456f9bb 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -378,6 +378,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_disable;
 
+	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
+
 	v3d->va_width = 30 + V3D_GET_FIELD(mmu_debug, V3D_MMU_VA_WIDTH);
 
 	ident1 = V3D_READ(V3D_HUB_IDENT1);
-- 
2.51.0


