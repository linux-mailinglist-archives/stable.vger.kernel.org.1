Return-Path: <stable+bounces-207467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C378D09F0D
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3ED3D302354A
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876F358D30;
	Fri,  9 Jan 2026 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZS8Pxy6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23D358D38;
	Fri,  9 Jan 2026 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962138; cv=none; b=qIncy+3tkN+xKVAwiklMezCEBjVt3E9phkIN8D8g9a1LOrUw5iXPp9OBiA2qbv3K/asADiQgDiBNxVFQNTukQ3q+FrZi4H7OFp3jkF3ngEozsD1vW3MfOKoV6GyU41klkMDYUARsrGROy7RWytG3mNiRe91w/Wn79JstiQRFidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962138; c=relaxed/simple;
	bh=6d+YU5o8WGbvQQruxRNVAcwCjez/GOZvS3iNKsBFGK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4MqUinT1ibVowc/ry8OWV6OZdpNZE2xwwO8A8nyCdkzETKIL7ZugMLNzZMvGxTiEDCpf+QM3lqBJMFTX5gZtIRl9agBGJkn1zf/6/D2WvYrwbEs5+6DFGSQVCG2TM0LfAeoNFL25WoW3reHUuyuAdvZAMRGEOpWEnaD4HsEPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZS8Pxy6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C81C4CEF1;
	Fri,  9 Jan 2026 12:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962138;
	bh=6d+YU5o8WGbvQQruxRNVAcwCjez/GOZvS3iNKsBFGK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZS8Pxy6diCghe5kn4eB0mqPC5uY56AHifHHofPU+hyeHg0elgITQ1dnCo9yo0P2JP
	 mJMUIG9dG0AQYFtc1eCQ6lDERCsuvdRYCnzf+bWG5VWYTRM0eVk+hY+N/obTt1dQa0
	 Opz2ZJ4KemXhD3cbhbDsHVWSju9Hek/JZQHZI1fg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Hans de Goede <hansg@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 242/634] wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet
Date: Fri,  9 Jan 2026 12:38:40 +0100
Message-ID: <20260109112126.648151863@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit a8e5a110c0c38e08e5dd66356cd1156e91cf88e1 ]

The Acer A1 840 tablet contains quite generic names in the sys_vendor and
product_name DMI strings, without this patch brcmfmac will try to load:
brcmfmac43340-sdio.Insyde-BayTrail.txt as nvram file which is a bit
too generic.

Add a DMI quirk so that a unique and clearly identifiable nvram file name
is used on the Acer A1 840 tablet.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Hans de Goede <hansg@kernel.org>
Link: https://patch.msgid.link/20251103100314.353826-1-hansg@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index c3a602197662b..abe7f6501e5ed 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -24,6 +24,10 @@ static const struct brcmf_dmi_data acepc_t8_data = {
 	BRCM_CC_4345_CHIP_ID, 6, "acepc-t8"
 };
 
+static const struct brcmf_dmi_data acer_a1_840_data = {
+	BRCM_CC_43340_CHIP_ID, 2, "acer-a1-840"
+};
+
 /* The Chuwi Hi8 Pro uses the same Ampak AP6212 module as the Chuwi Vi8 Plus
  * and the nvram for the Vi8 Plus is already in linux-firmware, so use that.
  */
@@ -91,6 +95,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* Acer Iconia One 8 A1-840 (non FHD version) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
+			/* Above strings are too generic also match BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "04/01/2014"),
+		},
+		.driver_data = (void *)&acer_a1_840_data,
+	},
 	{
 		/* Chuwi Hi8 Pro with D2D3_Hi8Pro.233 BIOS */
 		.matches = {
-- 
2.51.0




