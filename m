Return-Path: <stable+bounces-192504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00681C35ACD
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 13:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 789E034DBD8
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B6313295;
	Wed,  5 Nov 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjZc05Uo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE730FC2E
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346189; cv=none; b=J9A3JHf+wQ0nGLiMX6zqsa0gfpQerRs82ftediHaun4tULCLTgQ+Xnth8dnpO1fH2BSnCdT8+SkSQFkEwyvOLT5cLsg7xzN+8C20cNRM5qevVist+wbPZqImhSpNfyKuABLk7qAyNzSbf4NJ5NzBFkYuPilOp/HXi9snpB55MjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346189; c=relaxed/simple;
	bh=nJTNV9/EsPlUIMIwv9bK0Ir0hPWZYOWVI35hDM6yJXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HIqTJrCB5gRIcs9le+9hhnZUCAPHLA8F7r+lxakmYOGzGQgCnpnY9ZNpmgGU3sCtwKEs9WtCBFJXyooCnyhuXImDOfVqvtjssqS7B7ds6p+CbMPJaptfVzbJDL+NHFTMVjEDrqD6bvN4IOUaswQUqXX0tR8jQgrQjAevxFxykr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjZc05Uo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c7e0282dso3716055f8f.2
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 04:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762346186; x=1762950986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/66RhgS1hEGEBh1mPkZ3p7ONMmMoCPMprG29ER8/HN4=;
        b=HjZc05UoueuPZv74ODHeKbx7bqKOqfui/hAi1YM19muiEWf/dot2fshFhkv8iX74gF
         3wD2wHxO31IWjM5WZy5I+MovqfL4tfIRAnw9yhtlBud2S15gTlIQ4j4c4uAM4wHMtXaK
         PVvFNcb6mRO788qQTcnAEEbjz4xgI7Lskc7GS7KIvLsyux4GduG3gAihP6IH7LAlYRBA
         eyCRX6AEbF+4vBZ+mT2/DjMhjdb3/e++gOP7CjnQJ9jpOmEhsvqaJyP53+q/uuCYNigl
         tnvATGo3hxZITT/l0BFJgZQmwPuktKW68/fM94Yz8Bx8uaT/RYypnRrbcRCbD2jl289j
         4zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762346186; x=1762950986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/66RhgS1hEGEBh1mPkZ3p7ONMmMoCPMprG29ER8/HN4=;
        b=aSC55/FWD6PRANQEyhtfm8UPxg5sROh8tkBPljyf7t9s2w0ZqHbxgCr2lkm7wNIqb0
         fhtQzdcFEM9BnJGcR3zEwmSzSJygkG2AyLMpO2uMLj5sgffbH3Mjp+86yGPuCR242AWG
         IjWJexp69CujsHtuzMdk4pyhlLqdkjNjA4DQ05Fr8TbKpgKM/Pi8t0VhfHB8g/aYHuhH
         vjDqPQMeRJJbX3kleuQhWNsy7qJIhVpV4IPVdovQyjhMfI08u6K79SctlC23VBOHsMUS
         ZAAv8VVT7Ft23QTHO9FiEriTorj8E7LXWJFWD1pp0xw5q/C6vAkfTbsZ4HnWkhPQke9N
         Re3g==
X-Forwarded-Encrypted: i=1; AJvYcCV64/SIjtXN5pC7Om5R8Ti3YcwdJrtnSGBRfskS30cuznUeF8qyC1v/dpA4qztU8jsGpd9gNuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJE94pCmDgU7eXJ03rikKrjoTbvVKiPMyQSNsDKf401nU20neI
	OPLGdRciVPbE7esVxrgTuwTDDZiiXXnZJZXNKigHN730aLOFASen3Tur0RoDiUp4
X-Gm-Gg: ASbGnctFnHHBlB3i6TZKF8q9ivtPaXsBXboXluwTILpTHCvIKPF8+bTW6z5HyoNVZB8
	pWT9ooD8q4yACZt3anRuMen/JcXe5gpeOuKM51KzCVOf6ypx+knip3gNzSFiiXfJ5/VdehsFs61
	oA15zfCbnbknbepMdXkCzxWouUO4FLg2nGtFdK/PkqQiqRpisQ6iETNS9UpEvnpH1wWxTOikbG0
	q10/xxumANfV+6JwXlPFEYaHlg8J3fL4D6LkNqs1OsLSE203wndLlis8STvn/dP70Fxw5u/dc8h
	H5TkfhSqWZZEhlm7H4nJX38+/h5gHpqtEXPGtX7tDBS6tTFZCy7MZuPXFgn2qTNCptTJBpUYxiz
	/SlrfIB3b3Xf3z8qjAWmG9PBrqmY5iLq4ze4hLAuQmZMo/vPmUjRg2sZWNZwVCmi3y0SgswkzqJ
	EIWCeNY885qPb1g5s87eD4FQr8BRAlxJw+BK1pQq13IASNJxe2bJ8h9BxiJg==
X-Google-Smtp-Source: AGHT+IFqkcHKbN+a1s+l5W9NGgENLcQi55S/lobVNoAuLKiRyZ6rQNTrOb0X3JO0E6LLmQj5OA1LCg==
X-Received: by 2002:a05:6000:210c:b0:429:8daa:c6b1 with SMTP id ffacd0b85a97d-429e3308887mr2175800f8f.38.1762346185683;
        Wed, 05 Nov 2025 04:36:25 -0800 (PST)
Received: from GALAXY.zrh.enclustra.com (xcpe-178-82-9-56.dyn.res.sunrise.net. [178.82.9.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5a7fsm10602387f8f.24.2025.11.05.04.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:36:25 -0800 (PST)
From: Ivan Vera <ivanverasantos@gmail.com>
X-Google-Original-From: Ivan Vera <ivan.vera@enclustra.com>
To: git@amd.com
Cc: Peter Korsgaard <peter@korsgaard.com>,
	stable@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ivan Vera <ivan.vera@enclustra.com>
Subject: [PATCH v6.6-LTS] nvmem: zynqmp_nvmem: unbreak driver after cleanup
Date: Wed,  5 Nov 2025 13:36:19 +0100
Message-Id: <20251105123619.18801-1-ivan.vera@enclustra.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Korsgaard <peter@korsgaard.com>

Commit 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
changed the driver to expect the device pointer to be passed as the
"context", but in nvmem the context parameter comes from nvmem_config.priv
which is never set - Leading to null pointer exceptions when the device is
accessed.

Fixes: 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
Reviewed-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
State: upstream (c708bbd57d158d9f20c2fcea5bcb6e0afac77bef)
(cherry picked from commit 94c91acb3721403501bafcdd041bcd422c5b23c4)
Signed-off-by: Ivan Vera <ivan.vera@enclustra.com>
---
 drivers/nvmem/zynqmp_nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 68c51cc3efa1..0f308e53d82f 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -213,6 +213,7 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
 	econfig.word_size = 1;
 	econfig.size = ZYNQMP_NVMEM_SIZE;
 	econfig.dev = dev;
+	econfig.priv = dev;
 	econfig.add_legacy_fixed_of_cells = true;
 	econfig.reg_read = zynqmp_nvmem_read;
 	econfig.reg_write = zynqmp_nvmem_write;
-- 
2.25.1


