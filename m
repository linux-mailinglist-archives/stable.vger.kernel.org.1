Return-Path: <stable+bounces-92550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E76489C56BC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CD8B3D4E0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C922C75B;
	Tue, 12 Nov 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUIX9kYS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9022C737;
	Tue, 12 Nov 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407873; cv=none; b=cNa/dNddk7OAANHikG3OYDeL41j4U4RSPC7utb/vIgLBTPz4YknPRc2q6cSNU09DkOE/obp1Juj2asviJbfffdZ6xkmMhKaTWbWz9jRM1j/T1eXLt1w0rgNzjgf65UprRRxKCusGXJ7H034XNfED/toh43hgRmGwjrstCPNQ+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407873; c=relaxed/simple;
	bh=q/E2//ZEHvcPS3jMf+1Y8ZRMTaRr0UVqozDtKP4F+80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pqf8hANnZQBz51msoXYY1ysQAShRZFt20AqS6YOi//HE0MdYCQpRCy++hF72c1GccvK6lXuxAqkb2QHLcmobo5aMnYPzvH4s9UiaaX1EZFR0BV7BmxO4Z2PZXOH0PSBm2BuxPLEcjb+kabohpKx7g8W+Gl+PuUyNFcVhVyFLvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUIX9kYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D10C4CED8;
	Tue, 12 Nov 2024 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407873;
	bh=q/E2//ZEHvcPS3jMf+1Y8ZRMTaRr0UVqozDtKP4F+80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUIX9kYSMzgNI1bft0vtuk8jX8DsdJx6VzBcWYyaE+qV02pP7KfVZy/Nw6OzB8J7l
	 MCtqHT+L7B9cpEfq7I0JuO9spf792A1fwz/PqGNEz1yHGGNfMAomiYy1WDw1YFA9qA
	 uEw8HRWfHJVjrDRv69p8YHJdQlJ5qnQpJQuZkzBFQcJdK/UkZaaNT5ePQLQguuwifU
	 zN5FQInerlFC9yLXhiJ00kLl1i+unUCKPNfmP1eUTMoe9Hnl4+uqYFEKtBn+dTiWDr
	 91EcIg/EstqopeF6dDuPziFM+i2HoZ0Siivg9LDmZlDnGg84kO8flYDUbq+CMmOZ+d
	 KFp+4GbRuKB3Q==
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
Subject: [PATCH AUTOSEL 5.15 4/8] platform/x86: dell-wmi-base: Handle META key Lock/Unlock events
Date: Tue, 12 Nov 2024 05:37:38 -0500
Message-ID: <20241112103745.1653994-4-sashal@kernel.org>
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
index b12e6ebd10dd6..c853b429b9d73 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -79,6 +79,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
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


