Return-Path: <stable+bounces-80957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2010F990D36
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489FE1C22A96
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC92067AD;
	Fri,  4 Oct 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIV5PR+K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C832067A3;
	Fri,  4 Oct 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066358; cv=none; b=KZ1iqWe+cKFs082FVJEh8dlgCLGnnx+VKWUKMywYWajI6xN4DWENX7PBSG4lgay7y2OW33lILRUvSNimooqCD5HLC4nER+MVFRbpurd1a3jfFe9n74AkmuT/mjfadMwqCPGMoGtH98H1bFmLOvLvqRlXSCObnGbwcuDdt97tdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066358; c=relaxed/simple;
	bh=6d55/BnnI3qdnVXbI8ZqqtcV+rL6kt3+tYK6ms4ZHws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mctkp8M8YlJBzry1d/HcTbFr6AJIBWaP+fiE4e2nMnrfa8UsXnq6Q66eRqcr+WcEmcv1059i3OicLSkMg6i5MJj9HEZlEiYw4aYNFRtRLAnOjYFPw4yx21T/y5jRegkiiL9jm7s2Qpz0P5eNsIit03TMxWXg+wNdN/6nQus8m1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIV5PR+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A893C4CEC6;
	Fri,  4 Oct 2024 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066357;
	bh=6d55/BnnI3qdnVXbI8ZqqtcV+rL6kt3+tYK6ms4ZHws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIV5PR+KlfKt5pNnsW80LIw+sng7o2bOuPVaoJHvdsG06U78HK70rpipzZF3ulf8V
	 6E7svMN+s8Dij0w4jjL3bm3CgNN0DRvhmyJYEF5i2nAoG7Zqu5T9ghSn0vXqbjhx2b
	 9Sl/HI4SI/K4X7qkfPseVYZxDQEFmmPilH1mz81QRBRDwRG7GjHHUUlTrlELNmfwDc
	 +b4xPBqn4FDyB7c0VziE0La60dSO/Yv8uZ+EI9ltk56yPZ+kOeoGtyIlGU21imGvlJ
	 omoEJF2O/w+vLCs/QlLxCyIhUgf1LXuL3cjw64DPjXhLC/b5EUarUDifL5GV2nAsNw
	 aSe6DtW7+iA3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 31/58] mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Fri,  4 Oct 2024 14:24:04 -0400
Message-ID: <20241004182503.3672477-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ae7eee56cdcfcb6a886f76232778d6517fd58690 ]

There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
turns out that the 2G version has a DMI product name of
"CHERRYVIEW D1 PLATFORM" where as the 4G version has
"CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
unique enough that the product-name check is not necessary.

Drop the product-name check so that the existing DMI match for the 4G
RAM version also matches the 2G RAM version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/20240825132617.8809-1-hdegoede@redhat.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 7fce3ef7ab453..2a83f540d4c9d 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -178,7 +178,6 @@ static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
 		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YT3_X90,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 	},
-- 
2.43.0


