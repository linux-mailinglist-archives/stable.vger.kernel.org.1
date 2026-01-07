Return-Path: <stable+bounces-206107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF3CFCBB8
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 10:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C5130A1317
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5B2F619A;
	Wed,  7 Jan 2026 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjp+63yE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50ED2F547D
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776680; cv=none; b=IAykK20fsprZ659/Y1CzJNNi0CZpJEdk8CmB9vZuDR4tM/wNTgjiRqZY1Mw3CAJbDg9z2rMy6qGgE8ymnbsNFHDTJK+a/r8qFSZaOWU9Fyupwjdh2BKJ47Jx+8UNoagydEwNEdZOx82Xj7C7ODWbqWky52+PeDBpGbL5YLucCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776680; c=relaxed/simple;
	bh=DXXeHFHCRT6ALQ4aZTBR//uNRSxmmt2W+5GojkTCBeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xzv4WHehnk8P8VeDq5OuhFoVT+r5Z8cJiXz8BhWcmSSwWN5gwRXrMQf+k0jZBXSuA/6b6nc+RAwznDMgwrKvdeBcY+DB/hIe8GGHMrJnuEkgIv56jAB43pv8QBY3fHpIB7mi21+U3HAR8owyBurbiPu0sjJErGwkPMPP/tTgunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjp+63yE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477985aea2bso2432145e9.3
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 01:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767776677; x=1768381477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYA5NHCJuY3jjgYMFrcIZ25L1R5u6oP/KcQWduVcKq8=;
        b=Gjp+63yE532MJqGWE/UcHIKdfaMeQGJlamF5HdUXiutJ8bZzAMOYEaO4v2bama+fQO
         8PXCotPp9rQGIJnJLsUv9Hh4EN3zq0GTFpsyKwXc1NhnDksQfOI+r3Ub2fNMwxS58mcX
         sq5TNec4sbRhHJ9/1anGpAwtcR098Ww3HBBJ7c8DEkUx535aWcrIlKT9Ki/hZkU9mw1R
         R+VFhSOnNSfZXXyePAf2hQUjqDQCGuNq/rNPKrMkRTrFJKx7EU7t24PDscDln9u++iND
         OtzXcjx17M5/q6Jk7tRxC2AFBVWWdH31TXZqIsl24mE+nfFdsgXWul7K5DZTQXaDQmip
         HyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767776677; x=1768381477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYA5NHCJuY3jjgYMFrcIZ25L1R5u6oP/KcQWduVcKq8=;
        b=rgqw0rkHukCyR3nLuyxIkV7F4y1qNtz1rYATUx8asVMLvEhHSIp45lfCGfvVHa0H2A
         U/lrIRE3EA+E68k/cAWUadASoefw9VC9KmSr694JkLwI8gNfNBd7TIU9vqjYwKv3Az1W
         A+pz+mMBxE785ivyRxQkalr8DGS0tQHJop8nCgZ5wsHh3xed3if1qHsI6im89WVVYzue
         eu423kdjAW/4oP75LvsRwQDy18swLaewxcB8ZIIM0CJ+eyol/5d6+98kLuoh/gOm92/N
         5js0OuO+P5GbQDZbVtKft2FIqOlpL0YvVTXrze+UQWutgnh1a9+G80L9s/PyVvH9MCi3
         QfGA==
X-Forwarded-Encrypted: i=1; AJvYcCWFBct9LfGoL71JvJ1nuzHfuqFcRP7qthmm4Uz0G7pVEe2/fZk4WjLefO9YPiiDoe8zeAE1hkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxc1HyCMbM2cECJin3EWCX1UHwTAS3e6BamCaYPkrXrLmlwcA
	Jl7iyIzWnh/Xm59NYsMILaBt/O3q6zfuiyEVWF0SC+7mNkt1ZBi8XC1u
X-Gm-Gg: AY/fxX60W6Bo1z0M33Lp95Pgu2bfLfjHkk6RzGvl9qhccoCw9KXKWplirvExyHqjKsB
	KO851KFSYvF6XezQ+vNlXRw3BG/ZGAzEfHH8NIqmGaemNs3ddi6AFbtcrWaA1psAjstmAYtPJXw
	L4Cdp7OTPI8JmPAciA6iF420WQBrc5cHTRmehtgXNIiaGVlzrQgCnjd2kvGyqalxg6ltbbDL/LZ
	n5HeEhw/DPCIViXemeUlWkqL5dNzHAxaGx8Qf+YeETCH2vQJtAb3R2Skz5/FgitFAwLMGlCSKKz
	xpwpW/OaM4x5BD1qzWl5s+1koQxJHRhonDXBcmdogDHH1XzDkDpoYtUogn4gLDLbar1deGj97p4
	tk6eDKoOd+pkH3UUu2IOhhJJb9bPXx56sS5Gr5OBughqYgKrXpCNbVTh8ivnZ68PsBSHqwE16Dr
	+XNYEYIgQlkVjPzuafEMMtvfrfTFI+Hjl+x1j9Kb0Z+rImOQ==
X-Google-Smtp-Source: AGHT+IG74BQ+GmUBoQHHt8YRVhqA4eCcYpl43fd7bFTmvsailB9SELKZEsXAQgjdjVqKB/ovrcPmZg==
X-Received: by 2002:a05:6000:240e:b0:432:c0e8:4a4a with SMTP id ffacd0b85a97d-432c3776f42mr1250136f8f.8.1767776676625;
        Wed, 07 Jan 2026 01:04:36 -0800 (PST)
Received: from thomas-precision3591.. ([2a0d:e487:219f:3dc7:a574:8d6f:e649:bd82])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd0e16d2sm9514457f8f.13.2026.01.07.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:04:36 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] atm: Fix dma_free_coherent() size
Date: Wed,  7 Jan 2026 10:01:36 +0100
Message-ID: <20260107090141.80900-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of the buffer is not the same when alloc'd with
dma_alloc_coherent() in he_init_tpdrq() and freed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - change Fixes: tag to before the change from pci-consistent to dma-coherent.
 drivers/atm/he.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index ad91cc6a34fc..92a041d5387b 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -1587,7 +1587,8 @@ he_stop(struct he_dev *he_dev)
 				  he_dev->tbrq_base, he_dev->tbrq_phys);
 
 	if (he_dev->tpdrq_base)
-		dma_free_coherent(&he_dev->pci_dev->dev, CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq),
+		dma_free_coherent(&he_dev->pci_dev->dev,
+				  CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq),
 				  he_dev->tpdrq_base, he_dev->tpdrq_phys);
 
 	dma_pool_destroy(he_dev->tpd_pool);
-- 
2.43.0


