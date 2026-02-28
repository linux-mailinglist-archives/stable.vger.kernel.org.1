Return-Path: <stable+bounces-220922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAW6KUhJo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:00:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501E21C7B8C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AEC930F18C2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408042E713;
	Sat, 28 Feb 2026 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2QZL8C+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7542E709;
	Sat, 28 Feb 2026 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300811; cv=none; b=UNOiyzbtdHNvp5jZLWm4cyg3OXphn7/mFfEFMYzdNqylCbCSyoagUjtYKsn4DyDIJHZjnPokuKEVm6muWfsxr/AyJGRvIU8Jk11sh7GaTETALZA89iFZDprZy3+SJ8A14BK9eOK9jtzP5Nm9o9yYj8VS63vLbDm4WxB0kBHh59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300811; c=relaxed/simple;
	bh=kjYl48MKzqGpME0ktYz7rGI9bYGvuvntwezuXTvt6mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgl39gWLq0Kdw+9Zt3xoWJJDPWdfgAxgWvFw5xbfQlY4jXxw/XJ1+aOHK17TNjTB7ua/WEVedsXo8lXygwkaMBCPiqJV7efcXuPs6nvMwTrMjNAXLXkHUWk7Xr9pDKE+G/EsOxKvIUqRK9MIPmX1ITu/FzRHl1AKiOwUEDYOXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2QZL8C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428B4C2BCB4;
	Sat, 28 Feb 2026 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300810;
	bh=kjYl48MKzqGpME0ktYz7rGI9bYGvuvntwezuXTvt6mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2QZL8C+bcCE9zUdKOCA1evDantnd8VrNUhFDVOErncMcpY2UKIopVaT41BSDLyW4
	 IQEayyjBtdygrCpN8EgeK7qsTrsgkRcXatqaY6c+PTl45ggm93TMfiSRy5qXr1LNsN
	 DzZCnF5v3wdTKwZAAPSnqHUaoYEl8BJCpt1mRf4jf2sh4oqpVEr2M2f8n6ep++brDC
	 v1Ss9VJQoIp56u0qqiPP7XkA41cwjoVcxlAJzms+dl/FkWvNCEp3F0s67h3dEJP0Ee
	 X1qTv4jV6VrO8T1tNs3D+o9pLCHYVbCK5+envRf6/JeQRSs1+Wg3/ttQncnJTDGwBK
	 AYneuonY/S2WQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Athul Krishna <athul.krishna.kr@protonmail.com>
Subject: [PATCH 6.19 843/844] Revert "ACPI: processor: Update cpuidle driver check in __acpi_processor_start()"
Date: Sat, 28 Feb 2026 12:32:36 -0500
Message-ID: <20260228173244.1509663-844-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220922-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 501E21C7B8C
X-Rspamd-Action: no action

This reverts commit 0089ce1c056aee547115bdc25c223f8f88c08498 which is
upstream commit 6cfed39c2ce64ac024bbde458a9727105e0b8c66.

This commit is causing a suspend regression on systems such as the Asus
Zephyrus G14 (GA402RJ) with Ryzen 7 6700H: when suspending, the display
turns off but the device fails to fully power down. This is not seen
with v7.0-rc1 which indicates that there are changes missing. Therefore,
revert this change.

Link: https://lore.kernel.org/all/lA7Dz_m7_nCF8KkRyEOcSCLg799Mm9_DN2r9hx7ISjw32OoKiB1r_YjGHIFX8vgqxpOkVJ8d_yHb-VsGAvIWC942D4-zdWxAIP4_k6ZIQi8=@protonmail.com/
Fixes: 0089ce1c056a ("ACPI: processor: Update cpuidle driver check in __acpi_processor_start()")
Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/processor_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 7644de24d2faa..65e779be64ffc 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,7 +166,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
-	if (cpuidle_get_driver() == &acpi_idle_driver)
+	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
 	acpi_pss_perf_init(pr);
-- 
2.51.0


