Return-Path: <stable+bounces-92506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAD59C553A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F3BB3A341
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA6721CFB8;
	Tue, 12 Nov 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRrZndAS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65821CFAD;
	Tue, 12 Nov 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407813; cv=none; b=lkFLY0oWgZ7kToTgB+8UkOzMdlQURvC3wkNxP3M6jgMgz+k7RF40dt9WAz8EaHm1ttQ9/CKNsyZrfuikfweRifvyqOtPWNtJMzgQomH8Z2SdPyOF2OevESMOjl2Su64W0OI6qPy17A3N44cuNQFlxdKinPR4NraaXOdXryqKiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407813; c=relaxed/simple;
	bh=V2SfHRj42Qh9xvWSj4r98rg50craP88nJP0wIotBYdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNPLRXyxPfVKp0Dmc5tC3gIs0O5Bbe4fIIKTnIioi9SWJUwd0FiVVtxfl6wwQbTtRg/1cJFdZ+vQPGWv9N0UNdaRCaWaoY1vv/eu3BcPnas+hawMbZCX06kznR0GCdfbYSydPqXkgkOjDpbCPRK5xYwtir5/INfXQ8U6Zdm4N1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRrZndAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CE0C4CED7;
	Tue, 12 Nov 2024 10:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407813;
	bh=V2SfHRj42Qh9xvWSj4r98rg50craP88nJP0wIotBYdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRrZndASvuauzi7m9rhbu+BhE6DOQ4Lks2VxArKjXhourFAuJ4aUzrYur3MBU4aB5
	 eGEMGhTsEUE8Sd46ipnIsjkGEeibS7T2QluOcbytkAB15SUmEKgSdfE8z26c5Ls34T
	 xB4aXKnsU/fHDJdvgYk/DTdXAbbaWiH3pILSskAoVF7M3N4n4KPmo0hxWupyFiSoBL
	 +ac3EyuG4+qnCGL31wiKjjs+aUfDVN4YOm0FPtIX8aLitm42HUYXSHu8oZOzbzugKH
	 Qk44dTB0vduNNSNLoW5vb8RJZkcB+CpZAQKntK2ya4mIDsPYnRhN1DhhhAUEZ7Uft9
	 YGCz/kQS7LZoA==
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
Subject: [PATCH AUTOSEL 6.6 05/15] platform/x86: dell-wmi-base: Handle META key Lock/Unlock events
Date: Tue, 12 Nov 2024 05:36:26 -0500
Message-ID: <20241112103643.1653381-5-sashal@kernel.org>
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


