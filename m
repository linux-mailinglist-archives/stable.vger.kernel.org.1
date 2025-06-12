Return-Path: <stable+bounces-152558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B7AD7399
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64086164478
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643F02522B4;
	Thu, 12 Jun 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hztyPOui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D824886F;
	Thu, 12 Jun 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737900; cv=none; b=Bx8LNmefFqmSyBOyImXisvrilXG9xxnwPKWa0xIX6qn8+A8Ne1iOX7FG4FBrqazZfdQbLKP7zUvjWoWjyB17ogJzdAHIkV8BQpBWxyzOk4bfBNs4fkHHGbbrMuGqxvabVj9JS4BSH8mVk8jsKIurCU6tVNizRtf4Ikcg29IpigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737900; c=relaxed/simple;
	bh=Wm19W6ILPyOeVaqrzCWwFLG2OCJ4d848SPSkvqb417Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GY2gSkrcYBSj7S2x/uHdjqRduFpH1WRdXsRmtgTaxQQyUahDg1cYnHEEA3AnDIX8jA4/Q7Dk5ON+nW6179TqykrV9KpgNgauTQl71v1jVI7bneJIwyQc/b+n8xCXdD0lTbf0cE9296EJuW3ZkQnBuNgg+0fu2x15/uSgLNkEM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hztyPOui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91108C4CEEB;
	Thu, 12 Jun 2025 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749737899;
	bh=Wm19W6ILPyOeVaqrzCWwFLG2OCJ4d848SPSkvqb417Y=;
	h=From:To:Cc:Subject:Date:From;
	b=hztyPOuiSOpQZp4kcZZX9PexGV7E1EiqNM0y3SDDcEaxmDRYMjDLmh5pHh2orL/nK
	 c4K6NAYIlE1zP8QtIKNNRWFznHuppEHjvN54IQID5NEiZVZne0oD/AiwySG8q91dW1
	 31zA3+n7qtg6QC07ocsLzJdhjJC0XT2JSX81Mz6f0xv/JszL5ZaEEKLkMDJKRa75Lx
	 2t2CMyn/4w0s0Aq5bKWEViqRoAXgGzA+IabEmFfaJ9naCGNtVsIdraOmjaST/l5AFj
	 c4KGNlfqsncJZOG9HjikmvTR4/+kEfYBkC4A63xqSxdJHbdWzgVHTa2bnoBiC0g+X0
	 UVZbnm4M+uA5g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
	Hans de Goede <hansg@kernel.org>,
	Andy Yang <andyybtc79@gmail.com>,
	Mikko Juhani Korhonen <mjkorhon@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
Date: Thu, 12 Jun 2025 16:17:51 +0200
Message-ID: <20250612141750.2108342-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3400; i=cassel@kernel.org; h=from:subject; bh=Wm19W6ILPyOeVaqrzCWwFLG2OCJ4d848SPSkvqb417Y=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK8HvbFs8ZP7BRTPPrw5plvm1byR4hxv3klrsIqwMQn+ lJ6w/yUjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwk7xbDP4srAZGdywIDPRef 1PlTaSvd65M+O+MC18dQ0yLJTeefLmL4Zym5w/hJd5PtrGWCB4JeRF8WfFaoffWpnIVzaOfOUwU rmQE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A user has bisected a regression which causes graphical corruptions on his
screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
type").

Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
board type") makes the graphical corruptions on his screen to go away.
(Note: there are no visible messages in dmesg that indicates a problem
with AHCI.)

The user also reports that the problem occurs regardless if there is an
HDD or an SSD connected via AHCI, so the problem is not device related.

The devices also work fine on other motherboards, so it seems specific to
the ASUSPRO-D840SA motherboard.

While enabling low power modes for AHCI is not supposed to affect
completely unrelated hardware, like a graphics card, it does however
allow the system to enter deeper PC-states, which could expose ACPI issues
that were previously not visible (because the system never entered these
lower power states before).

There are previous examples where enabling LPM exposed serious BIOS/ACPI
bugs, see e.g. commit 240630e61870 ("ahci: Disable LPM on Lenovo 50 series
laptops with a too old BIOS").

Since there hasn't been any BIOS update in years for the ASUSPRO-D840SA
motherboard, disable LPM for this board, in order to avoid entering lower
PC-states, which triggers graphical corruptions.

Cc: stable@vger.kernel.org
Reported-by: Andy Yang <andyybtc79@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v2:
-Rework how we handle the quirk so that we also quirk future BIOS versions
 unless a build date is explicitly added to driver_data.

 drivers/ata/ahci.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e7c8357cbc54..c8ad8ace7496 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1410,8 +1410,15 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 
 static bool ahci_broken_lpm(struct pci_dev *pdev)
 {
+	/*
+	 * Platforms with LPM problems.
+	 * If driver_data is NULL, there is no existing BIOS version with
+	 * functioning LPM.
+	 * If driver_data is non-NULL, then driver_data contains the DMI BIOS
+	 * build date of the first BIOS version with functioning LPM (i.e. older
+	 * BIOS versions have broken LPM).
+	 */
 	static const struct dmi_system_id sysids[] = {
-		/* Various Lenovo 50 series have LPM issues with older BIOSen */
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -1440,6 +1447,13 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 			},
 			.driver_data = "20180409", /* 2.35 */
 		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
+			},
+			/* 320 is broken, there is no known good version yet. */
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
@@ -1449,6 +1463,9 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 	if (!dmi)
 		return false;
 
+	if (!dmi->driver_data)
+		return true;
+
 	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
 	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
 
-- 
2.49.0


