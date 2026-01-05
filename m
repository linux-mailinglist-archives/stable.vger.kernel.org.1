Return-Path: <stable+bounces-204928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6ACF59A5
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D20B307D45A
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4182D9784;
	Mon,  5 Jan 2026 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku+JMIuR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28D27F017
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647152; cv=none; b=K4l3hVKsOuIrMHicg8C8O8fFdPgcRse7iUEwcyDhj7LoMQqGGWLg/cwhmFHCbcuvF3kvGx9v2kNX4rqKQ08PFSLcXSWdQ8+oYNL//Ldd/Rjo6e+71XLC80EOjxuikHmKt1ispp4C1QdmAOzfC0fxiXZ7cqOHhOT+heE+UVX3Z+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647152; c=relaxed/simple;
	bh=DYutQNrGgwXioiun8+u6ap8SX04u9tbSx/6VE5md44I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbUbW2rGLBeuoVHXhqWp5abSGWTMDbs+8zs4Wd7H9Bly+ZANKSckTAISXoWOn2jqvGqx0uFFjldIT8WsTXC9ONZ5qmHFdDRKM3isI15P2oKwLKQt4Erv6WL7ivbfI8fIqozgipA1L+GSF2aE9mhXSrLwEwYB8GksodXM0l/AsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku+JMIuR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47797676c62so556025e9.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647149; x=1768251949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExRvh8gizlzCosztwzGXJoboDd+Ig4VaE8sOE6jME08=;
        b=Ku+JMIuRXXN36vx+hTdo6UdaBePSUHw2TfXZDbKwmV+cRYVSrHwlCxD0+pldU/RoTd
         +8r9TEXSC/OWD6mbu+kO+cOf1CP0WEx2heL1S3yKhvDbeZQlDomSoFC6nBR/yzE7Sq+9
         oXosVwv/r1NAsSAK2xeWm9dpCbJ1pPClWxEXFdn80JZqzTj36kQOvISMZ004OQA1NDtP
         6++Yf/3oN0UP26UJSsgrHO7wa/R3AhUthX1r629TA5HQ7AphZmt8A8dB2iNkywRn3vYP
         PVhbBPw37HdzIFmFkrr0KlaWqxVmoaVQXNRA9II97EmGh//nopYxI4pBo4yqD+PJVD5C
         IGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647149; x=1768251949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExRvh8gizlzCosztwzGXJoboDd+Ig4VaE8sOE6jME08=;
        b=np9utPUyEuKlzRmlzORRnqHXtRxCq+f7fKRYAkH3s0VGuwgNHgXyKzv2rNg6dye/NX
         ZseTkPWezb1kc97Vb2TfcyVbNx/qabDMWf83QFBzqR09hzm7zGbsh6rZOg8VeqUFHhdg
         imG7d0cb8o1rvEdj567ebTy6uV6Om29ABKhVYng4D8DA23qIq1utCHfYHj6/AJOYDLrk
         kV8Qry88+9kEFN2p6X3/z1/x02kSLV3rUwUxMZy5BYBHxltiznwapvHxLMzRRY7pThx5
         QMBYKaET0GhhNDp+ifd2nrV8lL7RRmM1l+HtCksVaY8FAU0wdFbw/IVdAGvXyDuHfEbe
         IyQg==
X-Forwarded-Encrypted: i=1; AJvYcCXXo1NOS3pPoDbYda5dhS76GAkP6Cpbc0aY2g8ZCPBy4wyCERQT+CFeRgmLJIW+qJBsqo6qpg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpF0U/2ezdCVQQKt5UQ17JubSAes1gQnUBmJBDoiBYNH5D+VbG
	5wyEm0F7ABqD22/r97ZhPJcKof38M+4+uR4gPh+pV3AVDsNBsZ+Nl4Qh
