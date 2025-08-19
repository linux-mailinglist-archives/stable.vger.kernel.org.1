Return-Path: <stable+bounces-171773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE597B2C282
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC6DD4E440C
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942F23314C7;
	Tue, 19 Aug 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="GZPrS9tj";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b="jfwV04f9"
X-Original-To: stable@vger.kernel.org
Received: from mail180-9.suw31.mandrillapp.com (mail180-9.suw31.mandrillapp.com [198.2.180.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EF3314A5
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604703; cv=none; b=aj6mMi/H8DV4TSFF7ZpfiSl//yc3pBTAoGFyayO8kLQC/WAgg+zCn2YxS9FrZzdAFREUuhC45TSyK3aQlr9NLYR2TXckPk0WijppNyAg0yXVKz5aS8xXRRtJ80obNRPFH7npEOUUYzCEXY/5ZJUGX4SIqYhZF69YuYSPHSRJlDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604703; c=relaxed/simple;
	bh=tm2PaySUd+ruiO51VNB0tOZbrsdOmnWTXI1a/6uqutY=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=Z3vleJ7o7D1+Q7TgkfVsfafmGJ6491wvcebgzVuYGsYYrdg99UnMhd7HezTRwRBmdzRZS/W6ieXRLcvSlC1jqdrv7vAiNHsenlVKEdP/BX4+67+iQJeGsXZiQGYYC/kBX+Tc1Tg40gBRoUKkNoMF5WMhgrCEX5J+acY7eT+2IkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=GZPrS9tj; dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b=jfwV04f9; arc=none smtp.client-ip=198.2.180.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1755604700; x=1755874700;
	bh=YKDi8ixb9ZWjNf22pTiR4bKbJluDjaiz4fxFBcVdozo=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=GZPrS9tjKpPK0/wkH+3qyilr3Oj7OlAJL6VO9ocaOnTSkiMKO2rlMgS1L27nj6MvR
	 5hdnCbJZifrkaC93eF3qAcRsIhLm8FDs+Dw+iiODTbMJvj7DUlDaFtICORWyUAcTFO
	 jx1PFCyhatVWR5ZuJx4xCYh5pF04P80Xg7L3sNBPomY1aNB+ToYNjPXdDdzrfhpPWv
	 fvGMJeRcdiDUBgEtdIxvo9/psh8LIlvorQg7snpw+m91LceQNxc4GGDC0DAjOQhnl3
	 BuKBN6FZAkYwYxt+ueeyM7lyp5gknQ9qEvmunV12s+H5a8Z22gN0LEHLBtnH01IspR
	 rcofydLHul7NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1755604700; x=1755865200; i=yann.sionneau@vates.tech;
	bh=YKDi8ixb9ZWjNf22pTiR4bKbJluDjaiz4fxFBcVdozo=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=jfwV04f97Zu19/wTfwQdJoeQRQUVPyg5eVUhCMNwGwqCYWdw05LmRUgfggCYQhw8G
	 VoGCiKknb8Hv7KqFepq30uhnsRv8aEWNgbCRFTzMJQcb2DmYIcJNbYvcKYokB8r9Qm
	 x9n4AUjAolQcqK0J9urb17vfygY8ssrAqxj5cOC0iQrVIcvWyFxqZKApJvXoT9X+gX
	 bvbKyxLzXrsaONGTRkzDbpGcr9EyJW6OSmPpvDzFRxHpvFki3R6XUMMNcx02Avd9Fd
	 KnhpP4jIcdvjxIQErZIH6lbos4QHwBYWz0dd3ECrg+qzqHccZrPFCcnucyM6k2cgIZ
	 aaKJXg00582OQ==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-9.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4c5p4r59TyzK5vqJq
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 11:58:20 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?[PATCH]=20ACPI:=20processor:=20idle:=20Check=20acpi=5Fbus=5Fget=5Fdevice=20return=20value?=
Received: from [37.26.189.201] by mandrillapp.com id 7a7a3264fd3742ef83042ef7d1200ce3; Tue, 19 Aug 2025 11:58:20 +0000
X-Mailer: git-send-email 2.43.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1755604698870
To: stable@vger.kernel.org
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Li Zhong" <floridsleeves@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Teddy Astie" <teddy.astie@vates.tech>, "Yann Sionneau" <yann.sionneau@vates.tech>, "Dillon C" <dchan@dchan.tech>
Message-Id: <20250819115301.83377-1-yann.sionneau@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.7a7a3264fd3742ef83042ef7d1200ce3?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250819:md
Date: Tue, 19 Aug 2025 11:58:20 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

From: Teddy Astie <teddy.astie@vates.tech>

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


