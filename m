Return-Path: <stable+bounces-172808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E021FB338A8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532C417EFB9
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4821629B8D3;
	Mon, 25 Aug 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx7HC4SL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1729B8D9
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110174; cv=none; b=VKqL2cqSVl9IvuGkRSbjCwfS6yD/wULzd/UqKGCrR+eaZztl+Se8Je0Ip1jJVl2G+Gq/vJ1bDoadv6gSDOiFsTV4bkfOZ2XuvJhTrRCE8WPpYmLZ3r40An5HkwaGQzbAia7Iy9H+71RlPvPSYVavnWUQmMtdoD2DfIYhndC7mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110174; c=relaxed/simple;
	bh=EIdLD/MXYqsQ0adRLiJAC5sTLOD0GQUTcGanl1KnRSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhWof/vruJGICiec9vAbMjClVh8SCKTO8vFVBUokoZMZJbbQs8rOhLSqXCdWx3ql8phErmc9w3HOVvSvMEZZfAdTBwzS9w/rd/c3oi7s+kNSS1VddujSd5/1jEprWD3w8EaPK5QTlKkUMM3mrflbdyvUNEiMhpt9XJt36qVNEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx7HC4SL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so3341131b3a.0
        for <stable@vger.kernel.org>; Mon, 25 Aug 2025 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756110172; x=1756714972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZBTgFlonGhz6EpmHeXDQjxLoBXSvw6xTBfh/7pBT9E=;
        b=Wx7HC4SL4BU1UZeZniz+d3f59bhnR+p1lZ3fT5hql1SZXif5D9hgKjWSnOpMrOVX4C
         TY/Vxq/LcVE+OvdyXgtudJpNLmc7F6rnVqyKWTK0Fw/7hmImkMO3UzzenIhASDhWxSxH
         79KupiFTU1i5Oep+r+0Db2bj3Vw35Iud/v4qg16z1DwspIbcwZEyEwPFFDiCWUzfmRez
         8b4DZjvUnDQPdztslgJjL7oMe4MQQUxeB0c94YMl5Y8i7lEirXM+1b9GvUe06Ycqz/2v
         laSAWI/sBKvVkr0PI1W1pRxyxoMpVG+YQTS5bB1iK81vUXda8z93Niz/kmb2+0VtwZDJ
         l6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756110172; x=1756714972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZBTgFlonGhz6EpmHeXDQjxLoBXSvw6xTBfh/7pBT9E=;
        b=i6RUhINL4RtTSSCkjBGD4ibb+epFvGiqa0cOeOUTX32Sy/Kn2Ktf2RHs85e1TvkW78
         VCxebNdXHqrMrtTYuSp8r8qqB5/NQzC+cUAjNXydIq62ocjG9axKK1YpdoM0Lb44TOjq
         dhf3leDbMx550kgN7zU8QNF0r2cxDtNf0zvz01dmToVXuX+mrvoU1ZHrLP3b5FDid4Sr
         UwZuOzsHp0mHTTHn7xmWoxORMxdjA6A3TzJa/IgYYMob8LunqF5wPx6qj+vPXsNs/cye
         dTlD6IR74EZCtwxSiKaumhy+yrvz1xAn0QrkgcvSnJOCjnF7gOOn3PsysJUeIViKzYfq
         JdAA==
X-Gm-Message-State: AOJu0Yw9QxYQpvLFPzW+EZFZv/M2DONt72ulvEb5gExb6OiVz6i0mDSO
	Y7I+jV44f1UNwEWtrkQlZyd7N2kvVJsLaeBREdedVuvW2fmPSbvzcjDSD3POCL/DTEs=
X-Gm-Gg: ASbGncur6DUDvB+CDvgMG5q/8D68nQiz/7E4RBvZ+DbQRBrCrTy7d48EL7F/Q+F1Gbs
	gL0Q9jUcHWkYzNR/o29F7kzFH4+Ocg2gKXn506Mmwq/rz4AT+7M33jle7gh2tERroDzlm/8fv6c
	SmqbNp37HGTwZy8h1nl4DKj1/s2R6GS7xtu/poV+a+ribT7P2fLrNDeq7DhXbQ/WvIu270TNKx8
	gvLlGtEvd3H04ZcDgcXmgDk88hasn+ZFn/m2sfVjha6PqB+kblFPYMJUpTzMKrnV0KPVOSW39hG
	Izn2SRajsxyr7HHgwh/oHWGFZDfmSW2ljMJ8ha1jXXrrekf3udPOYGpEDDF8inK88NYXiG2siEe
	nrA/kLct/tXfV5lQ/OaogM50+u2E1m5AfBp5GWWXF/ThZztzDpz/KnzEK
X-Google-Smtp-Source: AGHT+IGpp2h1IlaZDUO7CZmS7x/yKAsJ1W8mpK98ifU67mvTfW0qm81DnP78qnji1lHIv97sGBBxJw==
X-Received: by 2002:a05:6a00:1d87:b0:770:4ff5:1d2a with SMTP id d2e1a72fcca58-7704ff51f46mr5317963b3a.2.1756110171573;
        Mon, 25 Aug 2025 01:22:51 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ebabeeffsm811929b3a.30.2025.08.25.01.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 01:22:51 -0700 (PDT)
From: Tianxiang Peng <luminosity1999@gmail.com>
X-Google-Original-From: Tianxiang Peng <txpeng@tencent.com>
To: stable@vger.kernel.org
Cc: Tianxiang Peng <txpeng@tencent.com>,
	Borislav Petkov <bp@alien8.de>,
	Hui Li <caelli@tencent.com>,
	stable@kernel.org
Subject: [PATCH 5.10.y] x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper
Date: Mon, 25 Aug 2025 16:22:44 +0800
Message-ID: <20250825082244.1698472-1-txpeng@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2025082518-attest-grit-8063@gregkh>
References: <2025082518-attest-grit-8063@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since

  923f3a2b48bd ("x86/resctrl: Query LLC monitoring properties once during boot")

resctrl_cpu_detect() has been moved from common CPU initialization code to
the vendor-specific BSP init helper, while Hygon didn't put that call in their
code.

This triggers a division by zero fault during early booting stage on our
machines with X86_FEATURE_CQM* supported, where get_rdt_mon_resources() tries
to calculate mon_l3_config with uninitialized boot_cpu_data.x86_cache_occ_scale.

Add the missing resctrl_cpu_detect() in the Hygon BSP init helper.

  [ bp: Massage commit message. ]

Fixes: 923f3a2b48bd ("x86/resctrl: Query LLC monitoring properties once during boot")
Signed-off-by: Tianxiang Peng <txpeng@tencent.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Hui Li <caelli@tencent.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/20250623093153.3016937-1-txpeng@tencent.com
(cherry picked from commit d8df126349dad855cdfedd6bbf315bad2e901c2f)
Signed-off-by: Tianxiang Peng <txpeng@tencent.com>
---
 arch/x86/kernel/cpu/hygon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index b49f662f6871..531d2fc049b5 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -17,6 +17,7 @@
 #ifdef CONFIG_X86_64
 # include <asm/set_memory.h>
 #endif
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -259,6 +260,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_init_hygon(struct cpuinfo_x86 *c)
-- 
2.43.5


