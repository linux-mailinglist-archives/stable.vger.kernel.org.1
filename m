Return-Path: <stable+bounces-160862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31872AFD24C
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2131C24B77
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC58F5B;
	Tue,  8 Jul 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zf10XBJA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943A2E0910;
	Tue,  8 Jul 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992906; cv=none; b=YaA4W/C/VENx0Sc6sQVP+GJK8GeSwrDVWKNJ9IV/GQfax/J6rukOJIn40GWU9sgjioHsPasWoGeEwTzOYYHAJmJxntl1oiDv4h50fxlv/DIFS8/8MfnCRZc0LIXwZ1PH5pX1n2ZngZl6FOkVYRxNFdm0mhom+OCMkbhz2eTzyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992906; c=relaxed/simple;
	bh=j2gEYmWEnFPM/xn0+Ic8y7A8f5H5CW/BjJaLSuSA1I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwCzGmyqCxZVNzm9lT/b/6hSLRjuRG9VtbJZQ8J/fQQ34MbqnAQCbOi3m03Qe+GtdR5UmisPRHDIOblBWqsA4AOyaIj9EIW9rioMyGMSUw+p/jxGgZuxQR6FikdO+fSxmjbwNn37TUmGdvY1+9y6TcmS78OkhS7/Rl5wHXW1O4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zf10XBJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA369C4CEED;
	Tue,  8 Jul 2025 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992906;
	bh=j2gEYmWEnFPM/xn0+Ic8y7A8f5H5CW/BjJaLSuSA1I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zf10XBJA6fg0o//hfxm4qaQcxernLM+mzTpQjy2jmNsNp69YOtuVJzupfvyme5hNx
	 wcDqJGH8Xb3MocqT5PtSUkD3Eqbn8WRmq5lUonibzDVabY9zkSmvTxZqMeXKAbqdxE
	 fTQFp/mfwmSYjhWoBtZ3p2qjbe5ko8AYdpV70ARs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 121/232] ACPI: thermal: Execute _SCP before reading trip points
Date: Tue,  8 Jul 2025 18:21:57 +0200
Message-ID: <20250708162244.608013378@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 3f7cd28ae3d1a1d6f151178469cfaef1b07fdbcc ]

As specified in section 11.4.13 of the ACPI specification the
operating system is required to evaluate the _ACx and _PSV objects
after executing the _SCP control method.

Move the execution of the _SCP control method before the invocation
of acpi_thermal_get_trip_points() to avoid missing updates to the
_ACx and _PSV objects.

Fixes: b09872a652d3 ("ACPI: thermal: Fold acpi_thermal_get_info() into its caller")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20250410165456.4173-3-W_Armin@gmx.de
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/thermal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index dbc371ac2fa66..125d7df8f30ae 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -803,6 +803,12 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_thermal_aml_dependency_fix(tz);
 
+	/*
+	 * Set the cooling mode [_SCP] to active cooling. This needs to happen before
+	 * we retrieve the trip point values.
+	 */
+	acpi_execute_simple_method(tz->device->handle, "_SCP", ACPI_THERMAL_MODE_ACTIVE);
+
 	/* Get trip points [_ACi, _PSV, etc.] (required). */
 	acpi_thermal_get_trip_points(tz);
 
@@ -814,10 +820,6 @@ static int acpi_thermal_add(struct acpi_device *device)
 	if (result)
 		goto free_memory;
 
-	/* Set the cooling mode [_SCP] to active cooling. */
-	acpi_execute_simple_method(tz->device->handle, "_SCP",
-				   ACPI_THERMAL_MODE_ACTIVE);
-
 	/* Determine the default polling frequency [_TZP]. */
 	if (tzp)
 		tz->polling_frequency = tzp;
-- 
2.39.5




