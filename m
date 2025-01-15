Return-Path: <stable+bounces-108686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC25A11CE4
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F0188B50D
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E9246A2F;
	Wed, 15 Jan 2025 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5OqjPzP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4D246A26;
	Wed, 15 Jan 2025 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931979; cv=none; b=RgF/1//zmY5UBgfWRrq6EieN8lktYVFS8NKJRzfFsBtHaNpogfEa504RRnyBbSpLA1rj/p3YET3UrcPgMGD0XborPKQflGtotKDibbgbJm0sXiEG/vvPv5woQq096ARSaybAsMYeUkPQUxL/CG7t1LvB0VjB8tFo3sFB0GXas4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931979; c=relaxed/simple;
	bh=FRlG8uf6bwLvOxxHmDbtsFQfyc4Gnz3X+/8D670ah38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFhmcyxUqSk1pVP4pg+d88esmmwERh+1N/Xp1CfvAvBdHsw99VdZEoL7/KHHeoUenyzjoEgf32Apprxd5xU61mLR0U45sjMcjUvGaTkEmEyyVtEcbNcHwDvDFMHBq6mOQgQgxKDjQg18wcaoMMyKyn84VZ+rclGsppNiHoiKLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5OqjPzP; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so10689610a91.0;
        Wed, 15 Jan 2025 01:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736931977; x=1737536777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rriRZYqdDiODgYlfAScLN43iwPQc0F72KS+nFX7SUo=;
        b=l5OqjPzP8NOmMJD1unQu0FciANgSfQote+taucazRRlYCsmT8YD1okoARPqkndmAk+
         j5Ysb505bX5iWidRKpIeeLAwTujvj1LatrblkxxPPTJSjFcIAX3yobkCbvDHKb5vls26
         UTFlAPySVxbcjhQSzE6cJ4YmU4ihoHsH3DnzvmYrZ8H0uGC5xzykWYFOFuyAySS/aIEG
         kAgwZyINwTCderogx+bfLbxWof28OwumNBdY+Gha4aC/HYzYv8hVRynbrOh78suc2qnL
         ZnuWkDtbZ46VU1146tDIhCEGip+u1qL0KhuGoBDwrPj2pSPgzQ5cQdXZTdSVbavhVkwv
         +hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736931977; x=1737536777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rriRZYqdDiODgYlfAScLN43iwPQc0F72KS+nFX7SUo=;
        b=pwteZB3VOJiByiZ+TRzII5Oo6SAHQSM7qAxg9k8kgWL5cbk7FdmyDzvHLacths0AbW
         2mAtooX03rlvMDLHunXvwVrBZoBBqMrWBDwE1i1nrzOKxKR6Kfl4IHQwXqCAhGa0F0m5
         9alXIU2RBAFNDhAnwGxPs3IM8qWGKSCPL3V0SFBC1G9I94tqrs15e1UHPF67ABa8q/A7
         jnjPyWcFWoinx1xosJOy6qNqb1c8CogpRt7CHGw9Go0LmjpytgThtujmb5Tu0Hl7dMnu
         B6XGKNoQnvZGwUR+Z1J1djMGBZpcIU0mDl+Rc40wWlgJUZnVg3plMwPKniUoJ6FuPe5r
         lgfw==
X-Forwarded-Encrypted: i=1; AJvYcCU58iI5GxCSh8iSnMI9nTo4gUXCJ7h4FZCs10hoaPhL6/ENCfeBeSv9FN6CiDWEu5aREHL0bbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6uIYNAn13TL/OMYrjN0K3IOz9m3uLGjAITdAcI6/VhDTueMb
	ObCj3G7XKhOFXykWFMMlksEmnk6707qf+vAQWNiKmK/figywSIfH
X-Gm-Gg: ASbGnctdekEzzTU0ZLp2jCUxYoBZ1UQX5iPxMUBPKEynpv1QXhszVo/DPhQOZk3K9v6
	qjp77WYbwk3vEw73eNn/z4vhOUD21XqCaM9122WP3HD9U6MWv9VE0a8b4zkXZ7LUmnHdLH0iJ/8
	f1PrxR3vqCEhhZbv46hzDuR8hBcMYqow7spcOwh9W6kuftISr8NJZo0TeraPQM9mPzjA8pzBMVD
	RbfuCxoJR3cUpKIpcjWbOwJe6TL6Vzhg2E3Rwj9EhLXwZKdpbL5gvIKtc3vcx6fewdrAMG51eo=
X-Google-Smtp-Source: AGHT+IEN6gRLkULlkHIBtxArdFu2ZYdEpJux3x47mj6SjwJmy/gsdsBQWJ91azhGUMiX30KXHqp1Fg==
X-Received: by 2002:a17:90a:da8e:b0:2ee:b0b0:8e02 with SMTP id 98e67ed59e1d1-2f5490ac09cmr39822196a91.28.1736931977274;
        Wed, 15 Jan 2025 01:06:17 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c33172dsm890808a91.47.2025.01.15.01.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:06:16 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	greg@kroah.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] cdx: Fix possible UAF error in driver_override_show()
Date: Wed, 15 Jan 2025 17:04:49 +0800
Message-Id: <20250115090449.102060-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a possible UAF problem in driver_override_show() in drivers/cdx/cdx.c

This function driver_override_show() is part of DEVICE_ATTR_RW, which
includes both driver_override_show() and driver_override_store().
These functions can be executed concurrently in sysfs.

The driver_override_store() function uses driver_set_override() to
update the driver_override value, and driver_set_override() internally
locks the device (device_lock(dev)). If driver_override_show() reads
cdx_dev->driver_override without locking, it could potentially access
a freed pointer if driver_override_store() frees the string
concurrently. This could lead to printing a kernel address, which is a
security risk since DEVICE_ATTR can be read by all users.

Additionally, a similar pattern is used in drivers/amba/bus.c, as well
as many other bus drivers, where device_lock() is taken in the show
function, and it has been working without issues.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2:
Modified the title and description.
Removed the changes to cdx_bus_match().

V3:
Revised the description to reduce the confusion it caused.
---
 drivers/cdx/cdx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 07371cb653d3..e696ba0b573e 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -470,8 +470,11 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_unlock(dev);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.34.1


