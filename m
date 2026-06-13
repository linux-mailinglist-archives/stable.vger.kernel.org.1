Return-Path: <stable+bounces-262993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l5ZTBrQVLWoBbQQAu9opvQ
	(envelope-from <stable+bounces-262993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 10:32:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B867E23B
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 10:32:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Eq/2BVYI";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262993-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262993-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94CC6302D081
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF2C37206D;
	Sat, 13 Jun 2026 08:32:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F720CCDC
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 08:32:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339563; cv=none; b=i7FG0wbWy0IpA0uUozdPis+PtX+xZdHeB3AuvukLN9BZ8+CJshYVXK7lE9tbnWi+nkYwDUPnKbeRWcpkBWIsxHSpg1XGS2oYL6JPORi4cTav4ep88u6InxPNqHeKVs8N2gHNbsJ8veYqFqNTt8qNCY6IPMP3BoC8z+4F+D7A7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339563; c=relaxed/simple;
	bh=uPKIkZlhYoBQCHSj4lKsMmL61hDT6UcJ+fB+zDBMb6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DREYo4wV2lc2oE4Z4XYFrcJiZieja5nGAwUJC35hVq5OpqjY6lYoy1bbwt/dCTaId0mKbfGa1P4+eJriKKWQwkB3kNi+Kphaugwp5+HbUov7fnswTBjZJiLEpfpxQ2zarFKNgQ9ofjD/bG4SWWoXJpDjM9pAArcjlCzX6AogT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq/2BVYI; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf1f074a12so18261745ad.0
        for <stable@vger.kernel.org>; Sat, 13 Jun 2026 01:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781339562; x=1781944362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yo0ZagI1wjHBIRxCvM8uk+CoeAPsq0DsPwmR+5mIpTo=;
        b=Eq/2BVYICw9UENPsbFrUiiui6PaazfbJDOpvQ16SsYgYvsKeHPJfmkONaMgwBSla9b
         gAfIKEUmEu+I5Fd+zPnj2KnBKZKUN1iYNKBwJfKXoI6/ENk0SVvCVJHh2hn27WGyTJPH
         f5RDOYvU1M5LQNdC0gZPtJvBB7tmbZ7ZANW1A6qCd5Y5lnGbj5DBJKma2+5UDuzz37fU
         3JDfEwwGwMZ0tnE6Lrf467OJKx5fD3wiciGP3sN53r9Nx4U9n4uK4nz8ljBTPfZ+ILFj
         rMN2LQ1TXldHGnEyPNCutKScyvNjxJwCCZOZCCfZkRrkXZCm09ggnURC+ul+B0WveK8G
         d5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781339562; x=1781944362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo0ZagI1wjHBIRxCvM8uk+CoeAPsq0DsPwmR+5mIpTo=;
        b=orPg4svToRM+InNzLNs4zLmyrd5z3mnoTFuWGX6JiNKKOhQbit02IDL55PmZiVT0Ns
         WLDuzmTYBD9XH38xBwjBK9fJYyb662NW/9jJnl3zLyPz08JGMMbZ7e6kAeW/z6mKteZ8
         0OJJYJgQt6IghdotcQzSJpW4tvBMNW4J0gXa9SzuKi90vPduypOd2/y3MYychLHS/yqy
         wX5Tg6NOQFo53eIRS13+17QhcJ0WVU938iOyhqKnctQYr8o1uMiGeXL4VL9WrJvJQkC0
         z7GB7i0SeZCH0HUSKGgyz/5RgPJIBYPYnG7p1LMjexBNsW/8je5QdgmjyxpT47bXyY+R
         jypw==
X-Forwarded-Encrypted: i=1; AFNElJ/fNnM3vfJlxRC0qRj/rUCBKDyvdgR3uOjy2wf5Qa7cpjTqJWJB4uyb1TxT7bTsAymuxrajnYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Db3EJRLx+7UV7A9XjG5zxOBUHMD6gbitXK8DOZ3k6acn86Hr
	IEJb7mB6CudReAZ89Tvn1D9A9gTAE9psFD04864gqbHvQafOcnrx5eyH
X-Gm-Gg: Acq92OGSyP/otul5XGWije0WWhipZAjpAwHijwv1n3yaZKm/LDjirVRliqGMg82xphN
	IWsQkrf9DLwCyS8gNv9XdflVZLTH3nubYcxQHf+OHVDTf4q32n+dx8yTx8o7YBGr4WW9JI1+o3F
	RB/01do0Fcp4RbtH7zZNE5XncPK9p8Cff0FcG0wNf6G3Y7RqJgBt1dGjf4kFxOmwxh3z4dktSjo
	TJJ+lOkrdJ6J7I6ZSxXuH65zfxiieb3eGiUEGbps99MUeE05EeWE2NBgERJQFhtkAdZYNlBskDx
	CbgyRcP/yEn9CghQuRZ7XSeXgN8hsMmxuOjyH8jEvYUm2Psh1Crx/a1/IfUMib64y56WQVVEeeh
	UblSIDjCTSdW312UnlTIISqqnbUWTeG2JbuXtwyw6uvBwW6kIEp57r/ks8p2T1s/flTOlis+Wod
	ao7+A9l3yFnbXzSCxCvj/Lh+IR7pizAbv+Vu5xT8I9Ts7dKTKFCHKN
X-Received: by 2002:a17:902:e74e:b0:2c2:33a4:aa8f with SMTP id d9443c01a7336-2c410fbb865mr77312415ad.13.1781339561710;
        Sat, 13 Jun 2026 01:32:41 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb4424sm42665865ad.31.2026.06.13.01.32.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Jun 2026 01:32:41 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	dongchun.zhu@mediatek.com,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: ov02a10: fix endpoint parsing use-after-free and error leak
Date: Sat, 13 Jun 2026 14:02:35 +0530
Message-ID: <20260613083235.57363-1-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262993-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-media@vger.kernel.org,m:sakari.ailus@linux.intel.com,m:mchehab@kernel.org,m:dongchun.zhu@mediatek.com,m:linux-kernel@vger.kernel.org,m:birenpandya@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[birenpandya@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[birenpandya@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A34B867E23B

The ov02a10_check_hwcfg() function calls fwnode_handle_put(ep)
immediately after allocating and parsing the endpoint. However, it
subsequently calls fwnode_property_read_u32() using the same 'ep'
handle, leading to a potential use-after-free.

Additionally, reading the optional 'ovti,mipi-clock-voltage' property
used to overwrite the 'ret' variable. If the property was missing,
'ret' would become negative, and this failure code would be incorrectly
returned at the end of the function, causing probe to fail entirely.

Fix the use-after-free by moving fwnode_handle_put(ep) to the end of
the endpoint property reading block, and adding it to the error path of
v4l2_fwnode_endpoint_alloc_parse().

Fix the error leak by avoiding assigning the result of
fwnode_property_read_u32() to 'ret'.

Fixes: cf10e09b9a4b ("media: i2c: Add OV02A10 image sensor driver")
Cc: stable@vger.kernel.org

Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/media/i2c/ov02a10.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov02a10.c b/drivers/media/i2c/ov02a10.c
index 143dcfe..53ff86b 100644
--- a/drivers/media/i2c/ov02a10.c
+++ b/drivers/media/i2c/ov02a10.c
@@ -821,9 +821,10 @@ static int ov02a10_check_hwcfg(struct device *dev, struct ov02a10 *ov02a10)
 		return -ENXIO;
 
 	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
-	fwnode_handle_put(ep);
-	if (ret)
+	if (ret) {
+		fwnode_handle_put(ep);
 		return ret;
+	}
 
 	/* Optional indication of MIPI clock voltage unit */
 	ret = fwnode_property_read_u32(ep, "ovti,mipi-clock-voltage",
@@ -832,6 +833,8 @@ static int ov02a10_check_hwcfg(struct device *dev, struct ov02a10 *ov02a10)
 	if (!ret)
 		ov02a10->mipi_clock_voltage = clk_volt;
 
+	fwnode_handle_put(ep);
+
 	for (i = 0; i < ARRAY_SIZE(link_freq_menu_items); i++) {
 		for (j = 0; j < bus_cfg.nr_of_link_frequencies; j++) {
 			if (link_freq_menu_items[i] ==
-- 
2.50.1 (Apple Git-155)


