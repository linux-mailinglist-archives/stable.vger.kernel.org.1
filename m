Return-Path: <stable+bounces-38281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86F8A0DD4
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0EF1C21759
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E5E145FE0;
	Thu, 11 Apr 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P3UDgwKL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E31145B25;
	Thu, 11 Apr 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830093; cv=none; b=FwQHUeBKe4DLbR3lJrjw0uBax5GCSxwSaKf+I2YQoM5baAOk4rn9VmkS/BOiSkkBVUE/3JGg7fdLCfv8nSVkr+yyBS2lhza3vqZRhlpKANjNMtaOcBd4nzxARGQXjx8iysJRmSovSUc1L3ZqcqxjB0WIWa2ns6w53UYklxLFKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830093; c=relaxed/simple;
	bh=GoMtBC8i570UlmbQEsIP+lhEvjXyqSs3MtmXP6bE5xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8gb5MYOa7YLT/PPuUwQND1XMMkNHGqeQ5Vm0L3W2hEq66iHjAApWn5xHNoq9hS5Zea9+Gf+ZCCo+xw3OF1Uu6x/64hAQL4einkIJMD5LmqDYpHNuQlGHixdDtoPnuq0/WQM+Uy7QQeLbQC06qSiDEC/R9tHGuoRtd6X60suTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P3UDgwKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA7CC433F1;
	Thu, 11 Apr 2024 10:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830093;
	bh=GoMtBC8i570UlmbQEsIP+lhEvjXyqSs3MtmXP6bE5xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3UDgwKLEq9FItXP8IiiqeEhwhoOvoZdZlMlBcbB3VYqKH9iXHLipIw2Ijl3Xql9u
	 5poKGviZPuNWoBJ8Je9xc85msgepWtGcQJoIdnr1NoYvHkd3KsqzpiDzK49GJ/EbIg
	 lUffQVC8h12XGHI+6EqLgPVkRWGcY8kDute30ve0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 032/143] wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro
Date: Thu, 11 Apr 2024 11:55:00 +0200
Message-ID: <20240411095421.878870646@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 32167707aa5e7ae4b160c18be79d85a7b4fdfcfb ]

The ACEPC W5 Pro HDMI stick contains quite generic names in the sys_vendor
and product_name DMI strings, without this patch brcmfmac will try to load:
"brcmfmac43455-sdio.$(DEFAULT_STRING)-$(DEFAULT_STRING).txt" as nvram file
which is both too generic and messy with the $ symbols in the name.

The ACEPC W5 Pro uses the same Ampak AP6255 module as the ACEPC T8
and the nvram for the T8 is already in linux-firmware, so point the new
DMI nvram filename quirk to the T8 nvram file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240216213649.251718-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 86ff174936a9a..c3a602197662b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -82,6 +82,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* ACEPC W5 Pro Cherry Trail Z8350 HDMI stick, same wifi as the T8 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+		},
+		.driver_data = (void *)&acepc_t8_data,
+	},
 	{
 		/* Chuwi Hi8 Pro with D2D3_Hi8Pro.233 BIOS */
 		.matches = {
-- 
2.43.0




