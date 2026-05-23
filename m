Return-Path: <stable+bounces-253897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gTA9Flw3EWqliwYAu9opvQ
	(envelope-from <stable+bounces-253897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:13:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0045BD401
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 520CE306151B
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DF33A6F2;
	Sat, 23 May 2026 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgrIcqG+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE0333442
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512822; cv=none; b=ARqk/55EKl+BDVzSyWc07qgnR56oqrWP08nal3ZbMwwwFmdPaEdLVpKYOB7npOxtzjrMHZRpfFCT+7TNfI2ImVU7p7zDZVJv74WPP5QeRYzBL39QiAmGTtNjXgA7a9tF1bM7G5zJE4UfgwZOclaMugvRWcywVtUE23rIIBKRq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512822; c=relaxed/simple;
	bh=Vv+rBXMg+Icog16Aty71Q7I2UIjL+PEAOQ3S0oWuL+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc0KroKj6FZm12RkqxMWRDY7f4K9ZlqHVPMBEYQTD/AyuDs+/ZDyJvE9zJ002lD2XFaBZSncIvZrtG3p7OeQmuNz6ZM1si94AqjbdO8e+R7xEqIxwDyJvP3xiWCWK20rFzOrSTxa9ZgYq7mEWus+u14i2q21ns2OSUIlQ0lrxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgrIcqG+; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304545f5206so1688762eec.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512820; x=1780117620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJzf0QxClXhAIoPHFsXd6Vs6F+rAvHbI6FlA7maao6c=;
        b=GgrIcqG+jISmcVAp0K8lkOyscn8ul+BfMgcVG0jAeAwie2jDUPn6nTRi2/LQMsPSxn
         sDJZvwQ8q0lYng6Qam+wEVXdAlNy4rUXrDSotGosmwiZaBQ3JQQ4Kpj8ENbh+kx9ePUo
         vtjEZYtj3XSE5yA1KhpK9yp03VZ1ZJW4qn4BCEPlkFV9/kZMqym7HspMkdZcqM1V6R1K
         vLeiUZ/3HkdclYlJYwxzHbOYsONh5ic/pmsk5iUsdG6jsmG9XUHcG+EM/K1QROMTn2+n
         TsnevjkwhZ/M71tAzI0z8mrDuMs9IFMd/FycnRw8NggLuU74kNvK15uZh3HadU4e4NHM
         CKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512820; x=1780117620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJzf0QxClXhAIoPHFsXd6Vs6F+rAvHbI6FlA7maao6c=;
        b=qqF2H1+n8eCtHf8qlOtRQE5Zl7wa8KPTMCkKWshTGnUOJ7+oJWCfaXZeT0As800a7x
         1iHrl82PZ40Tbp3vLj48JVYdG5lIqsLJPbiOd8s573f/LQgEC5YTGnJ5sgiwGpHyHRFM
         89pxbvyLCBxs02CXiDqpWXvvSguBF1m5rTKY6HfnZmiGezPGNkz1iYBYOtfV3h5k0oBD
         PUEXfnSEEqASjUAVNLczSq8uQexT2ROgs3jScS+zSwS7WJjGJmNPvZkXRHDmFBAnEruZ
         dBBY62InHaGQw2So3NuVxrdbPgXQz4n/mx50uAm+/HBcSUhQ2xgPzj0ENXXcXmZDHLAl
         nBOA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ek3jZ4QpJSKi8YoeQmchYDesGnZAQMjbn6KJR4obx/ZlsDyIpuoeUK9wezcz+jqDGJ4UXrCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTV75+KMTGyjO3mI79D+moJYYt+UMNMSL/La6EKPXpDW+Yso+6
	Q+yzNw3jM1ni3oJHvug95Dxw+YTG7SmNq5P4FOwS322e7Hv125ExJc8g
X-Gm-Gg: Acq92OE740YIMJhDmqjVhpahz3zs0CN4nnGhvcVOpxL+jK2a0r7jQKxzrnnhSqygJhn
	wpBpNs0ktaTG/vtFif9Am+FYo7Faw4DRpTPOlf2FkudrtPLzX2fVIqchdYe1Yg1Me7vRJQW4Fgp
	dY75J5qp5V5Q2ameykETTtjwulCqhoqyBHo8M9XmBIfRhc7BivPTF3mgp+YY21X4S0bL0XqdCoz
	l1wcYhhMmPFYIhJa8WI0FPr6u84PXTEZwbiJCxj/+e2vf8PtEh03rm1hvDwhGGDSV9wRAarnnQi
	l1STmOYJuXGyqe9a0Crhtyj8c6SuE7I24m+m5cKcvr/kLS8oy04ZhQ5aP4Eu/Ol4PNZ+WmINBat
	c1ttrcRaTStXMkZ3fiehncJ1qHQikH3FvC3Y0SFSfY3nBHl3try+tKd3LAhCtCUno0Lf5dgjbU3
	mTS9t8zRhL7RpB3+rcX+zoML4MV6Cmus2DlUdmIqg446rmmBaTLdTY28YJxXyjN9xpt1fJfSfNZ
	z0lkSbJlNKgIg==
X-Received: by 2002:a05:7300:b104:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-30448ffc85fmr3364295eec.8.1779512819705;
        Fri, 22 May 2026 22:06:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 11/11] Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing
Date: Fri, 22 May 2026 22:06:29 -0700
Message-ID: <20260523050634.501509-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AE0045BD401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver parses CDC union descriptors in ims_pcu_get_cdc_union_desc()
by iterating through the extra descriptor data. However, it does not
verify that the bLength of each descriptor is at least 2. A malicious
device could provide a descriptor with bLength = 0, leading to an
infinite loop in the driver.

Add a check to ensure bLength is at least 2 before proceeding with
parsing.

Fixes: 628329d52474 (Input: add IMS Passenger Control Unit driver)
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 422b1be62303..a04dd3ea3a48 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1678,8 +1678,9 @@ ims_pcu_get_cdc_union_desc(struct usb_interface *intf)
 	while (buflen >= sizeof(*union_desc)) {
 		union_desc = (struct usb_cdc_union_desc *)buf;
 
-		if (union_desc->bLength > buflen) {
-			dev_err(&intf->dev, "Too large descriptor\n");
+		if (union_desc->bLength < 2 || union_desc->bLength > buflen) {
+			dev_err(&intf->dev, "Invalid descriptor length: %d\n",
+				union_desc->bLength);
 			return NULL;
 		}
 
-- 
2.54.0.746.g67dd491aae-goog


