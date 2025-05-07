Return-Path: <stable+bounces-142045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC20AADFC5
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B493A94AD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C6283CBE;
	Wed,  7 May 2025 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Lo4kv64Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40228368F
	for <stable@vger.kernel.org>; Wed,  7 May 2025 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622245; cv=none; b=mgQcn+NtXl+Ss1iKMpa0UFq2wvWVCLNLrtLsKXA1SDVHlGedcljxZMSr8rGqYFmbS6Vs6V3pQ8PiU1lBAIDgWXRza2LxNJydkJ/jrzHYx2sRkYdduvBdg9dni52pLWt6qI1kOX2F2nQ7NJcq+kp0WI0dZPrBXLOQpGSDpZu1dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622245; c=relaxed/simple;
	bh=cSM0SXbi9Fi+cYc6Hqvd1VUGwSL3FdGobsRiWjVTLxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=annz406zuyw6fNV2XTtCfzdmtx0OekEYuQ+LTDTWhdmQNjzknVPrI4/E/00mWJJdSB40zEF8qYl3jZA/gyWAocJZRrbZN5TYfHoYB5np4zD+j5wMwv+P48cM1Gbt9MSbCrDiB0PxLquD385AfLZwXl98CAvK4JHHvrDz6tMrNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Lo4kv64Z; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so9328173a12.3
        for <stable@vger.kernel.org>; Wed, 07 May 2025 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746622242; x=1747227042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II15ozzD5Ll5bPmianAxLgZ6qAOgIxXenrt045Eb9ZI=;
        b=Lo4kv64ZopQ0mXQOobY7q8w5WtWOeuwyKhu7i6D8uYw9eHObqv22iSMZburpsMq5DC
         vUqE+sB/aNbYyXDsBdSnUU9XaqTypjMR8nXgR3wVKPpuG3y88vuTLdYJB0w0TLOts1Tk
         KQ1VAXahhB3mjqEuPwkBQj/qLPBV+Uq5mCkdWPAclmZwIs1gmxihB7PWaSntNw2qIO5y
         OpWHTDgIa5PmEy7O/O7KDJGMGEeGknxsne+xD/IFjYeDIP4iy9c8UsZ+S+y1CYIGjlXw
         VtSL+22LegsWWWrghttxf0gbO5//1YsyFCEcPM4gZBpvOJYeI3rP9PenGjcYrG0/eyi+
         ThrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746622242; x=1747227042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II15ozzD5Ll5bPmianAxLgZ6qAOgIxXenrt045Eb9ZI=;
        b=Mu6cb1oF+qltKghoCD0UuxhbRznpcnGJd/9yvGYsod+VClngO3uiYW3m8PK3VV6XMm
         uWhFYxs+ixW2aL0yveKKgM/XFJIrIQwh0v/CTGvXDTFkJJjRWbhRmTtng4rHaGesklr7
         gUb65flko7PlvWgFw0hOU8jx//m8g3swCYCYl02Y6+P5Js0WERnI11mI5KRp4CHiTtWd
         +NrB574kpRokEIGy+r4w+MnlkFve2QALLpzmPgLuQUd3N/cMA/5aqbB9Yt5+qETuxPQx
         RPCfaSbJfGpIC5uXskpOAtQVqZFFHV2Sv5cw2zvZy7xVTM8QN+b5Se3qbTiAWjbNenXs
         Z5jw==
X-Forwarded-Encrypted: i=1; AJvYcCUfKa5DCyFtX7mkiU5RGHA/CX+OKZiRPgWsnkr529EYAPZcvdvXxr2/eB9be2+6U9AX8SLTtfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKb9u3PhrNnroEruaXIlZ5uZV8lcssP18XXzfkUCFk/fQcE6s
	mhc3Cx29rWhO9V4vPoYZAyLrO6TQqYfdlECYT+LZtKYD2ffNQxxdkWuYZEQUcuQ=
X-Gm-Gg: ASbGncsS/zI58UU66WJNoTucjs+pecaq+gRAY4xuep06vxr+X5TiVCZ6DWetcL04Zrg
	9/Ehq087L8dLYei+czWfdCHzUo/8wNsiznYCpWYMpa2aPRMjup1ry1q4ebDiXy9TlvOVWFEqOdN
	1kwnm4WXOX2y6pq7t56WRELgAJCAhuhuVrdIQ3yRqPvBI4gdZFWnhYV2+sQpbCKnfQYUzM34dYn
	QhVb4kUhlvHxUJfCIIFrWT2riOf2dyy+u3EgwajyoDi+6z33AHc41ooQdw7Tategtb/MjRHIb9s
	bwyCZBu/ssDo9TvhVmqkKUDICNRoe59nIUIc0XcTzHHee3t6DYpgNjU0b5USkA+p5XkqJ9w=
X-Google-Smtp-Source: AGHT+IFlk8miHuB42VMfUHBSf4Jai1MFWbXY60yj6sLC16sMrTufuU3xeUkiepwAWbCikXCtbz3w5w==
X-Received: by 2002:a17:907:9411:b0:ac7:391b:e684 with SMTP id a640c23a62f3a-ad1e8d9c78bmr295475866b.58.1746622241642;
        Wed, 07 May 2025 05:50:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189146fb4sm913182766b.10.2025.05.07.05.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:50:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	horms+renesas@verge.net.au,
	fabrizio.castro@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RESEND v3 4/5] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
Date: Wed,  7 May 2025 15:50:31 +0300
Message-ID: <20250507125032.565017-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507125032.565017-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250507125032.565017-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Assert PLL reset on PHY power off. This saves power.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- collected tags
- add an empty line after definition of val to get rid of
  the checkpatch.pl warning

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 00ce564463de..118899efda70 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -537,9 +537,17 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
-	scoped_guard(spinlock_irqsave, &channel->lock)
+	scoped_guard(spinlock_irqsave, &channel->lock) {
 		rphy->powered = false;
 
+		if (rcar_gen3_are_all_rphys_power_off(channel)) {
+			u32 val = readl(channel->base + USB2_USBCTR);
+
+			val |= USB2_USBCTR_PLL_RST;
+			writel(val, channel->base + USB2_USBCTR);
+		}
+	}
+
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-- 
2.43.0


