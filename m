Return-Path: <stable+bounces-194485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA1CC4E231
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A299F18863F1
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEED331235;
	Tue, 11 Nov 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVm0+nW6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4F324702
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868183; cv=none; b=cPo5VXRnlSZx6Spa0JTmQ//kBsWiRNJwBeEoS74m8gOEE4n9LJUW9zkRB/eNgkCbjcrlAdJmKh1N98xpATiyY15bxcBLIaQkatL3rSGCKFrKR8SpdJ87FzVGVvZnY5h6usPZ1FD/vEoSVblxzbQKRkLYWmYuu9GKLlnTIy2LV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868183; c=relaxed/simple;
	bh=tb/o45k6NTZzp5Nk7GT0C9oDC7orJsd/WdpvbNYlIMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NA/xDFZWnRjqKCA/8mMZTpQFuKX0xV3PscZnsCyh7wC8AQWTu2/lv6EWUT8WmTjPI+Fc5i4x6mkjO2ZiVcXJTrMlt3iD2X469B/LeFJeUS4MPl+gaTtV1LX9BeVhMvBceT9gWinpqD+qbX+TCWDgWtnCsVtBFPnsFwjR0JN4zk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVm0+nW6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7810289cd4bso4207443b3a.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868181; x=1763472981; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSjWYrocQfwFaqc/FEuBHYlJesYb/9NVMF9Hr5o9yD0=;
        b=bVm0+nW6FbW+buyPJeOGSP+EHHQk4Q9MXvabZHfYPXwOpZvVLHKFLBbMxHSzZ8aHMu
         rHKyn6XoqYv6+n03gqhCwmtsHNzcM7uDfVyTS//Il0u1EAuMYJi+K6QG5gUlt0ivlY2I
         ejiFjgvnuXcxmMQ5xuccVQJUC13oTRpLOIhZpq5pMAktUWzf7YmZ2UwCg3sYouG1Okgr
         BK7t9M5nnU6nu8L3w52V2Ep6yrP2cAmUaAFpApK08aO0XQrIUI9cLfPlLO1zdd75fkTP
         jmN7/RVPqfxv69rNMMGiS0UaGsa1XTenzsiK2CNNiEfmmV5UHlcwXttI2DJG4JeK7J2f
         MZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868181; x=1763472981;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSjWYrocQfwFaqc/FEuBHYlJesYb/9NVMF9Hr5o9yD0=;
        b=XlO3eHLU/BFWScXRBPN6jVChqMKg45B8+SESfOqnnBSX8kg1IVvmECvnFnl+k5Pnft
         GwJtntqb5P4SHXyGC+6DvCU/ekQOLlCSatfW3A6lYfHJ2MafvAE8oIJTA5GTs3VCZam/
         MtJs6p5QbXgA9Qq7+td89EovaFGIcwHWwb1mzyuEFCW4Nw0cpG5lXzooOF1hIbqlHoEv
         cdYLt4q5PrAjWSRapFz0L61UosVl9Cdob7MF5XK3p1er0Nh2qJWXNnBqivpl1K1UX7e/
         9/Z0RxXRVhxpphJBSY2svuVOR5/J8QY4QrWlVDxvsczqZeObzNtxlFjwx81rKJIRwYkV
         kM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+5Obw3GZDMMPmF3FxSTEcNGIHwPRiJd+u9vOnCAfuox28tbxX3rt40EPv/3tWDWEj1Lqt4ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6V0eu16WBpsIb5HHUHG9LWIr3cbTs9hf5WoI7BOTtgsb90Wc
	EUuYnHmzLagDdTG6bCjA7BT6FCZBT/BKk1xznktlHwwSpYROGr/Vorrw
