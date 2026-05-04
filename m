Return-Path: <stable+bounces-242980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GP0KMhw+GkYuwIAu9opvQ
	(envelope-from <stable+bounces-242980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:11:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FA54BB7B7
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 449EB302C6E8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9F3921D6;
	Mon,  4 May 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWni/hly"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC0391E52
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889341; cv=none; b=qv3PaW0ylToFMCGyq+eTzNxU7wK5vZ97mKKaFrY4dd3XtVT5atgPZcK56SpAqzv8rKGPhe+W0rhtkV+d9E7dbgxRwQ68Q/K5YhQ1LLtzOPnZ2yD369tDLWQooDgkIubj91tzinNCE9l0a2zooCdJCazEboA3KwWz6yfB1fFc79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889341; c=relaxed/simple;
	bh=ecvD7cXCIG9VrEOOchfKBfniIVf6VtECCyv5SmPD1kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQB6W+6oWAoYusRJcbmho2wNIDkGwSoHTwyHXKy1mDaJmOupFPCR1emJ9/gPXhd6SLQ/mSPGvTKbXVjCZxm0sBLxUDcRPbj03Gv2MNRMtCh9g67R1EWZIr22air7/6eDXSAeuKQWpn6EHhjH4jBzNi1VBHto+X0Bh2qvYocpYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWni/hly; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a865004748so1927994e87.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889334; x=1778494134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmNwLKC44+y7Cqt7OcmRZ9UY7ReRqF1/k1kRQnz8QNY=;
        b=aWni/hlyQIP+QilTm5Xe1LiBFc7ExKzkwyvFprVTmEXAQYpoYD38Zrfi5q+nwrBMkJ
         LQlsDCK340GvJWNeN+HtIEo3D0mI404aYQMjAh+Qse2+F2TJ9mIdnoqIueu4qXPvrY5h
         18YIqDhfiCyjNn3Fq2jnu3tnDvFS4wKevMFIudj5owUxkNT12h1SI3BqI1Zb1gY+vYNf
         EE0hiEKADwCqS3AHgki8mVDUhbGB85GzEaFbkhoSYNLlJzdngnSwIoBINyEStUw0AUIy
         5GFB8jN2IWqPeNrczs4+zi61qB67J8fOW63BEB5xXHO21Wn6QjZRWQ1i11aGZZ6+5owV
         2UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889334; x=1778494134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmNwLKC44+y7Cqt7OcmRZ9UY7ReRqF1/k1kRQnz8QNY=;
        b=EFqGTL3CYpUyiKgpbKU5erFp3BLURySQzmF6wF+4XfN2NtmhG73nK3TnYyL8Yz26Be
         7Q96YYMtxwGo11wgz+38IDAgkmwaZP8kbfUxtYF9KhkS40sM4nv+NaaB4YbyQfwNqxa9
         FrcaMNt8mdoPRZ+c5mOwLMKOBi0TeCz9+azZn0Fg8OYEyjgdJniwgRWfeKgQczfPVlV1
         JGrfher8fQyiOuUpt6I6odovVwLlcYTYpN0zcxDYxBB3eti/GkSneIejTfArensh1hxt
         V0lDZxpmQGh5XdxQsVjv61xIyr7MdzMP7fi90PTtHKAG5TW8KquerUcy7/5RrD2S8inn
         GRhg==
X-Forwarded-Encrypted: i=1; AFNElJ9oFNOgxADytAQOKEjDL0NPdousPIKnlRnZnNJtuL+WzZrv+ZnfCDinBLbSDiL/Kc3fFIpefNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75KnOfdiinr5wMUuTq36sKybVkYh0G0fRWddu2+86o8EPYk+o
	yWOx7a1sXH9qKDYU+OFc3ObkcwFVSuDUjcJ11wh1zI8eorK1vaKLWu7q
X-Gm-Gg: AeBDies0gNlvTvui+PWwgzBvjQszJFXllET37oBSfTNwCkNYRrHuAqX9+LVywrydcS7
	arENuCmWUV0+bptYqpQWmScwxvvkExJF5ki3HgEcMcqMETFnkOTDmP2R3ol4uApiFQEMKVtj69N
	e9oj7E2M2BbbcSEAuaBLnh4JUhAdZgokF+7w5lbQYe6eg1NX2P4AosPkNdszoTwbGxhM+jPVB63
	+WBoSJMkjjXy8IYMI8CjKObUv1Ni0VwsHUvFSwKxSCxO7CXrEJ1ntBaATRjkS9ca/shOu8zOtQv
	h40MmNdWEbJXur8c5KcyPgLaJ6jy7x3OcEeIWeZoxKe+ojpSMroGi/4E05LvAxg7yBPiNd5UKJh
	q/HPMycLKwUjiU2SsohGA+Nk2PhGwN/jniDb7DX4GLhkGfh1LNHDQkt+pQNJ5XSrF8b5Gvvileh
	H/UKinnBD4sy3RneUAIh0s4XcIQ0/Efm6L3ybAqaQTX5Uw8GsubRRRYPXctGMAvIYUc5AJBCs=
X-Received: by 2002:a05:6512:2208:b0:5a2:c962:59f1 with SMTP id 2adb3069b0e04-5a86215f89emr2358405e87.16.1777889334019;
        Mon, 04 May 2026 03:08:54 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86645ae7csm1979099e87.79.2026.05.04.03.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:53 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vastargazing <vebohr@gmail.com>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 3/5] mtd: maps: physmap: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:45 +0300
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
X-Rspamd-Queue-Id: 02FA54BB7B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bootlin.com,nod.at,ti.com,infradead.org,wantstofly.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-242980-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


