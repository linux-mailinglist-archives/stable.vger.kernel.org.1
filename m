Return-Path: <stable+bounces-94599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCD9D5FD3
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F168BB23578
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9487029405;
	Fri, 22 Nov 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEL4n2zv"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778E18AEA
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732282937; cv=none; b=F1N29s87+viI/n6GdU2hJXgWvjYVk4GmTqBVw8ZU+Xx+Ew/4bjWnALNHy754EF/VyDZuRr3Dc39nWu5jihNLay4qu86zYaaivUoU+CKHp7ssYFTRdKVZ1K7KYxtkPbJWs2GgS2JKzCtpQD2XjP+2hnX1KzpcvENZ1r1V1wPTzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732282937; c=relaxed/simple;
	bh=7rpxTCbAovNOOaSE5QqV66Aj2XvYh1HPcKPEvedvnPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIWnxLRUtzJPJDtMKkNeHUtPCnmURn1l3aIf4wTUtLOiv9GlLy01aWB3VS7+aGzucOFLDVQFOcrHSKb9dkMt7d5tz/7Ptk+OgYpH+kDjh9rlWv6Jji3y1hbBjHUI/fobg7fbwZxqUGS9lYzJmQQQA83DEy/CM7Mirskom7JAsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEL4n2zv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so1652253e87.3
        for <stable@vger.kernel.org>; Fri, 22 Nov 2024 05:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732282933; x=1732887733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR6Bt9wGJi7TnVA8wmi9rRKI8kqmYyf5TPLbM4hQqZU=;
        b=sEL4n2zvxEzzGCp/hRVpZ7udi7krOdjTeN96A96SYVR7j0zgpdrRjPxJH44Jj41hYk
         /S6CMByFPaf6M15/0fDC2ECv4jZGpEODQ4bnyALeLP+eNng5eVm6K7wGAVVOqMA497+u
         rtop/DjDkb9Nn9Pf3NkrHLEi+nQxBhBfRn4MlIndhGmjvLUD1t6h+Y20jvN7j6N1NdeK
         qdwj2G/vDjQZVGTwsykzT2EKUZtvSsKM4sPng4zgczZd6qtwsfOFWbwcW5EuCpEjS0+l
         aKmV1smSPRsYroSH63aKdSgujnvn9Ad+RQH0bdU/74bfJgGPWc5cnym4O1XtKaPJduP0
         sqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732282933; x=1732887733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR6Bt9wGJi7TnVA8wmi9rRKI8kqmYyf5TPLbM4hQqZU=;
        b=PlNTOeEriL/z6lWXambnPGultM2jc3SIGJsEdQMBMoASwe/X1CBY6lVatUpaNxdtxS
         uch4jwrQktVejYupKkAzCyMp8L4qRCgmQJsEkCjo6qvZxR8qxKlxZuUmPZ3AarN/LKsB
         0NvJd4QL/75w8JYSue4PfV1Bi+V4+UJt+zV2iXMbq0k50clxpgmr2DPFSpetP9MkMr5O
         vHnHJNMVXoQCEk/CkbblIKeiilkh+xB/+m6MNWxjTT4ADIlgcdQwsDVro4rxUBbq5Ym1
         tWUAjTrFTa+sqSi66XEqbf1qoP7/MTYoSrfiyvhVsOxLBoY7N/qTwy6pl6M4yjTi7AFC
         r0rg==
X-Forwarded-Encrypted: i=1; AJvYcCVZl5vKHn/pXD0UZXhadP9z5/hhowst1pW2F1x7BZgWHz2TqI3IPpzd82AKhcy2l6Qtfjh7v0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyz0Kzj/XCs2F5faU1n4xOODIB5/A3TlefbvfT0qfxls4D9mzZ
	0Exfmu34lbFNub6YY8mhjX51b6J0INSaKVex4r9d5c7VeTsTCvtWCK+SAQQC8Sc=
X-Gm-Gg: ASbGnctZYX6S73fP1toyO5gJXc+REq1jdE3VL5EN1EJf/yRsM/QDxjKROB50vLIWx1q
	mChAsQ6vsryIdxO6jsasK9SGur2QhkNru6HyLkpgbbbdsvy+U0gIu49HIe7cUZOM7aTCCt27zR+
	bEVpBv7oBcPGIw6uNP0FbKMjuFQoqkq9OiLAsm1cX+sY4XgYrZxbt99EtL6AstDMdbTA/5CxJb5
	5iUtLbAQ6l5uOjcGSQi/ybbePpg7AbVAU4QYLqar48OuvLc0Dw88w+IYyVLT6265Y2U/P4qWopo
	uXCwDrefuIg5NgIxH+nVIlC8
X-Google-Smtp-Source: AGHT+IHyw3GH8RrHFNfGtL+1PQD/slLLct9YZQoWaph6bHJlpew+jBHD6XIcc07hIt3G/uvpFcVtsw==
X-Received: by 2002:ac2:4f11:0:b0:539:e1c6:9d7f with SMTP id 2adb3069b0e04-53dd389d698mr1582840e87.25.1732282932796;
        Fri, 22 Nov 2024 05:42:12 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481e73sm376432e87.120.2024.11.22.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:42:12 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pmdomain: core: Add missing put_device()
Date: Fri, 22 Nov 2024 14:42:02 +0100
Message-ID: <20241122134207.157283-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122134207.157283-1-ulf.hansson@linaro.org>
References: <20241122134207.157283-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When removing a genpd we don't clean up the genpd->dev correctly. Let's add
the missing put_device() in genpd_free_data() to fix this.

Fixes: 401ea1572de9 ("PM / Domain: Add struct device to genpd")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a6c8b85dd024..4d8b0d18bb4a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2183,6 +2183,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 static void genpd_free_data(struct generic_pm_domain *genpd)
 {
+	put_device(&genpd->dev);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
-- 
2.43.0


