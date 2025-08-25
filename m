Return-Path: <stable+bounces-172805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E7B3386D
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30411897DFC
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0402F28F1;
	Mon, 25 Aug 2025 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk1OJqQ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63860280325
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109068; cv=none; b=pKQUvBr62uUxhTsWc0adNGXiqCFzgalWSHKvrbNHKMnx0OXuWvwlJru4ntR28LwtfacJgnE+HyNX6toTmayVz44GuJPukc9lIpnrpaM0JJOvSLKhieQagEh5OEdUA4dR7d8FF3CvmqKi28xoD42xZC7lA/a708UZdZXrspVtBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109068; c=relaxed/simple;
	bh=Y+k+W/vMhPf0mvuXevY/eIHf6BtpanPCKcBBAKb/YOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTYaDdwxUX/yUzJF0kJa6KbSOaJJ2nIiXmBcm4PBq5p9i246HOQHLzB32o88w8Ny9tAFbnja/f7BdBmS2zga5ut8HY1It7IOVKs1qFLPlhHuhbsV+zXl0Rb96ZjryZ12XeKJc1NaRUsVHEKLv4R55Fidq/BAVvvOyIWgoG3bmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk1OJqQ6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24687a76debso10922745ad.0
        for <stable@vger.kernel.org>; Mon, 25 Aug 2025 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756109067; x=1756713867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMUmzYmAF5Gaj+A/dFtcQDl9hQeLOunsoA+hVnSc5OY=;
        b=dk1OJqQ6nKOjOEXytUbqMz9jZPIHHim6k1wT2j8ErWOF/jIkibJDEv1VQXpLap7pE/
         6/lYD99DDMo9UgqR2mWmJeIOpnQAkPn3UVZen1y7cdfOGYCqpBVhss0PpHgMpxNQR+/6
         7xbqAD8lhfC8sQEzp+2vQkr5deIsIsoKWeIl48twqAcB9prRllw4cStQfJAaJ2wBik/s
         wfg2LRA2La7jO2BL0H8Z0ThVoJsmVtlu/GHehanQPbj4O0kdLuOolj1A6sRVHvYJq3cS
         NGdlQPY5aPN4vCcKihxubND+h0mu+Hy5JslcSCefzUSDGWPxb1roqla5HkH2hZYZkFKe
         NcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756109067; x=1756713867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMUmzYmAF5Gaj+A/dFtcQDl9hQeLOunsoA+hVnSc5OY=;
        b=TCpIEX9FMBxmjEPUl9WrXXtZZou13osh0r+sqmZwdCQkQDyo7avHkH1jfFz+ZjG/28
         ZJskmsK+S6KsN2bBVTBkZqaQ4FM2B0quIA1patjta/yNaNmPYqEjqtsVWoXzgdbm+8yr
         +w62AjjxMtCj8JLT0ppY0WAAB/BH/4MLG3AxN616lRoRw47M9D5R7FVz2dTHz0A+wQnc
         omD8d/e8PhxqbRZBgYBSdgfAY220uWk3vw1/x29ZK2FlN1te13Us32aAZ+Qv+86u7z+q
         K+LEcwiy1yFU3dgwLNa4Pzog5R0gfwV8Vd2WR6QxYtexSIZVN+LQHF65MKZ7YFAgBKgs
         J2/Q==
X-Gm-Message-State: AOJu0Yw4vjS2SS8iKnvKGXnPJ5T1ZH9WxjDeXhhFVrqX8ob+eBccOmTW
	uA1VNjMdGjoG8K+oQRnY0MmLFUovoq0nm+PpbIIv6lNKpadacXfWos02gCwMID4v
X-Gm-Gg: ASbGncufraJNpg6VZ+VS7JoSsuhf8GR0ZUXwZmeH4hWQOLuBI+TsQEq63deoExXO5GZ
	o+vMQc6t1rvdtBi4GVe8M0BZuEhfT1QpP95uPF0FvUUpWlOJr2kQkX9NczHo1bhwI0kufcvblRh
	yNDlORq37mlKC7bEgKMqaOoLgcc+16bmmBO6oB1++vQ5S5Yh9XNefF9pSUZwT1qWve8fk451CmI
	jVHpwYNcLgBPxu1yCC9nCEqknJhKdtsZdaf27gJnyyqXGhEUOQUDfmpgHgh3FR9uvqSqfgtNpF2
	y5RFIyx0aiwY8r6Tf6S8rQjLlub+JeuY5qV93x4BzcGESm6hY2JYdbojGqTgCrvrelYBXEC/stM
	A+qlTDQk5mIOp+CLFIcW0nmtwRV+ZwG8BGi6aRqk6sGClINeM7gBMBRfUgWWF1lF70Nw=
X-Google-Smtp-Source: AGHT+IFaFvSBv0c6fR1VHmaWWMyCp89amsYYmHx15PwYn4DMS3gbnhs+u3AyY4kPxDe920srFlednQ==
X-Received: by 2002:a17:903:2282:b0:246:ecce:544 with SMTP id d9443c01a7336-246ecce0c47mr15040555ad.12.1756109066515;
        Mon, 25 Aug 2025 01:04:26 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254a4d9159sm6321745a91.13.2025.08.25.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 01:04:25 -0700 (PDT)
From: Tianxiang Peng <luminosity1999@gmail.com>
X-Google-Original-From: Tianxiang Peng <txpeng@tencent.com>
To: stable@vger.kernel.org
Cc: Tianxiang Peng <txpeng@tencent.com>,
	Borislav Petkov <bp@alien8.de>,
	Hui Li <caelli@tencent.com>,
	stable@kernel.org
Subject: [PATCH 6.12.y] x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper
Date: Mon, 25 Aug 2025 16:04:17 +0800
Message-ID: <20250825080417.1550923-1-txpeng@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2025082516-casually-shaping-7c9a@gregkh>
References: <2025082516-casually-shaping-7c9a@gregkh>
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
index c5191b06f9f2..d2157f1d2769 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -15,6 +15,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -116,6 +117,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_init_hygon(struct cpuinfo_x86 *c)
-- 
2.43.5


