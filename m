Return-Path: <stable+bounces-238183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P9BDFba32lvZgAAu9opvQ
	(envelope-from <stable+bounces-238183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:35:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF874071DE
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7C030674ED
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF63382396;
	Wed, 15 Apr 2026 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQET4FmE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A403822AC
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278090; cv=none; b=hOYwFRyXlly9Ul+kuEnlIsgUsi7qpkqrh5wWbvU8kD7A4qBgzPSbIiO3ggByC5kgav7kCcXyv9WmVyv2aOK2+P3sxOo4r5euyGALACmyyi1m9CjFGnLNKW7oFnP9ulmdmSosbX+TCocje0mi/tx6KGJA7+CA+fDavreXET5d3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278090; c=relaxed/simple;
	bh=EdXmTvb5iJMARAAgUZi6IM1Lzl1CxlswTvTQaFCjcZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEuAidYjK4PNVw1XN+bSQISXIAs5gxdGDAqcx45pJ/DhlbmjNDrcuceWB3Gqj6+8Y+SnNWmxQ/KDzqkDWORHFG/pb9jN36VSFAlNA5RxhW1KHn1Ls3rUd+HwHMPz4Igaa5uToQ8xrDbV1YI3I3tVy96V2yylki/t6XATebAtxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQET4FmE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso4206389a91.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278088; x=1776882888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cipgUIxDH1EraQWdbgHFxKTYEd0SYP1EjujyQwqyAUw=;
        b=IQET4FmEX+DjZLOuxYojPfLx4fO9M6adJYho9jgrwimvkWP/bemB2lXzMPVSjT9goT
         lXor0h+GBGR8s6+Pa2Lf11eBlQrKDxNVtW6fKQOWen5Cf9gTFDRcJfsZUlUt9SDREq+Q
         oJEumszdP09k3NPlp/QGBYf/YIQYZAo9VpfDg88C/0+cHfv66WeENctbhb3yqxj6au0G
         LpFs2T8ImLuKeeJSbBSznGetYPwA1NBQOqCpbse5Ml0jEGIqPM447FOvsuBgM1rwrDMC
         BsqRf6M1ym7heBLEzC0/jmNg6Z57yGVE+B8fpiv2xlO17GebHy8fRZjBkIMKxnmzgVEG
         sl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278088; x=1776882888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cipgUIxDH1EraQWdbgHFxKTYEd0SYP1EjujyQwqyAUw=;
        b=a377VX6riLlc+ejXm4CCUcQ/M0CuvLvZrmR+10Wn0KzdTnHQ9JE8i6eSqjIlX1Y2JQ
         1lfH+JM6KQHEQazUdOqiwEc6y8YVC51EJ9z479rUaxXJjshgtNJ22wF5Begn8PZLoHwG
         zfGiUidHMDujYIFKk9EfJ1YtstQSLdX3PuByKhviN66QjtGBdQffilIKfltXFeGmDnk1
         E0/Kois9wcONdIdImgRscGycGBnrF+TYnaswpZG2miZFZ9njozRO3/XHhYSVGwFNsFMX
         YjoUZb1Eb/K+bn9XtbcVwILpXmFPVcaSG+8e1swGlGbhXRHJUgW5LuuXyj7zeg11fbzX
         R7AA==
X-Gm-Message-State: AOJu0YyIooUBahl9PKnVOzV5xfbd/1T2+XkA59H5ALpRPV9K2u/1pJfe
	0oSPx2emOx/rSYROR4AQXEKn1n8/4e7oYHqbkdJZRqDWhTT3gq4mdkZA
X-Gm-Gg: AeBDiesM9jIVXG7sptQ1sO9IkwiCTMBaDUW+q5Bv8iQXiliqV5ghUXjuIPYO3IEojop
	vZ/GXBh3MBPzhgZXfhOplAumlRDYX1PM9HXgM3TTMGw+xB3JsZw0TSgr75n7wutdgQPkC0/8I9D
	FBn+vuSMSqp7QKHwaTTZ5LD3eXY8i+5sasVLZQpgHpx1e+cqWtTNKvNKzVtTsI9gDTFpGpDIpvP
	Id4DRWQIFtFDqc+Af+8btq0b6N/g396ahD/wp8dv1her9hODgDbq+CD1fddSr0Gq+0u/795W5BI
	hSvCw9HqmlovuN3AFmgjH4Y2IogUth9vDSCay48NueU4ax1UPl5mWPsjNSE7K61sVD6BguRAUDi
	9du24alOW6m1zi2KfhP5fwJbLjkla/lgWVjEfBLFh7jiHlC1y3EUZ4Vkn6zQHsdQPXgV7cLbzAE
	BSAGBvCTxrGfiDr39ZHzh0MAizMnBvcQXpAqVd7Zsgs0HxgQ==
X-Received: by 2002:a17:90a:d4f:b0:35f:9ab2:a5bb with SMTP id 98e67ed59e1d1-35f9ab2a834mr9337216a91.10.1776278087627;
        Wed, 15 Apr 2026 11:34:47 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fce6e8e06sm1695268a91.0.2026.04.15.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:34:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_accent: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:34:36 +0800
Message-ID: <20260415183436.3763871-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238183-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,dyn-67.arm.linux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BF874071DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in accent_init(), the embedded
struct device in accent_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  accent_init()
    -> platform_device_register(&accent_device)
       -> device_initialize(&accent_device.dev)
       -> setup_pdev_dma_masks(&accent_device)
       -> platform_device_add(&accent_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_accent.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_accent.c b/drivers/tty/serial/8250/8250_accent.c
index 1691f1a57f89..e9cf40268c0e 100644
--- a/drivers/tty/serial/8250/8250_accent.c
+++ b/drivers/tty/serial/8250/8250_accent.c
@@ -25,7 +25,13 @@ static struct platform_device accent_device = {
 
 static int __init accent_init(void)
 {
-	return platform_device_register(&accent_device);
+	int ret;
+
+	ret = platform_device_register(&accent_device);
+	if (ret)
+		platform_device_put(&accent_device);
+
+	return ret;
 }
 
 module_init(accent_init);
-- 
2.43.0


