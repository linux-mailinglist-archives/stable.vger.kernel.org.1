Return-Path: <stable+bounces-237852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGC5BVcw3mnxogkAu9opvQ
	(envelope-from <stable+bounces-237852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:17:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4E03F9EAA
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA6530EBA16
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798711FC8;
	Tue, 14 Apr 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCUb5ha1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC53E0C4E
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168644; cv=none; b=nILR8IARRNUvMWJcpT/fuU/VPo9RlWIfJxErL7MWhFB4zTiEEgoHy1TglRjxNeFH69/6srX8g5RiU6gcl/IDYHHPKsktUqotSNzbZ5/uIGQU7Yw2mjN5ssx588o+R7URUnk+/rJ6cFHWzh3qQTLFe22D+9qLD+QH94XoHjH2tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168644; c=relaxed/simple;
	bh=tfda8ZO8a0yV41gxG73VphHs3ZacuNxiugV7H0nb0QM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gReOCNNkuZz8H74PIUTwUKD+BZcvtoHUKrGSYQGajFZZcbqr+KO7LCBClh50qsbo5Uv5SeWQdIIukmexhXlU3utnDgRRlKdCYbUcUscpzp7JI3CAnVnzKoh+AqiIsVP897O7c+R/06DEWQCrmXlfdw7GOXmn16OWTihLO/t0+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCUb5ha1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so3750141a12.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776168642; x=1776773442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWUp3g+LxoslnPkybujRtv0aSTtZxDvWQnt9LN6HDso=;
        b=HCUb5ha1GdXr0QN4glaR/TwMS9V251CrCR9ZMe7Y9E2ySA/DOvsjFVOb8QQpR9/Vfe
         4+zBxFmosolb5kOkNaFx3wWBvSsKHUXmqnfoVR81Igez/B0jYGVK+ZTFX0HejM2CCxvu
         9mvxTnMkKu+4c3Qid4w/rRNxL2GcDepR7EA6rs1FLs5ftokBtDDLKuvjs+99DboSZ6Y2
         aP/uFSe3Nw7pzFzMSkIPM+YbLD/0ZiEjwlUmruW714DLdOAuzpf3AFEuFYRaNRNNZSZl
         oIonD2PjDGWmgCkXVwab+WczgRegy0LU+GjfdxPoEOgxZwlRELGkkq6S7ceMMkAoT96b
         X86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168642; x=1776773442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWUp3g+LxoslnPkybujRtv0aSTtZxDvWQnt9LN6HDso=;
        b=h+Q+7250oaNGbF0RsXwcZdq7kQNSeq4AbmP3xbEXwyJBZjnlrXLlZqU1jz5LRTCrbt
         LfbcUUCedmKUqoWdrxreU7M8ZdLG4twDsunwGCphIqs0ztaDQxBIG+zf+r2SiO4kMiqO
         nUGJ0q59CWE3SkqWkCQ6lG4KRxOtJ5cij0sJxdSjCdTxfvQxpnGXq34guztaDtvL9iXt
         ZF9tmGcsvDjCQ/OWKZHfeGoKpfmkLdtCdweDgAb8fwHHHub2n85hJLhUVfWHcPeVk8vX
         vVFg4+3IztKpmpm1XnG8Y76n/URVN6xqlQJO3n5/0vPWolRiCfTKy7D9Vfw99fhhPyHj
         kQ4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8C3k5SwxZxcKZXYEFisZQ9Z+sxk4UoUhS/Bo7GB2/xu0tBuCM2m7uyPqW8mBjbiiOjhRkS41U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshtKwZR5mjQTRtySkIwaxH8n0iW3DtKduvbO3Y1Vv06td3ikX
	XD0fK7NswzUdLkzkdpbs4BC48CkkmGkehKApdq4ig/VbRYwp9ZKq/41G
X-Gm-Gg: AeBDietGABPyVOpjsIRNRIMOVADBmfnhON6VvU63GZ7EYP/CjpqWk9FdQ8e5FzmcAm7
	Mgr819eCB/QcWaI4axcOXfhXVZJxEE6O/zKQXR/xzhA5wO574gIErB5eutcoFxa+qKm9CTDYdLA
	kGg8LqPxM4eUeapbKA2zz4OS97TsIAdrLYAZYA1rdYlMGKgIObtbGzG+7rIyBfqSEETtSdJG+1n
	otIj8DyqY0Fah/yMdoXmybp+UopvRVSnW1tB+EI/O2T7iPUNEWSa0r6Q69fzo0XvKpaTGzhpNLN
	wbilaLUM1URMKAg6GJKNBpO4JKnxJzOckcqUK4jYK6B17gFZTxvS6kFKgA5ndcJQqQr4D2p54GF
	PEzMczXQnm+QBB0xRHA82SoVE1VZStCvnjcuT6Lcc331q+jBHQrYP7Nk+nMXvmI78sP/1cTLiRL
	mpplGNFCmR1ztl9Q==
X-Received: by 2002:a05:6a21:9983:b0:39c:4cc9:9d75 with SMTP id adf61e73a8af0-39fe409bcf7mr18846083637.56.1776168637484;
        Tue, 14 Apr 2026 05:10:37 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c794d8f3984sm1241349a12.12.2026.04.14.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:10:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	George Yang <George.Yang@amd.com>,
	Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/amdxdna: fix IRQ vector leak in aie2_init()
Date: Tue, 14 Apr 2026 20:10:24 +0800
Message-ID: <20260414121024.3142118-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237852-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,amd.com,kernel.org,oss.qualcomm.com,lists.freedesktop.org,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B4E03F9EAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

aie2_init() allocates MSI-X vectors with pci_alloc_irq_vectors() before
creating the PSP handle, starting the hardware and initializing the
resolver.

When aie2m_psp_create(), aie2_hw_start() or xrsm_init() fails after IRQ
vectors have been allocated successfully, the function releases the
firmware and unwinds hardware state, but fails to free the allocated
IRQ vectors.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Add a dedicated error path to free the IRQ
vectors after pci_alloc_irq_vectors() succeeds.

Fixes: 8c9ff1b181ba ("accel/amdxdna: Add a new driver for AMD AI Engine")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 4924a9da55b6..f05f49f691b5 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -591,14 +591,14 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	if (!ndev->psp_hdl) {
 		XDNA_ERR(xdna, "failed to create psp");
 		ret = -ENOMEM;
-		goto release_fw;
+		goto free_irq_vectors;
 	}
 	xdna->dev_handle = ndev;
 
 	ret = aie2_hw_start(xdna);
 	if (ret) {
 		XDNA_ERR(xdna, "start npu failed, ret %d", ret);
-		goto release_fw;
+		goto free_irq_vectors;
 	}
 
 	xrs_cfg.clk_list.num_levels = ndev->max_dpm_level + 1;
@@ -623,6 +623,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
 
 stop_hw:
 	aie2_hw_stop(xdna);
+free_irq_vectors:
+	pci_free_irq_vectors(pdev);
 release_fw:
 	release_firmware(fw);
 
-- 
2.43.0


