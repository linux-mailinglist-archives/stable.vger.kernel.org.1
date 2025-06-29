Return-Path: <stable+bounces-158857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E3AED169
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 23:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2504E3B1E5C
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A3239591;
	Sun, 29 Jun 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrRwYIiU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB773A1B6;
	Sun, 29 Jun 2025 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751234005; cv=none; b=aVVqzjkt9Ym+6Add4gx6kY6fukxPPJble+V7ZttwdFKDDK2vnuEx53jNu+dBKWsy0hGX+MkgrRuWRcuT2b+Crey3G0nEPfGquPEg4ZbPPkka0KXRsNmewt52KhjeI13FvfwolJ8rIUr4W7hYNc0bIGeFXPWAwWK7m7QXaCljyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751234005; c=relaxed/simple;
	bh=qa9GQUt1jtT2Gt7nQkWLc42amX+Sz/Pcd/7zyPeEoe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpW3OMOFb8XpxPZEKiuNvXegp/Kv+JmJMPUm7VzdnGcR8rRqlrrS2i+YBmaKkcqWabQ6K2CTRMqubSAwPw0bJpG6E3ROc76q2XtW2L4ewxVCLkecBBShSU1ZU+r05wQWSYuM2OhGu+L0onlkfuJsp+WEeUSrXfyQWfiZyKTHWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrRwYIiU; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fabb948e5aso19549196d6.1;
        Sun, 29 Jun 2025 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751234002; x=1751838802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyJcwNUn/7xBpKX8aXFhMH4lWqh2HK/mefvuweOGq6k=;
        b=PrRwYIiUIm/Bc3SYiA1yFn7ea4Oa20mGUomdn5OOhG5GBAnjv4QniYRVf3XLTVuNOf
         kqWUCOkNP4Bl5fGYJqZxSA5K3pf3Xu/j+TYSaZvBc8/lsM2NiROzy/IwJWbpS3Kfi9C8
         PRoBYbDijSooOLkE3C9yLUwSyWK/7k5djjupCXYDUVOxVeGF9xMntTmOwVZ1u6uq5iKn
         0qb5WwzDPur/50AroQkbNVkDi/y5h3loPdgnIwKi70QXoB2XoSaIi916VtDuwZFvG4rA
         s8vJK2nF/1pZsjOxvGvZD1zpvDM2rGlmMU/RtX3GplP4XlA4SU3j5P8tbipaqySDNGQD
         uBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751234002; x=1751838802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyJcwNUn/7xBpKX8aXFhMH4lWqh2HK/mefvuweOGq6k=;
        b=I2TxPBilHyyNJe3N3kTUng3QabAAM5x+6M7/5ZRFmDFRkE1K6Hwu1NBQ/1bEn9V0+M
         QT8HrSQZdhdAo71f6kiTXPzvfwRHVNzPiOwj8c6W8b3vIARZ4qCYftU+F9gPmskIZ9Gv
         nePMwJyrXN57E+bQ9DEnotHtCKWib4SGPjbzWuV59Lammh1IVgL3Ztswul4rG0KqxuqU
         WRKJfmRWtoxA0uQpYwH7HryulEMnf3CZZMJhQHwBZgi9BiYfucU7ZxGkrMYt1nZgeQ3C
         6cBo0pqAcuCi5sEbfAYFsAwqohy7llNL0Pcrjg1dvu4tYKzKi9vhJhExhyrGW+T0qUA9
         QHow==
X-Forwarded-Encrypted: i=1; AJvYcCVBCvt/nWtHc/sH4YyqGpfar37YjHxTls6gryy4vYrkUtxZ0koIhAc4uc/06IyR8ce49fyYAtU1xUbf@vger.kernel.org, AJvYcCVKPCj8SMWiAxAb4utt60AeeKm/tV3VMuxo14SUjeO/P+CYdpjK0VALY4eCyAkJQd3H4l6KOhd1@vger.kernel.org, AJvYcCVwyUGaSFki1411LAOmIbThik3YA8jqRugMJCSQLKCIws71uaytCNs1vSRbCBi8NqOhBFQ6MKMNNpK2xBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywie5uKWHoG3gDhpub7wMdvnREgAXC5RHZjb5Ph2hvqGWYIAVhv
	Zz2FHJwCOV4KEKL1Rap15ohg2p5KzY2hF7g1Z0/0/oGHZUG7kxVbkb/F
X-Gm-Gg: ASbGncv/jAuMnIhTI2JW0rjxZdipwG3flLDxjDPoGop9HURzAZOG+ZNfE0srr5Q6YC4
	coCvamYOD/5dUXu9b5/3yxusXaqwa7kVC7AQHBRENhokUGsaQcDflEX7R6Ef6BxfGtIdDtM7Xy1
	+RHOHaQeeyhkfj8oTCMRcVMQDpIN9XXyfRRRGQDwcw3Sp+Kujq+e2QZ0DWbd8+rcwtsabKEewwM
	zL83gx5BnUVYZMzAOgHh3slarmVgClMec9smwUtSQa80axV9UG1Wd+zo/DgoirScaNa2ghlvovC
	uKqJoiAwC9vFgwlMiescOFC13ppMGu0ISA6pl623a9H/pI2SKj2sjiB6d/1zp4kjVSys48xSdlw
	a7JQm7ppA/SuGuiNMPVkZ/c1Hzc0rt/07AdlcuaaWNhfdK1fDtSkPmQVERw==
X-Google-Smtp-Source: AGHT+IH8omZJ5/mhFuoc1KdSVYF9KBYbkdeLjH5Qt7Z7UicftP1H2NZyc3zQNgwkZSoMayqlZgYIJA==
X-Received: by 2002:a05:6214:4308:b0:6fd:76c2:a2fd with SMTP id 6a1803df08f44-700024399acmr211363176d6.4.1751234002499;
        Sun, 29 Jun 2025 14:53:22 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771b50e1sm56878656d6.34.2025.06.29.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:53:22 -0700 (PDT)
From: Seungjin Bae <eeodqql09@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: pip-izony <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] usb: gadget: max3420_udc: Fix out-of-bounds endpoint index access
Date: Sun, 29 Jun 2025 17:49:45 -0400
Message-ID: <20250629214943.27893-4-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629201324.30726-4-eeodqql09@gmail.com>
References: <20250629201324.30726-4-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the max3420_set_clear_feature() function, the endpoint index `id` can have a value from 0 to 15.
However, the udc->ep array is initialized with a maximum of 4 endpoints in max3420_eps_init().
If host sends a request with a wIndex greater than 3, the access to `udc->ep[id]` will go out-of-bounds,
leading to memory corruption or a potential kernel crash.
This bug was found by code inspection and has not been tested on hardware.

Fixes: 48ba02b2e2b1a ("usb: gadget: add udc driver for max3420")
Cc: stable@vger.kernel.org
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Added a second patch to fix an out-of-bounds bug in the max3420_getstatus() function.
 
 drivers/usb/gadget/udc/max3420_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 7349ea774adf..e4ecc7f7f3be 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -596,6 +596,8 @@ static void max3420_set_clear_feature(struct max3420_udc *udc)
 			break;
 
 		id = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (id >= MAX3420_MAX_EPS)
+			break;
 		ep = &udc->ep[id];
 
 		spin_lock_irqsave(&ep->lock, flags);
-- 
2.43.0


