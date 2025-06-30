Return-Path: <stable+bounces-158985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAA3AEE5DE
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669183AD1DC
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582A2E3B12;
	Mon, 30 Jun 2025 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcwGfWZy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4002BD5B5;
	Mon, 30 Jun 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304715; cv=none; b=AQd7Ft12TJZUhDOioL95G4AK8e7rt/E4We+HHC/122/QJU+XyAIFgcHywP54SHr6vIQNnZBY42cDGSYd3Zu9c/m3PigWvjfJvOyqoDn9WkwpWPDGqw+lvAiG2vIO9aDB0GIgXsHBNFzfq7rlfvJTPQaZSUyWWEb5+un5Z+jMDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304715; c=relaxed/simple;
	bh=bFQBqEheyr4aZ/KTyxhArKPVeEF2ZZO9d/HFxecTvJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qL/H2+/XOjSOKlw1SLj8RSqL4mNHbo/3OxZeb3PkXPHJdCwZozibgS4tNvrmpe2YdcSlV4KLuKatmpvoEAKv4JVqs2br6JflwHIxAoYj2E0+98hgpMgPL39AIik3xbbCWoEM6RaHElzZBeYL4SX/6hL7lLHObQIGTp8krrWbtgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcwGfWZy; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a42cb03673so60287041cf.3;
        Mon, 30 Jun 2025 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751304712; x=1751909512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVDqontjbqJDFX5cMzxu9XEm9l6XNXc31daQxLrNgwM=;
        b=mcwGfWZyPYWQGlf62baJ8yxa5cRT6Q2vMOvxN2UhwziCNBu7X09TbjAV2Sbv4V+9Au
         zG/8wudKNOvF+O8GtzUJWbkeA+hyZacRWJpklfk6kGpOY5gBNAC+eh1uIEzcE7SbzG0M
         NNn8LLuV1ZSptCuDtBwRHajHrZnbVf6RI2hE+scKjolY9X/72jyMgRLgP4eMjrSHWz6j
         zbpgY0upkX/GeqrCT3vAQMLpkChWMhOYIqS1Ij3arUpx2o8hmjjCm0YE19yDQQJ3zjwV
         HjuvfVObWf6iXyIA0QQ2aNw7tUB504AdzPhB6SUSiQWyNGfoifKmtq2QUo/dlaYc6Mih
         4R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304712; x=1751909512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVDqontjbqJDFX5cMzxu9XEm9l6XNXc31daQxLrNgwM=;
        b=VKb+zYArhmxMOY6HjvSEAZ6GPCePQTkDaB4igtZRcIYJABsi/34AfeDtdSXzdUbVPU
         6PH4s3AM+OiIADW7Pf88eH+K5/jbqHldXwR/681GlRXVSrEgpWLiZ6Yw/Goi5w9xnpfg
         79pJIcBHYHPdANlSSTNNhqVUoOvKX/uREPYttE2sIJC3i6H6eK5Ph2AL/Tew2kfGUHTo
         r3xm+aepSKXuNOUcj8x3bdAmaiSruIFgoMzh+kh0zjTvRqYmlCC8jMKwHyT+ECBmVtJf
         Q6HaGPjUgmkcMWNyLFvXh8l5WMr9YPjfSNhtBFsw84fmYA7PpoNCx+qXSa/O8ugIIivB
         EiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOSazpPrMoeLVUFJ9lWIs9XIY8fXeuW0+c4Vj/Eu6Coomty2rTNt815Qpdrg2s4kPRw/UQdk8V@vger.kernel.org, AJvYcCWx7SleLbVvjNhu4MJtFluO4s1/sMSB6BYbOfg2Q+B703cMf3lQQneBqxRDmdtprX86r4IdYR8S9vJkRHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xk/r2KTcPEXc3eKfzh7bliyUo3tLjzRveQ9fz0k4xFmi95rA
	DAQ380TQ/2SVxWI19bBmhz6R03Z81VEzIllxJIcuKyI7oGHIz2WHGV6dyx5RoZLg
