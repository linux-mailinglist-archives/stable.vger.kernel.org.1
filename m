Return-Path: <stable+bounces-132120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88090A845F3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D067A6F5E
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE928C5C5;
	Thu, 10 Apr 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MnUstkal"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82921CC6A
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294544; cv=none; b=aVKx5z36PuLO0IBgh8HNGpFl7h4Zg65ghezBL899EbssZKkDlKrgyzJWXQMdhS7Os3C3+0sB2P0uw9Sb+AUn78g1WNhwodA+Q28/g+KHoV+Q7qoFLzDSCx6+250bIPdLq0p8cByv4fxp6rrQlu4XMhYTzvWxyCVSC/neHAs8UwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294544; c=relaxed/simple;
	bh=WGrTOkWpO0sHWUslK1P+MDusc9W68dggbixV9wP52ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mU2kM3t3yNVL30A9SuLqs8y1vGJW0CFoLGigFAWzCgkbj60VNnDq3d8pwdkB9umL9T1upKSPtbfSJ3m/eAwu/DMWC0junDdC0xRuchszt6AdQKlvskA/5xv6r2JfZb+q/sDGZqNCSv+wAOG4D4v9AWNTiO1EGQhlS4Ds6OiCTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MnUstkal; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1efc4577so464485f8f.0
        for <stable@vger.kernel.org>; Thu, 10 Apr 2025 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1744294540; x=1744899340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q4flrwFmi1xae9xLSDs3kNrmcK2M75jTbQEeJS0lPw=;
        b=MnUstkalufEjVIF4cmtkVy3QVs10e7j6bT8Cpb+fjkfSDiaGRUG37y9ZlATmewOt3F
         R5jOiGf/EQfGgVAKy00/UcXMrc2tIzcX7VAzAK06aHEYtbDtbfJznHgxLlEytyJLmANR
         yWoqDwiUTsdWzDl6UmjKfx34SlfNzH3q/QY7qqdPDb8TOc5jheu9RxbCFLTOGWXX7jQ+
         vwJjx3C7TU04Yg4l9qDQvthS84MvN8/fMdmgEXAQ3N8n5zGgahMK3o9dvuLRsaAkDvGr
         DGce6rV5mHeBo0sKAqSNcq8dg59R5AqGzvkKjzhNiidE0hDtPqRozl4rgv0O5RE4WAMR
         W7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744294540; x=1744899340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Q4flrwFmi1xae9xLSDs3kNrmcK2M75jTbQEeJS0lPw=;
        b=Z/8coIbT0Z2Y6nP0FqRrcKiVYDlKTM42VroUCWZr9T22nmYQySyc42IFb+1lHvO5I4
         ww3HqgKTiJzWt9keEAOnJ9OsoRjlBS0Eqah4NTiB94ZmxZ9tuky6mXzpFsUeJBqkUpu6
         hiXkA5xwAUeYDzbM1ZLjsHzAsClq8GZuhW8qtglB6FMlwvg1abnb3sFD8ols11nDeYxO
         6UV45mKzc5K7jAET/32gZRo/0jpOHufdpNeElZNCIxaXmrTclIuo/aazWC4VmCGrn8u6
         ytgxKBME3q7vVhgsBGDCtU5a3uTJjaGYg5fSaNPxnyqIPZL+WZXaRA5iyrnWI+IHpJqY
         NsnA==
X-Forwarded-Encrypted: i=1; AJvYcCWlWuFKIyF+sTvcgocSJxcyriOHfjp+oQerc3BM2mFXIdCF+DibE///A8+RS889PiavXXe0JJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Rh4+GvOG9X3C4hUIGikWlWVo+EQyJPvDLk4zvxLZ8zFGs8UR
	PV+7Bf9X9L9VME/XNZYxVyZMXevMSsN3eVuRGPhNK9Z9ONcljMNw0vdkfQvx43rcrNX4OsJlgpZ
	N
X-Gm-Gg: ASbGnctSFyFS+iXUZFKr5oDazi9cvMKGxEO9ANBbIFehEMlHbW6C8m4eRwTQTalx4bY
	x5lO4qMIPfNqodUgf+YyjhMH2hGbcc79OOOP4fviGq9vx85QVa46sxqWyrFRMnsKTThuvPeW1Ok
	XNtw/l0QDGB8FnO3x/0poCbwX1OkHGHOkweQzFGfyOglK9FLnkXo1/dc1VGWdEdjLlZArqiC/0v
	F0eH/BTMX8qOIPSJXyBvTyVPvAXl/qf04RU+NxQZzXqJdgmAtWr9Xfj/eZU6cQQ+fW9gsmXjBVz
	bijy82313HzcUBO2n5Noe/nAJNKyXsjTdoVEfVQH2yQnleYQL8X9acipar6/92D2UUdK+Q==
X-Google-Smtp-Source: AGHT+IGOJrWtQiR/+aif2Q/6zHmp/n0I43XYjAwcFJCsTWbMwppiDvii7C8NCnUY+CCFFVo3ns+03Q==
X-Received: by 2002:a05:6000:4022:b0:390:d796:b946 with SMTP id ffacd0b85a97d-39d8f4dcebfmr2487414f8f.44.1744294539831;
        Thu, 10 Apr 2025 07:15:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5b08sm54864275e9.33.2025.04.10.07.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 07:15:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: claudiu.beznea@tuxon.dev,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Date: Thu, 10 Apr 2025 17:15:25 +0300
Message-ID: <20250410141525.4126502-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In the latest kernel versions system crashes were noticed occasionally
during suspend/resume. This occurs because the RZ SSI suspend trigger
(called from snd_soc_suspend()) is executed after rz_ssi_pm_ops->suspend()
and it accesses IP registers. After the rz_ssi_pm_ops->suspend() is
executed the IP clocks are disabled and its reset line is asserted.

Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
snd_soc_pm_ops is associated with soc_driver (defined in
sound/soc/soc-core.c), and there is no parent-child relationship between
soc_driver and rz_ssi_driver the power management subsystem does not
enforce a specific suspend/resume order between the RZ SSI platform driver
and soc_driver.

To ensure that the suspend/resume function of rz-ssi is executed after
snd_soc_suspend(), use NOIRQ_SYSTEM_SLEEP_PM_OPS().

Fixes: 1fc778f7c833 ("ASoC: renesas: rz-ssi: Add suspend to RAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 3a0af4ca7ab6..0f7458a43901 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -1244,7 +1244,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
-- 
2.43.0


