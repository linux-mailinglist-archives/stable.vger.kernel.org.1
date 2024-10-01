Return-Path: <stable+bounces-78456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1398BAE0
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E641C1C22A5B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E51BF7E7;
	Tue,  1 Oct 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="baQN4szB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06341BD000
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781663; cv=none; b=db47gH8JnLHlRXEcafrZTS96M31zZpUqNbiE8WJxrffLz6B7lVDkRUeqgWGnwfhovAjtKjEGR0BgL2eD9NfJtFpGjYUNQZ/AeWnl4/lW8ufpr/6OE6YLe0hpdHqMxLucpmjQGw0zmK/8lDOVHCpwPx0sTerKo+zWgQW0V+CXIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781663; c=relaxed/simple;
	bh=Gn4arjKg+QLJAVRi6nzLJu+XGxf17wVcgwhUAHlMQac=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cUhNWUw4wG68DQZe9jp6R5l0PNAhDUs8SAeH57kaMhviriSi2DJhlItXMkdB2tVWqTgCsBTnQkspzEgoWbrmL4NImxbobkQegMtRTptMSpUmDOXjd7iWZVGDiTp+Cw1Rryv1kvarnznG9n09AdbnQl4n+E6p2bLQumXpCoVZxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=baQN4szB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFA7C4CEC6;
	Tue,  1 Oct 2024 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781663;
	bh=Gn4arjKg+QLJAVRi6nzLJu+XGxf17wVcgwhUAHlMQac=;
	h=Subject:To:Cc:From:Date:From;
	b=baQN4szB4VC6jpInz0SvTDTTTVjN/pnOrS85ZmCqhaCtWA8Bl+Aqztj3Oy4LxMxgG
	 csL1q2eBDUitAbjwiMiGEUGVJ9TGrNEgCti/To7XuODl/jxahPvpf6GiT3OfG/iHIO
	 SKC4ymUV0XhrnvXXcXF5hVAwudTbOfcrYPPnGQmQ=
Subject: FAILED: patch "[PATCH] ACPI: resource: Do IRQ override on MECHREV GM7XG0M" failed to apply to 6.6-stable tree
To: me@linux.beauty,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 13:21:00 +0200
Message-ID: <2024100100-deflator-mouth-8525@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b53f09ecd602d7b8b7da83b0890cbac500b6a9b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100100-deflator-mouth-8525@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

b53f09ecd602 ("ACPI: resource: Do IRQ override on MECHREV GM7XG0M")
6eaf375a5a98 ("ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)")
424009ab2030 ("ACPI: resource: Drop .ident values from dmi_system_id tables")
d37273af0e42 ("ACPI: resource: Consolidate IRQ trigger-type override DMI tables")

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


