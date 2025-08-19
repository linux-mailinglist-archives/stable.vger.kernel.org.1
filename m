Return-Path: <stable+bounces-171794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6516B2C4BB
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175851BC04E4
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5A33EB1A;
	Tue, 19 Aug 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="GxQ2/oLJ";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b="ivkK37XL"
X-Original-To: stable@vger.kernel.org
Received: from mail180-17.suw31.mandrillapp.com (mail180-17.suw31.mandrillapp.com [198.2.180.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0416224AF9
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608749; cv=none; b=oKdtnpGG0QpmaGZ8ltI6c5/TL6LGVWa/vFpKkFAhKej8Iq9j+36U7urkD3l0oGcLPeS1rIIzajCRUmyBaCJYrdmEiNw00R/3+Kz7LXy3ff4Kz7ERlB0RJVUv1Oim5K9zPKjQf193wSc2asoqAZspYI5XI52FP91+P3useVG27sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608749; c=relaxed/simple;
	bh=fQ7pXsQGa4WtfPifP7npJmZXx5WVfS/kepd7GCuUs/Q=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=jA+28LGSwFrQjIPPORCsV3biPVjJSWRzbxL6L+660tolEfztz72bGlCclOYyixqPa64fdJOaJ8YTsEjsfbvnkc5jlLBsrldshdNDHP5XeRnuqfqbsUuF5Lf5u6TusBp9FZHn55jAlF0hoiVoO6q7y1kZNyTfosZRUh/59iTJaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=GxQ2/oLJ; dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b=ivkK37XL; arc=none smtp.client-ip=198.2.180.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1755608746; x=1755878746;
	bh=ynN0Q4f9z5yqLgyOgBZEkWAd9n0BYuRZiiXAJvoTa44=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=GxQ2/oLJKQ+1r+BHyq+pGOY5aVgCTapAFef53xN9L7h4IKuRVFOIi+5SyAF2vnau7
	 5baXE0a/qSaLBCsjA3YZQAzQUSicRp5lhwjmZMOHErkMqYOnqkwXQboNMLttV6J3qX
	 Rv7fhKOyfUvVOv7bsWtMBp9QDa2xuN9gZcrBotonUoIygsR7cAefnHMrB3OMvDZ8R/
	 JdmQnd/0NI8meTmFBXW6Ab3Dl0ArHcqIWMp2Lxgl7MGi7K9OdSfEW+NUzyIyYVG5Xu
	 6/UYQmsTfsooU05NFYiFeiAdpL6j6WndNJxD9jCMAlfJKCNMvVdLgG/lrCxAeeLWJE
	 DLqduKAQ+sVGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1755608746; x=1755869246; i=yann.sionneau@vates.tech;
	bh=ynN0Q4f9z5yqLgyOgBZEkWAd9n0BYuRZiiXAJvoTa44=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=ivkK37XLz5K788ib/bpX3jYL6xQbyHfbRplhfIx6fTmihCAUny8TI8eVypGHeYIiD
	 AoMbA44AHhMlZ8ANDv2ksEoLRkvcEM/fRM88/hcqNTnOpOE6N3CMTTbOojDdXW3922
	 bIBOnzahTUVSOatDaO0oN2XTjFNkcu5F6Ki+vBRHJ/UFJKzdPAMMAucTXSEsp+keAh
	 g1WVZ0Q9d4AY9DKauxlJx5omls/bSKA41qW1eby5hGHqSBANy8nxeEv8tHxNqE4ROZ
	 6Z3Elhi2fDb5rq45Z1ocjOB5no87OfoNwXfv/INX1w9ih21lAYClrA/GdjleCNxBwI
	 vAh9JpZPx6SFw==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-17.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4c5qZf04jWzRKLrMr
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 13:05:46 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?[PATCH=205.10.y]=20ACPI:=20processor:=20idle:=20Check=20acpi=5Fbus=5Fget=5Fdevice=20return=20value?=
Received: from [37.26.189.201] by mandrillapp.com id f44e7908149a4d5aa3aa452b35cd09aa; Tue, 19 Aug 2025 13:05:45 +0000
X-Mailer: git-send-email 2.43.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1755608744959
To: stable@vger.kernel.org
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Li Zhong" <floridsleeves@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Teddy Astie" <teddy.astie@vates.tech>, "Yann Sionneau" <yann.sionneau@vates.tech>, "Dillon C" <dchan@dchan.tech>
Message-Id: <20250819130539.98411-1-yann.sionneau@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.f44e7908149a4d5aa3aa452b35cd09aa?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250819:md
Date: Tue, 19 Aug 2025 13:05:45 +0000
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


