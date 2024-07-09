Return-Path: <stable+bounces-58791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD792C008
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B231C2866AD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8C1AED2E;
	Tue,  9 Jul 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW6dN6GL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4E1AE869;
	Tue,  9 Jul 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542073; cv=none; b=BskdMMWWX5y1tRW65wgGt8fqB+e7QxMc/VQ9zEDRbMqvmt90K9RCd8LBJPaiqGb9YZnHDhBi4RrCYf922pln1p4kFZvBc1a7M+uxeMCcfvmelHybgLux2gDD8zfcW+1VSUDHFKGpvic2C758HpsnqWTCEuTLjhy93zKklyiupbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542073; c=relaxed/simple;
	bh=6E3rqk8RBbJ7HQEiLAxgFRnwqMFp8YAGfUyVVui/9A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHf/SvmFd4tXinhPEyK8Cq4vzc9aqbRDlzoW6Mih6Pdb4ol2FEP761QWqfU0JhZFDwY4Y3U3aOH2Uke7wCvlI5NwErtBkzcuqz6KNNvvNeyyXqLtLl9mhatpCs4Oha9CWOwORUIaeaHzX8n7WPenT9rzqmcZAF9IWhBSb2yMvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW6dN6GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA125C32782;
	Tue,  9 Jul 2024 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542072;
	bh=6E3rqk8RBbJ7HQEiLAxgFRnwqMFp8YAGfUyVVui/9A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FW6dN6GLyicS3mSQWkWGA3QhNTnGeAsAjk/YQ0H5BWE1p3dXR7zxti89Gksf3XqWU
	 xWW/jrtp7hAS66AFrL009D5Pnvr2u+WtUW0gokEkahKV35WPlEFWUATkt2VF8KNE7t
	 d3KR13AHkvrAkt5dDKQI2AgqrGHtttV7L8oMmIyXZtBhosvhGmVM3WqBf2S/SrFZ+q
	 LzukTwEgUKtvD8um+rRNxvw3qeWYx7bRs5MZ/yTpUm37LBj2xFYIILHVLeQwNlHAF/
	 UpEr4Qc2IOIkFltewrZMcEHVydtLHmvGYYNaT1RS4EidvQY8770UiHJs02swd5husL
	 ynqn4jeROKz0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Agathe Boutmy <agathe@boutmy.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	matan@svgalib.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 29/40] platform/x86: lg-laptop: Change ACPI device id
Date: Tue,  9 Jul 2024 12:19:09 -0400
Message-ID: <20240709162007.30160-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 58a54f27a0dac81f7fd3514be01012635219a53c ]

The LGEX0815 ACPI device id is used for handling hotkey events, but
this functionality is already handled by the wireless-hotkey driver.

The LGEX0820 ACPI device id however is used to manage various
platform features using the WMAB/WMBB ACPI methods. Use this ACPI
device id to avoid blocking the wireless-hotkey driver from probing.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240606233540.9774-4-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lg-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 5d4df782ce8e1..c19c866361beb 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -768,7 +768,7 @@ static void acpi_remove(struct acpi_device *device)
 }
 
 static const struct acpi_device_id device_ids[] = {
-	{"LGEX0815", 0},
+	{"LGEX0820", 0},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
-- 
2.43.0


