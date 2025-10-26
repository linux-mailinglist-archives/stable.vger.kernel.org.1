Return-Path: <stable+bounces-189878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA9C0AE21
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A9F3B4AE0
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B1261581;
	Sun, 26 Oct 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac6DUDQD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFF246798
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497080; cv=none; b=dU6aYsh2MRXIacw3inWxEEfx1wNDqxkaap4A7xODfnNzz9/04Gy/Dlig1sHxbJCVEdck1azgWQXJXd0LxzjpJggnDQZU+6Qxlr9SmUbELqWn8Ygsnre3vidGbTB5ljwLehjrq4XaJNSueL0N7f08fSvTxdc2IiydTLSIpONgN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497080; c=relaxed/simple;
	bh=eQUOoR9FD3UwTeZyPSZWJNKIzcKibTzjwuLGuN9r9W8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EaeiPZcQ3bDYLhDOcvbAMwGrFRGSVHLbYrGlhIUTYXfFG7wUul3OFKb7pqj95W/MsTTwwGqSHiLyZgmE9OJNXsfbKTLrZvJq9Ml3XKEAdsu1tnYhTxsGYhFrGgY6SSaGAa8wgINqsFrg2TzF9tBy8WFw+JNjoCz/3qy1Slc/enY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac6DUDQD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a4176547bfso929540b3a.2
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761497079; x=1762101879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFfVLgzVjo4apr0F+9sFbXPgvyArU5e8XxuMCreDUBs=;
        b=Ac6DUDQDiSqha8TOhpNWOy1v4k4BWEPkFUBk1QP17CIF8yHldefaXWI5zassdy+prA
         g4N2SlPHpaaoQ4FBct+YD4Eahk6TU6cWdOZVy+ImjTiMWa7rXG4V7ZoiqSyk39iLlgnA
         Ex1rKWoOpHTHwEYEOVEKOORBXLK5bhWtr6KLAewwf9x4yU6fkTMmVu5DYlb0P8XOzkkM
         Lu4pddOAZk0KwUO5NFoSFh7FqoIvmAcRPBSiU6srzeU1W7LLm27MdqZvxQTfZIJiHNwJ
         4yrDENrUACx21mLAxbjsdNIp/NV7ORfWcCxuFEm/QFNeVvZrOdsrptiuEvctu9czYL2n
         xmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761497079; x=1762101879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFfVLgzVjo4apr0F+9sFbXPgvyArU5e8XxuMCreDUBs=;
        b=q8QpiaVBfLoKeDyRlO8UB6vvgilnZ/1Mk0SIe+yGweHd6SNCTjiyfq4TjMGocAPqmn
         23AwGrkFg5tqEAtxzg2Wc24xGti/QExXYolA9UdHEFnMlgbnNgkoPYaVd8m8d2FfKtc5
         a+QV6apsbZUXwAQcbew6lLzAjioEfCDGx7mwdth1aqlhKv3moaGG6xGzDWHIBg23ULTT
         JBL6KowwAtlD3/+fYPpXYOrhVI48nEIXckaDX5Q/cTb0XhFMr3MOOSuF1bTZjvnkK9pw
         i4rmyLWRl0TGdCMLq8q3O6rVXzsBDuMbBKx7JN8HBOoszgi2gCf4OOpTpgvgH3eYNN1L
         z34w==
X-Forwarded-Encrypted: i=1; AJvYcCVkAYRPIVRSsyBorq99Ta3rPMbXCd7PYDLGMei5xh1Zj2W7lh0CQd6d9r491qsjvJTw6KhwMww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzgn3sycEnLmi4xsuk7sowltWavyxxbAaVq0kwUkkYivINiUc
	bb5Fe9WlGG5SlJ7EXx3e5LgiI5jjiu6ZQhwgIq80uPkKva7VRyWlxUOW
X-Gm-Gg: ASbGncs3GPU4QOpkSq4k8vitCLdQm+fpJhNoIQqXxs6C3vTmsEZsGpUq3wAZ32Y9C3e
	RE0pBU+x6MvHq+GFbsjKd5MIcwp4pPJI61A9CayUWKVRSYiNPfBMwsgk9Ul0CKXT0KJtNuyhtvm
	a1Ift1WVkapQcZUCBNUAV/jjA/6M53QOtKa+yXhlo1eGqQnownvUJ+DUOfmnanEvPsbMULl05XB
	Jw/hj+lOVulcsKtKoYK1QYNbh+xuSxMTPxr9+cPRandrJsQFAqTbzmUSjaUyM0PHfLhsxAzHeyJ
	B5jYnNffBewANtSVs4o2gDQYHpM55uohn+KWUWdOgB8Q/PWIP+oskhlFVMQUlnc3gk8OS6M9/CV
	VI2LYSXH/N7D/nEuuzn9xBc94LSMnqqEz/mzAP3VFNuoKGDQoIrZPEXPoVcoSWvlxwWMfjqQq9K
	BHjo2DuXVbjl915Xcb4k260n+LfRijGJgn
X-Google-Smtp-Source: AGHT+IG49PJG/CbqXkaLHQC41z6X6jQK0xuoXYiEh+MDaaZLvv+6LBLNMogH8+OEV/PxbJSmU+sHyg==
X-Received: by 2002:a05:6a20:7d9f:b0:262:1611:6528 with SMTP id adf61e73a8af0-33deae4e085mr11445565637.29.1761497078563;
        Sun, 26 Oct 2025 09:44:38 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414072492sm5307768b3a.53.2025.10.26.09.44.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 09:44:38 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yu-Che Cheng <giver@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] thermal/of: Fix reference count leak in thermal_of_cm_lookup
Date: Mon, 27 Oct 2025 00:44:22 +0800
Message-Id: <20251026164422.58128-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function calls of_parse_phandle() to get a
device node, which increments the reference count of the node. However,
the function fails to call of_node_put() to decrement the reference.
This leads to a reference count leak.

This is found by static analysis and similar to the commit a508e33956b5
("ipmi:ipmb: Fix refcount leak in ipmi_ipmb_probe")

Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bind()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/thermal/thermal_of.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff..932291648683 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -284,8 +284,12 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 		int count, i;
 
 		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv)
+		if (tr_np != trip->priv) {
+			of_node_put(tr_np);
 			continue;
+		}
+
+		of_node_put(tr_np);
 
 		/* The trip has been found, look up the cdev. */
 		count = of_count_phandle_with_args(child, "cooling-device",
-- 
2.39.5 (Apple Git-154)