X-Gm-Gg: ASbGncvx2co+0MIgySyMcApaVeXXiiCeuU+/DYVKs27RVsPEbxfmTBYv5i659tKRbic
	s/4KFbMuD17Pnid4djowv1et6KaaPw7+1VGnj/HWYLJKk/kZrdxpnQWDY3ASvBDfdo5ae8leM2t
	aepuLMQLPkKsN4tSHMk0zAdjc8MpRVNPgQyLfHoNbzfcDcEuparbdLDNsS7I3U5yFZyQjm+183M
	zN629RKLXKJN/yldqqvH7Ts7+hbQE0A8KGwlU9rUY5lpDTzP5KO/zEYiYug5W6T/egHF1cb1QMc
	07QrBk+5klVMmDEjAugtGKEma/fsa1LLbLxmPRVcdGMo/jOmwVtFch5MkR8nnLJ27ZOUH6WtWWF
	/Tyhl1PKmdtlBCagczTAY44GDuFimxe1xffdWWCJqMXh1PwhZqVyQNEv/t97AVqgKLqUEFgq2j4
	FZqb5E8bG4lW2WUGPMHNmgwIBvPb8TXJ4CtAdRCw==
X-Google-Smtp-Source: AGHT+IGb8HlE8JWSJkJpS1zcZZEBczySzg7b334mkzaQboKOCpDTMasE41mUoiJGlPM7Flg7CXU+DQ==
X-Received: by 2002:a05:6a20:7fa9:b0:351:118a:62a5 with SMTP id adf61e73a8af0-353a1ae304dmr16647492637.30.1762868180916;
        Tue, 11 Nov 2025 05:36:20 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff74bfsm15512914b3a.27.2025.11.11.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:36:20 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 11 Nov 2025 21:36:08 +0800
Subject: [PATCH] mm, swap: fix potential UAF issue for VMA readahead
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
X-B4-Tracking: v=1; b=H4sIAMc7E2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDINAtLk8s0E3LrNAty03ULU1M001KTTY3sDSzNDI1SFMCaisoSgVKg42
 Mjq2tBQBHfgxpYgAAAA==
X-Change-ID: 20251111-swap-fix-vma-uaf-bec70969250f
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Huang Ying <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762868177; l=2673;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=HeLp2ZoEZDX3vftvgCEWtbgmeYKyB9IS5uu4bOi2WgY=;
 b=NP1wXB3s9uZ5LCa0q45CMtK5u/dbQ6VfiNSojUKk74bIoCx+/UuzY877LLypbYFnbaQsE5yWu
 5+x4bAONzQKCDhqfC//W4zhw1Ds+YK0ipI/5kAQRfxPapBT1qcI5Tpr
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=

From: Kairui Song <kasong@tencent.com>

Since commit 78524b05f1a3 ("mm, swap: avoid redundant swap device
pinning"), the common helper for allocating and preparing a folio in the
swap cache layer no longer tries to get a swap device reference
internally, because all callers of __read_swap_cache_async are already
holding a swap entry reference. The repeated swap device pinning isn't
needed on the same swap device.

Caller of VMA readahead is also holding a reference to the target
entry's swap device, but VMA readahead walks the page table, so it might
encounter swap entries from other devices, and call
__read_swap_cache_async on another device without holding a reference to
it.

So it is possible to cause a UAF when swapoff of device A raced with
swapin on device B, and VMA readahead tries to read swap entries from
device A. It's not easy to trigger, but in theory, it could cause real
issues.

Make VMA readahead try to get the device reference first if the swap
device is a different one from the target entry.

Cc: stable@vger.kernel.org
Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
Sending as a new patch instead of V2 because the approach is very
different.

Previous patch:
https://lore.kernel.org/linux-mm/20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com/
---
 mm/swap_state.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0cf9853a9232..da0481e163a4 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -745,6 +745,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 
 	blk_start_plug(&plug);
 	for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
+		struct swap_info_struct *si = NULL;
 		softleaf_t entry;
 
 		if (!pte++) {
@@ -759,8 +760,19 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			continue;
 		pte_unmap(pte);
 		pte = NULL;
+		/*
+		 * Readahead entry may come from a device that we are not
+		 * holding a reference to, try to grab a reference, or skip.
+		 */
+		if (swp_type(entry) != swp_type(targ_entry)) {
+			si = get_swap_device(entry);
+			if (!si)
+				continue;
+		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
+		if (si)
+			put_swap_device(si);
 		if (!folio)
 			continue;
 		if (page_allocated) {

---
base-commit: 565d240810a6c9689817a9f3d08f80adf488ca59
change-id: 20251111-swap-fix-vma-uaf-bec70969250f

Best regards,
-- 
Kairui Song <kasong@tencent.com>


