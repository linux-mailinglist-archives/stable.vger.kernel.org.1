Return-Path: <stable+bounces-191393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 078C6C13143
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 07:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FC2F3530E2
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C51C5D46;
	Tue, 28 Oct 2025 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwVffNQz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B28D29C33F
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631729; cv=none; b=F+VsKZtnBsfvxQOnMdzYTrCWj/MKRNA8pQEUxCtOiAfi+Uj3qD56eMw4rhvx7po2dYTtTxFqu0QY2LMZwRoDHKR4M6i1xSZJWgM4X5/D39itajsliA9IDl2/1IP3gvgoEewirYE2ujaQNfCTC8OoYk2wlbuckCRM04P94aF8ckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631729; c=relaxed/simple;
	bh=q7Tc2QsMBaN+HdSGE3XhX0GNjhdhA21Ns2bjotQEtBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q6bfJNUh5OK1PPRNkoplHeQz9oa7Kxaot+WQCSyFM2florbrlWrsIsmwUnYJAgiq2OxQPueAr7whgewTERqSbsYOC7N+t6GIZgMc53SnRmOvQezGaIy0oDydA4TUj+10HUIJhT6SDs7nntXom0cwMai8u4smZN8gVCJoKNm5tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwVffNQz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so4325067a91.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761631727; x=1762236527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtQOQB0/xeiaea1mof+0CkoSu6y09kgD2fJAIO20kBU=;
        b=BwVffNQzNrjA44edQduAm31/Ty1+eD1ko+O4xUYxdOqVIm1Mcbq5LNZ51gZFDMx6oz
         yctWAtLsp8LlKZAQUrtgGHv/Y8h6qntuXD/bqkBiJTQCMoZYk805s1rJwaM+9VPs26mu
         EElDlKL01yxVt0sem3jv4wlmkEvUZKk6sm9HZDEuYja18cKdmkQavc9w5/nR4zlc8o9X
         bddjEKSReP54w+lofIR/6jTmQtVWEhrpWsPDlNaLlkhmpNG6oZe5UKEG3a6xojMM3NS6
         m8xP8Iud3W/RU/JGX2luB62fvOYulnRbS7bX5QnMHtjbnQAeFDcpTIL4wF527QkBG6Ev
         DjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761631727; x=1762236527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtQOQB0/xeiaea1mof+0CkoSu6y09kgD2fJAIO20kBU=;
        b=SGCW/CYUxldt3MLBj3atW+1Wh10P4IFVLqpPKomyjv6l3Op+bPdZdey3cxmxadd7BX
         odcFND3yMpx8fvJvTJ5/XWT2QI/cIiciZcbH5ISKzhocRsq8l2Zzb2Yjwroqq1Zei51K
         q77IgURQNaWu8NxkHMQHZH9GkMiROPKDSQC++/MLTJB4TSh9FW0o5wVUvSpX3NdtN57y
         ouogZOsBogMeIKR05ErKPtGlQYwF3E056QMtS4kn5P9vQ4ipNudF7+oxgAeJObp/ULqv
         aSqV2ZdkSFt0QMBclp/zpfh+zoYhBP4tmuVvmiciglux0D6LqonrBgHia4kfOcD+AHSg
         uoOg==
X-Forwarded-Encrypted: i=1; AJvYcCUo7//zjcYXqyhJ6qaJqgiALWmmuE3jhbo17qTFIqiSpr3NVjvoE52JsGWx4JEBQ+byvzKiG+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJc4aiUfIRHG7Z1766GSo6HxB0ZNpx+awCO7r7Jfhvte2wMDEU
	JFkCingBIK09ioanzqUrsUc8w0xNBmACicgb9A5KunxfVPCyHUjpuz3I
X-Gm-Gg: ASbGncujkxZhd/II8M4psj4UWEf2pxjDHDjm4IJXon+RJFD8WkvQKWfxjqCNmj3ppUS
	UnThwnPzV4F4F0i+xqqJrXd8g9LOLZmt+9qxc8fiYsUEKsCXJS2DwlWd27F0d5pPQ3jyPkSWN4G
	GO+8VffHL5fe7NRi5IqYUyK7q6rZ7jxaxnb365GTGtt5nP5gUOMvvVOz6rGj20tIn1TcDQb2WTJ
	+Fa+jKV+6tm6k4om9RqnPpcrwpViHTTODopZwyPMMTR0WfIfsTvGIlj/CKX9xfQ2fH/WDuuREAF
	UKgTEsRpuzv1dVeuwuGOjyp4z/TJt6d50nhZMC1lezINCDobyo9g2mwaARXQ33eVIuUjCI0XwNX
	AdydTbofTfK1AJ8kklEBfEsI8qIetmNsa25bxVHwBZw9a3WfHRuhcNtEKPuNjWyFbdS4JFjucGM
	t6kSH3PEXyeJm56hDroqZcBQ==
X-Google-Smtp-Source: AGHT+IGM18PVXmk/Ly4QV9wJ4WdGZzC+O29UfRf1c8szMur4qUVhZWR85AkuIgff1YJgN9jGYRTafQ==
X-Received: by 2002:a17:90b:58f0:b0:32e:2059:ee83 with SMTP id 98e67ed59e1d1-340279e5f8bmr3103225a91.7.1761631726760;
        Mon, 27 Oct 2025 23:08:46 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm9533462a12.5.2025.10.27.23.08.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:08:46 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] thermal: thermal_of: Fix device node reference leak in thermal_of_cm_lookup
Date: Tue, 28 Oct 2025 14:08:29 +0800
Message-Id: <20251028060829.65434-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In thermal_of_cm_lookup(), of_parse_phandle() returns a device node with
its reference count incremented. The caller is responsible for releasing
this reference when the node is no longer needed.

Add of_node_put(tr_np) to fix the reference leaks.

Found via static analysis.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/thermal/thermal_of.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff..2bb1b8e471cf 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -284,8 +284,11 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 		int count, i;
 
 		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv)
+		if (tr_np != trip->priv) {
+			of_node_put(tr_np);
 			continue;
+		}
+		of_node_put(tr_np);
 
 		/* The trip has been found, look up the cdev. */
 		count = of_count_phandle_with_args(child, "cooling-device",
-- 
2.39.5 (Apple Git-154)


