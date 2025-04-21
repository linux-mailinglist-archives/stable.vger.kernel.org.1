Return-Path: <stable+bounces-134871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20652A954EC
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 18:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091CB18840ED
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707031DF987;
	Mon, 21 Apr 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGFb1f0Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E159013D53B
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254219; cv=none; b=RZ2CvsSiqFJxSo8ji3IHKksMBMh8W6W8ecdUO60sT1cGnwz/+pZzRC0M3nio+n0/lrBiZYCWhwUP0SKkLJyzaYPawixxcULmu6g3u3ZI8Ou99cXF7P3bXoTjRh+Vt6fuBdZMztzpvgLG6jWLE8Dp8MaKkn04SlMGHfUA8LJu1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254219; c=relaxed/simple;
	bh=uIQnDo8OhHMomo/3wbZsV9Zo03sE3k05zOEqO4y0BQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1WjM3ZvvyxkcrOoev9WdnLfrqu7Ee46OypPlEq1N36x4HGGcHcec+JYIgGIwSX9oSIysA0rIG33d8GCa55dYbYVo1HCMR6/PM2LC95Jk0iSzofx2m4/VPCZTJQFsmFs5tDZXkyqm2F0UqB8qke3SJc4jlSSYaHWdUFQ8TPRWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGFb1f0Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33e5013aso47131005ad.0
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745254217; x=1745859017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13svCrKPbDl9rHnNdnmiLKT3ce2oiVKAbFQB+3TJ3n8=;
        b=SGFb1f0Qgj5l23xmR2G5uKNDdlFIlevN7tVlZrlWEZzK9wDUvMULG6yO8IuX+LMGcS
         V/dnIltKjP0Ff5BeQ5CuziUiqO5GmZMdap6CO0oAQ4y/xQryiCwk137q1dBor7ub+BHG
         vHonT/Cz5o+Qt1GjvyUSO/lvxSvBnasZDtYkoPzoiG+fXfd7XmntY/qp/qlf/wn47O6W
         FNb1cQCENruWTDEiKaa5nKD6Ah5RmkPPPP4UTiQdVmqEMuMgn8P1Fh4NBSzaN48uSAz5
         cTTTm/Q7FoD0z1OLcshfN+ThQR1hpD4EtmCFPoEZwVYTRzUFlhofjSPajCbGcLnmdusX
         D8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745254217; x=1745859017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13svCrKPbDl9rHnNdnmiLKT3ce2oiVKAbFQB+3TJ3n8=;
        b=kTR5PMbPL+rMSeS1DWZEo7C827BzG70zzCoyBx2zG8QXZCVy0qeRHjbCLtrHgtmzjC
         9hfj/rLUzexZNAuiLQ2oHSNfQ9SFeccb3daAtZkfRn7PRr/XLzueFOpLsJvpMkLKG1tf
         lNFVZ5DIotk8wXT678I1lRwD9P8oRwvGg2RLQZ3V3NC8F03p/wgf9ZYygsVKyi45zpd8
         gV4HJeaU8/y3Rs7NteGoEZW8kl9SF6Um4zjXJmXehTvDfn9qHzN1STYajtKn1j7nAA8D
         DbbS9/AankepMIapHPh4x37+HGYu9UOPkGV6I9d4aQZN4NnnAL76CyGuF4Ek9KzHBU/t
         BnYw==
X-Gm-Message-State: AOJu0YzpqoNwVLG1Elxd53PwWCBF3ri+zTRKKECZ2/lSWuyaCO3cBVWV
	18H7JF1XuK2Bqw2vXh3LX9M+EE03BTLVAQXQhIt4+rE2I6HBXGtZ0xy4ZA==
X-Gm-Gg: ASbGncvPhAfytEkL/ocum+MpuJ4GiDmm7PSJ84PD9zhJ77tZW8tk6JyKcsnEW2zwuAS
	ZBZqlwdAyrO2MjYFEZwiyTVpuF0IXq3PWby+LBzQpZIWb3LOOlffCEEhICl/x1YU3Ji6zVcZ65R
	5/TgMUyJBAzr6nfZzf+SD0yrhQyyw7Wl9o34NGtn24fG1iEFuy97VcQ4hFM7utEjxgTWhC4F9gT
	ttInTjzihGc4RNh+NAnpZIndx0sVrZIJJZ2ndD7dIHUhH/Xjt4EMqdactJPlkK/ttddT8MOJ5nR
	yYCig7skVDu3s44b8qwubI7ILapbYm0i0stjfZjzCXAfLY85Vw==
X-Google-Smtp-Source: AGHT+IHB1C/ct5M79Rx/DalKtPK0pC/0464y7Ji5cYQMhBW37q1S4uVcgC2Lr1CFaHbff3meXkt1Ag==
X-Received: by 2002:a17:902:cf0e:b0:223:5241:f5ca with SMTP id d9443c01a7336-22c5359b672mr154794315ad.20.1745254216843;
        Mon, 21 Apr 2025 09:50:16 -0700 (PDT)
Received: from localhost.localdomain ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db1461b3csm5786878a12.47.2025.04.21.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:50:16 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.14.y] platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1
Date: Mon, 21 Apr 2025 13:49:53 -0300
Message-ID: <20250421164953.9329-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042129-reliance-rewrap-6d6b@gregkh>
References: <2025042129-reliance-rewrap-6d6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some users report the Alienware m16 R1 models, support G-Mode. This was
manually verified by inspecting their ACPI tables.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250411-awcc-support-v1-1-09a130ec4560@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
(cherry picked from commit 5ff79cabb23a2f14d2ed29e9596aec908905a0e6)
---
 drivers/platform/x86/dell/alienware-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index e252e0cf47ef..6067a8b630f1 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -248,7 +248,7 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1 AMD"),
 		},
-		.driver_data = &quirk_x_series,
+		.driver_data = &quirk_g_series,
 	},
 	{
 		.callback = dmi_matched,
-- 
2.49.0