X-Gm-Gg: AY/fxX5CFkOJ9Pj5MNZRQ1hpO5bKkGD4D2I9MaVnDYrOKwqfCPS5EmViOUwnNONHnMK
	d0IINoptBb1uzrfpJLPLE47ElqU7P8nI+Toshv3vL/17J13iDZY7HExjVAKpeg135G5lVyX206V
	wME9/oPwlshXWO3p8FJvKpCV4cdx87ajVOXdRUDuiDZsE+D3Ff1+zS7/E4oEAmqJF8PSYs3KC3q
	QqtZx4boJzH2F/pHdslsUrJJRhkzrbTgeaHr7/671SMWViVclI9odTCKJXE2kwla558J0Y2yiPi
	KzjXjz4Dlb/Zv7wnwGp++1NQzH1z53tqaMJoeMPhpxVgaiWE/WtBnajJOMtDgn8lvpip1nRkNQF
	gs95oYuiEZTAxjPAgYAUirS+KGK4QqDdnHbZTqaJy2K0Sew9fJcI6AR0V3UWrIUQKeQoFMnlDYF
	YNcucUBkpeubj04ZWWxiXhj+aLJEyR6fdsKy4=
X-Google-Smtp-Source: AGHT+IFjVV5YYWM1Hac/Fy7//KMT/cxXD4H8sP8nsBaJZGJr9obOAP5rEPdrJ+zyBeOpMLvhACyeFw==
X-Received: by 2002:a05:600c:1f94:b0:47d:3ffb:39ed with SMTP id 5b1f17b1804b1-47d7f09cca9mr5148485e9.4.1767647149186;
        Mon, 05 Jan 2026 13:05:49 -0800 (PST)
Received: from thomas-precision3591.. ([2a0d:e487:144e:5eef:4e0a:3841:cee5:ead8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm535579f8f.21.2026.01.05.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:05:48 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Govind Singh <govinds@qti.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] wifi: ath10k: fix dma_free_coherent() pointer
Date: Mon,  5 Jan 2026 22:04:38 +0100
Message-ID: <20260105210439.20131-2-fourier.thomas@gmail.com>
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

Fixes: 2a1e1ad3fd37 ("ath10k: Add support for 64 bit ce descriptor")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/ath/ath10k/ce.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 7bbda46cfd93..82f120ee1c66 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1727,8 +1727,8 @@ static void _ath10k_ce_free_pipe(struct ath10k *ar, int ce_id)
 				  (ce_state->src_ring->nentries *
 				   sizeof(struct ce_desc) +
 				   CE_DESC_RING_ALIGN),
-				  ce_state->src_ring->base_addr_owner_space,
-				  ce_state->src_ring->base_addr_ce_space);
+				  ce_state->src_ring->base_addr_owner_space_unaligned,
+				  ce_state->src_ring->base_addr_ce_space_unaligned);
 		kfree(ce_state->src_ring);
 	}
 
@@ -1737,8 +1737,8 @@ static void _ath10k_ce_free_pipe(struct ath10k *ar, int ce_id)
 				  (ce_state->dest_ring->nentries *
 				   sizeof(struct ce_desc) +
 				   CE_DESC_RING_ALIGN),
-				  ce_state->dest_ring->base_addr_owner_space,
-				  ce_state->dest_ring->base_addr_ce_space);
+				  ce_state->dest_ring->base_addr_owner_space_unaligned,
+				  ce_state->dest_ring->base_addr_ce_space_unaligned);
 		kfree(ce_state->dest_ring);
 	}
 
@@ -1758,8 +1758,8 @@ static void _ath10k_ce_free_pipe_64(struct ath10k *ar, int ce_id)
 				  (ce_state->src_ring->nentries *
 				   sizeof(struct ce_desc_64) +
 				   CE_DESC_RING_ALIGN),
-				  ce_state->src_ring->base_addr_owner_space,
-				  ce_state->src_ring->base_addr_ce_space);
+				  ce_state->src_ring->base_addr_owner_space_unaligned,
+				  ce_state->src_ring->base_addr_ce_space_unaligned);
 		kfree(ce_state->src_ring);
 	}
 
@@ -1768,8 +1768,8 @@ static void _ath10k_ce_free_pipe_64(struct ath10k *ar, int ce_id)
 				  (ce_state->dest_ring->nentries *
 				   sizeof(struct ce_desc_64) +
 				   CE_DESC_RING_ALIGN),
-				  ce_state->dest_ring->base_addr_owner_space,
-				  ce_state->dest_ring->base_addr_ce_space);
+				  ce_state->dest_ring->base_addr_owner_space_unaligned,
+				  ce_state->dest_ring->base_addr_ce_space_unaligned);
 		kfree(ce_state->dest_ring);
 	}
 
-- 
2.43.0


