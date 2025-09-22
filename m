Return-Path: <stable+bounces-180976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B62B91DB8
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1427189E9A0
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD532DEA77;
	Mon, 22 Sep 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYVJ7PfF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F726E711
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553846; cv=none; b=H55UHS2AovfRnNCeqcEgsL5lHzLYmINV7IU4wEMUuI/pH5l3iUid8RnLtme6y/N7+Xry1Xsvtx8x6QDIiJD1eEvvouIOXicqQpy8GgJ/HvfNs3r/baAAr1yr3A1Rwm/uIRRxElmygLTeVC+m0gmPfsrgXWMj31xob/w3p4sDrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553846; c=relaxed/simple;
	bh=shbNuIMNTIvGPcWi4JkSEiRj/eJEUs+EDGP+qunsASU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7N7/GVviLCRm8e3UtPK8C7KjlSNEzKk7vfoi3IN/1hkagbSOLemN45IUvuFQQbuAD6ZKH4iYSnuWnOwBceHSVtIdJhQ+esJS2G8a0+K8ivHCDbziDmSr6j+0Q6/Y9Co7f1A3r/03ZPd3rZut9u7ujLOPIDjYWFF4wOAu+9L3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYVJ7PfF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-269639879c3so45346955ad.2
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758553844; x=1759158644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeKEMoq0INFY9SFzoLjx1GtUOLFalE390u+VhOEOs1M=;
        b=EYVJ7PfFjSfLOKau/jKasLl7nQJdViXiZ5n/VZ2TTlF0tjghV0yAl1gFJvKVYEjs+Z
         xpvlS5OLmCQndRquF8TxUHSKIody51f5UU9ihusrb+KPTbE0gMdOrPLLNxR3i20JSUfJ
         iG/qLpM9ZpnUkgcjEf3tw287BN8r+wo9lHH0tbSrDtyfT2x9hWa1m4z3UtWE5vgkwXhn
         cFhQH45TD/X7pa7N6dVGqoW9z+cmdBODc3T61sm4tGZQNiIV24KhkDJ5jtNvWxZt/MOL
         Ec6ODpiWyUbbG02MqvM78mPedCFcQo2Zlk90V51qjUD2AKW5iQX6xwYyiDLxmhhuk+fM
         WZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553844; x=1759158644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeKEMoq0INFY9SFzoLjx1GtUOLFalE390u+VhOEOs1M=;
        b=QGWhprD6vIHT38nnuPa8I2MtIMH3lBonUCNEX6iOFJWshpeEoQmju0lADUazZ6uVpO
         A7hZkM+iyp79GfuhyJNVqWyrmJLMuCWWioSkCkg+yMIRSxyKGPpXLv4zKWWgNA7qVVUR
         gGhEb3wbMevboqOT3pf6icjVH3VIS/sI9mxMUshXdbvOCouw8i4EgBxKJob/ylt71wKQ
         AXdWYuR2rq/gxysejNcRAN1EW5vohV9f2e1jnIqDAPxKOvR6Ex3ULTT2eHyQtN155o7L
         sjCVcfQTt4YsvEz3uhrfnY+oIVVDjAvzQFrQwsqEcGC4O8OxVTqq0d24U1tV0RWAllXt
         BDFQ==
X-Gm-Message-State: AOJu0YzHxlDTGSI1Mz9pND/9BwzPljhaTr9l/FMMWKhZjtnTQNxKeQFG
	swrrq3Qc4jX9TzZHGZN98PoxSKKx2AStnWhN3xLZ/xaejkqL70ybPSHE
X-Gm-Gg: ASbGncufPr7U2heoSFnouI5vvJxcYY+HCoJMcxmxhfvg+AzfjVDFKdPMeSZQRm8EjUE
	gx5xGbGcOCyLiMt/8nioOylwu1KrCui1iEw1Yoe7i9OhCkHgw6k4qGSIzL9a5AL0PTa/vESnLgr
	BAfI51jnh+BIRytNohfs5w5R4/McWmAVICVzaXLARbutUzPd5ocf8Oapt9ZXIRcwF5WqaS8gCki
	7e1qSp3KtkRAUOpe8sgtok7Z20OLJiLIxQCARBTSSUrtl9o72Z3q/Hair0h0cUFSCFbFKuthJY4
	o1CIYX1GT5NjxumjblGBLcSDiapKGHJ93uJycc2/dgVxW/18Knc7ak8M/H4npgjp3elDSTUK9iN
	nlRbMiveIkt7cN+KWmHFhEMZS
X-Google-Smtp-Source: AGHT+IEvD9hsVBCMMBEEbvP8hFwp/v5gBhfqce58IDIzHbs1uD6mT1IGXhLlfqK/ToCU+antLZSz6Q==
X-Received: by 2002:a17:902:db0e:b0:267:cdc8:b30b with SMTP id d9443c01a7336-269ba554c27mr147031635ad.53.1758553844543;
        Mon, 22 Sep 2025 08:10:44 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:3d9f:679e:4ddb:a104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980180bdesm134733995ad.56.2025.09.22.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:10:44 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	"Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] powerpc/smp: Add check for kcalloc() failure in parse_thread_groups()
Date: Mon, 22 Sep 2025 23:10:25 +0800
Message-ID: <20250922151025.1821411-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
---
changelog:
v2:
- Return -ENOMEM directly on allocation failure.

Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..cfccb9389760 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.43.0


