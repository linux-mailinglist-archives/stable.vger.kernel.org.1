Return-Path: <stable+bounces-18573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02327848343
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995911F2549E
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E851CD30;
	Sat,  3 Feb 2024 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qVci0VKr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B6171A4;
	Sat,  3 Feb 2024 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933898; cv=none; b=e4VVIxSxxW2wfhrS1z+uvy49waqtZQPpiK9dzXSP38igjq+1UoDKleFL8xLw7DkB9UA5Te4LZgJoVnB4NBe9/tPnprmElR4FSaw+kKYXB7+ZoHaEL4GPZ1A2gghR1UJM3fj59s77Ug+MxHJADNU4YACfuo9YsF8rWOXknOCuFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933898; c=relaxed/simple;
	bh=mR1d7x+M8GIfuVpIHlw+np+dZl+QIl3zupBxPdnOc6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGDVDSxVoqreS+EvzzcOXOqjd3J1SeRds4xpP/6YOmJlhNAgdS8Sndeay6LktAcMCJ/5rxrBuJYjg/fKPnX/fzy7mFHTiVaV+UHgt7O7Zmn8vvWj55W01ySEkIpJlgtLRBwp0UkxQdvVgBRfYIemEA46//nrjQNmWzS1PsD1+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qVci0VKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4F3C433F1;
	Sat,  3 Feb 2024 04:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933898;
	bh=mR1d7x+M8GIfuVpIHlw+np+dZl+QIl3zupBxPdnOc6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVci0VKrpphC3OoKRVtWtqLXj1oJ72tEW4zcwg2iou5auZzjAf9ylTPBfGUgsEZNO
	 UzMkmlTxMBjk+Uc3COm5Q4ZRFMJOP7EXwOJ960IghgtoKx1OB8B3FtVngsZGUsBtGQ
	 L19UOKrfwaes1Y7bHN3iQzi3hyWo2O/M2sxG71uU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Maltsev <mekosko@projectyo.network>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 245/353] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CGA
Date: Fri,  2 Feb 2024 20:06:03 -0800
Message-ID: <20240203035411.460383460@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Maltsev <mekosko@projectyo.network>

[ Upstream commit e315e8692f7922cd1b2a26bd7a1741cc8ce77085 ]

Like the ASUS ExpertBook B1502CBA and various ASUS laptops, the
ASUS ExpertBook B1502CGA has an ACPI DSDT table that describes IRQ 1 as
ActiveLow while the kernel overrides it to Edge_High.

	$ sudo dmesg | grep DMI
	[    0.000000] DMI: ASUSTeK COMPUTER INC. ASUS EXPERTBOOK B1502CGA_B1502CGA/B1502CGA, BIOS B1502CGA.303 06/05/2023
	$ grep -A 40 PS2K dsdt.dsl | grep IRQ -A 1
	                IRQ (Level, ActiveLow, Exclusive, )
	                    {1}

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Signed-off-by: Michael Maltsev <mekosko@projectyo.network>
[ rjw: rebase, replace .ident field with a comment ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 7d58d8b4ca76..03b52d31a3e3 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -461,6 +461,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1502CGA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
+		},
+	},
 	{
 		/* Asus ExpertBook B2402CBA */
 		.matches = {
-- 
2.43.0




