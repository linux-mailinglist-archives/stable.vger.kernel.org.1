Return-Path: <stable+bounces-100874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A745D9EE370
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCD4188A80C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4920E6F3;
	Thu, 12 Dec 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z495krWB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04820E327;
	Thu, 12 Dec 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997063; cv=none; b=CNhoNC48RQp6m68aqxd5XDSTmy2y1h5sOsSywdqNVaVPKYwC2rxKB9yOXT5udPDRLQqwG7Nl8L6EHsX2aPloUOk4Nfj9z6B7iVsivoUvVAokeZzNQKv0nVc8+kzivsacv5AAmNm2tfj6bH2tYehsdaJ5u3PLRy4lgskqKieO0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997063; c=relaxed/simple;
	bh=tgwWCWfWL4TY8dfN9EN10EcWy058zgq9DmNzaaLKFnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ndN4VeqPCqTfyuc14fEbn98lB2gZwzn8yKrgPNZCpacHJ0QpF6TmKqEq9q++oZ7eCd3FDWDuvc6cHwUcg46SbY/sUsgssbKpmHNhSYvKBeAvDMYTMEZ8uwt1O4CisBxPfRCJcRNQo9E4Yyvtip1aQBM+w8hlsR2fsoltJqafB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z495krWB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa689a37dd4so67479166b.3;
        Thu, 12 Dec 2024 01:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733997059; x=1734601859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Lqlqa+yVzadnVCts+R28x1v55t3TnviPyK2Uw1lPbw=;
        b=Z495krWBuo/HGyO5DRhkQOhVcofiQGIt44KjSQIIIGHHtlZGd2FM2xOJrnDl4BBZFD
         GxGd3TsoedP+KT6JWwDi3huS8MpTGcGYHgleh+u5SEkZh8tU08cuE08/8aaRlwl6vAQb
         LU5oKYkBFAJI4ThVYp0VEm0WJAAtXyKZ/iPrON1BtFJ/yH7H+yBtWrHPdfdrFMdiF2MA
         IisjSpLhsJbuamMIG8K35zuOrQAufsD377RvdjhUUNQji5f8ZepD7Y8RSVD0XEUmD2SW
         JDBDmm23OONE8npFBjhsXYHThCITGWUS3O2wiNrFQDB4/Qw+YT01wyy/6JRYVaBg9Cet
         tjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997059; x=1734601859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Lqlqa+yVzadnVCts+R28x1v55t3TnviPyK2Uw1lPbw=;
        b=EdN5vjSr/VB4A4VAFGqeb9HTb8RLSudpIo/5lx86PPo+0K1qCy+yfWI+eI6qwyf5QS
         4XMGE0Ign09LxNOvPWm0arLFk8f7NHE9AgoOMNbXCYIh19tcp5Xjd4aZzW/AlHUJRUn+
         wJMoqCZV6/OBf3t3H2aI+ppjoyI4sWrWl6ZM84h5QFkjVSGpP9Eq2HADlIDUH/Pt0Jmt
         X8ECp6oKWFtF9c666LI3laRr2khqDvncBMW8FMCRGS4nBu4jAVGYOaU3bn9y7RdSi779
         fyKjBcmJ9unrfEsKoGFjDOxEiK3MFLleI3Go3r4uStNFK6B5MoRXAl1pUNcEFygj3CcR
         jPsw==
X-Forwarded-Encrypted: i=1; AJvYcCV4dFBMzU1kj2LJIylLpq8Xz28LMcVvAEJrZ8L1oW6D7/sWGwwiQ4n7pso0nLFefCw/ySSUQbII@vger.kernel.org, AJvYcCWR3xsmEGg1RYLWR6yyI5sjQ6OGDBH/lq3UxyEe7t/nEzK9gFvK20X6XWbD5ZHZjRnvo89zOFKm6Jv/hYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKF/Mi6OMvCc27NevXJ9v7sdAeH6CtE7/WhYPBYXeUehGFxfn
	ewsX1Kb7nemmEg4iaALTmUQYEKm55/b/4wCDMd+s4xDoL6N4jEoo
X-Gm-Gg: ASbGncvvPTCYAztFqll5X4WYE7jOgC8nsjIQgQb+RCLmDhVYgy8V5/rGotSTTxDRh36
	VPUE0OH2UMuJ6mlSYH+G85Qx/BXJDhlkl2M31Emi2mZVTMzTGlHr6h9PFOiN0IRQ+j5kTi3hA+1
	g7CBX8sFnF6uZnJBXrzXfSQwx6BVMDqyqlYkoKsPjJPRCgSZPAg59bowAPbl8Ek38j55RKnC+lS
	GcZp0sXDK1jYfe8MFuYskixiOLhwC6t4DW5J1F6ANyYe0KwDcfO2Z3ywRSrQDfWnBg=
X-Google-Smtp-Source: AGHT+IHIXf2ITezkzRXYqhyRdc3NGo7nV9HtTD9QcXe0iHTpQ2fk4AxkW5PqBr9zOQsKQHtffVHoOg==
X-Received: by 2002:a17:906:18b1:b0:aa6:8676:3b3d with SMTP id a640c23a62f3a-aa6b11df74bmr563324966b.29.1733997059330;
        Thu, 12 Dec 2024 01:50:59 -0800 (PST)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6701b08c2sm714818766b.124.2024.12.12.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:50:58 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: karprzy7@gmail.com,
	laurent.pinchart@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	michal.simek@amd.com
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv2] drm: zynqmp_dp: Fix integer overflow in zynqmp_dp_rate_get()
Date: Thu, 12 Dec 2024 10:50:57 +0100
Message-Id: <20241212095057.1015146-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a potential integer overflow in the zynqmp_dp_rate_get()

The issue comes up when the expression
drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000 is evaluated using 32-bit
Now the constant is a compatible 64-bit type.

Resolves coverity issues: CID 1636340 and CID 1635811

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
Fixes: 28edaacb821c6 ("drm: zynqmp_dp: Add debugfs interface for compliance testing")
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 25c5dc61e..56a261a40 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -2190,7 +2190,7 @@ static int zynqmp_dp_rate_get(void *data, u64 *val)
 	struct zynqmp_dp *dp = data;
 
 	mutex_lock(&dp->lock);
-	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000;
+	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000ULL;
 	mutex_unlock(&dp->lock);
 	return 0;
 }
-- 
2.34.1


