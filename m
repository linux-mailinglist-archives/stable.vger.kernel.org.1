Return-Path: <stable+bounces-55184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F7916276
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4101F2162C
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B681494D1;
	Tue, 25 Jun 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yjZDYeUQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24508FBEF;
	Tue, 25 Jun 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308159; cv=none; b=Fm3ATZDF0MNcxiYwTI23bFjt1pZZKKBIFMwFu432o8VkkheJdj7srQBnrG0Q6qFTIRERBO5nXlmP3axHKfUIofqzcCTXbV/KWlB4WE5wma1V++aEhXSKISxob5zrSIScmJwtGn7AMUxltIqCY+RcZRXKf8rAN800X734kA1rWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308159; c=relaxed/simple;
	bh=7KZgZKeMbKJO0U2YDXBTYNM8lgiazpN0sr490EIVuGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkQUb/+d/TYnd36U4ErBwB9bH5+Vf9GC1ZSsEzoni6fr/sTGiZ6uKuFRDBHvJI8SQ4FllPAX/Cjj3OLWSmPo7Jf3OiZFztODNmil7aWUOkgdcSUjAtTttKHwtJNGWxPDStXK0xqleKS61vBvYIGh7L345VFtwGplu4cr2T3GYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yjZDYeUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA6C32786;
	Tue, 25 Jun 2024 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308159;
	bh=7KZgZKeMbKJO0U2YDXBTYNM8lgiazpN0sr490EIVuGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yjZDYeUQ02m0kSG5nHOstRbAdXfH9J/r5SX2ExihRVtJyhhPE5J4sgnxCuq05Mql4
	 EXjbAqevFn0S31mTwOfYmzNmEAD4P+vLFHAcTv1v1lo8X06W6qhiQJbILHu5LFqiye
	 aiV/5e4d6QXkq+ahLfKaNIzWeBz0txJbdT1h9eZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Schafranek <gschafra@web.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 026/250] ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)
Date: Tue, 25 Jun 2024 11:29:44 +0200
Message-ID: <20240625085549.059693726@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Schafranek <gschafra@web.de>

[ Upstream commit 6eaf375a5a98642ba4c327f79673f4f308e0ac03 ]

The XM APEX 17 M23 (TongFang?) GMxBGxx (got using `sudo dmidecode -s
baseboard-product-name`) needs IRQ overriding for the keyboard to work.

Adding an entry for this laptop to the override_table makes the internal
keyboard functional [1].

Successfully tested with Arch Linux Kernel v6.8 under Manjaro Linux v23.1.4.

Link: https://www.reddit.com/r/XMG_gg/comments/15kd5pg/xmg_apex_17_m23_keyboard_not_working_on_linux/ # [1]
Signed-off-by: Guenter Schafranek <gschafra@web.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 6cc8572759a3d..65fa94729d9de 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -533,6 +533,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  * to have a working keyboard.
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
+	{
+		/* XMG APEX 17 (M23) */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxBGxx"),
+		},
+	},
 	{
 		/* TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD */
 		.matches = {
-- 
2.43.0




