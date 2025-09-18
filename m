Return-Path: <stable+bounces-173909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF506B3605F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370AC1BC0C25
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5FA1C84BD;
	Tue, 26 Aug 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ABc0aFq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681D1991CB;
	Tue, 26 Aug 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212985; cv=none; b=LkiFNYxyzwEc2mnaLxj+G4fI5Gi/yOLtJRDrAKl/kBs7GvAKH8GX6RHZkSZEFuSnJZHsH6w/qmqVilHxSBZ4w6IlGjJksYNyRWPlFA9kSuVR8xyD3G47235bsppGyisLwb5WE80sDl1N84nX5TE7s96HVyFbFN1dqvI9jC6Slps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212985; c=relaxed/simple;
	bh=w4/wXhS6gHuX7Ii6CpeErVxnD7qkgstidaEJePAHwr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8l+TXLxwLKs61jgXKV41aUEbzy/Lz41CwTP2L8vKxk4Sju2+04nAr3C+8CcT0+7O7zjf5NfnMiAjwzsNfKskF2FIT+oCbrkbv7Azoju3dxO/HTFNzF/8drYbV9EatydU7fq5AoyNKbjmLTfilzmEyO/iGg01H+T0si67JxepeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ABc0aFq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEAFC4CEF1;
	Tue, 26 Aug 2025 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756212985;
	bh=w4/wXhS6gHuX7Ii6CpeErVxnD7qkgstidaEJePAHwr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABc0aFq9oOInfzUmMoUiNLHwNFrsgNh/KdMFa29rrpIZ66Yl8+R/Z6HifSKrK9zfd
	 1G1vS27eqPa8U4at4et8uCVGJtbcPy5pioRZnULjaVNh56aPakEMigeE6zPgkjCfZA
	 uWAzQl6wk43aCVVd3EMoESgGTJshEobZodfiiRWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Work <work.eric@gmail.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Starovoitov <mstarovoitov@marvell.com>,
	Dmitry Bogdanov <dbogdanov@marvell.com>,
	Pavel Belous <pbelous@marvell.com>,
	Nikita Danilov <ndanilov@marvell.com>
Subject: [PATCH 6.6 177/587] net: atlantic: add set_power to fw_ops for atl2 to fix wol
Date: Tue, 26 Aug 2025 13:05:26 +0200
Message-ID: <20250826110957.445829217@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Work <work.eric@gmail.com>

[ Upstream commit fad9cf216597a71936ac87143d1618fbbcf97cbe ]

Aquantia AQC113(C) using ATL2FW doesn't properly prepare the NIC for
enabling wake-on-lan. The FW operation `set_power` was only implemented
for `hw_atl` and not `hw_atl2`. Implement the `set_power` functionality
for `hw_atl2`.

Tested with both AQC113 and AQC113C devices. Confirmed you can shutdown
the system and wake from S5 using magic packets. NIC was previously
powered off when entering S5. If the NIC was configured for WOL by the
Windows driver, loading the atlantic driver would disable WOL.

Partially cherry-picks changes from commit,
https://github.com/Aquantia/AQtion/commit/37bd5cc

Attributing original authors from Marvell for the referenced commit.

Closes: https://github.com/Aquantia/AQtion/issues/70
Co-developed-by: Igor Russkikh <irusskikh@marvell.com>
Co-developed-by: Mark Starovoitov <mstarovoitov@marvell.com>
Co-developed-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Co-developed-by: Pavel Belous <pbelous@marvell.com>
Co-developed-by: Nikita Danilov <ndanilov@marvell.com>
Signed-off-by: Eric Work <work.eric@gmail.com>
Reviewed-by: Igor Russkikh <irusskikh@marvell.com>
Link: https://patch.msgid.link/20250629051535.5172-1-work.eric@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |  2 +
 .../atlantic/hw_atl2/hw_atl2_utils_fw.c       | 39 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index dbd284660135..7f616abd3db2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -113,6 +113,8 @@ struct aq_stats_s {
 #define AQ_HW_POWER_STATE_D0   0U
 #define AQ_HW_POWER_STATE_D3   3U
 
+#define	AQ_FW_WAKE_ON_LINK_RTPM BIT(10)
+
 #define AQ_HW_FLAG_STARTED     0x00000004U
 #define AQ_HW_FLAG_STOPPING    0x00000008U
 #define AQ_HW_FLAG_RESETTING   0x00000010U
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
index 52e2070a4a2f..7370e3f76b62 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
@@ -462,6 +462,44 @@ static int aq_a2_fw_get_mac_temp(struct aq_hw_s *self, int *temp)
 	return aq_a2_fw_get_phy_temp(self, temp);
 }
 
+static int aq_a2_fw_set_wol_params(struct aq_hw_s *self, const u8 *mac, u32 wol)
+{
+	struct mac_address_aligned_s mac_address;
+	struct link_control_s link_control;
+	struct wake_on_lan_s wake_on_lan;
+
+	memcpy(mac_address.aligned.mac_address, mac, ETH_ALEN);
+	hw_atl2_shared_buffer_write(self, mac_address, mac_address);
+
+	memset(&wake_on_lan, 0, sizeof(wake_on_lan));
+
+	if (wol & WAKE_MAGIC)
+		wake_on_lan.wake_on_magic_packet = 1U;
+
+	if (wol & (WAKE_PHY | AQ_FW_WAKE_ON_LINK_RTPM))
+		wake_on_lan.wake_on_link_up = 1U;
+
+	hw_atl2_shared_buffer_write(self, sleep_proxy, wake_on_lan);
+
+	hw_atl2_shared_buffer_get(self, link_control, link_control);
+	link_control.mode = AQ_HOST_MODE_SLEEP_PROXY;
+	hw_atl2_shared_buffer_write(self, link_control, link_control);
+
+	return hw_atl2_shared_buffer_finish_ack(self);
+}
+
+static int aq_a2_fw_set_power(struct aq_hw_s *self, unsigned int power_state,
+			      const u8 *mac)
+{
+	u32 wol = self->aq_nic_cfg->wol;
+	int err = 0;
+
+	if (wol)
+		err = aq_a2_fw_set_wol_params(self, mac, wol);
+
+	return err;
+}
+
 static int aq_a2_fw_set_eee_rate(struct aq_hw_s *self, u32 speed)
 {
 	struct link_options_s link_options;
@@ -605,6 +643,7 @@ const struct aq_fw_ops aq_a2_fw_ops = {
 	.set_state          = aq_a2_fw_set_state,
 	.update_link_status = aq_a2_fw_update_link_status,
 	.update_stats       = aq_a2_fw_update_stats,
+	.set_power          = aq_a2_fw_set_power,
 	.get_mac_temp       = aq_a2_fw_get_mac_temp,
 	.get_phy_temp       = aq_a2_fw_get_phy_temp,
 	.set_eee_rate       = aq_a2_fw_set_eee_rate,
-- 
2.39.5




