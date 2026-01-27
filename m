Return-Path: <stable+bounces-211869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOlfOT7teGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:52:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEE97FDD
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DD273047DC8
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE3361DD7;
	Tue, 27 Jan 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lau6TCtt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D473624CF
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532656; cv=none; b=L60hYsyszMi83yZYh05PkCmIPDWo5rm0L6Ln1oDRJ7TGAEK3MpJQ7tx8zWT6NbrDuNHXL5C650/wf1JV4MxgnjY0z9YpI4y3GSm9fzS6XFbMkAukxlTSqpAlDsg4lZ0fhYBIVTT1VBV3YcHytgARRdPL3xM2BpYIRdUcFgMT4Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532656; c=relaxed/simple;
	bh=nuy9kCIcT6D2JU2yrVi1wvj+w0vJ76rxXT7o2vo9aSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMQx3oFjDPXdAPLsR5A+KU5FCJOXDaVbEyRKHSCKhOByylGvw0X7kZnPCImHC1/QzZoIiAkHcSWtCSFltcb1RnWg+C0DXLLwCMrryhumBzHvFjeakzn5/gipslfSMXId7D7r8OoCyYIzs7kzfEX05fWnEpVL7S+Pa6LBSS8Jy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lau6TCtt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so62029695ad.2
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769532655; x=1770137455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BKn4aFL+2s1aT9WYTZvpY1Tv/MFVpnlV48wAgQcplo=;
        b=Lau6TCttDiAvq1/mIDoYn9UZEi1GT1qTVdLNU0rmEXsr5hMuS2BQwEpDMl7hLZnga+
         vQ1gBY4Kuc1M7MPiPKEN9BhhFKMEpeMfus5Wu5wW2eNjpQvc31tTNT6HPrff+RRhyL0a
         Tgib6kOvBoi5r2g+GbtEkXexZODoOw5CJksV10Yww1FnzCDXAznpn95yqn6UUVdyT+Xf
         44tbGYEHpfR+/lhcOz44HGj+FQtb4n6DH7pnoQrdtImPFwAuYa8sUcbUP7LPMfpkxd7X
         tu9L95oKFBRHlKBUUN97f3mBnp/4FOLS2vL21X+rIrsdhlpk/TsuiGDtdLpHkxw7cYd7
         tAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769532655; x=1770137455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BKn4aFL+2s1aT9WYTZvpY1Tv/MFVpnlV48wAgQcplo=;
        b=aFGDVjF3yFJGhnWDoHVaPuwF/kPkapZFifcqN5DNeQBHMVz6ELNfPjD2a6aVS+8e/v
         kRCdZ47e0kTWWpQdiBJ5ywjnt0UKts/EhR54TnFscjBpiooWAtUJ6cjfR2qnAsBtP+X+
         vuKexgOgw35/gWUDKxhBCEZQ3/Avd4wGnolKmzia2AwE54/hcxm39/eFw3aI/SlpTs+U
         GVJWvmCXLCc+w6LhTQGam52SwBdxTQ9aY0j4cUXcwlk2rJO6zAdlcB6l1lLJHUg+KnNJ
         5YchvqWK8CVb9xDJoRorXUWok7q4lapX8HLmuC+29dGgAtVI9X/9YDDsx5v4QFuj1lnt
         1R3g==
X-Forwarded-Encrypted: i=1; AJvYcCWYDvMDZbYg1vk2dWgEA6T8H9UKxl/ws9KQD2z8KWsqlE0+U1LjKQr+XnqLQXHdP6WllJjjUcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwOP9SzWrDiOJ+sNBbXfg/xSf6lgR20TB7aIiaTJl0xx9EcZx
	Z/XWsEylVsIb/ah9XKnteoHvZPOMSnx7ytWXycVxd6mdHWwS/Q5fOVLDJ+aHNByU
X-Gm-Gg: AZuq6aJOkjIc78H/Ipv23v50/ieeb6cxdb+VcVkczPfZX7lAN/gPm3UTs18LqP+s9rA
	B8bxEBrc+QGrocl4lZFMm7k5CTIyRztnWIMQx8QN6cH0w0NeBWouJ1LuJd7iHp3X9wlPf92sRaC
	En2fvPWCTpjkjCUBMDp4E4UdZmP4VaFZGiv0qmXW5p1fcYtG22BLjUtQyBNa5+AB6FXULVcjYRP
	q7YEywR36YJZwGDGaqeiw/zoaz44yGfXqETVyRwsSrsoOnqN07Gdd9e2XJZCJejeePH3xBgiuL/
	hClDIlwN9rupnqPXM5/SuAMy3qHbuBjnNdbhjvfk11c0KCSi7AcQB6CrEi+1OEQ7FdRXhw7qpY9
	HjavZmPqpA2i/EYvDnUizLan0eTmhN8pK03PBDVutnQRK6LWuHuoBRHPuLDAbqPAbcW8xkXhpOp
	qd272u3VxckTYipxgp50UiBsmZKfrnZXQ4S+2ZBrWbxcMbJw==
X-Received: by 2002:a17:903:3504:b0:2a0:d5bf:b271 with SMTP id d9443c01a7336-2a870e18902mr23308865ad.32.1769532654708;
        Tue, 27 Jan 2026 08:50:54 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:d29a:ea37:2567:751])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa46fsm120318675ad.21.2026.01.27.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:50:54 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	rfoss@kernel.org,
	todor.too@gmail.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org,
	vladimir.zapolskiy@linaro.org,
	hansg@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	stable@vger.kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH v4 2/2] media: i2c: ov02c10: Correct power-on sequence and timing
Date: Tue, 27 Jan 2026 22:20:24 +0530
Message-ID: <20260127165024.46156-3-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127165024.46156-1-bjsaikiran@gmail.com>
References: <20260127165024.46156-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-211869-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95BEE97FDD
X-Rspamd-Action: no action

The previous power-on sequence did not strictly follow the hardware timing
requirements (T1), potentially leading to initialization failures on some
platforms.

Update the sequence to match the datasheet and maintainer recommendations:
1. Assert XSHUTDOWN (reset) for 5ms (T1 >= 5ms) before enabling power
   resources.
2. Enable clock and regulators in the standard order.
3. De-assert XSHUTDOWN.
4. Wait 5ms (T2 >= 5ms) for sensor boot before I2C access (using a wider
   range for timer coalescing).

This ensures the sensor enters a clean state during cold boot.

Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
Fixes: 44f8901 ("media: i2c: add OmniVision OV02C10 sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/i2c/ov02c10.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index fa7cc48b769a..3bfbd0deb126 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -676,6 +676,12 @@ static int ov02c10_power_on(struct device *dev)
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
 	int ret;
 
+	/* Assert reset for 5ms to ensure sensor is in reset state */
+	if (ov02c10->reset) {
+		gpiod_set_value_cansleep(ov02c10->reset, 1);
+		usleep_range(5000, 6000);
+	}
+
 	ret = clk_prepare_enable(ov02c10->img_clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable imaging clock: %d", ret);
@@ -691,10 +697,8 @@ static int ov02c10_power_on(struct device *dev)
 	}
 
 	if (ov02c10->reset) {
-		/* Assert reset for at least 2ms on back to back off-on */
-		usleep_range(2000, 2200);
 		gpiod_set_value_cansleep(ov02c10->reset, 0);
-		usleep_range(5000, 5100);
+		usleep_range(5000, 5500);
 	}
 
 	return 0;
-- 
2.51.0


