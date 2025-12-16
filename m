Return-Path: <stable+bounces-202730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6F0CC4EF7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 19:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D05A302B33D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8533CE87;
	Tue, 16 Dec 2025 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="TAHKPXVm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73433C53F
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910501; cv=none; b=BQoXpxWVwSJoCCYCjb4iCbsuYKiW+3FwaY8DZ1p4+xzNvRMxPpq+XtyflXYkHWgjEzFgHRtxe2fMWiPWN9pnV28V1YaVYyvxoFKy+vDp5kd4TyldUaPhKndq0jO7k1ieVDKAvAfLxf537twim/bv0SkTNnmxTRp6nUj8PvegdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910501; c=relaxed/simple;
	bh=V0yuNg0iV+B3gIISWOZEjmLZs+sFhcR3AfRXnuoFwWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtER8TZbd9Aq/moJsrftFzOGUoK0vDwR1UQOzregTjj+wyu5Z+IAAGMyzkop6/GOW5XK+4HgpA9eusaA+EQLVpaUhblV3JOEr9R3ehxrkI1Ok6EQxjtN6GqK1WwFTBLQybKyWBXbXuaf/mvtGpPQt40HOHY0ToPC/IXJjQgESbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=TAHKPXVm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so9848156a12.1
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1765910498; x=1766515298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nss51I/Jwq0hJeDmfg399hmUyY3dbLkceJU5Wfbrx+o=;
        b=TAHKPXVmX/20bHRS1U61Zt+nRkNB3o0XBLZSY6o9WKXj8tjRDsWEsVK25GTKIibzje
         ZaOTpvQ41QgyI+Cu80zADgcALfqKkqW2bdLIx32IjClxGBMMxr1dv7rSLuYYViE2im4G
         KnqlfNZxo1DJnyylZCJpk+W5rJh2gxa75w5e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765910498; x=1766515298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nss51I/Jwq0hJeDmfg399hmUyY3dbLkceJU5Wfbrx+o=;
        b=G8/q9Cq3lzjg27Ov/tqMpkgrMtK8bXj180n6alnaIQcQnuuzIDQSrDpgmP2gLqJAC2
         LaX7KAYitlYW5l7alriXvDHbKKHBrxBYZiTJm1aEHpYKMeo1C5s38KBJvqQ9/x/Gs0XW
         7gB6FNpYKlYtYPctVsG9K/bc/BbvcyICjHddSfIL3UO11pViD4MwmXkwg3wNNUZVD8Q5
         lSfqKKOVGG0Qi2xSyGZQb78MQfwLDMM+/59Xa3/+TP3R6rV8euME6yk1TBA0BSsVSyUn
         7bax070ll4vk76ROgZXWhYHGHZtIsv+oEQDAb/kgF5SayfYCJuYjqRJLZSx6nGNJFX3a
         +5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwMkW4QFCtRH/27sWXQ3la7rIxzSrx7w1C6/dipwOEKpmLkexuRbfe97/PVnG/1oeLRKEFWYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+6pcdvmbaAUOqLNHazVIdH4+d5fMNAF1yrfSAm49VQKk8/HC
	9UbmZh2mxFbRh17IiRhbFVzeA/tvIcWoMNWW+y7XqCwOBYvRWpZ+gbY7nfkRkD/e9iUNpIA2qSU
	A80f1On4=
X-Gm-Gg: AY/fxX6Z+7S5bFw+fnnLoILfqB6VnEC9RyE5RmZjJJtuNC04W/DsJ/XjGD49QXYCj1f
	VqX31M6lvucEs5PiNGtE9FjSWugroydN1hXVu4nB/SaWeOxO3DYYPXsbJN3rgAtHqaT4SWmQxCk
	1AdifjXDIIyxSqd8gcMcwPXohw6upVFIvX9IuZFj6ypjRVHPY0/zMe+FH0zlruKRj3VsEJK8c6G
	JrV8ZPoIFtz1iEMEHwdQYhu0BJoMiAdITQrvNA9DFE5lSlSgFnxgoBF9YCURnzqHjCxN8xKsVqv
	oT+ycwpb8KciInqwZmKeTix/N4ufxuVrri9WtgQ9Lt/IO+4ykIlLPKberaKPPguj3zIV+x64YUS
	lSbdUoiSslLAEXCbY8jvhtD0TcJd/MEJ4Y+eU1Veh+nxbHuilwb61KxZGV9N42DO2e23/xbIKAA
	5Z6Ga1lkkr24JTfwqPiFFm164UavlevfM4sODv1y8=
X-Google-Smtp-Source: AGHT+IFrlQiy9aIQ+9DdbQkq4o0jdSo4LXZz5Sddp7jQq9o+qaF7ZY8ITl0iy06lK91XkcBPG9K4rQ==
X-Received: by 2002:a17:907:3e02:b0:b7c:e320:522c with SMTP id a640c23a62f3a-b7d23b1c40amr1761406966b.53.1765910497792;
        Tue, 16 Dec 2025 10:41:37 -0800 (PST)
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa56c152sm1709454366b.56.2025.12.16.10.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 10:41:37 -0800 (PST)
From: Petko Manolov <petko.manolov@konsulko.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org,
	Petko Manolov <petko.manolov@konsulko.com>
Subject: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb() failure
Date: Tue, 16 Dec 2025 20:41:12 +0200
Message-ID: <20251216184113.197439-1-petko.manolov@konsulko.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In update_eth_regs_async() neither the URB nor the request structure are being
freed if usb_submit_urb() fails.  The patch fixes this long lurking bug in the
error path.

Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
---
 drivers/net/usb/pegasus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 81ca64debc5b..7a70207e7364 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -168,6 +168,8 @@ static int update_eth_regs_async(pegasus_t *pegasus)
 			netif_device_detach(pegasus->net);
 		netif_err(pegasus, drv, pegasus->net,
 			  "%s returned %d\n", __func__, ret);
+		kfree(req);
+		usb_free_urb(async_urb);
 	}
 	return ret;
 }
-- 
2.52.0


