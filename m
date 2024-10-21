Return-Path: <stable+bounces-87558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B999A69A7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65681C22859
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5B21F708F;
	Mon, 21 Oct 2024 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2CRbzYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4541F4285
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515788; cv=none; b=YkNp4Tq0r4Dv86425r174HT5LiOczI6vv7EALvUKyqKi7kN3C8RUPwzqVzAoqY0cuLZwImPbX3RP9n8hoE9XGZEBHcDoUEyASYvmNOLb0cViEz70Szxaha/r9DLzxLZ6WX+tyYXXm5EACUJ98X6zlXes1ASieJY+ubIX/Cr8wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515788; c=relaxed/simple;
	bh=pbNLGhRF17OowmZvC/zBoVenGqEeIZUgiRPs3r23FRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEeArZt5T6ba5ptFcIvSArZiAByGo3bqxoD7f6FWzH8AJp1RvTJiGwtHc/NonULQIcHcz8i8GX0wa0rnHz/o6U/KJRP12aYsXckaklglNiyBXKPWg8gRgK3vQfQO33U0c41ewdH1oLfZMSD5B1o3umDZCBWjPmaZGXVOsMqxkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2CRbzYK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so48798261fa.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729515784; x=1730120584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uffe5hTHXC1N9IpKdOMepaRpviJ24IOWzAUyLrjTbsU=;
        b=X2CRbzYK49b8CKphoKUHU2Z04LzJg9B2Rr9kLSJL+peTN5xaC74PSeDrqkwOg/rjNJ
         S92mz197BObzGylQZqW4qlpqYKnzoYTCAHrilofN+kiHTVmfrKZUUYv+sWYw+MhVvkoS
         cZKlkPAgqOTIWE5tpQ+buihGqP5+E3/ZpSD8svL7sn4ZPleCooNetHZnItHOtLdwttXc
         NVD7xFMB05OObBBDZ5dRIoYQoAwCWJ6KVBpccb7+02j9DgWZXBGxapcwFuA2cOadAWrZ
         EZv0bSWwerYgINie/+47XJP2Qj3wP7laGT+D+W140iXEtclZGXA9gDjRVKAjKaGZUUJJ
         AySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515784; x=1730120584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uffe5hTHXC1N9IpKdOMepaRpviJ24IOWzAUyLrjTbsU=;
        b=Qq0H8WnPhX/+R7zF+tdS2y7XHot6NhZmZQr9yBOs+1vGB8k98g0LXjsAjMyNq49DQE
         MeMM5Qfx66GsScDqggxq2ccumoMoBapgw/7pWs7Fkrd1oVDiIyJ3YZI1Z5e7KC+x1ha2
         2hYnMXCi3CFe9H9ZC9ZxcO/ag1p8KFhFaDTY40qbKV73oEh8jK+7pu750iyGQHz0zCDH
         TWpZLmXjOKY1LsQjEGrJDeR+/Zx4IYnSDl0rnyOx8lg28dhL3U5vAqtEQmQbC2vQFo9V
         IIdaAIpn+2HV25MgyTZaYkMXjwMUbzwFqcmKbmuJvBAxSWFM6esW4H9nHOKzUn0FGqSB
         IOlg==
X-Forwarded-Encrypted: i=1; AJvYcCXBsqpzLxV/qCbihJvV4Hv6wuBHdeVN+TwfHM7Z9JGg3Gie0uU2KD47mTy7QmtWaWh6ecFrLSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8S83aenjwQrHvGbCD3TWMwa9rijnFL6Ay4KghwZkIEwWwP82
	1ZOIPpgfQKIpkTSDjQ6bTwN5mqHMow/aZkl6w9gMZEbjE93rcLqc316idptfpo0=
X-Google-Smtp-Source: AGHT+IGO/4EX5avkuvXfScYCvhLu3iZRJMQg3BFD3nkjwgwkjHvopwRBrppx6dTV4/UAHlINPapBpQ==
X-Received: by 2002:a2e:4a11:0:b0:2fb:599a:a8e9 with SMTP id 38308e7fff4ca-2fb82ea2942mr40762811fa.15.1729515783475;
        Mon, 21 Oct 2024 06:03:03 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae24d51sm4808351fa.130.2024.10.21.06.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:03:03 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Oct 2024 15:02:58 +0200
Subject: [PATCH v4 1/3] ARM: ioremap: Sync PGDs for VMALLOC shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-arm-kasan-vmalloc-crash-v4-1-837d1294344f@linaro.org>
References: <20241021-arm-kasan-vmalloc-crash-v4-0-837d1294344f@linaro.org>
In-Reply-To: <20241021-arm-kasan-vmalloc-crash-v4-0-837d1294344f@linaro.org>
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, Melon Liu <melon1335@163.com>, 
 Kees Cook <kees@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.0

When sync:ing the VMALLOC area to other CPUs, make sure to also
sync the KASAN shadow memory for the VMALLOC area, so that we
don't get stale entries for the shadow memory in the top level PGD.

Since we are now copying PGDs in two instances, create a helper
function named memcpy_pgd() to do the actual copying, and
create a helper to map the addresses of VMALLOC_START and
VMALLOC_END into the corresponding shadow memory.

Cc: stable@vger.kernel.org
Fixes: 565cbaad83d8 ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/
Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Co-developed-by: Melon Liu <melon1335@163.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/ioremap.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 794cfea9f9d4..ff555823cceb 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -23,6 +23,7 @@
  */
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/io.h>
@@ -115,16 +116,40 @@ int ioremap_page(unsigned long virt, unsigned long phys,
 }
 EXPORT_SYMBOL(ioremap_page);
 
+#ifdef CONFIG_KASAN
+static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
+{
+	return (unsigned long)kasan_mem_to_shadow((void *)addr);
+}
+#else
+static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
+{
+	return 0;
+}
+#endif
+
+static void memcpy_pgd(struct mm_struct *mm, unsigned long start,
+		       unsigned long end)
+{
+	end = ALIGN(end, PGDIR_SIZE);
+	memcpy(pgd_offset(mm, start), pgd_offset_k(start),
+	       sizeof(pgd_t) * (pgd_index(end) - pgd_index(start)));
+}
+
 void __check_vmalloc_seq(struct mm_struct *mm)
 {
 	int seq;
 
 	do {
 		seq = atomic_read(&init_mm.context.vmalloc_seq);
-		memcpy(pgd_offset(mm, VMALLOC_START),
-		       pgd_offset_k(VMALLOC_START),
-		       sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
-					pgd_index(VMALLOC_START)));
+		memcpy_pgd(mm, VMALLOC_START, VMALLOC_END);
+		if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
+			unsigned long start =
+				arm_kasan_mem_to_shadow(VMALLOC_START);
+			unsigned long end =
+				arm_kasan_mem_to_shadow(VMALLOC_END);
+			memcpy_pgd(mm, start, end);
+		}
 		/*
 		 * Use a store-release so that other CPUs that observe the
 		 * counter's new value are guaranteed to see the results of the

-- 
2.46.2


