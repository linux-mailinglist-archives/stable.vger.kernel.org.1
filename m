Return-Path: <stable+bounces-92549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE49C54F6
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C68286814
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B922C743;
	Tue, 12 Nov 2024 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaXaG7tb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DE22C73C;
	Tue, 12 Nov 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407871; cv=none; b=dGntCpP5147iTy5Wuv/C3K6wF88sDFx+LalCxpR7c1DrzUxS2blKKBsInOsxWLfyHPMPZ1u5zxoTQ8HgGcT+NupD46IfhK71DsndMQ+4jDp8sFJhxMe+wP6ggeJ24uwRLUCp+cnuoBYjo+Xko0J9qHeDzCVchZXs7V1ai2oKNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407871; c=relaxed/simple;
	bh=QOvCdirU6UWPL06gwZZcW/ucIk4crvlQX68eUGa+UJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEotvUClOSpe++5fzENuUf3DCIGIqlO8dmjYmAH1HTLS8/tsYRZWqRYbG57RLPRhcHaoBkrMdq0Vq8RG4BbkiEZOqIkUaaDERvSNxzh8XaSmCRUeZYO8IpAd10q5xrlx+CXfae4v57vN1lpSg5rvr3KyX4vgHSO/qq21W3FUYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaXaG7tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3151DC4CED7;
	Tue, 12 Nov 2024 10:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407871;
	bh=QOvCdirU6UWPL06gwZZcW/ucIk4crvlQX68eUGa+UJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaXaG7tbTh40FeN/qRv7UgEovF77ON/AKLzRZS91lqFZMGRH2jH6U4SndMPqc6d78
	 2CoJPl//U7wau6/hLn4UYJeBuyf1JE51+mRP9ITH5aUR138YZESHL7EFP0TcLTq14s
	 UA9rHIBd0zH2EqSL25sP85ifoF/b/UwxS9wUry0mlPLH2MQUq5MD/vunCRab5DrVT8
	 Y2UgYHvGZmnTjSQX/+Ur/rcDktsaKcn42VdN2CN0geY1ixNSQJ/qC9nUOxkXKKw17Y
	 Y9o+1Mn8RhK8jKUKj3/YIoPhuwF+mV6fVKYZXgUS8iHSlx1rGP8QqQwTOa8zjzl0op
	 H/jTaZmiW+x0g==
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
Subject: [PATCH AUTOSEL 5.15 3/8] platform/x86: dell-smbios-base: Extends support to Alienware products
Date: Tue, 12 Nov 2024 05:37:37 -0500
Message-ID: <20241112103745.1653994-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103745.1653994-1-sashal@kernel.org>
References: <20241112103745.1653994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.171
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
index b19c5ff31a703..5b8783a7b0455 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -543,6 +543,7 @@ static int __init dell_smbios_init(void)
 	int ret, wmi, smm;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
-- 
2.43.0


