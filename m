Return-Path: <stable+bounces-76134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE5978F0A
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 10:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1641F239A6
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 08:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4613A899;
	Sat, 14 Sep 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="RofrCbpT"
X-Original-To: stable@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0463EA64;
	Sat, 14 Sep 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301746; cv=none; b=fwWElvX4TMvFlL5BWlfW0F4HwQlz5r4SbQ7jMeouVVxy+xKh9ZJOCIAoXid4hDT/vpgCrmp4V1R8JdC70WCA6kPL7VQQ2Ev/F7igO7nCMYUmRr23AmkENCZXftGYIoVF5Wy+bR6lGdP87OkqmA4QuWk/ZxgrMXnnZeJjSl24lrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301746; c=relaxed/simple;
	bh=mTioAPfI0CkIlr98RaGbMB1Mj1BuxR3Mz2j0F+asho4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T3eojtaQhxw+QAOb7QMhguIdg/E2NgVRs96ZdX+ImvbdAEgRooiO2x9FujTs4xUWfn6pYhQomT+bSHiWvCZnLn+7kUpfkTSEk4XkpjVJmISePqTkzevpwaTbgHMaWH79epmkJRRVww0aUoOpLKyN4tev0SCoEdjl98siCmrrZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=RofrCbpT; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QhKSFUo7WyCueWvNWaWlhkk8eLUSR6pLAbSkH0McOp8=; b=RofrCbpT0MFVExc/piCtQEF34U
	chwlno4MPLjs80PQc8FkIrIlJy6vU7SG4N/A4sXGVnGnRq9MzO6CddLJFpPEyRVRjMoZIH9HVy4eD
	yc/HWh2Udoy+11Wuvs8xHgBwaKvGMQMaIVSWKUrqjavJdfCcUuuBAPUX0hIxm11+6slCCNki2NAtI
	pUYLizCT85AvWR3z0xU8x9GYM4QgjbACcTVj7HprF90dz38S/IE7fqzjjQh5BEGUpRiDAS+svWe/Q
	47cVDYwzPiDBsPwMUsZiMPPJbp4WQmdQ86iDij/AZ3ROcMYlfH1DtURQ8Bp9qkiCkiyqiKuG/pd1L
	JryE92Mw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: sre@kernel.org,
	linux@weissschuh.net,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hns@goldelico.com
Cc: Andreas Kemnade <andreas@kemnade.info>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: sysfs: enable is_writeable check during sysfs creation
Date: Sat, 14 Sep 2024 10:15:23 +0200
Message-Id: <20240914081523.798940-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The files in sysfs are created during device_add(). psy->use_cnt
is not incremented yet. So attributes are created readonly
without checking desc->property_is_writeable() and writeable
files are readonly.

To fix this, revert back to calling desc->property_is_writeable()
directly without using the helper.

Fixes: be6299c6e55e ("power: supply: sysfs: use power_supply_property_is_writeable()")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Cc: stable@vger.kernel.org # 6.11
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 3e63d165b2f70..b86e11bdc07ef 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -379,7 +379,8 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 		int property = psy->desc->properties[i];
 
 		if (property == attrno) {
-			if (power_supply_property_is_writeable(psy, property) > 0)
+			if (psy->desc->property_is_writeable &&
+			    psy->desc->property_is_writeable(psy, property) > 0)
 				mode |= S_IWUSR;
 
 			return mode;
-- 
2.39.2


