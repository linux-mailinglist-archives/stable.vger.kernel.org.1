Return-Path: <stable+bounces-117399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8A6A3B639
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E9E17AFFF
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879F1E00BF;
	Wed, 19 Feb 2025 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MYJSp0jb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6B1C548C;
	Wed, 19 Feb 2025 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955157; cv=none; b=WNBh7nnSGQ64f1d7xtD2ertlllAHoKOqGKrw0o05QrK50EVsAWl5jxq7+j+54iTPYSRxVBzA6213f0b8MX06wsqDuOIFybCOVGuMlgSgQlEaFueZPj3uWtNLycaONm5w+x7paUT6+SD9NkiuGq1r9H80J4hyhqP+aNR9r5OhMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955157; c=relaxed/simple;
	bh=mappXI8nagcn+NtfgjgX1sbPkgLzPo0MtVKf6kHiDjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSes2hEnvD+0l7yVN58/3oA4wGp8JzwCshaKzv1+EpiQShbjKKWcWy7TgR0oJQsnc75bW4WT6z9YAZglgjTKHK5MxHhav9vaklLNgMMf/eihPiSsKQHEwXa5fJvpit7ZsVDM+JTwFFr/idqNzL71Q+Cst7vS0aychxR0wWJAirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MYJSp0jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FE6C4CED1;
	Wed, 19 Feb 2025 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955157;
	bh=mappXI8nagcn+NtfgjgX1sbPkgLzPo0MtVKf6kHiDjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYJSp0jbriqMvfnl+K/3Nm1DEQE6P9UjiecbzH6Cm/O9rQTmGYvGVjjJ3CHiwT66C
	 gZsUz03KcsESq3ngOtQolSw5JDX3gbeT6JkphL++jFstovzTN4/hvZw551rDHxoNp0
	 Zoza/D2VArxxr/2g0VnJTLOXWGiKLpSyUwZll56A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Delgan <delgan.py@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <westeri@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.12 150/230] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
Date: Wed, 19 Feb 2025 09:27:47 +0100
Message-ID: <20250219082607.556163120@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 8743d66979e494c5378563e6b5a32e913380abd8 upstream.

Spurious immediate wake up events are reported on Acer Nitro ANV14. GPIO 11 is
specified as an edge triggered input and also a wake source but this pin is
supposed to be an output pin for an LED, so it's effectively floating.

Block the interrupt from getting set up for this GPIO on this device.

Cc: stable@vger.kernel.org
Reported-by: Delgan <delgan.py@gmail.com>
Tested-by: Delgan <delgan.py@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3954
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Mika Westerberg <westeri@kernel.org>
Link: https://lore.kernel.org/r/20250211203222.761206-1-superm1@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-acpi.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1691,6 +1691,20 @@ static const struct dmi_system_id gpioli
 			.ignore_wake = "PNP0C50:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from GPIO 11
+		 * Found in BIOS 1.04
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3954
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Acer Nitro V 14"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@11",
+		},
+	},
 	{} /* Terminating entry */
 };
 



