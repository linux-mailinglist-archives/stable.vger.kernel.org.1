Return-Path: <stable+bounces-92504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA2F9C54A2
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663F2B3A1AE
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45221CF92;
	Tue, 12 Nov 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1kdnIxB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0E21CF8C;
	Tue, 12 Nov 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407811; cv=none; b=gVj9Z77rUzAn7GPILEyFjwuKHpqHO/xPPnGg99LAMLylWFbyjMa70sstAXCWrUBTEghX3CEXHQExPYq2iBCUztCYoVtyDkaDg8UKnzCuHIQLkGXloj61vdli2n15Ngc9CcopixaswBK7vtTCiKdig8OX8qlON7oDEYSqOb5dAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407811; c=relaxed/simple;
	bh=GvF7nkVv8o/M22CjS96TnPNxa4CZogBko2MirNKgpY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyAPJ7XAhIZ8gy5MhOH0FxNbrzMST5rrvhbCox50imxNLPL3/8jSpbWB5/yDrKMcwIEe3Q4f9Rfp+bja6tqeGohAwwxe3jMU8voMcYOfPGkNMNnzuESXiRJ3paKA9HuW40qRosn+pWBODmt7rmGQvhlJ1GD28ModF5l+Kv7uWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1kdnIxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4A1C4CECD;
	Tue, 12 Nov 2024 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407811;
	bh=GvF7nkVv8o/M22CjS96TnPNxa4CZogBko2MirNKgpY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1kdnIxB6mMuykPySwVD5f/HtkjFRYC351ExZvCluYd40A79whSErWOYqiMNrBZ9a
	 EncKw7q+d11dwjV6BwFK19cLv4CiFePRUykc7/Tpbdvua752iIxZJ4WrvjBPZ4ttdC
	 uZzntL3+bNpGLvWpozZqGElLdSLoyuEgGpLEHibVP0MJ6p3Fs+s+iptH+EZLVBhUC+
	 Fv1nbSFhf2djm+LHuO9G/g7ZoLxz/aTfbPEy0ZagPmQdaq2y5Jbx6Lg8oPXO4PDNaE
	 NMxUpyX0Xsu7vZir0Ps/xZ8cYxTFqMX4ZWsYQJTpNwBh+W7lv+Vyo/4B6C1qoYxUtm
	 7BKVWm6NlaEYA==
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
Subject: [PATCH AUTOSEL 6.6 04/15] platform/x86: dell-smbios-base: Extends support to Alienware products
Date: Tue, 12 Nov 2024 05:36:25 -0500
Message-ID: <20241112103643.1653381-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
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
index 6fb538a138689..9a9b9feac4166 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -544,6 +544,7 @@ static int __init dell_smbios_init(void)
 	int ret, wmi, smm;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
-- 
2.43.0


