Return-Path: <stable+bounces-242975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK2HFKRw+GmxuwIAu9opvQ
	(envelope-from <stable+bounces-242975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:10:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E874BB782
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2698630293C0
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6B391E7A;
	Mon,  4 May 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5XTJ02V"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34943921DB
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889312; cv=none; b=UOD42l6ydMZxPeFEZZs2qPMF0gUH52q5fkgxboqRnWPdZf2LUjXB+4Ffk45RajJwFdn/o3o4clmRF52kmVmm3cE3ZlSRVA6cWhi+qfWRWZ+0+qmT+XU8DXTI9P8T7zkXvcpxopXOqg7/wSN0lnjObY4R4+9pTqtEHtDnM0Kr6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889312; c=relaxed/simple;
	bh=ecvD7cXCIG9VrEOOchfKBfniIVf6VtECCyv5SmPD1kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQnFO6FK7MvlaSKVfI9m6Zwm+Fmwo0ENAFMBUEfQ6H2n+VuztcpQI6YH0q17khH0g91XbHb5NwATR7mAmrDay8t3pdwm7/kerpUyPCzgMe2ZdSJzSYx6sZ+eFDsBaBdnU5HSCWOZrZnxfGbOxkphStRKxL4VYgK0qbylvRTuEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5XTJ02V; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393800586aeso14207221fa.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889307; x=1778494107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmNwLKC44+y7Cqt7OcmRZ9UY7ReRqF1/k1kRQnz8QNY=;
        b=K5XTJ02ViEmFguCze1Cda9P3bI3E4aVgFZ4Wa85PNa6W6EqJij1bi3Ox3aL/jt8mqM
         OXC4yYme+rvZ5IO7EQKq0aHVsAaI9a29JhLGgJpxkLGDVIcG+yB0S4n41Rd7qVB0Ol1M
         AN2CbbW0vas53ZoI20uixunp63owACDg0Bn5JhLQhvPg8zBnz8Pd1yNGOGsxR1nUQKX1
         OOHQ2Fw5rof2INwHIze5DijVtNWttWRKNS0F6Yr68lAPewy+763J9lmcGWlv0SqkUxBB
         FK+LwCzchFnloyKIGX5aDlxrsPGN+BSZ8VKMEVhgJFOsw2OE5sI3xMu4xXc8yuJ2k2KD
         Pthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889307; x=1778494107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmNwLKC44+y7Cqt7OcmRZ9UY7ReRqF1/k1kRQnz8QNY=;
        b=MlMd067vRf1Iob20lLAgA69DlgWR2gm6Lp+84Sees1wLobNhMzQecNa/W1F72G41y3
         /FnjTPkyhndZCwyokhJa442z5sLC8SZvynVzWbOl+eEE7Kp9IsZGbmtrtZAe02Qv3sbU
         0sDqDAIM3xVnlFWnuUflzMI9WB8pdUIFuzi56R9VIpfMu+OHnVw355LoY2FD8pRduVZ8
         FfhLioed55a4OiU1Bj8hMxx3Npt2FxaxiMCiYGhQwUGiMoi3owlxeGvJDaSc7QbpelTp
         od9efnx1ubtzrSKf4NgfbMkFzz82OH8cyK3A/JCxPyUaIRhqoSOQFRj01A33bpHB6pHi
         Ns7Q==
X-Gm-Message-State: AOJu0Yy/7ccEJyI/IXPtg1Sk+FpXOM6XffULs8+7NRIPgVPFgI3+bTuk
	0uJbjdkFJKyPo4Zl9gkydwjZe5oKqnv8LhvBh0/UJF3ioCO0dZZ3BdR3
X-Gm-Gg: AeBDietSSr4feDQs30ZW+rR4u6+ItVK//Cj3FnJ1GkUqT0/GAHr6K5UKn/2nQO4l13v
	1FbMnMLmVPGdheRMpDPnZFiowefHhvpFtGhgSRBZieMrXiVZ8xB3XB8CBnSP6h/TRLiAFgTHRx5
	1hZIEFslo6HG1TRESSzPnq9unINJoBXZmoejTA8RJ9hVqcqyp+qY/ZAv4y/xtXq8uBjvx2UEfyD
	90XQXa27ZenNTEw9WS/GWUVsL+NYm/hnAiETmoJFU/7TAJJZIeNzgY/k4YfkXoLGvg4y+kTinlN
	VYV9PWS5Av4g5snLagFq+GJ7gXLP2kOyfRcuNcVwnmXVCE4TbwE1CgzzXY6lpfGlhSh1gvK/8Uu
	sXkYATwAw58fIYcKnxqxB8GY5Bhc3XcJugjk8vFRT08Um+pz5GbjC25aIHywLksCelzRg686YMB
	RVZ7hqbCYqH2WPcyuAkZUxoxNB4X7eQNLJN/ADIis+bgwFGqJylPKf6by5wVoNriVFfsfwhBo=
X-Received: by 2002:a05:6512:1328:b0:5a7:4696:dc24 with SMTP id 2adb3069b0e04-5a85271c81cmr5783165e87.2.1777889306760;
        Mon, 04 May 2026 03:08:26 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c33c2ecsm2856217e87.42.2026.05.04.03.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:26 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: vebohr@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 3/5] mtd: maps: physmap: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:18 +0300
Message-ID: <6717e0b2a6244ee4e691dba03eb8c790c202e89e.1777889235.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4E874BB782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-242975-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When platform_device_register() fails in physmap_init(), the embedded
struct device has already been initialized by device_initialize() inside
platform_device_register(). The error path unregisters the driver but
returns without dropping the device reference:

  physmap_init()
    -> platform_device_register(&physmap_flash)
       -> device_initialize(&physmap_flash.dev)   /* kref = 1 */
       -> platform_device_add(&physmap_flash)     /* fails */
    <- platform_driver_unregister() called, but kref still 1

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() before unregistering the driver.

Fixes: 73566edf9b91 ("[MTD] Convert physmap to platform driver")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/mtd/maps/physmap-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index dcda7685fc99..45d79ca622c1 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -654,8 +654,10 @@ static int __init physmap_init(void)
 #ifdef CONFIG_MTD_PHYSMAP_COMPAT
 	if (err == 0) {
 		err = platform_device_register(&physmap_flash);
-		if (err)
+		if (err) {
+			platform_device_put(&physmap_flash);
 			platform_driver_unregister(&physmap_flash_driver);
+		}
 	}
 #endif
 
-- 
2.51.0


