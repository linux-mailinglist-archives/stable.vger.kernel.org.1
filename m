Return-Path: <stable+bounces-236105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IHkOrv73GnXYgkAu9opvQ
	(envelope-from <stable+bounces-236105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:20:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A730D3ED3F1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67B6F305529E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0835DA4F;
	Mon, 13 Apr 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpE4uFcS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC133C343F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089765; cv=none; b=pYbkggY2eS9vGWUTJmqrCwg9GyXkh4tnnLXl5z8zBk5c17Sbil9vUxTLGJ6iISDVucGJUNqxzXA7kLkaGXnSpRhua1KM+HIvXJg1lMwjOxnh0XnF8sCDBlVtyOUQUJyp8ab8xb0L8ALWAhq9JcHKsDqcPl7ELJTvSU/mbdqktxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089765; c=relaxed/simple;
	bh=joQClY02gPxW9Rgcbp7cpGeoX2QQLsorYSTJB70FVCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9qjohnX3/uSxaWEsiG/PMFSz9uQI+OIaHVKQts0WZP8NNXEiZtbzSXtp5uTTuG1j/r8QZWZodIan1eQjI7h2lBbRVbnvUzSHVehwNgCVDd731Zh8Ruy+cuILcWOE23m0vwsaM/7ZQa+xOjckx5dRslpslFzLD9sxL17OXsu5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpE4uFcS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so1957548b3a.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089763; x=1776694563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e0zbRRSwXZ7Pwh3Wo3GiTsNe9+S5y60LaaG4gtv9gLI=;
        b=fpE4uFcSQ93uZqwt9purUfTlAbpVDNmiEnXLWomjMdpAtKiwmdEnPGKGIySxODYzkT
         1Z4t77ZKgTQzVXtnHRltKGDIvI+tN5bF3ZKaVbFxAhUAk1P+xJB7wQDC8vUdpf4gGufQ
         q8V/kVCO3U5VuDXh2r1Z57iGrJfNH+NvBTCRbbdOJeq9uScF8oF+q4DrqRbNLY0bBtXt
         I56XHKbj8lnJqPCTbYaYngSDu3sWW1U8IPmgdcFI299x/F9I0qSCEALcVUEHBgmHfKeX
         smJZ2xAyA19R16/wf7zkyPjJn4L/Z4ohuN863Z88SGkLY5z7JRspXc3Xjz7O9iWdQZeq
         ma7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089763; x=1776694563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0zbRRSwXZ7Pwh3Wo3GiTsNe9+S5y60LaaG4gtv9gLI=;
        b=MUOzaqxRQ7xXAGF4RN291hjPQaINk4dUxxyhUx4pmT87qA6wkFQmL5oFj3rCz3iFAI
         ZhpHJ4a2VshbBnMqPvwdn4BtpyIq0qwLsWPY5zJjwTzWGRGy+zwjWQ9uB+8ZFTvnue2J
         kjoSf7gZEdJR/lMw0odSTtjTFJmNhHfJc1edygxKIle+8w1Y0XU/bx6vmOs6VgKonQOR
         hp98QJFmuBpIl/faNr0DQefdc4jDyky7KIKISd33v7qlRYwx+ylMpTwoVmCffItwKWHx
         283cmJCWZO70X93SeAI+wJOWLXdwZSiLW+hwlkqPJNewXKy09YsCajgheygD+4Ni/UVJ
         g9nQ==
X-Forwarded-Encrypted: i=1; AFNElJ80oA6iGExZ+0jS6lT8tnV9DmaCPCTeA1n8js9bO6mg56rrkCQ1JWvg4NM1y6AIhjvVdIE8ywY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3F5C6eIbkc2qVAUVgRBpN/dwDAI7X3fyrb3QeG2FTJ8QWLUGW
	1GP/30xFUbrfVLfml1//wdEkO0ufZfsUKwoIywDKQWMqqP5LQh/KxHMB
X-Gm-Gg: AeBDietUNuVwaK0J3cXvmVWzec86uJ41mHCI+ms/5qCMVwXNFQSqBTApKSGpDe5nf9F
	9krxWCK+apKn905vsDrT2SEno5MlXjIwhSj3pAB33yxFTyKsY9h0g0iMeYhuJobrpNVnFG2MmeJ
	0V0kPKmfZm4B73zg3z8nstXB2sUHXTN3YwXSijcdjrXyVy+j37CEI/x5mj9XtVBKrB19II600LS
	XcxM8qMe75Vsd+F0/hsWnfjaT4+444F4pL3rUZTssZiKthaqqEW00l9ioqJjgXJ7J8++NssJFha
	kTRrHRJs/V0VwXeX43U3Jeef9MoavHa+enojct3ZeQiXsVHqR7A8fimP7ys5UIPduvf0HX7GS1W
	DCscn3X+70dHbm5WJgn9KrXFc2digAPLMrNUI0KelR5ljQU/QDYFZMj6QxvRsPkZjZmWIaaX1la
	n39rxGdYSSaTK2xNXME6+Ebo3nKUZ+0oE=
X-Received: by 2002:a05:6a00:170c:b0:82c:ddbb:7db3 with SMTP id d2e1a72fcca58-82f0c21d396mr13302565b3a.25.1776089762689;
        Mon, 13 Apr 2026 07:16:02 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b17fcsm11396301b3a.33.2026.04.13.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:16:02 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mark Zhang <markz@nvidia.com>,
	Sean Paul <seanpaul@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] gpu: host1x: Fix device reference leak in host1x_device_parse_dt() error path
Date: Mon, 13 Apr 2026 22:15:26 +0800
Message-ID: <20260413141526.2961841-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,ffwll.ch,chromium.org,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236105-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A730D3ED3F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), if host1x_device_parse_dt() fails, the current
error path frees the object directly with kfree(device). That bypasses
the normal device lifetime handling and leaks the reference held on the
embedded struct device.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device() in the host1x_device_parse_dt() failure
path.

Fixes: f4c5cf88fbd50 ("gpu: host1x: Provide a proper struct bus_type")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

v2:
  - add Cc: stable@vger.kernel.org

 drivers/gpu/host1x/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 63fe037c3b65..e3ac85848aec 100644
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


