Return-Path: <stable+bounces-171793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF55B2C4ED
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54798A20493
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688B33CE9B;
	Tue, 19 Aug 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="DRp6HJzR";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b="cbNk+Pif"
X-Original-To: stable@vger.kernel.org
Received: from mail180-17.suw31.mandrillapp.com (mail180-17.suw31.mandrillapp.com [198.2.180.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D217A2E0
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608727; cv=none; b=X3EOsc6Kq62Skn8k426h+sevOrd5gXW/sagFeKrO9nqJILzsiokGkzV20UZXgw2g1v1yHOAZAXLzN+kQPOfseXLoRfhO88DSkxFHPDLMzhNbQPXiMe0tYwGE3JiLzS9KxVqkGoW9XbmfaKZOt5PI1eK4gQnODXcJU17TSU46y2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608727; c=relaxed/simple;
	bh=fQ7pXsQGa4WtfPifP7npJmZXx5WVfS/kepd7GCuUs/Q=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=VV4Y8ICGanZIudAlT0yOOpwq/2UYdkdS7CGdzv+VZuLF35vWIhp9R6Mym+YWFz5I8yzYrYGlko6zgkoUBTosfRyLmKExDjACI3DSL6QQ0d/w0xUC4mTWsckvxyE4LnxwG2nezbLNU7p6gcwQGVaXE8scs+SWvoe3liPvdube0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=DRp6HJzR; dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b=cbNk+Pif; arc=none smtp.client-ip=198.2.180.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1755608724; x=1755878724;
	bh=ynN0Q4f9z5yqLgyOgBZEkWAd9n0BYuRZiiXAJvoTa44=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=DRp6HJzREksCMBLGWflvIdzTDCZv9DUApOCOVgbc0eAMUzDplg4uZKJsSN15DHrjK
	 MpqVCKzY8QipcPWQ0ibz0prxtb7t9zwCvvkojSBRPGoAXi89nJaSinxiiRLNBFbVFu
	 WdT/IFLailtkSVBtHn+NANvgzzz3QGemSkzptW7RedXJZ7bXE8bpMx4m43IVufZnm4
	 OL1wkAMriGpT+b8i9nZa/NC4We9bhBw+k7Aj1Dsqw26OdMXOcX1NL57zC3UdTidh36
	 li6dHAX5tXiLrnvYfs6VKS19rEN6KN7L2YlpiXZpOY4mrUtQbD1S2rc/CyS4BZET3q
	 IB9zqujTpR/qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1755608724; x=1755869224; i=yann.sionneau@vates.tech;
	bh=ynN0Q4f9z5yqLgyOgBZEkWAd9n0BYuRZiiXAJvoTa44=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=cbNk+PifMdiol4mnmwiqj7Iuw1VeK8FpIaH+cPgLu0RDGJpDcPw8NCw8mHHZXId+l
	 k5fzqJJpYVRF/FZ7YUlK54STqPSheAt7kw5dNlOal6I8novPqnHwOv0IMwdR4m3u5p
	 XZZq02ghDRKrG20nJmq0E2EJj776wKcw3TTVttOc9OcjhpxyJLAlO66iHe4ea5clEl
	 Ml8027vulf6xd+eE5UAbA+pxLcql8orVShoQaJtgM0oRyEKIrf0aLScsJVe8xPTkRl
	 nLH3oMILotRZhkC0pV/KqhdffSxbRKBG5UGkPq5UTbCtfvGkcUrQk4b7QDasOe8XAI
	 MoMHiVNaHBKyw==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-17.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4c5qZD36xwzRKLf5d
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 13:05:24 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?[PATCH=205.15.y]=20ACPI:=20processor:=20idle:=20Check=20acpi=5Fbus=5Fget=5Fdevice=20return=20value?=
Received: from [37.26.189.201] by mandrillapp.com id 6f54511bf52a4c09ab8bfde5d873bcee; Tue, 19 Aug 2025 13:05:24 +0000
X-Mailer: git-send-email 2.43.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1755608723166
To: stable@vger.kernel.org
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Li Zhong" <floridsleeves@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Teddy Astie" <teddy.astie@vates.tech>, "Yann Sionneau" <yann.sionneau@vates.tech>, "Dillon C" <dchan@dchan.tech>
Message-Id: <20250819130500.98303-1-yann.sionneau@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.6f54511bf52a4c09ab8bfde5d873bcee?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250819:md
Date: Tue, 19 Aug 2025 13:05:24 +0000
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


