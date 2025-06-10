Return-Path: <stable+bounces-152259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDBAD2EE4
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 09:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8469A1893930
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826FD280327;
	Tue, 10 Jun 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u7TpJ0Yq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E825C807
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540931; cv=none; b=WYAa1CmkYhPOhKkF1GzWr+zO79ql9RFk0HI0J6aASRJWoQxGhyR4/BbjJvcDOX6ptB3CUtMvN3pNnTFSUpAeHEEcOqw3J+loAoRRLsciasmhbrHWWWAGN8Flstbi57MhFeYIE4ALK7mXLOIhcR5HBQ3KLSfeNFpSAVBZDxr09p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540931; c=relaxed/simple;
	bh=qYWWP+zpjIyMrJlRbwnOtKfwQXnuMdXDuWoMJsoC4D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpJGpn85aT+b3k0KChlnQbIM6rALtHD1OCK+6z0oIb/e/2+mN/dHaGJkCbZ/WIasT3xMKP8oI8G06Kn7zvHhsmOEVS5mb6hPGpNXoE692UYgZLLjbU4cpcn1fAcfnvgrfQ0/nZzPwmG8A4BT9RKA9/3KL8gP+w6DAaDC0ueBpfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u7TpJ0Yq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d54214adso41633955e9.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749540927; x=1750145727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mwQDB1V1PMK3IYAreD4ugNvP/HNaIrh6csOiogWyt0=;
        b=u7TpJ0Yq1WEymvGqsE7D/Y27s89irCz5pmwCl5/FC6GRhcqoeKJhxlWyk1VvSynTxW
         GjaGEEw43TMcImdDQgsg+T/1GsKxkpG+K9tsoK0zOCh3mOymk71WDCK4jS8US/VJblDH
         MHnPGuMwd5IVUFD56ujeZMYNgxcYwX1QKyMN4Gb7B2/81m/DDYHK5htMtfZc6kGpd1SC
         XdJMFeuSwqsj/mwZsnP/SGR8lmVRsSr9eOVi+EDhlg+n9mlJt7lZdHKiT5QvVYlN57oa
         udku+6jEg5g9gCYtr/W11oL7u+7TtaG7pWkaJvR8Vgprk8b8nQKj/8UH/71kVY5eYiXU
         KZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749540927; x=1750145727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mwQDB1V1PMK3IYAreD4ugNvP/HNaIrh6csOiogWyt0=;
        b=b2bGb801FOHO3ZtrxXWde6SSrzgt6RNfLYNknyQ6TB9dgSDM2lDQclsGbj4V7v03Xm
         +Cuk54o34mjergVv501dsW9mZoPf5tSw6gAYBrWkPnm5zA4nX/d7nFkG+cdGAxxFKwoR
         eJqFfap7gPafOxPDpikgCR/hPqdi96qhthfrxp+Cj7ZIkk9aVSrrBnrLLZbMF2dWIaNk
         ktalRUQKoKxDmTq/cs4dhg94aUzOA5Xxx6hv6pmatujtQE+Xh80h2zSxPoqBQ2JBwtgT
         XJ2bEFj9a8/7EBSIsqp9iIrIooBsb0aIgOQWepMZmdNON3fNFknAvZa98P897nTL6u+t
         EhHg==
X-Forwarded-Encrypted: i=1; AJvYcCWmfMn78Q+APBoeanBZ2dkAHmP9HjKRV53UsP4Jfn+bYXIoKL5idlUoEPiUGf5rBYE7QYl4PMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhlgKaerZd2mhYjpHhHtUJiO5cWGmFR0kboSWJUVbH+oUlqsG
	olYvDuKgSm6fWYj38noSvPMFTjyB7fPZvlslK/m1IYfQtm2RO1k8Rj4DTvDK4xs01ic=
