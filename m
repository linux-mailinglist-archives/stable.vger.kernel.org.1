Return-Path: <stable+bounces-57449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801F1925C99
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375721F21156
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061EA185097;
	Wed,  3 Jul 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFjjEA8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7362185093;
	Wed,  3 Jul 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004916; cv=none; b=h9z5MlGFWRbYAB2Jm1XcshAxc+HTN8dswXOckkWCVKF+ILkQ14dSSYjgCxgL0jRIj+1DM1KIJs+MeEbzTriNcr/UAvvoLk9NMqx3eCyVdBT31STgLAUFrJufdUk4w+AowNYlXp9Ft8q11buGOv66BdjxPoVriagbaqhfRMp5XDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004916; c=relaxed/simple;
	bh=KTFHHf7yJEgyVxX/PmpEiqp8TT5hjKe5T9ZWBIslZJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/pgdO+05EV7Hq3mtEFZFcbvDM+78af6lEb0b0sCYZ1X5x46YQXDyqYDaCI5DXllR4nCFczqpfdyLDx/hkFF1Um74242BINNqWRE7RCoXRb3dXBmbdWSQzgjsGNNNrhG+kA6bxo3GyQTof/szaILVLs2H+ENjTda9Z7Z5LBTSzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFjjEA8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB3AC2BD10;
	Wed,  3 Jul 2024 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004916;
	bh=KTFHHf7yJEgyVxX/PmpEiqp8TT5hjKe5T9ZWBIslZJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFjjEA8aYxLaIsFpYJ9ix0h0q6ymwWYqTX2ybXp58lV5rmX99SiMLO5MLFm+QO+eo
	 JZ/WFrbUeZVmz4kHkTnMK8JE5aiwNA8xmg++HL8UYO7eJ9mW9Vts/HOavSt/2WBXrS
	 IzwtdXAQB+Y52HgpLZCI3RUV3F0TDppsujwQ5SgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Julius Brockmann <mail@juliusbrockmann.com>
Subject: [PATCH 5.10 200/290] ACPI: x86: Add another system to quirk list for forcing StorageD3Enable
Date: Wed,  3 Jul 2024 12:39:41 +0200
Message-ID: <20240703102911.718052122@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 2124becad797245d49252d2d733aee0322233d7e ]

commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
for StorageD3Enable") introduced a quirk to allow a system with ambiguous
use of _ADR 0 to force StorageD3Enable.

Julius Brockmann reports that Inspiron 16 5625 suffers that same symptoms.
Add this other system to the list as well.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
Reported-and-tested-by: Julius Brockmann <mail@juliusbrockmann.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: e79a10652bbd ("ACPI: x86: Force StorageD3Enable on more products")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 3a3f09b6cbfc9..222b951ff56ae 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -210,6 +210,12 @@ static const struct dmi_system_id force_storage_d3_dmi[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
 		}
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5625"),
+		}
+	},
 	{}
 };
 
-- 
2.43.0




