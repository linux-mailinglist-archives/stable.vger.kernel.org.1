Return-Path: <stable+bounces-92476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D959C56B0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B558CB3829E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EA221730A;
	Tue, 12 Nov 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D45gr604"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001821744C;
	Tue, 12 Nov 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407773; cv=none; b=ifWPxa5ow9WQMBtT2XcSMWD/kverAkHBthd3cxKgqRU53rPtU++BpxOjFg8PREigu62FMvtRmeHmxv84oxfoVujfKP+OCVDYxD7O7nrcaAWnP7A6P8GxQxdY3i5ezjUSR5Gt1Dvup28DCeXeAgQJ7mu6y+nnFgNZFz9GPj/cn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407773; c=relaxed/simple;
	bh=bLhfO9WfpYEpuO1XwE9/Yl4ucns1dTotnCrC1EHO5uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCLpAdDH35QPkkDr6htVgyUoLoQZUWQGnpeYUtgRMKUCo1qDckYsUyhfpzuUDhtA4WukJeROfLr6vHjKHH1kdhjZlLdiL39H5lA3bGjgu3O2MnhC1IpGo5/Q7Q9eYhtJ2LOHknUIreGYH3sZqqFyVh6VHWZyPFGdoW3Mx9XlR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D45gr604; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6BDC4CECD;
	Tue, 12 Nov 2024 10:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407773;
	bh=bLhfO9WfpYEpuO1XwE9/Yl4ucns1dTotnCrC1EHO5uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D45gr6047XICXNHxTcQEqeMEb8CPMInnyg++pMc69j9LKXQoVzpqJnJq+MaE8y8mj
	 vo0IBoQJjKn5EwWsmGaus3XlvX0z7+l1AyTmXSUqmTN8Y2S0EiJI4AyRdY2yZs7uJ5
	 UEe/ZJaVJsKmYmJ2b3cnxNGTXmPPAWbebiHxsLUy9BCrBebp1Mqj8LaSbxxe6IVTBp
	 4gtGlT7OGgxz44YTWizFbwIkITPKnZZnWqRbg5mkfxEnGnTKNwnE1AgAK8/bYtjD0n
	 OhAkApp2LWuQgeIN+HZXDA866yNW4V4R96xMslCCVTJjaQHvgnCeRPHbidTOwEZiE9
	 o6YV97BEVQl5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	lsanche@lyndeno.ca,
	W_Armin@gmx.de,
	amishin@t-argos.ru,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 04/16] platform/x86: dell-smbios-base: Extends support to Alienware products
Date: Tue, 12 Nov 2024 05:35:46 -0500
Message-ID: <20241112103605.1652910-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
Content-Transfer-Encoding: 8bit

From: Kurt Borja <kuurtb@gmail.com>

[ Upstream commit a36b8b84ac4327b90ef5a22bc97cc96a92073330 ]

Fixes the following error:

dell_smbios: Unable to run on non-Dell system

Which is triggered after dell-wmi driver fails to initialize on
Alienware systems, as it depends on dell-smbios.

This effectively extends dell-wmi, dell-smbios and dcdbas support to
Alienware devices, that might share some features of the SMBIOS intereface
calling interface with other Dell products.

Tested on an Alienware X15 R1.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20241031154023.6149-2-kuurtb@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-smbios-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 73e41eb69cb57..01c72b91a50d4 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -576,6 +576,7 @@ static int __init dell_smbios_init(void)
 	int ret, wmi, smm;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
-- 
2.43.0


