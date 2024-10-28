Return-Path: <stable+bounces-88473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459149B261F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60BE1F21E08
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245D018E74D;
	Mon, 28 Oct 2024 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QSpfEb+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF518E350;
	Mon, 28 Oct 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097411; cv=none; b=KQRPX795L7Kgzkc9CeIiga9CREaUpsX8N1nA14iO5KLYuYYA1qWNEgT0KphR4p/umHwZNlYI+JzyRoURnsXnk/y48jnnRokthuf/YXOLiJIIMZ5BCOsSwwdEXOTjivSSAkZ5RQYxiXBdDGWnT9cRj3T0Gv9/9omk63baYB2YJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097411; c=relaxed/simple;
	bh=GdMDz6dahbLFR8TywUAXvmjSZfFtDdTp9AGv8Ooo0f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dj4OuMBPUe+bjTzDAdmTSn42P7H+NnahJG9JfZHX2FjSWZ1NtKZpEsMkiacA+TL9pqPzfgLnKAxVTRRmfTQ040QLYP8dtr1giVMUlTqOx/qPb8bIy6LrnsubhuZA/0Bxr8F2pP6JY+T9T79W/iJPDxxL2x83mSYv1yjskW/+c+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QSpfEb+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CB3C4CEC3;
	Mon, 28 Oct 2024 06:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097411;
	bh=GdMDz6dahbLFR8TywUAXvmjSZfFtDdTp9AGv8Ooo0f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSpfEb+j9qTR5i6co0KuXHkKhNFEtVJXokjJ2MgpnZVCLuqrEDUrmoCeyyrt8xCN0
	 rKLgndEMhF4NmVY8UE4VBxjOX7ctXyalve+ns4SK5DJqB5yDvDuxdkVzpjye39GYSE
	 QCCcnuIWhGWAMseOcQpsUcS2jeAZwFOdg1ZL9ATE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shubham Panwar <shubiisp8@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1 120/137] ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue
Date: Mon, 28 Oct 2024 07:25:57 +0100
Message-ID: <20241028062302.064171942@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shubham Panwar <shubiisp8@gmail.com>

commit 8fa73ee44daefc884c53a25158c25a4107eb5a94 upstream.

Add a DMI quirk for Samsung Galaxy Book2 to fix an initial lid state
detection issue.

The _LID device incorrectly returns the lid status as "closed" during
boot, causing the system to enter a suspend loop right after booting.

The quirk ensures that the correct lid state is reported initially,
preventing the system from immediately suspending after startup.  It
only addresses the initial lid state detection and ensures proper
system behavior upon boot.

Signed-off-by: Shubham Panwar <shubiisp8@gmail.com>
Link: https://patch.msgid.link/20241020095045.6036-2-shubiisp8@gmail.com
[ rjw: Changelog edits ]
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/button.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -121,6 +121,17 @@ static const struct dmi_system_id dmi_li
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Samsung galaxybook2 ,initial _LID device notification returns
+		 * lid closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "750XED"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 



