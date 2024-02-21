Return-Path: <stable+bounces-22472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05385DC34
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F98282EB6
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C338398;
	Wed, 21 Feb 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n7UVbFrW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA378B7C;
	Wed, 21 Feb 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523413; cv=none; b=Ff7j1L3d8q9s+Eis0+Byr7BHs1UN6ANRJ9/vnN3+z2CqwxNN/Tdk74ZCwahiH9o7GwoX6TyQfESGmeH0k+pqzHNNML8VXsvYA7aa2d1nRyLUEscj7Pc0hA2R4QW1a+NmUF++A3GF73f1oOU7BxndUcBzCWPwmhtkUpbiBJHsimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523413; c=relaxed/simple;
	bh=x5Mp+s8lo1PdqFDJHw6Nn2sXnJLnbWFKAME2kQq/1IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9T85wpjVEt+JSW5bTDBY/D+oqFqJwtm5HV5bUabtKiNn4xd2wGd63scmqmwBdqiEIAJCF1u5uYjZytsX5kFTRKP0nHq+VO3k66gBr4xTJVpt/4Cp/vp0UZMvyxOUl4VMHvocLoWK+cPiXanrWUwQCrfck9wEpoLX7CsGHUyhrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n7UVbFrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72FFC433C7;
	Wed, 21 Feb 2024 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523413;
	bh=x5Mp+s8lo1PdqFDJHw6Nn2sXnJLnbWFKAME2kQq/1IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7UVbFrWGwONmvjxHtCQVl5j5t/dGY3JFgiO9x5dG6RUw5VffjrRFdGMOSFdtQlZP
	 jHWadfrtsdf/FBkMBuB93+Sp9repFjq5f99MXlSS72Aj2wRzNggDwBZJrmthcKbicW
	 Iye/1FuYIZsNydxaewbcyv3EkMXPvXGIMUcaEdgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH 5.15 429/476] wifi: mwifiex: add extra delay for firmware ready
Date: Wed, 21 Feb 2024 14:08:00 +0100
Message-ID: <20240221130023.877183671@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lin <yu-hao.lin@nxp.com>

[ Upstream commit 1c5d463c0770c6fa2037511a24fb17966fd07d97 ]

For SDIO IW416, due to a bug, FW may return ready before complete full
initialization. Command timeout may occur at driver load after reboot.
Workaround by adding 100ms delay at checking FW status.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Cc: stable@vger.kernel.org
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Brian Norris <briannorris@chromium.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com> # Verdin AM62 (IW416)
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231208234029.2197-1-yu-hao.lin@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 19 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sdio.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 919f1bae61dc..dd4bfb7d71ee 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -343,6 +343,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = false,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
@@ -358,6 +359,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
@@ -373,6 +375,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
@@ -388,6 +391,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
 	.can_dump_fw = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
@@ -404,6 +408,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
@@ -420,6 +425,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = true,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
@@ -436,6 +442,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
@@ -451,6 +458,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
@@ -467,6 +475,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
@@ -482,6 +491,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static struct memory_type_mapping generic_mem_type_map[] = {
@@ -574,6 +584,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
 		card->fw_dump_enh = data->fw_dump_enh;
 		card->can_auto_tdls = data->can_auto_tdls;
 		card->can_ext_scan = data->can_ext_scan;
+		card->fw_ready_extra_delay = data->fw_ready_extra_delay;
 		INIT_WORK(&card->work, mwifiex_sdio_work);
 	}
 
@@ -777,6 +788,7 @@ mwifiex_sdio_read_fw_status(struct mwifiex_adapter *adapter, u16 *dat)
 static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 				   u32 poll_num)
 {
+	struct sdio_mmc_card *card = adapter->card;
 	int ret = 0;
 	u16 firmware_stat;
 	u32 tries;
@@ -794,6 +806,13 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 		ret = -1;
 	}
 
+	if (card->fw_ready_extra_delay &&
+	    firmware_stat == FIRMWARE_READY_SDIO)
+		/* firmware might pretend to be ready, when it's not.
+		 * Wait a little bit more as a workaround.
+		 */
+		msleep(100);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index e9a9de566cc8..8f11fed8eae9 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -269,6 +269,7 @@ struct sdio_mmc_card {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool fw_ready_extra_delay;
 
 	struct mwifiex_sdio_mpa_tx mpa_tx;
 	struct mwifiex_sdio_mpa_rx mpa_rx;
@@ -292,6 +293,7 @@ struct mwifiex_sdio_device {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool fw_ready_extra_delay;
 };
 
 /*
-- 
2.43.0




