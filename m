Return-Path: <stable+bounces-231330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIrWMuZmy2mAHQYAu9opvQ
	(envelope-from <stable+bounces-231330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:17:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 771673646D3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2E1A301C057
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81656385509;
	Tue, 31 Mar 2026 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/dPmRFB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6A3ACA72
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937826; cv=none; b=hDxU/m7jb8i1+QadzhJHbR68dGd+orIpLPdjYDMlmYZqFrUMzov+5ST8HiuQAPaG7SVsDhGgyJFtGafSdy2qfDPMCmE4eLMKrEzrfXrmqxBsKDO0y92i7MdUMDsJKki3SiHEN8CfDo4mxuvvxzMAnuLxMKg/d1g49e13/62HkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937826; c=relaxed/simple;
	bh=32Nkju6QPo7DcDfAct7IAD8EQeQKUz1dOWtW6JHOpPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IT2EEaQeAakoDwG+8u85C/K64b3GAYON8tWkbG6+Fzfoaw1Xx+Nw/H4XQ+M8enTAC7QtfcpVLDK9b7PqmFPGRmAD28RB+iIPDxEqHPoV82LaCWysKoYPHXkncpT4Ayin7tOG46b2nlznyrAMHfTK3m6Gj3lFvqCFRIfFGCGFppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/dPmRFB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38be5d7c27cso50736511fa.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 23:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937822; x=1775542622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slrIynpsyCDGbw/DVJ139y58tD8HDF7VkYtGZ4Dd10U=;
        b=P/dPmRFBIohgW+J1TbSt/GE0XAz0coqH2iZXs2lf31kShRPnxveKhLhjnVtYaAMRmP
         ekQ+yBAxsKy/D4NpGexvd9aIl8hndoaQnUwSyq9OM95X5c2OnhfDT/BegYZ50cfzANPy
         W21i3Id2f0l9Ar6gpzFX0EsCcZc1iD7d6Svpw7/9sZzTwn+5TQn/KCtxFF5xSzEel+1Q
         K5ERR+HkEbnasS0hFmbw6f7Ke/r/umNNifE7Mtd7b+Qd4zd981TvRGztvIF/yjfTL/A+
         wmbRNuX/fpBdEaoa3f4+bdar5M/B9y0Npq05VkBRcPlgG7dzQy0R1hwH/DCHzeDFaEJ2
         Cu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937822; x=1775542622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slrIynpsyCDGbw/DVJ139y58tD8HDF7VkYtGZ4Dd10U=;
        b=MEDfWYFzM+xEF7wdPiUnzQx76u+k7nviDh+RkYfxHjtrg0fHofbBxqi1cUpyH+ZgvP
         nBFpVifat3SJvfNeWdomqW+Fdspoe9kyH2eHeap6tYBZ4ATXdYY9vATwpUrLGEIQNdmk
         wfn6/l/IkMhqo8lgS2DtqNN/+ofDNgnPDsTe4dyOO/AEXlYEYzh6ryPDB0OvJd9HHGql
         DJxvLK+NJ5B41RuWaP23Wm0TZEJfqpkLBDBHBzpjz3DbXvn+OdXTtsIUitaV40lVzX0i
         kF/aWjDr9JSLev9jsuptDvp2VbteBOFbOo/+kzi0luTgMZljGzUpLvCfv5yDbUw4cbFM
         9sfA==
X-Forwarded-Encrypted: i=1; AJvYcCUjPG77k4T1XKZ8mXMnINlv1NCJsludv70ExoBiZp6SYarTSUAdcraAaCv3JcoBXIgdTDR5wE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1Ht8IzIyT0snudCqFcglY6ko/oDQfVjFH77TJ2+TvpqNvhOS
	cZkhyfoU+2EG7P6cYE2MeA4uDogD4zzHiwjI5azds0m9Tr8blbKozyYT
X-Gm-Gg: ATEYQzx9DNhCS7cUPmPnXItjaWYe8teYXAlOYKg65TzNN6u+8beLX3vls9UNSrMWpac
	3On2bpwi4V3+SwOZ8CyH61NRU52z083/bcangieXO/jDN7SYj6+z4g6U1AWnxJR5ntKc1JMqM7Z
	6iJDI2OQEx+ZyE4ircqKnX7xgiUNEZkdhvf16MMj6Cs14C289y6I/FEaV3PaluxrksPEF6dsQf2
	oc+xzUupJjmTI71bIqPnWuAl3fLYpz8S0iOrwk1hp7MJ6UJx/ErU/FF9w3AWiHtRg3bYStQM0so
	ZYf4GVBLA6IHVY+V1Sh6zjToeF4NTddAkiwgZzoXB9hznw2dmnvD9I2hBZlCURRMXfxF71X6kLs
	vayDBRrn57MXWQX+a/HrNIwA/hxfUd5PI4rTyu18QQ3h5a+mbWDpzALiPn4x121Tqi6aCSAswMC
	itIydOUaCrHw428fXVpWvLlT/7cw0dw+uTww==
X-Received: by 2002:a05:6512:3b2c:b0:5a2:b3fc:b877 with SMTP id 2adb3069b0e04-5a2b3fcbaacmr2578412e87.25.1774937821564;
        Mon, 30 Mar 2026 23:17:01 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b1455e14sm2145277e87.64.2026.03.30.23.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:17:00 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: kraxel@redhat.com,
	vivek.kasireddy@intel.com
Cc: sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning
Date: Tue, 31 Mar 2026 11:16:57 +0500
Message-ID: <20260331061657.79983-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231330-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,amd.com,lists.freedesktop.org,vger.kernel.org,lists.linaro.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 771673646D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When CONFIG_DMA_API_DEBUG_SG is enabled, importing a udmabuf into a DRM
driver (e.g. amdgpu for video playback in GNOME Videos / Showtime)
triggers a spurious warning:

  DMA-API: amdgpu 0000:03:00.0: cacheline tracking EEXIST, \
      overlapping mappings aren't supported
  WARNING: kernel/dma/debug.c:619 at add_dma_entry+0x473/0x5f0

The call chain is:

  amdgpu_cs_ioctl
   -> amdgpu_ttm_backend_bind
    -> dma_buf_map_attachment
     -> [udmabuf] map_udmabuf -> get_sg_table
      -> dma_map_sgtable(dev, sg, direction, 0)  // attrs=0
       -> debug_dma_map_sg -> add_dma_entry -> EEXIST

This happens because udmabuf builds a per-page scatter-gather list via
sg_set_folio().  When begin_cpu_udmabuf() has already created an sg
table mapped for the misc device, and an importer such as amdgpu maps
the same pages for its own device via map_udmabuf(), the DMA debug
infrastructure sees two active mappings whose physical addresses share
cacheline boundaries and warns about the overlap.

The DMA_ATTR_SKIP_CPU_SYNC flag suppresses this check in
add_dma_entry() because it signals that no CPU cache maintenance is
performed at map/unmap time, making the cacheline overlap harmless.

All other major dma-buf exporters already pass this flag:
  - drm_gem_map_dma_buf() passes DMA_ATTR_SKIP_CPU_SYNC
  - amdgpu_dma_buf_map() passes DMA_ATTR_SKIP_CPU_SYNC

The CPU sync at map/unmap time is also redundant for udmabuf:
begin_cpu_udmabuf() and end_cpu_udmabuf() already perform explicit
cache synchronization via dma_sync_sgtable_for_cpu/device() when CPU
access is requested through the dma-buf interface.

Pass DMA_ATTR_SKIP_CPU_SYNC to dma_map_sgtable() and
dma_unmap_sgtable() in udmabuf to suppress the spurious warning and
skip the redundant sync.

Fixes: 284562e1f348 ("udmabuf: implement begin_cpu_access/end_cpu_access hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v1 -> v2:
  - Rebased on drm-tip to resolve conflict with folio conversion
    patches. No code change, same two-line fix.

v1: https://lore.kernel.org/all/20260317053653.28888-1-mikhail.v.gavrilov@gmail.com/

 drivers/dma-buf/udmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b26ea706a3..bced421c0d65 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -145,7 +145,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 	if (ret < 0)
 		goto err_alloc;
 
-	ret = dma_map_sgtable(dev, sg, direction, 0);
+	ret = dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret < 0)
 		goto err_map;
 	return sg;
@@ -160,7 +160,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(dev, sg, direction, 0);
+	dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
2.53.0


