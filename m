Return-Path: <stable+bounces-171795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2963B2C4EB
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB9324445A
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D8342CA0;
	Tue, 19 Aug 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="bS/JjKH2";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b="NIKFOyh3"
X-Original-To: stable@vger.kernel.org
Received: from mail180-17.suw31.mandrillapp.com (mail180-17.suw31.mandrillapp.com [198.2.180.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F633EB1D
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608772; cv=none; b=ia44R2WWVugyC8FqG4NZN+j+WmA4A9wTOpqSL1UPU1mr7fbvqwS/LqYot6qOQW5iBbXwqZKpjJqdQYDLNSmXjn05UnNUFQvE/U+VSxE+f0NhMX3hq9PJYSW1TKLAV18XEVAd4ddpFdE5C+rewRAZm8taAf+gHd7aW0eY3dgNCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608772; c=relaxed/simple;
	bh=fQ7pXsQGa4WtfPifP7npJmZXx5WVfS/kepd7GCuUs/Q=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=pUtFzuZ7lv3Wl2Hkvf1TbOogZCoQ23K+vLa2AciH5mUjUX29/dnAugkypXXPBIPbSL5AqewwA7DtTJ9Daj3oytcjVZAZuvjIVtzKkd2grMmnQ9EQ3Kr7iF6h4itGbtaOHGfKcYNCgXOX+ggkPl7Pm8J9dSQUgl6i0nR+vGuRAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=bS/JjKH2; dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b=NIKFOyh3; arc=none smtp.client-ip=198.2.180.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1755608770; x=1755878770;
	bh=ynN0Q4f9z5yqLgyOgBZEkWAd9n0BYuRZiiXAJvoTa44=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=bS/JjKH2GML1An7acP76+uz4amYnvbmLOxB1oMOhSqdQyBHk9vx1xDcnDkn8DyUDn
	 WqhRJbuxwnq+5G58E3NVnRz2aXopZJ7CHSI/Nn91roBxa6Gy/KtFr9mSoi8RDsZllo
	 bc+L9SRScMjqTNd+5NpBXk6sQKQTKm8sYj8Qra3AbgvvdY+uMC8yoP9chIutc/VQbb
	 pk57YuDLt2ciMQXBaxF1v9yUhVVu8TD18hTZ4lt9g/zVzHKgu8V6ffJvvQmgQTXNX1
	 kgB6YDxPynROO/TgfXwaBGz6VlDaUeKqD93u9EKelvtyCS32OR/YlYdlE0Zu4LnFf7
	 iNVXnI5DtXcdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1755608770; x=1755869270; i=yann.sionneau@vates.tech;
	bh=ynN0Q4f9z5yqLgyOgBZEkWAd9n0BYuRZiiXAJvoTa44=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=NIKFOyh3HXebCHPigI2O1vxPhfTk7W8IW1k0Ew+BzEckAwJNHON+DPqVWyg3bZCCx
	 VSubSYFovNHrK36IzsUT+Cvk5sHzZNHOCEkLamK5Tg0YnoHQzCZ5L9JtVnDSoiuicN
	 QCu/Coil/ADmVq+nrtIf9FB3lF5Qy//hcK/eiUQ1RMEvXQNn8GOZ8e6wwzFmRxvfhJ
	 T6elhdH2ixCZCRtoGvKFNX/e6G/ctmdxZZkR6FUG9YW8hG3JzOlOL+DIRL9NWwYCBw
	 Ldh8TWTBWOqYth8TLTy6ADuQ0yb+ln4QiU9OTOfNzCDZKuwvaUTJcDic9RcqShTUDf
	 K/u2x2F0wOaBQ==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-17.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4c5qb60LXPzRKLrN0
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 13:06:10 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?[PATCH=205.4.y]=20ACPI:=20processor:=20idle:=20Check=20acpi=5Fbus=5Fget=5Fdevice=20return=20value?=
Received: from [37.26.189.201] by mandrillapp.com id 0a4c7f8cc6aa47c7af1f0edcc658228f; Tue, 19 Aug 2025 13:06:10 +0000
X-Mailer: git-send-email 2.43.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1755608768253
To: stable@vger.kernel.org
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Li Zhong" <floridsleeves@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Teddy Astie" <teddy.astie@vates.tech>, "Yann Sionneau" <yann.sionneau@vates.tech>, "Dillon C" <dchan@dchan.tech>
Message-Id: <20250819130603.98467-1-yann.sionneau@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.0a4c7f8cc6aa47c7af1f0edcc658228f?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250819:md
Date: Tue, 19 Aug 2025 13:06:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

From: Teddy Astie <teddy.astie@vates.tech>

[ Upstream commit 2437513a814b3e93bd02879740a8a06e52e2cf7d ]

Fix a potential NULL pointer dereferences if acpi_bus_get_device happens to fail.
This is backported from commit 2437513a814b3 ("ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value")
This has been tested successfully by the reporter,
see https://xcp-ng.org/forum/topic/10972/xcp-ng-8.3-lts-install-on-minisforum-ms-a2-7945hx

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
Signed-off-by: Teddy Astie <teddy.astie@vates.tech>
Signed-off-by: Yann Sionneau <yann.sionneau@vates.tech>
Reported-by: Dillon C <dchan@dchan.tech>
Tested-by: Dillon C <dchan@dchan.tech>
---
 drivers/acpi/processor_idle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 92db8b0622b2..e6bba26caf3c 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1228,7 +1228,9 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 
 	status = acpi_get_parent(handle, &pr_ahandle);
 	while (ACPI_SUCCESS(status)) {
-		acpi_bus_get_device(pr_ahandle, &d);
+		if (acpi_bus_get_device(pr_ahandle, &d))
+			break;
+
 		handle = pr_ahandle;
 
 		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))

base-commit: 04b7726c3cdd2fb4da040c2b898bcf405ed607bd
-- 
2.43.0



Yann Sionneau | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


