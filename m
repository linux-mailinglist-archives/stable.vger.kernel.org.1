Return-Path: <stable+bounces-106057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDC9FBA47
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 08:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDFF1883272
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2218B47E;
	Tue, 24 Dec 2024 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YRD25q+p"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201F86250;
	Tue, 24 Dec 2024 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735026266; cv=none; b=NCNaLe/AQfq6WpliiOWiHxx7lyjFgSvKnU5a5R0CmeGi0Js4wKT6hBifJ31pVol/MhlpjSz+QyZeTiPNisTDrw7y3VCil3EIahCTGB5y6RJ1TKvtNHkcDfua39M/zTaMYvaP6UQqco18KLAwdx8kHn8a5Gp63uDTM/blR36Q6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735026266; c=relaxed/simple;
	bh=+tmVQNDbPLLjALMas9jkB+FitqvhPC+w92rzlYHAmaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kgud8Rk6VvM85EeYUXGxkwm1rdzNOED6xBniqAH4uwaU8U1lzIxJZvG5YndD8ZfiFEHUnlbXfsn+BJ4FuWI+D2Orj1C4t/NessDjpIXcANMkjJrby+JRU/Oi3GCH/Xhdsb3G7siA7gC9Kh17Y+IJO9ISmn82LPJDyf2yIAgzefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YRD25q+p; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rv8l9
	YFNfbS2Fc/AUsV3HzdcDIM3qTrTB46nCaLjGlg=; b=YRD25q+pp5yfPM8Ayf2wj
	pY4BXC4d8Aa2lfKqS/ToGjZ2ZTrICY753+4S94kTnVV5obyRQBB1PpZesh8bSNex
	OGcZRmda1T7J/oWckZYgtOT8yXTr5DA0GGnyftGny8t9jDJZ6oWHiwHbyCX0QOBZ
	S3YmVEUETwL0OXq2QLZd7g=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X5QTZmpnV25TBQ--.3123S4;
	Tue, 24 Dec 2024 15:43:24 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	jeff@garzik.org,
	James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] [SCSI] raid class: Fix error handling in raid_component_add
Date: Tue, 24 Dec 2024 15:43:14 +0800
Message-Id: <20241224074314.3769014-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X5QTZmpnV25TBQ--.3123S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15JF48GrWrAw48ZFW3GFg_yoWkAFg_GF
	40vryIgr1Ikrs7XasxtanxZr1vgFsF93yfuFWIvFn3Zay3XFZFqr1DWrs0vryUW3yUXw17
	J3W5tr40vr409jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZnYFUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBXwC-C2dqYxc-yQAAsk

The reference count of the device incremented in device_initialize() is
not decremented when device_add() fails. Add a put_device() call before
returning from the function to decrement reference count for cleanup.
Or it could cause memory leak.

As comment of device_add() says, if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: ed542bed126c ("[SCSI] raid class: handle component-add errors")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/scsi/raid_class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 898a0bdf8df6..2cb2949a78c6 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -251,6 +251,7 @@ int raid_component_add(struct raid_template *r,struct device *raid_dev,
 	list_del(&rc->node);
 	rd->component_count--;
 	put_device(component_dev);
+	put_device(&rc->dev);
 	kfree(rc);
 	return err;
 }
-- 
2.25.1


