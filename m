Return-Path: <stable+bounces-197601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96246C925CA
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 15:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A57C3AA641
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0727CCE0;
	Fri, 28 Nov 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y40UwwV8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF0251795
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764341277; cv=none; b=HOWE/dZkz3kqnPM+dgOORf1CRZjEivSZNeN3hfMzFpPe++X0TRFIVg6SyfCKgJRNopwP70+MslvMBpOTuEjo/Szqz0HL+kOZqrxuVP5u53VeBspb/MUYV7iQTbbqQ+L0/XH91W4b+wahJCj/WOEPVflXvm8u7a4ZI2Hx3XyRfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764341277; c=relaxed/simple;
	bh=kBsXaBTbTfKM2axj9Do1FbixYAYlvJ2ocJAHzb3rwog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peGkm7aG+R1Z4GFnwbZzKPdrLhB62PZXW6uv6MpquL7qG5xYieby1AZnPSuHG+lGzbATR6MMbEEPU7ZaG367Ab1q9qj3lR5Pb8z4zLxXWcP2LJeEE0X9ke6yu1zgakhj5zQFmIOg6B9o3mowQfrG80i/DB31bi6raYOh9Nrpg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y40UwwV8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5957d7e0bf3so3136324e87.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 06:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764341274; x=1764946074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6/Fm/oVY95uFXuY2detaFQ/ocohpIH0USIsHRoZb9Q=;
        b=Y40UwwV8f93b/2anVNRU2FGNsOTTNhrozfofzHUHfYXVRjntSZAVok0FBAf35+Br6k
         YNkN4XMsql/b6dmbI+Iz3Uod3UYo1tRbmebWwog9NWoCPs1+EcM8RTjYg4qqxeb8CqMx
         HBbWQvb4TcTwfHPyHBNQhwUZnSc1urx1SUF8CPkCFnWGQEi7drfUSqY2FzJudSI5sX8g
         bHt+8OCtXI95VB269iQVAstQbM/xGU+KxcQ0NChNoJ1N0VonmalcmmiBAmcTg9q1Qu2g
         hcWssjaIuFpclqWa/hbKRGWsKhwzOGUTPx7qEfF5k4Bp/Q54WpT4fGd3OjoGH2MPDM8+
         Ik3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764341274; x=1764946074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6/Fm/oVY95uFXuY2detaFQ/ocohpIH0USIsHRoZb9Q=;
        b=SSTlbXgwJB5/kP39H19s0S3JPxOw15U8P98mEFdoLQzytQxw4O+HVTDFXMNY1p4F8j
         XFWkUnFyWG8MfdvvnGwoKU09s8yo3mK3az+oCx/lr/FKxtp7n9d4YoKJhuZrnOhOnk8d
         W62GKxdiYjvu5u4P4x64oST5PQfderEzXlYzq8ZmGFfp3chHOw+QIxE3NCSh5Dal3Li0
         YyJU9aTGIFKV2QJ856+FVL2y3szwTgNuOI3YgFr1J7S9vxDGIPFEpaHFhvcXkOMh2R2v
         NKQdsaCW6Bss6aKZ00mVqAMUiL1cALXsPoIZs2XGnaWbRF+9lngEhVOjtMcYw3W/DuRB
         2MJQ==
X-Gm-Message-State: AOJu0YyP3DxIvAtCf4eHeBJ/AxpVeH+YwOVQfTvAGaLCm7D4P2zGZDGX
	UnmGp0DHwcjTNaEiYt3RCIk0DfAbl1K4GZlxK+41c2+Tr7e/3bkNpHQE6zzWAiEODnkUQg==
X-Gm-Gg: ASbGnctTgetbCHNwsycDsQbM1IBs2rtu5F/VRhiQZEUrYEnG98OJxiEhP6rvUizq/L8
	UhJ5P3QMfgNwP64ZOJeJz/qTsk71wwVTH62fR5e37xnOdewNAnqVuKY3cqRKuYjMk1Udd/6MJzG
	hv3U1wFvBGQqrwiOtAbqlIJv/VFzlOgSU2SRKyaGcesFEKCvIQzoN9iVqUYqqcqw1QWnUl8HPKX
	PkvltuVEgy8S70ijj2wvu8FyHESLOdjYrJDMhTYYhTXk2UiwpGkQ7V25N5mw1HCYNHoq5oQCEob
	lKoZSZEbidbjtgcBQIPv5k/zB7/VFDK0CNMsQV+ONe0yljfjelymrsPchP/0J4uuIVv/BaqPb2p
	LxURNk6rMyWdFFoHQik45W2pKAK2At0smjrzwqberDwNk9I/2EXum/1Pd3SQE/Q3wcWUDd9OJmE
	pS2un9+xh+AjX0eMNP9Ypi+6qdQu31J78CxAsZAJkVP0ghn6h2PwFevyI5
X-Google-Smtp-Source: AGHT+IGri/Kcqai6Ho5kp6UE3YX9ridRldxzonTf7wiVODikqOhdC/WBm9NPMdz2N8FXWRU8ePEc8A==
X-Received: by 2002:ac2:4e04:0:b0:595:90ce:df8e with SMTP id 2adb3069b0e04-596a3740821mr10547766e87.5.1764341273519;
        Fri, 28 Nov 2025 06:47:53 -0800 (PST)
Received: from cherrypc.astracloud.ru (109-252-18-135.nat.spd-mgts.ru. [109.252.18.135])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa43e6csm1261533e87.54.2025.11.28.06.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:47:53 -0800 (PST)
From: Nazar Kalashnikov <sivartiwe@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <sivartiwe@gmail.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Terrence Adams <tadamsjr@google.com>,
	Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH 5.10/5.15/6.1] scsi: pm80xx: Set phy->enable_completion only when we
Date: Fri, 28 Nov 2025 17:48:15 +0300
Message-ID: <20251128144816.55522-1-sivartiwe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Igor Pylypiv <ipylypiv@google.com>

[ Upstream commit e4f949ef1516c0d74745ee54a0f4882c1f6c7aea ]

pm8001_phy_control() populates the enable_completion pointer with a stack
address, sends a PHY_LINK_RESET / PHY_HARD_RESET, waits 300 ms, and
returns. The problem arises when a phy control response comes late.  After
300 ms the pm8001_phy_control() function returns and the passed
enable_completion stack address is no longer valid. Late phy control
response invokes complete() on a dangling enable_completion pointer which
leads to a kernel crash.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Terrence Adams <tadamsjr@google.com>
Link: https://lore.kernel.org/r/20240627155924.2361370-2-tadamsjr@google.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
---
Backport fix for CVE-2024-47666
 drivers/scsi/pm8001/pm8001_sas.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 765c5be6c84c..85c27f2f990f 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -163,7 +163,6 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 	unsigned long flags;
 	pm8001_ha = sas_phy->ha->lldd_ha;
 	phy = &pm8001_ha->phy[phy_id];
-	pm8001_ha->phy[phy_id].enable_completion = &completion;
 	switch (func) {
 	case PHY_FUNC_SET_LINK_RATE:
 		rates = funcdata;
@@ -176,6 +175,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 				rates->maximum_linkrate;
 		}
 		if (pm8001_ha->phy[phy_id].phy_state ==  PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
@@ -184,6 +184,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 		break;
 	case PHY_FUNC_HARD_RESET:
 		if (pm8001_ha->phy[phy_id].phy_state == PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
@@ -192,6 +193,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 		break;
 	case PHY_FUNC_LINK_RESET:
 		if (pm8001_ha->phy[phy_id].phy_state == PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
-- 
2.43.0


