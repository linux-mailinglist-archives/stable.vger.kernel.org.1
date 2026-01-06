Return-Path: <stable+bounces-205048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A39CF7589
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 09:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3219A306B763
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 08:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5327E7EC;
	Tue,  6 Jan 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkP7Iw00"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7B277C96
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689411; cv=none; b=VjXr7NEC4/YBmPD1KRFBtDB879HatTHm6IBadG2yF9za4ZgB0EiEprcQvICAyA2f6ycyMSbrJVoAXoC2/dUF27agXeFcX4F5IJte795g0VY5VGmZqzPNFMHYQemXAjzcudpNkSgn5XGSXOQsF6CehGNvKOsbqVZbjDGhgB0J1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689411; c=relaxed/simple;
	bh=Mfr8IanOt8jxU7vewSt4DV+aakgkKleTBni/LrpiBkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbaGHAetxlvr+wmo4BgKagittHF7sXL5b8Lb3oAmwbqpB/XnUty9ylDD7QWMqsaK05LCypMgLXP1QImj0hAUeGgCmIKMtSMSEvCsxsgkkumPfttMttWGWGxh4iAi+hqDpkNK/yHchnk0tTIe4KYAKbPjr655xD00fxl8HOMKX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkP7Iw00; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso821225e9.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767689406; x=1768294206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hV/GMcvRyLCr7DUYxLRLYti8UWuf7naTwJHZtiyzU+M=;
        b=AkP7Iw00c1wFdlkYWq6yqgIF1CKlsR12fcDUPOL31p3kLkLR/ssOVsd7YqLz8P0+45
         zPnNxxQf0culpGPdFzTrdJ5lTq3ZNWVJae7v49F4MuDkszzsCKItuT3JFtENQXFhq54c
         RsXJjr5tniRMg5H6HZwfHq6PFDwQA9DlqyKM6P3sb0yDCLnHwwj7wtrx402r6om/OQbG
         8PLPTw54DDVi8s1xRpQRTZ3JcpYRYt0PXwqvA1oAJ7++d5Z+5wJOBmG1exrCR+CGiNTc
         SauophdfPBQPSecYWelhrr3sTf9MStySRg7m/DvfYpvEI6W0kZz4ozeBV3XnD1/5eimC
         GfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767689406; x=1768294206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV/GMcvRyLCr7DUYxLRLYti8UWuf7naTwJHZtiyzU+M=;
        b=m/QDLVL6wrhQVw5o9yrAkDsy7xrOXDe4MurYXSa4GLYC3oyTte/4hELWDwDijEICvC
         kCgYqxUq2anyFskmqhGbX1bNKavH1ShFj4GDk2F2xaFAR/1oKa+TGFYRydvwFGWKQVIs
         Spc1GC0lcRdKXcWRIIVa87PvTn2DWwe2FDO6w5zW2uLYpsbxwhl4SjdTmJlQcrQxd0Zd
         HxrPLehosF5utSBIhI4QdUNrrPI7YT+GlGigysT8xMEQfMG26aza5K4Lu1dkJ3lulmhG
         yIypXYQb0U9Zpldvfa8ooAehzEzgImHcdQoDqmdDFZs0dvJak+BjCDco16Jxdjx/KaPp
         iaSg==
X-Forwarded-Encrypted: i=1; AJvYcCXgF9uQ3hG43qxVtxtCHYjylvtMj0R189cly150mb1Ei9fI0BZ9cWZ72KNrv/Gh8f+HmK0OmA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5wWdRX3Rz8BDA4YHoHluf8yyJ2zJFUE35kVAK2xJ0lwG343E
	XRhVaQeQBPVMZK+8beDQpw75531k9F9DpyoDkDR5lAJTivq7yHYOInbS
X-Gm-Gg: AY/fxX7g61zF3RkHdxo8Hf5jlWRGsT/mdDr0IxsuGvL2D0cmDglEVXzYlwJW1rXrTLU
	1j9S79uMecApDpmB4Huv0lKKlR5QSoKVFisBal3B5wOcX1kA7NgP9WNCGc1njwAVOsXy0IdkNxy
	1dG99PNxr44VV2qidslMvxzpVu8KUIrOGXg22uIAemiS94G+Wn7MHFf4DoBp11hoBberqKFJME3
	xV12JcIU7IEKj6wtSmhfdaEaaRYGWZGh1kMShHJqkYAuuLtee4+aGk1R3GUrgBdYoXSEQfyQzIX
	rn/sTPJC52CbFhjYNdu7a14w0IYY+yAdlrkj4lTux2dDNSEK3oFLLdnTBYXLex5sk6HOlvZyqT1
	QpY4Zbe5t9CmX81/y/W41Txhsn/+RcgrTbK2G6c45IODvQiSRqH/xFsoJcKApiWwHCnfKoA+hmT
	lz6tdzqRrNpko+Bx+MEZax9rz8yZyKtvhLdzM0/hD/gexafakuliGSrGRUwDpqQsaDjfZMP9PrX
	1VA2BY=
X-Google-Smtp-Source: AGHT+IEbVRYctNc4A+yz5Gyy1tMc8wt0TvOceywuKntqSSYPrKkT3maN7meDceSemXFvcHnWFEclrQ==
X-Received: by 2002:a05:600c:138b:b0:475:d7b8:8505 with SMTP id 5b1f17b1804b1-47d7f0a86f9mr14273175e9.7.1767689406312;
        Tue, 06 Jan 2026 00:50:06 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47d7fb35701sm12342695e9.11.2026.01.06.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:50:06 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Jeff Johnson <jjohnson@kernel.org>,
	Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Sriram R <quic_srirrama@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Wen Gong <quic_wgong@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] wifi: ath12k: fix dma_free_coherent() pointer
Date: Tue,  6 Jan 2026 09:49:04 +0100
Message-ID: <20260106084905.18622-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_alloc_coherent() allocates a DMA mapped buffer and stores the
addresses in XXX_unaligned fields.  Those should be reused when freeing
the buffer rather than the aligned addresses.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/ath/ath12k/ce.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index 9a63608838ac..4aea58446838 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -984,8 +984,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 			dma_free_coherent(ab->dev,
 					  pipe->src_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->src_ring->base_addr_owner_space,
-					  pipe->src_ring->base_addr_ce_space);
+					  pipe->src_ring->base_addr_owner_space_unaligned,
+					  pipe->src_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->src_ring);
 			pipe->src_ring = NULL;
 		}
@@ -995,8 +995,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 			dma_free_coherent(ab->dev,
 					  pipe->dest_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->dest_ring->base_addr_owner_space,
-					  pipe->dest_ring->base_addr_ce_space);
+					  pipe->dest_ring->base_addr_owner_space_unaligned,
+					  pipe->dest_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->dest_ring);
 			pipe->dest_ring = NULL;
 		}
@@ -1007,8 +1007,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 			dma_free_coherent(ab->dev,
 					  pipe->status_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->status_ring->base_addr_owner_space,
-					  pipe->status_ring->base_addr_ce_space);
+					  pipe->status_ring->base_addr_owner_space_unaligned,
+					  pipe->status_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->status_ring);
 			pipe->status_ring = NULL;
 		}
-- 
2.43.0


