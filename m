Return-Path: <stable+bounces-78458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4698BAE3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2862827F2
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7200C1BF7FA;
	Tue,  1 Oct 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2lfUupy0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316591BF7E7
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781675; cv=none; b=OmxDBkMDRXGf0FWuryOTcJZqqZIyNtkh3oOYEaFpdNC5F1A5V/RxijW0htoFrhaS3ALbMz54OnKBOrSfClb2A9A8ADit4b4X9uoN03j7rdwrCkJB+04+U3HyUHbk5LZ8P5AzZBceGY2C83GAjsmaI9RDf5zMu/UCAuxq5FdnqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781675; c=relaxed/simple;
	bh=tw1r6s6W6RiyHLHjd2Zi/0YQgjKFTfzZFWTbEFqKX0g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uu9ghZ/CcDaomkeu+pem8ChKpSQzCdIhibgY4ToMgy7NTUOxZwKKwOLWuHU/jSAeHhD0A4gp7LchOyPfEi5Yb93SJP0GLBCBSXk2C3DD3x6ghBsxsquEqfBs9thcYmMEbqZU/ANV1bQgyIAxS3oXMF1/jlL2q9eOQnbnVE6mNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2lfUupy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61C5C4CEC6;
	Tue,  1 Oct 2024 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781675;
	bh=tw1r6s6W6RiyHLHjd2Zi/0YQgjKFTfzZFWTbEFqKX0g=;
	h=Subject:To:Cc:From:Date:From;
	b=2lfUupy06ZUQKRveeHPaSdvDjj7cpAodmQDi8AtMbR3RY07rZb/ekyXZ19cxfkad3
	 XyD1duTth2dml4VuTS757wedIYjga3XWjvWb9X85OB4CUpf31KTCwu6i8ai1EvI7JH
	 pUhlN0ge5zQ1+HKHjdQf6lwMP1YSSL/BcO0J+tfg=
Subject: FAILED: patch "[PATCH] ACPI: resource: Do IRQ override on MECHREV GM7XG0M" failed to apply to 5.15-stable tree
To: me@linux.beauty,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 13:21:02 +0200
Message-ID: <2024100101-huskiness-tray-09c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b53f09ecd602d7b8b7da83b0890cbac500b6a9b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100101-huskiness-tray-09c8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b53f09ecd602 ("ACPI: resource: Do IRQ override on MECHREV GM7XG0M")
6eaf375a5a98 ("ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)")
424009ab2030 ("ACPI: resource: Drop .ident values from dmi_system_id tables")
d37273af0e42 ("ACPI: resource: Consolidate IRQ trigger-type override DMI tables")
c1ed72171ed5 ("ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA")
453b014e2c29 ("ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M")
56fec0051a69 ("ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M")
9728ac221160 ("ACPI: resource: Always use MADT override IRQ settings for all legacy non i8042 IRQs")
2d331a6ac481 ("ACPI: resource: revert "Remove "Zen" specific match and quirks"")
a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P")
05cda427126f ("ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA")
2d0ab14634a2 ("ACPI: resource: Add Medion S17413 to IRQ override quirk")
65eb2867f5bf ("ACPI: resource: Skip IRQ override on Asus Expertbook B2402FBA")
17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang GMxRGxx")
cb18703c1797 ("ACPI: resource: Add IRQ overrides for MAINGEAR Vector Pro 2 models")
77c724888238 ("ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA")
7203481fd12b ("ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks")
f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b53f09ecd602d7b8b7da83b0890cbac500b6a9b9 Mon Sep 17 00:00:00 2001
From: Li Chen <me@linux.beauty>
Date: Sat, 3 Aug 2024 16:13:18 +0800
Subject: [PATCH] ACPI: resource: Do IRQ override on MECHREV GM7XG0M

Listed device need the override for the keyboard to work.

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Li Chen <me@linux.beauty>
Link: https://patch.msgid.link/87y15e6n35.wl-me@linux.beauty
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index df5d5a554b38..aa9990507f34 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -554,6 +554,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  * to have a working keyboard.
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
+	{
+		/* MECHREV Jiaolong17KS Series GM7XG0M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
+		},
+	},
 	{
 		/* XMG APEX 17 (M23) */
 		.matches = {


