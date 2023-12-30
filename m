Return-Path: <stable+bounces-8914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B8820569
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBC28201C
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94579DC;
	Sat, 30 Dec 2023 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n77gtU1z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342379D8;
	Sat, 30 Dec 2023 12:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9C7C433C8;
	Sat, 30 Dec 2023 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938090;
	bh=gYNOUJpbSQUBmLLN2fLIN5WCeXwGeAYzijcdXtvDiYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n77gtU1zGqDYQAu5p+8uoHLArB9klKnI1LBBSYea76nMVSif32GiUpSiojRqib/2R
	 5cxXGUARaiNNLJZMw+uUQ17XyNOgTyHQID/LcU1eAA48DrCIXwIX9VtZwVwM4MEvWQ
	 NXsKdC0GwNIIPRpjyTTaOwHKnZyPuVIRSDF4KGo8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	Marcus Aram <marcus+oss@oxar.nl>,
	Mark Herbert <mark.herbert42@gmail.com>
Subject: [PATCH 6.1 004/112] HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]
Date: Sat, 30 Dec 2023 11:58:37 +0000
Message-ID: <20231230115806.875570644@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit a9f68ffe1170ca4bc17ab29067d806a354a026e0 ]

Users have reported problems with recent Lenovo laptops that contain
an IDEA5002 I2C HID device. Reports include fans turning on and
running even at idle and spurious wakeups from suspend.

Presumably in the Windows ecosystem there is an application that
uses the HID device. Maybe that puts it into a lower power state so
it doesn't cause spurious events.

This device doesn't serve any functional purpose in Linux as nothing
interacts with it so blacklist it from being probed. This will
prevent the GPIO driver from setting up the GPIO and the spurious
interrupts and wake events will not occur.

Cc: stable@vger.kernel.org # 6.1
Reported-and-tested-by: Marcus Aram <marcus+oss@oxar.nl>
Reported-and-tested-by: Mark Herbert <mark.herbert42@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2812
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index 171332fef6d14..6d35bb3974818 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -40,6 +40,11 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
 	 * ICN8505 controller, has a _CID of PNP0C50 but is not HID compatible.
 	 */
 	{ "CHPN0001" },
+	/*
+	 * The IDEA5002 ACPI device causes high interrupt usage and spurious
+	 * wakeups from suspend.
+	 */
+	{ "IDEA5002" },
 	{ }
 };
 
-- 
2.43.0




