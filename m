Return-Path: <stable+bounces-105512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E056E9F9941
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 19:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC0F16576D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4721A447;
	Fri, 20 Dec 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM/3hsnv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7E3D81
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734718442; cv=none; b=GrHTs9bQP6n6dx1xlxvbBlIsx0Jonrttn+Gzfga4P+8JIybs6EfU4m7Ne4J/hj4QlKcQNY3Uml34yVAnWHa4JTOcQLgNQEQRfjloiGFcPsmq/EWzPMtrdivjrbv4q3dgooG4aOWX2HU5ADW7GeRJT4HcRpF2C/Rres0k2GcXEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734718442; c=relaxed/simple;
	bh=D+422xzYfNbceghs9iP1357co6BAuS7mDh4KB0sBq2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTguZrOLFP4eD+YnKKDgefqdE7HV8YjxOvqrOQP48tDevfQHQPlN9vGu9x4U4P3yay4rEGw0pQym1fAQef7NxDVFihQPf3hO78riEOdoj6Dhf5AaULQqS7u3lyYD7afbJ6MsMABvt4SZO4S3+KMRyi+UNMOw/4iPZfIPTG/cGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PM/3hsnv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734718439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+E/+0LM2lE7K2vZEgFblryD/86he2sGF+A9H+0OMLmM=;
	b=PM/3hsnv5hCzLpco8Snq2uFv9q+bC5dFoPc7AdFxF/+oUYZh3TuiD4YQDTTQ1jRCrUtW/X
	4HlAGYt8bTf2i8y4prTJmPBUcdIG4g0yfpeG+0Nqxk5RpQDfeB6Q0FEDwBJvE1QZ/k/aLB
	5vu5T6EZ2bhHyxNL0VQZ84p5ZJuuKb8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-jFLqdM_nOjWkuJ6_exb9Sw-1; Fri,
 20 Dec 2024 13:13:57 -0500
X-MC-Unique: jFLqdM_nOjWkuJ6_exb9Sw-1
X-Mimecast-MFC-AGG-ID: jFLqdM_nOjWkuJ6_exb9Sw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE16919560A2;
	Fri, 20 Dec 2024 18:13:55 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CA45195608A;
	Fri, 20 Dec 2024 18:13:53 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]
Date: Fri, 20 Dec 2024 19:13:52 +0100
Message-ID: <20241220181352.25974-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Like the Vivobook X1704VAP the X1504VAP has its keyboard IRQ (1) described
as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh which
breaks the keyboard.

Add the X1504VAP to the irq1_level_low_skip_override[] quirk table to fix
this.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 821867de43be..ab4c0e0b6b8e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1504VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1504VAP"),
+		},
+	},
 	{
 		/* Asus Vivobook X1704VAP */
 		.matches = {
-- 
2.47.1


