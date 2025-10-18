Return-Path: <stable+bounces-187860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB9BED447
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAA0B4E4526
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D072571A0;
	Sat, 18 Oct 2025 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSZyRGar"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD37225A29
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806720; cv=none; b=pO0b/rLCZPsVViyE6GqQt8gK2/dOPaEGOkVmb8XzdukdBUwp0062NPwSfD1sDNZYK6LWLAHWqRsJsfX8rGfDwPGHLKbFvV9nkTV1hl+lMIfQLHE1V8n5/tYBfQ8x+NmH+UPGr7XPWAlSY201QDZVOSHrTNr1AWSprAvfcJbcncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806720; c=relaxed/simple;
	bh=gL9tcVKOxeXgCuidv9aJaGiXfxgPIHPCk+ZE6JBKV20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNY1NSwiBpzb5nifChvuCb4JV6mM5KHcdhV9AVmGdqc3KX3ofgNWqQYMXolG3jw+7goGOsmcBVIOzK4u6kZoX/98O9IvkxGRcCGLP4MAOuEROHWZ/6gS3YQNEoZvXDDamRfmMHjdx5cA0R9KlybiPjhQSnHRFrGD4/n01QTff28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSZyRGar; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430cadec5deso15013625ab.1
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760806717; x=1761411517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbSrfLmeKcMiAn9HXZUM+zX/zHb68gILBq3d9ts68KE=;
        b=LSZyRGarCJz1GarMDsaQpmvyL6AxEVZeJWLGQH+PTI5XDucoKWar7JjMP35KWRT5vJ
         qxCZSE+o10ZBb8axo1hF5DpNHi2vMy2X5ErNVL/twGCLNclG/r7b4ZzelnhBd2hRvmcW
         J/M2NIj04nWbl5m1MpE7owBHo/9tyOk/Gwd+ZOJ3TXCRrc5tPq/QGuN7m26tKBPrxQS7
         OBDUD+tyTm9UoFNfQnQG9jadPBYCzMy2CO8urTLeY8UjjHHJqb9m8e3wKET9B9lDSR3r
         T1K2UWe6hF5vSS0duufPO671eB6+SLdhzmv6PXQrrM+jfE5K8ksFjrFMEkllk+JHSXYQ
         gnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760806717; x=1761411517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbSrfLmeKcMiAn9HXZUM+zX/zHb68gILBq3d9ts68KE=;
        b=GPz6wKH2B0KAppm6nWbdrwIxqo5GALFAUFRbkOGg4TQaT0g+FTFGdVv9crWVxj0tmb
         FFseLrm6yTzXUG/FagzO46027LsabuRvf/JRqs6zmm/FS1MpxQwZcTJnf5WQAOVuphLS
         eFeaL8/GdHiVx/nqd6CuiKWj00+ZujoVZMLWYLfAAEA7Qrv6BrcQmm++upxdbCRoB2EK
         9clcMj+rOB1eNDGEXxRPWa4M9m48rpzSyf6XLNv295+PJn1HEwbVaYnYGx82UQVR7gJk
         //Jt5Mpl0Cauj5GKaYBe2lFfbpDpy6jAKp2xJWeK7efbARPx4Eklc0IXgmA7yM8RIzQL
         yJZw==
X-Gm-Message-State: AOJu0YxPr0AZQdLlUbQJn9LdyXdvtER4HOwWJjKxAeEDRmzonn+Pa+fM
	sdv7C7VdrSwhaDdnSKDF8wZ/dlvBhLPb5zv7iuVa4bIqTs4m3ma2s8w9fsKn11w4oZs=
X-Gm-Gg: ASbGncsP73V0iM7R40Sq2Poua7Qa4aR+BCsh507lJeVbJ8UJ9jzdGzL13v1yhfxsve1
	r7A9sAB4PpkUsVCL/oGTfNHptqlFhnigdx0JlGzswPeHga2nrhdQ95R59XCBK+JnjqBCyAiu4AD
	Iw1xaSrus8s3qfy5XxRrOtC5s7eIyRomD327xkbdlcvGUshKJLfBUciG03nwOpKhEzPC1RWArhf
	zyQae0UtAqh4/r25FQJg7QC1qNAJkD1Sf4xCeb7Bubl5lwIlr5aHvQB8CnfAOEfErC10j5MBDUJ
	j+3jeKwcWoLO7kuYoGXe3kxA6/GBp+hhAqsXGBsrMQGojUfhHZgkCgebrxGPJAMZLmMa4rL8bbN
	NxPe3UfhclIPeGSasqCTRmXzrUBFTE1gM4qpqFfsL8TSkSsbsyeApwm/VR81n7VwTS3rgRqFpZx
	VFl2KavKXSo06wsISAS1866HqMM1HLc6c6hPQdDY9ovSX22sa0
X-Google-Smtp-Source: AGHT+IGCPrlS5P1TWVELOp/T5kfwz95pTEDtxgcUCwy5VZQzXvfWE0A/oqrGl48WeOnrTW9OQciO+Q==
X-Received: by 2002:a05:6e02:b2b:b0:430:bcef:e0a8 with SMTP id e9e14a558f8ab-430c529fb9amr119407455ab.28.1760806717551;
        Sat, 18 Oct 2025 09:58:37 -0700 (PDT)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b4614sm11927545ab.33.2025.10.18.09.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 09:58:37 -0700 (PDT)
From: Adrian Yip <adrian.ytw@gmail.com>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Adrian Yip <adrian.ytw@gmail.com>
Subject: [PATCH 3/4 6.6.y] drm/amd: Check whether secure display TA loaded successfully
Date: Sat, 18 Oct 2025 11:56:43 -0500
Message-ID: <20251018165653.1939869-4-adrian.ytw@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018165653.1939869-1-adrian.ytw@gmail.com>
References: <20251018165653.1939869-1-adrian.ytw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit c760bcda83571e07b72c10d9da175db5051ed971 upstream

[Why]
Not all renoir hardware supports secure display.  If the TA is present
but the feature isn't supported it will fail to load or send commands.
This shows ERR messages to the user that make it seems like there is
a problem.

[How]
Check the resp_status of the context to see if there was an error
before trying to send any secure display commands.

There were no code conflict when applying to 6.6.y.
This backport gets rid of below error messages on AMD GPUs (per Shuah
Khan's machine)

  kern  :err   :
  amdgpu 0000:0b:00.0: amdgpu: Secure display: Generic Failure.
  amdgpu 0000:0b:00.0: amdgpu: SECUREDISPLAY: query securedisplay TA
    failed. ret 0x0

Compile test was done.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c760bcda83571e07b72c10d9da175db5051ed971)
Cc: <stable@vger.kernel.org>
Signed-off-by: Adrian Yip <adrian.ytw@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c83445c2e37f..d358a08b5e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2012,7 +2012,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
-	if (!ret) {
+	if (!ret && !psp->securedisplay_context.context.resp_status) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
 	} else
-- 
2.51.0


