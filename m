Return-Path: <stable+bounces-81176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A28991AD7
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 23:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B141C21802
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 21:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E6166315;
	Sat,  5 Oct 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHUVvJ9O"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26A1662F1
	for <stable@vger.kernel.org>; Sat,  5 Oct 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728163727; cv=none; b=mAmXyx4rpvqPV13Oopd3sME1cVokdQDaCjlt1cSCcNoQGQjei2mjV78k1ukzYBERlSllYQXdvpNQsCZPkyIdmDuFkvlXb8OjAtmX9ChfOlLSb2JN5liSnW6WeOXRQUedwpJ+NXyjA7Jt1dNgg2Dl+DLBsm3uwwkA7FmeXrGOm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728163727; c=relaxed/simple;
	bh=+6IGhI/VhCRc/pCFnHaKy6UeBFPJuaelh6tc7PVS7NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/H41HygMnh6W4ab+Ap3hnMQJC0jxxApk0Z+rE5+yQrFGUvYPOwehYYPq/OAvaOBGLBTSUJEml9onn6cUrEOZg8Zns/leQqziRrklBRreiUFFNyQVyh2OVg6IYFO/Vp6JTw/Nls7CldBc9qqj6sbfxvkeTZRnWKKZ1f5AzeCgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHUVvJ9O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728163725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvY/dMyu28luY+XmjBds51FhPF3+yFHesMUEQg3Czek=;
	b=BHUVvJ9OJxCa1PI1BSHkjavQ7LTsM4vaRYdKFBwfMc7hGAy80UHmmv4Srxy7ACYRfuJ/Gu
	ccautuzmrkua/mBMGD/GqP6gbCtb6w6cxMqZ3fnLHQGPSxKFuMjE/E/DoAjMPQ/XJsrEVx
	FF2SpOGlDFKe2bPBhEuZwohkbRaWzn0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-zy4I1Xv6MfyWmV4SSF-aYw-1; Sat,
 05 Oct 2024 17:28:41 -0400
X-MC-Unique: zy4I1Xv6MfyWmV4SSF-aYw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94DE11954206;
	Sat,  5 Oct 2024 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.19])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BD5C1956088;
	Sat,  5 Oct 2024 21:28:38 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	All applicable <stable@vger.kernel.org>
Subject: [PATCH 2/4] ACPI: resource: Make Asus ExpertBook B2502 matches cover more models
Date: Sat,  5 Oct 2024 23:28:17 +0200
Message-ID: <20241005212819.354681-3-hdegoede@redhat.com>
In-Reply-To: <20241005212819.354681-1-hdegoede@redhat.com>
References: <20241005212819.354681-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Like the various 14" Asus ExpertBook B2 B2402* models there are also
4 variants of the 15" Asus ExpertBook B2 B2502* models:

B2502CBA: 12th gen Intel CPU, non flip
B2502FBA: 12th gen Intel CPU, flip
B2502CVA: 13th gen Intel CPU, non flip
B2502FVA: 13th gen Intel CPU, flip

Currently there already are DMI quirks for the B2502CBA, B2502FBA and
B2502CVA models. Asus website shows that there also is a B2502FVA.

Rather then adding a 4th quirk fold the 3 existing quirks into a single
quirk covering B2502* to also cover the last model while at the same time
reducing the number of quirks.

Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cbe51ae6ae25..0eb52e372467 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -490,24 +490,10 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		/* Asus ExpertBook B2502 */
+		/* Asus ExpertBook B2502 (B2502CBA / B2502FBA / B2502CVA / B2502FVA) */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
-		},
-	},
-	{
-		/* Asus ExpertBook B2502FBA */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
-		},
-	},
-	{
-		/* Asus ExpertBook B2502CVA */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502"),
 		},
 	},
 	{
-- 
2.46.2


