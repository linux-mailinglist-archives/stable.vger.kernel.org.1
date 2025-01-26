Return-Path: <stable+bounces-110750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03AA1CC29
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280063ADF73
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB82309BE;
	Sun, 26 Jan 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2nBhvpR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A34230D38;
	Sun, 26 Jan 2025 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904079; cv=none; b=DsqiNxyuOS1JYkjkFCwPkeUlLhPpJkRFD4iXDe/c5eAFtyRn0ZbsxukGQc76tVdzJ4+1uW8UVk3/u/opag1yk0GMxfZf9IiyeVXCvD9K/4PIg98AiqsEwsZuaKUh9kynWVRaHp+px3JxCyDKaaVm7r9xBx6ezM2M4xfHsUschyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904079; c=relaxed/simple;
	bh=F3npVf/i4dskGmfuKD/PaL9nDNxLEEmW1yiw7GoDy6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvXgXLO95ES22/csMg+ZFmKMnv3+0c6eGlR7ILLCqLcEbS9zQKTk7SMyyGNh2DJNda7uKMKHcq4GZp/xr8El8rhIhA1Z4zts1SWg2+wNcsoKHZjWjVbq3LaK5kxJMLKvKdC3GwFmkUSkCqBvKtB+N1IbGvnUguUi7UJVOubiIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2nBhvpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD619C4CEE3;
	Sun, 26 Jan 2025 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904079;
	bh=F3npVf/i4dskGmfuKD/PaL9nDNxLEEmW1yiw7GoDy6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2nBhvpR4RM63mgX7ZPmMvWafNBhV6WHoL8aSPM64fdVWSYhfVcKKztXXysnZhf9m
	 evei6SmwLjYWk/yxEXxMw8dEe5YcPtxGN04ohjNCxOX76ABt3ZX1GDs6DvXZKq4cwZ
	 iGBwTWCp9IgG/aw7LWa+Cm42aXy5z+z9JOTn1kd5AciUnTncngcHLBTg0IPfTpyU3f
	 h5ZAiDwgQfE0MBvpnCIvg75ZOVdw7rsG76/U3UlFXVu3zWpjjmrFq8z4GstUemODO5
	 v8GkVXgnJbHWst4coDrTIIPNqgQ0oTV08VaFlYWnfv7gPAMniuWZQrSTHfELxcMNSP
	 DlfNwDKVT6G9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hridesh MG <hridesh699@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 15/16] platform/x86: acer-wmi: add support for Acer Nitro AN515-58
Date: Sun, 26 Jan 2025 10:07:17 -0500
Message-Id: <20250126150720.961959-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Hridesh MG <hridesh699@gmail.com>

[ Upstream commit 549fcf58cf5837d401d0de906093169b05365609 ]

Add predator_v4 quirk for the Acer Nitro AN515-58 to enable fan speed
monitoring and platform_profile handling.

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250113-platform_profile-v4-5-23be0dff19f1@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 3c211eee95f42..1b966b75cb979 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -578,6 +578,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_travelmate_2490,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Nitro AN515-58",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro AN515-58"),
+		},
+		.driver_data = &quirk_acer_predator_v4,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Acer Predator PH315-53",
-- 
2.39.5


