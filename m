Return-Path: <stable+bounces-89155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8EF9B4096
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 03:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083F8B2218C
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE71E0DA7;
	Tue, 29 Oct 2024 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdW8Te8K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1971DFE3D
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169768; cv=none; b=VyZjG8eePe+kYAMVaqcn8XbJFeYMle9JEiAUyMhulrxHQkuONnB+p0eLrK94LFkg4mjjL3EfjJNokygtiTLwMObWQZWfBY4Q2BAB9ebktkPKq4Hhc9YrMy2MEcJn/SnAXVP7lO7yZNP6UWzf9YERoblQJH51SrDXPCw9YIz/RI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169768; c=relaxed/simple;
	bh=CIbq1ifEgFt6W1X8j1DfbsyaE8c97nM3gGMLPXLGsDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b793uCGmeD58EB12CJhEO9A3edmal2DJFQWEgE0axikObzN7Cw/l/UOKxdeYEebUbtgyFsITrSjiAeeGDPsLLWQVHm03JutUVc+dazP5z8h5+QQkDOfJL0zAi2LLDPy4HgZEPNGXSUBxSvYqrJW+0wWa7feCcKo9iZbHI/N2KI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NdW8Te8K; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c77459558so41270815ad.0
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730169765; x=1730774565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU0m18qlbYPwqYfA+DIm9Rsw5kNqo31NH8il36rID1c=;
        b=NdW8Te8KovdsRYba6ADkw2ZIyGM+IbUx+QRnQGhyTf176sd2MioycbzShoiZE51gMO
         7G6SlDpgpkzvP8gQyCeENvm4iiKXzbxKfk0l3/UAxUf2vRCUkHi9A3q0CMqPU2cKUbt/
         e/5aVDEBQbJwUX3AKvcm/LqZlXcrPy8M1YViA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730169765; x=1730774565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EU0m18qlbYPwqYfA+DIm9Rsw5kNqo31NH8il36rID1c=;
        b=pIQNsw0MBHrBRv3I1DFBhI87LpjYWQmYw1riiaNHCa0hPM/bSgmLmzAOxfyA1d3aBk
         O6NH35oBWXC4p10eY2zvJVyYlkRwE/yai7GgEwIipA7QOZ2P6LNfCEQqUMmwvobQdIiT
         iOjV1TOj0p95HvKUJ68f7YMqTqoFrBtXbmu7dDM4sbV79MhxOQKTLCKdzpZB59hysi4n
         dWrpVGnzZaKsCsP7oxP0IB9mwT4GlAFjac2A8EpSRK3IDeGgjkv0X9+fRN1bgkk53WpX
         4pCwsQMdwHz6SV1ts6QL65cYoWqRijZdIyUfs+OS0kcNSzRotMQhJnuT6f9QykUZV1FM
         pyyA==
X-Forwarded-Encrypted: i=1; AJvYcCV4DGsMHQiE7uD/Yk//bZQK2RGVJeBazcUlLG8FCMwE/nQjy74O7RCwZRn8DVRQ2VubP9BBSis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUiPbFtFj4PrxuYn7VOFL+vKXdPThGfu69zBIoolmJIRood/1
	asVRzkWfoNPiWYjMmLo6HLYlyzofxo39AZNiCRFg32CnNzlIidhII+6OBwofvV99kNF2uyEOOh0
	=
X-Google-Smtp-Source: AGHT+IHT+dld7klfyYLy6A9hBhkDuS07vpgyWFV5LZFb7JFYIdXzbJyScSCZU4fj8F1tmYMj/GtyeA==
X-Received: by 2002:a17:902:d48e:b0:20e:5777:1b83 with SMTP id d9443c01a7336-210c6c011b6mr139172565ad.24.1730169765434;
        Mon, 28 Oct 2024 19:42:45 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:6e49:6193:843d:22c2])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-210bc0489e4sm56506135ad.236.2024.10.28.19.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 19:42:44 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: bob.beckett@collabora.com
Cc: hch@lst.de,
	kbusch@kernel.org,
	kbusch@meta.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	Gwendal Grignou <gwendal@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Date: Mon, 28 Oct 2024 19:42:36 -0700
Message-ID: <20241029024236.2702721-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
is a NMVe to eMMC bridge, that can be used with different eMMC
memory devices.
The NVMe device name contains the eMMC device name, for instance:
`BAYHUB SanDisk-DA4128-91904055-128GB`

The bridge is known to work with many eMMC devices, we need to limit
the queue depth once we know which eMMC device is behind the bridge.

Fixes: commit 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")

Cc: stable@vger.kernel.org
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a3..1c908e129fddf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3448,8 +3448,6 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
-		.driver_data = NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.47.0.163.g1226f6d8fa-goog


