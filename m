Return-Path: <stable+bounces-235812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLhiHWCT22lVDgkAu9opvQ
	(envelope-from <stable+bounces-235812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:43:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA7E3E3D26
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A705530103A2
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D8E277007;
	Sun, 12 Apr 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKUdFXdD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D452737FC
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775997783; cv=none; b=FpxuTsCKWZuUe0IzrX5CNxtwTUhw+Wky5DADW9MHM6tmt3QAeU22NLIx24QcihkAHMXvpyaYcmz8ln2uxI67mp32lP40p8ue0Vd+HUYpCP2KajfT+gqOjw+S6TEP5TpOdNj/ymPcvrY6RKLdV/22ZCnpRKvqYGogRRmN66vFzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775997783; c=relaxed/simple;
	bh=j/V6kvnhuhlsoN7ZuzaHKSXaC7u5794AySSBjPax8WU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPtLAG2acCrk9AyVHhFn3q/v0GqXEB16inguvraOZqaT0vg5sM4ZhGlucP9+HQz8m4KoLF0jI/yu0azqIEOorMyFkdh48HOhdmli6+2980C+8F1hgA29DZRdoHnpSRPqe0NUZfQ6+ScvPt9/ourZco9lASHNTt6itzqF2/c6tCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKUdFXdD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2ea1b3962so3092345ad.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775997782; x=1776602582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7QWVaN0FaywpyGDYy623KiFtyqheURnD6LA050XwQY=;
        b=pKUdFXdDd9q4VYszMsiDUGcF60PQh6qKswjLPkSMlAdwpTumb7hBDM9nM1xAOWlpNg
         JHdZbEYtoP3RXLuqOa//BpETu6XROLM4eq7gRgx6bqTidkCfj2cG2m8SSFAevw4/OsJm
         A9nmPFkleI+inT0oeVFyGPMFmKiSleyaD0BKwHkEZd8SXJ27jdFabHBztzrDVArRE7Dj
         KDQd1aHfERhHU5Sic5cdQC/pGmhOrZvDIOu99PEwj5iJ9jIEjhilG7Q6mCOQbp164rT4
         N5xzCdUGiwMDly+W+ZmUKujm57pdVcq28M9htwxnIqKf6xNCf/9EMbZVjyr2RMSC2Vbi
         GweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775997782; x=1776602582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7QWVaN0FaywpyGDYy623KiFtyqheURnD6LA050XwQY=;
        b=WA+0ky6lhfktBwOfjOXeA7EEABe4op1AdyO9m3HRcInvydM543zUsBKXhXIRJmzUt8
         c7AxCf2x/YioyatEpNfiD741CdNC6fYvVk1XVZfMB5C0XrwZ/6hzai2jYHBTQMDAvgzx
         /RPvCmtpeQ+Mfp7AJ+wNtcjcjxDhmFRqnISsXlaNgccVFjiJouhlNNmTeHaIRmcqgSad
         eQ2LfuOq9SKw13PwKz40/W0MOJnkBMRpUByHzCaP974cS0nYV9v7YgWUL6J+2divwBOt
         J6u2tfaiLpz6T/qBlbIOwibrfdTkD/DyFnAnM654T3d4YtYL5n//zpaEZfLj8XmId8p3
         9p3g==
X-Forwarded-Encrypted: i=1; AFNElJ+oN3B2AVY6AaIiwjMVfUJbOmIibC93myf1umHy84c2aphsYG1fuqQJeoe1l6Soxxjj34eAssg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKvaPeyUyiTspInOHnqNxhySfPRMmXV+otII6KuM2syd1wZghT
	QwUn3SlCBkQwqMzN1SGWxc0/rWQV+Oopef0QYXmTxpt9j1Lbt8yhrCqS
X-Gm-Gg: AeBDiesiQKzT/SAbqDhOi4UG0ks/17HfutFrTJuogXcJVbbLNXdxpDn92Y1YIBBcwTN
	Pkof3cgPy6qN8+topxyP0ZgLH55z8SrR981LtexPEF7S1PeudlvipwYVRei69cL+sGRCK/oSBEs
	Nne7IRxpJY1ouLi1pNz9Nf1l2ttaODipqS24HQYH4oJnI2RPJzTzdLPn68onIaZ2TY6JXj2tjxX
	9rLzHEKqIm0gN2ajef5hCZUHEo5jKKrdw7kI5k68e60W1dExmjFOTF7R6pMp3ij7xKa9VcC8hCI
	ghm2jUSvDHWTE5D71uuatKRvCLwQAsc5/u8xsfNilI5IdGt4EFPzrvWjFPAj92Z8tAbIhzir2Ye
	AMtR8VZY0dCwlM3wAxyC9zVqQkyO8PqcrUv+xI0okLqzfS7Dfgc60t+Lpb0FG4xrdD38cyOMd6y
	G9U35yYBZT0OQ4ug==
X-Received: by 2002:a17:903:40c6:b0:2b4:5ddf:24f with SMTP id d9443c01a7336-2b45ddf0454mr4606985ad.10.1775997781786;
        Sun, 12 Apr 2026 05:43:01 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45cbf0f87sm7731895ad.6.2026.04.12.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 05:43:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-mips@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] clk: eyeq: fix memory leak in eqc_auxdev_create() error path
Date: Sun, 12 Apr 2026 20:42:46 +0800
Message-ID: <20260412124247.2494971-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235812-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEA7E3E3D26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

eqc_auxdev_create() allocates an auxiliary_device with kzalloc() before
calling auxiliary_device_init().

When auxiliary_device_init() returns an error, the function exits
without freeing adev. Since the release callback is only expected to
handle cleanup after successful initialization, adev should be freed
explicitly in this path.

Add the missing kfree(adev) before returning from the
auxiliary_device_init() error path.

Fixes: 25d904946a0b ("clk: eyeq: add driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/clk/clk-eyeq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
index ea1c3d78e7cd..a48ecec4c9a5 100644
--- a/drivers/clk/clk-eyeq.c
+++ b/drivers/clk/clk-eyeq.c
@@ -346,8 +346,10 @@ static int eqc_auxdev_create(struct device *dev, void __iomem *base,
 	adev->id = id;
 
 	ret = auxiliary_device_init(adev);
-	if (ret)
+	if (ret) {
+		kfree(adev);
 		return ret;
+	}
 
 	ret = auxiliary_device_add(adev);
 	if (ret)
-- 
2.43.0


