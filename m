Return-Path: <stable+bounces-246765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKxcMSgiBGoZEwIAu9opvQ
	(envelope-from <stable+bounces-246765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:03:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FFD52E607
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FCA1306BB37
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D143D5645;
	Wed, 13 May 2026 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRbtAcGu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D363D411B
	for <stable@vger.kernel.org>; Wed, 13 May 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655781; cv=none; b=jUy6ANKHzytKh/yitQbVUDIe5VSOhjSTBL1FLc0b3qMJ25vmnOFCnVVKmWc7lM0gajVmQK9Dl+qUfhypL+qTkR3Dy6l+Gvb3e/mQibHf5l6Sh6PNX0FZr6dJX5iTgl1oxUs0YGltgX6wBousDf6YNYLWvyTL7pJNnm9uECF0JXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655781; c=relaxed/simple;
	bh=eOOYOcqT3op8hwOvsAG2awwbAC9YwaQbYCu+tWEDbu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVRftabmPyKaq9wBq+4xxTOMB2d+PAj3ry6qD03hNmG76N1REoISEou5s6l7GCCdLk6jQNOHEcQEQ/I+1bOGn0lJW9Tyni9TIKnFO3b/qBx6ExYCa+q0YmtF5UeKSabMIBYtnSMR/jgk1tNIJ6faqvcMO9oSfdYSFDL8q72918k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRbtAcGu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so2564003b3a.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778655780; x=1779260580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GaH9g17uem0QR3nAcOAHHOsv86hTEnX1C7NUBwFlEN0=;
        b=LRbtAcGu+iIDHOSJxA1Bl1LRZpQwh/GKxKs5DYwhMxmbKwOa9MTZSb4JimKkXGqh56
         xivUS2+SspTXjQIhYKD72Xyttbkr1WuvZFJUGQGnQGKiUFqNKKJlWupW8kTelNTPGl9k
         DqnYg5Irhckl5W6+402d84PjmQkpztfWgHU1A3J5pfae3Nzt59EySeL2SgdoSVCcz+Cq
         e5NIXuXNJmZoBVRs3BF+u9qV9plcbTUQbOF9+MvNGH7vqFJI6krqZThCIqiZ4U1vQdIC
         +l3WO5q/HNfB9r9FoWwbAjhEJmrC5941cEyyUXUJVLOQVD4afs+2grL09xtqYU6WpUPp
         e0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778655780; x=1779260580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaH9g17uem0QR3nAcOAHHOsv86hTEnX1C7NUBwFlEN0=;
        b=T8XlpwEOlYTfCAm+EqM+Hkl0OI7B8x9EFufjSNacLjcppeh9AG6nH871bCUaTYRuXL
         2sX1IAs181po16Ta+rGxvxSjU/9p6MpSRPV6fZypsmm7FTPlXUm2+fTqlSdpspV9TlRa
         gn4cX4j5vNEhiv62/62tknSJ/2pg41zvpRy6oo5MwH0p2Abv/wMFEp3aVTIbv01oMtj6
         dg3mPrt1YIISLm1Gma1R4w57D9saBqdykRYmkFWbhdNAH5Fs2OH8l3vJSN7XkPIczf/K
         MwMPqq/zF6xGgrXzidyZ4fX8h5oY8qkLwpJ0a2ic8ceEEFfqrF44ADkRCrf5woOcf51B
         S+Rg==
X-Forwarded-Encrypted: i=1; AFNElJ8PMlKZpFXIq9SJtLZXjgQ/wmGZsaYMPWgMXarxTp1Au2zox6aCzucJNnGWeRQTvj48UGVep24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Hwxk211JRsIHt2kgOjQBL4C1wErTatG+gQ5HHDzp4uG9HtYV
	u5XoQ6L/u8Xo0z38dFVSUmPZO1m4/GIiXc7Lz9ACuD9u4UNmLHaMKmo=
X-Gm-Gg: Acq92OEXi4GlfKNHzYHAMvcIQGacAIqwlj4Zp6fOzIYLPHxk6V/ed73XDHxGzUILuaD
	iBvJTur0iG1U5xfUtyRagIvXlH3WdAJZTdgcY+OVAUrvg5aoh/Ku3KAPKqDY60qTRVNMWb4ELBk
	pWsUOGLoZ7lzGxsoN/+8e7xQJVpy4OA4qNPnM+xBx5xa4I9CnPnRNpwdeozo0BO69bRBJaH43fw
	OnZag/PqiPZUHH1gmynLIsVZxRPUVsOFPQGLls1xoisP50ISWX65eUworqA0jR6F7iLiEXwyIl+
	BX3bXTunmrGM90MN2LPRJMYysf5+HjHD7pBtXDjH+xeh8Weq3zURf/Zrtnz/BL1CMbYUSZcItHa
	wmYVldRceRocPR6l+93JRDeNofzev9tkGB5j3kE+ZtZ4+AP6Yh7VcpAGYEqQ4HpT/H31XDr/sY1
	HSdpHvR2tSYIi17OKZ/0J48jwCRde+vXyHJT8rT4GCZIiTf8RiAnSh6pdNXOwNeGDVIenwPQxpy
	doKvqGJhvqaOf7d3Nl1WjqSuAC2pP6jZLrQ99Y=
X-Received: by 2002:a05:6a00:4615:b0:83d:c0dd:62ef with SMTP id d2e1a72fcca58-83f042d4afdmr2101496b3a.45.1778655779889;
        Wed, 13 May 2026 00:02:59 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdfb0sm24906420b3a.45.2026.05.13.00.02.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 00:02:59 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] media: radio-si476x: Unregister v4l2_device on probe failure
Date: Wed, 13 May 2026 16:02:37 +0900
Message-ID: <20260513070254.29870-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 39FFD52E607
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246765-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bagmyeonghun-ui-MacBookPro.local:mid]
X-Rspamd-Action: no action

From: Myeonghun Pak <mhun512@gmail.com>

si476x_radio_probe() registers radio->v4l2dev before allocating the V4L2
controls and before registering the video device. If any of those later
steps fails, probe returns through the exit label after freeing only the
control handler.

A failed probe does not call si476x_radio_remove(), so the
v4l2_device_unregister() there is not reached. This leaves the parent
device reference taken by v4l2_device_register() behind on the error path.

Unregister the V4L2 device in the probe error path after freeing the
controls.

Fixes: b879a9c2a755 ("[media] v4l2: Add a V4L2 driver for SI476X MFD")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/radio/radio-si476x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/radio/radio-si476x.c b/drivers/media/radio/radio-si476x.c
index 9980346cb5..bfe89782dc 100644
--- a/drivers/media/radio/radio-si476x.c
+++ b/drivers/media/radio/radio-si476x.c
@@ -1493,6 +1493,7 @@ static int si476x_radio_probe(struct platform_device *pdev)
 	return 0;
 exit:
 	v4l2_ctrl_handler_free(radio->videodev.ctrl_handler);
+	v4l2_device_unregister(&radio->v4l2dev);
 	return rval;
 }
 
-- 
2.39.5


