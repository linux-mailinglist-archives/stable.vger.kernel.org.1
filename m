Return-Path: <stable+bounces-187858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12583BED441
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C490A4E6AD4
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4CF256C89;
	Sat, 18 Oct 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQcfieWR"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5E24A067
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806705; cv=none; b=r7OvsQmZ+pS5jycJzdOSp7pBGWrOJbai6SGe6DpcYC11jyFGt8JlBc9bw1anFJoVJQZzXx8OnIEUML2c4xN9mO69nHGY++R1xKUkDfUPduzNOORql87AgwfJYpOC5t42DKlNh8q2KBK/e+uzvGNpF08hldOkTpd59DowWmLZJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806705; c=relaxed/simple;
	bh=4SufFCPXmxpkslZ+FDy02vXkO1ooFHOQKGFISivorpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQMli7oc0Sg5jRtZ5+Zef3m+ENztUl8/NV6iqFO3rXwMc3Fir1HJa14LcHlFIqMZYSqgwo4+ICrtnZGUrlZKUIgJEmAggZp/Qy7zvB2Oo9ORkJ8o3Lz3qL4P3ydJxCZOYzqPqui1lZw56teP34cafWiShfUwooAKRh6bwK6eFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQcfieWR; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e7e87c21bso151111139f.3
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760806703; x=1761411503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU0Vaz702n4jmmJNBsbiEKHEOlTcHaJiSdld/th41J4=;
        b=VQcfieWRAE+y8IKUWBNhOYq0V+ZLC3pPhqL8p6SOf22T78YZwz9Vu8Kkh4v/Ezkgjx
         LGunTQCucBt0oBA7kkF/MMGbRQrIqB81nxyXopPqHlxZLMgEn4VAZRNnzKUQGyL5ekpT
         bSgLTZytKdNoL95Y4tr0cIhWQvPfOSZsYN5V6wlgM0Cv8xKGCfE4AQdU9IrsGdaqcyYY
         nO+aDSTW2tgTCG7jCkz1QO1ocUe6QYsu+Zhs2RKpBP4flMjM67M+vzQqWvVJl8abOgnS
         U6BvDKkjanKHtWlXba1ezOBCFT621pQisjMpV0SMnVdi4eRT22R9RpEwqZ1yWy2qLplo
         cAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760806703; x=1761411503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU0Vaz702n4jmmJNBsbiEKHEOlTcHaJiSdld/th41J4=;
        b=cvgmgXMRCKyMBs1tgEuCSxqN9P1jyteqBJ6AD2vayQU6wUAcSulTW8dEewRM5WHni/
         1we48Kuym61oVCVa8kHThL5JLCW34yslM/KP7zupRWv7uiBhOyVcbXWi7OaEte+MJkQ8
         xnWVLB5RQpY7cDPjS4nWahBrNlMnQZR4/Q3abbL2qNcB9WpKtovUFL3bysyz7i1aD6kr
         RwO5NLjihWDiGvM1WFA9h/N5wQ6QOrtJpgCJEVgTFDH5fJNGFRHyALgt7JhcLnpfxED+
         3AYMSOMyutv1ofNb5R9tIz5I5ydoF1f7pGLcLn86EWZCfUBOrf+zlDEvbdEscV5fRLyU
         FETg==
X-Gm-Message-State: AOJu0YwlMzRVt9ze0GsVmmbcDjZkOQOxIsovGa+EUcYkBluilBVvw0Kb
	+JgyOCG5puNPxVeyfVIrGRDqYxVmPAHJJHAxEY0GO68LaUKSdiDwqyRfIGgiW/vT5JA=
X-Gm-Gg: ASbGnctYA1XrkHsIp9LibgIp8aIl3YvVRWgeuhCMVnHyRcSWQRCNdcNGVBprCUllc8M
	nUs2lJJkqfPY5aWwn+ghLiFH75NlkUAQeOmr11t/b2oPGUHnZdZf7bBquYCVUOiNuRSLUaCA1Lf
	uSyMf+8CUP9BwtyBvdLU70vfmF4aiz5VqhQu8RrO+4DJCj9erw0tDFlqdV6yKmmZYOjIT4ScmfP
	onuNcy3FNgFJ9z7Igh4ZDe4EVyC4trdbGf4N1NGQz1dL/HmL65bmvy3VgPZCdzlHhLTEzLGU3Tp
	chqtzmwNL7R44uSmk2jHSPNcOm5pNCjAp6tBJ0Hv0B1xYq1QUJpuwSJMIsXNQ1bNPDSDYdnPPIM
	EPdYEGAAeH1Z4ygQ1j7nypcIhiKepDgv/l0A+C5MkjSV3HuLDXPYIrOzPyx9a2tfg018NVOOlDz
	zp2yoaVzE7BrXb6QL1anGSvc/2JX9A86z2IuBCvy8zUbPMiFdEk0Hehf5Eaws=
X-Google-Smtp-Source: AGHT+IHKaSv3O3IeWubXsR/NlCaA17Q7Uvpw8Ni/C5X6m8p/2C/Y03YluZFi07O36GktyEubOFY4zQ==
X-Received: by 2002:a05:6e02:1d9d:b0:430:ab98:7b1f with SMTP id e9e14a558f8ab-430c52beddbmr124046415ab.18.1760806702718;
        Sat, 18 Oct 2025 09:58:22 -0700 (PDT)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b4614sm11927545ab.33.2025.10.18.09.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 09:58:22 -0700 (PDT)
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
Subject: [PATCH 1/4 6.17.y] drm/amd: Check whether secure display TA loaded successfully
Date: Sat, 18 Oct 2025 11:56:41 -0500
Message-ID: <20251018165653.1939869-2-adrian.ytw@gmail.com>
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

There were no code conflict when applying to 6.17.y.
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
index 693357caa9a8..d9d7fc4c33cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2350,7 +2350,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
-	if (!ret) {
+	if (!ret && !psp->securedisplay_context.context.resp_status) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
 	} else
-- 
2.51.0


