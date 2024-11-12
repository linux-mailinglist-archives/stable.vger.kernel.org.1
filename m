Return-Path: <stable+bounces-92530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D09C54C1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021CB1F21C18
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C4A2229DC;
	Tue, 12 Nov 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq3cahq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04E2229D5;
	Tue, 12 Nov 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407846; cv=none; b=UtJQxgVzOBoLwx8x7oFHops6gIQrwEheZGu3PopqNv3iVzUkJhROoRnFTBNUz4TxN3P52BN/hvmIp98y+y3+NhLi8otdOXB5HYTfyIKXD48u9qaawLoCtvpvQiJ9AAF3Rgas84mO4WxZFMnk8ev9VAzsi0XXXsQ+0ScumBVCzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407846; c=relaxed/simple;
	bh=V2SfHRj42Qh9xvWSj4r98rg50craP88nJP0wIotBYdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5ig1bLlB2wnNxy09FPhIfhiV5I1CtRhkybLRFXZmjGJPBhfM5+FWmRtNTHN1I0UANlF2f1ZyeNuwKY7mx8pR9uezFcgDYGzw5qCjb0Vx/46VOPivZR1U2+HEbBR3PkthyOvcidPyfRPW6rXZBkXD/hA7KaiGw6gY+6GA16Wu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq3cahq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A231C4CED7;
	Tue, 12 Nov 2024 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407846;
	bh=V2SfHRj42Qh9xvWSj4r98rg50craP88nJP0wIotBYdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fq3cahq9Nk90+ZOna3rTtfBgrRolYXjBxRsUyu5ZL1PqH5deo0l80vB4olxfuT/Gg
	 LmBfyRiYtOIIfZooFR8TJVyEbYdlyyrNe1x1PtsrN2HJrhJTsBhAPJTTavkfw61eSP
	 GK+WRx9+xZk196PPMcAROlcaVetXPXngJEoErSJ709G3mlQiuBsX7Gdrmc8DnI3PeU
	 07CUmm4tAeOsPa4AR4dkTQmSTV0q8v88EuBKXL5WZJQwQFc/qJeR6s8P33jYx7F+Qu
	 r9gVVCg/iB4yrMuF5ZAybOKgSg5fqpuH2VLCyKn2xJUBedchbcJFVnJFaonDfJJSgN
	 AIw7X4KrHG3bQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	mjg59@srcf.ucam.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/12] platform/x86: dell-wmi-base: Handle META key Lock/Unlock events
Date: Tue, 12 Nov 2024 05:37:06 -0500
Message-ID: <20241112103718.1653723-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
Content-Transfer-Encoding: 8bit

From: Kurt Borja <kuurtb@gmail.com>

[ Upstream commit ec61f0bb4feec3345626a2b93b970b6719743997 ]

Some Alienware devices have a key that locks/unlocks the Meta key. This
key triggers a WMI event that should be ignored by the kernel, as it's
handled by internally the firmware.

There is no known way of changing this default behavior. The firmware
would lock/unlock the Meta key, regardless of how the event is handled.

Tested on an Alienware x15 R1.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20241031154441.6663-2-kuurtb@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 24fd7ffadda95..841a5414d28a6 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
 static const struct key_entry dell_wmi_keymap_type_0000[] = {
 	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
 
+	/* Meta key lock */
+	{ KE_IGNORE, 0xe000, { KEY_RIGHTMETA } },
+
+	/* Meta key unlock */
+	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
+
 	/* Key code is followed by brightness level */
 	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
-- 
2.43.0


