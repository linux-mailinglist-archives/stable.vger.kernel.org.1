Return-Path: <stable+bounces-240966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCs7K5J262kQNAAAu9opvQ
	(envelope-from <stable+bounces-240966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:56:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6421445FDDA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD526304299A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22823D813E;
	Fri, 24 Apr 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cznsQXEE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568343AE6EB
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038675; cv=none; b=in0y82Kevq51jSBXUh/KiiJ/1bR4mcDqbpDQycrMcb+mcPx7GVHbMT+yO5d5PrfY/V4zGNl21VRpTipvpvIT0RWg1A9TJBcVDumsVWdDJJyIXu7wg0DB7Hh7d17Pn8Ea6PaXOIPrNGcG3eSQFilgVwNFChPyZJWXy1KHM6hoLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038675; c=relaxed/simple;
	bh=858P5mFpF+TrKrI6ZyGiotk5+CzcEz31qN54eKosWAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnWGDNtC2aMICFKhkXKe/CXWnvVUvIe5BXltnXLcjh1TqVqUHia/JIVigSUnX4dVwS/fhYZX37HXOZPHg9ACyLLwhIEvt8yv+wdIL92O8ea5dH8K/OpjCyYv2z7Y2mAQEXinCstHpSpbLAiobRL2bmBo7LIJuYqilDrxupuqtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cznsQXEE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82735a41920so3232839b3a.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777038673; x=1777643473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5BzP7d1QHnmFXYW9OV542PaMIY/QnoUuc/2j7D+PjyI=;
        b=cznsQXEEMwHAveO4Uxx/xWl5VJxSOL/au8OU9oKdR2sDP31241rakHs8I5v9EYqZMu
         lPlPRII2yJcuXxNBX6WNvCXErWyTpBNBlTFHBtg0FahHT2iNydo4OSc9UCgqwIIFXA/J
         qlPX7279SnHS91aBK/b94W5mdp/kQb0uCVW0RkDjpJ7RqSfDa97tFuSjluu/8B98iO3c
         /THZp7Lov3MY7x8sUV9KjGnPuNkGNmC4xHhRmKAGPChrxYC2D70KWQnlOiE3eXsBox8J
         OWhIU59W28hjeeD69vjxneHcvlh593UWOc2kkzJSBBxSgsa9W6k0rAyKv2kJmXp1fOYy
         N7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038673; x=1777643473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BzP7d1QHnmFXYW9OV542PaMIY/QnoUuc/2j7D+PjyI=;
        b=q3kWAauOcR/I2iKtL8LYUeegSRavV6wCKrVkgaAvTPdBViwfeaMpz4fK06XYcheBHn
         9TpAJP8582dUcCY9Sd7Mp0nElXGjnxQ7V7JVkrVc8Ul4YjuDs7XEeN1Tf1kBwTEJ0utG
         Fepa5PWsKzcKIe+OLbNcWO0yIWK72KsOX1OoiimlNkOFaVt0OWzmlHDmFDa2PotRqfcE
         rWpmkZoHheYv5etDEqTabfP5rySnbwVYKidXuCf6e+dK+pX+Fhao10md/EWo9X56Cn1p
         euR3tQN7/ErU00q+tnsrUOjOXmsmqZUkr4D+Q9dr93l09SDVfvxWbX4EjH660PKmSOHD
         re1A==
X-Forwarded-Encrypted: i=1; AFNElJ/fh7WvKiWOSM+pXb+qe/4UbeSoQwcqfmDiLxThE/GDsrtHGHg3jILMEY0n6ihfOytkC3dnsrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUihQcf0a+6e7w3NW57LD+y24lCRcS9s4aDhEW5uNwgqEGQYW
	ZWXDw+X+QXEqPYwqiRVag91oLREomY9zcCTiuoezwSDPGCtDi6z+m6g=
X-Gm-Gg: AeBDiesARGohhhomgUvwQVstYzh55B4jZ0qcuNaAr/9QIakNbZxpGfP/51NPl+4dCxp
	vTVeEHyoySSyf9gQO0IXFEPApfzHtFtUpZOvPZprD7FerTSFLjL5ubO2FCRt08hWccooHfjMisx
	NEnA7w1lY18ifk+GEF/iBnxVl9BeDniezJ45z4//NmhbPNT/RHm2KWLXMRjbdjd1sTDRBR63cMl
	Nnrjv4TMjRdPv064Q6xjlf9pJjHHLm6id8Lmb+mCOJL4xBr6mxw0WDAoPjiXaqOojaGWYJQuRoL
	hR9819YECfdHN7bi75hR+zMgVD+Fi+HoqufullOK3QDMXplnF7uytrsfym8G9SXLlfKqMn6nEL0
	+88Q3xLoDPs5QAKf9Gh3IzBmKo8nYAvOlBW3LDa1dWhzX1zgZVKy4N88DOpD5dJS7+EPXsLClel
	PfQocQHuxelMLR9H42tS4VqfvL7BmMTjRtORDeUeKm0Ph8dzcf72/4rQ65XUYGNpJx5YhRZnSeG
	gc0TicLFxOixWk=
X-Received: by 2002:a05:6a00:1307:b0:827:3b1b:43e6 with SMTP id d2e1a72fcca58-82f8c83bf5dmr31712297b3a.21.1777038672699;
        Fri, 24 Apr 2026 06:51:12 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm22402386b3a.13.2026.04.24.06.51.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 06:51:12 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] hwmon: (corsair-psu) Close HID device on probe errors
Date: Fri, 24 Apr 2026 22:50:51 +0900
Message-ID: <20260424135107.13720-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6421445FDDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

corsairpsu_probe() opens the HID device before sending the device init
and firmware-info commands. If either command fails, the error path jumps
directly to fail_and_stop and skips hid_hw_close().

Use the existing fail_and_close label for those post-open failures so the
open count and low-level close callback are balanced before hid_hw_stop().

Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/hwmon/corsair-psu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index dddbd2463f..76f3e1da68 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -796,13 +796,13 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
 	ret = corsairpsu_init(priv);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to initialize device (%d)\n", ret);
-		goto fail_and_stop;
+		goto fail_and_close;
 	}
 
 	ret = corsairpsu_fwinfo(priv);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to query firmware (%d)\n", ret);
-		goto fail_and_stop;
+		goto fail_and_close;
 	}
 
 	corsairpsu_get_criticals(priv);
-- 
2.50.1