X-Gm-Gg: ASbGncuvs8yvsS8+vqMFy04LWJNiQoPp0FRVrSZCaWHHpeH4U5z1LTr+W0XwaVZyCXL
	yd1E5sN0dQNRjcgiFOrM6nKB/9NmLHk0gSn2wsqIVJ7tglhdJwhB/nPflEL+c4oHcF+3f7xy32/
	BjxVBXy/bGxg/j0bhtRcnugQQrej3cMnRq89gnMgOrXLQ/TePi2isZquPyRDTImrWB/7ZmWvPT7
	LTFv+97/cf8rbhsjyqdn/ceCvErOcyd3nTUT3GblEAy1CfdxsMxZAOLjhT7+hzbSucIGjCiiccB
	9uxsF5beLlYqYgnyzcw1lYb2ijGUgzY+YoZJHWg4U6eegujgJsW5xA5DDFUGzNgykrQ7WH58aaB
	5CCw93EyWfrfX3coRxQEbIcPBu/gk
X-Google-Smtp-Source: AGHT+IGiKgGq2K6bFjJ6JdVvMouVeeMTVCRkqaymJUWuhRWmRgHQPUaaS3Q7GB4qTMvVQt4GfV8udg==
X-Received: by 2002:a05:600c:1e0d:b0:442:f482:c421 with SMTP id 5b1f17b1804b1-4531de6ca66mr9848365e9.22.1749540927446;
        Tue, 10 Jun 2025 00:35:27 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4531febf905sm5995905e9.0.2025.06.10.00.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 00:35:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexandre Mergnat <amergnat@baylibre.com>,
	Cassio Neri <cassio.neri@gmail.com>,
	stable@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 5.10.y 3/3] rtc: Fix offset calculation for .start_secs < 0
Date: Tue, 10 Jun 2025 09:35:00 +0200
Message-ID:  <1f965f4886f65e45423f863930ccc7139944272d.1749539184.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749539184.git.u.kleine-koenig@baylibre.com>
References: <cover.1749539184.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=X84EWsmN871czU1dFWJrOfrFlJlzjw1vvjrJHqVSPyg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoR+ArQBYeSFSZJ4ktSO5e1eqFAZgtBRzAwzJ4n EhS6OOPI+WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaEfgKwAKCRCPgPtYfRL+ ToAsCACb/wdMka0BapKkfUDpg9Y9zstN7YdTWY+CZS8Vxb/UPnEpkfGVQ1KYOSfKQZMjf0v3lI7 +sVdYjDqeosq3NFXGd93UH4o6EOFXpcA7htkcgwB9S0STx/KQwdni4y6C7kDtst0NF6aiF+6Fjs bszqk6qEKjp9aEWdnlAyIgkpmuuGvP3E3YrP7lhJP0ChPRXoeY/1nB6pYxBBsjiKCZDvmF/pbrI 4hL6e2cI1CFNoAHBNFAKssJsKmuoQChJZFmWrccJsvFAN1covV8DMCOkVmquhzl7zFCTMxwYfLN pDq6P0xPpidP80QBa8u876FwSqv2jQ+Y+7rQvScBlofdudY+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Alexandre Mergnat <amergnat@baylibre.com>

commit fe9f5f96cfe8b82d0f24cbfa93718925560f4f8d upstream.

The comparison

        rtc->start_secs > rtc->range_max

has a signed left-hand side and an unsigned right-hand side.
So the comparison might become true for negative start_secs which is
interpreted as a (possibly very large) positive value.

As a negative value can never be bigger than an unsigned value
the correct representation of the (mathematical) comparison

        rtc->start_secs > rtc->range_max

in C is:

        rtc->start_secs >= 0 && rtc->start_secs > rtc->range_max

Use that to fix the offset calculation currently used in the
rtc-mt6397 driver.

Fixes: 989515647e783 ("rtc: Add one offset seconds to expand RTC range")
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/20250428-enable-rtc-v4-2-2b2f7e3f9349@baylibre.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/rtc/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 625effe6cb65..b1ce3bd724b2 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -314,7 +314,7 @@ static void rtc_device_get_offset(struct rtc_device *rtc)
 	 *
 	 * Otherwise the offset seconds should be 0.
 	 */
-	if (rtc->start_secs > rtc->range_max ||
+	if ((rtc->start_secs >= 0 && rtc->start_secs > rtc->range_max) ||
 	    rtc->start_secs + range_secs - 1 < rtc->range_min)
 		rtc->offset_secs = rtc->start_secs - rtc->range_min;
 	else if (rtc->start_secs > rtc->range_min)
-- 
2.49.0