X-Gm-Gg: ASbGncsUljWmHl/Pw27nhuYPCqf01d8rVbd+tHTovmmoHUK6u5LGlcLgltOrD8jEexq
	rtIU8Ew4JlrRMM0IbrMywtg9LSiFTkMEUNAmeAQdnJ76PEwoZgFN+U6SsVryNXFomYq4xIFpMiY
	Q4YqGBFsxh3gKpvW0a/hvuKu+kZ9N7A+n1GI8L8NuoZK7pNpz7WHXCiUdpmAmp1rskF1fU6GpAr
	LYfmCxBlX7JiLt5KXf3X9uT9VNdZDXXtLGWssXywd8lvs8kbIV37RMzhVMRP2G4k/b20C3qR3bu
	+EImddt0nrOF5wxQVTac/Zx8CgQ4k/i7/0FELnfkrFJfsBpIRII2Xy9vh9+k1w==
X-Google-Smtp-Source: AGHT+IGohO+H1t4zEd+J84aW1WC+S9/4R0DzCq15gbMSgdFlZnJf2TpTggm6I4gXLMGtxWQ5u4W/tA==
X-Received: by 2002:a05:622a:248:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4a7fcde94a5mr192338081cf.36.1751304712278;
        Mon, 30 Jun 2025 10:31:52 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fdadb11bsm59784521cf.17.2025.06.30.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:31:51 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 30 Jun 2025 14:31:19 -0300
Subject: [PATCH v3 1/3] platform/x86: think-lmi: Create ksets consecutively
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-lmi-fix-v3-1-ce4f81c9c481@gmail.com>
References: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
In-Reply-To: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=bFQBqEheyr4aZ/KTyxhArKPVeEF2ZZO9d/HFxecTvJU=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBlJp5hFXdPeXzhey1QitYQp0ZtZXHaRzj4VuYKIcsX2T
 6vZxXZ2lLIwiHExyIopsrQnLPr2KCrvrd+B0Pswc1iZQIYwcHEKwET4JBkZOqa8XnQ58KGMXGxl
 +KubogLLjB3iq0/YyhiIiK2Jt31VzPC/JjErZPHvW8+aF56smtbTyhW86GJH199IP3GVzVzfolI
 5AQ==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Avoid entering tlmi_release_attr() in error paths if both ksets are not
yet created.

This is accomplished by initializing them side by side.

Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/think-lmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 00b1e7c79a3d1e95621701530ea5e11015414498..4c10a26e7e5e3471f286136d671606acf68b401e 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1455,6 +1455,14 @@ static int tlmi_sysfs_init(void)
 		goto fail_device_created;
 	}
 
+	tlmi_priv.authentication_kset = kset_create_and_add("authentication", NULL,
+							    &tlmi_priv.class_dev->kobj);
+	if (!tlmi_priv.authentication_kset) {
+		kset_unregister(tlmi_priv.attribute_kset);
+		ret = -ENOMEM;
+		goto fail_device_created;
+	}
+
 	for (i = 0; i < TLMI_SETTINGS_COUNT; i++) {
 		/* Check if index is a valid setting - skip if it isn't */
 		if (!tlmi_priv.setting[i])
@@ -1496,12 +1504,6 @@ static int tlmi_sysfs_init(void)
 	}
 
 	/* Create authentication entries */
-	tlmi_priv.authentication_kset = kset_create_and_add("authentication", NULL,
-								&tlmi_priv.class_dev->kobj);
-	if (!tlmi_priv.authentication_kset) {
-		ret = -ENOMEM;
-		goto fail_create_attr;
-	}
 	tlmi_priv.pwd_admin->kobj.kset = tlmi_priv.authentication_kset;
 	ret = kobject_add(&tlmi_priv.pwd_admin->kobj, NULL, "%s", "Admin");
 	if (ret)

-- 
2.50.0


