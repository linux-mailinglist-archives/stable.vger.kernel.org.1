Return-Path: <stable+bounces-118690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD07A4117F
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 21:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5918B173DC7
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFBD237717;
	Sun, 23 Feb 2025 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANC+MySE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C312155327;
	Sun, 23 Feb 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740341839; cv=none; b=PUcDoLRi8oLGLdYPEMA9VSso4fGzKRw7tup00TcGE6gvBaEO2JcjxWtlyZgZkirUn8RyVtQT6qsw8EcSvNgQtPdA/GGMEUVmUYPFZqcaLpah+ZaGvCgk8mS1HRf9XQSTGPBgYXP8qX+0c4HMW7vsPYhY8ss8qrEDvpxNKbYRqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740341839; c=relaxed/simple;
	bh=Lcz9oIvIMtu0OBEbeURtBLsHVo3py6JmyZZ3rHW7W0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqGLpDIBebkIeQvozn4KTCrISMS6tTA+YG5+F6DmDWvdxUfRRPZpQdypIEh3DSo+DEF/HHtn62yn6dO5iuAzVS2K/aSlNGBhLuHZgoFb/ZgFQgj1hb+sVosxsHiTPGHtwXJR7VD5r8uq/ze84DwxX6naEZxSjfDgHOfJD/T7n+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANC+MySE; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e44fda56e3so37589276d6.1;
        Sun, 23 Feb 2025 12:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740341834; x=1740946634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8ZnynSf18TQjdyqnQ5CECi+H03cXqzc3RLft7bPUFk=;
        b=ANC+MySEfPw2uJu2y97ojgFt+DLT+peaWbIdbRk1ZM7mhNeecDL6CfaImDOJl9uM4q
         yUbf9qLTIn9L8H4yGwN2YFxXfMWVCePIKk/uzyXf6g1Atb0BW0fxCppmYvV/13V5D5Pv
         iqG79la0e18Iwfe/iHihiJ8CvylFYoYWnzwYztYbHyVPUq3R9bczXbNCssRZ1TH36xLC
         YGRbhDp5xjXkGVmGLhxURHM2WhLQje/LBmZI3t2b6RqQVDB1Xp7X0b+LFhB+5+gRTNk7
         Ip+I+WJXqxusBuoZ6gHBfmZq81enXk9E7X3Gk0Iw7p+nl9RIp0ZRn73Ugk4heT/czSdz
         OVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740341834; x=1740946634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8ZnynSf18TQjdyqnQ5CECi+H03cXqzc3RLft7bPUFk=;
        b=TmpYOVLkDLag4cm+1w2Xl33Stx6VQa/zFpULnvRXHHvL3Tevmh+AFHtQLBMdPdZoV6
         +9Ql2nWfE9D77kBgPGwAyenob5L27ZY0ytdeF1gbHdJT3hmpyODRFB9Ad+qwkSag4vUw
         lbPRUM7BgEaodEX5FQptwVxvmXHZaJqAA5mR/CoDggXHd5VxJywtmM5M8tQvrl17Ch/l
         ZC7xaiqWCWuDcTtR4/FtAe816qLw8Pp54YSDNkj3y4TGdbJlS0CCSAERM6j5S1CyJ2zs
         8PXaZvp6Zzeeq8wbfubmN4CVRg5UCwVqOldyLww4mRl8KRmmcQ569upYrZ0eLNfjR54x
         7Dig==
X-Forwarded-Encrypted: i=1; AJvYcCWZamwS/O2k0fCL0vWbKirjf+Nvt+jAwgxaZe8HccY5ZY1h50cx0fybys7LgsfSyu5+yJZsILQ+@vger.kernel.org, AJvYcCXyoYkhOHhiAfPXnsiOcEc8TIQcsIFJWAMFTJhCVFC+ot9CQ2D4l3FD2g5z2xE6ainUj31Q9fJzAJux8Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCzWBxSJRjVohnbNN1ummxrLRI5zNo+1NxOScP2zvMK+JvrpNP
	/i+MlAgale6mmtytRu4zO//bNj/0ONjn01FM3TZiMRnC9SYckGWQseqEcA==
X-Gm-Gg: ASbGncvW/3RMgq/5WfEu0iiJuoM67N3Dg+wS/8viUW6sCDRZ1jvPzg8IfEEQ1qrScGv
	WVzaZcp7y/N03yBH5dehEy+kZtwEdmjAAOcxoLTwpvXHzku27hkGs8zaaU2LCRRBnZSbcDwbMqK
	PVUzON2uoPzT5lxUxcFtVT+ZXccDde0v1GlylAERwQB98/6WZBm0sPloUmH36E0KIxB9lGM576Z
	BiF3f4YjGQU6BYBorhE26PnMkqgnTgnP3ENW05rgmd1knVOs6+3gopJGhq7UebSHEMC9DZc3AiO
	IfaeqG/WQl2Q6Dp5uMQJAAiRBmVuhcCNGWrFTaYAgAHz50AZ
X-Google-Smtp-Source: AGHT+IEAD1BHa1kewHfO0OtMm6kfhsPzvnxmiAMaWzuqtLlP5DmMQ9O2gvT7ceYLImmvtpDklDPmvg==
X-Received: by 2002:a05:6214:19ce:b0:6e4:2561:48a7 with SMTP id 6a1803df08f44-6e6ae8628d3mr154661636d6.17.1740341832577;
        Sun, 23 Feb 2025 12:17:12 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779332sm124942036d6.24.2025.02.23.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:17:12 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	jan.glaza@intel.com,
	przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dpll: Add a check before kfree() to match the existing check before kmemdup()
Date: Sun, 23 Feb 2025 20:17:09 +0000
Message-Id: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When src->freq_supported is not NULL but src->freq_supported_num is 0,
dst->freq_supported is equal to src->freq_supported.
In this case, if the subsequent kstrdup() fails, src->freq_supported may
be freed without being set to NULL, potentially leading to a
use-after-free or double-free error.

Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/dpll/dpll_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 32019dc33cca..7d147adf8455 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -475,7 +475,8 @@ static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 err_panel_label:
 	kfree(dst->board_label);
 err_board_label:
-	kfree(dst->freq_supported);
+	if (src->freq_supported_num)
+		kfree(dst->freq_supported);
 	return -ENOMEM;
 }
 
-- 
2.25.1


