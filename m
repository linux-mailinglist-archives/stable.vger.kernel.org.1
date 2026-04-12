Return-Path: <stable+bounces-235811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLbFEYqP22mZDQkAu9opvQ
	(envelope-from <stable+bounces-235811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:26:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 476943E3C7B
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48A213002B7B
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D737BE70;
	Sun, 12 Apr 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJFAeGyX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B43115B8
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775996805; cv=none; b=Fm4fzlVCW9i6S9qja1Iyxcg5dqfkJJjYPyeZIKxPA9boI3CUQcOTNeSvIfAlNIbi1QMty0TisiJht6/whYeXyWz5sJYRQql6XMQQsjJ48JRgE3rocgbWIeOtBRJ7OM8o+WqDkyctcuv2q+iZRDTYaIL60C8cZMgDOa5vFzLYIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775996805; c=relaxed/simple;
	bh=5PH6HgTFfPOB4nkrcwcyggoXwvHL/fdGKGMj2V4rxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMik8aXLuKfhJ1PZzcTZT5TCAcDwSQQzDKuIIQFI0O9xwm4vGIZxYw0n8gElPzwNwZyztWWkVExTaZ+gPpeZy1okKT48Y89Pv9IK2OIpwONrL+431hu2RWrUNMm+25vD1LTTPmGBgrTQYXPOKZ2jaXolhoAe2hhnahZkcAW9PcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJFAeGyX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c648bc907ebso2496950a12.3
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775996803; x=1776601603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LE6huvR6spyj6pXFbXVnPFFoN9AhuKNeTxygPGeaug=;
        b=EJFAeGyXF0Ln65yiUZakpPVMHgMpUdVJLp/ZKH22pjF79EBqMGgh6roZLzq242V24B
         YqolMT0w3BBe4fhAh5+O4bF1Cq72JG5DmCnsUuTXAfHxaJdjx3KOWaGqkXWcSkzMXTdy
         mUdw1OMWBGMCJ3f8vnAk9smtl9EzIk03XhwEy0qwSkzFaNygQhfj1uV71gGUk1SuwIig
         C+DHZWJk92Rl4nT+HWV0kOHwp4i7iD1W0YSoLcJogdpEHprxOnywGXzOCJseIe9wppUW
         Q1MToGvUUD/TpVbvpYS6Id15ix7LwuuCFnYNzep64XmKGbYfq4PzZmp4mTnxjBXG3ChJ
         m+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775996803; x=1776601603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LE6huvR6spyj6pXFbXVnPFFoN9AhuKNeTxygPGeaug=;
        b=Ci6p4a5mGTt2zHCpUr/ybhpa3Vi5ECxBM7yl3dfm9RvpMPTMBJXWK2a0hYXJmigHDE
         3aRFQ4/xseltGqXP8EnDHiLGSCPE/qbyUY3zwgqTlrRdBQFO3GLlTgDPYVVc2cDx4HHk
         WHKOEAI2p/Ok4GmYAgVrwhqnslB32IT1yX7V7yo9l1MYByHJ/k1Rt8DRB5bXbBI1tofJ
         nSJucEsv7saKw2FXFwRY8fui+5/SFEuc/pcz71ZuQrG6Pq161IPB7gMCD6fCKUq25cUz
         EzHJ2Wd9/JaAsVzZc96efy3U45S0zbIHh9O/F1PHC9wS1M/B/RYJpYkKjsJ6fSC3clS6
         KgcA==
X-Forwarded-Encrypted: i=1; AJvYcCUoJVE2TpDIT02Np6I+SVyBWgQJQnRsbQDPQ3hlmDBZ1prnQxGo7imaN/bfDqE1Td7aePS9ygU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KiKmKmGxLJnZYTeKWD6pD0BlGMN/YFd6oP257FpViJQ+Ewx6
	LJ5Bs8eTgq8d3aJq3GtvYCFPt2P3I3oESeJSjcJs6cas8gkQA6TTvEl6
X-Gm-Gg: AeBDievRBw4voY6Kml/c2jFjp6QY45l1P9GpG5u/s8XmfX5A6WYuWzoxm42hRKHkMSV
	5bZKxlAlaSi779lhaxBWD7Gt8KBs6YfXkSmSgSuyPDgHpu17y7HvscL+vzbqHbtgWEKe4WMfoYI
	4Z0twzukQ+iWJRFvuPiTW3cs0LJWK3iiY6rQr0l3PVd4U39immygo2eamW82CrJtNY35XCw+u2P
	vRjfB26ko4fzkZbhse+vsoHot09b7z45a90UVn6uH1G+pu9h8JJN9pICrxSms2bv7kPPUZhWhlG
	2RRGGQsvwWwQKMK8+Mv3OI57Hil/xImDS+eefEVqM+sUPTgoBOeggs8Z17yrcQZNdgy6YuU5guo
	+wPDbmNUViPB/2VSIaBtOfRv92klXs4iLpFDlWsfjC49RBniIv2UsgnCAdaih/qiSpVoVG4MVIK
	6UlrRO9A1EGM9oHw==
X-Received: by 2002:a05:6a20:1592:b0:39b:e789:7d20 with SMTP id adf61e73a8af0-39fe3ff14c3mr10951914637.44.1775996803341;
        Sun, 12 Apr 2026 05:26:43 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79218fc462sm7633431a12.8.2026.04.12.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 05:26:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sean Paul <seanpaul@chromium.org>,
	Mark Zhang <markz@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] gpu: host1x: Fix device reference leak in host1x_device_parse_dt() error path
Date: Sun, 12 Apr 2026 20:26:33 +0800
Message-ID: <20260412122633.2487800-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,ffwll.ch,chromium.org,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235811-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 476943E3C7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), if host1x_device_parse_dt() fails, the current
error path frees the object directly with kfree(device). That bypasses
the normal device lifetime handling and leaks the reference held on the
embedded struct device.

Fix this by using put_device() in the host1x_device_parse_dt() failure
path.

Fixes: f4c5cf88fbd50 ("gpu: host1x: Provide a proper struct bus_type")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - add Cc: stable@vger.kernel.org

 drivers/gpu/host1x/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 723a80895cd4..f97567e6ae87 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -452,7 +452,7 @@ static int host1x_device_add(struct host1x *host1x,
 
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
-		kfree(device);
+		put_device(&device->dev);
 		return err;
 	}
 
-- 
2.43.0


