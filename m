Return-Path: <stable+bounces-165623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D03EB16C47
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 08:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509BA622DB4
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 06:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB128DEE1;
	Thu, 31 Jul 2025 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwxYpOgG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEF28DB59;
	Thu, 31 Jul 2025 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945088; cv=none; b=Q6KA0vnbl8MdI/NbcBmCQmIw1B4ufE+AHGQ4N5OB7bgZnTg171jxVt1wrFG2Tlyn9udVADSJAHw/Kd0dQTYJNYvbr0tNcfr2u8NU0CUNuQ4dUGIPgrAoj1i4Ic1us0l/Mj0VOXmv9puQZeFbSjF5bIcMEZDUC/XRi2tWoiMmnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945088; c=relaxed/simple;
	bh=ctkZcZA2sLGt+W4PXq09D8Wf+NQBaY1bc5Nj9fwzAYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuuhN1GcQgnMuWAxBzG39KRVNvd68dvZdnvM+dPHsykXc/z3sVv61muoG0zaEWWEQ57f1X3x0wkqOalExJccmkdvZhpyQNVtolCRQHwFj9Oc0KXbL/eTUYFZ3zwqz0bhNVLjif4JsmisiAVA3jRfMRlRPEURlLZb+CU5/KqlOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwxYpOgG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31f314fe0aaso748477a91.0;
        Wed, 30 Jul 2025 23:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753945087; x=1754549887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtS19pZNkkW1vymfEpVwFemFyLgP+PGhZhEy3UD877Y=;
        b=RwxYpOgGkInfr1VcE1OsYP73Ti38e+RTf9WodgTJzry0Cx4dT3x4qeMbKfCIOZ6gEI
         zm6aHOK01P9kTOadBXX2bzi3TqAyqR9bm6qkUt+6+BQeuVaptZP6Nj1beWeMfMHXTO66
         lUD5RFeIxqxwdjXmvZiN9jCG9l7AueaBCr3zt94+nNiAMAVg2IvGQ8NO4L7OuDR9OK4s
         OG/kqs9ePjEQ7Wda+OStU8nXLIZpmHqM82zHuvQjD+rlLiyGtpa41zfvFn9pvJWOFKeW
         gcfljTcvza7RbSHo3YbzwgVKDriLsZ2FOpNs9fSjh/5IsKqPQSI7zHR7uD/NgxjcMFTO
         jBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753945087; x=1754549887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtS19pZNkkW1vymfEpVwFemFyLgP+PGhZhEy3UD877Y=;
        b=k0Z5P8Id3AzFx1PwF8txrZp7nl47dqWMcaq+Nx3qCH5LHe5jpZKOkLg9QvPpFs+5dl
         RpUWdCYKt641BhEeZTSshgqucWJHAfxzUC24bQq1U9Z/8wAEeWwwtz6hN1dbOWvkNuYp
         vv98tqVdQ4+nQGez/eB0HenWyxkr/XSkM6UZ23d3QkzGZlrBsuSnV70Ttiq5eip33/Wb
         ANW2p5b4OmWLJkW+ZrDygMzHSCgMVYlQ0/xo8QV5ujJ81oANB11FA4n6rE0haA++FcXP
         yVEw14vEyreK7/7WjCaAmTquZ/N6US/zxc24Y1GB9c6eEst3kWkaHoDQoAzV1egqudji
         yF7A==
X-Forwarded-Encrypted: i=1; AJvYcCVfTjhesKEno4M/tqicrS36aVJVPxSKeqtNqOm5jcnep0EyrA5yOYqTa+09yThmIkrM7Cl5HVniX/Gg3iI=@vger.kernel.org, AJvYcCWjtRrSViTSj/u8A7im3ESSJUCkhg5CgnpFTsdFTWIc69pcOKQMb6EQ4ZB6rXyIm46C8Rr4iWjP@vger.kernel.org
X-Gm-Message-State: AOJu0YxmACxtIGHL4NFFTtuyb6KGMh9obKcKWsIjcKxK62GoLnFFFZRb
	eSpoAw55s5oHfYibMtfODhSSe6P1BEXtYEQ0K5iojSStkf47c3Fr/AeL
X-Gm-Gg: ASbGncvVQwzIEUKFuC0hIY3n9HpFSQPNMNZefLxYkO4RDShCqDc8VxrKKLjktuKuaxb
	rWGIuTL6l2DoJNJRfgWHYL48D9VbxNeOa8ReWAMk5JRorqCj+cG/6ZoPnWNw1fRWa4EUX9ZeZW/
	jtpov3JPmk8/0sXk1d6D6GryI7Qlja7dwsxuGXO1jXoSYTBmDT6ASttewUohT2odRHtOuuzr6DH
	RO0SnoKJit/fg+8Bq4oU01N6Ms/al02/1Mt/8WKPtZLSD4dLV8v1whC/WmdSEAZjOXB8cyo45xZ
	EU0IRF3AwTb3x0lEKqxFt52vuUlapZPp6LaSJL+LrdetRDV2GFoc9rXa74snkbsg239FskquYeb
	ImKsgXso1eU96TCOfOhtLMYkc+PESaw==
X-Google-Smtp-Source: AGHT+IFVM2Bc6/kK50XpRRpIbELczDj8pDCm4vQv6uDFaris8u2oVTWZDxvRthcnI8n4i7evcC8xnw==
X-Received: by 2002:a17:90a:e7ca:b0:31c:3669:3bd8 with SMTP id 98e67ed59e1d1-31f5de963b5mr9346587a91.21.1753945086666;
        Wed, 30 Jul 2025 23:58:06 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:3aa4:3d44:3e04:a6c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6fdfsm1056736a91.20.2025.07.30.23.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 23:58:06 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	stable@vger.kernel.org
Subject: [PATCH V4 2/3] mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consistency
Date: Thu, 31 Jul 2025 14:57:51 +0800
Message-ID: <20250731065752.450231-3-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731065752.450231-1-victorshihgli@gmail.com>
References: <20250731065752.450231-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

In preparation to fix replay timer timeout, rename the
gli_set_gl9763e() to gl9763e_hw_setting() for consistency.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index f678c91f8d3e..436f0460222f 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1753,7 +1753,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	return ret;
 }
 
-static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
+static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
 	u32 value;
@@ -1925,7 +1925,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
-	gli_set_gl9763e(slot);
+	gl9763e_hw_setting(slot);
 	sdhci_enable_v4_mode(host);
 
 	return 0;
-- 
2.43.0


