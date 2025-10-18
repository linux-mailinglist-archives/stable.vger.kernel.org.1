Return-Path: <stable+bounces-187859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C63BED444
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21897400FFD
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39CC2522B6;
	Sat, 18 Oct 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKj19nsY"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464FA225A29
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806717; cv=none; b=Lz7b14on8JSi3cjOsPZu7K8nFBzjBkTVj/w7dxXaIouAZZAeIMroD+akdazUNpNc4OI7eexikjJsJIonpXmmiQSZxpaQF3nToXVkr1dWCdLoHStvZCDHVr2Hpsx5GD0ij1xY/6Yc4Omg94S/epaRehvbMhkCdNZYs2aZN1yNbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806717; c=relaxed/simple;
	bh=w7J82fnUD6xfEpzP95bpQv/8s1/Ygz1qLRmzDTIVvOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNk4sokGuXWUkOdH7Up8VtkSOBeZVDaaBPMsQ0GW0asXeHkc/+m5A4UcmXk7jTMVez8wSqLOKONQf2S8DQTePcJe8OoOrKQsE9CGeDSvCYsoZQgdz/mq4VbnnzQ+j+5/CKbDyrSydYIviaS/G31CXvOFc+o7BR+aPxQN1QscUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKj19nsY; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-938bf212b72so120858139f.1
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760806715; x=1761411515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1WBSTPx2pG3XQLINSM8ILY6Yp6IM7QVYiXHEETaCAQ=;
        b=TKj19nsYrsdImkPiC3Sx6CFLvK1VC5rdeBrzaeiP2GTirj1C5vj1DDOQYMY39dZ91/
         6lGhl0Atc9Y/5hQwNyS/q0zvsXXYpLaNf9TUXoOzD2gABATWL3yhYSDECAaWCzd3BLIY
         bPFAp6vZoQOyL3Z0Hh/S2WUBJ1B54QvHnIQN3PGvQQfEmoJ85cUF/LiwaLCtrsEpF0Ov
         6FFVT2lW9AOBFItU2CRkiMGWQMqhgZi2+QJCxJ6wQwZPAtUZvoR9D+rnWYPSqAbWwZkC
         3PRXliw+4PI2i1wNXH6/IJk9uovBaMAhZ/GtMfhkB0hunBy2YAyXzDDrFDSLs5xME4tY
         /iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760806715; x=1761411515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1WBSTPx2pG3XQLINSM8ILY6Yp6IM7QVYiXHEETaCAQ=;
        b=oYYeP1UcNC/gDw1PxdeZxkICDTddlouIrnx+wew85zVvu+r3Hsh5eXkBBzY/gbLi+9
         nXSciCu6o/oNyPJZKOnLqx9DZcz9AKOZKku0IlmgJuuBgGO2PYC4iFpG3KBVzZa8WjyE
         FGdq2Z05PkSmd/1xRP+qSk/y1eYJQ90MDoUmOHRprkLUyiJJgXwGbVMkyhCNBj3/LUX9
         5U92L/3KyMRamr+8frJNfpPC3SNYsKNIYtp/dF0A9y1y0uQZyx7lv44Tehd7w55QWRDk
         pum4DKbmqlf5tJWsN0tDzHbwLD5GJrfgqM5yMFK6T+gL/Q/KQFkewUUXelARx9JxiiB/
         /5Hg==
X-Gm-Message-State: AOJu0YzLZZd3sZZKOw1eUpOCRYwouIQkyOLbEBOMlUtO4AzEjSU432Os
	Vswj7Wlrgup/2u7qVFvmULbTu8Ms6goUDJj1LdzkUpL/DkJP2Xkov2F3pafC6MTK6NI=
X-Gm-Gg: ASbGncuJ2f1OMzPANKSkfhOOA1TP+xRsjwh3nnLkY5/rnY/no5kbuDMdWz9aHjP+KCz
	lr216b0AxkkH87yFrLCKWm1R75kXZIo222nct6quaK7onzKDVcjyV/GWOXO7t+M+0YKIvJVtiR6
	UdoScU2FxwlYAbs78+moqMeVrCfv6y+GTSGqgrrUOVjFD1wHuI6/c/JtwBmnBlJ4T+qOudbOsX8
	W3mwrzDVRLQcEPWXZay4+zeyIq1OfYkvSXnAuB6ldmjWLOG9NRtMuuaXBLfiC1AqIxynxRqkIV9
	GL6sNPydaGg+LJOK4/lFa8WHOZrT6DXacXpxlWb/YLTdMx+XC/pecOXFVjB25q5lM1B4+jOlyXY
	xbAqjz/flaxgsJClbez7castvgq3UlVr4EDjaWXEEfo++6cMIeWop+Iet9ckv+3hWdI+2wYZtX4
	yfNFxVG7Lmnpr3Rxl2Aw0uqyuLE1UoxjHRqSJTJiV5WwPYP4YJg9QOl6GigOo=
X-Google-Smtp-Source: AGHT+IGmyUsFoSszv+fFX1S9Hfb5LIc8WC5/DDJ3AFJI2cwDTPzwqnf8s2YrglMNMXLSksHQruG3ig==
X-Received: by 2002:a05:6e02:1689:b0:42d:876e:61bd with SMTP id e9e14a558f8ab-430c527fb41mr119609355ab.28.1760806715225;
        Sat, 18 Oct 2025 09:58:35 -0700 (PDT)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b4614sm11927545ab.33.2025.10.18.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 09:58:35 -0700 (PDT)
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
Subject: [PATCH 2/4 6.12.y] drm/amd: Check whether secure display TA loaded successfully
Date: Sat, 18 Oct 2025 11:56:42 -0500
Message-ID: <20251018165653.1939869-3-adrian.ytw@gmail.com>
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

There were no code conflict when applying to 6.12.y.
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
index 8553ac4c0ad3..a8358d1d1acb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2171,7 +2171,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
-	if (!ret) {
+	if (!ret && !psp->securedisplay_context.context.resp_status) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
 	} else
-- 
2.51.0


